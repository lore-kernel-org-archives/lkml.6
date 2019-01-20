Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8226C636A2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF2214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hoPofmoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfATO4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 09:56:48 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4729 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfATO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 09:56:47 -0500
X-IronPort-AV: E=Sophos;i="5.56,499,1539673200"; 
   d="scan'208";a="25547920"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Jan 2019 07:56:46 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 20 Jan 2019 07:56:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDX3Jxit3kh+vZtT2NVF8aGOrRlNIil2/0oqz7Hutdg=;
 b=hoPofmoPEHyMSK+t2NuTbKs5qEpxQuyjtzSHIzNRVU4h6iiJpoFW63jXVaTJ+l5hPAd2PidutR8ZY5FalFw0kNDMc8SlPKY5XqZN9M9tMdxsVZscRC1Q/eHYGHdAK3rtJXfyIksS7gJbeiNqr8X6aCtXh/W2h1/rxIYQog7eG7o=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB1483.namprd11.prod.outlook.com (10.172.36.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Sun, 20 Jan 2019 14:56:42 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1%10]) with mapi id 15.20.1537.031; Sun, 20 Jan
 2019 14:56:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <bbrezillon@kernel.org>
CC:     <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Thread-Topic: [PATCH v3 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Thread-Index: AQHUrYaDrXUj68GKYkqwbPlWtM/dE6W4RZ4A
Date:   Sun, 20 Jan 2019 14:56:42 +0000
Message-ID: <6e6f7c3a-4772-1a17-0f5f-547ea9809283@microchip.com>
References: <20190116103027.22657-1-vigneshr@ti.com>
 <20190116103027.22657-3-vigneshr@ti.com>
In-Reply-To: <20190116103027.22657-3-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::31) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.121.188.235]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1483;6:UBhHxVezT8VOgi+rjEH64/gYKJsQHp+RPAMlyZsVtzR4CL+WsjXTGHax8ANbXfKrd3zcEyRzbvrtqvbAl7ilzQhM15H2z2vQGR21MppDmmHQpS4J5ZZWaF3T7whAP8qih+yCvFv08qstk/Pxqp0PY1wvLtRr8DfidZgMRKHdtSw2T//eGzA7Kd0sgVtAXRtRG/hN/ingX/INLLzoycWBOND1Oaa2ty5tyqucsGpkEhHFb6WiiZscCSuwVkK7Ax5yArlRV4Kq+lQVeW6D02s0/4kSuf4kD81wiOn1C70q/v97LVxl4UCxMXPK5MSgQiVz0opU8B4v0k4PWkjUwHYWS67irkgB9BA9Jj5dIj4gUvnOqz/m2FVZwANo60vrvkQywWy9gNSx4lTfFaaS+VtgK9249SnqZ8X8WIQ/JhB4wkdAm25hK8nfd7uYdfwdw9unZkA98+aovuWAHVi88ocVgA==;5:9KnOiXwWuirQeiR+FqVos0fTbBlsa7ZxaTLWZAS19+nAsNnx+NFyopLuQ0bDbHDD5FBjDMpitPV2re4bM82L9aR6PIfbOjH1OYFAtOq/o/dZwSY54flg3nt8+sqlCvJIOQozzJaWE3bYmDNZwzzB8cSUFEJOKtrV5jzACw3nokU1Led8xodvEXMFnQ4S8BpjxZr4ZFsW+9Z+WPH8g8fD7g==;7:y2N7Kzdw7U13Q2Bej0nTgMxOCF54D43mQZHn4C8Fefj5o32bMFqqS61gckls2Q+CHcUFTdNGD9GQ64wk8+K/JFSda5cmWWPh90uFf7a/UstH2ZXCelP3uxBvqnG7UeaOl9b+WahW83AExgynOzzy1A==
x-ms-office365-filtering-correlation-id: 0d16e82d-ecbb-4da1-4463-08d67ee77cf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1483;
x-ms-traffictypediagnostic: DM5PR11MB1483:
x-microsoft-antispam-prvs: <DM5PR11MB1483A186B6B7CF2967FED1C9F09E0@DM5PR11MB1483.namprd11.prod.outlook.com>
x-forefront-prvs: 0923977CCA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(189003)(11346002)(446003)(52116002)(478600001)(76176011)(97736004)(110136005)(31686004)(386003)(102836004)(6506007)(72206003)(53546011)(316002)(14454004)(26005)(6116002)(68736007)(2906002)(66066001)(54906003)(2616005)(3846002)(31696002)(86362001)(476003)(486006)(106356001)(186003)(6246003)(14444005)(71190400001)(71200400001)(81166006)(229853002)(4326008)(105586002)(256004)(53936002)(305945005)(6512007)(6486002)(36756003)(8676002)(81156014)(6436002)(25786009)(39060400002)(8936002)(99286004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1483;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uvTUf4nWz6Zmuim4sHaoDKw8FMmUK+fANgiIyhCyIfbn42/uPJcuTkqkj9v9qXDRTJ9Da/FmD8OZPBST1A6jikX6ThpL5hL9y8S4zXOA0tTNOhqEDRYhNnhEBTYgjHDWmyRv0664JkC4z6Nt3n2Yb9W8zpM9ykqgQ5tBwNDbS+YyiTzQduPt4cj9N7hnFgeFQvHbXbKThxCXphWOxBGux+TfhIbZn7fxOqa3UL8bAsXsXtVUQOrDZhMUzjluP+TZ6jBd5z5u5eRlZVwdvjKyZpVW6Z+cMUyefolP3eGHnUWurHR+QYmHxqxRc3bDgPOWCXtW1E9JI4+IUsQPkPrmbZZ2cBNK1tsrOg41aOIi5qksUlhme6Cmlx0WE0FndhFfOgiYcaZQ3z7RHBKHawlNsq1/yKa05xocd9uCHYp5b+c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A099F846579D24294CF38020A4C0E14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d16e82d-ecbb-4da1-4463-08d67ee77cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2019 14:56:40.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1483
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpZ25lc2gsDQoNCk9uIDAxLzE2LzIwMTkgMTI6MzAgUE0sIFZpZ25lc2ggUiB3cm90ZToN
Cj4gQ2FkZW5jZSBPU1BJIGNvbnRyb2xsZXIgSVAgc3VwcG9ydHMgT2N0YWwgSU8gKHg4IElPIGxp
bmVzKSwNCj4gSXQgYWxzbyBoYXMgYW4gaW50ZWdyYXRlZCBQSFkuIElQIHJlZ2lzdGVyIGxheW91
dCBpcyB2ZXJ5DQo+IHNpbWlsYXIgdG8gZXhpc3RpbmcgUVNQSSBJUCBleGNlcHQgZm9yIGFkZGl0
aW9uYWwgYml0cyB0byBzdXBwb3J0IE9jdGFsDQo+IGFuZCBPY3RhbCBERFIgbW9kZS4gVGhlcmVm
b3JlLCBleHRlbmQgY3VycmVudCBkcml2ZXIgdG8gc3VwcG9ydCBPY3RhbA0KPiBtb2RlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogVmlnbmVzaCBSIDx2aWduZXNockB0aS5jb20+DQo+IC0tLQ0KPiB2
MzogTm8gY2hhbmdlcw0KPiANCj4gdjI6DQo+IERlY2xhcmUgT2N0YWwgbW9kZSBjYXBhYmlsaXR5
IGJhc2VkIG9uIGNvbXBhdGlibGUuDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNl
LXF1YWRzcGkuYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jDQo+IGluZGV4IDA0Y2VkZDNhMmJmNi4uMzFlZDUwZjc4
OTcyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5j
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMNCj4gQEAgLTkz
LDYgKzkzLDExIEBAIHN0cnVjdCBjcXNwaV9zdCB7DQo+ICAJc3RydWN0IGNxc3BpX2ZsYXNoX3Bk
YXRhIGZfcGRhdGFbQ1FTUElfTUFYX0NISVBTRUxFQ1RdOw0KPiAgfTsNCj4gIA0KPiArc3RydWN0
IGNxc3BpX2RyaXZlcl9wbGF0ZGF0YSB7DQo+ICsJdTMyIGh3Y2Fwc19tYXNrOw0KPiArCXU4IHF1
aXJrczsNCj4gK307DQo+ICsNCj4gIC8qIE9wZXJhdGlvbiB0aW1lb3V0IHZhbHVlICovDQo+ICAj
ZGVmaW5lIENRU1BJX1RJTUVPVVRfTVMJCQk1MDANCj4gICNkZWZpbmUgQ1FTUElfUkVBRF9USU1F
T1VUX01TCQkJMTANCj4gQEAgLTEwMSw2ICsxMDYsNyBAQCBzdHJ1Y3QgY3FzcGlfc3Qgew0KPiAg
I2RlZmluZSBDUVNQSV9JTlNUX1RZUEVfU0lOR0xFCQkJMA0KPiAgI2RlZmluZSBDUVNQSV9JTlNU
X1RZUEVfRFVBTAkJCTENCj4gICNkZWZpbmUgQ1FTUElfSU5TVF9UWVBFX1FVQUQJCQkyDQo+ICsj
ZGVmaW5lIENRU1BJX0lOU1RfVFlQRV9PQ1RBTAkJCTMNCj4gIA0KPiAgI2RlZmluZSBDUVNQSV9E
VU1NWV9DTEtTX1BFUl9CWVRFCQk4DQo+ICAjZGVmaW5lIENRU1BJX0RVTU1ZX0JZVEVTX01BWAkJ
CTQNCj4gQEAgLTkxMSw2ICs5MTcsOSBAQCBzdGF0aWMgaW50IGNxc3BpX3NldF9wcm90b2NvbChz
dHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdCBpbnQgcmVhZCkNCj4gIAkJY2FzZSBTTk9SX1BST1RP
XzFfMV80Og0KPiAgCQkJZl9wZGF0YS0+ZGF0YV93aWR0aCA9IENRU1BJX0lOU1RfVFlQRV9RVUFE
Ow0KPiAgCQkJYnJlYWs7DQo+ICsJCWNhc2UgU05PUl9QUk9UT18xXzFfODoNCj4gKwkJCWZfcGRh
dGEtPmRhdGFfd2lkdGggPSBDUVNQSV9JTlNUX1RZUEVfT0NUQUw7DQo+ICsJCQlicmVhazsNCj4g
IAkJZGVmYXVsdDoNCj4gIAkJCXJldHVybiAtRUlOVkFMOw0KPiAgCQl9DQo+IEBAIC0xMjEzLDIx
ICsxMjIyLDE5IEBAIHN0YXRpYyB2b2lkIGNxc3BpX3JlcXVlc3RfbW1hcF9kbWEoc3RydWN0IGNx
c3BpX3N0ICpjcXNwaSkNCj4gIA0KPiAgc3RhdGljIGludCBjcXNwaV9zZXR1cF9mbGFzaChzdHJ1
Y3QgY3FzcGlfc3QgKmNxc3BpLCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgew0KPiAtCWNv
bnN0IHN0cnVjdCBzcGlfbm9yX2h3Y2FwcyBod2NhcHMgPSB7DQo+IC0JCS5tYXNrID0gU05PUl9I
V0NBUFNfUkVBRCB8DQo+IC0JCQlTTk9SX0hXQ0FQU19SRUFEX0ZBU1QgfA0KPiAtCQkJU05PUl9I
V0NBUFNfUkVBRF8xXzFfMiB8DQo+IC0JCQlTTk9SX0hXQ0FQU19SRUFEXzFfMV80IHwNCj4gLQkJ
CVNOT1JfSFdDQVBTX1BQLA0KPiAtCX07DQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diA9IGNxc3BpLT5wZGV2Ow0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+
ICsJc3RydWN0IGNxc3BpX2RyaXZlcl9wbGF0ZGF0YSAqZGRhdGE7DQoNCmNvbnN0IHN0cnVjdCBj
cXNwaV9kcml2ZXJfcGxhdGRhdGEgKmRkYXRhOw0KDQo+ICsJc3RydWN0IHNwaV9ub3JfaHdjYXBz
IGh3Y2FwczsNCj4gIAlzdHJ1Y3QgY3FzcGlfZmxhc2hfcGRhdGEgKmZfcGRhdGE7DQo+ICAJc3Ry
dWN0IHNwaV9ub3IgKm5vcjsNCj4gIAlzdHJ1Y3QgbXRkX2luZm8gKm10ZDsNCj4gIAl1bnNpZ25l
ZCBpbnQgY3M7DQo+ICAJaW50IGksIHJldDsNCj4gIA0KPiArCWRkYXRhID0gKHN0cnVjdCBjcXNw
aV9kcml2ZXJfcGxhdGRhdGEgKilvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCg0KWW91
IGZvcmdvdCB0byBjaGVjayBmb3IgTlVMTC4gQWxzbywgSSB3b3VsZCBleHBlY3QgYW4gaW1wbGlj
aXQgdHlwZSBjYXN0LCB5b3UNCmNhbiBkcm9wIHRoZSBleHBsaWNpdCBjYXN0Lg0KDQo+ICsJaHdj
YXBzLm1hc2sgPSBkZGF0YS0+aHdjYXBzX21hc2s7DQo+ICsNCj4gIAkvKiBHZXQgZmxhc2ggZGV2
aWNlIGRhdGEgKi8NCj4gIAlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZShkZXYtPm9m
X25vZGUsIG5wKSB7DQo+ICAJCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAicmVnIiwg
JmNzKTsNCj4gQEAgLTEzMTAsNyArMTMxNyw3IEBAIHN0YXRpYyBpbnQgY3FzcGlfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1Y3QgY3FzcGlfc3QgKmNxc3BpOw0K
PiAgCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgCXN0cnVjdCByZXNvdXJjZSAqcmVzX2FoYjsN
Cj4gLQl1bnNpZ25lZCBsb25nIGRhdGE7DQo+ICsJc3RydWN0IGNxc3BpX2RyaXZlcl9wbGF0ZGF0
YSAqZGRhdGE7DQoNCmNvbnN0IHN0cnVjdCBjcXNwaV9kcml2ZXJfcGxhdGRhdGEgKmRkYXRhOw0K
DQo+ICAJaW50IHJldDsNCj4gIAlpbnQgaXJxOw0KPiAgDQo+IEBAIC0xMzc3LDggKzEzODQsOCBA
QCBzdGF0aWMgaW50IGNxc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJfQ0KPiAgDQo+ICAJY3FzcGktPm1hc3Rlcl9yZWZfY2xrX2h6ID0gY2xrX2dldF9yYXRlKGNx
c3BpLT5jbGspOw0KPiAtCWRhdGEgID0gKHVuc2lnbmVkIGxvbmcpb2ZfZGV2aWNlX2dldF9tYXRj
aF9kYXRhKGRldik7DQo+IC0JaWYgKGRhdGEgJiBDUVNQSV9ORUVEU19XUl9ERUxBWSkNCj4gKwlk
ZGF0YSAgPSAoc3RydWN0IGNxc3BpX2RyaXZlcl9wbGF0ZGF0YSAqKW9mX2RldmljZV9nZXRfbWF0
Y2hfZGF0YShkZXYpOw0KDQpJIHdvdWxkIGV4cGVjdCBhbiBpbXBsaWNpdCB0eXBlIGNhc3QsIHlv
dSBjYW4gZHJvcCB0aGUgZXhwbGljaXQgY2FzdC4NCg0KPiArCWlmIChkZGF0YSAmJiAoZGRhdGEt
PnF1aXJrcyAmIENRU1BJX05FRURTX1dSX0RFTEFZKSkNCj4gIAkJY3FzcGktPndyX2RlbGF5ID0g
NSAqIERJVl9ST1VORF9VUChOU0VDX1BFUl9TRUMsDQo+ICAJCQkJCQkgICBjcXNwaS0+bWFzdGVy
X3JlZl9jbGtfaHopOw0KPiAgDQo+IEBAIC0xNDYwLDE0ICsxNDY3LDM3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZGV2X3BtX29wcyBjcXNwaV9fZGV2X3BtX29wcyA9IHsNCj4gICNkZWZpbmUgQ1FT
UElfREVWX1BNX09QUwlOVUxMDQo+ICAjZW5kaWYNCj4gIA0KPiArI2RlZmluZSBjcXNwaV9iYXNl
X2h3Y2Fwc19tYXNrCQkJCQlcDQo+ICsJKFNOT1JfSFdDQVBTX1JFQUQgfCBTTk9SX0hXQ0FQU19S
RUFEX0ZBU1QgfAkJXA0KPiArCVNOT1JfSFdDQVBTX1JFQURfMV8xXzIgfCBTTk9SX0hXQ0FQU19S
RUFEXzFfMV80IHwJXA0KPiArCVNOT1JfSFdDQVBTX1BQKQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGNxc3BpX2RyaXZlcl9wbGF0ZGF0YSBjZG5zX3FzcGkgPSB7DQo+ICsJLmh3Y2Fwc19t
YXNrID0gY3FzcGlfYmFzZV9od2NhcHNfbWFzaywNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgY3FzcGlfZHJpdmVyX3BsYXRkYXRhIGsyZ19xc3BpID0gew0KPiArCS5od2NhcHNf
bWFzayA9IGNxc3BpX2Jhc2VfaHdjYXBzX21hc2ssDQo+ICsJLnF1aXJrcyA9IENRU1BJX05FRURT
X1dSX0RFTEFZLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBjcXNwaV9kcml2
ZXJfcGxhdGRhdGEgYW02NTRfb3NwaSA9IHsNCj4gKwkuaHdjYXBzX21hc2sgPSBjcXNwaV9iYXNl
X2h3Y2Fwc19tYXNrIHwgU05PUl9IV0NBUFNfUkVBRF8xXzFfOCwNCj4gKwkucXVpcmtzID0gQ1FT
UElfTkVFRFNfV1JfREVMQVksDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBjcXNwaV9kdF9pZHNbXSA9IHsNCj4gIAl7DQo+ICAJCS5jb21wYXRpYmxlID0g
ImNkbnMscXNwaS1ub3IiLA0KPiAtCQkuZGF0YSA9ICh2b2lkICopMCwNCj4gKwkJLmRhdGEgPSAo
dm9pZCAqKSZjZG5zX3FzcGksDQoNCllvdSBjYW4gZHJvcCB0aGUgKHZvaWQgKikgY2FzdC4NCg0K
TG9va3MgZ29vZC4gRGlkIHlvdSB0ZXN0IHRoZSBvY3RhbCBtb2RlIHdpdGggbXQzNXh1NTEyYWJh
PyBJZiB5ZXMsIGl0IHdvdWxkIGJlDQpuaWNlIHRvIHNwZWNpZnkgdGhpcyBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UuDQoNCkNoZWVycywNCnRhDQoNCj4gIAl9LA0KPiAgCXsNCj4gIAkJLmNvbXBhdGli
bGUgPSAidGksazJnLXFzcGkiLA0KPiAtCQkuZGF0YSA9ICh2b2lkICopQ1FTUElfTkVFRFNfV1Jf
REVMQVksDQo+ICsJCS5kYXRhID0gKHZvaWQgKikmazJnX3FzcGksDQo+ICsJfSwNCj4gKwl7DQo+
ICsJCS5jb21wYXRpYmxlID0gInRpLGFtNjU0LW9zcGkiLA0KPiArCQkuZGF0YSA9ICh2b2lkICop
JmFtNjU0X29zcGksDQo+ICAJfSwNCj4gIAl7IC8qIGVuZCBvZiB0YWJsZSAqLyB9DQo+ICB9Ow0K
PiANCg==
