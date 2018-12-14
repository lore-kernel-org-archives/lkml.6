Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F67C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3894C20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AyjenLds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3894C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeLNKa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:30:59 -0500
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:27284
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeLNKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNAhomB5XcYeSH2MdbuLsXttyjihAAM1eQ51patOsjo=;
 b=AyjenLdsXt+PYY6m9xUmcPbmMMOKQRAKei6Li+ZcEm8IX69PNllh1gW81yff8xdLXDQD4t4IJdTBAJlVSoBKEOhcQPSJu9n3Xp50M2ADlVT2tLotfakq5vDPsopJPHlubYF50ablm5064mTioecSIJxiliGQkMpIyq6lJPsnXdk=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB4926.eurprd04.prod.outlook.com (20.177.49.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 10:30:15 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::9d3c:74fa:d05e:beca]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::9d3c:74fa:d05e:beca%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 10:30:15 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Peng Ma <peng.ma@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wen He <wen.he_1@nxp.com>
Subject: RE: [PATCH 3/3] arm64: dts: ls1046a: add qdma device tree nodes
Thread-Topic: [PATCH 3/3] arm64: dts: ls1046a: add qdma device tree nodes
Thread-Index: AQHUjVYSrxNojj0f00arK99KhqH/cKV+FFqA
Date:   Fri, 14 Dec 2018 10:30:15 +0000
Message-ID: <VI1PR04MB44313466C33A7BAD7167D4EEEDA10@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181206111823.45985-1-peng.ma@nxp.com>
 <20181206111823.45985-3-peng.ma@nxp.com>
