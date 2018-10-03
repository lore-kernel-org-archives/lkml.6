Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB1C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483122089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SzrHEJjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483122089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeJCWOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:14:44 -0400
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:55296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbeJCWOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACIIqDhKpqz/kMzGMW1PHfs5vd2e39YR0JaMSml659Q=;
 b=SzrHEJjWwTs/7GgvMd9Tq1KxA4fy9me5fVoNl+1axiCQFPOXLL/229wb/gTIypi75/8Otr2gZJTw42pc0XTUGkrwo/8Nxd+NqcFSRnXxH2EqBzcdqq7B01LTWD5D0GCjWIOcX3h+HwD+f9EKBx9kOPeZn6wxJ762IfJTYKEPFvM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1291.namprd12.prod.outlook.com (10.168.237.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Wed, 3 Oct 2018 15:25:48 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 15:25:48 +0000
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
Subject: Re: [RFC PATCH 06/10] arch/x86: Initialize the resource functions
 that are different
Thread-Topic: [RFC PATCH 06/10] arch/x86: Initialize the resource functions
 that are different
Thread-Index: AQHUVDt2BjQ8Krcjz0mZSUcWMkilQ6UMj8+AgAEibIA=
Date:   Wed, 3 Oct 2018 15:25:48 +0000
Message-ID: <417c03a9-c634-a81d-fb87-a5037af21c37@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-7-babu.moger@amd.com>
 <d35e76c8-a79a-c574-33ff-20db12b8219a@intel.com>
In-Reply-To: <d35e76c8-a79a-c574-33ff-20db12b8219a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:404:5f::17) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1291;20:vqmWYkat/UcnASf0OefWt+/zxxT5Ukh+iLlKNNEQC9HHz/SvFYyyrvjvlMEYIwdvOQIYyzIitRh4JlK2+FmwTr5AzuXXwfbprAWEPYHk0r7+NmsUPOK3XmXUb6mEJblHeLrWcOkAKx3kx4n5T5/U015zStCQplgCvyoFSXxtH3uWiGLKCAz0KSGxzcbYbq+13QwTyYxjGxyhyl0ZHC4SsMyYBSQlcDzO3U75aePpesdEXNS+Tq3BQew6YyT/7Gyz
x-ms-office365-filtering-correlation-id: d11e5e9b-da3b-4d3a-5d5d-08d629447ed1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1291;
x-ms-traffictypediagnostic: DM5PR12MB1291:
x-microsoft-antispam-prvs: <DM5PR12MB12913E41507BC5B3C1CE29DC95E90@DM5PR12MB1291.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB1291;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1291;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(25786009)(36756003)(86362001)(2501003)(2201001)(6246003)(4326008)(14444005)(31686004)(5660300001)(97736004)(6512007)(53936002)(6436002)(229853002)(99286004)(386003)(186003)(68736007)(8676002)(71190400001)(316002)(7736002)(476003)(2616005)(446003)(486006)(11346002)(106356001)(5250100002)(2900100001)(6116002)(217873002)(6486002)(102836004)(81166006)(6506007)(105586002)(305945005)(7416002)(72206003)(3846002)(2906002)(53546011)(110136005)(31696002)(52116002)(76176011)(478600001)(54906003)(26005)(8936002)(14454004)(66066001)(81156014)(256004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1291;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3Ijj0vIea5hyddOM1eBiwmWpDM/yLdMiC+Y6THFoud8P40JMqqEYt7NzAbtl9ca5B10T66+rDOPPdi9Mcp0/js7IXd1Y42F1W3L8/EJ0QYtl0OjEiqAjviUlNvmPtyXw61X9GUm0L4Mo7k+dt2iHsuvbRtN3ivyFiFSQQ+veBVLruqLLSK+ckf5ZC/RMF9SVDn86/wUsBB8WeFB+zgJv2KwnkimWtI/Ov0BqR75rG+YhWSTyVcvNRhqoXIbn5pfy6Ry6NFmomFybu08ffpc6KRviBUqvAQdS1F/vax/s9vvpGNOfdqAByL99ZnoKknWAsY87ZGG/IRDLi9WiZtBRaIMG5Zuos8txv6al6objpy4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <614B9D944CD9D5408BD708620D7B5045@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e5e9b-da3b-4d3a-5d5d-08d629447ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 15:25:48.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzAyLzIwMTggMDU6MDYgUE0sIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4gSGkg
QmFidSwNCj4gDQo+IE9uIDkvMjQvMjAxOCAxMjoxOSBQTSwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+
PiBJbml0aWFsaXplIHRoZSByZXNvdXJjZSBmdW5jdGlvbnMgdGhhdCBhcmUgZGlmZmVyZW50IGJl
dHdlZW4gdGhlDQo+PiB2ZW5kb3JzLiBTb21lIGZlYXR1cmVzIGFyZSBpbml0aWFsaXplZCBkaWZm
ZXJlbnRseSBiZXR3ZWVuIHRoZSB2ZW5kb3JzLg0KPj4NCj4+IEZvciBleGFtcGxlLCBNQkEgZmVh
dHVyZSB2YXJpZXMgc2lnbmlmaWNhbnRseSBiZXR3ZWVuIEludGVsIGFuZCBBTUQuDQo+PiBTZXBh
cmF0ZSB0aGUgaW5pdGlhbGl6YXRpb24gb2YgdGhlc2UgcmVzb3VyY2UgZnVuY3Rpb25zLiBUaGF0
IHdheSB3ZQ0KPj4gY2FuIGVhc2lseSBhZGQgQU1EJ3MgZnVuY3Rpb25zIGxhdGVyLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4+IC0tLQ0K
Pj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmR0LmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysr
KysrLS0tDQo+PiAgYXJjaC94ODYva2VybmVsL2NwdS9yZHQuaCB8ICA0ICsrKysNCj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1
L3JkdC5jDQo+PiBpbmRleCA3MzY3MTViODFmZDguLjZkZWM0NWJmODFkNiAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmR0LmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvcmR0LmMNCj4+IEBAIC0xNzQsMTAgKzE3NCw3IEBAIHN0cnVjdCByZHRfcmVzb3VyY2UgcmR0
X3Jlc291cmNlc19hbGxbXSA9IHsNCj4+ICAJCS5yaWQJCQk9IFJEVF9SRVNPVVJDRV9NQkEsDQo+
PiAgCQkubmFtZQkJCT0gIk1CIiwNCj4+ICAJCS5kb21haW5zCQk9IGRvbWFpbl9pbml0KFJEVF9S
RVNPVVJDRV9NQkEpLA0KPj4gLQkJLm1zcl9iYXNlCQk9IElBMzJfTUJBX1RIUlRMX0JBU0UsDQo+
PiAtCQkubXNyX3VwZGF0ZQkJPSBtYmFfd3Jtc3IsDQo+PiAgCQkuY2FjaGVfbGV2ZWwJCT0gMywN
Cj4+IC0JCS5wYXJzZV9jdHJsdmFsCQk9IHBhcnNlX2J3LA0KPj4gIAkJLmZvcm1hdF9zdHIJCT0g
IiVkPSUqdSIsDQo+PiAgCQkuZmZsYWdzCQkJPSBSRlRZUEVfUkVTX01CLA0KPj4gIAl9LA0KPj4g
QEAgLTg2NSw2ICs4NjIsMjUgQEAgc3RhdGljIF9faW5pdCB2b2lkIHJkdF9jaGVja19tYmEodm9p
ZCkNCj4+ICAJCXJkdF9nZXRfbWVtX2NvbmZpZygmcmR0X3Jlc291cmNlc19hbGxbUkRUX1JFU09V
UkNFX01CQV0pOw0KPj4gIH0NCj4+ICANCj4+ICtzdGF0aWMgX19pbml0IHZvaWQgcmR0X2luaXRf
cmVzX2RlZnNfaW50ZWwodm9pZCkNCj4+ICt7DQo+PiArCXN0cnVjdCByZHRfcmVzb3VyY2UgKnI7
DQo+PiArDQo+PiArCWZvcl9lYWNoX3JkdF9yZXNvdXJjZShyKSB7DQo+PiArCQlpZiAoci0+cmlk
ID09IFJEVF9SRVNPVVJDRV9NQkEpIHsNCj4+ICsJCQlyLT5tc3JfYmFzZSA9IElBMzJfTUJBX1RI
UlRMX0JBU0U7DQo+PiArCQkJci0+bXNyX3VwZGF0ZSA9IG1iYV93cm1zcjsNCj4+ICsJCQlyLT5w
YXJzZV9jdHJsdmFsID0gcGFyc2VfYnc7DQo+PiArCQl9DQo+PiArCX0NCj4+ICt9DQo+IA0KPiBQ
YXRjaCAxMCBpbnRyb2R1Y2VzIHBhcnNlX2J3X2FtZCBhbmQgbWJhX3dybXNyX2FtZCBhcyB5b3Ug
cHJlcGFyZSB1cyBmb3INCj4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBJIHRoaW5rIGl0IHdvdWxk
IHJlZHVjZSBjb25mdXNpb24gaWYgdGhlc2UNCj4gZnVuY3Rpb25zLCBtYmFfd3Jtc3IgYW5kIHBh
cnNlX2J3LCBhbHNvIGZvbGxvdyB0aGlzIHBhdHRlcm4gdG8gY29udGFpbg0KPiB0aGUgdmVuZG9y
IG5hbWUuIFNvLCBtYmFfd3Jtc3IgLT4gbWJhX3dybXNyX2ludGVsLCBwYXJzZV9idyAtPg0KPiBw
YXJzZV9id19pbnRlbC4NCg0KWWVzLiBTdXJlLiBXaWxsIG1ha2UgdGhpcyBjaGFuZ2UuDQoNCj4g
DQo+PiArDQo+PiArc3RhdGljIF9faW5pdCB2b2lkIHJkdF9pbml0X3Jlc19kZWZzKHZvaWQpDQo+
PiArew0KPj4gKwlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfSU5U
RUwpDQo+PiArCQlyZHRfaW5pdF9yZXNfZGVmc19pbnRlbCgpOw0KPj4gK30NCj4+ICsNCj4+ICBz
dGF0aWMgZW51bSBjcHVocF9zdGF0ZSByZHRfb25saW5lOw0KPj4gIA0KPj4gIHN0YXRpYyBpbnQg
X19pbml0IHJkdF9sYXRlX2luaXQodm9pZCkNCj4+IEBAIC04NzUsNiArODkxLDEyIEBAIHN0YXRp
YyBpbnQgX19pbml0IHJkdF9sYXRlX2luaXQodm9pZCkNCj4+ICAJLyogUnVuIHF1aXJrcyBmaXJz
dCAqLw0KPj4gIAlyZHRfcXVpcmtzKCk7DQo+PiAgDQo+PiArCS8qDQo+PiArCSAqIEluaXRpYWxp
emUgZnVuY3Rpb25zKG9yIGRlZmluaXRpb25zKSB0aGF0IGFyZSBkaWZmZXJlbnQNCj4+ICsJICog
YmV0d2VlbiB2ZW5kb3JzIGhlcmUuDQo+PiArCSAqLw0KPj4gKwlyZHRfaW5pdF9yZXNfZGVmcygp
Ow0KPj4gKw0KPiANCj4gV2hpbGUgaXQgZG9lcyBzZWVtIGFzIHRob3VnaCBjdXJyZW50bHkgcmR0
X3F1aXJrcygpIGlzIG5vdCB1c2luZyBhbnkgb2YNCj4gdGhlIHNldHRpbmdzIG1hZGUgaW4gcmR0
X2luaXRfcmVzX2RlZnMoKSBpdCAocmR0X3F1aXJrcygpKSBkb2VzIHVzZSB0aGUNCj4gcGFydGlh
bGx5IGluaXRpYWxpemVkIHJlc291cmNlcyBzdHJ1Y3R1cmUgYW5kIHRoaXMgbWF5IGluIHRoZSBm
dXR1cmUNCj4gaW5jbHVkZSB1c2luZyBwYXJhbWV0ZXJzIHRoYXQgaGF2ZSBub3QgYmVlbiBpbml0
aWFsaXplZCB5ZXQuDQo+IA0KPiBJIHRodXMgdGhpbmsgaXQgd291bGQgYmUgc2FmZXIgdG8gZG8g
dGhpcyBpbml0aWFsaXphdGlvbiBiZWZvcmUNCj4gcmR0X3F1aXJrcygpLg0KDQpZZXMuICBNYWtl
cyBzZW5zZS4NCg0KPiANCj4gUmVpbmV0dGUNCj4gDQo=
