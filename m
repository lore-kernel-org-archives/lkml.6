Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF22E218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FttuvFNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfAaRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:18:36 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:43444
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfAaRSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0ij+Zdu83axAgYaw4ot9pVLHXSzCEoaOE90LoHFl6g=;
 b=FttuvFNVBNUvOy/fCxCgbSLom3HJGIEAXGBtSKCNJZCNO3cHbu+0QP9eSh+JvDTjhHjzFKDozf4GVy3DNhr061jHH+xdu0UR4MXzXmFCQU26960cnswGk7Wq2/r91CGVG1XQ0tcegsBTvJnYdx5Fan5Pv23blcM61h6xUJC11NI=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3286.eurprd05.prod.outlook.com (10.170.220.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 17:18:21 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 17:18:21 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v2] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Index: AQHUuYV/ZdouKCwE60m/C1lyrX9NOaXJmmYAgAAB23A=
Date:   Thu, 31 Jan 2019 17:18:21 +0000
Message-ID: <DB6PR05MB3223E95170C064869591118AA1910@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1548953587-12719-1-git-send-email-lsun@mellanox.com>
 <CAHp75Vfr7+NONzthw=E77BqLb06=wgfmNqu7D01fkcNQMqUCsQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfr7+NONzthw=E77BqLb06=wgfmNqu7D01fkcNQMqUCsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB3286;6:dz6fMT6DlJd9SPHO/gTBbBOP7stgB90jmY/JosOguGIaC7BivhPvrJXfcsatVUhoeCVWVw4NMsywIu+3I085uDQ7X5596LW/rQefkeCgcU0qk/gzKS9XjNAhac2wT3052i40JOfEUEMR5thjUuSOXYwYmhxCrh4jDxvexm32JHB8ljD7+TWeM1KzbgaLpLJjQfVFkNXpaVcCAp6Pzp+1JenJO6m7/2go68WRSzXhKW1RAGWTuZ8RuQi1OVZBkUDT48fSDNEvebGOIMm+xWpRZDkKm49YcKw1Z3X7wnObqYbMnyb4ujgfG9PyMXHsb8Ri4jMTBPBOQdKtFXuSbDQD7Gesjxb33nM/RNNbX+C8UDVgyqZp0i/adsYdGKISL5j57IuKSHf465D2YSeQ7ErQGl6FhPotmDZ6MOjTqeLy8MTbfUCqxcEAJhuWyZXic9ilAOKPBkeBg3h/Kbjo5pHWqA==;5:O6l86/yo5C7lBZ8bQNyqinw+EIUrCde1Z0gBUSZdrwQicfz4FjOkBjvcfRrxStvTW6lHDsR93CuaQNxB8Xz/eE/x4tZntT0/3Fmb3LcGLErliaUbAqr/hF6Hb5WAutKgcvK2WeBjYRXPVBCy86wYJZs3RaniruTDbK53QTSsRHs773FuGn8lqvGhFMnHlMt2ec1B7ocqFU6F1HUaNxTuKA==;7:z7x7OP26aAsAOS4+dgqLtGXPA7rojUUu/MpG1Klwg+rZ4kkkHH4MOw9P9sDXjSGnp2jP1qJ73F8tYDuQ2d2UDpohEL4hCf9drcBActBCSqgLED/Rr8pDAmvNsyAjFK6ivPquq9xDckeiRpOhuBaBtA==
