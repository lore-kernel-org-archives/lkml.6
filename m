Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4954C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757F220863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fXBHOh0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfB0Ous (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:50:48 -0500
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:20400
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbfB0Our (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxhiKGR3WwRuqZMRx7DwI7Rg4ul++X8O+Lzd6+UkNDk=;
 b=fXBHOh0iCSAe76v0x0S7u15z+wnj+9UCs7D24OgRvvcypSZ1P5gKaetes941J3ZUPhlbOS41ik/9wCoZVgtzrG3SFe6PpCO3tSgQgXCZUk/l1nppAvjXKtY0TgP8Ojnrt0p4LtuBfmVDR3PAYbTh0hBGXMXW09mXuEDdRp7gGeA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 14:50:41 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 14:50:41 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] EDAC/amd64: Use a macro for iterating over Unified
 Memory Controllers
Thread-Topic: [PATCH v2 3/6] EDAC/amd64: Use a macro for iterating over
 Unified Memory Controllers
Thread-Index: AQHUzfhPOnzbEp1j5UuxjNRxQYhp9aXyn3eAgAEb27A=
Date:   Wed, 27 Feb 2019 14:50:41 +0000
Message-ID: <SN6PR12MB26395C43A849A9B467700C08F8740@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190226172532.12924-1-Yazen.Ghannam@amd.com>
 <20190226172532.12924-3-Yazen.Ghannam@amd.com>
 <20190226215327.GH14836@zn.tnic>
In-Reply-To: <20190226215327.GH14836@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [75.66.99.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f93dfd4d-3181-4ba4-30a4-08d69cc2f1e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2752;
x-ms-traffictypediagnostic: SN6PR12MB2752:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2752;20:Lr9ZlMHj6KikywZ1n4ITroVODZtJwOAXvQUou0aP6pOgF7B686wLdZEf8oVrCQuirk9Ko+xM6SLud55EBC0AVsb7J34/tSVxUK3Pl1LiQYwkcL1rkpQEbV/JCptPAeDQfRmlXshlmY7xy6jOwmbn/XL1OUAPkStDbWKr14GCbBAA82Gu9XE2xmOsIuQylgEviD5lBQiOY3MEIAjxP6QzsvXIFhh+q/GaZj/b2kUHnrGQZ6ify+rRJh37aacLb2JQ
x-microsoft-antispam-prvs: <SN6PR12MB2752DD72E98520488C2EA205F8740@SN6PR12MB2752.namprd12.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(13464003)(199004)(189003)(229853002)(7736002)(74316002)(305945005)(8676002)(186003)(8936002)(71190400001)(5660300002)(81156014)(81166006)(71200400001)(102836004)(11346002)(6306002)(9686003)(26005)(446003)(55016002)(476003)(53936002)(6246003)(4326008)(97736004)(53546011)(25786009)(486006)(66066001)(6506007)(52536013)(6116002)(68736007)(3846002)(14454004)(966005)(478600001)(2906002)(54906003)(14444005)(7696005)(76176011)(72206003)(33656002)(86362001)(99286004)(256004)(316002)(6436002)(106356001)(105586002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2752;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aRE3JM3mT9esTTQzszNp7MuU43ddENSIMVszXTb9UqANrBH94YBMsxQw0HYaoSN8CQULUVTOIXJSNZXm7+E6ukHvehMjAaS/hsOsIOpsgzGnMFegCeyEpdK5hncwqAjVn5dmwwOJJAs4/g4qp7RZhEXNNSuRpTbcnHhLNhZ6M7ZXD750LdK6BZ8OMpcKk1nEnBh9yFnQVMdeSVfg9QpxF3+A+nHGnNDaThMH9UXFJiSE7+j7KBVuAZa7Bimu62tQC7Jljo8jhJmUI8ftemXCSGDQVIHlN04baggTwYcekS+rqesxWvVyRA++uZwAW5s/mz2IBzWYuRNwIOpbFIG0Q1hsGOAU3MeT0wCGszsVhWKofwO8iUSxy85baS1ldzBdLnN7OTBNyk9oA7q0hDv7dINbjZS/OQDLMpQEsOttkf4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93dfd4d-3181-4ba4-30a4-08d69cc2f1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 14:50:41.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjYsIDIwMTkg
Mzo1MyBQTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4g
Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy82XSBFREFDL2FtZDY0OiBVc2UgYSBtYWNy
byBmb3IgaXRlcmF0aW5nIG92ZXIgVW5pZmllZCBNZW1vcnkgQ29udHJvbGxlcnMNCj4gDQo+IE9u
IFR1ZSwgRmViIDI2LCAyMDE5IGF0IDA1OjI1OjQ2UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdy
b3RlOg0KPiA+IEZyb206IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4g
Pg0KPiA+IERlZmluZSBhbmQgdXNlIGEgbWFjcm8gZm9yIGxvb3Bpbmcgb3ZlciB0aGUgbnVtYmVy
IG9mIFVuaWZpZWQgTWVtb3J5DQo+ID4gQ29udHJvbGxlcnMuDQo+ID4NCj4gPiBObyBmdW5jdGlv
bmFsIGNoYW5nZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhemVuIEdoYW5uYW0gPHlhemVu
LmdoYW5uYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBMaW5rOg0KPiA+IGh0dHBzOi8vbGttbC5r
ZXJuZWwub3JnL3IvMjAxOTAyMTkyMDI1MzYuMTU0NjItMi1ZYXplbi5HaGFubmFtQGFtZC5jb20N
Cj4gPg0KPiA+IHYxLT52MjoNCj4gPiAqIE5ldyBpbiBWMi4gUGxlYXNlIHNlZSBjb21tZW50IG9u
IFBhdGNoIDIgVjEgYXQgbGluayBhYm92ZS4NCj4gPg0KPiA+ICBkcml2ZXJzL2VkYWMvYW1kNjRf
ZWRhYy5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9lZGFjL2FtZDY0X2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCj4gPiBpbmRl
eCAwMDM4ZmNiMGIwMTAuLmM4MmFhZmI3MjQ2YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Vk
YWMvYW1kNjRfZWRhYy5jDQo+ID4gKysrIGIvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KPiA+
IEBAIC00NDksNiArNDQ5LDkgQEAgc3RhdGljIHZvaWQgZ2V0X2NzX2Jhc2VfYW5kX21hc2soc3Ry
dWN0IGFtZDY0X3B2dCAqcHZ0LCBpbnQgY3Nyb3csIHU4IGRjdCwNCj4gPiAgI2RlZmluZSBmb3Jf
ZWFjaF9jaGlwX3NlbGVjdF9tYXNrKGksIGRjdCwgcHZ0KSBcDQo+ID4gIAlmb3IgKGkgPSAwOyBp
IDwgcHZ0LT5jc2Vsc1tkY3RdLm1fY250OyBpKyspDQo+ID4NCj4gPiArI2RlZmluZSBmb3JfZWFj
aF91bWMoaSkgXA0KPiA+ICsJZm9yIChpID0gMDsgaSA8IG51bV91bWNzOyBpKyspDQo+ID4gKw0K
PiA+ICAvKg0KPiA+ICAgKiBAaW5wdXRfYWRkciBpcyBhbiBJbnB1dEFkZHIgYXNzb2NpYXRlZCB3
aXRoIHRoZSBub2RlIGdpdmVuIGJ5IG1jaS4gUmV0dXJuIHRoZQ0KPiA+ICAgKiBjc3JvdyB0aGF0
IGlucHV0X2FkZHIgbWFwcyB0bywgb3IgLTEgb24gZmFpbHVyZSAobm8gY3Nyb3cgY2xhaW1zIGlu
cHV0X2FkZHIpLg0KPiA+IEBAIC03MjIsNyArNzI1LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcg
ZGV0ZXJtaW5lX2VkYWNfY2FwKHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCkNCj4gPiAgCWlmIChwdnQt
PnVtYykgew0KPiA+ICAJCXU4IGksIHVtY19lbl9tYXNrID0gMCwgZGltbV9lY2NfZW5fbWFzayA9
IDA7DQo+ID4NCj4gPiAtCQlmb3IgKGkgPSAwOyBpIDwgbnVtX3VtY3M7IGkrKykgew0KPiA+ICsJ
CWZvcl9lYWNoX3VtYyhpKSB7DQo+IA0KPiBIbW0sIG1heWJlIEkgZGlkbid0IGV4cHJlc3MgbXlz
ZWxmIGFzIGNsZWFybHkgYXMgSSBzaG91bGQgaGF2ZSwgYmVmb3JlLg0KPiBTb3JyeSBhYm91dCB0
aGF0Lg0KPiANCj4gQnV0IGlmIHlvdSBzb3J0IHRoZSBwYXRjaGVzIHRoaXMgd2F5Og0KPiANCj4g
MS4gQWRkIGZvcl9lYWNoX3VtYygpIGFuZCBjb252ZXJ0IGNvZGUgdG8gdXNlIGl0DQo+IDIuIGFk
ZCBudW1fdW1jcyBhbmQgY29udmVydCBmb3JfZWFjaF91bWMoKSB0byB1c2UgaXQNCj4gDQo+IFlv
dSB3b24ndCBoYXZlIHRvIHRvdWNoIHRoZSBsb29wcyB0d2ljZSBpbiBwYXRjaGVzIDIgYW5kIDMg
YW5kIHlvdXINCj4gZGlmZnN0YXQgd2lsbCBiZSBhIGxvdCBzbWFsbGVyLg0KPiANCj4gTWFrZXMg
c2Vuc2U/DQo+IA0KDQpZZXAsIG1ha2VzIHNlbnNlLg0KDQpJIGNhbiBzZW5kIG91dCBhbm90aGVy
IHZlcnNpb24gc29vbi4gRG8geW91IGhhdmUgYW55IGNvbW1lbnRzIG9uIHRoZSBvdGhlciBwYXRj
aGVzPw0KDQpUaGFua3MsDQpZYXplbg0K
