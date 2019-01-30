Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3974BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AA22184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktIo+OeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfA3NMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:12:31 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:48780
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfA3NMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8BbTiEmfTjgib/yt8bvr/LhNAB7SHb796LPPgcvNzw=;
 b=ktIo+OeLQERBFiQFrPt1XgfmJ8ikNp2wjN6rf4SBNCrdCVI65N9uTVevvVnbOlbxU/dO9W4nyU99CSthE+YORix8LroQk0Clqx48iaI/T6SSU1IVUc/OO8SH4N16h+I04Frr7T1voxKVLBHW8Sa6YSlXxv62BUHHd4hakMkxrOE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3325.eurprd04.prod.outlook.com (52.134.7.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 13:12:25 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:12:25 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "dongas86@gmail.com" <dongas86@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] firmware: imx: Add support to start/stop a CPU
Thread-Topic: [PATCH v2] firmware: imx: Add support to start/stop a CPU
Thread-Index: AQHUuIJIb5ERbmz8Z0ilGZjHtOs21aXHwqaAgAAHN4A=
Date:   Wed, 30 Jan 2019 13:12:25 +0000
Message-ID: <fc0ef2f1709cb678f29cd37d618e28a7ed606791.camel@nxp.com>
References: <20190130095749.8952-1-daniel.baluta@nxp.com>
         <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
