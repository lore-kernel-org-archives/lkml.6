Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78918C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2813120875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bdgPrfXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2813120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeGIO7j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:59:39 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:40139
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932903AbeGIO7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyTYGTwREWTMXtAxJdFRK9MEhrAqg/rAaL4iwpjQm4E=;
 b=bdgPrfXTHPNPVXfxEc0B/bDGI5L3IGccmKL3lcMf4/Rw5TuETvMIg9CwNYkYZyuJSwg5X4uYkg5xxOxgbx3VMQ4GU5JLT918l6lzbqJdaDr3FcwTb8kH464Y30iwh4ymAdwj0yT1RW13xnVXS4MHwh9breim7C4JGX7L1bdFqEQ=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4370.eurprd04.prod.outlook.com (52.135.148.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 14:59:33 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4%2]) with mapi id 15.20.0930.016; Mon, 9 Jul 2018
 14:59:33 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Thread-Index: AQHT/zW2MJXwgkaSqkWoaZZ+xNMvtaR8UuMAgAECJQCACddmgA==
Date:   Mon, 9 Jul 2018 14:59:33 +0000
Message-ID: <e36fac6f4907288c58a7dfa112541e73de957d46.camel@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
         <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
         <1528468422.26356.20.camel@pengutronix.de>
         <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
         <1530607328.22468.102.camel@pengutronix.de>
