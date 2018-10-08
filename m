Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD4FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293E6214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="cqnf7llD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293E6214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJIE5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:57:47 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com ([40.107.8.93]:23056
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725749AbeJIE5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27zGogwVD9hHi2afOwWvw3yipSY7GrttcsqTxFxwcEo=;
 b=cqnf7llDiFq9dfHcirAH0W/kNSyC0lUAQKqELmhyTD/XsEwV/ZG+NkIz81BvMjF4mxp9qFBSh9oQFl1jGRCQO395pXmMUgE5s4xbD4Het3WtwZsyXeSQwnerMCDHNZvJ+GN3hb+rLDEnuTEkkTHmKZ4oCzFA+DOJ/0Y1Ks29S8Q=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB1741.eurprd02.prod.outlook.com (10.166.41.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 21:43:55 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 21:43:55 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Luca Ceresoli <lucaceresoli77@gmail.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Thread-Topic: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Thread-Index: AQHUWyyIYmlXSDP/EEi7krLfM400NKUV6akA
Date:   Mon, 8 Oct 2018 21:43:55 +0000
Message-ID: <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
References: <20181003151928.17713-1-lucaceresoli77@gmail.com>
In-Reply-To: <20181003151928.17713-1-lucaceresoli77@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0226.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::26) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB1741;6:ACorDabAdPDOXj3Ng+wLb7iF3M8eb+SNsK3xuOSYRd7u9+yUwVxWN+TppFXiWCL0gAPZseKUid8dw7g/j8/fHUF1ee8VelSmRcu9ybaAawG4hGibZLHG1rjLsJXFwR1X227q9Gfizn703WOf39WFp4fDR9BCkE+PtWsX0M1GvPrOpmINLUf5/RGSKJ0qIAY5RoowEs4aoKGQFF+SbGNfC2g6lLB/ht2CGaCCsVINk8oB2l+2PKC1t5BsCzJajj4IvuiAoSvO8/8dHEuOve5Tu4RjDTyzoiStXSG+zseG0YdRG8rYbd8ROYSE8HaK0iAkA5oPcopAbIHB43HI2YoRkL9KJu9VV+W3UtKH3fihrvQIbIBeImeK3Z7EL9a4Sxmt/3PVQetLoYOEtNnj/kwSUvgEiLTM0ycJHRFkVq6JtJhgmFa/G9rON7V0BO/F3lknO8+iu9xSK/H/R+cNp+s/eQ==;5:whiWEAwfswVbpkWnG2g2ut3ontQlnw1eF1/VMLyApnpN8ohCBlXG+YHrBHR5/FFZ3wWUvXRWhHPxqB9qW+X6ufdCYekgWvGVXZM3tnKf3XlS3m2cwpGChxMVykzNt96aY8IYRnT0ULirMzsdu7zmaL8E5F/jtTuS4lznUY1qOX4=;7:7lQqRL2uOOjhftWjm1/vAHwSrIUBJ3y2nv3L51n2wqr6NRCQXePiGRr0mSI7DEk//omRb7jHY0x69/gOwAgHGNKaGSUKDNq1yaJ4O7fe4/xxlwga8LUr3hZHv0M8L7FfxnUeStCvjEKWqsq2mO5ma/Y2R7AZetJ0R8vctcevR8eNAAxPGY2Tg2xP5LF3gwG4DV5hV52zakYMg/b//Hm2NXgvcLpjpDIx7tyUczaaZpPoKOKj6JA4JbXeY8VmiQJr
x-ms-office365-filtering-correlation-id: fba53af9-1f88-48b9-5637-08d62d67251d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB1741;
x-ms-traffictypediagnostic: VI1PR0201MB1741:
x-microsoft-antispam-prvs: <VI1PR0201MB174127563142AA37237FFA8DBCE60@VI1PR0201MB1741.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051);SRVR:VI1PR0201MB1741;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB1741;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39830400003)(189003)(199004)(64126003)(74482002)(36756003)(31696002)(86362001)(6436002)(316002)(508600001)(7736002)(102836004)(14454004)(305945005)(71190400001)(6246003)(6512007)(52116002)(71200400001)(2906002)(54906003)(110136005)(53936002)(65806001)(65956001)(99286004)(58126008)(66066001)(76176011)(68736007)(97736004)(2501003)(5250100002)(8936002)(2616005)(486006)(476003)(3846002)(386003)(6506007)(6116002)(81156014)(53546011)(81166006)(26005)(229853002)(186003)(14444005)(256004)(8676002)(6486002)(31686004)(106356001)(105586002)(25786009)(3260700006)(65826007)(39060400002)(446003)(5660300001)(4326008)(11346002)(2900100001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB1741;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m+qUVEYx2py+9uA0D+Sqx+si02hvOuRBtc8QsZuBJ0DYSpCpOIQckmf7Gf7OPRqVXXPy+YWvmXrYXU5Y7tad466+4WQxpPPt3aEUnJovfsIGQyL7oz/o93AcWa3eBF5lJIUIjaTXawRHHb2hvFCJ5GyQlFgbVWnhLih2DGAkKg671T+tHyfluEVo0F1Rz1TLm1vp401dE7QIxypcxWms2E60pKMGdrru+ssZGoyfZW6oLhkvDey6zSB8hwBWy9wyNl52+tyaX+OBZbvH2S4/U4GHk2IND18ciCWKGcfIJTOdz8068dPz7Jp2KWeOk+kK54jbY1ggdIfIgpRVLEP58pcEM3epUGp5d/2melr5PMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <355CE9BA777F23429C443D68FF7A17FA@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fba53af9-1f88-48b9-5637-08d62d67251d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 21:43:55.1648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB1741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMC0wMyAxNzoxOSwgTHVjYSBDZXJlc29saSB3cm90ZToNCj4gRnJvbTogTHVjYSBD
ZXJlc29saSA8bHVjYUBsdWNhY2VyZXNvbGkubmV0Pg0KPiANCj4gaTJjLW11eCBpbnN0YW50aWF0
ZXMgb25lIGkyY19hbGdvcml0aG0gZm9yIGVhY2ggZG93bnN0cmVhbSBhZGFwdGVyLg0KPiBIb3dl
dmVyIHRoZXNlIGFsZ29yaXRobXMgYXJlIGFsbCBpZGVudGljYWwsIGRlcGVuZGluZyBvbmx5IG9u
IHRoZQ0KPiBwYXJlbnQgYWRhcHRlci4NCj4gDQo+IEF2b2lkIGR1cGxpY2F0aW9uIGJ5IGhvaXN0
aW5nIHRoZSBpMmNfYWxnb3JpdGhtIGZyb20gdGhlIGFkYXB0ZXJzIHRvDQo+IHRoZSBpMmNfbXV4
X2NvcmUgb2JqZWN0LCBhbmQgcmV1c2UgaXQgaW4gYWxsIHRoZSBhZGFwdGVycy4NCg0KT3VjaCwg
d2hpbGUgSSBsaWtlIHRoZSBjb25jZXB0IG9mIGhhdmluZyBvbmUgaTJjX2FsZ29yaXRobSBwZXIg
bXV4LA0KdGhpcyBwYXRjaCBpcyBub3Qgd29ya2luZy4gVmFyaW91cyBpMmMtbXV4IGRyaXZlcnMg
c2V0IHRoZQ0KbXV4Yy0+bXV4X2xvY2tlZCB2YXJpYWJsZSAqYWZ0ZXIqIHRoZSBpMmNfbXV4X2Fs
bG9jIGNhbGwsIGFuZCB0aGlzDQpwYXRjaCBicmVha3Mgc3VjaCB1c2UuDQoNClNvLCB0aGUgcGF0
Y2ggbmVlZHMgc29tZSByZXdvcmtpbmcuIFNvcnJ5IGZvciBub3Qgbm90aWNpbmcgdGhpcw0KZWFy
bGllci4NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiBDYzogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRp
YS5zZT4NCj4gU2lnbmVkLW9mZi1ieTogTHVjYSBDZXJlc29saSA8bHVjYUBsdWNhY2VyZXNvbGku
bmV0Pg0KPiANCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIHYyIC0+IHYzOg0KPiAgLSBmaXggY29kaW5n
IHN0eWxlIG9mIGNvbW1lbnQgd2hlbiBtb3ZpbmcgaXQgKFBldGVyIFJvc2luKQ0KPiAgLSBtb3Zl
IHRoZSAnYWxnbycgbWVtYmVyIGJldHdlZW4gcGFyZW50IGFuZCBkZXYgKFBldGVyIFJvc2luKQ0K
PiANCj4gQ2hhbmdlcyB2MSAtPiB2MjoNCj4gIC0gaW5jbHVkZSBpMmMuaCAoZml4ZXMgYnVpbGQg
ZmFpbHVyZSBvbiBpMmMtbXV4LWx0YzQzMDYpDQo+IC0tLQ0KPiAgZHJpdmVycy9pMmMvaTJjLW11
eC5jICAgfCAzOCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgaW5j
bHVkZS9saW51eC9pMmMtbXV4LmggfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ky
Yy9pMmMtbXV4LmMgYi9kcml2ZXJzL2kyYy9pMmMtbXV4LmMNCj4gaW5kZXggZjMzMDY5MGI0MTI1
Li42YWMyMzAwNGZiMmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJjL2kyYy1tdXguYw0KPiAr
KysgYi9kcml2ZXJzL2kyYy9pMmMtbXV4LmMNCj4gQEAgLTMwLDcgKzMwLDYgQEANCj4gIC8qIG11
bHRpcGxleGVyIHBlciBjaGFubmVsIGRhdGEgKi8NCj4gIHN0cnVjdCBpMmNfbXV4X3ByaXYgew0K
PiAgCXN0cnVjdCBpMmNfYWRhcHRlciBhZGFwOw0KPiAtCXN0cnVjdCBpMmNfYWxnb3JpdGhtIGFs
Z287DQo+ICAJc3RydWN0IGkyY19tdXhfY29yZSAqbXV4YzsNCj4gIAl1MzIgY2hhbl9pZDsNCj4g
IH07DQo+IEBAIC0yNjMsNiArMjYyLDI0IEBAIHN0cnVjdCBpMmNfbXV4X2NvcmUgKmkyY19tdXhf
YWxsb2Moc3RydWN0IGkyY19hZGFwdGVyICpwYXJlbnQsDQo+ICAJbXV4Yy0+ZGVzZWxlY3QgPSBk
ZXNlbGVjdDsNCj4gIAltdXhjLT5tYXhfYWRhcHRlcnMgPSBtYXhfYWRhcHRlcnM7DQo+ICANCj4g
KwkvKg0KPiArCSAqIE5lZWQgdG8gZG8gYWxnbyBkeW5hbWljYWxseSBiZWNhdXNlIHdlIGRvbid0
IGtub3cgYWhlYWQgb2YNCj4gKwkgKiB0aW1lIHdoYXQgc29ydCBvZiBwaHlzaWNhbCBhZGFwdGVy
IHdlJ2xsIGJlIGRlYWxpbmcgd2l0aC4NCj4gKwkgKi8NCj4gKwlpZiAocGFyZW50LT5hbGdvLT5t
YXN0ZXJfeGZlcikgew0KPiArCQlpZiAobXV4Yy0+bXV4X2xvY2tlZCkNCj4gKwkJCW11eGMtPmFs
Z28ubWFzdGVyX3hmZXIgPSBpMmNfbXV4X21hc3Rlcl94ZmVyOw0KPiArCQllbHNlDQo+ICsJCQlt
dXhjLT5hbGdvLm1hc3Rlcl94ZmVyID0gX19pMmNfbXV4X21hc3Rlcl94ZmVyOw0KPiArCX0NCj4g
KwlpZiAocGFyZW50LT5hbGdvLT5zbWJ1c194ZmVyKSB7DQo+ICsJCWlmIChtdXhjLT5tdXhfbG9j
a2VkKQ0KPiArCQkJbXV4Yy0+YWxnby5zbWJ1c194ZmVyID0gaTJjX211eF9zbWJ1c194ZmVyOw0K
PiArCQllbHNlDQo+ICsJCQltdXhjLT5hbGdvLnNtYnVzX3hmZXIgPSBfX2kyY19tdXhfc21idXNf
eGZlcjsNCj4gKwl9DQo+ICsJbXV4Yy0+YWxnby5mdW5jdGlvbmFsaXR5ID0gaTJjX211eF9mdW5j
dGlvbmFsaXR5Ow0KPiArDQo+ICAJcmV0dXJuIG11eGM7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9M
X0dQTChpMmNfbXV4X2FsbG9jKTsNCj4gQEAgLTMwMSwyOCArMzE4LDExIEBAIGludCBpMmNfbXV4
X2FkZF9hZGFwdGVyKHN0cnVjdCBpMmNfbXV4X2NvcmUgKm11eGMsDQo+ICAJcHJpdi0+bXV4YyA9
IG11eGM7DQo+ICAJcHJpdi0+Y2hhbl9pZCA9IGNoYW5faWQ7DQo+ICANCj4gLQkvKiBOZWVkIHRv
IGRvIGFsZ28gZHluYW1pY2FsbHkgYmVjYXVzZSB3ZSBkb24ndCBrbm93IGFoZWFkDQo+IC0JICog
b2YgdGltZSB3aGF0IHNvcnQgb2YgcGh5c2ljYWwgYWRhcHRlciB3ZSdsbCBiZSBkZWFsaW5nIHdp
dGguDQo+IC0JICovDQo+IC0JaWYgKHBhcmVudC0+YWxnby0+bWFzdGVyX3hmZXIpIHsNCj4gLQkJ
aWYgKG11eGMtPm11eF9sb2NrZWQpDQo+IC0JCQlwcml2LT5hbGdvLm1hc3Rlcl94ZmVyID0gaTJj
X211eF9tYXN0ZXJfeGZlcjsNCj4gLQkJZWxzZQ0KPiAtCQkJcHJpdi0+YWxnby5tYXN0ZXJfeGZl
ciA9IF9faTJjX211eF9tYXN0ZXJfeGZlcjsNCj4gLQl9DQo+IC0JaWYgKHBhcmVudC0+YWxnby0+
c21idXNfeGZlcikgew0KPiAtCQlpZiAobXV4Yy0+bXV4X2xvY2tlZCkNCj4gLQkJCXByaXYtPmFs
Z28uc21idXNfeGZlciA9IGkyY19tdXhfc21idXNfeGZlcjsNCj4gLQkJZWxzZQ0KPiAtCQkJcHJp
di0+YWxnby5zbWJ1c194ZmVyID0gX19pMmNfbXV4X3NtYnVzX3hmZXI7DQo+IC0JfQ0KPiAtCXBy
aXYtPmFsZ28uZnVuY3Rpb25hbGl0eSA9IGkyY19tdXhfZnVuY3Rpb25hbGl0eTsNCj4gLQ0KPiAg
CS8qIE5vdyBmaWxsIG91dCBuZXcgYWRhcHRlciBzdHJ1Y3R1cmUgKi8NCj4gIAlzbnByaW50Zihw
cml2LT5hZGFwLm5hbWUsIHNpemVvZihwcml2LT5hZGFwLm5hbWUpLA0KPiAgCQkgImkyYy0lZC1t
dXggKGNoYW5faWQgJWQpIiwgaTJjX2FkYXB0ZXJfaWQocGFyZW50KSwgY2hhbl9pZCk7DQo+ICAJ
cHJpdi0+YWRhcC5vd25lciA9IFRISVNfTU9EVUxFOw0KPiAtCXByaXYtPmFkYXAuYWxnbyA9ICZw
cml2LT5hbGdvOw0KPiArCXByaXYtPmFkYXAuYWxnbyA9ICZtdXhjLT5hbGdvOw0KPiAgCXByaXYt
PmFkYXAuYWxnb19kYXRhID0gcHJpdjsNCj4gIAlwcml2LT5hZGFwLmRldi5wYXJlbnQgPSAmcGFy
ZW50LT5kZXY7DQo+ICAJcHJpdi0+YWRhcC5yZXRyaWVzID0gcGFyZW50LT5yZXRyaWVzOw0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pMmMtbXV4LmggYi9pbmNsdWRlL2xpbnV4L2kyYy1t
dXguaA0KPiBpbmRleCBiZDc0ZDU3MDZmM2IuLjNkODk2MDBkNWE5ZSAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC9pMmMtbXV4LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9pMmMtbXV4LmgN
Cj4gQEAgLTI4LDkgKzI4LDExIEBADQo+ICAjaWZkZWYgX19LRVJORUxfXw0KPiAgDQo+ICAjaW5j
bHVkZSA8bGludXgvYml0b3BzLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvaTJjLmg+DQo+ICANCj4g
IHN0cnVjdCBpMmNfbXV4X2NvcmUgew0KPiAgCXN0cnVjdCBpMmNfYWRhcHRlciAqcGFyZW50Ow0K
PiArCXN0cnVjdCBpMmNfYWxnb3JpdGhtIGFsZ287DQo+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0K
PiAgCXVuc2lnbmVkIGludCBtdXhfbG9ja2VkOjE7DQo+ICAJdW5zaWduZWQgaW50IGFyYml0cmF0
b3I6MTsNCj4gDQoNCg==