In-Reply-To: <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3325;6:POv9+r9GP0ezFLNDHwGpagrpkaB0L7rxtDjHoxM0eGXQ6qDwioi3g69LADfLN+O0PO6bV0XZ7ZkyVxik/NcMxnDgTqML2rmlLa8CmVTVyKweA5DJMz2WmLyPw86HZ9QQ/iMVIlzKTw/exV9kLoWImRDoU2xNjAHd4cglyqF7oMaOQJXUZomW4OSQG2XHVhLj3xGKO8GQeshFQEmW8JuyykMeCfR9GhWhegqia2hZnl35pEcOy6q6DromUOO2HOyVz12pCQkhIQR5tNAgfeNLPyOVBJ+vnqn//YmCxHi2a8JIubbMoCqGjwGegGTjS9s+8ta19bfjrIX7fLQC4b6zN70nz4wmJzQH12Duq/wRL5uOe4/WOH4lyEIgaA8GkwBfM+f8NocS2q+eguwL2RiQz29dY2UZtqtt3NfQTek2DlRmAS2p50YBl3yRZOqA53iMrKLqdW8GeAjKyj2MThxVzQ==;5:n3XpJldxLDXSxGhfrHmPO71P3XwWrtEd0SuRkUywTl3nyQuj+oLEQXOkMPFn6dIX4m0CPblHSJ6+rA5qXH28x411uRNAIew9o99IYztxodpSRqaM0g/WLCn9BBTsQr5EU6y0oCA8DZQljDf5mWk2iQOtSLW1BzzrQDAxXWIpTLnNfjpREzou/s0NJMx+87Qax/TFWsFGDWY1p/CDjpszDA==;7:mrTcdnD/zSP/w/deay3Zal2IEC3K78CErWD0teqc2xzPtOjmsrrDEErHi+tQqt7ZG6ngcl+M4zvgQRbsqTWoaPvZ9vhkM1b0hQa/QByp4eJrVJVRkwcio+iIT81um2RmM/jLicV4Lz+o4ADs9rHAhw==
x-ms-office365-filtering-correlation-id: 8d1b9f81-e9cc-411d-53f5-08d686b49447
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3325;
x-ms-traffictypediagnostic: VI1PR0402MB3325:
x-microsoft-antispam-prvs: <VI1PR0402MB332578725EC593001CD36D57F9900@VI1PR0402MB3325.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(316002)(6116002)(3846002)(66066001)(6916009)(478600001)(39060400002)(81156014)(81166006)(486006)(54906003)(446003)(11346002)(2616005)(476003)(4326008)(25786009)(44832011)(5640700003)(106356001)(99286004)(2351001)(68736007)(6506007)(105586002)(186003)(7736002)(26005)(305945005)(102836004)(6512007)(97736004)(76176011)(8676002)(71190400001)(6486002)(71200400001)(6436002)(53936002)(14454004)(118296001)(1411001)(6246003)(8936002)(2906002)(1361003)(86362001)(256004)(229853002)(36756003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3325;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TOdKSgblq4bpmqRDd0CcHw7BQLC5ldDF2d2PIGAmihD6i5nJdsA8aB8gLaHHW7w8BRGFSeKksrOd3QDyo4WvIC65nMnl9f20+V4QmfTPzlRQSeH/XJsxxdaLGCfiamyW3KGB9DtZAFsItiSPgVOxeNjx6RB6536Fm8ar/L2yAScoVpnnoWoSHmG03xhHGcBd2/sSU5URDv6pC4qRA+x2rpGQOU4IAD/ct9ZSghM1mbWTCffTmCtxQOa0/7to6jD9FAr4B0BPrDFCOWLwi/Cjm+wcclUwasg6iFkUp6JxX0ZQJNhZdC92qes42/+PO4k8x4za1RtsE+nARjKaqhvupfXZqZrVJrmvPypjjldn+jUNm7mPmw7pSxM3HSE98BVOLF6MjPhBw5wvIKZm31k3wy/2ITn6e4e0uKz6fE/XwvA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A7123B49DE5604F812E02A28FED717D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1b9f81-e9cc-411d-53f5-08d686b49447
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:12:25.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFpc2hlbmcgZm9yIHRoZSBjb21tZW50cyENCg0KPHNuaXA+DQoNCitpbnQgaW14X3Nj
X3BtX2NwdV9zdGFydChzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1MzIgcmVzb3VyY2UsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBlbmFibGUsIHU2NCBhZGRyZXNzKQ0KPiA+ICt7
DQo+ID4gKyAgICAgICBzdHJ1Y3QgaW14X3NjX21zZ19yZXFfY3B1X3N0YXJ0IG1zZzsNCj4gPiAr
ICAgICAgIHN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gKw0KPiA+
ICsgICAgICAgaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ID4gKyAgICAgICBoZHIt
PnN2YyA9ICh1aW50OF90KUlNWF9TQ19SUENfU1ZDX1BNOw0KPiA+ICsgICAgICAgaGRyLT5mdW5j
ID0gKHVpbnQ4X3QpSU1YX1NDX1BNX0ZVTkNfQ1BVX1NUQVJUOw0KPiANCj4gcGxzIGRyb3AgdGhl
IHVubmVjY2VzYXJ5IHVuaXQ4X3QNCg0KT2ssIEkgY2FuIGRvIHRoYXQuIEkgaGFkIGJvcnJvd2Vk
IGl0IGZyb20gdGhlIGFscmVhZHkgZXhpc3RpbmcNCmZ1bmN0aW9ucyBpbXhfc2NfbWlzY19nZXRf
Y29udHJvbCAvIGlteF9zY19taXNjX3NldF9jb250cm9sDQoNCj4gDQo+ID4gKyAgICAgICBoZHIt
PnNpemUgPSA0Ow0KPiA+ICsNCj4gPiArICAgICAgIG1zZy5hZGRyZXNzX2hpID0gYWRkcmVzcyA+
PiAzMjsNCj4gPiArICAgICAgIG1zZy5hZGRyZXNzX2xvID0gYWRkcmVzczsNCj4gPiArICAgICAg
IG1zZy5yZXNvdXJjZSA9IHJlc291cmNlOw0KPiA+ICsgICAgICAgbXNnLmVuYWJsZSA9IGVuYWJs
ZTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gaW14X3NjdV9jYWxsX3JwYyhpcGMsICZtc2cs
IGZhbHNlKTsNCj4gDQo+IHMvZmFsc2UvdHJ1ZQ0KDQpOaWNlIGNhdGNoIQ0KDQpJbmRlZCwgdGhl
IG9sZCBBUEkgaGFkIGEgZGlmZmVyZW50IHNlbWFudGljIGZvciB0aGlzIHBhcmFtZXRlci4NCj4g
DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChpbXhfc2NfcG1fY3B1X3N0YXJ0KTsNCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaA0KPiA+IGIv
aW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaA0KPiA+IGluZGV4IGUyMWM0OWFi
YTkyZi4uYzAzYmYyYTIzYWRkIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdh
cmUvaW14L3N2Yy9taXNjLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9z
dmMvbWlzYy5oDQo+ID4gQEAgLTUyLDQgKzUyLDcgQEAgaW50IGlteF9zY19taXNjX3NldF9jb250
cm9sKHN0cnVjdCBpbXhfc2NfaXBjDQo+ID4gKmlwYywgdTMyIHJlc291cmNlLA0KPiA+ICBpbnQg
aW14X3NjX21pc2NfZ2V0X2NvbnRyb2woc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTMyIHJlc291
cmNlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBjdHJsLCB1MzIgKnZhbCk7
DQo+ID4gDQo+ID4gK2ludCBpbXhfc2NfcG1fY3B1X3N0YXJ0KHN0cnVjdCBpbXhfc2NfaXBjICpp
cGMsIHUzMiByZXNvdXJjZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBib29sIGVuYWJs
ZSwgdTY0IGFkZHJlc3MpOw0KPiANCj4gTml0cGljazogcGh5X2FkZHINCg0KT2ssIHdpbGwgZml4
Lg0KDQoNCg==
