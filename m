Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9800620856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QopcVBMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAQHQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:16:06 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50122 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfAQHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:16:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="26534637"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jan 2019 00:16:04 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 17 Jan 2019 00:16:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyxgfg9S2DzD0TGBa+y+I9TjYOqwA2sUPGEkfBHsLfI=;
 b=QopcVBMQKa0JMc7197TpSIgJPLQjix8r/bO9MDuyCJr/O7h+bcGROedHcg2P6rLjC1+CZITNOw4DxpUiikIBvewJzYjsPErMntmOVjxpwCizC8lcDV+oASaVtbmePT1mkkGSlvzAI4KJNvXsfJjUYkY0ozmPty0Sz1iuiMu9WlU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1571.namprd11.prod.outlook.com (10.172.22.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 07:16:01 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 07:16:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <broonie@kernel.org>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Topic: [PATCH v7 3/5] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Index: AQHUrLnUkUf6WbGWr02OhoksrpQ9aqWzD4KA
Date:   Thu, 17 Jan 2019 07:16:01 +0000
Message-ID: <8381785e-95c2-8dfc-6fac-ea4710b3c943@microchip.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-4-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0026.eurprd02.prod.outlook.com
 (2603:10a6:803:14::39) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1571;6:DgF1SH219lwynwSnKUGsawtdVxy7+KQjfQgXqS7lnvtzFe6bKMoC3VmQuvGCrqJeB0Fu3p45esSQHIEm8mA2bcFM4j8E1akhtPf8ZhTuhbR6BzCu6Uv2uqZ30tRFabGZ6xggCFTFPIkgn9UcOh3KtzkP7ZWpJYGgXX5YW1zom92SUHrVUEsvEOrJeZrhzMowSF8990cVZ6zjly7xAcZwVkx7IxDgHTA3VvZQoxTLrQnCR0JJOLCF94cmDs+95o3HRUiP00asrrHTMT889S2qCH1SvGmCzNZGT3pg+7o82qacdb8bAMJYHA55gZX4h9lh8yl9lFn7HZwccNZz2rTPUAE9G5UHIAjovxWx5RK85UlNdXgh+yuNsuX75qViAksB1p6RLEPERmrbiDyyyMTAoxbNmrRqmPmeq8FG6MyQ1pRJshzJT3wgB90W4G6UX1YBUXvK5gtaFHW19FSFex+9kQ==;5:2+6L1u4ojZSupg/sFFsUxUEatALqh/qQXHLew7wJv5v8+5wiXm6LTweNMT/o3jIlYQzx8r1XwUHtnRgvsA+tPs21bN6nWmw/1PmMKJbEFSryExOOIIH90nHHmEYFI+4ltz/rpK+GDCzsLoRXIl+F/Rvhutpa/5lsVvv48lb4dS5LVqdPfDtIBfHsKojUgiUtCdFekFGJOo21uxVFBgc7Ww==;7:E5hML/Job5qUqTxJH537pEuxob9EUjfNx8awLAPkDzLqQryi1oo37zuKD1f1EGX0rdG3MuMxcN7EdmB8ALBhjoZ+iPAFoVlU5u7Jevb0/GcT0+5lY7IXEeqcuasUfLvuNS0mCD88H+g0cY+Gt7AR7A==
x-ms-office365-filtering-correlation-id: eb7949db-44e4-491d-a1ca-08d67c4ba243
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1571;
x-ms-traffictypediagnostic: BN6PR11MB1571:
x-microsoft-antispam-prvs: <BN6PR11MB1571C263ADC934E544E1D49FF0830@BN6PR11MB1571.namprd11.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(53936002)(71200400001)(71190400001)(105586002)(6512007)(31686004)(4326008)(6246003)(97736004)(66066001)(25786009)(39060400002)(86362001)(36756003)(106356001)(31696002)(68736007)(6116002)(6486002)(229853002)(386003)(72206003)(2201001)(2906002)(5660300001)(102836004)(81156014)(7416002)(8676002)(6506007)(14454004)(3846002)(8936002)(81166006)(305945005)(6436002)(7736002)(53546011)(256004)(2616005)(76176011)(52116002)(14444005)(446003)(476003)(11346002)(99286004)(186003)(26005)(2501003)(110136005)(54906003)(316002)(478600001)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1571;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kis2bW8HuHtU8ac0+pGRVVhwaq5nxjXm56f0kvnEhgla/TCyz0S4ZqTKygsfKuVSd7OYsYmucXkXWwVjAiU+/M4Zd1/naToW5a1q7ReFKXe91/4pwwuDi95RcST9nQSOkTivtDwXhxMQUQtouAsReBizDz8suv9Nq1dcVqqUeA7cC7kTxrw8a/+Z/jzmdqB946V2DXD2RAZpT/JCRwh0fUleWpSlxas66ZZ9ghANLcUNhf2jEfiF9O7VjvkpHcDrfh6H3rmmKK+/lzfzmI99XK/BzR5VZlc/d16uMSDkKnbxlMAPJ9sCpFHN8QPEx0VQr3Tdr2xbXVu65hSjXPUgaF4Ht8hEUwzutaoD+hZuV6lZMYqsjKnK5bMnwcI8xZMwBzDDeSzhCUYLaG01kdh+4OnEP0uKG9O0uWWy9WzQCBc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDE7A108107BB745BE3483018FC7CA90@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7949db-44e4-491d-a1ca-08d67c4ba243
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 07:15:58.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1571
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzE1LzIwMTkgMTI6MDUgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+
IEFkZCBzdXBwb3J0IGZvciBvY3RhbCBtb2RlIEkvTyBkYXRhIHRyYW5zZmVyIGJhc2VkIG9uIHRo
ZSBjb250cm9sbGVyIChzcGkpDQo+IG1vZGUuDQo+IEFzc2lnbiBody1jYXBhYmlsaXR5IG1hc2sg
Yml0cyBmb3Igb2N0YWwgdHJhbnNmZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb2dlc2ggTmFy
YXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFR1
ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgfCA5ICsrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgYi9kcml2ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5j
DQo+IGluZGV4IGM0YTFkMDRiOGM4MC4uNjUxYmFiNmQ0ZTMxIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1
cDgwLmMNCj4gQEAgLTE5NSw3ICsxOTUsMTQgQEAgc3RhdGljIGludCBtMjVwX3Byb2JlKHN0cnVj
dCBzcGlfbWVtICpzcGltZW0pDQo+ICAJc3BpX21lbV9zZXRfZHJ2ZGF0YShzcGltZW0sIGZsYXNo
KTsNCj4gIAlmbGFzaC0+c3BpbWVtID0gc3BpbWVtOw0KPiAgDQo+IC0JaWYgKHNwaS0+bW9kZSAm
IFNQSV9SWF9RVUFEKSB7DQo+ICsJaWYgKHNwaS0+bW9kZSAmIFNQSV9SWF9PQ1RBTCkgew0KPiAr
CQlod2NhcHMubWFzayB8PSBTTk9SX0hXQ0FQU19SRUFEXzFfMV84Ow0KPiArDQo+ICsJCWlmIChz
cGktPm1vZGUgJiBTUElfVFhfT0NUQUwpDQo+ICsJCQlod2NhcHMubWFzayB8PSAoU05PUl9IV0NB
UFNfUkVBRF8xXzhfOCB8DQo+ICsJCQkJCVNOT1JfSFdDQVBTX1BQXzFfMV84IHwNCj4gKwkJCQkJ
U05PUl9IV0NBUFNfUFBfMV84XzgpOw0KPiArCX0gZWxzZSBpZiAoc3BpLT5tb2RlICYgU1BJX1JY
X1FVQUQpIHsNCj4gIAkJaHdjYXBzLm1hc2sgfD0gU05PUl9IV0NBUFNfUkVBRF8xXzFfNDsNCj4g
IA0KPiAgCQlpZiAoc3BpLT5tb2RlICYgU1BJX1RYX1FVQUQpDQo+IA0K
