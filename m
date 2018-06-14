Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26936C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A81208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVTolUhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A81208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754969AbeFNKRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:17:25 -0400
Received: from mail-ve1eur01on0044.outbound.protection.outlook.com ([104.47.1.44]:2499
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754724AbeFNKRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ6wyy0hke4Iw83O3GNRNpjbHc2uDuDz5KXXy+ZLWL4=;
 b=PVTolUhhfI+sT2lZLXXI+FPsJi3D8yKddZpu/ctfyUi0cqRoTZHx544VxFdPeMcLIeZNTptWVYGOjEUcybP6kGy1P6coic39LNZGf+ACx2LUU5cKIJx1EVTqCaZxfGa7R4uDjWhuG18rLASpmn5XGervbxRSDYW36NZBIshrHJY=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4996.eurprd04.prod.outlook.com (20.177.40.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Thu, 14 Jun 2018 10:17:20 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::7c00:e3c8:5be3:49b6]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::7c00:e3c8:5be3:49b6%2]) with mapi id 15.20.0841.021; Thu, 14 Jun 2018
 10:17:20 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
Thread-Topic: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
Thread-Index: AQHT/oEhJZg5YXx3B0uwk1uiLyWFSqRVBx4AgAqNm4A=
Date:   Thu, 14 Jun 2018 10:17:20 +0000
Message-ID: <a20cc6a0c278cc2791c0bdfc30a79b022de396ef.camel@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
         <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4996;7:hldk9JtpCsG9JYvfjJqUQH40Hw9U4zUVp6/FfyTh5qBiOJpK+YoalB7gYrnbOGyTqDTbcXkW1fQVeOXVcuLfpcODOh3UI/IuXWh5tlYkwdt7HJb12w6+ro/X6WAShY7H2IacewzUI4ghQ3ilKZurY98/soEl6cp7U4+KDaaIX+apaGN7Lb1DI4PBSljmCSMj+mJ018OWCmMcWQYxeZ+TgI9zbnTJwJ4NlRzdRvi/v3pySR22nhPEdVbY0K70bisK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94fff1d1-0d37-4ce7-1a43-08d5d1e00360
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4996;
x-ms-traffictypediagnostic: AM0PR04MB4996:
x-microsoft-antispam-prvs: <AM0PR04MB49966A6F683340E2CA53731CEE7D0@AM0PR04MB4996.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4996;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4996;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(105586002)(44832011)(3280700002)(5250100002)(3660700001)(6862004)(229853002)(68736007)(39060400002)(97736004)(6486002)(6246003)(478600001)(5660300001)(316002)(4326008)(6436002)(36756003)(25786009)(54906003)(2906002)(6636002)(106356001)(486006)(37006003)(14454004)(8936002)(50226002)(26005)(446003)(81166006)(11346002)(6506007)(53546011)(102836004)(53936002)(2616005)(7736002)(305945005)(476003)(8676002)(3846002)(66066001)(118296001)(6512007)(81156014)(99286004)(2900100001)(6116002)(86362001)(76176011)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4996;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QB33FkELHULxFKKCPeH44VbIiWvuCAmCoQ0O5G4zb/wf3XStVXyR+R9VggwSvwv0JypDw2jeaaVqsgO1TxaRAwvTW8GtFVjx+I2RObKOlNvQNEa8LPfTmPTLbPEjEucBBuksNvHPN3Fuv+4KjmBwIKv2e4xRrAs8qI1XkPtyuV8tduLI6/0mY0aYBOckbo/+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3AF7A53089C9641B7FE44997B20215E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fff1d1-0d37-4ce7-1a43-08d5d1e00360
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 10:17:20.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4996
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTA3IGF0IDE0OjA3IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBMZW9uYXJkLA0KPiANCj4gT24gVGh1LCBKdW4gNywgMjAxOCBhdCAyOjAwIFBNLCBMZW9u
YXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlzbDI5MDIzQDQ0IHsNCj4gDQo+IEFjY29yZGlu
ZyB0byBEZXZpY2V0cmVlIFNwZWNpZmljYXRpb24gdjAuMiBkb2N1bWVudDoNCj4gDQo+ICJUaGUg
bmFtZSBvZiBhIG5vZGUgc2hvdWxkIGJlIHNvbWV3aGF0IGdlbmVyaWMsIHJlZmxlY3RpbmcgdGhl
IGZ1bmN0aW9uDQo+IG9mIHRoZSBkZXZpY2UgYW5kIG5vdCBpdHMgcHJlY2lzZSBwcm9ncmFtbWlu
ZyBtb2RlbC4iDQo+IA0KPiBTbyB5b3UgY291bGQgd3JpdGU6DQo+IA0KPiBsaWdodC1zZW5zb3JA
NDQNCg0KT2ssIHdpbGwgZml4IGluIHYyLg0KDQpTaG91bGQgSSBhbHNvIGFzc2lnbiBhIGxhYmVs
LCBsaWtlICJpc2wyOTAyMzogbGlnaHQtc2Vuc29yQDQ0Ij8gSQ0KY291bGRuJ3QgZmluZCBhbnkg
cmVjb21tZW5kYXRpb24gb24gdGhpcy4NCg0KVGhlcmUgYXJlIG5vIGltbWVkaWF0ZSB1c2VzIGZv
ciBhIGxhYmVsIGJ1dCB0aGlzIHByYWN0aWNlIGlzIHZlcnkNCmNvbW1vbi4gSGF2aW5nIGxhYmVs
cyBhbGxvd3MgY3JlYXRpbmcgbWlub3IgYm9hcmQgdmFyaWFudHMgd2l0aCByZWR1Y2VkDQpjaHVy
biBpbiB0aGUgYmFzZSBkdHMgc28gaXQgc2VlbXMgZ29vZC4NCg0KLS0NClJlZ2FyZHMsDQpMZW9u
YXJk
