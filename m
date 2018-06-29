Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B067C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED24827C13
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rX09VMYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED24827C13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965918AbeF2Il7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:41:59 -0400
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:28282
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965487AbeF2Il5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0Rk5Xw9JtzWv6DggZItCEU8YmpOxL2viju+sK8ONx8=;
 b=rX09VMYkyZoHWtiP6H9QNb0vPT4DwftTkVn5OnsKFrNBFxeEAPSCExr4lVvFi+PzyNlcw9f6EXO1moWMDlj7byTw/U8DyDZnm/aH7Hm2szRNgvQ7hfbSGgpg9GX6YaFbD5ICo21iEe9n/ssvUqHwLCwrNjKe+uzPhwKFO5D9AZw=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB532.eurprd04.prod.outlook.com (10.242.113.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Fri, 29 Jun 2018 08:41:52 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.025; Fri, 29 Jun 2018
 08:41:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6: correct anatop regulators range
Thread-Topic: [PATCH] ARM: dts: imx6: correct anatop regulators range
Thread-Index: AQHUD38AdyuDZR4W10i/tnVGAfQSq6R245iAgAAATiCAAAZCAIAAAL7g
Date:   Fri, 29 Jun 2018 08:41:52 +0000
Message-ID: <AM3PR04MB1315000269912D2423AC63D9F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
         <1530260109.22468.60.camel@pengutronix.de>
         <AM3PR04MB13157A4948E36BAE60A8DC49F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <1530261518.22468.62.camel@pengutronix.de>
In-Reply-To: <1530261518.22468.62.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB532;7:LGHQwSYbx2m8oUiKm9LmZ5/tCQP35wHunoJ3j8Di7Bt+W/vSVgdzvB1Abi8t/jdOEADiuGuMnReC9zZ8c7B0KZXMzxbqljuLhArc7mdKkkarJOWEym8V5Vu5YQvkjzYixKUAUw9mg0cgLXmpZjNGTXlRyLhbsjy7FTHA6OG92oNalM2ukaJ/3/vE5Ui1Y9xiB2UYNcN3qMWHimy8FpUvYKEF0rfRN6UolTVaMHLm4GbftMr/bIX/P2Ujj4Yciqru
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 83bf5bc1-0000-4fbb-6c48-08d5dd9c298f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB532;
x-ms-traffictypediagnostic: AM3PR04MB532:
x-microsoft-antispam-prvs: <AM3PR04MB5327F4034CA9E754B198B71F54E0@AM3PR04MB532.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB532;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB532;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(13464003)(189003)(199004)(14454004)(3846002)(6116002)(53936002)(478600001)(99286004)(5660300001)(110136005)(66066001)(8676002)(81166006)(86362001)(81156014)(2201001)(7736002)(256004)(93886005)(305945005)(9686003)(74316002)(5024004)(11346002)(6246003)(446003)(53546011)(6506007)(106356001)(68736007)(33656002)(2501003)(5250100002)(4326008)(102836004)(486006)(186003)(476003)(8936002)(26005)(44832011)(2906002)(97736004)(229853002)(55016002)(6436002)(7696005)(105586002)(76176011)(25786009)(316002)(2900100001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB532;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mGIDSElpK+SP6oG3T6fFCyfl8C6xWAQDrmxVGNdP0F1QtWk7I/5shu1qf09km2iBRZs64Ex8Zr5sM0LKU7mcUM2LhdvWrcK3muCVuzO9x3yIk8wygA/FL3h+zCFGEjYky8+O7hHDwEjfT9oqHHxONkU2Q5Gd5wIfQIdk4COkv2bRGL+0/5tJ9ify1MB08HytRSiw0qkaSVLLJNQhoZb2PmolSA7oVYBTYIXB6BRREE9Q+34Jd8JAZ49fiaAs0wvfO68jqjp/hQfjkb5ORbLC0Z8Q13FJIG9JQBg5l8GA3Kz1WJRQzCTPT8r7uTbhdsIsTx1qGnJJTP7aO5YSpfNzopC5DUUiJ3kpek3NgUPbOaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bf5bc1-0000-4fbb-6c48-08d5dd9c298f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 08:41:52.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1Y2FzDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRvOmwuc3RhY2hAcGVu
Z3V0cm9uaXguZGVdDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyOSwgMjAxOCA0OjM5IFBNDQo+IFRv
OiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8g
RXN0ZXZhbQ0KPiA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDY6IGNvcnJlY3QgYW5hdG9wIHJlZ3VsYXRvcnMg
cmFuZ2UNCj4gDQo+IEFtIEZyZWl0YWcsIGRlbiAyOS4wNi4yMDE4LCAwODoyNyArMDAwMCBzY2hy
aWViIEFuc29uIEh1YW5nOg0KPiA+IEhpLCBMdWNhcw0KPiA+DQo+ID4gQW5zb24gSHVhbmcNCj4g
PiBCZXN0IFJlZ2FyZHMhDQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+ID4gPiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRvOmwuc3RhY2hAcGVuZ3V0cm9u
aXguZGVdDQo+ID4gPiBTZW50OiBGcmlkYXksIEp1bmUgMjksIDIwMTggNDoxNSBQTQ0KPiA+ID4g
PiA+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBzaGF3bmd1b0Br
ZXJuZWwub3JnOw0KPiA+ID4gPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbQ0KPiA+ID4gPiA+ID4gPiA+ID4gPGZhYmlvLmVzdGV2
YW1AbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPiA+ID4gPiA+ID4gPiA+IG1hcmsu
cnV0bGFuZEBhcm0uY29tOw0KPiA+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gPiA+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiBDYzogZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBp
bXg2OiBjb3JyZWN0IGFuYXRvcCByZWd1bGF0b3JzIHJhbmdlDQo+ID4gPg0KPiA+ID4gQW0gRnJl
aXRhZywgZGVuIDI5LjA2LjIwMTgsIDE1OjU0ICswODAwIHNjaHJpZWIgQW5zb24gSHVhbmc6DQo+
ID4gPiA+IENvcnJlY3Qgc29tZSBpLk1YNiBTb0NzIGFuYXRvcCByZWd1bGF0b3JzIHJhbmdlIGFj
Y29yZGluZyB0bw0KPiA+ID4gPiByZWZlcmVuY2UgbWFudWFsLg0KPiA+ID4gPg0KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+DQo+
ID4gPiBOQUNLLg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgd3JvbmcuIFdoaWxlIHRoZSByZWd1bGF0
b3Igc3VwcG9ydHMgdGhpcyByYW5nZSwgdGhlIFNvQw0KPiA+ID4gZG9lc24ndC7CoFRoZSBjdXJy
ZW50IHNldHRpbmdzIGFyZSBkZXJpdmVkIGZyb20gdGhlIGFsbG93ZWQgb3BlcmF0aW5nDQo+ID4g
PiByYW5nZXMgb2YgdGhlIFNvQyAoYXQgbGVhc3QgZm9yIHRoZSBNWDZRREwpLCB3aGljaCBpcyBp
biBhY2NvcmRhbmNlDQo+ID4gPiB3aXRoIGhvdyByZWd1bGF0b3IgY29uc3RyYWludHMgaW4gRFQg
YXJlIG1lYW50IHRvIGJlIHVzZWQuDQo+ID4NCj4gPg0KPiA+IFVuZGVyc3RhbmQgdGhhdCBub3Jt
YWxseSB0aGVzZSByZWd1bGF0b3JzJyB2b2x0YWdlIGFyZSBOT1QgYWRqdXN0ZWQsDQo+ID4gd2Ug
anVzdCB1c2UgdGhlIGRlZmF1bHQgdmFsdWUsIGxldCdzIGp1c3QgY2FsbCB0aGUgb3BlcmF0aW5n
IHJhbmdlIG9mDQo+ID4gdGhlIFNvQyAiU29DIHJhbmdlIiwgbXkgaW50ZW50aW9uIGlzIHRvIG1h
a2UgYWxsIGkuTVg2J3MgYW5hdG9wDQo+ID4gcmVndWxhdG9yIHNldHRpbmdzIGFsaWduZWQgc2lu
Y2UgdGhleSBhcmUgaW4gc2FtZSBzZXJpZXMsIEkgc2F3IHNvbWUNCj4gPiBpLk1YNiBTb0NzIHVz
ZSBzYW1lIFNvQyByYW5nZSBhcyBhbmF0b3AgbGRvIHJhbmdlLCBidXQgc29tZSBhcmUgTk9ULA0K
PiA+IGxpa2UgaW14NnFkbC9pbXg2c3gvaW14NnNsIHVzZSBkaWZmZXJlbnQgU29DIHJhbmdlIHRo
YW4gYW5hdG9wIGxkbw0KPiA+IHJhbmdlLCBidXQgaW14NnVsL3VsbC9zbGwgdXNlIHNhbWUgcmVn
dWxhdG9yIHJhbmdlIGFzIGFuYXRvcCBsZG8sIGFuZA0KPiA+IHJlZ3VsYXRvciAxcDEvMnA1LzNw
MCBhbHNvIGhhdmUgZGlmZmVyZW50IHNldHRpbmdzLCBzb21lIGFyZSB1c2UgU29DIHJhbmdlDQo+
IGFuZCBzb21lIGFyZSBqdXN0IHNhbWUgYXMgYW5hdG9wIGxkbyByYW5nZS4uLi50aGlzIGxvb2tz
IHJlYWxseSBjb25mdXNlZC4NCj4gPg0KPiA+IFNvLCBkbyB5b3UgdGhpbmsgd2UgY2FuIGFkanVz
dCB0aGUgaW14NnVsL3VsbC9zbGwncyByZWd1bGF0b3IgcmFuZ2UgdG8NCj4gPiBiZSBTb0MgcmFu
Z2UgcmF0aGVyIHRoYW4gYW5hdG9wIGxkbyByYW5nZT8gQW5kIGhvdyB0byBkZWZpbmUgdGhlIFNv
Qw0KPiA+IHJhbmdlPyBMaWtlIHRoZSAxcDEgbGRvIHJhbmdlLCBob3cgZG8gd2Uga25vdyB3aGlj
aCByYW5nZSBpcyBmaW5lPyBBcyBJIHNhdw0KPiBpdCBpcyAxdiB+IDEuMnYgb24gaW14NnFkbCwg
YnV0IDAuOHYgfiAxLjM3NXYgb24gaW14NnNsPw0KPiANCj4gSWYgeW91IHdhbnQgdG8gYWxpZ24g
dGhvc2Ugdm9sdGFnZXMgdG8gc29tZXRoaW5nIHRoZW4gaXQncyBkZWZpbml0ZWx5IHRoZSBTb0MN
Cj4gcmFuZ2UgeW91IHdhbnQgdG8gdXNlLiBUaGlzIGlzIGhvdyB0aGUgY29uc3RyYWludHMgYXJl
IHNwZWNpZmllZCBpbiB0aGUgRFQNCj4gYmluZGluZywgYXMgYmVpbmcgdGhlIGFsbG93ZWQgdm9s
dGFnZSByYW5nZSB0aGF0IHdvbid0IGRhbWFnZSBhbnkgb2YgdGhlDQo+IGF0dGFjaGVkIGNvbnN1
bWVycy4NCj4gDQo+IFBsZWFzZSBhbGlnbiB0aGUgY29uc3RyYWludHMgdG8gdGhlIG9wZXJhdGlu
ZyByYW5nZXMsIGFzIHNwZWNpZmllZCBpbiB0aGUNCj4gZGF0YXNoZWV0LiBGb3IgZXhhbXBsZSBh
biBleGNlcnB0IGZyb20gdGhlIGkuTVg2U0wgZGF0YXNoZWV0Og0KPiANCj4gIjQuMy4yLjEgUmVn
dWxhdG9ycyBmb3IgQW5hbG9nIE1vZHVsZXMNCj4gICBMRE9fMVAxDQo+ICAgIFsuLi5dIFR5cGlj
YWwgUHJvZ3JhbW1pbmcgT3BlcmF0aW5nIFJhbmdlIGlzIDEuMCBWIHRvIDEuMiBWIHdpdGggdGhl
DQo+IG5vbWluYWwgZGVmYXVsdCBzZXR0aW5nIGFzIDEuMSBWIg0KPiANCj4gU28gdGhlIHJhbmdl
IGZvciAxcDEgTERPIG9uIGkuTVg2U0wgc2hvdWxkIGJlIDEuMFYgdG8gMS4yViwgd2hpY2ggaXMg
dGhlIHNhbWUNCj4gYXMgaS5NWDZRREwuDQoNCk9LLCB0aGFua3MsIEkgd2lsbCBjaGVjayBhbGwg
dGhlIGRhdGFzaGVldCBhbmQgcmV3b3JrIGEgcGF0Y2guDQoNCkFuc29uLg0KDQo+IA0KPiBSZWdh
cmRzLA0KPiBMdWNhcw0K
