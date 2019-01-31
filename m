Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE43218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d2J/hc8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbfAaKnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:43:24 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:40920 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:43:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="23247804"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 03:43:23 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 03:43:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzriarA1q0+UUc9G+o/XOMNDQJyPM0VPYVIY9JFpVlc=;
 b=d2J/hc8c97Yjez9bZNXkPnr/b31FBlT+zvySdUnAxJEKNS2b9tStg29BClxld5fVvWMVEEVp0ZPZCoDM16Mis5m9PWgWNAQD763XN0O8mkTZ6aRlNiG6KejdaNh7Afn9Wn2Mxl7l7irWsTFDD9ARLciNZ7m4gNvbwAQ1J/mB7Zo=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1556.namprd11.prod.outlook.com (10.172.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 10:43:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:43:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUuK2rht/7ZFEtQkGJmNLPHPLPUaXIDnwAgAEjrwA=
Date:   Thu, 31 Jan 2019 10:43:21 +0000
Message-ID: <4a18feb1-2665-37c4-79e7-3cb7b6df8665@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-4-tudor.ambarus@microchip.com>
 <20190130181904.14094418@bbrezillon>
In-Reply-To: <20190130181904.14094418@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:802:2::41) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1556;6:aLXgcRYrWgasF6umhkGIMDMPQvtpplMxRYJ9CaRX0Im+RZXdhrgM5DxXozg9WTab2q0HLgxZzgfr4J2+n1BmBNnNC3E39MtQmZGyqI/VRa+WYd8sXCnqppnKZ1rqCw62e9QgmHnBkofbXE04Ak3YmAXy6b8TLunYPRXnTlj0pCQ/uM1/Ka+u4ZgkBmUVLqucQ2YH+SPeuZDxdR/WM6t8VrnsxEsMHW8tsPLvie+zlleuRrJ091MkEyp9lUy92kAT08z2mF1XN5whYSzN1TnYIly+tJtWmPLBkjWuhUJJUtvEJLpAFsrEit2WJeXGn9WlpSxw0RRLaDB+++a2sOZeufFLbA8mZFTBHAZTRed4C/dd+T822Ph9wGxT4NRZFQX1Mwj1lJrZyO2UEFoKjeKv5BlTtjBpBd2Q2mNzdpbnbnZlCn5IXO8fM94fG+UUhStPtUHanw7PDH2HNw4kg5NT+A==;5:rWQFITQiUhPvTf0/Otc0zjHrISo3P5PnoPblCXmpAB1iR/t30dV6xugjWZIPsH4DKGQnA0b6V4EuL1t499vJ3snqnL8xSxcu3aIE+WOGImdg25mFJvKVPOUSOxwIq57QDCdl6Hs/fJpHeoA8TsGr96UBrKL7lK8lUN8lfZJDpwiWZ+KqZqby9jbmEez2mqhoN4dbs3zfzDXE6Tm9aLecIw==;7:nkyuMM324G8JL7ShGFFlm6LMxkQmKmr7MZZJ817G2SK52lkt7pf+OYlAQgSBD5Ui7IO9h7J9rAmEb26EgfBbfx02XrQo3ggDCVjsUVQ2nbLhMMB8nImjkByNU94007/WlYUKzZw6O+WEdrTCTL/H6g==
x-ms-office365-filtering-correlation-id: 00e6ea2d-e229-4998-12df-08d68768eaf9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1556;
x-ms-traffictypediagnostic: BN6PR11MB1556:
x-microsoft-antispam-prvs: <BN6PR11MB15561252AB199F05E52916BCF0910@BN6PR11MB1556.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(86362001)(105586002)(31696002)(6486002)(102836004)(316002)(66066001)(52116002)(229853002)(99286004)(53546011)(72206003)(6436002)(2906002)(14454004)(6116002)(478600001)(3846002)(106356001)(4326008)(76176011)(25786009)(53936002)(6246003)(36756003)(386003)(6512007)(6506007)(8936002)(81156014)(7736002)(8676002)(476003)(446003)(305945005)(11346002)(2616005)(14444005)(68736007)(71200400001)(26005)(256004)(31686004)(486006)(71190400001)(6916009)(186003)(97736004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1556;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 86FQQhwjT1TlBTM2ZzZsXx/wW4KTw5CmjzWYwAD727vafydyDkb8StRXBhc2vJn/PyuXJIqrzjU0s7mxvRWg3DX4ThyRshLNVaroG3DK1yf2GNjw8zZQtHX3/t4tZPoHT2UFAui2JJMBm3iw61P0P1E3/RbNG2a7PrGOXsEE73XVrwQQ+ePLCTFgC/V8WBCjK/8RbB352/J3cvWZtlZgRUCcE6wj6E4niBXv1je+ryUiXDhACWKiBYIfMdbMkWePxQ47v0bmQnhFlrcY5lh47stvE+RvGRNNyb/+VTNEJYUDjwnBE+/a83cyy/D46tjPoU7pAe3fiD/lfInCt7hhYzS7LqkFbeDlx5OpJpjFVZLwDbJuGJVpR2grcMC0EHriSNC07Ty7b7nyUOTrN5SMGO9lOStmtebkKdDhexayYuI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FF3B4672228C341A97267F2FFE0A5AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e6ea2d-e229-4998-12df-08d68768eaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:43:19.2521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1556
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzMwLzIwMTkgMDc6MTkgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
V2VkLCAzMCBKYW4gMjAxOSAxNTowODozMyArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gTGV0IGdlbmVyYWwgbmFtZXMgdG8gY29yZSBkcml2ZXJz
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyB8IDUy
ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gIDEgZmls
ZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jIGIvZHJpdmVycy9zcGkvYXRtZWwt
cXVhZHNwaS5jDQo+PiBpbmRleCA2NDQ3NWFkMTZjODMuLmUxNTZjMzQ1NzA1YiAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPj4gKysrIGIvZHJpdmVycy9zcGkv
YXRtZWwtcXVhZHNwaS5jDQo+PiBAQCAtMTU3LDE0ICsxNTcsMTQgQEAgc3RydWN0IGF0bWVsX3Fz
cGkgew0KPj4gIAlzdHJ1Y3QgY29tcGxldGlvbgljbWRfY29tcGxldGlvbjsNCj4+ICB9Ow0KPj4g
IA0KPj4gLXN0cnVjdCBxc3BpX21vZGUgew0KPj4gK3N0cnVjdCBhdG1lbF9xc3BpX21vZGUgew0K
Pj4gIAl1OCBjbWRfYnVzd2lkdGg7DQo+PiAgCXU4IGFkZHJfYnVzd2lkdGg7DQo+PiAgCXU4IGRh
dGFfYnVzd2lkdGg7DQo+PiAgCXUzMiBjb25maWc7DQo+PiAgfTsNCj4+ICANCj4+IC1zdGF0aWMg
Y29uc3Qgc3RydWN0IHFzcGlfbW9kZSBzYW1hNWQyX3FzcGlfbW9kZXNbXSA9IHsNCj4+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGF0bWVsX3FzcGlfbW9kZSBzYW1hNWQyX3FzcGlfbW9kZXNbXSA9IHsN
Cj4+ICAJeyAxLCAxLCAxLCBRU1BJX0lGUl9XSURUSF9TSU5HTEVfQklUX1NQSSB9LA0KPj4gIAl7
IDEsIDEsIDIsIFFTUElfSUZSX1dJRFRIX0RVQUxfT1VUUFVUIH0sDQo+PiAgCXsgMSwgMSwgNCwg
UVNQSV9JRlJfV0lEVEhfUVVBRF9PVVRQVVQgfSwNCj4+IEBAIC0xNzUsMTggKzE3NSwxOCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHFzcGlfbW9kZSBzYW1hNWQyX3FzcGlfbW9kZXNbXSA9IHsNCj4+
ICB9Ow0KPj4gIA0KPj4gIC8qIFJlZ2lzdGVyIGFjY2VzcyBmdW5jdGlvbnMgKi8NCj4+IC1zdGF0
aWMgaW5saW5lIHUzMiBxc3BpX3JlYWRsKHN0cnVjdCBhdG1lbF9xc3BpICphcSwgdTMyIHJlZykN
Cj4+ICtzdGF0aWMgaW5saW5lIHUzMiBhdG1lbF9xc3BpX3JlYWRsKHN0cnVjdCBhdG1lbF9xc3Bp
ICphcSwgdTMyIHJlZykNCj4+ICB7DQo+PiAgCXJldHVybiByZWFkbF9yZWxheGVkKGFxLT5yZWdz
ICsgcmVnKTsNCj4+ICB9DQo+PiAgDQo+PiAtc3RhdGljIGlubGluZSB2b2lkIHFzcGlfd3JpdGVs
KHN0cnVjdCBhdG1lbF9xc3BpICphcSwgdTMyIHJlZywgdTMyIHZhbHVlKQ0KPj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBhdG1lbF9xc3BpX3dyaXRlbChzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEsIHUzMiBy
ZWcsIHUzMiB2YWx1ZSkNCj4+ICB7DQo+PiAgCXdyaXRlbF9yZWxheGVkKHZhbHVlLCBhcS0+cmVn
cyArIHJlZyk7DQo+PiAgfQ0KPiBDYW4gd2UgZ2V0IHJpZCBvZiB0aGVzZSB3cmFwcGVycz8gSSdt
IG5vdCBhIGJpZyBmYW4gb2Ygd3JhcHBlcnMgdGhhdA0KPiBoaWRlIHRoZSBmYWN0IHRoYXQgYWNj
ZXNzZXMgYXJlIHJlbGF4ZWQuDQo+IA0KDQpXaWxsIGRvLCB0aGFua3MhDQoNCnRhDQo=
