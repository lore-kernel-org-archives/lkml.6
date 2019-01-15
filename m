Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05EFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7402085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ol8+pg/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfAOG7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:59:17 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48794 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfAOG7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:59:17 -0500
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="25331489"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jan 2019 23:59:15 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 14 Jan 2019 23:59:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng09PLkUUz6SwL5ErtLGvezUyzNihuqbnkRE1FoEN6U=;
 b=Ol8+pg/MkmQxfA2vmQI0bvLzMiShNrB8HIKaZsRk+TOpG3zgTmrAy7fN9k4PHCAOnXIDaBxpjrswwti5ptjOnE1swD9dRfxdWG5A+LbhFDnvWKJfqROWe+SD8zdFURovpvjHJ1nlJpeJuPe+7b3fsIX/yxQZBoFeb6YlqAr4yro=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1810.namprd11.prod.outlook.com (10.175.99.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Tue, 15 Jan 2019 06:59:11 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 06:59:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <ryder.lee@mediatek.com>, <marek.vasut@gmail.com>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>
CC:     <robh+dt@kernel.org>, <weijie.gao@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <guochun.mao@mediatek.com>
Subject: Re: [PATCH v1 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ
 for capcity setting
Thread-Topic: [PATCH v1 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ
 for capcity setting
Thread-Index: AQHUq8fHRd5pPA6AkEygQ7ztmaoqW6Wv6AUA
Date:   Tue, 15 Jan 2019 06:59:11 +0000
Message-ID: <8afdb25c-894b-0a89-b7a8-b754fb4ba905@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
 <54bb8a9d517e2ee35018d78457c6aa6a4970e644.1547442452.git.ryder.lee@mediatek.com>
In-Reply-To: <54bb8a9d517e2ee35018d78457c6aa6a4970e644.1547442452.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0113.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::42) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1810;6:X9zYaK+mJxOhgM9+QvC2j5C71cJdvflghpzgYt+Ve9ythaTVVRBUizTtV6VdbFfKaB7cCFeQ07N/ohTVuG+lLBtyFKP11WXVtux/a9qwO9Ay6K05ahpFrK+EQpUvPEMYAiYCt/oWbAdBWbMIJ7r7IICN4qxnRZ6be1o8bRvo++g30oWsOSffq+zNuAT5bJuPXHKzb0HgavWNGf0UXw20Ny2RP3Ss6sDuTTNZSRfGddcoEt6IJN4VilpXnHn9CmZ9nbYtSPhKdN8dFm41/ETXWwkc3juoakVVYdM11G3LfpP6Gn+fLtGQVRzcsm89qlMg1n8SnprzoFZ/oMPE3L+0L6POvxfdL1DTHTlSPZJCiXmvudYilVYHFxFiuNevH48c+HMOBW8uO7ej5qSTR1cG6dM6tJsK3yw0yOOUvyJvmTKv1ffjjUNDGyS12WB0ocbDrJOBNeGd2S6ALkkDrO9iNg==;5:7cPZPjZXFMkxQwqOJSZ36FZmqeGxmz7dW+cuJmtxkguui/sjmZGLX2sx/aIlJ34PITPy2xcr3Ju8X5q07rQDiDZTILA5qeVFgqFoO5qoXc+cUF3QY++1pIauVWP6D2ufP9SHZfiqqFyX7+6G+d31de/0ck9UkXEBe1EJJiTficD+nZKQvnyQIXdfq5pz9kcUXL+qDXFdrue1KHvX+VHTGA==;7:v4FSSrcByTqXotMtXd2hgdPHtt8KKDeFMPPChUU7Z56XX5vcdJSiMaB1TWJ2NxaUkTlUX5sN2DpueF7stjEyP6fdHtZmcFCakiuBqwx+DeK6xpBOH2F27ePPgjWNOC5XAsHBjvEmVOVyiJwYEs6duw==
x-ms-office365-filtering-correlation-id: c0ae81f6-7c32-4a72-0443-08d67ab6f3ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1810;
x-ms-traffictypediagnostic: BN6PR11MB1810:
x-microsoft-antispam-prvs: <BN6PR11MB18101A80E40248E5A20A8CB4F0810@BN6PR11MB1810.namprd11.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(199004)(4326008)(2906002)(8676002)(97736004)(14444005)(25786009)(256004)(6512007)(53936002)(39060400002)(6246003)(305945005)(7736002)(86362001)(31696002)(99286004)(6116002)(3846002)(81166006)(8936002)(68736007)(81156014)(54906003)(110136005)(5660300001)(316002)(2616005)(6436002)(7416002)(11346002)(66066001)(446003)(36756003)(486006)(229853002)(6486002)(476003)(478600001)(386003)(6506007)(106356001)(53546011)(102836004)(105586002)(71200400001)(72206003)(71190400001)(52116002)(26005)(31686004)(14454004)(76176011)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1810;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pOVdjxwW2oYkoCd+DLaCy9VhjUbmNvXs9FobANrSoXSjF0lVzfSd1hbqHWTXeyPOoTUSieglXPoYso2h7kzWMV+CvMzTLL/Jx8ADQ9WMMeaFpqhSxNLmmFeT79KSU7QVX+3nTFYPI26CrP63ZQlU//iuCzE0mXhFzgg//GfdaPs5lvLOGnCCS6ow7S+MjFNQDZp/XelxbjFfOLdzfMjOa+EY82jB2a4x1Tbp14xsvxYMjPbD2o9bk0HWv4eYg2iyZL2jO9xAzPWIs0l7rMQLSgMjsZ4/x40AcvB7u4ULPGB5LeTtBaXsx2xj0VnerAy1CFigGncHZmX8RaCQARvJM5SDZeQFgEdT8+eD84T9N8yjPEhjlgk1yZ08mSvyqzwtDRaXmQeX+URKMg1uazq0Xwr2wVsOr/mReRDMsEdJmMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3F225B418569B4D909CFCF3A5EB32D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ae81f6-7c32-4a72-0443-08d67ab6f3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 06:59:09.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1810
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJ5ZGVyLA0KDQpPbiAwMS8xNC8yMDE5IDA3OjEyIEFNLCBSeWRlciBMZWUgd3JvdGU6DQo+
IEZyb206IEd1b2NodW4gTWFvIDxndW9jaHVuLm1hb0BtZWRpYXRlay5jb20+DQo+IA0KPiBTTk9S
X0hXQ0FQU19SRUFEIGlzIGEgYmFzaWMgcmVhZCBtb2RlIGZvciBib3RoIGZsYXNoIGFuZCBjb250
cm9sbGVyLA0KPiBpdCBzaG91bGQgYmUgc3VwcG9ydGVkLCBzbyBhZGQgdGhlIGNhcGNpdHkgZm9y
IG10ay1xdWFkc3BpLg0KDQpTaW5jZSBJIGNvdWxkbid0IGZpbmQgYSBkYXRhc2hlZXQgZm9yIG10
ODE3MywgSSB0ZW5kIHRvIHNoYXJlIHlvdXIgYXNzdW1wdGlvbiAtDQpTTk9SX0hXQ0FQU19SRUFE
IHNob3VsZCBiZSBzdXBwb3J0ZWQgYnkgdGhpcyBjb250cm9sbGVyLiBIb3dldmVyLCBpdCdzIGFs
d2F5cw0KYmV0dGVyIHRvIHRlc3QgaXQgYW5kIG5vdCByZWx5IG9uIGFzc3VtcHRpb25zLiBZb3Ug
Y2FuIHRlc3QgaXQgYnkgZm9yY2luZyB0aGUNCm1hc2sgdG8gaGF2ZSBqdXN0IFNOT1JfSFdDQVBT
X1JFQUQgfCBTTk9SX0hXQ0FQU19QUCBzZXQuIE9yIHlvdSBhbHJlYWR5IHRlc3RlZCBpdD8NCg0K
WW91IGhhdmUgYSB0eXBvIGluIGNhcGNpdHkuIE1heWJlIHN1YnN0aXR1dGUgaXQgd2l0aCBjYXBh
YmlsaXR5IG9yICJhZGQgdGhpcw0KZmxhZyB0byBzcGlfbm9yX2h3Y2FwcyBtYXNrIg0KDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBHdW9jaHVuIE1hbyA8Z3VvY2h1bi5tYW9AbWVkaWF0ZWsuY29tPg0K
DQpZb3Ugc2hvdWxkIGFkZCB5b3VyIFNvQiB0YWcsIGJlY2F1c2UgeW91IGFyZSBzZW5kaW5nIGEg
cGF0Y2ggdGhhdCBpcyBub3QgeW91cnMuDQoNCkNoZWVycywNCnRhDQoNCj4gLS0tDQo+IENoYW5n
ZXMgc2luY2UgdjE6IG5vbmUuIA0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbXRrLXF1
YWRzcGkuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9tdGstcXVh
ZHNwaS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9tdGstcXVhZHNwaS5jDQo+IGluZGV4IDU0NDI5
OTMuLmQ5ZWVkNjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbXRrLXF1YWRz
cGkuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL210ay1xdWFkc3BpLmMNCj4gQEAgLTQz
MSw3ICs0MzEsOCBAQCBzdGF0aWMgaW50IG10a19ub3JfaW5pdChzdHJ1Y3QgbXRrX25vciAqbXRr
X25vciwNCj4gIAkJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqZmxhc2hfbm9kZSkNCj4gIHsNCj4gIAlj
b25zdCBzdHJ1Y3Qgc3BpX25vcl9od2NhcHMgaHdjYXBzID0gew0KPiAtCQkubWFzayA9IFNOT1Jf
SFdDQVBTX1JFQURfRkFTVCB8DQo+ICsJCS5tYXNrID0gU05PUl9IV0NBUFNfUkVBRCB8DQo+ICsJ
CQlTTk9SX0hXQ0FQU19SRUFEX0ZBU1QgfA0KPiAgCQkJU05PUl9IV0NBUFNfUkVBRF8xXzFfMiB8
DQo+ICAJCQlTTk9SX0hXQ0FQU19QUCwNCj4gIAl9Ow0KPiANCg==
