Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C0ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F3E2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ItVCK3pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F3E2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJQWq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:46:57 -0400
Received: from mail-bn3nam01on0070.outbound.protection.outlook.com ([104.47.33.70]:60461
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbeJQWq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajeih4Op6vkFyssPay1wToDj+IVUpYfk5jFI3zgH76I=;
 b=ItVCK3pFgqHf2o0l9Bb4RRogVVshf+vAS6GFbPaKId548lDCUULGCDG04Scqm5kNxkvEnrgyya3f0GAl+ngjTQ6m9dfBqm10IBiHZWmM4bjdZC2PiqzLna0B3SZzNrap4npSKbZb7+2U6LCAdPtd6OrJCghV7Rqx9VazjidfjKM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1915.namprd12.prod.outlook.com (10.175.88.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 17 Oct 2018 14:50:45 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 14:50:45 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v4 08/13] arch/x86: Bring few more functions into the
 resource structure
Thread-Topic: [PATCH v4 08/13] arch/x86: Bring few more functions into the
 resource structure
Thread-Index: AQHUZMlzim78ZV4gn02F0jJUDULTV6UiizAAgAD8yAA=
Date:   Wed, 17 Oct 2018 14:50:45 +0000
Message-ID: <bcfe2e44-4595-2a62-c3f2-16bdad5ed196@amd.com>
References: <20181015205514.25387-1-babu.moger@amd.com>
 <20181015205514.25387-9-babu.moger@amd.com>
 <20181016234556.GB39177@romley-ivt3.sc.intel.com>
In-Reply-To: <20181016234556.GB39177@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:805:a2::23) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1915;20:QqfoI346H79le1pBdXKGMr3Yz1SZ2jhq8dX/e+lMPII5/GgDMy5o0oIyMbr+ElLe/Rf76uLT2uVeQW4TJ51pLIjXYgAZklMNJ7wHuhQAsxU+aejErqicKZoeiSo3ApEya+T0u8ghXWnSv6qWSqlIFa9GIMxDPiLpq/0bf3Dnkn8pHCoT2O8qehGuwpaaFs9tVbxCRK2ZWI8MAMgEOQSkxedp9qOwnvEo6N3LxRNQT2mjdPjnNmMdpZuYYR+o4/oH
x-ms-office365-filtering-correlation-id: 076069ea-4631-4410-2781-08d6343feb39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1915;
x-ms-traffictypediagnostic: DM5PR12MB1915:
x-microsoft-antispam-prvs: <DM5PR12MB19150D8B50AF60D5DB9EBEE395FF0@DM5PR12MB1915.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1915;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1915;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(81166006)(105586002)(54906003)(6916009)(31686004)(316002)(4326008)(36756003)(72206003)(81156014)(25786009)(102836004)(186003)(26005)(8936002)(14444005)(486006)(31696002)(256004)(106356001)(478600001)(11346002)(446003)(8676002)(14454004)(2616005)(476003)(71190400001)(2900100001)(86362001)(97736004)(6436002)(3846002)(6116002)(6246003)(2906002)(229853002)(53936002)(5660300001)(305945005)(66066001)(5250100002)(7736002)(6512007)(99286004)(7406005)(68736007)(76176011)(7416002)(53546011)(52116002)(386003)(6486002)(6506007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1915;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rNJnZE7XbQNFyYDrYE3yeIPSm3mwhUaOoFgx0PLCGrBmM6IukAfcHvKYMTkr2NfJR+C+uC0kwstL1A3zYVH7Jdqqn05IFTvRD316wJtbetlV3CVzOq5oMkthGH9RBj4gFZiCuRPsu9qkmBzonbm/hoiCDIFUeiGoMXyVexuIdwlTHvne4RzkCVWovaEYK5rCxGSRvGELf2n2DGKxTXstQXwBjysXzFvyh+iqHdGiXpsT+EpHimY4r8pZOdBIVboxmeAOx8SJyXnGaamIALDsxGciwjdUdXj3phxK2jLKo+FtJyRxyXXSgPr6YHw5dleKRFTw/o+ksdPu9gu5c4ZeXiPKODGLt2/gx0ZPAqnRcd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <36FBE988105F6E459104EC2EBF07AF8C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076069ea-4631-4410-2781-08d6343feb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 14:50:45.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVuZ2h1YSwNCg0KT24gMTAvMTYvMjAxOCAwNjo0NSBQTSwgRmVuZ2h1YSBZdSB3cm90ZToN
Cj4gT24gTW9uLCBPY3QgMTUsIDIwMTggYXQgMDg6NTU6NDlQTSArMDAwMCwgTW9nZXIsIEJhYnUg
d3JvdGU6DQo+PiB1cGRhdGVfbWJhX2J3IDogRmVlZGJhY2sgbG9vcCBiYW5kd2lkdGggdXBkYXRl
IGZ1bmN0aW9uYWxpdHkgaXMgbm90DQo+PiAgICAgICAgICAgICAgICAgbmVlZGVkIGZvciBBTUQu
DQo+IA0KPiBXaWxsIHlvdSBpbXBsZW1lbnQgdXBkYXRlX21iYV9idygpIGZvciBBTUQgaW4gZnV0
dXJlPw0KDQpOby4gVGhlcmUgaXMgbm8gcGxhbi4NCg0KPiANCj4+ICAJCWxpc3RfZm9yX2VhY2hf
ZW50cnkoY3JncnAsIGhlYWQsIG1vbi5jcmR0Z3JwX2xpc3QpDQo+PiAgCQkJbWJtX3VwZGF0ZShk
LCBjcmdycC0+bW9uLnJtaWQpOw0KPj4gIA0KPj4gLQkJaWYgKGlzX21iYV9zYyhOVUxMKSkNCj4+
IC0JCQl1cGRhdGVfbWJhX2J3KHByZ3JwLCBkKTsNCj4+ICsJCWlmIChpc19tYmFfc2MoTlVMTCkp
IHsNCj4+ICsJCQlyX21iYSA9ICZyZHRfcmVzb3VyY2VzX2FsbFtSRFRfUkVTT1VSQ0VfTUJBXTsN
Cj4+ICsJCQlpZiAocl9tYmEtPnVwZGF0ZV9tYmFfYncpDQo+PiArCQkJCXJfbWJhLT51cGRhdGVf
bWJhX2J3KHByZ3JwLCBkKTsNCj4+ICsJCX0NCj4gDQo+IE1vdW50IG9wdGlvbiAibWJhX01CcHMi
IGlzIG5vdCBpbXBsZW1lbnRlZCBvbiBBTUQuIFRoZW4gZG9uJ3QNCj4gY2FsbCBzZXRfbWJhX3Nj
KHRydWUpIGluIHBhcnNlX3JkdGdyb3VwZnNfb3B0aW9ucygpLg0KPiANCj4gVGh1cywgeW91IGRv
bid0IG5lZWQgdG8gY2hhbmdlIHRoaXMgY29kZSBoZXJlIGJlY2F1c2UgaXNfbWJhX3NjKE5VTEwp
IGlzDQo+IGZhbHNlIG9uIEFNRC4NCg0KWWVzLiBpc19tYmFfc2MoTlVMTCkgaXMgZmFsc2Ugb24g
QU1ELiBJIGNhbiByZW1vdmUgdGhpcyBjaGFuZ2UuDQoNCj4gDQo+IFRoYW5rcy4NCj4gDQo+IC1G
ZW5naHVhDQo+IA0K
