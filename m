Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6565C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722F120BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="txzngNC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722F120BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeGLNMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:12:49 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:8044
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbeGLNMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEPjzmIjTfSrmicKo8BNdAWHGupWSipp024pbDafFYM=;
 b=txzngNC23+qrJ9hXqdV/YjwsI2wqyzlP1e+ob1rHF43EOGpIRByyM3PdTitKGDvjKrvpt2c8ThrbCaiK6m70/FERbC1AkLVCOnEt/zjpTDZ7BCBpomDySZaNF2+V6rXd4rEsKSJIITfWwaneP3EPq5GV8TmLErZZmHuFgJnVFVE=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4724.eurprd04.prod.outlook.com (20.176.214.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 13:03:15 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4%2]) with mapi id 15.20.0930.022; Thu, 12 Jul 2018
 13:03:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Thread-Topic: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Thread-Index: AQHUBOE6dIO4bv5XOkuQXfh+MS7cPKRhubYAgAATpQCAAArcAIAAEl0AgAAN+wCAJlhKAIAAAU+AgAMnpICAAD3UAA==
Date:   Thu, 12 Jul 2018 13:03:14 +0000
Message-ID: <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
         <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
         <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
         <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
         <638457fd-85da-8fec-d146-517c43f71813@denx.de>
         <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
         <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
         <fd22085f646d97f66cff5b7f22785500@agner.ch>
         <6fdba55b-0be6-9e28-d87a-43d876a1fd09@denx.de>
         <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
