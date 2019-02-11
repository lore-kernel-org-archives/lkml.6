Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC06C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5E20823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y1z4qdav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfBKJDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:03:36 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:39990 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBKJDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:03:36 -0500
X-IronPort-AV: E=Sophos;i="5.58,358,1544511600"; 
   d="scan'208";a="26369480"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Feb 2019 02:03:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 11 Feb 2019 02:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEdMuHPQybC3whZISou8bW5bawXGlUaEXTQImhlYfYM=;
 b=Y1z4qdavoExP4mnOwkfJ5deu2BKvvGnjUIGaAOfdj8lzqDUafdF+wcwve2EBUyxBGRtGWbfg9V7UQePXRQfvn1B0jqsB3TL4W5PL5bH8JgJBFIOpIoo9+SPw++LYC9qeSp9OD9AC1MBk7kqpFMEEhMjjzAwI/OVvhOzqxUUN4kQ=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1456.namprd11.prod.outlook.com (10.172.53.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 09:03:13 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 09:03:13 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <gustavo@embeddedor.com>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <davem@davemloft.net>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
Thread-Topic: [PATCH][next] can: at91_can: mark expected switch fall-throughs
Thread-Index: AQHUv96tjOVfcaEDgkW1qPEWyqPSIaXaUXYA
Date:   Mon, 11 Feb 2019 09:03:13 +0000
Message-ID: <8119fbe8-5f4b-e45c-6687-ec42aceb3428@microchip.com>
References: <20190208184444.GA28484@embeddedor>
In-Reply-To: <20190208184444.GA28484@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1456;6:79gga67oVy0cF8WADNFwaRkhgP8XBh+xEmA4kaaU3aqEfk78lZSjdzrn12d5ZtVcN9oBCR3mY8O05+J0KvAVTM/+72H2zgAsADsypdykEz4jc1jcwmVjhojFEOtNt1KXaOCJecuwXtFNF7DcexpJfu7CYPLoZRVO3XReTtByMz/+7R+JVzEeNVuQnVXlib3PThzIzioyLrHqzGWzfi+L0U9/PZ8MtDuiHPWRhlSwjUO7OQMYfG797ZJylA0DB6uv+oh57WD9uRH4GnLr7AP6oDZ2DW0XnzCYTtIFvbTQlF5nBvvj4Wb1uAfxMb4naNyqT46vMmm9nDZnShIiJNd8JxAWMocRg1WTY1NkicQJ0dzDlJlMm8sJL3R0f53gpwe3d/HLAK6EskeQKgn6QnpU4KaylxWVVjUDsT9Z9R0kKx1Sc9r6AY2dOk3udam/IYgldXUi32lGnOcs5e3oIh/kdQ==;5:ZF5quZa6RiUVN9QsQlHiXNq/QVPiGbGTgl+27/5CYkTZsofv74YtrFKL/ln/n+DG3VIKkFhi67wSUEP0TUbzSBjExpf92+PxzUqJXJbj4XbzHcfcC6bwhp6O88YuC3Bmkq5xxEZpCuQaQRx+baMRK12Pzu0OxHs0nfupmzRndeRN3GHAnXaswedaPI0+0lCAe3Nl7KNmJXSBlkXziE4+Vw==;7:R+1bFvVNieBOD9FxYTnGmJKBFvMrH5CeWpMzOYDLnh8efDrV4aPDP7mAol1+D4v0J9vgUm7qGBtPIjS+JQ6A2UeLUEEZJJ0kEhddGwrl4wkrWK+AkmGQqhZgJl84FI+1hZg2qg3TnqinFyDP5W0HSw==
x-ms-office365-filtering-correlation-id: 59c2fbae-64ac-4ba9-2b80-08d68fffc084
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1456;
x-ms-traffictypediagnostic: MWHPR11MB1456:
x-microsoft-antispam-prvs: <MWHPR11MB145636EE1D0F39AC0C22B6AAE0640@MWHPR11MB1456.namprd11.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(102836004)(71200400001)(71190400001)(53546011)(6486002)(6436002)(14444005)(256004)(229853002)(26005)(25786009)(4326008)(31686004)(106356001)(86362001)(186003)(68736007)(36756003)(6636002)(31696002)(316002)(110136005)(54906003)(66066001)(14454004)(6512007)(6246003)(446003)(8936002)(11346002)(2906002)(105586002)(8676002)(72206003)(81156014)(81166006)(99286004)(97736004)(2616005)(478600001)(476003)(7736002)(305945005)(3846002)(386003)(6506007)(76176011)(53936002)(6116002)(52116002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1456;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pVqqIOEDeiYtPHr8KZVgZ9riUoCtbGBu6+75YdJwap0kTWDdbKQ11Mfl/cLpcYptXQuorzBqe58j2NjIsSx17h6LRsayihwmro/YG5tMLh8KI8L/66OUheXROeFVP3ISNvcxsLiJbjQoI8JvQMs7+wr55jSZDtNMtiRfKF1xYhfG6sn3ppGLxOntqTxWVMwdvmxyVaCdmdM/27sYKemBeeUr8dKiYDEzKsmJnLlPa7XiBDzTkJ/K7JoUKsenJQ/8OczRND362F2kgvY6Kp6B6oZYtJmw+Z1GCEFRLaXcmv9DFxa5H9znJ1mVI7i4WHCijBDGx+ABpzwOLHQINn9nwEM0T3tOdhXEBjYvU0myhKb2fvFGlQRv9/70R+hixLMxxv20P8PZISfLGIJdcmNGMJr8CMopuhjX8GtDDzPxyjg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20C0511DD1579446A467767CDC4922FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c2fbae-64ac-4ba9-2b80-08d68fffc084
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 09:03:10.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1456
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDIvMjAxOSBhdCAxOTo0NCwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gSW4g
cHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBzd2l0
Y2gNCj4gY2FzZXMgd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guDQo+IA0K
PiBOb3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHRoZSAvKiBmYWxsIHRocm91
Z2ggKi8NCj4gY29tbWVudHMgYXJlIHBsYWNlZCBhdCB0aGUgYm90dG9tIG9mIHRoZSBjYXNlIHN0
YXRlbWVudCwgd2hpY2gNCj4gaXMgd2hhdCBHQ0MgaXMgZXhwZWN0aW5nIHRvIGZpbmQuDQo+IA0K
PiBXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mw0KPiAN
Cj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxpbmcN
Cj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8g
QS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQoNCkxvb2tzIGdvb2QgdG8gbWU6
DQpBY2tlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0K
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jIHwgNiArKysrLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jIGIvZHJpdmVycy9uZXQvY2FuL2F0
OTFfY2FuLmMNCj4gaW5kZXggZDk4YzY5MDQ1YjE3Li4xNzE4YzIwZjljOTkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9h
dDkxX2Nhbi5jDQo+IEBAIC05MDIsNyArOTAyLDggQEAgc3RhdGljIHZvaWQgYXQ5MV9pcnFfZXJy
X3N0YXRlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ICAgCQkJCUNBTl9FUlJfQ1JUTF9UWF9X
QVJOSU5HIDoNCj4gICAJCQkJQ0FOX0VSUl9DUlRMX1JYX1dBUk5JTkc7DQo+ICAgCQl9DQo+IC0J
Y2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJLyogZmFsbHRocm91Z2ggKi8NCj4gKwkJLyog
ZmFsbCB0aHJvdWdoICovDQo+ICsJY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoNCj4gICAJ
CS8qDQo+ICAgCQkgKiBmcm9tOiBFUlJPUl9BQ1RJVkUsIEVSUk9SX1dBUk5JTkcNCj4gICAJCSAq
IHRvICA6IEVSUk9SX1BBU1NJVkUsIEJVU19PRkYNCj4gQEAgLTk1MSw3ICs5NTIsOCBAQCBzdGF0
aWMgdm9pZCBhdDkxX2lycV9lcnJfc3RhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj4gICAJ
CW5ldGRldl9kYmcoZGV2LCAiRXJyb3IgQWN0aXZlXG4iKTsNCj4gICAJCWNmLT5jYW5faWQgfD0g
Q0FOX0VSUl9QUk9UOw0KPiAgIAkJY2YtPmRhdGFbMl0gPSBDQU5fRVJSX1BST1RfQUNUSVZFOw0K
PiAtCWNhc2UgQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkc6CS8qIGZhbGx0aHJvdWdoICovDQo+ICsJ
CS8qIGZhbGwgdGhyb3VnaCAqLw0KPiArCWNhc2UgQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkc6DQo+
ICAgCQlyZWdfaWRyID0gQVQ5MV9JUlFfRVJSQSB8IEFUOTFfSVJRX1dBUk4gfCBBVDkxX0lSUV9C
T0ZGOw0KPiAgIAkJcmVnX2llciA9IEFUOTFfSVJRX0VSUlA7DQo+ICAgCQlicmVhazsNCj4gDQoN
Cg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
