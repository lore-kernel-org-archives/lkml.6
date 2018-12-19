Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A159C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F90A21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kL+oDWfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeLSKPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:15:06 -0500
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:37661
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728925AbeLSKPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRZ/+vQjPmNTJTscqXAb/7kIsypq/wZk628PQlnNObc=;
 b=kL+oDWfiLgpCDEtT0zp0EhwxA3dCgqijjbW4nbl4kY6oMMmQ0bSMJzITSNFdFiAq1WJ0l8WYBYuttNPuvSLKEb8+qLTDANyNH7wxBRCvSN6nVWqUQc4nvMDC1X5pQHZ5BTbtaiNkvct9C+KpPtiG9McW06Xc3dsZL1v4F8Tl9gI=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5854.eurprd04.prod.outlook.com (20.178.204.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 10:15:00 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:15:00 +0000
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
Thread-Index: AQHUiuOuxIvwGhR/Ik2nR/UOeUIxtaV31PEAgAEp0pCAAD0wAIAMrARQ
Date:   Wed, 19 Dec 2018 10:15:00 +0000
Message-ID: <VI1PR04MB5726FBFD2CBEB7A3F0454A5999BE0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
 <VI1PR04MB57264CBB25E2984DF221ED2E99A60@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <141c6d79-ae7a-60aa-865a-f6b6997f8da9@microchip.com>
In-Reply-To: <141c6d79-ae7a-60aa-865a-f6b6997f8da9@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5854;6:DO68cWpQL3sX3odPZ3/x47xaHLeCahQlRlmOZKGhgynzliiCMokJZB9GmoYsGeiY1GAG1iTKWG3LLrQv93BCg0amKBar58qAUhVgqSL4JQKsOWrFBGyOm0AIThrL2CYAae/M2U1Kw8VsVApPYuMxWv9Y6wRjfAj66dnI/RsFgRrwM7ILt1IH6q5DJ8NH6NWMuGE55VguAkwf0DihTQ72q7IIgRfU7bqPJHx9NmMbLqODaUZJd0cE5AJYSNUU7l+eOl6S5lsaWaQm75WDIinLBjHdU+Ncnx6bNS8zaleV8ZrDWFmvPV5/dPFdVVdvsTc1gAGhI7jxVTN35Dq6NUU9NQRqCFzGZycPzZ/MRbcDZ9la3zLBZj+McZ4HuBiSnPrj7jVbLkgMwyXYugbYgHGJuttJP6gFaVNqqAwo4rlE53LGhOiRGGd7Gwy5t5mT9hrcson/EZmYDX1xk9xxukYqqw==;5:mTVGw6ofEFdFlNkZo/ZkTTYqWHNWTteZ3hNyPQ6nFFqef39Wk5L05yO/WyoP7cXXNSYn3EkcyARFd8oN6O82fxhrAbA7OBSlcvp6U27HS6ncy4J5QKZe5b79n3BA34iQWYmkFx5fBQMt+ha2sbc5dSZOgN4eyHOqlFxzWAry9Dk=;7:el9znNj7WELoqFehlncLUYQ8IdLSzuyrVnwZOW/0LZZE+AeE3PcrjgPBSGpLQ4FoYycNx47sDtYEtQBn/UgOdxSLEcDFdteVtLc5mgl1QaCr907OdgwJIOvb5pwy85glG+LaWIoF8b4QkocrGnhwpA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b157a7e7-fdb0-4437-2bae-08d6659ad5ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5854;
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB5854D026481FCB01EE29CB2599BE0@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5854;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5854;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(13464003)(33656002)(68736007)(256004)(11346002)(446003)(486006)(5660300001)(7736002)(54906003)(110136005)(86362001)(2906002)(229853002)(2201001)(99286004)(6116002)(3846002)(76176011)(102836004)(97736004)(7696005)(186003)(26005)(53546011)(6506007)(39060400002)(305945005)(105586002)(71190400001)(106356001)(81166006)(8936002)(4326008)(55016002)(6306002)(6246003)(9686003)(53936002)(74316002)(8676002)(81156014)(478600001)(66066001)(93886005)(476003)(14454004)(2501003)(316002)(966005)(6436002)(7416002)(25786009)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5854;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ALkl7FWvAoFjFORQj58f90acVNcXBCZ8v2gPToAeCohQJrPpmD5OzO2Fid1ksNtCd2tI/6/r7owSoCtg9BXaD3dOA5SyWHw9YzkQ7Ty1pAl8DdTssUvRkNcoU47Pq3BcfjgdW4WTwPUGJStGvqlcCc/WTsf5bywXIYhVccvG6iIJL/eC5U4SMhNGnq0hNik286/AsAwdmEKNbuRHAw06+uTeSaTYlxGYhb7MVs7FNBcDIEE+pxq3hkwQihGYxs1YOtUimlzVqArYP9m/u6ktjzUBREfegryy5MjWz743MwdbCu3pbKlHF+X10FSdEKPF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b157a7e7-fdb0-4437-2bae-08d6659ad5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:15:00.6960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIFttYWlsdG86VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29t
XQ0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMSwgMjAxOCAxOjQwIFBNDQo+IFRvOiBZb2dl
c2ggTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47IGxpbnV4LQ0KPiBt
dGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgYm9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tOyBicm9v
bmllQGtlcm5lbC5vcmc7DQo+IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgdmlnbmVzaHJAdGkuY29t
OyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9A
a2VybmVsLm9yZzsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY29t
cHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPiBmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMv
N10gbXRkOiBzcGktbm9yOiBhZGQgb3Bjb2RlcyBmb3Igb2N0YWwgUmVhZC9Xcml0ZQ0KPiBjb21t
YW5kcw0KPiANCj4gSGksDQo+IA0KPiBPbiAxMi8xMS8yMDE4IDA2OjU1IEFNLCBZb2dlc2ggTmFy
YXlhbiBHYXVyIHdyb3RlOg0KPiA+IFRodXMgd291bGQgZ29pbmcgdG8gbW9kaWZ5IHRoZSBjb25k
aXRpb24gY2hlY2sgYXMgYmVsb3csIHNvIHRoYXQgU0ZEUA0KPiBwYXJzaW5nIHdvdWxkIGFsc28g
YmUgcGVyZm9ybWVkIHdoZW4gU1BJX05PUl9PQ1RBTF9SRUFEIGlzIHNldC4gQ29ycmVjdD8NCj4g
Pg0KPiA+ICAgICAgICAgaWYgKChpbmZvLT5mbGFncyAmIChTUElfTk9SX0RVQUxfUkVBRCB8IFNQ
SV9OT1JfUVVBRF9SRUFEIHwNCj4gPiAgICAgICAgICAgICAgU1BJX05PUl9PQ1RBTF9SRUFEKSkg
JiYgIShpbmZvLT5mbGFncyAmDQo+ID4gU1BJX05PUl9TS0lQX1NGRFApKSB7DQo+IA0KPiBZZXMs
IHRoaXMgaXMgd2hhdCBJIHdhcyBzdWdnZXN0aW5nLiBPbiBhIHNlY29uZCB0aG91Z2h0LCB3ZSBo
YXZlbid0IGFkZGVkIHlldA0KPiBzdXBwb3J0IGZvciBwYXJzaW5nIHNmZHAgdG8gZ2V0IHRoZSBv
Y3RhbCBtb2RlIGluZm8sIHNvIHRoZSBwYXJzaW5nIHdpbGwgYmUgZG9uZQ0KPiBncmF0dWl0b3Vz
bHkuIExldCdzIGRyb3AgdGhpcyBjaGFuZ2UgYW5kIGFkZCBpdCB3aGVuIGFkZGluZyBzdXBwb3J0
IGZvciBwYXJzaW5nDQo+IG9jdGFsIG1vZGUgaW5mbyBmcm9tIHNmZHAuIEknbGwgcHJlcGFyZSBh
IHBhdGNoIGZvciB0aGlzLg0KPiANCj4gUGxlYXNlIHJlYmFzZSBvbiB0b3Agb2Ygc3BpLW5vci9u
ZXh0LCBzL29jdG8vb2N0YWwgaW4gc3BpLW5vci5oIGFuZCBjb3JyZWN0IHlvdXINCj4gUy1vLWIg
dGFnIGFuZCB5b3UnbGwgaGF2ZSBteSBSLWIgdGFnLg0KPiANCk5leHQgdmVyc2lvbiwgdjYsIHNl
bnQgZm9yIHJldmlld1sxXS4NClNvcnJ5IGZvciBsYXRlIHJlcGx5LCB3YXMgb24gbGVhdmUuDQoN
Ci0tDQpSZWdhcmRzDQpZb2dlc2ggR2F1cg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L2xpbnV4LW10ZC9saXN0Lz9zZXJpZXM9ODI4MTUNCg0KPiBUaGFua3MgWW9n
ZXNoLA0KPiB0YQ0K
