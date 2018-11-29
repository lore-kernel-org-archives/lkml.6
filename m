Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8013FC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA8420868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="max9JNWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA8420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeK2SvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:51:13 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:36960
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726639AbeK2SvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXZZi0ISrC9FY9YqcFzNmFDgDqLz4nRqBfLr4mz04Ls=;
 b=max9JNWf85h8f3kxg0SONM3TEYw0ea3/09deTxXPUGHFQILrtsZ52ITYjN+CTakTK4Ob+qB8EgNDpHmYyBSDVggJ4eVJiNtxkN/8uoFqlerypfjlpRayhCKKQXHwQyvKLNL/pZ4xW1FUXIDWYnneGz4klrnPnkscCA739FGbrqA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5876.eurprd04.prod.outlook.com (20.178.202.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 29 Nov 2018 07:46:41 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 07:46:41 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v13 0/5] Add i.MX8MQ clock driver
Thread-Topic: [PATCH v13 0/5] Add i.MX8MQ clock driver
Thread-Index: AQHUe2y3mzPT6ZN6ckOdG5IYTodpUqVmAcUAgAB0pjA=
Date:   Thu, 29 Nov 2018 07:46:41 +0000
Message-ID: <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
 <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
In-Reply-To: <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5876;6:G6f8wlWtAK5LYIcicZl4aeklJ+aH7mXfReujAgOoBSKWe6t83IfyyGC9aXVhqd7Qz8SgFbsybHHkjiZhYXXw1PZ3jeqNPiplJV8pu+gG89Hb5S6KJWtprcrt6gxVPZ0JdFqC0qVAcMwlMzfi2xwOHNFuHUBAsP+Bwcw7/xikfr8EVM7B+ipASj7ijLuJMHWYolCdcCgVrnJxMTCo3r0VLUjEJ4cUtdwTHtKf1B1yez4CNfoswXQbx+KENGM5JK0STrIV4td3yis10prVhTYDzKU5MGqBxBvV+eBBZRsXtxBz6+U3iEfZsXBUQ0gW5SJsVYUmYbac8uoq3uL+phBZml7uTxxozO/piOK/oy9m8fRNEZKRz8vaSdmVMHUwwXUZfz4EQlHcE6jdHiFpyNVqzsFCAwQoNn3zD5qIp20mqVVYyGnpdbeSR4WVdNwn0PdVF/1HYc7a/Y+PAyVzotfKdA==;5:tMFJEQd9+UHC3sIXzyeiLBeAJBVMTufEjXi0mQCD678USfnf1yo4DVBRlTTy/hN1by2uS7jQGrbKCTxh+KzCGndHGgF9sAxM6IcFOeCQcvFX1a8umnV1vSev2gXrQthxHadLZHsG9KpRuNDXrqoDtpoFNFKjVp5YG0LCDZ6R1Fc=;7:DpjC69Cr8VxHRp7Dmhbu9M6ZJvPip77Mrzh5875RHp3nmVS4i1uzfGMb5O/RKGo6jL8U+0DZMCih0WUHHDjkNLDRw4sih0IpCVWP3Sdxs+TIL6BEL3nqzaUbxkXIjLs1kmWZpehIG6PjkJNkj4Ckqg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d359694-5cef-40cf-170e-08d655cecd2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5876;
x-ms-traffictypediagnostic: AM0PR04MB5876:
x-microsoft-antispam-prvs: <AM0PR04MB58760AFF5CC3282B91B3299B80D20@AM0PR04MB5876.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5876;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5876;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(13464003)(199004)(189003)(3846002)(74316002)(5660300001)(11346002)(446003)(229853002)(71200400001)(476003)(71190400001)(8936002)(99286004)(53936002)(110136005)(54906003)(86362001)(97736004)(256004)(486006)(478600001)(6436002)(25786009)(6506007)(7736002)(26005)(68736007)(76176011)(33656002)(7696005)(2906002)(102836004)(6116002)(14454004)(9686003)(8676002)(66066001)(305945005)(106356001)(186003)(105586002)(6246003)(81166006)(7416002)(4326008)(316002)(81156014)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5876;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r8QzoCE6Fh5+eqUVV4vkEje4Q14Q0vepePktpHlAhvag7ITi613ElbAVKRNsb637xudX5lGVAtIDv7YSarCw/d4RAUxSjpBipc9RZC52AswC59KG6aK74GqXBkjVHQ7Zu9ZYQA6cYm7Aftpg8ZgrgNPY8EU9+ciFxucKTXBi7TSqiB68iNrWmKBQpgXmItd/XwWgc5CfAWVbavVtaxVsgzU8JiLZw+bB/2AJav8+/Xq0EIIoLbGJ/QmVcIaTefTqFDctEx/sAVraR8cxh0oPSfempVsVNse6LXHL7fR6NL4O4CiTTXyZ7GOo9ZD+ucJwBsj2Gxz6iUMcgeyEWZw1i71sBoxox5yheEEeh35WL84=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d359694-5cef-40cf-170e-08d655cecd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 07:46:41.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0
bzpzYm95ZEBrZXJuZWwub3JnXQ0KWy4uLl0NCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjEyOg0K
PiA+ICAqIHJlcGxhY2VkIHRoZSBkaXZpc2lvbiBpbiBjbGtfcGxsX3JlY2FsY19yYXRlIGluIGNs
ay1mcmFjDQo+ID4gICAgd2l0aCBkb19kaXYgYXMgc3VnZ2VzdGVkIGJ5IFN0ZXBoZW4NCj4gPg0K
PiA+IEFiZWwgVmVzYSAoMik6DQo+ID4gICBjbGs6IGlteDogQWRkIGlteCBjb21wb3NpdGUgY2xv
Y2sNCj4gPiAgIGNsazogaW14OiBBZGQgY2xvY2sgZHJpdmVyIGZvciBpLk1YOE1RIENDTQ0KPiA+
DQo+ID4gTHVjYXMgU3RhY2ggKDMpOg0KPiA+ICAgZHQtYmluZGluZ3M6IGFkZCBiaW5kaW5nIGZv
ciBpLk1YOE1RIENDTQ0KPiA+ICAgY2xrOiBpbXg6IGFkZCBmcmFjdGlvbmFsIFBMTCBvdXRwdXQg
Y2xvY2sNCj4gPiAgIGNsazogaW14OiBBZGQgU0NDRyBQTEwgdHlwZQ0KPiA+DQo+IA0KPiBJIGhh
ZCB0byBhcHBseSB0aGlzIHNldCBvZiBmaXhlcyB0byBzaWxlbmNlIHNwYXJzZSBhbmQgc21hdGNo
IHdhcm5pbmdzIGFib3V0DQo+IHRoaW5ncyB0aGF0IGFyZSBub3QgcmlnaHQuIFBsZWFzZSB0YWtl
IGEgbG9vayBvdmVyIHRoaW5ncyBhbmQgc2VlIGlmIGl0J3Mgc2FuZS4NCj4gDQoNClRoZSBjaGFu
Z2UgbG9va3MgZ29vZCB0byBtZSBhbmQgdGVzdGVkIG9rLg0KSSBkaWQgbm90IHNlZSB0aGlzIHBh
dGNoIHNlcmllcyBpbiB5b3VyIHRyZWUuDQpEbyB5b3Ugd2FudCB1cyB0byBhcHBseSB5b3VyIGNo
YW5nZXMgYW5kIHJlLXNlbmQgZm9yIGVhc3kgcGljayB1cD8NCg0KUmVnYXJkcw0KRG9uZyBBaXNo
ZW5nDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMN
Cj4gYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS04bS5jDQo+IGluZGV4IGJjZDMxZDg4
OTU4NC4uNmQ5ZDM3MTRiNGRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWNv
bXBvc2l0ZS04bS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMN
Cj4gQEAgLTEyNyw4ICsxMjcsOCBAQCBzdHJ1Y3QgY2xrICppbXg4bV9jbGtfY29tcG9zaXRlX2Zs
YWdzKGNvbnN0IGNoYXINCj4gKm5hbWUsDQo+ICAJCQkJCWludCBudW1fcGFyZW50cywgdm9pZCBf
X2lvbWVtICpyZWcsDQo+ICAJCQkJCXVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ICB7DQo+IC0Jc3Ry
dWN0IGNsa19odyAqaHcgPSBOVUxMLCAqbXV4X2h3ID0gTlVMTDsNCj4gLQlzdHJ1Y3QgY2xrX2h3
ICpkaXZfaHcgPSBOVUxMLCAqZ2F0ZV9odyA9IE5VTEw7DQo+ICsJc3RydWN0IGNsa19odyAqaHcg
PSBFUlJfUFRSKC1FTk9NRU0pLCAqbXV4X2h3Ow0KPiArCXN0cnVjdCBjbGtfaHcgKmRpdl9odywg
KmdhdGVfaHc7DQo+ICAJc3RydWN0IGNsa19kaXZpZGVyICpkaXYgPSBOVUxMOw0KPiAgCXN0cnVj
dCBjbGtfZ2F0ZSAqZ2F0ZSA9IE5VTEw7DQo+ICAJc3RydWN0IGNsa19tdXggKm11eCA9IE5VTEw7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWZyYWMtcGxsLmMgYi9kcml2ZXJz
L2Nsay9pbXgvY2xrLWZyYWMtcGxsLmMgaW5kZXgNCj4gYTM3MzJiZTVhZDdmLi45ODcyNjIwNmYz
YzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstZnJhYy1wbGwuYw0KPiArKysg
Yi9kcml2ZXJzL2Nsay9pbXgvY2xrLWZyYWMtcGxsLmMNCj4gQEAgLTE0LDYgKzE0LDggQEANCj4g
ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4N
Cj4gDQo+ICsjaW5jbHVkZSAiY2xrLmgiDQo+ICsNCj4gICNkZWZpbmUgUExMX0NGRzAJCTB4MA0K
PiAgI2RlZmluZSBQTExfQ0ZHMQkJMHg0DQo+IA0KPiBAQCAtMjE0LDcgKzIxNiw3IEBAIHN0cnVj
dCBjbGsgKmlteF9jbGtfZnJhY19wbGwoY29uc3QgY2hhciAqbmFtZSwgY29uc3QNCj4gY2hhciAq
cGFyZW50X25hbWUsDQo+ICAJcmV0ID0gY2xrX2h3X3JlZ2lzdGVyKE5VTEwsIGh3KTsNCj4gIAlp
ZiAocmV0KSB7DQo+ICAJCWtmcmVlKHBsbCk7DQo+IC0JCXJldHVybiBFUlJfQ0FTVChodyk7DQo+
ICsJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+ICAJfQ0KPiANCj4gIAlyZXR1cm4gaHctPmNsazsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstc2NjZy1wbGwuYyBiL2RyaXZlcnMv
Y2xrL2lteC9jbGstc2NjZy1wbGwuYyBpbmRleA0KPiA0NjY2Yjk2YmRiM2YuLmVlNzc1MmJhY2U4
OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1zY2NnLXBsbC5jDQo+ICsrKyBi
L2RyaXZlcnMvY2xrL2lteC9jbGstc2NjZy1wbGwuYw0KPiBAQCAtMjQ5LDcgKzI0OSw3IEBAIHN0
cnVjdCBjbGsgKmlteF9jbGtfc2NjZ19wbGwoY29uc3QgY2hhciAqbmFtZSwNCj4gIAlyZXQgPSBj
bGtfaHdfcmVnaXN0ZXIoTlVMTCwgaHcpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJa2ZyZWUocGxs
KTsNCj4gLQkJcmV0dXJuIEVSUl9DQVNUKGh3KTsNCj4gKwkJcmV0dXJuIEVSUl9QVFIocmV0KTsN
Cj4gIAl9DQo+IA0KPiAgCXJldHVybiBody0+Y2xrOw0K
