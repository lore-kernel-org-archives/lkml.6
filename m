Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8175CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B532084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WBxT9pkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B532084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeLJKov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:44:51 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:35764 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLJKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:44:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,338,1539673200"; 
   d="scan'208";a="23739026"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Dec 2018 03:44:49 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 10 Dec 2018 03:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJVmNWj1gHvsDasV8hK39O64J3GwDNTK1uCO/dVry24=;
 b=WBxT9pkxBjNhD2hNT5Ccw1+BA57+nqyBDUk4mgHyHPWoCBi3G2txfPStpW44TiEcW4fpPNVQJgS8WYUYQRyKOtQPeYlBsaI8HZD6eWk9QbkzH/zvk1/OuCvrmnqi9IkUNyRIzvGK3BBTGc8fJSV3nVNX+tXF4q65XzwwJplTqTM=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1489.namprd11.prod.outlook.com (10.172.21.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 10:44:44 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 10:44:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <broonie@kernel.org>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuPgL6l2VShjyka5vhSTd0gdZqV31OaA
Date:   Mon, 10 Dec 2018 10:44:44 +0000
Message-ID: <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0281.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::48) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1489;6:A66wLpBGVj3xVW1UoLboeH+Fb/fuE+cw7dp4bwpGnWwTjmIg6gjJ2CKlnqZClDCbpOMrDZgl9ypql/eM9iuFtUnA2/NoRwekivqwEZ3CHAAwGzUmfTpej00NOCZDBp64XvHrL5oySgdN2q+ijAM77W6zjF4SeKB9wrCv1oo4SBL6HqGR5cVbk8uM0MqvogBh6/mFbLa8TvshgiiqJnh7IBrOY+yGPs1yO7UXlqYJjUm9Ge5CjP/0P2hOi+5AXoF2Z7VxhrPopTQpEWu8RH3rNcEvt+fuQrP6i0I5TKh80uDHOp+ql+5S75MwFErcQcK3mLZ3j/Tfh9e3GehhBcK1BT7ieOEUwWw2Vzto9ylNXPYBdn64YcraXt2ET+sDMF0/ZoXaUPiunh5e0QXsBu0+IMUmi1B8zrfGykKZ7p4vXABc6ArXZ6wl1a0edPY2mvUucDDRTxIV7/1ju/g02hl90A==;5:RHB+fV19eyk/Kbv4U75XMM028QtQE4Cmx1WsuNVLMeUrJlJ1Zr1E32hSnm7GYON7RL7NLrAVsn+J8UMdOqG3Lu6I7hYClEEt6S3hM30lsZF2GvlwHzlUJRxYOiqvmONct3YhHtcqM4Hei/dDfMM2gLdYd1wN75vHUsnAd5/Woak=;7:wozVjq6ZNVa4IS/dz/KFqbobiRopCsAYL3DmQ1itnVZ8uGLlA+8bFngWkr3rmwDul/pLm3kiZDHSZKWss+OVFotcNzibF0CqQdevUxqqCw/+813YAViPpT98izV6T/6yOm1U/rde4jTnbT8S1cKMvA==
x-ms-office365-filtering-correlation-id: 87412d2c-0764-4511-5721-08d65e8c7f38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1489;
x-ms-traffictypediagnostic: BN6PR11MB1489:
x-microsoft-antispam-prvs: <BN6PR11MB1489D62C790FCE15515C1204F0A50@BN6PR11MB1489.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1489;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1489;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39850400004)(396003)(376002)(136003)(189003)(199004)(66066001)(6116002)(36756003)(8936002)(31696002)(6486002)(316002)(5660300001)(54906003)(110136005)(76176011)(106356001)(53546011)(6506007)(386003)(31686004)(99286004)(52116002)(102836004)(2501003)(53936002)(6512007)(186003)(68736007)(26005)(229853002)(11346002)(446003)(476003)(2616005)(4326008)(7736002)(6246003)(25786009)(105586002)(305945005)(39060400002)(97736004)(71190400001)(71200400001)(486006)(6436002)(2906002)(81156014)(86362001)(8676002)(81166006)(3846002)(14454004)(2201001)(478600001)(7416002)(256004)(72206003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1489;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CstYAvK22vnaSStIzOsvp06Vs7JUHgjGnbU1Nu5+pRadCmp8QNCaUzSOX/SxW12ClDpEYP6rGNC5MOo5Hh/aV+KO8UqmmC8+t9Sh8bL0cOU5DJA1FZjd2KW2Wc+Av0ftH6Kz1qNvo6YmdumR08ZU9AtHpzgw15rHO5EJvXOAXANwGNtetSS3SJCGlrJiNvS2wDLHqDrDO6scJKMcR8YNVVj5CnrqlMOegtniLVrAPZi8sycgWZ3odH3ChLvehKXJ4YOZjwIqrTDgHbmGbWFRVzS1uc2szkqTZ8Wf/U7bV2KFogQw8YTOz+pFeEeoypp9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3677578BA72704419DF709B3AB20C86D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87412d2c-0764-4511-5721-08d65e8c7f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 10:44:44.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1489
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvZ2VzaCwNCg0KT24gMTIvMDMvMjAxOCAxMDozOSBBTSwgWW9nZXNoIE5hcmF5YW4gR2F1
ciB3cm90ZToNCj4gLSBBZGQgb3Bjb2RlcyBmb3Igb2N0YWwgSS9PIGNvbW1hbmRzDQo+ICAgKiBS
ZWFkICA6IDEtMS04IGFuZCAxLTgtOCBwcm90b2NvbA0KPiAgICogV3JpdGUgOiAxLTEtOCBhbmQg
MS04LTggcHJvdG9jb2wNCj4gICAqIG9wY29kZXMgZm9yIDQtYnl0ZSBhZGRyZXNzIG1vZGUgY29t
bWFuZA0KPiANCj4gLSBFbnRyeSBvZiBtYWNyb3MgaW4gX2NvbnZlcnRfM3RvNF94eHggZnVuY3Rp
b24NCj4gDQo+IC0gQWRkIGZsYWcgc3BlY2lmeWluZyBmbGFzaCBzdXBwb3J0IG9jdGFsIHJlYWQg
Y29tbWFuZHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaWduZXNoIFIgPHZpZ25lc2hyQHRpLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAu
Y29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgdjU6DQo+IC0gTW9kaWZpZWQgc3RyaW5nICdvY3Rv
JyB3aXRoICdvY3RhbCcuDQo+IENoYW5nZXMgZm9yIHY0Og0KPiAtIE5vbmUNCj4gQ2hhbmdlcyBm
b3IgdjM6DQo+IC0gTW9kaWZpZWQgc3RyaW5nICdvY3RhbCcgd2l0aCAnb2N0bycuDQo+IENoYW5n
ZXMgZm9yIHYyOg0KPiAtIEluY29ycG9yYXRlZCByZXZpZXcgY29tbWVudHMgb2YgQm9yaXMgYW5k
IFZpZ25lc2gNCj4gDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDE2ICsrKysr
KysrKysrKysrLS0NCj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCAgIHwgIDggKysrKysr
KysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZl
cnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IGluZGV4IDM5OGQyNzMuLjdhMjE3NmQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IEBAIC05MCw2ICs5MCw3IEBAIHN0cnVjdCBmbGFzaF9p
bmZvIHsNCj4gICNkZWZpbmUgTk9fQ0hJUF9FUkFTRQkJQklUKDEyKSAvKiBDaGlwIGRvZXMgbm90
IHN1cHBvcnQgY2hpcCBlcmFzZSAqLw0KPiAgI2RlZmluZSBTUElfTk9SX1NLSVBfU0ZEUAlCSVQo
MTMpCS8qIFNraXAgcGFyc2luZyBvZiBTRkRQIHRhYmxlcyAqLw0KPiAgI2RlZmluZSBVU0VfQ0xT
UgkJQklUKDE0KQkvKiB1c2UgQ0xTUiBjb21tYW5kICovDQo+ICsjZGVmaW5lIFNQSV9OT1JfT0NU
QUxfUkVBRAlCSVQoMTUpCS8qIEZsYXNoIHN1cHBvcnRzIE9jdGFsIFJlYWQgKi8NCj4gIA0KPiAg
CWludAkoKnF1YWRfZW5hYmxlKShzdHJ1Y3Qgc3BpX25vciAqbm9yKTsNCj4gIH07DQo+IEBAIC0y
MDksNiArMjEwLDggQEAgc3RhdGljIGlubGluZSB1OCBzcGlfbm9yX2NvbnZlcnRfM3RvNF9yZWFk
KHU4IG9wY29kZSkNCj4gIAkJeyBTUElOT1JfT1BfUkVBRF8xXzJfMiwJU1BJTk9SX09QX1JFQURf
MV8yXzJfNEIgfSwNCj4gIAkJeyBTUElOT1JfT1BfUkVBRF8xXzFfNCwJU1BJTk9SX09QX1JFQURf
MV8xXzRfNEIgfSwNCj4gIAkJeyBTUElOT1JfT1BfUkVBRF8xXzRfNCwJU1BJTk9SX09QX1JFQURf
MV80XzRfNEIgfSwNCj4gKwkJeyBTUElOT1JfT1BfUkVBRF8xXzFfOCwJU1BJTk9SX09QX1JFQURf
MV8xXzhfNEIgfSwNCj4gKwkJeyBTUElOT1JfT1BfUkVBRF8xXzhfOCwJU1BJTk9SX09QX1JFQURf
MV84XzhfNEIgfSwNCj4gIA0KPiAgCQl7IFNQSU5PUl9PUF9SRUFEXzFfMV8xX0RUUiwJU1BJTk9S
X09QX1JFQURfMV8xXzFfRFRSXzRCIH0sDQo+ICAJCXsgU1BJTk9SX09QX1JFQURfMV8yXzJfRFRS
LAlTUElOT1JfT1BfUkVBRF8xXzJfMl9EVFJfNEIgfSwNCj4gQEAgLTIyNSw2ICsyMjgsOCBAQCBz
dGF0aWMgaW5saW5lIHU4IHNwaV9ub3JfY29udmVydF8zdG80X3Byb2dyYW0odTggb3Bjb2RlKQ0K
PiAgCQl7IFNQSU5PUl9PUF9QUCwJCVNQSU5PUl9PUF9QUF80QiB9LA0KPiAgCQl7IFNQSU5PUl9P
UF9QUF8xXzFfNCwJU1BJTk9SX09QX1BQXzFfMV80XzRCIH0sDQo+ICAJCXsgU1BJTk9SX09QX1BQ
XzFfNF80LAlTUElOT1JfT1BfUFBfMV80XzRfNEIgfSwNCj4gKwkJeyBTUElOT1JfT1BfUFBfMV8x
XzgsCVNQSU5PUl9PUF9QUF8xXzFfOF80QiB9LA0KPiArCQl7IFNQSU5PUl9PUF9QUF8xXzhfOCwJ
U1BJTk9SX09QX1BQXzFfOF84XzRCIH0sDQo+ICAJfTsNCj4gIA0KPiAgCXJldHVybiBzcGlfbm9y
X2NvbnZlcnRfb3Bjb2RlKG9wY29kZSwgc3BpX25vcl8zdG80X3Byb2dyYW0sDQo+IEBAIC0yMDkz
LDcgKzIwOTgsNyBAQCBlbnVtIHNwaV9ub3JfcmVhZF9jb21tYW5kX2luZGV4IHsNCj4gIAlTTk9S
X0NNRF9SRUFEXzRfNF80LA0KPiAgCVNOT1JfQ01EX1JFQURfMV80XzRfRFRSLA0KPiAgDQo+IC0J
LyogT2N0byBTUEkgKi8NCj4gKwkvKiBPY3RhbCBTUEkgKi8NCj4gIAlTTk9SX0NNRF9SRUFEXzFf
MV84LA0KPiAgCVNOT1JfQ01EX1JFQURfMV84XzgsDQo+ICAJU05PUl9DTURfUkVBRF84XzhfOCwN
Cj4gQEAgLTIxMTAsNyArMjExNSw3IEBAIGVudW0gc3BpX25vcl9wcF9jb21tYW5kX2luZGV4IHsN
Cj4gIAlTTk9SX0NNRF9QUF8xXzRfNCwNCj4gIAlTTk9SX0NNRF9QUF80XzRfNCwNCj4gIA0KPiAt
CS8qIE9jdG8gU1BJICovDQo+ICsJLyogT2N0YWwgU1BJICovDQo+ICAJU05PUl9DTURfUFBfMV8x
XzgsDQo+ICAJU05PUl9DTURfUFBfMV84XzgsDQo+ICAJU05PUl9DTURfUFBfOF84XzgsDQo+IEBA
IC0zMTk1LDYgKzMyMDAsMTMgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0cnVj
dCBzcGlfbm9yICpub3IsDQo+ICAJCQkJCSAgU05PUl9QUk9UT18xXzFfNCk7DQo+ICAJfQ0KPiAg
DQo+ICsJaWYgKGluZm8tPmZsYWdzICYgU1BJX05PUl9PQ1RBTF9SRUFEKSB7DQo+ICsJCXBhcmFt
cy0+aHdjYXBzLm1hc2sgfD0gU05PUl9IV0NBUFNfUkVBRF8xXzFfODsNCj4gKwkJc3BpX25vcl9z
ZXRfcmVhZF9zZXR0aW5ncygmcGFyYW1zLT5yZWFkc1tTTk9SX0NNRF9SRUFEXzFfMV84XSwNCj4g
KwkJCQkJICAwLCA4LCBTUElOT1JfT1BfUkVBRF8xXzFfOCwNCj4gKwkJCQkJICBTTk9SX1BST1RP
XzFfMV84KTsNCj4gKwl9DQo+ICs+ICAJLyogUGFnZSBQcm9ncmFtIHNldHRpbmdzLiAqLw0KPiAg
CXBhcmFtcy0+aHdjYXBzLm1hc2sgfD0gU05PUl9IV0NBUFNfUFA7DQo+ICAJc3BpX25vcl9zZXRf
cHBfc2V0dGluZ3MoJnBhcmFtcy0+cGFnZV9wcm9ncmFtc1tTTk9SX0NNRF9QUF0sDQoNCkF0IHRo
ZSBlbmQgb2Ygc3BpX25vcl9pbml0X3BhcmFtcyB3ZSBjaGVjayB0aGUgY29uZGl0aW9ucyBmb3Ig
cGFyc2luZyB0aGUgc2ZkcC4NClNob3VsZG4ndCBTUElfTk9SX09DVEFMX1JFQUQgdHJpZ2dlciB0
aGUgc2ZkcCBwYXJzaW5nIHdoZW4gU1BJX05PUl9TS0lQX1NGRFAgaXMNCm5vdCBzZXQ/DQoNCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCBiL2luY2x1ZGUvbGludXgv
bXRkL3NwaS1ub3IuaA0KPiBpbmRleCA4YjFhY2Y2Li4wMTlmNTM0IDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tdGQvc3Bp
LW5vci5oDQo+IEBAIC01MCw5ICs1MCwxMyBAQA0KDQpDYW4geW91IHBsZWFzZSBzL29jdG8vb2N0
YWwgb24gdGhlc2UgYXMgd2VsbDoNCiQgIGdyZXAgLW5pIG9jdG8gaW5jbHVkZS9saW51eC9tdGQv
c3BpLW5vci5oDQo0NzE6ICogQXMgYSBtYXR0ZXIgb2YgcGVyZm9ybWFuY2VzLCBpdCBpcyByZWxl
dmFudCB0byB1c2UgT2N0byBTUEkgcHJvdG9jb2xzIGZpcnN0LA0KNDkyOiNkZWZpbmUgU05PUl9I
V0NQQVNfUkVBRF9PQ1RPCQlHRU5NQVNLKDE0LCAxMSkNCjUwMTogKiBMaWtlIChGYXN0KSBSZWFk
IGNhcGFiaWxpdGllcywgT2N0by9RdWFkIFNQSSBwcm90b2NvbHMgYXJlIHByZWZlcnJlZCB0byB0
aGUNCjUxNTojZGVmaW5lIFNOT1JfSFdDQVBTX1BQX09DVE8JR0VOTUFTSygyMiwgMjApDQoNCnRo
YW5rcywNCnRhDQo=