In-Reply-To: <1530607328.22468.102.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4370;7:Y+tDoj1CtYzzhZ3umvPrH+HKfWBSn9bp92Qe8awADI4CBpot9yfFydwhazg/1JwMnXxLmz5Dl/RrJZVjHic/ZF54uF7dlBBEDF/MXGt2WqIvNWkKcSg4NcnRmDGLHKHgmxanoo8SJfirTsuW1WCvAbb0z0vIQeCpcy9Vws4BWawmn3G9ypPlLV0eCd/Cdyt9Hjrs6edHx/V7BTuhVueyYyE0tUo/BM2hOXXg9CvN8BZQHdX6E92IFNxl3/yfWSSS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1c3e56b8-c527-4094-7c9a-08d5e5ac94e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4370;
x-ms-traffictypediagnostic: AM0PR04MB4370:
x-microsoft-antispam-prvs: <AM0PR04MB43705AF144E8AFE051470952EE440@AM0PR04MB4370.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4370;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4370;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(51444003)(7736002)(3846002)(305945005)(6116002)(81166006)(50226002)(8676002)(81156014)(8936002)(2906002)(106356001)(25786009)(4326008)(105586002)(39060400002)(2900100001)(5660300001)(6246003)(53936002)(5250100002)(2501003)(118296001)(7416002)(97736004)(6512007)(68736007)(36756003)(93886005)(110136005)(102836004)(229853002)(6486002)(6436002)(99286004)(2201001)(256004)(11346002)(76176011)(44832011)(476003)(2616005)(486006)(478600001)(14454004)(446003)(54906003)(26005)(186003)(86362001)(14444005)(6506007)(316002)(66066001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4370;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /F+y87WPbU4lD7rgfc4VymCiaJj3cjgdSQ9R/fp7+J2ixLKqQz3eo6u7GMJQkvF2zf5B8jSk26Cp9vLd2Dw4Oom5cdhTsDQ19vhy/k70+ketW9qKxa0meq9IOw5yONPq2I3yy9O6qeWX0rDAijD07ZbuX3ORL1T1oqP+44ZKgviLDm1AdRXqqUGBDakJRbs6sj5Jicm2B2ftbeVymLqHrNOUdoelxUmjYE4QJOHI8Uz1G7KbC2ObPDOrJ46UfYtnNyfL83qiE+chozo6pL+vif2IbfM5yYAdwyyv6Cd3x5lv4W1q/0UxGdKXLGlLl9vdHCtgXZeUbNRXQ/zI3chdM3vyVrs1CKiK4Kva5EfS4BM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B61CF5608B5F45A9CBA820DF8ACA13@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3e56b8-c527-4094-7c9a-08d5e5ac94e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 14:59:33.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTAzIGF0IDEwOjQyICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTW9udGFnLCBkZW4gMDIuMDcuMjAxOCwgMTc6MTggKzAwMDAgc2NocmllYiBMZW9uYXJkIENy
ZXN0ZXo6DQo+ID4gT24gRnJpLCAyMDE4LTA2LTA4IGF0IDE2OjMzICswMjAwLCBMdWNhcyBTdGFj
aCB3cm90ZToNCj4gPiA+IEFtIERpZW5zdGFnLCBkZW4gMjkuMDUuMjAxOCwgMjI6MzkgKzAzMDAg
c2NocmllYiBMZW9uYXJkIENyZXN0ZXo6DQo+ID4gPiA+IE9uIGlteDdkIHRoZSBwaHkgaXMgdHVy
bmVkIG9mZiBpbiBzdXNwZW5kIGFuZCBtdXN0IGJlIHJlc2V0IG9uIHJlc3VtZS4NCj4gPiA+ID4g
UmlnaHQgbm93IGxzcGNpIC12IGZhaWxzIGFmdGVyIGEgc3VzcGVuZC9yZXN1bWUgY3ljbGUsIGZp
eCB0aGlzIGJ5DQo+ID4gPiA+IGFkZGluZyBtaW5pbWFsIHN1c3BlbmQvcmVzdW1lIGNvZGUgZnJv
bSB0aGUgbnhwIHZlbmRvciB0cmVlLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyBjdXJyZW50
bHkgb25seSBlbmFibGVkIGZvciBpbXg3IGJ1dCB0aGUgc2FtZSBzZXF1ZW5jZSBjYW4gYmUNCj4g
PiA+ID4gYXBwbGllZCB0byBvdGhlciBpbXggcGNpZSB2YXJpYW50cy4NCj4gPiA+ID4gKyNpZmRl
ZiBDT05GSUdfUE1fU0xFRVANCj4gPiANCj4gPiBBbm90aGVyIGlzc3VlIHRoYXQgc2hvdWxkIGJl
IGRpc2N1c3NlZCBoZXJlIGlzIHRoYXQgb24gNnN4IGFuZCA3ZCB0aGUNCj4gPiBncGMgUENJRSBw
b3dlciBkb21haW4gaXMgbm90IGRlZmluZWQgY29ycmVjdGx5OiB0aGUgUENJRSBibG9jayBpcyBp
bg0KPiA+IHRoZSBESVNQTUlYIGRvbWFpbiBvbiBib3RoIFNPQ3MgYW5kIGl0IGlzIG9ubHkgUENJ
RV9QSFkgd2hpY2ggaGFzIGENCj4gPiBzZXBhcmF0ZSBwb3dlciBkb21haW4uDQo+ID4gDQo+ID4g
VGhpcyBtYXR0ZXJzOiBlbmFibGluZyBwb3dlci1nYXRpbmcgZm9yIGRpc3BsYXlzIHdpbGwgYnJl
YWsgcGNpZSBpZg0KPiA+IHRoaXMgcmVsYXRpb25zaGlwIGlzIG5vdCB0YWtlbiBpbnRvIGFjY291
bnQuIEhlcmUgYXJlIHNvbWUgb3B0aW9uczoNCj4gPiANCj4gPiAxKSBNYWtlICZwZF9wY2llIGEg
Y2hpbGQgb2YgJnBkX2Rpc3AgYnkgaGFja2luZyBpbnRvIGdwYyBwcm9iZQ0KPiA+IGZ1bmN0aW9u
cyBhbmQgY2FsbGluZyBwbV9nZW5wZF9hZGRfc3ViZG9tYWluLiBOb3QgdmVyeSBuaWNlLg0KPiA+
IA0KPiA+IDIpIFN1cHBvcnQgbmVzdGluZyBQR0NzIGluIEdQQyBjb2RlPyBMb3RzIG9mIGNvZGUg
YW5kIHN0aWxsIGFuDQo+ID4gaW5jb3JyZWN0IHJlcHJlc2VudGF0aW9uIG9mIGhhcmR3YXJlLg0K
PiA+IA0KPiA+IDMpIFNldCBwb3dlci1kb21haW5zID0gPCZwZF9kaXNwPiBhbmQgZW5hYmxlIHJ1
bnRpbWUgUE0gb24gJnBkX3BjaWU/DQo+ID4gDQo+ID4gNCkgQWRkIHNlcGFyYXRlIGRldmljZXMg
Zm9yIHRoZSBwY2llLXBoeS4gVGhlc2Ugd291bGQgYmUgbW9zdGx5IGVtcHR5DQo+ID4gYnV0IHN0
aWxsIGRpZmZlcmVudCwgZm9yIGV4YW1wbGUgb24gaW14NnN4IHRoZSBQSFkgaXMgbm90IGV2ZW4N
Cj4gPiBhY2Nlc3NpYmxlIG9uIHRoZSBidXMgYnV0IG9ubHkgdGhvdWdoIFBDSUUgcmVnaXN0ZXJz
Lg0KPiANCj4gNSkgVGFrZSBhIGxvb2sgYXQgdGhlIGxpbnV4LXBtIGxpc3QuIDspIFRoZSBwb3dl
ciBkb21haW4gZnJhbWV3b3JrIGhhcw0KPiBqdXN0IGdhaW5lZCBzdXBwb3J0IGZvciBtdWx0aXBs
ZSBwb3dlciBkb21haW5zIHBlciBkZXZpY2UuIEkgdGhpbmsgdGhhdA0KPiAgaXMgdGhlIHJpZ2h0
IHNvbHV0aW9uIGZvciB0aGlzLCBhcyBsaWtlIHlvdSBtZW50aW9uZWQgdGhlIFBIWSBpc24ndA0K
PiByZWFsbHkgYSBzZXBhcmF0ZSBibG9jayBvbiBpLk1YNiwgYnV0IHBhcnQgb2YgdGhlIFBDSWUg
Y29udHJvbGxlcg0KPiBkZXZpY2UuDQoNClllcywgSSBub3RpY2VkIHRoYXQgZWFybGllciBidXQg
bm90IHRoYXQgaXQgd2FzIG1lcmdlZCByZWNlbnRseS4gSXQgaXMNCmEgYmV0dGVyIHNvbHV0aW9u
Lg0KDQpVbmZvcnR1bmF0ZWx5IHRoZSBtdWx0aXBsZSBwb3dlci1kb21haW4gY29kZSBzZWVtcyB0
byByZXF1aXJlIGRldmljZXMNCnRvIGV4cGxpY2l0bHkgZmV0Y2ggcmVmZXJlbmNlcyB0byB0aGUg
cG93ZXIgZG9tYWlucyBhbmQgbWFuaXB1bGF0ZQ0KdGhlbS4gQXMgZmFyIGFzIEkgY2FuIHRlbGwg
dGhpcyBtZWFucyB0aGF0IGV2ZXJ5IGRldmljZSB1c2luZyBtdWx0aXBsZQ0KcG93ZXIgZG9tYWlu
cyBoYXMgdG8gYmUgbW9kaWZpZWQgdG8gZG8gc28uIEluIHRoaXMgcGFydGljdWxhciBjYXNlIGl0
DQp3b3VsZCBiZSB1c2VmdWwgdG8ganVzdCBoYXZlIGFsbCBwb3dlciBkb21haW5zIHR1cm5lZCBv
biBiZWZvcmUgcHJvYmUsDQpqdXN0IGxpa2Ugd2hlbiBhIHNpbmdsZSBwb3dlci1kb21haW4gaXMg
c3BlY2lmaWVkOg0KDQogICAgcG93ZXItZG9tYWlucyA9IDwmcGRfcGNpPiwgPCZwZF9kaXNwPjsN
Cg0KQnV0IHRoaXMgaXNzdWUgaXMgbm90IHN0cmljdGx5IHJlbGF0ZWQgdG8gaW14N2QgcGNpIGhh
bmdpbmcgb24NCnN1c3BlbmQvcmVzdW1lLCBpdCBjYW4gYmUgZGVhbHQgd2l0aCBsYXRlci4NCg0K
LS0NClJlZ2FyZHMsDQpMZW9uYXJk
