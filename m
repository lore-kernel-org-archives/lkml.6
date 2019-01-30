Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0038C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B01F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ztA7pBzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfA3IMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:12:05 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:65429 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3IME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:12:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="27045087"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 01:12:01 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 01:12:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cVeOWfck1Fa8s0qS/zWkWe6PQQ7hj8OlvtoyKxWsqk=;
 b=ztA7pBzP+hhG3uODMHzK2G8lwaA0PSYSBQrjnREpMyO7v61VKWUmMV7Ns20vnOuuakRyk4EUyka1OljZ2x5vA7cE/bl5rYbHDnaZmqsIpMP7SSZslkGlwkF6GhCi8uq89agRyzj5FP0gtJIohtI+8+RZHU5x39sHms62eQuQP2I=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1439.namprd11.prod.outlook.com (10.172.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 08:11:59 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 08:11:59 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <gustavo@embeddedor.com>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <davem@davemloft.net>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Thread-Topic: [PATCH] can: mark expected switch fall-throughs
Thread-Index: AQHUuHN5YrHubPv1+kWISVHRiH0OqQ==
Date:   Wed, 30 Jan 2019 08:11:59 +0000
Message-ID: <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
References: <20190129180612.GA28650@embeddedor>
In-Reply-To: <20190129180612.GA28650@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1439;6:NcGQV14nWiMBVYgpJzLkQ25raJHffE5NjA5a3UqskVoV0+neWfz5vbf56RDPgBii+OAVr6GLqUGLU9s314DqgAsaSZ5LGBjAMn3Xd5hXP72NoQx8AQR6X1rXMWQMyR7KgMWvRmoDeivoPpSj8y3jKe75O9FwoVWYDwg9QRyLAfkWK91E55kcBEcQ4eooUcrMNce0aDeQeknC+UecTNt//OB5TlaLubEtJKrfLVsUTVPxCzccYi036gBt0aXkosdO1FnQ0+FeQ4U+Lxo75YO+cxv83HL/3tOz02EKhuIcsAM2OdD0JdtHrNm6tSQ+7CH26Wjm74BCPXFdYeJaOGKjHE6/yDzi115GV2OpgSDSiQjLDTYrFKEZhMT/DbH9R5mEQ/NJV3IBD3hxDmN5ktaR4QSCokaG2KMUOP7DoMd/7htx55ZPW/gpDbdB8GTOnyhAn3eic2vwk1+YKXNfQnTPkQ==;5:GiDnPxVGz1KHGrw3jnEL9ODqoiRf2Us6oCCWO9U93W0H+Pj79IOxwGgw0idmIjql9GcHmO2Q7CUPWAJb8UaTB6Ijcw8p1kYnFhtDk2EPM9CwnhBpXzxepVXbW3VAo2XMhejOnj5eD0eF7Qnd0uh0yiUNzumxq576RpgwnP5816CZoGfTRqZFPP+Q0PaUfOcVz2mL+7isTtrSkyVHUBXiVQ==;7:lmEs3fmyn/3VBaiM4+FU/g1hLZAnGjTfbuQd82bMesEX+HcG3zRNB3j/Jc56Lx3Mw/zNmnol4rbxIjqCthSD3H7DQryALicH2AVKvqy3JKCbLPA+p071Z158JEzhoSlU1yx5Y+iEWtyYIBD2m3w7Sg==
x-ms-office365-filtering-correlation-id: aece4843-f31a-4785-161c-08d6868a9ba6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1439;
x-ms-traffictypediagnostic: MWHPR11MB1439:
x-microsoft-antispam-prvs: <MWHPR11MB143957AB9EF59585AF0736D0E0900@MWHPR11MB1439.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(8936002)(3846002)(2906002)(105586002)(14454004)(478600001)(106356001)(305945005)(229853002)(6116002)(97736004)(31686004)(72206003)(99286004)(8676002)(7736002)(6636002)(81156014)(81166006)(14444005)(256004)(486006)(36756003)(54906003)(2616005)(446003)(110136005)(6436002)(52116002)(386003)(6512007)(476003)(76176011)(68736007)(6486002)(71190400001)(31696002)(26005)(102836004)(11346002)(86362001)(6246003)(25786009)(71200400001)(186003)(66066001)(4326008)(316002)(6506007)(53546011)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1439;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ieleTcLk4bZJASM8QNnvi9sEaf2n1nQUyIga3SPOdZbo0vEtuY3Xts08LClDrWw/3hSBAR+Yv/0x/G7D5K+Pt85WrGg+Jo8UI3ZO5XGf1LqIKJvWP6kH4ftLaDmDx7avGyFJgDFyrFHDSEhB2lhlmp1OWExIalF9W+ib8cbYL4EGy2dR/SEcql6NdWnCwpom5agMACRVSsM3bPjpa8x6XkuvNfWITGb/7im1snL8DoPAj+22OOxmxZDUaIKAxasxcfMSQKOwmRvJA8wY0708c7J5zZZVcjTSN127Z1rVIltDq87+pMlAz9rqEJ/utGuO68yYUdp+7wBg0Im6d1AtPtWFoLuBarMVlubsKt0YykqqxI/AcI4rqNEsKdr2BSOD1HWL0XdBG/xrsfqEHDCTAT7/wrhGc/4yvSpdL9T9sT8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92A2D6A9DA81A24DB2EC2D0260FDF749@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aece4843-f31a-4785-161c-08d6868a9ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 08:11:56.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1439
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDEvMjAxOSBhdCAxOTowNiwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gSW4g
cHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBzd2l0
Y2ggY2FzZXMNCj4gd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guDQo+IA0K
PiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZ3M6DQo+IA0KPiBkcml2ZXJz
L25ldC9jYW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9tYWluLmM6NjY4OjM6IHdhcm5pbmc6IHRo
aXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQ0K
PiBkcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYzo4NzU6Nzogd2FybmluZzogdGhpcyBzdGF0
ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+IGRyaXZl
cnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYzo0MjI6Njogd2FybmluZzogdGhpcyBz
dGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+IGRy
aXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jOjg5NTo2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBt
YXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gZHJpdmVycy9uZXQv
Y2FuL2F0OTFfY2FuLmM6OTUzOjE1OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0
aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gZHJpdmVycy9uZXQvY2FuL3VzYi9w
ZWFrX3VzYi9wY2FuX3VzYi5jOiBJbiBmdW5jdGlvbiDigJhwY2FuX3VzYl9kZWNvZGVfZXJyb3Li
gJk6DQo+IGRyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYzo0MjI6Njogd2Fy
bmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhy
b3VnaD1dDQo+ICAgICBpZiAobiAmIFBDQU5fVVNCX0VSUk9SX0JVU19MSUdIVCkgew0KPiAgICAg
ICAgXg0KPiBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmM6NDI4OjI6IG5v
dGU6IGhlcmUNCj4gICAgY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoNCj4gICAgXn5+fg0K
PiANCj4gV2FybmluZyBsZXZlbCAzIHdhcyB1c2VkOiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMN
Cj4gDQo+IFRoaXMgcGF0Y2ggaXMgcGFydCBvZiB0aGUgb25nb2luZyBlZmZvcnRzIHRvIGVuYWJs
aW5nDQo+IC1XaW1wbGljaXQtZmFsbHRocm91Z2guDQo+IA0KPiBOb3RpY2UgdGhhdCBpbiBzb21l
IGNhc2VzIHNwZWxsaW5nIG1pc3Rha2VzIHdlcmUgZml4ZWQuDQo+IEluIG90aGVyIGNhc2VzLCB0
aGUgLyogZmFsbCB0aHJvdWdoICovIGNvbW1lbnQgaXMgcGxhY2VkDQo+IGF0IHRoZSBib3R0b20g
b2YgdGhlIGNhc2Ugc3RhdGVtZW50LCB3aGljaCBpcyB3aGF0IEdDQw0KPiBpcyBleHBlY3Rpbmcg
dG8gZmluZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rh
dm9AZW1iZWRkZWRvci5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5j
ICAgICAgICAgICAgICAgICAgICB8IDYgKysrKy0tDQoNCkZvciB0aGlzIG9uZToNCkFja2VkLWJ5
OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQoNCj4gICBkcml2
ZXJzL25ldC9jYW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9tYWluLmMgfCAyICstDQo+ICAgZHJp
dmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4LmMgICAgICAgICAgICAgICAgIHwgMyArKy0NCj4gICBk
cml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmMgICAgICAgfCAyICstDQo+ICAg
NCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMgYi9kcml2ZXJzL25ldC9jYW4v
YXQ5MV9jYW4uYw0KPiBpbmRleCBkOThjNjkwNDViMTcuLjE3MThjMjBmOWM5OSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvY2Fu
L2F0OTFfY2FuLmMNCj4gQEAgLTkwMiw3ICs5MDIsOCBAQCBzdGF0aWMgdm9pZCBhdDkxX2lycV9l
cnJfc3RhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj4gICAJCQkJQ0FOX0VSUl9DUlRMX1RY
X1dBUk5JTkcgOg0KPiAgIAkJCQlDQU5fRVJSX0NSVExfUlhfV0FSTklORzsNCj4gICAJCX0NCj4g
LQljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgkvKiBmYWxsdGhyb3VnaCAqLw0KPiArCQkv
KiBmYWxsIHRocm91Z2ggKi8NCj4gKwljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOg0KPiAg
IAkJLyoNCj4gICAJCSAqIGZyb206IEVSUk9SX0FDVElWRSwgRVJST1JfV0FSTklORw0KPiAgIAkJ
ICogdG8gIDogRVJST1JfUEFTU0lWRSwgQlVTX09GRg0KPiBAQCAtOTUxLDcgKzk1Miw4IEBAIHN0
YXRpYyB2b2lkIGF0OTFfaXJxX2Vycl9zdGF0ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiAg
IAkJbmV0ZGV2X2RiZyhkZXYsICJFcnJvciBBY3RpdmVcbiIpOw0KPiAgIAkJY2YtPmNhbl9pZCB8
PSBDQU5fRVJSX1BST1Q7DQo+ICAgCQljZi0+ZGF0YVsyXSA9IENBTl9FUlJfUFJPVF9BQ1RJVkU7
DQo+IC0JY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJLyogZmFsbHRocm91Z2ggKi8NCj4g
KwkJLyogZmFsbCB0aHJvdWdoICovDQo+ICsJY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoN
Cj4gICAJCXJlZ19pZHIgPSBBVDkxX0lSUV9FUlJBIHwgQVQ5MV9JUlFfV0FSTiB8IEFUOTFfSVJR
X0JPRkY7DQo+ICAgCQlyZWdfaWVyID0gQVQ5MV9JUlFfRVJSUDsNCj4gICAJCWJyZWFrOw0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5j
IGIvZHJpdmVycy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jDQo+IGluZGV4
IGM0NThkNWZkYzhkMy4uZTRmNGQ2NWE3NmI0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9j
YW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvY2Fu
L3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jDQo+IEBAIC02NjgsNyArNjY4LDcgQEAgc3Rh
dGljIGludCBwY2llZmRfY2FuX3Byb2JlKHN0cnVjdCBwY2llZmRfYm9hcmQgKnBjaWVmZCkNCj4g
ICAJCXBjaWVmZF9jYW5fd3JpdGVyZWcocHJpdiwgQ0FORkRfQ0xLX1NFTF84ME1IWiwNCj4gICAJ
CQkJICAgIFBDSUVGRF9SRUdfQ0FOX0NMS19TRUwpOw0KPiAgIA0KPiAtCQkvKiBmYWxsdGhvdWdo
ICovDQo+ICsJCS8qIGZhbGwgdGhyb3VnaCAqLw0KPiAgIAljYXNlIENBTkZEX0NMS19TRUxfODBN
SFo6DQo+ICAgCQlwcml2LT51Y2FuLmNhbi5jbG9jay5mcmVxID0gODAgKiAxMDAwICogMTAwMDsN
Cj4gICAJCWJyZWFrOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4
LmMgYi9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYw0KPiBpbmRleCBlOTA4MTc2MDg2NDUu
LjE3MjU3YzczYzMwMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4LmMNCj4gQEAgLTg3NSw3ICs4
NzUsOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbWNwMjUxeF9jYW5faXN0KGludCBpcnEsIHZvaWQg
KmRldl9pZCkNCj4gICAJCQlpZiAobmV3X3N0YXRlID49IENBTl9TVEFURV9FUlJPUl9XQVJOSU5H
ICYmDQo+ICAgCQkJICAgIG5ld19zdGF0ZSA8PSBDQU5fU1RBVEVfQlVTX09GRikNCj4gICAJCQkJ
cHJpdi0+Y2FuLmNhbl9zdGF0cy5lcnJvcl93YXJuaW5nKys7DQo+IC0JCWNhc2UgQ0FOX1NUQVRF
X0VSUk9SX1dBUk5JTkc6CS8qIGZhbGx0aHJvdWdoICovDQo+ICsJCQkvKiBmYWxsIHRocm91Z2gg
Ki8NCj4gKwkJY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoNCj4gICAJCQlpZiAobmV3X3N0
YXRlID49IENBTl9TVEFURV9FUlJPUl9QQVNTSVZFICYmDQo+ICAgCQkJICAgIG5ld19zdGF0ZSA8
PSBDQU5fU1RBVEVfQlVTX09GRikNCj4gICAJCQkJcHJpdi0+Y2FuLmNhbl9zdGF0cy5lcnJvcl9w
YXNzaXZlKys7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3Bj
YW5fdXNiLmMgYi9kcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmMNCj4gaW5k
ZXggMTMyMzhhNzJhMzM4Li5lY2E3ODU1MzJiNmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYw0KPiArKysgYi9kcml2ZXJzL25ldC9jYW4vdXNi
L3BlYWtfdXNiL3BjYW5fdXNiLmMNCj4gQEAgLTQyMyw3ICs0MjMsNyBAQCBzdGF0aWMgaW50IHBj
YW5fdXNiX2RlY29kZV9lcnJvcihzdHJ1Y3QgcGNhbl91c2JfbXNnX2NvbnRleHQgKm1jLCB1OCBu
LA0KPiAgIAkJCW5ld19zdGF0ZSA9IENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOw0KPiAgIAkJCWJy
ZWFrOw0KPiAgIAkJfQ0KPiAtCQkvKiBlbHNlOiBmYWxsIHRocm91Z2ggKi8NCj4gKwkJLyogZmFs
bCB0aHJvdWdoICovDQo+ICAgDQo+ICAgCWNhc2UgQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkc6DQo+
ICAgCQlpZiAobiAmIFBDQU5fVVNCX0VSUk9SX0JVU19IRUFWWSkgew0KPiANCg0KDQotLSANCk5p
Y29sYXMgRmVycmUNCg==
