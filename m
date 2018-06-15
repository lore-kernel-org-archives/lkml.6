Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120FCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F2F208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoRO2SW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F2F208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966032AbeFOU6M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:58:12 -0400
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:22992
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753735AbeFOU6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lW5RmukXOD8jW8Cz4x6u8Is0h2KDl4OWNhl3hxdDow=;
 b=QoRO2SW+bO+tcjzX2y8wUMFoRRdwPz40GCO3ik5Pg1wPBmsBg3GkIFjp1c5jHOJ73Auhhdp+xgv2oAXTEgc+I3mHywNgMpRknyOsSeDXf8VcdsK2mB1+l1qOripvjtAAHXRg4DonMPfQA/GQckxG97fWunTlYiR9Wai3Jaamfys=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4370.eurprd04.prod.outlook.com (52.135.148.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 15 Jun 2018 20:58:07 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec%2]) with mapi id 15.20.0863.016; Fri, 15 Jun 2018
 20:58:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Thread-Topic: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Thread-Index: AQHUBOE6dIO4bv5XOkuQXfh+MS7cPKRhubYAgAATpQA=
Date:   Fri, 15 Jun 2018 20:58:06 +0000
Message-ID: <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
         <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
         <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.2-1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4370;7:934wPVP4CexRiGbtuqiNzOWx97KPsZ0H9ijSKppQsW6/wU8uFhjU5l/I2TSQwyBCWaV5oTVectvMC6KKv6z76wC7bWXedhjXKFjPEvb8lBGM5V0WEbsOSRlZLsy/i2y5OxDUkFtsZP05yU2zckAneY3qbB3/aK3eIaOKH+veASqRU0YVitJ6DpbFJEQYGntl7n+PHfdeXCtsVzyWiuEUvZ9XTzRdOrIJ7RQbYf29vtQCv5EfMJVRnGWGLbLNdk41
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdf519d1-4a09-48b1-4e24-08d5d302b1e5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4370;
x-ms-traffictypediagnostic: AM0PR04MB4370:
x-microsoft-antispam-prvs: <AM0PR04MB437035B3ADD68E168CF66BF6EE7C0@AM0PR04MB4370.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4370;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4370;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(76176011)(59450400001)(14454004)(81156014)(26005)(6506007)(118296001)(561944003)(81166006)(102836004)(53546011)(97736004)(478600001)(8676002)(966005)(106356001)(105586002)(6512007)(6306002)(2906002)(36756003)(3660700001)(50226002)(6246003)(6486002)(2900100001)(53936002)(3280700002)(68736007)(229853002)(6436002)(2501003)(5250100002)(5660300001)(66066001)(446003)(2616005)(7416002)(476003)(11346002)(25786009)(39060400002)(4326008)(486006)(305945005)(7736002)(54906003)(110136005)(316002)(44832011)(2201001)(8936002)(3846002)(6116002)(86362001)(186003)(99286004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4370;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r4qoIPaMwrFsod+9pex2zCT5wreKKv3d6KCRYRYyyZsUGf9GL7QZawWeMhuqOquZ7y8yCCO+gi6Q+FmRG9Otp38SsNrxWMUM1q6jTrSpnyRcxqhmx/uh7Y1xrm09F4Wk5YugW4EtsxhB8iKpwN4CvZOhxJJDIhipWR9WWkVxnGlkMbZunFmGfRs3zgLDuIRf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F6F90A1F6B40E47B9E906E5E6560708@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf519d1-4a09-48b1-4e24-08d5d302b1e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 20:58:06.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA2LTE1IGF0IDE2OjQ3IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
DQo+IE9uIEZyaSwgSnVuIDE1LCAyMDE4IGF0IDQ6NDMgUE0sIExlb25hcmQgQ3Jlc3Rleg0KPiA8
bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+IHdyb3RlOg0KPiA+IFRoZSBGQkRFViBkcml2ZXIgdXNl
cyB0aGUgc2FtZSBuYW1lIGFuZCBib3RoIGNhbid0IGJlIHJlZ2lzdGVyZWQgYXQgdGhlDQo+ID4g
c2FtZSB0aW1lLiBGaXggdGhpcyBieSByZW5hbWluZyB0aGUgZHJtIGRyaXZlciB0byBteHNmYi1k
cm0NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jl
c3RlekBueHAuY29tPg0KPiANCj4gU3RlZmFuIHNlbnQgdGhlIHNhbWUgcGF0Y2ggYSBmZXcgZGF5
cyBhZ286DQo+IGh0dHA6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvZHJpLWRldmVsL21zZzE3OTQ4
OS5odG1sDQoNCkluIHRoYXQgdGhyZWFkIHRoZXJlIGlzIGEgcHJvcG9zYWwgZm9yIHJlbW92aW5n
IHRoZSBvbGQgZmJkZXYvbXhzZmINCmRyaXZlciBlbnRpcmVseS4NCg0KVGhhdCB3b3VsZCBicmVh
ayBvbGQgRFRCcywgaXNuJ3QgdGhpcyBnZW5lcmFsbHkgY29uc2lkZXJlZCBiYWQ/IEFsc28sDQph
cmUgd2Ugc3VyZSB0aGUgcmVtb3ZhbCBvZiBmYmRldi9teHNmYiB3b3VsZG4ndCBsb3NlIGFueSBm
ZWF0dXJlcz8NCg0KV2hhdCBteSBzZXJpZXMgZG9lcyBpcyBtYWtlIGJvdGggZHJpdmVycyB3b3Jr
IHdpdGggdGhlIHNhbWUga2VybmVsDQppbWFnZSBhbmQgdHVybnMgdGhlIGNob2ljZSBpbnRvIGEg
Ym9hcmQtbGV2ZWwgZHRiIGRlY2lzaW9uLiBTdXBwb3J0aW5nDQpldmVyeXRoaW5nIGF0IG9uY2Ug
c2VlbXMgZGVzaXJhYmxlIHRvIG1lIGFuZCBpdCBhbGxvd3MgZm9yIGEgdmVyeQ0Kc21vb3RoIHVw
Z3JhZGUgcGF0aC4NCg0KVGhlIG9sZCBkcml2ZXIgY291bGQgYmUgcmVtb3ZlZCBsYXRlciwgYWZ0
ZXIgYWxsIHVzZXJzIGFyZSBjb252ZXJ0ZWQuDQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA==