In-Reply-To: <20181206111823.45985-3-peng.ma@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4926;6:YO45B84aRaPhiw49YB7pSEs1NPrgePPD3XbMCj7/SG38m/fDtrWTsMARlj2OV+pnb4OJ2A4vMNkepyK6CbvN0b2syHrRL4s3sA2LRnr8fad1bsq74PZIqq/IA+mFO+9g+fdBNBsNAk4ZhE0OJAE9sThQbLnQCzfBX5rvcUtnn5DQqBQfiYDEyLJx0tBOEotXB+Um8z1JfSgUDSxPvhvEizTxe3uVxBF6wE5hZpwXJO5FMVbiafsXL6rq47IeBoy6Ptqo3IofMtWIbRgD7nFiw0tOig41qUHnAAY9AL4OMMe/amAqkqVhaesPoGe0tavbOdEaXM1eebKWvfXTNeOF6/pkDiOgAVtzgl/QPqBCSoWzMnhxRKssOEAoBBXMD8omPp45TntkpJOEpFZkWCXIwHn1uGek0JSHy2RCSbKUs9+w/R3eSv8nppuldDPUZxKgw2BMUqtnfQGy0/64rBj2Aw==;5:HxBsKVZXizhXQMiCk9O2mj3XAwMGpxU2YGQ062fFPlUJxv+V5SmCrqkcn7YzudWjveHEnntModsiM53RY8hiLsC+3u7bIQuoiQ6FtR3BBNz9W34Oy7+mYgll8Gn/K5ZXL3vhSvQ/75ka6TtWMqrQ2gemx9g1lWE6N6Rf4ScM5YM=;7:7jKFLP4ULfhSm2l0OmWv9i0c7E4WOHgi1uJLAR0ZroBkhm8WyguTSBfhSky9ZinkBgawmByzV35LokxSljvya9S5HZJ2pu4UD9qyaOb+t9fCfUmEOBcACs3nt8pB7nmnMtkBEO03BW+YDzBFVMLPWg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: faa7969a-68f9-489a-3b53-08d661af2304
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4926;
x-ms-traffictypediagnostic: VI1PR04MB4926:
x-microsoft-antispam-prvs: <VI1PR04MB4926CE0893D29F9868A8F3ABEDA10@VI1PR04MB4926.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4926;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4926;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(13464003)(189003)(199004)(186003)(2201001)(66066001)(486006)(6436002)(26005)(2501003)(476003)(6506007)(102836004)(4326008)(71200400001)(86362001)(71190400001)(99286004)(446003)(5660300001)(68736007)(256004)(44832011)(76176011)(11346002)(105586002)(9686003)(54906003)(6306002)(81166006)(74316002)(8676002)(81156014)(305945005)(6116002)(8936002)(966005)(229853002)(7736002)(55016002)(106356001)(6246003)(33656002)(316002)(110136005)(14454004)(478600001)(25786009)(2906002)(53936002)(7696005)(3846002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4926;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vV7OO3SIT1e3vSAs5EP7LAjfFiCBWke6KVI5E0GJbAzl54/uw9XQmzHTCI8z/ihoPW3ILkaMu7H6yp+l123Hpok2ldRT3hAE0D+WAdq4u6jr0qb8X2Hd4Vd8zgcsd0Fxgnp3kgW3tDs5R7V2DXlyhICk621ia/eoiksrSZsjkKlXjK3KnMNLBu/3v8TEZd1Tu5FiVPNDWQdyFEqiPcqak8Bv/13zLcw1SqwuKVUr2jg7Scz8FMylRi1PpDGsz/QxkZCfTrHgObA2kirvm2dEwhCP3fn40auX8i3wD5TybpwKGILAxVC0ulfuMvs/TlmO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa7969a-68f9-489a-3b53-08d661af2304
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 10:30:15.3061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgc2hhd25ndW8sDQoNCkkgc2VuZCB0aGlzIHNlcmllcyBwYXRjaCB0byBodHRwOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC9kZXZpY2V0cmVlLWJpbmRpbmdzL2xpc3QvDQpCdXQgSSBk
aWQgbm90IGZpbmQgcGF0Y2hzIG9uIGRldmljZXRyZWUgcGF0Y2h3b3JrLCBjb3VsZCBJIHNlbmQg
cGF0Y2hzIGFnYWluLg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsIA0KUGVuZw0KPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPlNl
bnQ6IDIwMTjE6jEy1MI2yNUgMTk6MTgNCj5UbzogdmtvdWxAa2VybmVsLm9yZzsgc2hhd25ndW9A
a2VybmVsLm9yZw0KPkNjOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IHJvYmgrZHRAa2Vy
bmVsLm9yZzsNCj5tYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPmRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBQZW5nIE1hDQo+PHBlbmcubWFAbnhwLmNvbT47IFdlbiBIZSA8d2Vu
LmhlXzFAbnhwLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggMy8zXSBhcm02NDogZHRzOiBsczEwNDZh
OiBhZGQgcWRtYSBkZXZpY2UgdHJlZSBub2Rlcw0KPg0KPmFkZCB0aGUgcURNQSBkZXZpY2UgdHJl
ZSBub2RlcyBmb3IgTFMxMDQ2QSBkZXZpY2VzLg0KPg0KPlNpZ25lZC1vZmYtYnk6IFdlbiBIZSA8
d2VuLmhlXzFAbnhwLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBQZW5nIE1hIDxwZW5nLm1hQG54cC5j
b20+DQo+LS0tDQo+Y2hhbmdlIGluIHYxMjoNCj4JLSB1c2VkIEdJQ19TUEkgYW5kIElSUV9UWVBF
X0xFVkVMX0hJR0ggdG8gaW5zdGVhZCBpbW1lZGlhdGUNCj4JbnVtYmVyDQo+DQo+IGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kgfCAgIDIxDQo+KysrKysrKysr
KysrKysrKysrKysrDQo+IDEgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMCBkZWxl
dGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTA0NmEuZHRzaQ0KPmIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxz
MTA0NmEuZHRzaQ0KPmluZGV4IDUxY2JkNTAuLjhmY2NlNzkgMTAwNjQ0DQo+LS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEuZHRzaQ0KPisrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj5AQCAtNzA0LDYgKzcwNCwy
NyBAQA0KPiAJCQkJCTwwMDAwIDAgMCA0ICZnaWMgR0lDX1NQSSAxNTQNCj5JUlFfVFlQRV9MRVZF
TF9ISUdIPjsNCj4gCQl9Ow0KPg0KPisJCXFkbWE6IGRtYS1jb250cm9sbGVyQDgzODAwMDAgew0K
PisJCQljb21wYXRpYmxlID0gImZzbCxsczEwNDZhLXFkbWEiLCAiZnNsLGxzMTAyMWEtcWRtYSI7
DQo+KwkJCXJlZyA9IDwweDAgMHg4MzgwMDAwIDB4MCAweDEwMDA+LCAvKiBDb250cm9sbGVyIHJl
Z3MgKi8NCj4rCQkJICAgICAgPDB4MCAweDgzOTAwMDAgMHgwIDB4MTAwMDA+LCAvKiBTdGF0dXMg
cmVncyAqLw0KPisJCQkgICAgICA8MHgwIDB4ODNhMDAwMCAweDAgMHg0MDAwMD47IC8qIEJsb2Nr
IHJlZ3MgKi8NCj4rCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE1MyBJUlFfVFlQRV9MRVZFTF9I
SUdIPiwNCj4rCQkJCSAgICAgPEdJQ19TUEkgMzkgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+KwkJ
CQkgICAgIDxHSUNfU1BJIDQwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPisJCQkJICAgICA8R0lD
X1NQSSA0MSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4rCQkJCSAgICAgPEdJQ19TUEkgNDIgSVJR
X1RZUEVfTEVWRUxfSElHSD47DQo+KwkJCWludGVycnVwdC1uYW1lcyA9ICJxZG1hLWVycm9yIiwg
InFkbWEtcXVldWUwIiwNCj4rCQkJCSJxZG1hLXF1ZXVlMSIsICJxZG1hLXF1ZXVlMiIsICJxZG1h
LXF1ZXVlMyI7DQo+KwkJCWRtYS1jaGFubmVscyA9IDw4PjsNCj4rCQkJYmxvY2stbnVtYmVyID0g
PDE+Ow0KPisJCQlibG9jay1vZmZzZXQgPSA8MHgxMDAwMD47DQo+KwkJCWZzbCxkbWEtcXVldWVz
ID0gPDI+Ow0KPisJCQlzdGF0dXMtc2l6ZXMgPSA8NjQ+Ow0KPisJCQlxdWV1ZS1zaXplcyA9IDw2
NCA2ND47DQo+KwkJCWJpZy1lbmRpYW47DQo+KwkJfTsNCj4rDQo+IAl9Ow0KPg0KPiAJcmVzZXJ2
ZWQtbWVtb3J5IHsNCj4tLQ0KPjEuNy4xDQoNCg==
