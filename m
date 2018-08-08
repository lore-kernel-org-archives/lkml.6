Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC96C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0590821A0D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UqaATGCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0590821A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeHHRSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:18:23 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:32288
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbeHHRSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll2ekcpz3g+xvRT2tx9qgL+yMxwDoJ9CmrgfjHffKgQ=;
 b=UqaATGCNWEbwCmU2KY3QY3nzuT8je92RNbmlofyn3wP59ONd0gvv/HsI+e8fIAo+aJYK1xOMuBtSPR9kb94J9m9yK67WXFEMCwSDejIc6yWI3bm0t3VSYm9AO70Pv4UM4OYDCg7mqUPUZ95iCU9p48/Q10uVZhb2inscl6Tvols=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB3954.eurprd04.prod.outlook.com (52.134.90.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 14:58:15 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 14:58:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUI2mAdxFCdwbsIEW0mCMYIbqjI6S1xVuAgAAFxICAAAZagIAALWEAgAAKyQA=
Date:   Wed, 8 Aug 2018 14:58:15 +0000
Message-ID: <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
         <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
         <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
         <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
         <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB3954;6:q9YHQmteK4SxMZmrkrvJMZKErRTBAK/8GIG3HehbqXOozfKFM+F3NPDgy3LOeh8XOpVS/K/g3Mt65VmaNXV7vHy+hsiyerCfZIejsAekP/ypU33dUqmiQkzvDZBMyDF5ghacmvHydDv/CDB5QeOz7Ai0ddTZYkN9zHFFUiYqKG05hz+lzqpvj6QadKl8/fuR7JXgFIIYJe4/eBaWgYjzSmXfBXVyU+1Bw0fR5UF+kfBTQyz54lTZGrK1LuFTl7d8evfRpDhrFh+ym+ejYuDCn64NZeIAxecEpBAddNsG986trWtMlPad9236OGDXK0wJwHMaMRED5dG78G8M37UZffB5+90o+1/yWGsNclt9zndMP/xJlD0F+bLcP2AdCrnXPNXy8OV6FwFQdjNOxYSm++0rayzXMOs0DAiYidMWoHCQejSetMLTd88KjdRIs/+stdtI9vUMVT0M28fIo5a5Fw==;5:+AKlTVoSPz7277BjBQAd5Py2mKrKWccdXH3hDO+A0SGusbsIlsDX5Jj2obPk2Tj7EtUPVVHIB5/v0eiIVAhPE2ic6NTcRJHG6tcTkq4jXdMYYE6rsW3GRschNaf/Wxem4N3L7g+FdY1+CjgwnejYcEBirLCavtVrYhF3MDKUwGE=;7:Q+9LrN8bGVwOyGQWJhHTcBot93VKSBkhAOTuaCirPNupTeaypj5MKBUYEUoR+GZ1rCHAbfUG4DmPIHVSjfuqc3SBzrhAUe+zvOSlV1u8CjLOwtvx+1zOwJ+mjzkZ3anA83INa8IG3KHU6zX/jCdGAD8TIrk4DzhPCmQr2FZu9oheb9wYIvrOePhjqQtcFssl9BKbAME/U7AyFW/mz9Ut2ZRG9JiIIsD+8oVlcKfkbz52Xwo6ZaYC+naJKniLH9cN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df37170b-94f4-4bb1-89ec-08d5fd3f5ea8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3954;
x-ms-traffictypediagnostic: AM0PR04MB3954:
x-microsoft-antispam-prvs: <AM0PR04MB39545D358BE4178487258E53EE260@AM0PR04MB3954.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB3954;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB3954;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(106356001)(6506007)(54906003)(8676002)(44832011)(305945005)(446003)(2501003)(99286004)(76176011)(7736002)(110136005)(8936002)(6512007)(316002)(256004)(81166006)(3846002)(118296001)(53936002)(86362001)(14444005)(105586002)(2906002)(81156014)(6116002)(50226002)(93886005)(68736007)(14454004)(229853002)(5660300001)(66066001)(6486002)(4326008)(11346002)(7416002)(6436002)(2900100001)(186003)(25786009)(97736004)(102836004)(5250100002)(476003)(2616005)(478600001)(36756003)(26005)(39060400002)(486006)(6246003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3954;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f50ElS+uxWgOqQxsCFZc9YYQKH7FM+Qq0/7nKDl00RIAedUKU50L1jIy9Le76SFjm5+qrXWZH9aMSht9o9YkDpC/lK5b6EYGJjJ106OqG6Zu+f4JmvzeehqVooi9z/QC+sX77HWhGbv/jRBpVjbAQacPA4pERrMtQokYSKtM8cbY4G8f6tospZW5a3ZnJFuzMkMbxJJ4moLRa1Nup7ewTFaR6NNlH9zcEAiS8r9Phcc8BL2kbQAAYnzvy1Kq2ASdC8/G6DikOxuMyeXcLMI8jENhYG0pfdxpNXRVXRxs9cfEzqcj3aX/8b7v+Jwi1p9UxXXor0zEspxU0veey9fQa208LvOBEtZ9FokWyNE7SEs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C538179C67ACF54AA9CF6898CCEC8B07@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df37170b-94f4-4bb1-89ec-08d5fd3f5ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 14:58:15.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTA4IGF0IDE1OjE5ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMDgsIDIwMTggYXQgMTE6Mzc6MTRBTSArMDAwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAxOC0wOC0wOCBhdCAxMjoxNCArMDEwMCwgTG9y
ZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEF1ZyAwOCwgMjAxOCBhdCAxMDo1
Mzo1MkFNICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAx
OC0wNy0yNCBhdCAxOToxNCArMDMwMCwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOg0KPiA+ID4gPiA+
IENoYW5nZXMgc2luY2UgdjI6DQo+ID4gPiA+ID4gICogUHJpbnQgd2l0aCBkZXZfaW5mbyBpZiBs
aW5rIGZhaWxzIG9uIHJlc3VtZSAoTHVjYXMpDQo+ID4gPiA+ID4gICogQWRkIGEgY29tbWVudCBv
biBpbXg3ZCBwY2kgaXJxIG1hcHBpbmdzIChBbmRyZXkpDQo+ID4gPiA+ID4gICogTWFrZSBpbXg2
X3BjaWVfbHRzc21fZGlzYWJsZSBwcmludCBhbiBlcnJvciBvbiBJTVg2USAoTHVjYXMpDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gVGhlIGx0c3NtX2Rpc2FibGUgZG9lcyBub3QgcmV0dXJuIGFuIGVy
cm9yIGJlY2F1c2UgaXQgY2FuJ3QgYmUgdXNlZnVsbHkNCj4gPiA+ID4gPiBoYW5kbGVkLCByZXZl
cnNpbmcgcGFydGlhbCBzdXNwZW5kIGlzIGEgbmlnaHRtYXJlIGFuZCB1bmxpa2VseSB0byB3b3Jr
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICAqIERyb3AgInJlc2V0OiBpbXg3OiBGaXggYWx3YXlz
IHdyaXRpbmcgYml0cyBhcyAwIChhY2NlcHRlZCBieSBQaGlsaXBwKQ0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFNlcmllcyBpcyBhZ2FpbnN0IGxpbnV4LW5leHQgdGFnIG5leHQtMjAxODA3MjQgd2hl
cmUgdGhlIHJlc2V0IHBhdGNoIHdhcw0KPiA+ID4gPiA+IGFscmVhZHkgYWNjZXB0ZWQuIFRoZSBp
bXg3ZC5kdHNpIHBhdGNoIGlzIGFsc28gdXNlZnVsIHN0YW5kYWxvbmUuDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGlzIGlzIGEgZ2VudGxlIHJlbWluZGVyIHRoYXQgdGhpcyBzZXJpZXMgd2FzIHJldmll
d2VkIGJ5IEx1Y2FzIHR3bw0KPiA+ID4gPiB3ZWVrcyBhZ28gYnV0IG5vdCB5ZXQgaW5jbHVkZWQu
DQo+ID4gPiANCj4gPiA+IERvZXMgdGhpcyBzZXJpZXMgaGF2ZSBhIGZ1bmN0aW9uYWwgZGVwZW5k
ZW5jeSBvbiB0aGUgcmVzZXQgZml4ID8gSWYgeWVzDQo+ID4gPiB3ZSBjYW4gaGF2ZSBhIGJpc2Vj
dGlvbiBwcm9wbGVtIGRlcGVuZGluZyBvbiB3aGljaCB0cmVlIGdldHMgbWVyZ2VkDQo+ID4gPiBm
aXJzdC4NCj4gPiANCj4gPiBZZXMsIHdpdGhvdXQgdGhlIHJlc2V0IGZpeCBJIGV4cGVjdCBoYW5n
cy4NCj4gPiANCj4gPiBNYXliZSB0aGUgcmVzZXQgZml4IHNob3VsZCBiZSBwdWxsZWQgaW4gdGhl
IHBjaSB0cmVlPyBJIGRvbid0IGtub3cgaG93DQo+ID4gdGhlc2UgaXNzdWVzIGFyZSBzb3J0ZWQg
b3V0Lg0KPiANCj4gV2VsbCBlaXRoZXIgSSBwdWxsIHRoYXQgZml4IGludG8gdGhlIFBDSSB0cmVl
IChidXQgaXQgaXMgYWxyZWFkeSAtcmM4DQo+IGFuZCBJIGNhbid0IGd1YXJhbnRlZSB2NC4xOSBp
bmNsdXNpb24gLSBJIHNoYWxsIHRyeSkgb3IgSSBjYW4gYWNrIHRoZXNlDQo+IHBhdGNoZXMgYW5k
IFBoaWxpcHBlIHdpbGwgc2VuZCB0aGVtIHVwc3RyZWFtIG9uIG15IGJlaGFsZiwgYXRvcCB0aGUN
Cj4gcmVzZXQgZml4IGFib3ZlLg0KPiANCj4gV2hlbiB3aWxsIHRoZSByZXNldCBmaXggd2lsbCBi
ZSBzZW50IHRvIExpbnVzID8gUGxlYXNlIGxldCBtZSBrbm93DQo+IGhvdyB5b3Ugd2FudCB0byBw
cm9jZWVkLg0KDQpJIGhhdmUgc29tZSBvdGhlciB1bnNlbnQgY2hhbmdlcyBmb3IgaW14IHBjaStk
dHMrcmVzZXQgc3RhbmRpbmcgYnkuDQpTaW5jZSB0aGVzZSBjaGFuZ2VzIHF1YWxpZnkgbW9yZSBh
cyAicG0gZmVhdHVyZXMiIHRoYW4gZml4ZXMgSSBkb24ndA0KcmVhbGx5IG1pbmQgc2tpcHBpbmcg
NC4xOS4NCg0KUHVsbGluZyBwY2kgZmVhdHVyZXMgaW50byB0aGUgcmVzZXQgdHJlZSBkb2Vzbid0
IG1ha2UgbXVjaCBzZW5zZSB0byBtZS4NCg0KTWF5YmUgdGhpcyBraW5kIG9mIHN0dWZmIGNvdWxk
IGdvIHRocm91Z2ggU2hhd24ncyB0cmVlPyBUaGVyZSBzaG91bGRuJ3QNCmJlIGFueSBpbnRlcmFj
dGlvbiB3aXRoIG5vbi1pbXggc3R1ZmYu
