Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8F2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="evt7yThr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeLSNRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:17:02 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:17952
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbeLSNRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iqOo3VJQePdEalkfAN7w1vwt/odNk2sA5cRZ49l16g=;
 b=evt7yThrxtmWH05JwP03x9bsXN5HdQtlnJJuUjpg0bEZ7CoOGyZyOjNP/RNGLlsM4TIJ1AtTwkqcR1EzdZlrkKot+n5AFhrb33n3zfj32B1jOKrakpz6Sl+F/owezoj+mJmtLc5YYFBJ3pt+VJ6XcjYnDyJg6zsRLGL7aMl9nxk=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3437.eurprd04.prod.outlook.com (52.134.3.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 13:16:54 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ec1a:b30c:84c2:89d3]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ec1a:b30c:84c2:89d3%6]) with mapi id 15.20.1425.021; Wed, 19 Dec 2018
 13:16:54 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Topic: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Index: AQHUl5hS3YQwM2HAUkyF1f0Av+JOLaWGCwaA
Date:   Wed, 19 Dec 2018 13:16:54 +0000
Message-ID: <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
In-Reply-To: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3437;6:GJyoMd9FaLjNMDSslSvsloSYj1mUcYFCsUXenOmI/bQGMxzKlHK2A2jYEMN7v1Mkeua0cXSumE9c7oKMYgtP+L6w+OrucoEbou6i6R5Rr6fQi9fW+5pDZ4ijM/uNnRUBN0FAP6dpA/f3qXA06D3M2RtE30JIKwqhatvN8fgAJbnbfUxgswZbC8JFrKqUqWOdbfjhTfuqsjrfpy6sKe0e5sEp23KPohKwTtS9qQ2v8P2BnVL/jTQKwgZ3pYrSUS6d355iE28TzW3ZttBGnAQ7gBSiZqA7YXeLSPmarVJAYeUUPIVN9ZAzUGXOmiKAIy9V47Uid52x51JtLCEI2qFLMvgvLwAYRIq+g4RnQmZCCh9sa57ruw47JnVvgigM/zcWY2AIS2+RPR7kkQpRKT/W6sIrqwLxHavi0Pbtdl8hfZUN+Vo4PGdNX0bvQ/9bGCL6h8XMVQivHwdebB5IVPQnmA==;5:lC5Vy7B6lVIbCf6txqyItPyupMovWm8j7LHgJdM56yelfGZ5I2dLkwkabGHzvymhuGnpyHsH1kdqj5dM/Jgp18mBm5SVqb0yksASO/VNAIBnDN2dS9TryD/4isrhfunk4rPKHSFN/MaDgrzmDeRS0vmIxC+kDXZLtSusQu61YuM=;7:PDSe0Lmw0Hz9NIQQsK6thIqkIKafqvXP4AS/aMZyrGoUOOqbaRdGoZ3+ha0gVn3PUGMaS8LFlGmZ1LYAww9gzYCaI4q0qc634pWOTN/ZzUEJS6NnJ17mxUB99ZrZegD9kz6a7aW6tsHf23XneGWVLQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 86e05a59-c744-42c1-4599-08d665b43f2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3437;
x-ms-traffictypediagnostic: VI1PR0402MB3437:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR0402MB34375EF3DCA33352168F57DEF9BE0@VI1PR0402MB3437.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3437;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3437;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(6512007)(575784001)(305945005)(2616005)(8936002)(7736002)(6246003)(6116002)(2501003)(476003)(25786009)(36756003)(102836004)(5660300001)(8676002)(11346002)(446003)(81156014)(81166006)(66066001)(118296001)(14454004)(4326008)(6506007)(4001150100001)(53936002)(229853002)(44832011)(6436002)(110136005)(71200400001)(71190400001)(3846002)(106356001)(76176011)(316002)(2906002)(105586002)(26005)(478600001)(6486002)(99286004)(486006)(256004)(97736004)(186003)(86362001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3437;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J0fLj8aB+RYBHLr3zeQ691Y3o3jfux7NoHIKHKBxxli6sl1O6XjCEJQ/rPtoiEwJo5NUWsY59q2g6USDgGH1uNeIKs5pxrKByJRnRuQ7rWAyqIh2Mf0au/oC0w/eLGyKvxbd4YECgV+kENJj22YXeEeD2VBAicxEqiPoIJ3ge/TxAo4zDDtAf5TcaNL7yd9KfNnAdSr7b+/aKSmDIo76JZCbOQXPvDmwBa0a7INR11S9wFCMHVrCCcs3KjCZDblSrahM6wqUFlMC9b78HjHNpdVWX+Y98lpz1bW/m4fUF4xSF93K6isWNZxBnGZxzrIa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <034BDCE48DE72D408E5BCF0A0D6ED83F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e05a59-c744-42c1-4599-08d665b43f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 13:16:54.7014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMTgtMTItMTkgYXQgMTI6NDIgKzAwMDAsIE1hcmNlbCBaaXN3aWxlciB3cm90
ZToNCj4gSGkgdGhlcmUNCj4gDQo+IEkgbm90aWNlZCB0aGF0IGF0IGxlYXN0IHRvZGF5J3MgYW5k
IHllc3RlcmRheXMgLW5leHQgd29uJ3QgYnVpbGQgd2l0aA0KPiB0aGUgaW14X3Y2X3Y3X2RlZmNv
bmZpZyBnaXZpbmcgdGhlIGZvbGxvd2luZyBlcnJvcjoNCj4gDQo+ICAgTEQgICAgICBhcmNoL2Fy
bS9ib290L2NvbXByZXNzZWQvdm1saW51eA0KPiBhcmNoL2FybS9ib290L2NvbXByZXNzZWQvaGVh
ZC5vOiBJbiBmdW5jdGlvbiBgcmVzdGFydCc6DQo+ICgudGV4dCsweGE4KTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgX19oeXBfc3R1Yl92ZWN0b3JzJw0KPiAoLnRleHQrMHhhYyk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYF9faHlwX3N0dWJfdmVjdG9ycycNCj4gDQo+IEhhcyBhbnlib2R5IHNl
ZW4gdGhhdCBhcyB3ZWxsIGFuZCBrbm93cyB3aGF0IGlzIGdvaW5nIG9uPw0KDQpIbW0sIHdvcmtz
IGZvciBtZS4NCg0KVXNpbmcgbGludXgtbmV4dCwgbWFzdGVyIGJyYW5jaC4gSEVBRCBjb21taXQ6
DQoNCmNvbW1pdCAwMmZjMTY5NTk0ZTk2ZjdjNTFjNGYyMzExNGUxMmI3YTE4ZTg1YTBhIChIRUFE
IC0+IG1hc3RlciwgdGFnOg0KbmV4dC0yMDE4MTIxOSwgb3JpZ2luL21hc3Rlciwgb3JpZ2luL0hF
QUQpDQpBdXRob3I6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3JnLmF1Pg0KRGF0
ZTogICBXZWQgRGVjIDE5IDE4OjQyOjQ2IDIwMTggKzExMDANCg0KICAgIEFkZCBsaW51eC1uZXh0
IHNwZWNpZmljIGZpbGVzIGZvciAyMDE4MTIxOQ0KICAgIA0KICAgIFNpZ25lZC1vZmYtYnk6IFN0
ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3JnLmF1Pg0KDQoNClVzaW5nIGdjYyB2ZXJz
aW9uIDcuMy4wIChHQ0MpLg0K
