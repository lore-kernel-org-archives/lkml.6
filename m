Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85067C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD892089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PZW/EB9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD892089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJCShk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:37:40 -0400
Received: from mail-db5eur01on0083.outbound.protection.outlook.com ([104.47.2.83]:4178
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbeJCShk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BqeDHvTB9tPhGtr6QrAGpGcdcv9xszWVS07OCaXhe0=;
 b=PZW/EB9h9IpIH/PoeuUNOxyKhUpzcQ0JAIWM2YYPW3qHPZdIb03Z1ZuuTPEcbmc2y3muT9THblGU3Cr7/kUgL5mRoHQisSSKjfoBIjkzXDSZM1CYtcZME83HnUBTjS+BObCJwIpRC1LFrh2pAlxIh9OQ7sPXfon1Y8A/YqLIoTc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4433.eurprd04.prod.outlook.com (52.135.148.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Wed, 3 Oct 2018 11:49:33 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 11:49:33 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Topic: [PATCH] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Index: AQHUWn70L5CxBxcrw0W+NgO3q4rJuKUMXxKAgAEKOQA=
Date:   Wed, 3 Oct 2018 11:49:32 +0000
Message-ID: <234ccbfccc26701bd0b9fd9cf2ffb5ad2414adec.camel@nxp.com>
References: <1147be600733a1bcde194f7df61866019f34a531.1538504729.git.leonard.crestez@nxp.com>
         <CACRpkdajdjLUEwv8ABSBuy4dVMXqrUfxVDmu55aEiRAK877urQ@mail.gmail.com>
In-Reply-To: <CACRpkdajdjLUEwv8ABSBuy4dVMXqrUfxVDmu55aEiRAK877urQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4433;6:fV7WZodMyFcNB1wadi3tImpfzYLFPR7sFU8FnR03RON5qgx0wJhgRZP7gm53vYdmPujTvtt27Pkatgc7j2C3hwJk9yid5JcVZ5bnC6MB9kvMtDk4CF34AtFwWVIi4K8RIqLO2X0vYCxgnUIdn5fzANG69mhe4m1QJUqjbIJizauD8qaYIb5Fq+/3gIbkLVFWEbgTKtInbDT4Jt04FiDHKdUR4NP3OnTpazuWlfyZ+joT68xz1lLTN5wdJh1t4hZvSaq270ET+j2vd5BAh5z02BRhE3jecymKNwpdyRr8ZlsQjzWcAp7UCavqRC6im2J9ZXlgQGfndjRkEaVV6B9RLkrvRMgc42rHn/v9qB6TIVezspXPaqJX9the09K5imtQ1ZKeYpp1VKMZ8ExiT21jW4Qh0Jv1/rqAmU566wcGUk6LZjk3ZbyVeFs8wLjiVVEifSVpG10jtYx/sfEM0LdQiQ==;5:hYroSPu/ckHb9F7BSVUx1qYWaLwlXiL3bsEbcNQ4598n3Y7RutObSKigdFeGAxJFSRvUbAIBolD+8mzyukLRYw+UIfuiZcIG2v9q7gS/YM7L/z1CXb8V1qBu/raFhpe/2ai3l5xxvykyaJJSCbgXxObzmyZfCFAxVdrA56h26rI=;7:s0pwW6Jp9PWzt2hNaDI1JdgT28emMohdEOx1SlJBFTBGHCFCDl9lzb15pG9bs6wKA6/ll5AX1c3LHiTpOrK+es5xPBAttDL+8Q2qPU+/DiVUuzWQelbpEHltQZjLgoWSFSoPUajw8fK0lxE73FM+dxgyQbBiuSx6ei41E2cMbUuoWYvMJcuUy3Tgti8fSVjYroJ1jUcWC4r7jgS0cKdOxh6nORyOC+2PQVAEufQnxhFXjI6lu/lyq6O+3L0UJ6dS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d59e40a6-b3b9-418b-5637-08d629264907
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4433;
x-ms-traffictypediagnostic: AM0PR04MB4433:
x-microsoft-antispam-prvs: <AM0PR04MB443320D7482E9B0FFD8E7E54EEE90@AM0PR04MB4433.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:AM0PR04MB4433;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4433;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(52314003)(199004)(189003)(229853002)(39060400002)(8936002)(6116002)(106356001)(2900100001)(71200400001)(105586002)(3846002)(71190400001)(25786009)(316002)(81156014)(256004)(81166006)(50226002)(8676002)(36756003)(2906002)(6486002)(6436002)(6506007)(7736002)(53546011)(6246003)(97736004)(6512007)(86362001)(26005)(76176011)(118296001)(186003)(53936002)(99286004)(305945005)(68736007)(66066001)(4326008)(11346002)(5250100002)(2616005)(486006)(2501003)(446003)(478600001)(476003)(102836004)(44832011)(5660300001)(110136005)(14454004)(54906003)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4433;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zplsKgd5ZIjeOMDftlrL/XUhf2f6k84bmmcNeVWaUsnxs88GSpKp3lqRF3snbl1vHVFtD1aKakNaMUJWdA63p1/1QY+gTbZHFHPmTX0dZElr15z6UEMx+CjWBzIGd1ZtS9nVaS4+TKVTi+dg7PH/QYouq7YJaw6pef+pQ97xfVi0miokkhi6BBl4EzMF9cp/+HoyfRcU20v4h8A/Y0O6wuy/gqu4SqFJBEytu4Y/VSmqCr4fLAuPijQjaGhxF7Tr8oi1x180zPaNLYAtJ19bf56NUrEUDV2e5qbSV+/eA9q+f4qIDFq6A4AoJwIT/msvGV0bfUYqWzx77IjXtRicfa8W+N16jU3yjgnTq9e3xmw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <868ACE3B74A7CC49A72118AED41532BF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59e40a6-b3b9-418b-5637-08d629264907
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 11:49:32.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTAyIGF0IDIxOjU2ICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBUdWUsIE9jdCAyLCAyMDE4IGF0IDg6MzcgUE0gTGVvbmFyZCBDcmVzdGV6IDwNCj4gbGVv
bmFyZC5jcmVzdGV6QG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlzIGlzc3VlIHdhcyBleHBv
c2VkIGJ5IGNvbW1pdCBlZmRmZWIwNzljYzMgKCJyZWd1bGF0b3I6IGZpeGVkOg0KPiA+IENvbnZl
cnQgdG8gdXNlIEdQSU8gZGVzY3JpcHRvciBvbmx5Iikgd2hpY2ggY2F1c2VzIHRoZSAiZ3Bpb3Mi
DQo+ID4gcHJvcGVydHkNCj4gPiB0byBhbHNvIGJlIHBhcnNlZC4gQmVmb3JlIHRoYXQgY29tbWl0
IHRoZSAiZ3Bpb3MiIHByb3BlcnR5IGhhZCBubw0KPiA+IGVmZmVjdCBhbmQgUEhZIHJlc2V0IHdh
cyBvbmx5IGhhbmRsZWQgaW4gdGhlIGJvb3Rsb2FkZXIuDQo+IA0KPiBXb3cgdGhhdCB3YXMgYSB2
ZXJ5IGludGVyZXN0aW5nIG9uZS4NCj4gVHVybmluZyBvdmVyIHRoZXNlIHN0b25lcyBzb21ldGlt
ZXMgZXhwb3NlIHRoZSB3ZWlyZGVzdA0KPiB0aGluZ3MuDQo+IA0KPiBUaGlzIGlzIG9uZSBvZiB0
aGUgcmVhc29ucyB3aHkgd2UgbmVlZCBmb3JtYWwgdmFsaWRhdGlvbiBvZg0KPiBEVFMgZmlsZXM6
IHRoaW5ncyBsb29rIE9LIHRvIHRoZSBodW1hbiBleWUgYW5kIGdldCBtZXJnZWQNCj4gYnV0IHRo
ZXkgYXJlIGp1c3Qgc3ludGFjdGljYWxseSB3cm9uZy4NCj4gDQo+IEkgZ3Vlc3MgSSBjb3VsZCBo
YWNrIHRvIG1ha2UgImdwaW9zIiBiZSBpZ25vcmVkIGJ5IHRoZQ0KPiByZWd1bGF0b3IgR1BJTyBx
dWlya3MgaW4gZ3Bpb2xpYiwgYnV0IEkgdGFrZSBpdCB5b3UgcHJvYmFibHkNCj4gcHJlZmVyIHRv
IGZpeCB1cCB0aGUgcmVhbCBpc3N1ZSBsaWtlIHRoaXMuDQoNCk1heWJlIHlvdSBjb3VsZCBkb2N1
bWVudCBpbiBmaXhlZC1yZWd1bGF0b3IgYmluZGluZ3MgdGhhdCBpdCBub3cNCnN1cHBvcnRzIHRo
ZSBzdGFuZGFyZCAiZ3Bpb3MiIHByb3BlcnR5IGFzIHdlbGw/IFRoZXJlIHN0aWxsIHNlZW1zIHRv
IGJlDQphIHJlc3RyaWN0aW9uIHRoYXQgdGhlIGxpc3QgbXVzdCBjb250YWluIGEgc2luZ2xlIGVs
ZW1lbnQuDQoNCkFueXdheSwgd2hhdCBteSBwYXRjaCBmaXhlcyBpcyBhIGJvYXJkLXNwZWNpZmlj
IGlzc3VlIHdoaWNoIGV4aXN0cyBldmVuDQpvdXRzaWRlIHlvdXIgcGF0Y2g6IHRoZSBlbmV0IHBo
eSByZWd1bGF0b3IgbmV2ZXIgd29ya2VkIGFzIGV4cGVjdGVkLg0KDQotLQ0KUmVnYXJkcywNCkxl
b25hcmQNCg==
