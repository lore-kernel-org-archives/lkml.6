Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB15C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC72220870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pA4DnOpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfBAOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:43:23 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:18579 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfBAOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:43:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="26032028"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 07:43:22 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 07:43:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXjBO4r1Ndv1n4EYS1f7eGRa4lF+0zWT9KgdPUIAsyI=;
 b=pA4DnOpZMe4kReF5hsZ1GRxlWR9R+A34SmS1lSjY105EUzEkjkWc9PumkGjuJIPw57ZnHagnQyKlpBWFIYUFiGdtXPqWj0muG2bj2Muyv2uEozTNcT/4sVX5lrt0un0jxaRhsJT2racVwhcTNOdFSnWJN7f1kIqxA+nUscGcueI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1841.namprd11.prod.outlook.com (10.175.99.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 1 Feb 2019 14:43:18 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Fri, 1 Feb 2019
 14:43:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUuYA85AgiqORGIUCz49OB4RqXzKXJkgKAgAD0mICAAH9LgA==
Date:   Fri, 1 Feb 2019 14:43:18 +0000
Message-ID: <af691fb9-e972-5590-77f7-754bc1018b05@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
 <20190131161515.21605-11-tudor.ambarus@microchip.com>
 <20190131173207.56481a42@bbrezillon>
 <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
In-Reply-To: <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0052.eurprd03.prod.outlook.com
 (2603:10a6:803:50::23) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1841;6:xVEO7lrbliwBLnDQ2K45x84/MPEa2g6kg3HqaYQRDKqIWxUXOf2fMssg8RTf93Zywf9MmXgWUG54QAxrB4mr3fUn9gsLEvQ0riux8Q7bnd+5Ss+1WPRiicQ1l1ydPR4G1iZRAnU+Q+lxs2O2xuhWdrAX7tCvyEK0zYkKcHGnrSr+hc9JcdzlwliRaqFRzu4jS0HXcfiKDdKeNGhD8kvTUWVhfwOaRZtGk0m6koWJ9wPriXnOHbRsOB8a+lhpoEyq2ESUct7uCsTW7dpmxByac+E2BAVom8A5yShNhCBZWRv/tj7jBaQ7F3ZwHCoCXR4sTmfOkJmyqk8RrJatUsaBLETG5rsU2f/f+I57HsE1P86Y+9fAChokQr0hu6UQI2vmmF8gZWbdK1hS4CajZxX3DWwTxEmN6zF80JTjCl4lqnbaV6/oRE47VrN2TPJsGmqWmzg2nMcvyvM8Cxgz43YIFA==;5:BUf9DC5QVicmX6Aa1ULAyqCapzJ/TndfDxUs2+oPDHzwgfMaxvBGbh9Bm+jNfTWpRWl5r1LBtHjhl4huihqqlSq3n4AxhIuNRkr64oZu5Gz+G5lLzM4Bw2nE6QCN1xcEewaTIM7d9yCDjmXMa/vLzuSsRkaw6jMe2xIEqRAV7ucanhfppEGUAGJ3A2QVoQFPhFqIvcmGaSPxLerC54F4Ew==;7:5BZDVsxYROJnVAWJObuXLTdWqxGW8hSBVGes5Z1huv+MDwn75sx+8DmIxTTe9mKbuBxI4IQiOnD8GgYrZ/P1ue9D6GzS5bnlG+2ahhQ8r8keHcP4wij4+2Jjrb4uF8bSwDnHUg05WzwSLh7ek11Gwg==
x-ms-office365-filtering-correlation-id: 19a49ad3-bcd8-49de-ef9a-08d688539ace
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1841;
x-ms-traffictypediagnostic: BN6PR11MB1841:
x-microsoft-antispam-prvs: <BN6PR11MB1841634D6C67632F42F5CE52F0920@BN6PR11MB1841.namprd11.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(2501003)(386003)(7416002)(68736007)(76176011)(102836004)(6116002)(3846002)(6916009)(11346002)(31696002)(6246003)(476003)(7736002)(6506007)(53546011)(446003)(316002)(53936002)(2616005)(486006)(26005)(86362001)(305945005)(186003)(256004)(36756003)(54906003)(99286004)(93886005)(14454004)(2906002)(4326008)(6436002)(71200400001)(71190400001)(8676002)(25786009)(478600001)(1730700003)(5640700003)(8936002)(72206003)(229853002)(52116002)(106356001)(2351001)(6486002)(31686004)(105586002)(97736004)(81156014)(66066001)(81166006)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1841;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u36L+Y9IVERvihAAV+qxZ11DAh4uopZO91ctDonmfo0aKlv8u7AHDI6NEbMZ5lcMJQv7wS+FWgISGkcZZhNUBaoQgs2P2smvcC2mvMwWBmjKqayaJ0i/lmWHQA+83JYd5AiEAgWkzIbTr847ruBJBZF48D62gCXONgnPDscMxR926DGjwVV4dl86w/jjKF77UBmcGNNXyosy+gbCiCvE0NxYIt8yDadoGIdYlJy50MGJBrRMSMvLR661dJYX/dQuYRn1Q9NYE4/n29uwYEGtDiK1Vo+3GZpppSBgl2s57M0gG8C4FUbpk/I2XwVVmnOj1kqLqklPBKtQm0eHj4UcCXe6GJXXpSdDBF6saQzcrKmL8kz6iOwblDUiqr0Q6e+g0JKIbaWIwnE6luYK4kdoRcJ2sC1s+TbXvZcaxOpy/OI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1A32B394A61DF4C8AD769D0FF5E83AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a49ad3-bcd8-49de-ef9a-08d688539ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 14:43:16.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1841
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzAxLzIwMTkgMDk6MDcgQU0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3
cm90ZToNCg0KY3V0DQoNCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNw
aS5jIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQoNCmN1dA0KDQo+Pj4gK3N0YXRpYyBp
bnQgYXRtZWxfc2FtOXg2MF9xc3BpX3NldF9jZmcodm9pZCBfX2lvbWVtICpiYXNlLA0KPj4+ICsJ
CQkJICAgICAgY29uc3Qgc3RydWN0IHNwaV9tZW1fb3AgKm9wLA0KPj4+ICsJCQkJICAgICAgc3Ry
dWN0IGF0bWVsX3FzcGlfY2ZnICpjZmcpDQo+Pj4gK3sNCj4+PiArCWludCByZXQgPSBhdG1lbF9x
c3BpX3NldF9tb2RlKGNmZywgb3ApOw0KPj4+ICsNCj4+PiArCWlmIChyZXQpDQo+Pj4gKwkJcmV0
dXJuIHJldDsNCj4+PiArDQo+Pj4gKwlyZXQgPSBhdG1lbF9xc3BpX3NldF9hZGRyZXNzX21vZGUo
Y2ZnLCBvcCk7DQo+Pj4gKwlpZiAocmV0KQ0KPj4+ICsJCXJldHVybiByZXQ7DQo+Pj4gKw0KPj4+
ICsJY2ZnLT5pZnIgfD0gUVNQSV9JRlJfSU5TVEVOOw0KPj4+ICsJY2ZnLT5pY3IgfD0gUVNQSV9J
Q1JfSU5TVChvcC0+Y21kLm9wY29kZSk7DQo+Pj4gKw0KPj4+ICsJLyogU2V0IGRhdGEgZW5hYmxl
ICovDQo+Pj4gKwlpZiAob3AtPmRhdGEubmJ5dGVzKQ0KPj4+ICsJCWNmZy0+aWZyIHw9IFFTUElf
SUZSX0RBVEFFTjsNCj4+PiArDQo+Pj4gKwlpZiAoIW9wLT5hZGRyLm5ieXRlcykgew0KPj4+ICsJ
CWNmZy0+aWZyIHw9IFFTUElfSUZSX1RGUlRZUF9UUlNGUl9SRUc7DQo+Pj4gKwkJaWYgKG9wLT5k
YXRhLmRpciA9PSBTUElfTUVNX0RBVEFfT1VUKQ0KPj4+ICsJCQljZmctPmlmciB8PSBRU1BJX0lG
Ul9BUEJURlJUWVBfV1JJVEU7DQo+Pj4gKwkJZWxzZQ0KPj4+ICsJCQljZmctPmlmciB8PSBRU1BJ
X0lGUl9BUEJURlJUWVBfUkVBRDsNCj4+PiArCX0gZWxzZSB7DQo+Pj4gKwkJY2ZnLT5pZnIgfD0g
UVNQSV9JRlJfVEZSVFlQX1RSU0ZSX01FTTsNCj4+DQo+PiBDYW4geW91IHRyeSBkb2luZyBvbmx5
IHJlZ3VsYXIgdHJhbnNmZXJzIGFuZCBsZXQgbWUga25vdyBpZiBpdCBzdGlsbA0KPj4gd29ya3Mu
IFN1cHBvcnQgZm9yIG1lbSB0cmFuc2ZlcnMgY2FuIHRoZW4gYmUgYWRkZWQgYWxvbmcgd2l0aCBk
aXJtYXANCj4+IHN1cHBvcnQuDQo+IA0KPiBzaG91bGQgd29yay4gV2lsbCB0cnkgYW5kIGxldCB5
b3Uga25vdy4NCg0KeW91IHdlcmUgcmlnaHQsIGl0IHdvcmtzLiBJIHdpbGwgbGV0IG1lbSB0cmFu
c2ZlciBsb2dpYyBmb3IgZGlybWFwIHN1cHBvcnQuDQoNCkNoZWVycywNCnRhDQoNCg==
