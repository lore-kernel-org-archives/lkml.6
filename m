Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC29C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB5321741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="MX0BxjfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbeLTMOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:14:11 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:28546
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731706AbeLTMOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ213LF2TEZgcy9lw1delmrhUGR8P3/CHyIBa1ZYhP0=;
 b=MX0BxjfGAUJu3mPMKe8ov8ZU2Pck+5GGUFbVIJyugk6gSAnc7rLzLRJ82w0ye/Kbkj6VcK34GbOUIpR1/1ocwY1LzPvxIYbTl1wCt154HtjxXtSOCd5ZdXn65Bk/AlEPxC0+YQ4vYjNUMCTrFpfdYKOfzr9mwkjvWej+OAuEODk=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4555.eurprd04.prod.outlook.com (52.135.138.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 20 Dec 2018 12:13:59 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 12:13:59 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH v2 4/4] ARM: mxs: cfa10036: Fixup OLED display reset polarity
Thread-Topic: [PATCH v2 4/4] ARM: mxs: cfa10036: Fixup OLED display reset
 polarity
Thread-Index: AQHUmF17VaGP6W4V9EimfGBpapxsgQ==
Date:   Thu, 20 Dec 2018 12:13:57 +0000
Message-ID: <1545308005-51559-5-git-send-email-michal.vokac@ysoft.com>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4555;6:D2VuRcyYvcFpgjLG8tH1SuACPWQrAVifPmWzncERM/lpgyBe6z7ux9PC7J58bqLjMqk9Ob7JGolxq3U2xXm0vGXnvarQH7Xcoyzv0QyK+ccUD1C9Q0QE1nYiMCgFvRw7TJjRamuIExn3wCfwlS6sZJN6PNkOrJunroRj/9HL59NZayLmlyqnEzlbRHWfX6WmlvmHXWN5YbLOpVG6Ex2h6sds7EAOw8A+U9qYPjPH5fFEeg5h+qEfO/h83JIe/CIf6b9leWr1e00fdU4uVkxEOJETxw12fITDn6brmZzYLwa39GHinH4xam4Ulhqfg1IrH9IM54zTnYLEZRgnWBC5LS1VkkXIS5tOe1IxRLDRmjcq7CxbUmfipcU1byolSKvL6foKzAgMT/PvKSL1CjRLJ0TJ6Cb5w0HQCnbG/zckdRrHxqfx2PqTS5dF3BI0T5dibbRv62HSrdeg4kqdgIo5sQ==;5:Qv1lE7G5pGxHvIG9u7RXdx2RKttTz2D1KWM3EtatEf5/7qwgU/18yFiL1UbiyKx3k+1GTQkp157PCI2IPetm+TXHO+qf+u+sBobtnWvUXdrABrFqabKggvxo8675NTY8Rg7d4HpoTjPAeS4+BZajRlc1btI1e77K8Q8Bj9/3lYQ=;7:pMTabk3mNlXQuRNzJIpeoig/RM3PCxARpJKr2WVZnIJTtMrkXsAqbZuxi04Uw5K9mXEWWm/pSHI84cnPn3NSNBDbopAGiFQpDfFhsXbKoHWO1Y5NlAJPdlHeVJ61MXojH3zzO1hNg0vzmbcBgPDiAw==
x-ms-office365-filtering-correlation-id: 4addf853-3716-44fd-3644-08d666749dc5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4555;
x-ms-traffictypediagnostic: DB7PR04MB4555:
x-microsoft-antispam-prvs: <DB7PR04MB45550E81E57AD0514DF52A549EBF0@DB7PR04MB4555.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4555;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4555;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39850400004)(376002)(366004)(396003)(199004)(189003)(99286004)(305945005)(7736002)(102836004)(14454004)(66066001)(110136005)(72206003)(478600001)(8676002)(81166006)(6486002)(8936002)(71200400001)(71190400001)(81156014)(76176011)(446003)(6436002)(476003)(386003)(6506007)(2616005)(486006)(11346002)(86362001)(68736007)(54906003)(5660300001)(85182001)(53936002)(36756003)(107886003)(6116002)(3846002)(256004)(14444005)(106356001)(52116002)(105586002)(25786009)(26005)(2906002)(316002)(6512007)(4326008)(186003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4555;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wiAIWtcz8Fj9G4n1NnE7N1acB32MU2WaE0z74rsVApbbTe3iQny3CpzjQ18bbeYHZrtVrmQbw7/EyAlpsR3z5u+meX1m5n9VBb7hIxHVa+bPRutJlqMyH2IoojAThBSCuJB2iARCSUvpWZarYQgAEVOpFm7/qBhjV/1hh44oaZGUos6kw4Jq17CowwDYw3hH63i3dV0PYDBDkwJUyEZeh4pUQkh77txUfszQ/IFPnY6GTs9ffl7PUb7C0F72KFpYzRCQf4eH2gh7L5imbwntuxBkX169R/iKqg58xcO98InY6zm5SrY5ZTZiHwuQMq0i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D36679391D19094BA572C90953807E9F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4addf853-3716-44fd-3644-08d666749dc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 12:13:57.2733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4555
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
