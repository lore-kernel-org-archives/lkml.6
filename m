Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5BC21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vNEfGOc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403934AbeLUOpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:45:34 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38399 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUOpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:45:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="25554415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 21 Dec 2018 07:45:32 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 21 Dec 2018 07:45:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klo6Hi7a73gON1edZM21ejJ37zK/3HF1OiM2ThpL+Cw=;
 b=vNEfGOc7kNyQggTrGCHBvPBhGQxKua+U5XtTkPjN+3JdsE0ewlL3nRf4510KnBecZBpEBoIfIV0foomsh57kvqhRnwTGZAEhP9DFp3eVsVwsEya1Qh93FCQhAFMDKpA3aQv7FeVli0aO372scIufjfwTTgqBXAiRg4PIAh2CpCw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Fri, 21 Dec 2018 14:45:28 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239%10]) with mapi id 15.20.1446.022; Fri, 21 Dec
 2018 14:45:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <broonie@kernel.org>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v6 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUl4OHZx7esZc7KkGk0K2ddcXB8aWJSJIA
Date:   Fri, 21 Dec 2018 14:45:28 +0000
Message-ID: <bf29684e-138c-5f8d-e0ca-a04e343768df@microchip.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1545214186-16987-5-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0064.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::41) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1508;6:D/2QEBrjc6URHYWuc6H070S/i2T89vVOTNB7Q5iINWEiT8ColaxiLGsSwy0/3Z1yVXuqTwnN5MmBhkQOXBUNK8FuRtwIz531pk3dLHcFPTJDycuwml2447RQKTHudeu90cfshE2hBOpMLg1YWhPjwJX4albqAoIEsQvYi5Jvj+nHtZVxScFB8/xf4GOnfamcBd6Ngv5/4YEUaeh2vysV4lCOgdn++L5cxggqg+zipBxOPOv2cl1266I0e5YeI1rwjZdqt32GrNPkn0qa5qOQuFQuh2ugNFUJBqyQCAWEC/HmTaK+ThgB4uPlAlZBD0xPqHHWnqwK9/6SD4TYUt+vTiBnNyBTQey/Wz1Mrbhpl1cWdReO5PLVkN5R6pNcUEsiGoPgr+/nD8USQIdCVxUHsptKSzZ10YFnd7CBV/xhZ6t4LOI6Nzj3VSOncnBls1SxXEATkpCA2/nk30/AGVY7Ew==;5:0IfhtB+1QLzAkLYve9YNMb/xrhekz/ACI6GDbbYXhD8EJxO3TNQyRYj2eleHmyPaTd/kh3nSZqWbDK3Uk+9XTlPKlts4T4P/XL1xIbSB5YnzRF0/w97zuTS/PYm1akyyPAOgC6PYFQWRsRI5W1n+ZMkKyNH08E1+sb0UUUtJ8yY=;7:jf4dUNjDSoK5NppMjR9HBxIjiH/6vi3SXrtIlYADohhRGPvbtinnFzuhuxP+5fvWlzKZHZaUJKwKpl26IReFEaWOlTPMW5c1w1Xe9MEBTEMoGNm77cdTvrRlf/BMBGmxnP08kbUGZjJDY4K4duHEFQ==
x-ms-office365-filtering-correlation-id: e83b5737-6f23-465a-d37e-08d66752f30a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1508;
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB15080B5E1D3E116132FF9470F0B80@BN6PR11MB1508.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1508;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1508;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(71200400001)(71190400001)(106356001)(2501003)(25786009)(105586002)(229853002)(4326008)(6486002)(6436002)(7416002)(66066001)(2201001)(486006)(39060400002)(97736004)(86362001)(5660300001)(31696002)(76176011)(68736007)(8936002)(6116002)(3846002)(31686004)(81166006)(14454004)(81156014)(52116002)(8676002)(11346002)(476003)(2616005)(6246003)(386003)(6506007)(53546011)(256004)(99286004)(53936002)(54906003)(110136005)(6512007)(316002)(102836004)(7736002)(305945005)(14444005)(26005)(72206003)(186003)(2906002)(478600001)(446003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1508;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UK9/gA2DZ0FjC7nG4EwjOr4GtjMNUmoXguuLfB2pB0DmZKYLtwVTMlyZHVPN+HZ6m4qP5MNiFyyVPO+FSBUEMVDxKy16e9BVfpNmBLeKK9uDe6pG9hCtIgTkK77FqM4tKqxJpI15ARjdIDa3tbZURvgVDD7GmnX6mg/ZHi1dakAY1Kguf0jUkynLOVJThUtDNeOUXws/UvtL9Td1mJx3QE+NCQyWpzInD2Pb7nKTM/gJzADeBTdv8ZClfFECw34Sh+Ay3x4Fyg49T0Dbwm7GrtkZNm5P0eNjxsAXdGNRfn2Iflni0SZU8T3JBWkPb4mX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7D11504F499F14D9ECDFC622B36D03E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e83b5737-6f23-465a-d37e-08d66752f30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 14:45:28.5458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLzE5LzIwMTggMTI6MTIgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+
IEFkZCBvY3RhbCByZWFkIGZsYWcgZm9yIGZsYXNoIG10MzV4dTUxMmFiYS4NCj4gVGhpcyBmbGFz
aCwgbXQzNXh1NTEyYWJhLCBpcyBvbmx5IGNvbXBsYWludCB0byBTRkRQIEpFU0QyMTZCIGFuZCBk
b2VzDQo+IG5vdCBzZWVtIHRvIHN1cHBvcnQgbmV3ZXIgSkVTRDIxNkMgc3RhbmRhcmQgdGhhdCBw
cm92aWRlcyBhdXRvDQo+IGRldGVjdGlvbiBvZiBPY3RhbCBtb2RlIGNhcGFiaWxpdGllcyBhbmQg
b3Bjb2Rlcy4gVGhlcmVmb3JlLCB0aGlzDQo+IGNhcGFiaWxpdHkgaXMgbWFudWFsbHkgYWRkZWQg
dXNpbmcgbmV3IFNQSV9OT1JfT0NUQUxfUkVBRCBmbGFnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VmlnbmVzaCBSIDx2aWduZXNockB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBOYXJh
eWFuIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiBDaGFu
Z2VzIGZvciB2NjoNCj4gLSBDb3JyZWN0IFMtby1iIHRhZyB3aXRoIGZ1bGwgYXV0aG9yIG5hbWUg
YXMgJ1lvZ2VzaCBOYXJheWFuIEdhdXInLg0KPiBDaGFuZ2VzIGZvciB2NToNCj4gLSBNb2RpZmll
ZCBzdHJpbmcgJ29jdG8nIHdpdGggJ29jdGFsJy4NCj4gQ2hhbmdlcyBmb3IgdjQ6DQo+IC0gTm9u
ZQ0KPiBDaGFuZ2VzIGZvciB2MzoNCj4gLSBNb2RpZmllZCBzdHJpbmcgJ29jdGFsJyB3aXRoICdv
Y3RvJy4NCj4gQ2hhbmdlcyBmb3IgdjI6DQo+IC0gSW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50
cyBvZiBCb3JpcyBhbmQgVmlnbmVzaA0KPiANCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IGluZGV4IDg3MmQ3MDcuLjUzYTNiY2Mg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IEBAIC0xODc3LDcgKzE4NzcsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3BpX25vcl9pZHNbXSA9IHsNCj4gIAkvKiBNaWNy
b24gKi8NCj4gIAl7DQo+ICAJCSJtdDM1eHU1MTJhYmEiLCBJTkZPKDB4MmM1YjFhLCAwLCAxMjgg
KiAxMDI0LCA1MTIsDQo+IC0JCQlTRUNUXzRLIHwgVVNFX0ZTUiB8IFNQSV9OT1JfNEJfT1BDT0RF
UykNCj4gKwkJCVNFQ1RfNEsgfCBVU0VfRlNSIHwgU1BJX05PUl9PQ1RBTF9SRUFEIHwNCj4gKwkJ
CVNQSV9OT1JfNEJfT1BDT0RFUykNCj4gIAl9LA0KPiAgDQo+ICAJLyogUE1DICovDQo+IA0K
