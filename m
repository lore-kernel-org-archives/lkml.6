Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA32E213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3JMRodvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA32E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJDALV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:11:21 -0400
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:23280
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbeJDALU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHNl4FoJ0CHred35Rkub0UYPhBd83iC/8ylCrLrXAp0=;
 b=3JMRodvpm1XNwNjzbpMsxstfc9BJJsN4UBJczyp7kDwUXi9zvPXQq61MeOUt9wC5cS1w17/v9JFZ7PX8qrBBcWhjE+WDVrr4AkEvNIXcC/YCWTVCALx0y+DXv95LIGJWK8Q8KmqIkYFHuWy/fuclQQ1ngUP1gBRxiKkQz313rqQ=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1225.namprd12.prod.outlook.com (10.168.237.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Wed, 3 Oct 2018 17:21:18 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 17:21:18 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUVDt7FEaq7WNkoUWHOChzTz42MaUMkbQAgAFAzQA=
Date:   Wed, 3 Oct 2018 17:21:18 +0000
Message-ID: <94e59101-8aa5-01f3-afaa-71701cc78cd5@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-11-babu.moger@amd.com>
 <7690b121-dd54-ea58-ec77-2dbb88c25b16@intel.com>
In-Reply-To: <7690b121-dd54-ea58-ec77-2dbb88c25b16@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR0601CA0080.namprd06.prod.outlook.com
 (2603:10b6:910:88::21) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1225;20:Vm/TphxPv2yKbLWt2liNjdJxnrmbZjjZTktAzctJfeeaGwoo/2OLPTNOLsmOeCskmrVb6IFVBTvU9GTscgDqbDELiZuj73Upfkie/UGkRYheJ9gtly+SFZ+Irv0zcDKn3axSz0nN9x/gmyKOAXIbAcV8LF5x6FeS2N7DezsdIFNaujQG7vE+QGWsuFel2r/69bPMbDOJee0knkwrSHd3oIxvwZu8Gj5wn/4YnNEwm5qqF0fvOxuuxA0y5QZIVCdK
x-ms-office365-filtering-correlation-id: 73dfe965-ca6f-40ff-2220-08d62954a13c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1225;
x-ms-traffictypediagnostic: DM5PR12MB1225:
x-microsoft-antispam-prvs: <DM5PR12MB12258D6CE732566C73F9A51295E90@DM5PR12MB1225.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95223839027130)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991048);SRVR:DM5PR12MB1225;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1225;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(478600001)(486006)(76176011)(4326008)(31686004)(99286004)(6246003)(229853002)(97736004)(86362001)(68736007)(446003)(2616005)(11346002)(6116002)(2201001)(2900100001)(6436002)(186003)(476003)(31696002)(71200400001)(14444005)(256004)(6512007)(26005)(6486002)(25786009)(66066001)(6306002)(3846002)(53936002)(5660300001)(71190400001)(7736002)(36756003)(81156014)(81166006)(110136005)(966005)(8676002)(14454004)(316002)(2501003)(102836004)(105586002)(53546011)(6506007)(217873002)(386003)(2906002)(106356001)(305945005)(52116002)(54906003)(7416002)(5250100002)(8936002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1225;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FBXX7n4yPCAxDZPQraUnNl1uNvaZUN/zvtIYtE8++eOHFW9g7hbg7JIWSShuHquXbMZrLJ4YxmJIhab0SjuG8tOAuS9OXfFahb5xdHyYhjBbkGMMsLnGe/G450nvRhRbjvL6aS7ZfmP8s4EsOwYKbbT2seUMhGZgYzlDm3ZSCnDNH2wy0Onf7gmYhghJhK/GnY1sLrQpAKA671npEJBN/xPJ847H44QEVquiAeoE8KTMTFf+A05xYn+gx47WicnD5FjdFyXPpNERTBpkIwI9hqozDpBy/n8MVQm22+nleC1JwpEt+GgHf5EEIoY4jB/iMrj6+1k/twRSfhWuY/EAkkkuuRq1twA3mVt8MpXv0GU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <87958D4A46685F4BB5FB2963716F0EE4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dfe965-ca6f-40ff-2220-08d62954a13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 17:21:18.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCk9uIDEwLzAyLzIwMTggMDU6MTMgUE0sIFJlaW5ldHRlIENoYXRyZSB3
cm90ZToNCj4gSGkgQmFidSwNCj4gDQo+IE9uIDkvMjQvMjAxOCAxMjoxOSBQTSwgTW9nZXIsIEJh
YnUgd3JvdGU6DQo+PiArLyoNCj4+ICsgKiBDaGVjayB3aGV0aGVyIGEgY2FjaGUgYml0IG1hc2sg
aXMgdmFsaWQuIEFNRCBhbGxvd3MNCj4+ICsgKiBub24tY29udGlndW91cyBtYXNrcy4NCj4+ICsg
Ki8NCj4+ICtib29sIGNibV92YWxpZGF0ZV9hbWQoY2hhciAqYnVmLCB1MzIgKmRhdGEsIHN0cnVj
dCByZHRfcmVzb3VyY2UgKnIpDQo+PiArew0KPj4gKwl1bnNpZ25lZCBsb25nIGZpcnN0X2JpdCwg
emVyb19iaXQsIHZhbDsNCj4+ICsJdW5zaWduZWQgaW50IGNibV9sZW4gPSByLT5jYWNoZS5jYm1f
bGVuOw0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlyZXQgPSBrc3RydG91bChidWYsIDE2LCAm
dmFsKTsNCj4+ICsJaWYgKHJldCkgew0KPj4gKwkJcmR0X2xhc3RfY21kX3ByaW50Zigibm9uLWhl
eCBjaGFyYWN0ZXIgaW4gbWFzayAlc1xuIiwgYnVmKTsNCj4+ICsJCXJldHVybiBmYWxzZTsNCj4+
ICsJfQ0KPj4gKw0KPj4gKwlpZiAodmFsID09IDAgfHwgdmFsID4gci0+ZGVmYXVsdF9jdHJsKSB7
DQo+PiArCQlyZHRfbGFzdF9jbWRfcHV0cygibWFzayBvdXQgb2YgcmFuZ2VcbiIpOw0KPj4gKwkJ
cmV0dXJuIGZhbHNlOw0KPj4gKwl9DQo+IA0KPiBBY2NvcmRpbmcgdG8NCj4gaHR0cHM6Ly93d3cu
YW1kLmNvbS9zeXN0ZW0vZmlsZXMvVGVjaERvY3MvNTYzNzVfUXVhbGl0eV9vZl9TZXJ2aWNlX0V4
dGVuc2lvbnMucGRmDQo+ICJJZiBhbiBMM19NQVNLX24gcmVnaXN0ZXIgaXMgcHJvZ3JhbW1lZCB3
aXRoIGFsbCAw4oCZcywgdGhhdCBDT1Mgd2lsbCBiZQ0KPiBwcmV2ZW50ZWQgZnJvbSBhbGxvY2F0
aW5nIGFueSBsaW5lcyBpbiB0aGUgTDMgY2FjaGUuIg0KPiANCj4gVGhlICJ2YWwgPT0gMCIgdGVz
dCB0aHVzIGRvZXMgbm90IHNlZW0gbmVjZXNzYXJ5Lg0KDQpZZXMuIEdvb2QgcG9pbnQuIFdlIGRv
bid0IG5lZWQgdGhpcyB0ZXN0Lg0KPiANCj4+ICsNCj4+ICsJZmlyc3RfYml0ID0gZmluZF9maXJz
dF9iaXQoJnZhbCwgY2JtX2xlbik7DQo+PiArCXplcm9fYml0ID0gZmluZF9uZXh0X3plcm9fYml0
KCZ2YWwsIGNibV9sZW4sIGZpcnN0X2JpdCk7DQo+PiArDQo+PiArDQo+PiArCWlmICgoemVyb19i
aXQgLSBmaXJzdF9iaXQpIDwgci0+Y2FjaGUubWluX2NibV9iaXRzKSB7DQo+PiArCQlyZHRfbGFz
dF9jbWRfcHJpbnRmKCJOZWVkIGF0IGxlYXN0ICVkIGJpdHMgaW4gbWFza1xuIiwNCj4+ICsJCQkJ
ICAgIHItPmNhY2hlLm1pbl9jYm1fYml0cyk7DQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+PiArCX0N
Cj4gDQo+IElmIEFNRCBwbGF0Zm9ybXMgYWNjZXB0IENCTSBvZiBhbGwgemVyb2VzIHRoZW4gaXQg
c2VlbXMgdGhhdCB0aGUNCj4gcGxhdGZvcm1zIHdvdWxkIG5vdCByZXF1aXJlIGEgbWluaW11bSBu
dW1iZXIgb2Ygc2V0IGJpdHM/DQoNClllcy4gV2UgZG9uJ3QgbmVlZCB0aGlzIGNoZWNrIGFzIHdl
bGwuICBUZXN0ZWQgYW5kIGNvbmZpcm1lZC4NClRoYW5rcw0KPiANCj4gUmVpbmV0dGUNCj4gDQo=