In-Reply-To: <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4724;7:KFaTvJxh0Hc2dXnVqSvuSdpKPcp1P2nFvNk9S/kFU6+PWzi92JRf4HN4gp/MACc+vD7Lfyc0FQ3eNwVN9V0/iXFI2xBrOVsrntTZc8CALjnfpy23lfswALw3CZ+4y9y0aSPGwBy8EOQScHS+TRNKwSWxiNvC71ywiC/BbJv0lFV45rQRCUNPScb0XvTafy4d9IrRGj5zq0ZFd2RsDVbvr/CoXTr14Q1qdrbLqh+ZbKj/KRawUxz532N3dn81lld4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 33bde0f8-d730-4dc9-e332-08d5e7f7d471
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4724;
x-ms-traffictypediagnostic: AM0PR04MB4724:
x-microsoft-antispam-prvs: <AM0PR04MB4724406B3BBA497D1CBF8B4FEE590@AM0PR04MB4724.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4724;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4724;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(81156014)(6246003)(486006)(53546011)(102836004)(106356001)(6506007)(446003)(93886005)(2900100001)(2616005)(11346002)(2906002)(476003)(186003)(26005)(6116002)(3846002)(8676002)(5660300001)(14454004)(44832011)(7416002)(105586002)(316002)(81166006)(39060400002)(478600001)(76176011)(6512007)(8936002)(6436002)(54906003)(25786009)(110136005)(97736004)(36756003)(6486002)(7736002)(86362001)(229853002)(5250100002)(2501003)(53936002)(50226002)(118296001)(256004)(305945005)(68736007)(99286004)(66066001)(4326008)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4724;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4vEy5a6E8Gg/1bUpeUIeVvibBXLGBDBcQrhn8lcnR0oAD+u/FSG7B6+JFqH2EbxdvD8yxtD5Bno4B4QKxa/OU2xt94lScsAdDL5Yy4NX/aMFBGzgz9AXm7ff9W8smWAtttX4iqNcOoY+JldufTXMvcQZD0Gtg84WgsR4h4EmmiXXrver/RnPw1l4Qr+Oh9IizzQSsAsDNz6Kx7oUBKiT4QfjPFWp6PdEFQ34N7iVYm7LWMNxhAjb/B8HTcFOH19IJcEBSCoPP14NUsSACEPh69ByXvlvuqzQyYxAYauw2uDminl7voRfUawLUgcZQT7m/lfXaXx7faRe3DLcGZhardgWTJ0Ulw84z1cQoHGTIOc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3036EF3E555E4E4899EEA9E98FC6126B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bde0f8-d730-4dc9-e332-08d5e7f7d471
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 13:03:14.9340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTEyIGF0IDExOjIxICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDEwLjA3LjIwMTggMTE6MTEsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiA+IE9uIDA3LzEwLzIw
MTggMTE6MDYgQU0sIFN0ZWZhbiBBZ25lciB3cm90ZToNCj4gPiA+IFRoaXMgaXMgb25lIG9mIHRo
ZSBzaXR1YXRpb24gd2hlcmUgc3RhdGVzIHF1byBpcyBraW5kYSB0aGUgd29yc3QNCj4gPiA+IHNp
dHVhdGlvbi4NCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5IGlteF92Nl92N19kZWZjb25maWcgYW5k
IG14c19kZWZjb25maWcgYWN0dWFsbHkgc3RpbGwgdXNlcw0KPiA+ID4gQ09ORklHX0ZCX01YUy4N
Cj4gPiA+IA0KPiA+ID4gSSB1bmRlcnN0YW5kIHRoYXQgeW91J2QgcmF0aGVyIHByZWZlciB0byBt
b3ZlIGZvcndhcmQuIEkgc3VnZ2VzdCB3ZSBkbw0KPiA+ID4gaXQgaW4gc3RlcHMuDQo+ID4gPiAN
Cj4gPiA+IEluIDQuMTk6DQo+ID4gPiANCj4gPiA+IC0gQ2hhbmdlIERSTSBkcml2ZXIubmFtZSB0
byBteHNmYi1kcm0gc28gd2UgYXZvaWQgY29uZmxpY3RzIGZvciBub3cNCj4gPiANCj4gPiBCdXQg
dGhpcyB3aWxsIGJyZWFrIG1lc2EgaWYgaXQgZGVwZW5kcyBvbiBteHNmYiBuYW1lIGZvciBpZS4g
ZXRuYXZpdg0KPiA+IGJpbmRpbmcuDQo+IA0KPiBEb2VzIGl0PyBncmVwIC1yIC1lIG14c2ZiIGlu
IGxpYmRybSBhbmQgbWVzYSBtYXN0ZXIgcmV0dXJucyBub3RoaW5nLg0KPiANCj4gVGhlcmUgaXMg
YWxzbyAubmFtZSBpbiBzdHJ1Y3QgZHJtX2RyaXZlciwgd2hpY2ggaXMgYWxyZWFkeSBzZXQgdG8N
Cj4gbXhzZmItZHJtLi4uIElzIHRoYXQgdGhlIG9uZSBleHBvc2VkIHRvIHVzZXIgc3BhY2U/DQoN
ClJ1bm5pbmcgZXRuYXZpdit4MTEgd2l0aCBhIHJlbmFtZWQgbXhzZmIgZHJpdmVyIHdvcmtzIGZp
bmUgb24gaW14NnN4LQ0Kc2RiLg0KDQpUb29scyBsaWtlIG1vZGV0ZXN0IGFscmVhZHkgbmVlZCAt
TSBteHNmYi1kcm0sIHRoZSBkcm1fZHJpdmVyLm5hbWUNCnNlZW1zIHRvIGJlIHdoYXQgbWF0dGVy
cy4NCg0KPiAtIFJlbW92ZSBDT05GSUdfRkJfTVhTIGZyb20gaW14X3Y2X3Y3X2RlZmNvbmZpZy9t
eHNfZGVmY29uZmlnIG5vdywgYW5kDQo+IG9ubHkgZW5hYmxlIENPTkZJR19EUk1fTVhTRkI9eQ0K
DQpJZiBvbmUgb2YgdGhlIGRyaXZlcnMgaXMgcmVuYW1lZCB0aGVuIHRoZXkgY2FuIGNvZXhpc3Q6
IHNpbmNlIHRoZQ0KYmluZGluZ3MgYXJlIGRpc3RpbmN0IG9uZSBkcml2ZXIgd2lsbCByZXR1cm4g
YSBwcm9iZSBlcnJvciBhbmQgdGhlDQpvdGhlciB3aWxsIGJpbmQgc3VjY2Vzc2Z1bGx5LiBUaGlz
IGNhbiBldmVuIGJlIGFkanVzdGVkIHNvIHRoYXQgaXQNCmRvZXNuJ3QgZXZlbiBwcmludCB1Z2x5
IHNjYXJ5IGVycm9ycy4NCg0KVGhpcyBjYW4gbGFzdCB1bnRpbCBzb21lYm9keSBpbXBsZW1lbnRz
IHN1cHBvcnQgZm9yIG9sZCBiaW5kaW5ncyBpbiB0aGUNCmRybSBkcml2ZXIgYW5kIHRoZW4gRkJf
TVhTIGNhbiBqdXN0IGJlIGRlbGV0ZWQu
