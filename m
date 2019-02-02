Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F0C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26C620869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="keB1vkCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfBBIoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 03:44:30 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:46867 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfBBIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 03:44:30 -0500
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="26065106"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Feb 2019 01:44:29 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sat, 2 Feb 2019 01:44:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Xm15afEM4Px9j8FoRyu/eKLb0Rq9lUUS60Q0iqmp4=;
 b=keB1vkCZU6nF1nTtr+M//joGfgXKFaI2HHTRn4V2M44J1L8RfdXQW3D+aWNKNtN+qkm6abfQ3W4KY4D4q33KIvbx1+//lbTN00yLD9BJCerF+26r0Zni7jUJjtTI+haZDwCdKHQQuv30nUD4LFlBY49FqLecgMI9ucq4VUyyrY4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2035.namprd11.prod.outlook.com (10.173.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 08:44:27 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:44:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Thread-Topic: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Thread-Index: AQHUuqzK70j+j/B0dE+wG5hbzKgwl6XMF5mAgAAaBoA=
Date:   Sat, 2 Feb 2019 08:44:27 +0000
Message-ID: <53c9f4b2-7022-e13d-65a4-2e1bed4d76b1@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-4-tudor.ambarus@microchip.com>
 <20190202081111.0bbc4443@bbrezillon>
In-Reply-To: <20190202081111.0bbc4443@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0113.eurprd09.prod.outlook.com
 (2603:10a6:803:78::36) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB2035;6:6VtBruGU6zll4SCefrbHyRwD31wVQyoqTnT/cH4o1fClD0Z9AfKR26QDjs2erakjKi23xw/7MNWT8+hYmOizuQKiZgtXV1+RelIcMUITQBhsxJd1127vmT0vNhKb/pWTBJz1myx+Cg06vt9XXFgnEKKlQT+9AF5CseakMrqYlMuhEfccrD96M+Q+4m/4mkqH1JSbBgrXGTsJrgzyjKuslgHQwjEszv6iZEOhrokwXlxYrP1OoGivx3Q94MSp48MdppZDGVz/hJeMjv8ZmWx4O+PvPBaehB7d7AZvoa9JH/dSPMDNGjrwuSw3C/sHgSLfKvpPS+TdUDYbgooxEWI1HuWFE8AXsbvtgvTnU/cQedd78j0yoCuFvtlo3wHs9+nkn1ckkqZqqEmBSztbGvMShMqPPDHlnPn8pSF1PGjMjh1rnT4TtnYHWeSykXpPPiKnTKtxyudkC67Med3ECDT4WA==;5:CYGHxXh4gaw1bOQaBBL8f6QxMYeoJRhOMBJMPjy01x7wvDilouYYxcq+vbR0z9AoDi2Tgvpy/qePN2ZdIOD2Wl+jRrFw+zTdGcCqSkNl2++D0nq16uytSg5pqEQH8KPwTgssAosKGsMEJX48Kv/J2DbKSuMk1I3332+3gZV7DvekuwTS4X/IIv0byQ7SbDmMvI5JUEfdwTH9qktCZulW8A==;7:OsHFUmGewgAryL6ehU6LSA5O8lumv50t4BJ+KFE2mvU1eZvE2oA7zyhpcl6xraddDIv2kKg75BlrvB2SWVOj6MaRAkdA/CvZ94KAB9e5tILFOKf0rHAIsaibnNkVB5yV1Z13z0TC1RCrCGgAdZAHRA==