x-ms-office365-filtering-correlation-id: 8e1ddac7-6a5f-4fd5-e65c-08d687a01994
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3286;
x-ms-traffictypediagnostic: DB6PR05MB3286:
x-microsoft-antispam-prvs: <DB6PR05MB3286632BEF83CDF1CF6ADF96A1910@DB6PR05MB3286.eurprd05.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(54534003)(13464003)(189003)(199004)(2906002)(68736007)(55016002)(33656002)(54906003)(7736002)(14454004)(9686003)(76176011)(7696005)(305945005)(316002)(74316002)(106356001)(256004)(3846002)(6116002)(71200400001)(14444005)(71190400001)(105586002)(53936002)(6436002)(53546011)(6506007)(229853002)(102836004)(6916009)(97736004)(39060400002)(4326008)(186003)(6246003)(26005)(81156014)(81166006)(8936002)(8676002)(478600001)(99286004)(25786009)(486006)(476003)(66066001)(86362001)(446003)(11346002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3286;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5+CpzAVcwEJo5wqAupKrUGqOuKz8pIPyQ2K5sW9cj2CHbcxSuXQeOHrKFHcDHD40QY/MfBGsnJoS3Pymcwv607Jo8HhEzqPOu8bWEhOQFHeZXuwlAXb1KBvjYxyYQZL3FpNDoyTwGXVEbUpFKe9AUQzrtLrCGfuDQRyGe5HuGMAjO5W+0ptLRpbxczZV/Rc6bWCnsvy/gDrFIwcgcXkSUwPa/rFcSklChT+xk/WBqfi2diTTJKaagrMClHZ0nHUlkjeOpGp9Y+ybj6tP8Xj5Wd9XFZyNIA/brA2dcQFBfOcGxvXu69gLmj5BDmh86YT8eaB6RWJq3tGRqtAt+65v1xxuILCzfZP/RYg2XGCCtITEDuV9bIGjIO7r+9+gm7Id4CsBnVFg02zqCso4v0uOVSzSAo74Wgsfw7XqBbl9n9U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1ddac7-6a5f-4fd5-e65c-08d687a01994
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 17:18:21.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIHNlZSBteSByZXNwb25zZSBpbmxpbmUuIFdpbGwgcHJvdmlkZSB2MyBvbmNlIEkgc29s
dmUgdGhlIGNvbW1lbnRzLg0KDQpUaGFua3MsDQpMaW1pbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFp
bC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDMxLCAyMDE5IDEyOjAyIFBNDQo+IFRv
OiBMaW1pbmcgU3VuIDxsc3VuQG1lbGxhbm94LmNvbT4NCj4gQ2M6IEFuZHkgU2hldmNoZW5rbyA8
YW5keUBpbmZyYWRlYWQub3JnPjsgRGFycmVuIEhhcnQgPGR2aGFydEBpbmZyYWRlYWQub3JnPjsg
VmFkaW0gUGFzdGVybmFrIDx2YWRpbXBAbWVsbGFub3guY29tPjsgRGF2aWQNCj4gV29vZHMgPGR3
b29kc0BtZWxsYW5veC5jb20+OyBQbGF0Zm9ybSBEcml2ZXIgPHBsYXRmb3JtLWRyaXZlci14ODZA
dmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHBsYXRmb3Jt
L21lbGxhbm94OiBBZGQgYm9vdGN0bCBkcml2ZXIgZm9yIE1lbGxhbm94IEJsdWVGaWVsZCBTb2MN
Cj4gDQo+IE9uIFRodSwgSmFuIDMxLCAyMDE5IGF0IDY6NTMgUE0gTGltaW5nIFN1biA8bHN1bkBt
ZWxsYW5veC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBjb21taXQgYWRkcyB0aGUgYm9vdGN0
bCBwbGF0Zm9ybSBkcml2ZXIgZm9yIE1lbGxhbm94IEJsdWVGaWVsZA0KPiA+IFNvYywgd2hpY2gg
Y29udHJvbHMgdGhlIGVNTUMgYm9vdCBwYXJ0aXRpb24gc3dhcHBpbmcgYW5kIHNlbmRzIFNNQw0K
PiA+IGNhbGxzIHRvIEFURiBydW5uaW5nIGF0IGV4Y2VwdGlvbiBsZXZlbCBFTDMgdG8gcHJvZ3Jh
bSBzb21lIHN5c3RlbQ0KPiA+IHJlZ2lzdGVyLiBUaGlzIHJlZ2lzdGVyIGlzIG9ubHkgYWNjZXNz
aWJsZSBpbiBzZWN1cmUgY29kZSBhbmQgaXMNCj4gPiB1c2VkIHRvIGVuYWJsZSB0aGUgd2F0Y2hk
b2cgYWZ0ZXIgcmVib290Lg0KPiA+DQo+ID4gQmVsb3cgYXJlIHRoZSBzZXF1ZW5jZXMgb2YgYSB0
eXBpY2FsIHVzZSBjYXNlLg0KPiA+DQo+ID4gICAxLiBVc2VyLXNwYWNlIHRvb2wgdXBncmFkZXMg
b25lIGVNTUMgYm9vdCBwYXJ0aXRpb24gYW5kIHJlcXVlc3RzDQo+ID4gICAgICB0aGUgYm9vdCBw
YXJ0aXRpb24gc3dhcHBpbmc7DQo+ID4NCj4gPiAgIDIuIFRoZSBib290Y3RsIGRyaXZlciBoYW5k
bGVzIHN1Y2ggcmVxdWVzdCBhbmQgc2VuZHMgU01DIGNhbGwNCj4gPiAgICAgIHRvIEFURi4gQVRG
IHByb2dyYW1zIHJlZ2lzdGVyIEJSRUFEQ1JVTUIwIHdoaWNoIGhhcyB2YWx1ZQ0KPiA+ICAgICAg
cHJlc2VydmVkIGR1cmluZyBzb2Z0d2FyZSByZXNldC4gSXQgYWxzbyBwcm9ncmFtcyBlTU1DIHRv
DQo+ID4gICAgICBzd2FwIHRoZSBib290IHBhcnRpdGlvbjsNCj4gPg0KPiA+ICAgMy4gQWZ0ZXIg
c29mdHdhcmUgcmVzZXQgKHJlYm9vdGluZyksIEFURiBCTDEgKEJvb3RSb20pIGNoZWNrcw0KPiA+
ICAgICAgcmVnaXN0ZXIgQlJFQURDUlVNQjAgdG8gZW5hYmxlIHdhdGNoZG9nIGlmIGNvbmZpZ3Vy
ZWQ7DQo+ID4NCj4gPiAgIDQuIElmIGJvb3RpbmcgZmFpbHMsIHRoZSB3YXRjaGRvZyB0aW1lciB3
aWxsIHRyaWdnZXIgcmVib290aW5nLg0KPiA+ICAgICAgSW4gc3VjaCBjYXNlLCBBVEYgQm9vdFJv
bSB3aWxsIHN3aXRjaCB0aGUgYm9vdCBwYXJ0aXRpb24NCj4gPiAgICAgIHRvIHRoZSBwcmV2aW91
cyBvbmUuDQo+IA0KPiBUaGFua3MgZm9yIGFuIHVwZGF0ZS4gTXkgY29tbWVudHMgYmVsb3cuDQo+
IA0KPiANCj4gPiBSZXZpZXdlZC1ieTogRGF2aWQgV29vZHMgPGR3b29kc0BtZWxsYW5veC5jb20+
DQo+IA0KPiBJJ20gbm90IHN1cmUgSSBzZWUgdGhpcyBndXkgdG8gcmV2aWV3IHYyLiBPZiBjb3Vy
c2UgaWYgeW91IGNvbnNpZGVyDQo+IGFsbCBjaGFuZ2VzIG1pbm9yLCB5b3UgbWF5IGxlYXZlIHRo
aXMgdGFnLg0KDQpIZSBzaXRzIGJlc2lkZXMgbWUgZm9yIGludGVybmFsIHJldmlldy4gSSdsbCB0
cnkgdG8gYXNrIGhpbSB0byBzZW5kDQpjb21tZW50cyB0byB0aGUgbWFpbGluZyBsaXN0Lg0KDQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IExpbWluZyBTdW4gPGxzdW5AbWVsbGFub3guY29tPg0KPiA+
IC0tLQ0KPiANCj4gSGVyZSBzaG91bGQgYmUgYSBjaGFuZ2Vsb2cgd2hhdCBoYWQgYmVlbiBkb25l
IGluIG5ldyB2ZXJzaW9uLg0KDQpXaWxsIHByb3ZpZGUgY2hhbmdlbG9nIGluIHRoZSB2MyBlbWFp
bC4NCk9yIHBsZWFzZSBjb3JyZWN0IG1lIGlmIHlvdSBtZWFudCBhZGRpbmcgY2hhbmdlbG9nIGlu
IHRoZSBjb2RlIG9yDQpjb3ZlciBsZXR0ZXIuDQoNCj4gPiArLyogVVVJRCB1c2VkIHRvIHByb2Jl
IEFURiBzZXJ2aWNlLiAqLw0KPiANCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtbHhi
Zl9ib290Y3RsX3N2Y191dWlkX3N0ciA9DQo+ID4gKyAgICAgICAiODljMDM2YjQtZTdkNy0xMWU2
LTg3OTctMDAxYWNhMDBiZmM0IjsNCj4gDQo+IHN0YXRpYyBjb25zdCBjaGFyICp4eHggPSAuLi47
DQoNCldpbGwgdXBkYXRlIGl0IGluIHYzLg0KDQo+IA0KPiA+ICsvKg0KPiA+ICsgKiBVVUlEIHN0
cnVjdHVyZSB1c2VkIHRvIG1hdGNoIHRoZSByZXR1cm5lZCB2YWx1ZSBmcm9tIEFURiBpbg0KPiA+
ICsgKiBmb3VyIDMyLWJpdCB3b3Jkcy4gTm8gbmVlZCB0byBkbyBlbmRpYW4gY29udmVyc2lvbiBo
ZXJlLg0KPiA+ICsgKi8NCj4gPiArdW5pb24gbWx4YmZfYm9vdGN0bF91dWlkIHsNCj4gPiArICAg
ICAgIGd1aWRfdCBndWlkOw0KPiA+ICsgICAgICAgdTMyIHdvcmRzWzRdOw0KPiA+ICt9Ow0KPiAN
Cj4gSSdtIG5vdCBzdXJlIGl0J3MgdGhlIGJlc3QgeW91IGNhbiBkby4gaW5zdGVhZCBvZiB1c2lu
ZyB1bmlvbiwgYmV0dGVyDQo+IHRvIHVzZSBjb252ZXJzaW9uIGZyb20gYW5kIHRvIGNvcnJlc3Bv
bmRpbmcgdXVpZCB0eXBlLg0KDQpJJ2xsIHRyeSB0byBmaWd1cmUgb3V0IGFub3RoZXIgd2F5IHdp
dGhvdXQgdGhlIHVuaW9uIHRvIGNvbXBhcmUgdGhlDQp1dWlkIGRpcmVjdGx5IHVzaW5nIHV1aWQg
YXBpLiBXaWxsIHVwZGF0ZSBpdCBpbiB2My4NCg0KPiANCj4gVGhlIHJlc3QgSSB3aWxsIGNvbW1l
bnQgb24gdjMuDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hl
bmtvDQo=
