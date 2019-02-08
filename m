Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D81C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1777E206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FgnxrpOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfBHPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:53:51 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:11909 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBHPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:53:51 -0500
X-IronPort-AV: E=Sophos;i="5.58,348,1544511600"; 
   d="scan'208";a="26002642"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Feb 2019 08:53:50 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 8 Feb 2019 08:53:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfUX/BKxKKp+KuUcrHEUdLhz45z2XCFya2ivk0Mtmfg=;
 b=FgnxrpOt1KG11OUJSoXOwspGPSBLJVdFRFdsUEe7fJNe6ETC8FtMVjJjXE8yhA/V5NygK58ZJzr1UfVv+bw0lGjGUcBpO6xKHg1wJaDf8ZFGz8uixlJPokO2Us6rDFOmcyXXGqqHVq+lmB4OYD0wpJ3ivW9dNppKviRZwI4qq+0=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1247.namprd11.prod.outlook.com (10.169.236.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:53:47 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 15:53:47 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>
CC:     <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: fix masterck name
Thread-Topic: [PATCH] clk: at91: fix masterck name
Thread-Index: AQHUv7x/dAWxQXybc0i6K8XkGPakkqXWDXGA
Date:   Fri, 8 Feb 2019 15:53:47 +0000
Message-ID: <db6b542f-add1-af4c-e3f1-ce293042f375@microchip.com>
References: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0442.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::22) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1247;6:NQXazG1vRiUS8YmPueohkpGlcyuLBrF/AqrpSPKeFO5XC/KSTgeHcPmnFvPBcouoAgpbzZXew7Oppzsev+dLnC4DflHodc5rOMLydO2QY5X6KG0svSHagLhRG5oClhz5vmJ/7q9HEDJf56d814bBLzrLoqsmEWDQ3jkCQAm+QVfk9xp9JkUENKfYNc4QMwRLlwjf3ZO8iAXEUd7jk295WyRBBIP4MoFB7ALZ/PtQl7AnnhLJcl2tblQzhlCq23OOf+F+TjpIJ+7tq/nEiaoLjl0PcE9RxsRNticNOk0yZVOMzegPbgn1Qdn23Ngj/Ld6v/ChLwyeUMtdyVMBYzwUPvMBmK8CLceUgw3bdsTKlbI2pcYVzWM/zckbbujkrXOOLeRdnaOCMbMjOoQy55EfULse26NmY9mjjLQ+nVrwzYAkNNz464m90VrBCv1LFgT/vaMZx3tH7I40312rzSD0zQ==;5:rmb0Nr1GDydrPp9pJ4qlTi7ngPatBnpGA31WYrn3djKJ3o+JTEGbBY6Fl3pMTvB+XwiLGH5yuyTsNeclgLAPMCkN6ed+GbzWv1SjArQQsUVtSDDE5dkoYZcvGZGxXk5Ow90w6BREKW2i7swiCS2kFXBOjrYGJJ5BSvjJUYJx7bdbd9CHBErFUVwYG/KnU1xzmZfAGacpE7XoY48aIa5I4g==;7:7APSFt6P+3smqd4AScxcPpO5s+NQOSWPeqdTYhr3xDc9uIngk5dRvpG0cNNQZN14sd/nEa9utn8OjWossEanvShbrAk2TOExDjKn3NARKAvntySF/E29COx3xXgYmTsPsAsT8bQ1k/iQrPgTXHD3Tg==
x-ms-office365-filtering-correlation-id: 605c7a5e-3450-48c2-a63d-08d68ddd9c2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1247;
x-ms-traffictypediagnostic: MWHPR11MB1247:
x-microsoft-antispam-prvs: <MWHPR11MB1247F6F244B925ED29DA8E18E0690@MWHPR11MB1247.namprd11.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(97736004)(106356001)(476003)(105586002)(486006)(53936002)(6512007)(6246003)(26005)(2616005)(86362001)(6486002)(4326008)(6436002)(11346002)(446003)(31686004)(14454004)(31696002)(25786009)(36756003)(14444005)(53546011)(66066001)(99286004)(229853002)(71200400001)(71190400001)(54906003)(316002)(102836004)(72206003)(76176011)(3846002)(110136005)(52116002)(6506007)(6116002)(256004)(8936002)(305945005)(478600001)(8676002)(81156014)(81166006)(186003)(68736007)(2906002)(7736002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1247;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8NK2O1V2Hgax9CVlvZUIqN6HvvN923ZRz3cPit8N7qpi0X58kbDD1t2YIp8Xlhoybdq8qTqVVAcN/SQc1n8SbYnLBR93r2tkS0U5gSf8avTu2utVW5B/Rg99ee3mgo2Q9hRGVrsaAeUxD69iNL5wYGtbwwx6qdMNP0gIhIaYqvTT78K36B4da5w3K6e8jCdQ/TAildo6Q76Gc/dV/xmmevJ7NyM2hg1cxJFM7WG9KvjzxqobUY4RN4U/wKj+0R7EFEK24ARxgQleCowakNJphLUndxr/Yk27ZmZI82PDzfjp/9QR4BlHEbVYnUzx1ML8g7nEKD4WoDVs0wzL2c2RON0PjWaS5ENxBOqdVLJAkq2FpalPUetpaSORfVRGOPs3UCEPQVTzes/7CBirvoaRPZluoYzPV6A1G2PO1ye35xk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E1277669F1FE342A03D64FA37C336CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 605c7a5e-3450-48c2-a63d-08d68ddd9c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:53:45.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1247
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDIvMjAxOSBhdCAxNTo0MCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IFRoZSBt
YXN0ZXIgY2xvY2sgaXMgYWN0dWFsbHkgbmFtZWQgbWFzdGVyY2sgZWFybGllciBpbiB0aGUgZHJp
dmVyLiBIYXZpbmcNCj4gIm1jayIgaW4gdGhlIHBhcmVudCBsaXN0IG1lYW5zIHRoYXQgaXQgY2Fu
IG5ldmVyIGJlIHNlbGVjdGVkLg0KPiANCj4gRml4ZXM6IDFlYWJkYzJmOWRkOCAoImNsazogYXQ5
MTogYWRkIGF0OTFzYW05eDUgUE1DcyBkcml2ZXIiKQ0KPiBGaXhlczogYTIwMzgwNzdkZTlhICgi
Y2xrOiBhdDkxOiBhZGQgc2FtYTVkMiBQTUMgZHJpdmVyIikNCj4gRml4ZXM6IDA4NGI2OTZiYjUw
OSAoImNsazogYXQ5MTogYWRkIHNhbWE1ZDQgcG1jIGRyaXZlciIpDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQoN
CkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQoN
Cj4gLS0tDQo+ICAgZHJpdmVycy9jbGsvYXQ5MS9hdDkxc2FtOXg1LmMgfCAyICstDQo+ICAgZHJp
dmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMgICAgfCA0ICsrLS0NCj4gICBkcml2ZXJzL2Nsay9hdDkx
L3NhbWE1ZDQuYyAgICB8IDIgKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2F0
OTFzYW05eDUuYyBiL2RyaXZlcnMvY2xrL2F0OTEvYXQ5MXNhbTl4NS5jDQo+IGluZGV4IDJmZTIy
NWE2OTdkZi4uZDU1YTE1MWNiN2Y1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkxL2F0
OTFzYW05eDUuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05eDUuYw0KPiBAQCAt
MjEwLDcgKzIxMCw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBhdDkxc2FtOXg1X3BtY19zZXR1cChz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiAgIAlwYXJlbnRfbmFtZXNbMV0gPSAibWFpbmNrIjsN
Cj4gICAJcGFyZW50X25hbWVzWzJdID0gInBsbGFkaXZjayI7DQo+ICAgCXBhcmVudF9uYW1lc1sz
XSA9ICJ1dG1pY2siOw0KPiAtCXBhcmVudF9uYW1lc1s0XSA9ICJtY2siOw0KPiArCXBhcmVudF9u
YW1lc1s0XSA9ICJtYXN0ZXJjayI7DQo+ICAgCWZvciAoaSA9IDA7IGkgPCAyOyBpKyspIHsNCj4g
ICAJCWNoYXIgbmFtZVs2XTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEv
c2FtYTVkMi5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMNCj4gaW5kZXggZDY5YWQ5NmZl
OTg4Li5jZDBlZjcyNzRmZGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVk
Mi5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jDQo+IEBAIC0yNDAsNyArMjQw
LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHNhbWE1ZDJfcG1jX3NldHVwKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnApDQo+ICAgCXBhcmVudF9uYW1lc1sxXSA9ICJtYWluY2siOw0KPiAgIAlwYXJlbnRf
bmFtZXNbMl0gPSAicGxsYWRpdmNrIjsNCj4gICAJcGFyZW50X25hbWVzWzNdID0gInV0bWljayI7
DQo+IC0JcGFyZW50X25hbWVzWzRdID0gIm1jayI7DQo+ICsJcGFyZW50X25hbWVzWzRdID0gIm1h
c3RlcmNrIjsNCj4gICAJZm9yIChpID0gMDsgaSA8IDM7IGkrKykgew0KPiAgIAkJY2hhciBuYW1l
WzZdOw0KPiAgIA0KPiBAQCAtMjkxLDcgKzI5MSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1h
NWQyX3BtY19zZXR1cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgIAlwYXJlbnRfbmFtZXNb
MV0gPSAibWFpbmNrIjsNCj4gICAJcGFyZW50X25hbWVzWzJdID0gInBsbGFkaXZjayI7DQo+ICAg
CXBhcmVudF9uYW1lc1szXSA9ICJ1dG1pY2siOw0KPiAtCXBhcmVudF9uYW1lc1s0XSA9ICJtY2si
Ow0KPiArCXBhcmVudF9uYW1lc1s0XSA9ICJtYXN0ZXJjayI7DQo+ICAgCXBhcmVudF9uYW1lc1s1
XSA9ICJhdWRpb3BsbF9wbWNjayI7DQo+ICAgCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHNh
bWE1ZDJfZ2NrKTsgaSsrKSB7DQo+ICAgCQlodyA9IGF0OTFfY2xrX3JlZ2lzdGVyX2dlbmVyYXRl
ZChyZWdtYXAsICZwbWNfcGNyX2xvY2ssDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkx
L3NhbWE1ZDQuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkNC5jDQo+IGluZGV4IGUzNThiZTdm
NmM4ZC4uYjY0NWE5ZDU5Y2RiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1
ZDQuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDQuYw0KPiBAQCAtMjA3LDcgKzIw
Nyw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1hNWQ0X3BtY19zZXR1cChzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5wKQ0KPiAgIAlwYXJlbnRfbmFtZXNbMV0gPSAibWFpbmNrIjsNCj4gICAJcGFyZW50
X25hbWVzWzJdID0gInBsbGFkaXZjayI7DQo+ICAgCXBhcmVudF9uYW1lc1szXSA9ICJ1dG1pY2si
Ow0KPiAtCXBhcmVudF9uYW1lc1s0XSA9ICJtY2siOw0KPiArCXBhcmVudF9uYW1lc1s0XSA9ICJt
YXN0ZXJjayI7DQo+ICAgCWZvciAoaSA9IDA7IGkgPCAzOyBpKyspIHsNCj4gICAJCWNoYXIgbmFt
ZVs2XTsNCj4gICANCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