x-ms-office365-filtering-correlation-id: 348ff2a2-f321-4f3e-1248-08d688eaa3a7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB2035;
x-ms-traffictypediagnostic: BN6PR11MB2035:
x-microsoft-antispam-prvs: <BN6PR11MB2035EFFD5018A810B55C8DC9F0930@BN6PR11MB2035.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(2616005)(8936002)(7416002)(11346002)(31686004)(105586002)(71190400001)(14454004)(71200400001)(81156014)(36756003)(8676002)(81166006)(486006)(97736004)(446003)(2906002)(3846002)(476003)(68736007)(6116002)(102836004)(39060400002)(106356001)(6246003)(229853002)(25786009)(6512007)(4326008)(99286004)(52116002)(72206003)(6506007)(53936002)(6436002)(54906003)(186003)(256004)(31696002)(66066001)(26005)(14444005)(86362001)(53546011)(478600001)(6486002)(386003)(305945005)(7736002)(316002)(76176011)(6916009)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2035;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /dyDInrd8l2U7fwofZMFJUt0iUermzeba3imOEu3r4xd0wk9Y3kDpDHKbkbdvYWMr2vFuYbs1ZGxgtmR7aT+EvgPaKMYSFozWdYjrWahVRnPYAd1uaqZQgFocxjn5svofftSwI4LquT7hqGtg6i6EOZsng3tZEF6E/X1RCTt2oyabaN5Z+1LXpFFCKx9SiMBn2i5+o1JothGHoVe4OjWPrmmONVq0MciQ5y8f+fIhmr9voGT155gXi5mrt27cJMFnM4PUs74fLV/E+LEZr5C6quz2XUcnnXmejP8KBpaTblZ17W8sF724Nmg7TD/RmseeVotca1dPa8WUoda09wJpyaZlyFnewQ1yvbqx+Oe7VyyoFLQpL+2Achy5dLCiO60PoDk2fUspUVIwe2fSXYIpV8To9sjFCoAyiR+fwhjI0c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCD794DE2C183345BDE83BB586E8540E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ff2a2-f321-4f3e-1248-08d688eaa3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:44:24.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2035
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMTkgMDk6MTEgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
U2F0LCAyIEZlYiAyMDE5IDA0OjA3OjE5ICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNA
bWljcm9jaGlwLmNvbT4NCj4+DQo+PiBUaGUgd3JhcHBlcnMgaGlkIHRoYXQgdGhlIGFjY2Vzc2Vz
IGFyZSByZWxheGVkLiBEcm9wIHRoZW0uDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBCb3JpcyBCcmV6
aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFt
YmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gdjM6IG5vIGNo
YW5nZQ0KPj4gdjI6IG5ldyBwYXRjaA0KPj4NCj4+ICBkcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3Bp
LmMgfCA0NyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyBiL2RyaXZlcnMvc3Bp
L2F0bWVsLXF1YWRzcGkuYw0KPj4gaW5kZXggZmVlZGRjYjI1ZTFmLi4xMzEzNzRkYjBkYjQgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4+ICsrKyBiL2RyaXZl
cnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPj4gQEAgLTE3NSwxNyArMTc1LDYgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBxc3BpX21vZGUgc2FtYTVkMl9xc3BpX21vZGVzW10gPSB7DQo+PiAgCXsgNCwg
NCwgNCwgUVNQSV9JRlJfV0lEVEhfUVVBRF9DTUQgfSwNCj4+ICB9Ow0KPj4gIA0KPj4gLS8qIFJl
Z2lzdGVyIGFjY2VzcyBmdW5jdGlvbnMgKi8NCj4+IC1zdGF0aWMgaW5saW5lIHUzMiBxc3BpX3Jl
YWRsKHN0cnVjdCBhdG1lbF9xc3BpICphcSwgdTMyIHJlZykNCj4+IC17DQo+PiAtCXJldHVybiBy
ZWFkbF9yZWxheGVkKGFxLT5yZWdzICsgcmVnKTsNCj4+IC19DQo+PiAtDQo+PiAtc3RhdGljIGlu
bGluZSB2b2lkIHFzcGlfd3JpdGVsKHN0cnVjdCBhdG1lbF9xc3BpICphcSwgdTMyIHJlZywgdTMy
IHZhbHVlKQ0KPj4gLXsNCj4+IC0Jd3JpdGVsX3JlbGF4ZWQodmFsdWUsIGFxLT5yZWdzICsgcmVn
KTsNCj4+IC19DQo+PiAtDQo+PiAgc3RhdGljIGlubGluZSBib29sIGlzX2NvbXBhdGlibGUoY29u
c3Qgc3RydWN0IHNwaV9tZW1fb3AgKm9wLA0KPj4gIAkJCQkgY29uc3Qgc3RydWN0IHFzcGlfbW9k
ZSAqbW9kZSkNCj4+ICB7DQo+PiBAQCAtMjI5LDYgKzIxOCw3IEBAIHN0YXRpYyBib29sIGF0bWVs
X3FzcGlfc3VwcG9ydHNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwNCj4+ICBzdGF0aWMgaW50IGF0
bWVsX3FzcGlfZXhlY19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLCBjb25zdCBzdHJ1Y3Qgc3BpX21l
bV9vcCAqb3ApDQo+PiAgew0KPj4gIAlzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEgPSBzcGlfY29udHJv
bGxlcl9nZXRfZGV2ZGF0YShtZW0tPnNwaS0+bWFzdGVyKTsNCj4+ICsJdm9pZCBfX2lvbWVtICpi
YXNlID0gYXEtPnJlZ3M7DQo+IA0KPiBDYW4gd2UgbmFtZSB0aGlzIHZhcmlhYmxlIHJlZ3MgaW5z
dGVhZCBvZiBiYXNlIG9yIGV2ZW4gZ2V0IHJpZCBvZiBpdA0KPiBhbmQgZGVyZWZlcmVuY2UgYXEt
PnJlZ3MgaW4gdGhlIHh4eF9yZWxheGVkKCkgY2FsbHMgKGRvZXNuJ3QgbG9vayBsaWtlDQo+IHRo
ZSBsaW5lcyB3b3VsZCBiZSBvdmVyIDgwIGNoYXJzIGV2ZW4gd2hlbiBkb2luZyB0aGF0KS4gV2l0
aCB0aGlzDQo+IGFkZHJlc3NlZCwgeW91IGNhbiBhZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogQm9y
aXMgQnJlemlsbG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+DQoNCkkgY2hvc2UgdG8gaW50cm9k
dWNlIHRoZSAiYmFzZSIgdmFyaWFibGUgd2hlbiBJIGhhdmUgYXQgbGVhc3QgMiBkZXJlZmVyZW5j
ZXMgaW4NCmEgZnVuY3Rpb24sIGFzIGFuIG9wdGltaXphdGlvbi4gSW4gZXhlY19vcCgpIGZvciBl
eGFtcGxlLCB0aGVyZSBhcmUgNg0KZGVyZWZlcmVuY2VzIG9mIGFxLT5yZXFzLiBXaHkgZG8geW91
IHByZWZlciBrZWVwaW5nIGFxLT5yZWdzPw0K
