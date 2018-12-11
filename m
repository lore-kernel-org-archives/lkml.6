Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7E5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C1F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oRQCThf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C1F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeLKEzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 23:55:38 -0500
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:17521
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbeLKEzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 23:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BfMAx6PXpB0A5xNDBv86W1+XdSzobCcMn4CBiRg7pc=;
 b=oRQCThf1lhpYMvuJJDJ4U33WwYPog+ZXF045k1DZaABWr8mSxhN9VuXcjZQoL2Xzr3nAzLmv6R2gmVXgbspT9N1R2g2E9MKuhK1V+1IRenarnkTsdG58ZycTqAMK7UdI/3e1QmcanfwzuhGENcFvpRPx9pNSFAD9xT2jUn9m508=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4525.eurprd04.prod.outlook.com (20.177.54.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 04:55:29 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 04:55:29 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuOuxIvwGhR/Ik2nR/UOeUIxtaV31PEAgAEp0pA=
Date:   Tue, 11 Dec 2018 04:55:29 +0000
Message-ID: <VI1PR04MB57264CBB25E2984DF221ED2E99A60@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
In-Reply-To: <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4525;6:jX4K3DIl7i+ryFAiUJ7yrbmbSryTlI5HhPZTI9mcFRrrsBXTqFH5PoovShQc3tS4qcdl6EZW/0ntpQ6AJJ3xRMJXBPj4ZnjPQ2PUyXJIP23//1c7JNwdnAskJv393Gg9W1buPjbDkwAu3MRlxlmnRFHnh8XSgIHNpUFUibyFQw9zkSKNnF01VAt3IfNx4GTLNriPJp7W6fGAyBzBumMSciwsD7vlvpeQMUeJ1Rm8oiXic9wsxq0ksubx/iLvaI4IZ016E9BbSQlc68cPWZM05XA+YijGFd9QbubauzcOxKo2P156zvO+U3+vSK2MDpQZbyXciOMxy+pL3z7OEpz5kTk7PgxvHJtowwBMTI2PcK85J2s3IuGNy5VelZjZlO4c1ZCJRiwjNXuPj3h3hqJbqWX5Q/yrdEXdp205E00g9pRvm5gm6V3+cS8rU6mVvMAwZNC39wTLULxheGDS56R9jg==;5:WC2sBNevdCKjeyxX5sm+8kljExc0wXtr9pTfhiK/w8YaA/ZT07qGefVXfxaNKczesoBQ02XaopNBt4tp5pNpgvYSYS5+vhpxyqQEGlakle9k5ZqdrbhDM0i8/FVV/EazISnws98RTu2B2ofjCk0Q77zcun3Nd35SIsXx/+//mps=;7:e9lik8B49/T5mgFphSabN6RYKDlfKFuY4UfG5ZwsgRGJ9lOhN4nTcBZUmIZ1ZDfl0FeX3MxnIX+XmozsRTvAjWJKntMrspoJ6E7rBrlfZ1Y8/dlOq0Ty66V0Vmy0OpdXw5K4r66jcgMbhg9mL5OUKg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b355acb3-f00f-4970-9310-08d65f24dfba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4525;
x-ms-traffictypediagnostic: VI1PR04MB4525:
x-microsoft-antispam-prvs: <VI1PR04MB452519F15B045214F179DF9199A60@VI1PR04MB4525.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4525;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4525;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(13464003)(2501003)(3846002)(486006)(2906002)(7736002)(53936002)(7696005)(229853002)(6116002)(66066001)(5660300001)(81156014)(97736004)(33656002)(8936002)(6246003)(6436002)(78486014)(8676002)(102836004)(71200400001)(71190400001)(76176011)(55236004)(256004)(6506007)(74316002)(99286004)(53546011)(316002)(55016002)(26005)(105586002)(9686003)(305945005)(81166006)(106356001)(7416002)(68736007)(54906003)(39060400002)(11346002)(4326008)(478600001)(476003)(446003)(110136005)(2201001)(14454004)(25786009)(186003)(86362001)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4525;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F4FB3+0v0VRN5xxO8/mZkmJjjoSA4wykLF9QIgUgFdfR6k1fGWkrjLxmLQngYa6CsPSmVMrdHApkD0GNyZCLb+7sd0fWqhos149H3iEoUmjdtztl8EpivF9pyC7yPXnzEHvUKGKr1ukS9n5g1OgogBLBdrGRSPet7GSptY1hEKpExTOnn/qhYz3RVitcEHA60pdX35zaGVH1Sbyo3hxr3qp7HH3DRN+3A1v5rRiglumKG/mQICB8y7B9brBcUf+5A/wDFt36ozd3lBpns6i423r3Zq+TlptmpEULglxcrVJqPMRmr5dMFUC2kB1XeXZD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b355acb3-f00f-4970-9310-08d65f24dfba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 04:55:29.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIFttYWlsdG86VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29t
XQ0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDEwLCAyMDE4IDQ6MTUgUE0NCj4gVG86IFlvZ2Vz
aCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsgbGludXgtDQo+IG10
ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb207IGJyb29u
aWVAa2VybmVsLm9yZzsNCj4gbWFyZWsudmFzdXRAZ21haWwuY29tOyB2aWduZXNockB0aS5jb207
IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBsaW51eC0NCj4gYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBjb21w
dXRlcnNmb3JwZWFjZUBnbWFpbC5jb207DQo+IGZyaWVkZXIuc2NocmVtcGZAZXhjZWV0LmRlOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy83
XSBtdGQ6IHNwaS1ub3I6IGFkZCBvcGNvZGVzIGZvciBvY3RhbCBSZWFkL1dyaXRlDQo+IGNvbW1h
bmRzDQo+IA0KPiBIaSwgWW9nZXNoLA0KPiANCj4gT24gMTIvMDMvMjAxOCAxMDozOSBBTSwgWW9n
ZXNoIE5hcmF5YW4gR2F1ciB3cm90ZToNCj4gPiAtIEFkZCBvcGNvZGVzIGZvciBvY3RhbCBJL08g
Y29tbWFuZHMNCj4gPiAgICogUmVhZCAgOiAxLTEtOCBhbmQgMS04LTggcHJvdG9jb2wNCj4gPiAg
ICogV3JpdGUgOiAxLTEtOCBhbmQgMS04LTggcHJvdG9jb2wNCj4gPiAgICogb3Bjb2RlcyBmb3Ig
NC1ieXRlIGFkZHJlc3MgbW9kZSBjb21tYW5kDQo+ID4NCj4gPiAtIEVudHJ5IG9mIG1hY3JvcyBp
biBfY29udmVydF8zdG80X3h4eCBmdW5jdGlvbg0KPiA+DQo+ID4gLSBBZGQgZmxhZyBzcGVjaWZ5
aW5nIGZsYXNoIHN1cHBvcnQgb2N0YWwgcmVhZCBjb21tYW5kcy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFZpZ25lc2ggUiA8dmlnbmVzaHJAdGkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlv
Z2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFu
Z2VzIGZvciB2NToNCj4gPiAtIE1vZGlmaWVkIHN0cmluZyAnb2N0bycgd2l0aCAnb2N0YWwnLg0K
PiA+IENoYW5nZXMgZm9yIHY0Og0KPiA+IC0gTm9uZQ0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+
IC0gTW9kaWZpZWQgc3RyaW5nICdvY3RhbCcgd2l0aCAnb2N0bycuDQo+ID4gQ2hhbmdlcyBmb3Ig
djI6DQo+ID4gLSBJbmNvcnBvcmF0ZWQgcmV2aWV3IGNvbW1lbnRzIG9mIEJvcmlzIGFuZCBWaWdu
ZXNoDQo+ID4NCj4gPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAxNiArKysrKysr
KysrKysrKy0tDQo+ID4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCAgIHwgIDggKysrKysr
KysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+
ID4gYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBpbmRleCAzOThkMjczLi43YTIxNzZk
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ID4gKysr
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gPiBAQCAtOTAsNiArOTAsNyBAQCBz
dHJ1Y3QgZmxhc2hfaW5mbyB7DQo+ID4gICNkZWZpbmUgTk9fQ0hJUF9FUkFTRQkJQklUKDEyKSAv
KiBDaGlwIGRvZXMgbm90IHN1cHBvcnQgY2hpcA0KPiBlcmFzZSAqLw0KPiA+ICAjZGVmaW5lIFNQ
SV9OT1JfU0tJUF9TRkRQCUJJVCgxMykJLyogU2tpcCBwYXJzaW5nIG9mIFNGRFAgdGFibGVzICov
DQo+ID4gICNkZWZpbmUgVVNFX0NMU1IJCUJJVCgxNCkJLyogdXNlIENMU1IgY29tbWFuZCAqLw0K
PiA+ICsjZGVmaW5lIFNQSV9OT1JfT0NUQUxfUkVBRAlCSVQoMTUpCS8qIEZsYXNoIHN1cHBvcnRz
IE9jdGFsIFJlYWQgKi8NCj4gPg0KPiA+ICAJaW50CSgqcXVhZF9lbmFibGUpKHN0cnVjdCBzcGlf
bm9yICpub3IpOw0KPiA+ICB9Ow0KPiA+IEBAIC0yMDksNiArMjEwLDggQEAgc3RhdGljIGlubGlu
ZSB1OCBzcGlfbm9yX2NvbnZlcnRfM3RvNF9yZWFkKHU4IG9wY29kZSkNCj4gPiAgCQl7IFNQSU5P
Ul9PUF9SRUFEXzFfMl8yLAlTUElOT1JfT1BfUkVBRF8xXzJfMl80QiB9LA0KPiA+ICAJCXsgU1BJ
Tk9SX09QX1JFQURfMV8xXzQsCVNQSU5PUl9PUF9SRUFEXzFfMV80XzRCIH0sDQo+ID4gIAkJeyBT
UElOT1JfT1BfUkVBRF8xXzRfNCwJU1BJTk9SX09QX1JFQURfMV80XzRfNEIgfSwNCj4gPiArCQl7
IFNQSU5PUl9PUF9SRUFEXzFfMV84LAlTUElOT1JfT1BfUkVBRF8xXzFfOF80QiB9LA0KPiA+ICsJ
CXsgU1BJTk9SX09QX1JFQURfMV84XzgsCVNQSU5PUl9PUF9SRUFEXzFfOF84XzRCIH0sDQo+ID4N
Cj4gPiAgCQl7IFNQSU5PUl9PUF9SRUFEXzFfMV8xX0RUUiwNCj4gCVNQSU5PUl9PUF9SRUFEXzFf
MV8xX0RUUl80QiB9LA0KPiA+ICAJCXsgU1BJTk9SX09QX1JFQURfMV8yXzJfRFRSLA0KPiAJU1BJ
Tk9SX09QX1JFQURfMV8yXzJfRFRSXzRCIH0sDQo+ID4gQEAgLTIyNSw2ICsyMjgsOCBAQCBzdGF0
aWMgaW5saW5lIHU4IHNwaV9ub3JfY29udmVydF8zdG80X3Byb2dyYW0odTgNCj4gb3Bjb2RlKQ0K
PiA+ICAJCXsgU1BJTk9SX09QX1BQLAkJU1BJTk9SX09QX1BQXzRCIH0sDQo+ID4gIAkJeyBTUElO
T1JfT1BfUFBfMV8xXzQsCVNQSU5PUl9PUF9QUF8xXzFfNF80QiB9LA0KPiA+ICAJCXsgU1BJTk9S
X09QX1BQXzFfNF80LAlTUElOT1JfT1BfUFBfMV80XzRfNEIgfSwNCj4gPiArCQl7IFNQSU5PUl9P
UF9QUF8xXzFfOCwJU1BJTk9SX09QX1BQXzFfMV84XzRCIH0sDQo+ID4gKwkJeyBTUElOT1JfT1Bf
UFBfMV84XzgsCVNQSU5PUl9PUF9QUF8xXzhfOF80QiB9LA0KPiA+ICAJfTsNCj4gPg0KPiA+ICAJ
cmV0dXJuIHNwaV9ub3JfY29udmVydF9vcGNvZGUob3Bjb2RlLCBzcGlfbm9yXzN0bzRfcHJvZ3Jh
bSwgQEANCj4gPiAtMjA5Myw3ICsyMDk4LDcgQEAgZW51bSBzcGlfbm9yX3JlYWRfY29tbWFuZF9p
bmRleCB7DQo+ID4gIAlTTk9SX0NNRF9SRUFEXzRfNF80LA0KPiA+ICAJU05PUl9DTURfUkVBRF8x
XzRfNF9EVFIsDQo+ID4NCj4gPiAtCS8qIE9jdG8gU1BJICovDQo+ID4gKwkvKiBPY3RhbCBTUEkg
Ki8NCj4gPiAgCVNOT1JfQ01EX1JFQURfMV8xXzgsDQo+ID4gIAlTTk9SX0NNRF9SRUFEXzFfOF84
LA0KPiA+ICAJU05PUl9DTURfUkVBRF84XzhfOCwNCj4gPiBAQCAtMjExMCw3ICsyMTE1LDcgQEAg
ZW51bSBzcGlfbm9yX3BwX2NvbW1hbmRfaW5kZXggew0KPiA+ICAJU05PUl9DTURfUFBfMV80XzQs
DQo+ID4gIAlTTk9SX0NNRF9QUF80XzRfNCwNCj4gPg0KPiA+IC0JLyogT2N0byBTUEkgKi8NCj4g
PiArCS8qIE9jdGFsIFNQSSAqLw0KPiA+ICAJU05PUl9DTURfUFBfMV8xXzgsDQo+ID4gIAlTTk9S
X0NNRF9QUF8xXzhfOCwNCj4gPiAgCVNOT1JfQ01EX1BQXzhfOF84LA0KPiA+IEBAIC0zMTk1LDYg
KzMyMDAsMTMgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9y
ICpub3IsDQo+ID4gIAkJCQkJICBTTk9SX1BST1RPXzFfMV80KTsNCj4gPiAgCX0NCj4gPg0KPiA+
ICsJaWYgKGluZm8tPmZsYWdzICYgU1BJX05PUl9PQ1RBTF9SRUFEKSB7DQo+ID4gKwkJcGFyYW1z
LT5od2NhcHMubWFzayB8PSBTTk9SX0hXQ0FQU19SRUFEXzFfMV84Ow0KPiA+ICsJCXNwaV9ub3Jf
c2V0X3JlYWRfc2V0dGluZ3MoJnBhcmFtcy0NCj4gPnJlYWRzW1NOT1JfQ01EX1JFQURfMV8xXzhd
LA0KPiA+ICsJCQkJCSAgMCwgOCwgU1BJTk9SX09QX1JFQURfMV8xXzgsDQo+ID4gKwkJCQkJICBT
Tk9SX1BST1RPXzFfMV84KTsNCj4gPiArCX0NCj4gPiArPiAgCS8qIFBhZ2UgUHJvZ3JhbSBzZXR0
aW5ncy4gKi8NCj4gPiAgCXBhcmFtcy0+aHdjYXBzLm1hc2sgfD0gU05PUl9IV0NBUFNfUFA7DQo+
ID4gIAlzcGlfbm9yX3NldF9wcF9zZXR0aW5ncygmcGFyYW1zLT5wYWdlX3Byb2dyYW1zW1NOT1Jf
Q01EX1BQXSwNCj4gDQo+IEF0IHRoZSBlbmQgb2Ygc3BpX25vcl9pbml0X3BhcmFtcyB3ZSBjaGVj
ayB0aGUgY29uZGl0aW9ucyBmb3IgcGFyc2luZyB0aGUgc2ZkcC4NCj4gU2hvdWxkbid0IFNQSV9O
T1JfT0NUQUxfUkVBRCB0cmlnZ2VyIHRoZSBzZmRwIHBhcnNpbmcgd2hlbg0KPiBTUElfTk9SX1NL
SVBfU0ZEUCBpcyBub3Qgc2V0Pw0KDQpJIGd1ZXNzIGZvciBub3cgc2V0dGluZyBvbmx5IFNQSV9O
T1JfT0NUQUxfUkVBRCBkaWRuJ3QgdHJpZ2dlciBTRkRQIHBhcnNpbmcgYXMgU0ZEUCBwYXJzaW5n
IHdvdWxkIHN0YXJ0IG9ubHkgd2hlbiB3ZSBoYXZlIGJvdGggb2YgdGhlIGJlbG93IGNvbmRpdGlv
biBhcmUgdHJ1ZQ0KICAgICAgICBpZiAoKGluZm8tPmZsYWdzICYgKFNQSV9OT1JfRFVBTF9SRUFE
IHwgU1BJX05PUl9RVUFEX1JFQUQpKSAmJg0KICAgICAgICAgICAgIShpbmZvLT5mbGFncyAmIFNQ
SV9OT1JfU0tJUF9TRkRQKSkgew0KQnV0IGZvciBjYXNlIHdoZW4gd2UgaGF2ZSBvbmx5IHNldCBT
UElfTk9SX09DVEFMX1JFQUQgdGhlbiBmaXJzdCBjb25kaXRpb24gY2hlY2sgd291bGQgYmUgZmFs
c2UgYW5kIGhlbmNlIFNGRFAgcGFyc2luZyB3b24ndCBvY2N1ci4NCg0KSSBndWVzcywgd2UgbmVl
ZG4ndCB0byBoYXZlIFNGRFAgcGFyc2luZyBvbmx5IHdoZW4gU1BJX05PUl9TS0lQX1NGRFAgaXMg
c2V0Lg0KVGh1cyB3b3VsZCBnb2luZyB0byBtb2RpZnkgdGhlIGNvbmRpdGlvbiBjaGVjayBhcyBi
ZWxvdywgc28gdGhhdCBTRkRQIHBhcnNpbmcgd291bGQgYWxzbyBiZSBwZXJmb3JtZWQgd2hlbiBT
UElfTk9SX09DVEFMX1JFQUQgaXMgc2V0LiBDb3JyZWN0Pw0KDQogICAgICAgIGlmICgoaW5mby0+
ZmxhZ3MgJiAoU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCB8DQogICAgICAg
ICAgICAgU1BJX05PUl9PQ1RBTF9SRUFEKSkgJiYgIShpbmZvLT5mbGFncyAmIFNQSV9OT1JfU0tJ
UF9TRkRQKSkgew0KDQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdhdXINCg0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oIGIvaW5jbHVkZS9saW51eC9tdGQvc3Bp
LW5vci5oDQo+ID4gaW5kZXggOGIxYWNmNi4uMDE5ZjUzNCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L210ZC9zcGkt
bm9yLmgNCj4gPiBAQCAtNTAsOSArNTAsMTMgQEANCj4gDQo+IENhbiB5b3UgcGxlYXNlIHMvb2N0
by9vY3RhbCBvbiB0aGVzZSBhcyB3ZWxsOg0KPiAkICBncmVwIC1uaSBvY3RvIGluY2x1ZGUvbGlu
dXgvbXRkL3NwaS1ub3IuaA0KPiA0NzE6ICogQXMgYSBtYXR0ZXIgb2YgcGVyZm9ybWFuY2VzLCBp
dCBpcyByZWxldmFudCB0byB1c2UgT2N0byBTUEkgcHJvdG9jb2xzIGZpcnN0LA0KPiA0OTI6I2Rl
ZmluZSBTTk9SX0hXQ1BBU19SRUFEX09DVE8JCUdFTk1BU0soMTQsIDExKQ0KPiA1MDE6ICogTGlr
ZSAoRmFzdCkgUmVhZCBjYXBhYmlsaXRpZXMsIE9jdG8vUXVhZCBTUEkgcHJvdG9jb2xzIGFyZSBw
cmVmZXJyZWQgdG8NCj4gdGhlDQo+IDUxNTojZGVmaW5lIFNOT1JfSFdDQVBTX1BQX09DVE8JR0VO
TUFTSygyMiwgMjApDQo+IA0KPiB0aGFua3MsDQo+IHRhDQo=
