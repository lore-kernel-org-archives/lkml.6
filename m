Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D70C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ADD20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="HbvVnQeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ADD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLDPDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:03:42 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:2400
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbeLDPDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfNaW4p+MpQMxfGylPFfkSmbjvrEepE7s65wCkT1dKM=;
 b=HbvVnQeUGL+F9lgTudPZYNjC0rxPuV4EuhVc3wgMCHVnrStl27PdAIKLTX+Wvk1tHh8F485ySvVtJWzlXhRSovrLkcTXNz7S9WD+v49UHKiRQ/gTltgfJKv8Q0dSYfcg2SDcP8AwHySCMdzBoDy2MiepCCI22yKI2g3EeQUGGws=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5963.eurprd04.prod.outlook.com (20.178.107.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 15:03:36 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 15:03:36 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH 1/4] dt-bindings: display: ssd1307fb: Remove reset-active-low
 from examples
Thread-Topic: [PATCH 1/4] dt-bindings: display: ssd1307fb: Remove
 reset-active-low from examples
Thread-Index: AQHUi+KI2gmlvx0j6EalDjgRIUSaNQ==
Date:   Tue, 4 Dec 2018 15:03:36 +0000
Message-ID: <1543935806-94880-2-git-send-email-michal.vokac@ysoft.com>
References: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:203:90::21) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5963;6:QEkyc5QRpJBmf6vxe6vKADg/UI93pfWETMKE/oKg19dSnX3mnTkJsu8+FI9ca9zMm2VlmYjgowpxu4TYugk1anYGfW6bgExzlIK3ZRHq4rq83H5pyGLfPKYX0ypzcQ56FBpS+M4tu5bTlQzhEKtYWpOrraJJvXcz+mn6Lg1r9MItr92JO3voBjOc12bZW9Z4iFSwBL1EaSTx4xSBHtwRNUawRB3WYWHoq4gTdJEG6Er9O+SipIhrMH32Q3ER4i1wldEtgvKNHNqj77+ucumWhEBx/sMrivZGiDtdzL0Masylxmo6xIRBQeknsqxIexqdtvlH799+/BkwL5Zuik3YsH+fdI1uQM9dJlXf3uI2Yaxc1K621W3WmIhMd7S1iEzjQvLpYYU611R61Mdcqq7lf2hhPh4SBlBBmm8Rq7Cn/dIh1sjo/4FPreg4wrEgAzxM8u/ZjWbYjHYjAy7vxLCRfQ==;5:Dp3ChVyCcl70cPxISjMBwjiCZUDUiHlbjfxTeZIGL7kYS9QW530bpyNRdGMMkpi+4b2jKFFw2EuRdUTKxd/Z69It8N2GG1kdKNcKeEWDWJ3dNXhaUkSycIv4A5M6Z/PtoNI3HCJ+wWVbwq1JNWFWMr+vbYl80yUfhltpVOuZs0k=;7:yr7AYbEIkDQ74FHlZRuSNl96KsVBLZsW0w/eqAptKzbUli+4YvigIS4TwF6tZB8aIias6EK5g0V8fz6wJqsTZoT77+Y5nHH1oUr1wUUfnyuHaLrzaOBq7iY8CqUaVp6YFfOdVxVYjXnfxbCJepLAag==
x-ms-office365-filtering-correlation-id: 3a88adab-9496-4adc-9408-08d659f9aaa3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5963;
x-ms-traffictypediagnostic: DB7PR04MB5963:
x-microsoft-antispam-prvs: <DB7PR04MB5963AF8B4251D414C08B75D49EAF0@DB7PR04MB5963.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5963;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5963;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(136003)(396003)(346002)(376002)(199004)(189003)(72206003)(53936002)(478600001)(76176011)(6512007)(26005)(386003)(305945005)(186003)(4326008)(107886003)(7736002)(256004)(81156014)(66066001)(8936002)(71200400001)(14454004)(71190400001)(6506007)(81166006)(6486002)(5660300001)(11346002)(25786009)(99286004)(36756003)(2616005)(6436002)(446003)(316002)(68736007)(102836004)(105586002)(2906002)(110136005)(106356001)(54906003)(486006)(52116002)(6116002)(86362001)(3846002)(476003)(85182001)(8676002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5963;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WerOtR9PP+oyqlCDklUx2LdQF3/t+tEY7amOU8FF4vQBECLWHme2Y83Pc91eMeZC4+zh7sae/j0eIR7KMltQ4nv8FM0l5i/m/tONqRXwymream0allp9naXZHKelYNjktG1w561r1ktK6yfEriuSBkvQUjJYFpSxWC6CtgWTwihLeX5rfVtW8iJYYJltGSWcCTeoRNPF4nrtFYh+zTJTIzU1FfWshObMREK9UXdzh8twNAu2cXMpt6AQ0tLerK3fUDXOMCQWWlj1+hSITYxjkK8fLhIo8H61BqplxgMed9z3IPf5P1jJJm8XZy/TCrlxf5P6xYxoFajvAjLpa5NTa0Zm7XB9fT72J/LO1W7WIwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BD8A44105FC0B40A67DEE2208FBAE27@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a88adab-9496-4adc-9408-08d659f9aaa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 15:03:36.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5963
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlc2V0LWFjdGl2ZS1sb3cgcHJvcGVydHkgaGFzIGJlZW4gcmVtb3ZlZCBicm9tIHRoZSBi
aW5kaW5nIGEgd2hpbGUNCmFnby4gU28gcmVtb3ZlIGl0IGZyb20gdGhlIGV4YW1wbGVzIGFzIHdl
bGwuDQoNCkZpeGVzOiA1MTliNGRiICgiZmJkZXY6IHNzZDEzMDdmYjogUmVtb3ZlIHJlc2V0LWFj
dGl2ZS1sb3cgZnJvbSB0aGUgRFQgYmluZGluZyBkb2N1bWVudCIpDQpTaWduZWQtb2ZmLWJ5OiBN
aWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0tLQ0KIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3NzZDEzMDdmYi50eHQgfCAyIC0tDQogMSBm
aWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9zc2QxMzA3ZmIudHh0IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvc3NkMTMwN2ZiLnR4dA0KaW5kZXggMjA5ZDkz
MS4uYjY3ZjhjYSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L3NzZDEzMDdmYi50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L3NzZDEzMDdmYi50eHQNCkBAIC0zNiw3ICszNiw2IEBAIHNzZDEzMDc6
IG9sZWRAM2Mgew0KICAgICAgICAgcmVnID0gPDB4M2M+Ow0KICAgICAgICAgcHdtcyA9IDwmcHdt
IDQgMzAwMD47DQogICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbzIgNz47DQotICAgICAgICBy
ZXNldC1hY3RpdmUtbG93Ow0KIH07DQogDQogc3NkMTMwNjogb2xlZEAzYyB7DQpAQCAtNDQsNyAr
NDMsNiBAQCBzc2QxMzA2OiBvbGVkQDNjIHsNCiAgICAgICAgIHJlZyA9IDwweDNjPjsNCiAgICAg
ICAgIHB3bXMgPSA8JnB3bSA0IDMwMDA+Ow0KICAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW8y
IDc+Ow0KLSAgICAgICAgcmVzZXQtYWN0aXZlLWxvdzsNCiAgICAgICAgIHNvbG9tb24sY29tLWxy
cmVtYXA7DQogICAgICAgICBzb2xvbW9uLGNvbS1pbnZkaXI7DQogICAgICAgICBzb2xvbW9uLGNv
bS1vZmZzZXQgPSA8MzI+Ow0KLS0gDQoyLjEuNA0KDQo=
