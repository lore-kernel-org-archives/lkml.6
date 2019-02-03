Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA32CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68937218A6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MUyagcG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfBCNdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:33:54 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:54914 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfBCNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:33:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,556,1539673200"; 
   d="scan'208";a="25801214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Feb 2019 06:33:53 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 3 Feb 2019 06:33:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtzUKZJHrGg6W4L1AfuHk0XS07216OeLlq1HF1ovcHU=;
 b=MUyagcG+eWoTPjDyDv8K6OZy68+/N/fPJxa8ONk4FgWVTzVd08WWFPjgeIxMZzDMeyg1hC1aGh4zg+yG32P0LTH0Zoikgk4awPNjqnHKrQE1/eQ/0QljfNwT/wwpq1lU6+KgcBjc1VXSgYv/tpgWD5NvNTltg0y/2jiPAseSYsw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1521.namprd11.prod.outlook.com (10.172.23.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Sun, 3 Feb 2019 13:33:49 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 13:33:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <frieder.schrempf@kontron.de>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Index: AQHUsvEnBk05JSMTaE23Hh40f7Dva6XOJEMA
Date:   Sun, 3 Feb 2019 13:33:48 +0000
Message-ID: <f0b2c97b-419a-1e3e-4624-52c60fe32065@microchip.com>
References: <20190123075538.12681-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190123075538.12681-1-frieder.schrempf@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:803:14::37) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.121.188.150]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1521;6:yi+ytiG41Yy/EYgQe/B16xyKqVjnI0XrO4+oYKVQQ/tc2j2or4n1jDvWwlMW1dDaqKyDXZzfXVzlxiqIaoZvCSvr+0LtmeIKFqERR3APqYU9pCG7CqEstsFkN3x+l1HS70+zrR7kqu3mNi5WI96JISH1J1Kh1r72w1oeiwu7G8d9qM1r59OZt6xsvJ+UydpYObJXHqgErNBVkpVSLKjxRaAs6sit0LwUq3eGbL7XYRlp2BiGlDWER5sa5lgzPS91R7vFFQjAPoXf4bccY7SjIcECRcgK34uoOGydmKLAlJQvDoRq+FCekseeqJ5KBMdx7TmyTqeSQjUMUrn/mSrtIXRamR+hpCOAbJzRNytInPNu6WIdETN1nHizeq/18w8xaW1HFMZUcE/z4+YYr1MS3qGyncbvJrxWkfdlze9f6yG5PfAH94bovAoLuoWyFGxuPRnuYCd65S7PR1Od6LAkyQ==;5:G4EXyyyaaLIbsAzvQAW3W3HLtULs4Nsg9yzOi1wU2lrrUXnrICAuA0pjnRlyTNMX+IDIuKfUzKCd0dIEBkWiUmL0RVCbUL1Gr5KDhauTitSgOkB3f0EWfgv+s6cUH93B/3khvHDOIvURNmUharPD6jbD9Y+GbUrrf7q+znFeeiydXf2JAecPbmeA9bAr6V9O0C72aSh6DDbAE2LiGXlxLg==;7:YrLa9cSvCy74IQxVnubAaOBrQ3XsrK2khWHj7/uDhJgL/SvdHd0tQ6WwOjDbc72u4fy9R/oiQmOUXw3z0V1uzgyNtEHqAkqbL4YI/pKXwOl1Auf6YlncXVTsZWb9/uKx41ysxo4lI3kbHt1VrfgYjw==
x-ms-office365-filtering-correlation-id: 905573fc-b437-424e-0947-08d689dc3a5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1521;
x-ms-traffictypediagnostic: BN6PR11MB1521:
x-microsoft-antispam-prvs: <BN6PR11MB1521D48809A7EF109B8BC3D7F06C0@BN6PR11MB1521.namprd11.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(366004)(396003)(376002)(346002)(189003)(44054003)(199004)(6436002)(68736007)(6512007)(81166006)(81156014)(25786009)(446003)(31686004)(31696002)(256004)(72206003)(478600001)(14444005)(86362001)(39060400002)(71190400001)(6246003)(14454004)(53936002)(4326008)(105586002)(71200400001)(76176011)(106356001)(52116002)(99286004)(305945005)(53546011)(6506007)(386003)(3846002)(26005)(97736004)(102836004)(36756003)(186003)(6116002)(8936002)(11346002)(229853002)(486006)(2616005)(476003)(110136005)(54906003)(316002)(8676002)(7736002)(6486002)(66066001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1521;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i1FQHNqua6veQdDKnLLezP9ha2QLq0T0XtI5rmayIUh/XQ1/bSFydHCvEPP00wkPykjW2GnO1otTRTmAYZF6D6/LGZwIdNuOQJAw78ZVv04C/zq1btWTnH3J44BQ89qq2DiDSAwdyRT1aUO23a0KEMWHP6cPWsSDEoECWkmfjVCQ9RYUdkuIUMaK3p3aMnXV3Vecl4DcBwo/fek/82qdKgtZ39l0WZprJGMhsZjwBe/IBvZgxO6ksAJ237YnNMhNGhl7aVZzSwfT9Ks7dKFTEyTu6LXHQDWGTq/ya75bofaSfa5V5D9eb0zKwp16308J5tp1l10FMqJ6mbwqIPYBFGL2Bz9rTbZAywv8cG6Xb9fBzOuLp/L4QKnpIdD8OJbwDJtrvySn44WOFBmi8BR7+jsJWMr1nceyyjiWgdDzcL8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5D02C195F62E64699584B43471C8832@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 905573fc-b437-424e-0947-08d689dc3a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 13:33:47.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1521
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZyaWVkZXIsDQoNCk9uIDAxLzIzLzIwMTkgMDk6NTYgQU0sIFNjaHJlbXBmIEZyaWVkZXIg
d3JvdGU6DQo+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJv
bi5kZT4NCj4gDQo+IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgRU9OIEVOMjVRODBBLCBhIDhN
YiBTUEkgTk9SIGNoaXAuDQoNCkkgd291bGQgc3VnZ2VzdCB0byBzcGVjaWZ5IHdobyBpcyB1c2lu
ZyB0aGlzIGZsYXNoIGFuZCBob3cgZGlkIHlvdSB0ZXN0IGl0LiBUaGlzDQp3YXkgd2Ugd2lsbCBu
b3QgZW5kIHVwIHdpdGggc3VwcG9ydCBmb3IgZmxhc2hlcyB0aGF0IGFyZSBub3QgYWN0dWFsbHkg
dXNlZC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5z
Y2hyZW1wZkBrb250cm9uLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9zcGktbm9yLmMNCj4gaW5kZXggNmUxM2JiZDFhYWE1Li5hYThhMDQyOTNhMjUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IEBAIC0xNzM3LDYgKzE3MzcsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGZsYXNoX2luZm8gc3BpX25vcl9pZHNbXSA9IHsNCj4gIAkvKiBFT04gLS0gZW4y
NXh4eCAqLw0KPiAgCXsgImVuMjVmMzIiLCAgICBJTkZPKDB4MWMzMTE2LCAwLCA2NCAqIDEwMjQs
ICAgNjQsIFNFQ1RfNEspIH0sDQo+ICAJeyAiZW4yNXAzMiIsICAgIElORk8oMHgxYzIwMTYsIDAs
IDY0ICogMTAyNCwgICA2NCwgMCkgfSwNCj4gKwl7ICJlbjI1cTgwYSIsICAgSU5GTygweDFjMzAx
NCwgMCwgNjQgKiAxMDI0LCAgIDE2LA0KPiArCQkJU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFE
IHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQoNCkknbSByZWFkaW5nIEVOMjVRODBBIFJldi4gSCwg
SXNzdWUgRGF0ZTogMjAxMi8xMC8yMw0KIGRhdGFzaGVldC4gSSBkb24ndCBzZWUgdGhlIGJmcHQg
dGFibGUgZGVzY3JpYmVkLCBzbyBwcm9iYWJseSBpdCBkb2Vzbid0IHN1cHBvcnQNCml0LiBUaGUg
Zmxhc2ggYWR2ZXJ0aXNlcyBTUElOT1JfT1BfUkVBRF8xXzRfNCAoMHhlYiksIGJ1dCBub3QNClNQ
SU5PUl9PUF9SRUFEXzFfMV80ICgweDZiKS4gSW4gc3BpX25vcl9pbml0X3BhcmFtcygpLCB3aGVu
IFNQSV9OT1JfUVVBRF9SRUFEIGlzDQpzZXQsIHdlIGFzc3VtZSB0aGF0IFNOT1JfSFdDQVBTX1JF
QURfMV8xXzQgaXMgc3VwcG9ydGVkLCBzbyB3ZSB3aWxsIHVzZSAweDZiIGZvcg0KcXVhZCByZWFk
cy4gSSBjYW4ndCBzZWUgaG93IHRoZSBmbGFzaCB3b3JrcyB3aXRoIDB4NmIsIHVubGVzcyB0aGVy
ZSBpcyBhIGJmcHQNCnRhYmxlIHRoYXQgaW5kaWNhdGVzIHN1cHBvcnQgZm9yIDB4ZWJoLg0KDQpJ
ZiBpdCBkb2VzIHN1cHBvcnQgYmZwdCwgc2V0IGp1c3QgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9S
RUFELCB0aGUgbGF0dGVyIHdpbGwNCnRyaWdnZXIgdGhlIGJmcHQgcGFyc2luZy4NCg0KSWYgeW91
IHdpbGwgcmVzdWJtaXQsIHBsZWFzZSBvcmRlciB0aGUgZW50cnkgaW4gYWxwaGFiZXRpY2FsIG9y
ZGVyLCBieSBuYW1lLg0KDQpDaGVlcnMsDQp0YQ0K
