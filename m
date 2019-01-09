Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459DD214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="kMD+teN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfAIIj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:39:58 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:32372
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730003AbfAIIjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ213LF2TEZgcy9lw1delmrhUGR8P3/CHyIBa1ZYhP0=;
 b=kMD+teN8Furmaj5VsAOB9zZN2LQca9KjnbSlRchG1I07CQNoBjTHGimZZ90bnVMSJvZjPmsIselaSbYzZDpEKs9jjKLxjiUsDj4bWnCi2S5LlLzJ5OCcxznAx3rlNOEqra8cU/uyFnouITHFFuiWBV0cuTjgEbc+3+s8UsnKv8U=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3780.eurprd04.prod.outlook.com (52.133.39.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 08:39:46 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 08:39:46 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgNC80XSBBUk06IG14czogY2ZhMTAwMzY6IEZp?=
 =?utf-8?Q?xup_OLED_display_reset_polarity?=
Thread-Topic: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgNC80XSBBUk06IG14czogY2ZhMTAwMzY6IEZp?=
 =?utf-8?Q?xup_OLED_display_reset_polarity?=
Thread-Index: AQHUp/bge8VKpB9zqEWIZtatzCOaLQ==
Date:   Wed, 9 Jan 2019 08:39:46 +0000
Message-ID: <1547023165-111798-5-git-send-email-michal.vokac@ysoft.com>
References: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::35) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3780;6:+1KK/T5IrjA3kSDneTfJMcJ8llg+vNueElubFBgDaRU1hJAxUbyWpkva4eC+FGz24FZ+CUJnr8491ACErWeGdX4GmfXgUGzqhmHHw8oP89qpgMoNpTnEx1mHNev0COzQsK4L0FlGwBvvoaZtP7wGfekcT3HsZ5Su2ueUlsgGx1rnvfOlkNAxo4d11k11Y3zVOONsBB2K7SwBwWW7FHetBcp0Uoir+9icZ4UzlT48Xq2ZGjySZx0YgVtUueWb9WWibJCK38LxN0JzRh4hWfmoU9+w2BMSoFqfQ0VTieYewWn2KB87CwV/P1Iy5oO8ao6U5XssaxrRJJmbQy3I7z2EqF0fixtJV9tDhfCjya6yMHrTJKfP8CZEcPDKvUzCE1jcA2Dskn6h0XysYvH2/8i/wyCIca+7ozPNS55f/ylorCt/h0em92uyWve6SlpJI7DVikmX6W43Py5xp8PRP9p2ow==;5:xy4d20VD/hNnPUs98TsEsMHmXEGShE5KHFoR4Yl6rOpa5rm1VS/l9c/Fvw2XDgmmJyTQQG03teJJ0v1RFi+nRV9d+6beGNCNBy64ufkABOxd8HlJwYIE7uRqqBksvuS9JN5gXmplUayKdqTB2qDDFMi1zYgGKfgW5MfiTz+67z3L+LpsYVA8rKDY56dc8GbLDeW6IypVfu80vuFjjLXRbg==;7:MacNuKv2DwLCg0a7T4SnlALL6vHdYJRFjq5hc2Joocgk6nwUuKmCyxmj1y+De203frnEFAImdnAtu3cn+RprfMAQbcI9w+nJA4BmbfVd7+fF9uFjL6x851EMslvaId2+nLHTn9NfE68mY9Yv/WzbIQ==
x-ms-office365-filtering-correlation-id: 4c8c846b-5d90-48e3-45ed-08d6760e026d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3780;
x-ms-traffictypediagnostic: AM0PR0402MB3780:
x-microsoft-antispam-prvs: <AM0PR0402MB3780835E107E85C59AE161739E8B0@AM0PR0402MB3780.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3780;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3780;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39850400004)(199004)(189003)(53936002)(5660300001)(66066001)(8936002)(6512007)(72206003)(6916009)(25786009)(4326008)(14444005)(256004)(36756003)(107886003)(106356001)(6116002)(14454004)(6436002)(105586002)(81156014)(81166006)(97736004)(486006)(6486002)(3846002)(50226002)(2906002)(305945005)(7736002)(86362001)(85182001)(11346002)(478600001)(446003)(476003)(2616005)(68736007)(6346003)(76176011)(102836004)(99286004)(386003)(6506007)(186003)(71190400001)(54906003)(71200400001)(316002)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3780;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YORqYMc6aGiS2xQPxL3MuzBNmhsgO6NIU0lOGad3euMJlbiBpCs6LzbSECj07zP4tNZaNkmHg0lymBNV0OM5us6mOahJE0JUO7l1pM7W2IkwOVariCVGIUzmggqG+VVxpCRMlpE9Pymv25dWQeWeD7o9ZDIfzLJOBLgAB/OrnM2LVpWTL9fYrquLWxumhpinDq4wnD43E/Bmc4ZJnwUjkwdWuhXkBgO69GJ2jGzC77V5tAtE91P4XFONVj4c9KgtV5vvK9/XoS1ombyNf3i8fjz11GqsoLFm/gg0TmBuV3hayB/cYW+OE05jya1/CoNq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0BD439C44A4C64EA744CCB34071D644@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8c846b-5d90-48e3-45ed-08d6760e026d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 08:39:45.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgd2FzIGEgYnVnIGluIHJlc2V0IHNpZ25hbCBnZW5lcmF0aW9uIGluIHNzZDEzMDdmYiBP
TEVEIGRyaXZlci4NClRoZSBkaXNwbGF5IG5lZWRzIGFuIGFjdGl2ZS1sb3cgcmVzZXQgc2lnbmFs
IGJ1dCB0aGUgZHJpdmVyIHByb2R1Y2VkDQp0aGUgY29ycmVjdCBzZXF1ZW5jZSBvbmx5IGlmIHRo
ZSBHUElPIHVzZWQgZm9yIHJlc2V0IHdhcyBzcGVjaWZpZWQgYXMNCkdQSU9fQUNUSVZFX0hJR0gu
DQoNCk5vdyBhcyB0aGUgT0xFRCBkcml2ZXIgaXMgZml4ZWQgaXQgaXMgYWxzbyBuZWNlc3NhcnJ5
IHRvIGltcGxlbWVudA0KYSBmaXh1cCBmb3IgYWxsIGN1cnJlbnQgdXNlcnMgb2YgdGhlIG9sZCBE
VCBBQkkuIFRoZXJlIGlzIG9ubHkgb25lDQppbi10cmVlIHVzZXIgYW5kIHRoYXQgaXMgdGhlIENy
eXN0YWxmb250eiBDRkEtMTAwMzYgYm9hcmQuIEluIGNhc2UNCnRoaXMgYm9hcmQgaXMgYm9vdGlu
ZyBhbmQgR1BJT19BQ1RJVkVfSElHSCBpcyB1c2VkIGZvciByZXNldCB3ZQ0Kb3ZlcnJpZGUgaXQg
dG8gR1BJT19BQ1RJVkVfTE9XLg0KDQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IE1pY2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNAeXNv
ZnQuY29tPg0KLS0tDQpDaGFuZ2VzIGZyb20gdjE6DQogLSBBZGQgUi1ieSBmcm9tIFJvYg0KIC0g
VXNlIG9mX3Byb3BlcnR5X3JlYWRfdmFyaWFibGVfdTMyX2FycmF5IHRvIHJlYWQgdGhlIEdQSU8g
c3BlY2lmaWVyDQogICBhcnJheSBpbnN0ZWFkIG9mIHJlYWRpbmcgaXQgbWFudWFseSBpbiBmb3Ig
Y3ljbGUuIChSb2IpDQoNCiBhcmNoL2FybS9tYWNoLW14cy9tYWNoLW14cy5jIHwgNDQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwg
NDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1teHMvbWFjaC1t
eHMuYyBiL2FyY2gvYXJtL21hY2gtbXhzL21hY2gtbXhzLmMNCmluZGV4IDFjNjA2MmQuLjUwMDM4
ZDYgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9tYWNoLW14cy9tYWNoLW14cy5jDQorKysgYi9hcmNo
L2FybS9tYWNoLW14cy9tYWNoLW14cy5jDQpAQCAtMjEsNiArMjEsNyBAQA0KICNpbmNsdWRlIDxs
aW51eC9yZWJvb3QuaD4NCiAjaW5jbHVkZSA8bGludXgvbWljcmVsX3BoeS5oPg0KICNpbmNsdWRl
IDxsaW51eC9vZl9hZGRyZXNzLmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX2dwaW8uaD4NCiAjaW5j
bHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCiAjaW5jbHVkZSA8bGludXgvcGh5Lmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L3BpbmN0cmwvY29uc3VtZXIuaD4NCkBAIC0yNjgsOSArMjY5LDUyIEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBhcHg0ZGV2a2l0X2luaXQodm9pZCkNCiAJCQkJCSAgIGFweDRkZXZr
aXRfcGh5X2ZpeHVwKTsNCiB9DQogDQorI2RlZmluZSBPTEVEX1JFU0VUX0dQSU9fTEVOCTMNCisj
ZGVmaW5lIE9MRURfUkVTRVRfR1BJT19TSVpFCShPTEVEX1JFU0VUX0dQSU9fTEVOICogc2l6ZW9m
KHUzMikpDQorDQorc3RhdGljIHZvaWQgX19pbml0IGNyeXN0YWxmb250el9vbGVkX3Jlc2V0X2Zp
eHVwKHZvaWQpDQorew0KKwlzdHJ1Y3QgcHJvcGVydHkgKm5ld2dwaW87DQorCXN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbnA7DQorCXUzMiAqZ3Bpb3NwZWM7DQorCWludCByZXQ7DQorDQorCW5wID0gb2Zf
ZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgInNvbG9tb24sc3NkMTMwNmZiLWkyYyIp
Ow0KKwlpZiAoIW5wKQ0KKwkJcmV0dXJuOw0KKw0KKwluZXdncGlvID0ga3phbGxvYyhzaXplb2Yo
Km5ld2dwaW8pICsgT0xFRF9SRVNFVF9HUElPX1NJWkUsIEdGUF9LRVJORUwpOw0KKwlpZiAoIW5l
d2dwaW8pDQorCQlyZXR1cm47DQorDQorCW5ld2dwaW8tPnZhbHVlID0gbmV3Z3BpbyArIDE7DQor
CW5ld2dwaW8tPmxlbmd0aCA9IE9MRURfUkVTRVRfR1BJT19TSVpFOw0KKwluZXdncGlvLT5uYW1l
ID0ga3N0cmR1cCgicmVzZXQtZ3Bpb3MiLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFuZXdncGlvLT5u
YW1lKSB7DQorCQlrZnJlZShuZXdncGlvKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwlncGlvc3Bl
YyA9IG5ld2dwaW8tPnZhbHVlOw0KKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3ZhcmlhYmxlX3Uz
Ml9hcnJheShucCwgInJlc2V0LWdwaW9zIiwgZ3Bpb3NwZWMsDQorCQkJCQkJICBPTEVEX1JFU0VU
X0dQSU9fTEVOLCAwKTsNCisNCisJaWYgKHJldCA8IDApIHsNCisJCWtmcmVlKG5ld2dwaW8pOw0K
KwkJcmV0dXJuOw0KKwl9DQorDQorCWlmICghKGdwaW9zcGVjWzJdICYgT0ZfR1BJT19BQ1RJVkVf
TE9XKSkgew0KKwkJZ3Bpb3NwZWNbMl0gfD0gT0ZfR1BJT19BQ1RJVkVfTE9XOw0KKwkJY3B1X3Rv
X2JlMzJfYXJyYXkoZ3Bpb3NwZWMsIGdwaW9zcGVjLCBPTEVEX1JFU0VUX0dQSU9fTEVOKTsNCisJ
CW9mX3VwZGF0ZV9wcm9wZXJ0eShucCwgbmV3Z3Bpbyk7DQorCX0NCit9DQorDQogc3RhdGljIHZv
aWQgX19pbml0IGNyeXN0YWxmb250el9pbml0KHZvaWQpDQogew0KIAl1cGRhdGVfZmVjX21hY19w
cm9wKE9VSV9DUllTVEFMRk9OVFopOw0KKwljcnlzdGFsZm9udHpfb2xlZF9yZXNldF9maXh1cCgp
Ow0KIH0NCiANCiBzdGF0aWMgdm9pZCBfX2luaXQgZHVja2JpbGxfaW5pdCh2b2lkKQ0KLS0gDQoy
LjEuNA0KDQo=
