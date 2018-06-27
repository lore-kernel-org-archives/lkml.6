Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC75C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A726649
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bsyT0y1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8A726649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965529AbeF0ORk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:17:40 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:48270
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932579AbeF0ORg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlNBwKBssJSN6ntzUwC1Nm3aPXnmvWV5LjII/yKfhFo=;
 b=bsyT0y1DS9ieKYxjaZ9NFM01Wm4/AEGJvwZpkZfsOkbciNOnVkJGkNklVfD8hG4IQVSEo7Ebw4Qoa7KrmKEb2IXuS/ORPUyxXx0SnePGIyxXE24kbXKFqcZkkPevWtVb2uqb+Z7NO9taTbx13HZDvK1FIOF4bsk6sfK6xjeCyHM=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Wed, 27 Jun 2018 14:17:32 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec%2]) with mapi id 15.20.0884.024; Wed, 27 Jun 2018
 14:17:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     "A.s. Dong" <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Subject: Re: [RFC 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
Thread-Topic: [RFC 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
Thread-Index: AQHT/PA5iHo7Vc5Ckki13LXd18qp/6RS9pqAgCFSsYA=
Date:   Wed, 27 Jun 2018 14:17:32 +0000
Message-ID: <9213574bccbb62a8055c8840397ab947a8a085f6.camel@nxp.com>
References: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
         <b75a4dc8fa208ca9f9009fd0b0c9789a8b1f28c6.1528218001.git.leonard.crestez@nxp.com>
         <1528277099.26063.11.camel@pengutronix.de>
In-Reply-To: <1528277099.26063.11.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4290;7:ai8c4pC44wZyfNNHKVCyTK03Tm9jVBBoV0O3gSStcPZA1O/xkQqNODXnp+Ab3Kq0EkOxbCW1hQOO6pUfD24Q23LuPSw7f5nyLbFaEP75oVtWbzssB+O9KKEbgBQFCe6AuAV3ZQ0tOzXo3wIDuDpGJc57kI7TeJvJpJ0t0Sv7lfBG3QOLdsPl/XPADv4/GaRK96JXJy2+asdADZOD9LO2pl9OJzCHoS0HU6Irny0BZxvLKWF5vayyp39Jz4J4XZqj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 105efcdf-a589-425e-2015-08d5dc38b8f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
x-ms-traffictypediagnostic: AM0PR04MB4290:
x-microsoft-antispam-prvs: <AM0PR04MB42908AA48E0E0B5AFDF98D1AEE480@AM0PR04MB4290.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(264314650089876);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(14454004)(86362001)(97736004)(2900100001)(8936002)(81166006)(118296001)(2501003)(53936002)(36756003)(81156014)(5250100002)(76176011)(6512007)(25786009)(14444005)(26005)(6306002)(256004)(5660300001)(966005)(6116002)(2906002)(102836004)(478600001)(3846002)(105586002)(7736002)(106356001)(486006)(44832011)(2616005)(186003)(476003)(50226002)(446003)(66066001)(11346002)(6636002)(54906003)(99286004)(110136005)(305945005)(6246003)(8676002)(68736007)(6506007)(6486002)(229853002)(6436002)(4326008)(316002)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T2Wn4gUwv7DNjf8TY60pq/8uWrkHtAC8K1bN42Lr3k9oK7VZAD6495zQfGnUAU901DPgNyTdD0REUqMe0qxrejqYwfwbsmoZcGYIlvHd8xJbTJ6ZdmSueNjCzMubFyFntA2wOJcHdUkCq6gZ9jxNdLZ9Rs7q9xLzz8azWsAni6BGyvYc9VyqIIeW6/CEfmrVILQ6UxNDhZT38ICfGSjukZtChmx2KJVcZOP0YYG/Zmrkwz9rTSExFOgl9o2lHYoyYAd3XXbqdbxoS7+KAlkVieNTi3bbItXHp9qGZ5kE54yj6q7HnV/mZjLlL24IaNqWT7qeWJPosWHj1H8v3C9rE4CF2xQ+dQXtMcnA1+C4ruk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <39C2B5C3F3C6754A87AFA658DC8E0752@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105efcdf-a589-425e-2015-08d5dc38b8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 14:17:32.0832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTA2IGF0IDExOjI0ICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gRGllbnN0YWcsIGRlbiAwNS4wNi4yMDE4LCAyMDoxMSArMDMwMCBzY2hyaWViIExlb25hcmQg
Q3Jlc3RlejoNCj4gPiBXaXRoIG9sZCBiaW5kaW5ncyBpbXhfZ3BjX29uZWNlbGxfZGF0YSBhbHdh
eXMgc2V0cyBudW1fZG9tYWlucyB0byAyIHNvDQo+ID4gdGhlIERJU1BNSVggZG9tYWluIGNhbid0
IGFjdHVhbGx5IGJlIHJlZmVyZW5jZWQuIFRoZSBwZCBpcyBzdGlsbCBkZWZpbmVkDQo+ID4gYW5k
IHBtIGNvcmUgc2h1dHMgaXQgZG93biBhcyAidW51c2VkIiBzbyBkaXNwbGF5IGNhbid0IHdvcmsu
DQo+ID4gDQo+ID4gQ29udmVydGluZyB0byBuZXcgZ3BjIGJpbmRpbmdzIGJ5IGFkZGluZyBwZ2Mg
bm9kZXMsIGFsc28gcmVmZXJlbmNlDQo+ID4gcmVmZXJlbmNpbmcgdGhlIG5ld2x5LWRlZmluZWQg
JnB1X2Rpc3AgZG9tYWluIGZyb20gJmxjZGlmLg0KPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
TGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gPiANCj4gPiAtLS0N
Cj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kgfCAzNSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBUaGVyZSBhcmUgZXJyYXRhcyByZWdhcmRpbmcg
ZGlzcG1peCBvbiA2c2wgc28gdGhpcyBtaWdodCBiZSB3cm9uZw0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZzbC5kdHNpDQo+ID4gaW5kZXggYWI2YTdlMmU3ZThmLi45OTgyODc0ZmEzOWUgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kNCj4gPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2c2wuZHRzaQ0KPiA+IEBAIC02OTQsMTQgKzY5NCw0MiBAQA0KPiA+ID4g
IAkJCQlyZWcgPSA8MHgwMjBkYzAwMCAweDQwMDA+Ow0KPiA+ID4gIAkJCQlpbnRlcnJ1cHQtY29u
dHJvbGxlcjsNCj4gPiA+ICAJCQkJI2ludGVycnVwdC1jZWxscyA9IDwzPjsNCj4gPiA+ICAJCQkJ
aW50ZXJydXB0cyA9IDwwIDg5IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ID4gIAkJCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZpbnRjPjsNCj4gPiA+IC0JCQkJcHUtc3VwcGx5ID0gPCZyZWdfcHU+
Ow0KPiA+ID4gLQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlNMX0NMS19HUFUyRF9PVkc+LA0KPiA+
ID4gLQkJCQkJIDwmY2xrcyBJTVg2U0xfQ0xLX0dQVTJEX1BPREY+Ow0KPiA+ID4gKwkJCQljbG9j
a3MgPSA8JmNsa3MgSU1YNlNMX0NMS19JUEc+Ow0KPiA+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJp
cGciOw0KPiA+ID4gIAkJCQkjcG93ZXItZG9tYWluLWNlbGxzID0gPDE+Ow0KPiANCj4gVGhlIGFi
b3ZlIHBvd2VyLWRvbWFpbi1jZWxscyBuZWVkcyB0byBnbyBhd2F5IHdoZW4gdXNpbmcgdGhlIG5l
dw0KPiBiaW5kaW5nLg0KDQpZZXMsIEkgZml4ZWQgdGhpcyBmb3IgbmV4dCB2ZXJzaW9uLg0KDQpI
b3dldmVyIGZvciBpbXg2c2wgdGhlcmUgaXMgYSB2ZXJ5IG5hc3R5IGVycmF0YSBwdWJsaXNoZWQg
YW5kIEkndmUgYmVlbg0KdW5hYmxlIHRvIGdldCBjb25maXJtYXRpb24gb2YgYSBmaXggaW4gbGF0
ZXIgdmVyc2lvbnMgc28gaXQgc2hvdWxkDQpwcm9iYWJseSByZWNlaXZlIHRoZSBQR0NfRE9NQUlO
X0ZMQUdfTk9fUEQgdHJlYXRtZW50Lg0KDQpTZWUgRVJSMDA2Mjg3IGluIGh0dHBzOi8vd3d3Lm54
cC5jb20vZG9jcy9lbi9lcnJhdGEvSU1YNlNMQ0UucGRmDQoNCkFueSBjb21tZW50cyBvbiB0aGUg
Zmlyc3QgcGF0Y2ggZm9yIG14c2ZiPyBJdCdzIGZhciBtb3JlIGludGVyZXN0aW5nLg==
