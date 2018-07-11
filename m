Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1693EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD87620846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PmbTrOD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD87620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbeGKNef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:34:35 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:43776
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732721AbeGKNed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w0MRFOjJk0U6yXTw/PZwtmr9qVCCcE6UFf34qXlt90=;
 b=PmbTrOD3WIuAqMJh5IlOLo/THo46uaNzEr/p7Q7ocgbZLwgAt2+2wAP5jZOAy4MyBA4uHZfwXtoDJFo2HauvGep0rqvEkJqK7WCe6DQe0A+pVjZLO0G7Y4sC8VhLZvALr7/Xdo28NwTKUXRIYQ5WpMkBjfXXxh/kMeQziaGefEE=
Received: from HE1PR04MB3004.eurprd04.prod.outlook.com (10.170.255.150) by
 HE1PR04MB1436.eurprd04.prod.outlook.com (10.163.175.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 13:30:04 +0000
Received: from HE1PR04MB3004.eurprd04.prod.outlook.com
 ([fe80::d1a6:2b89:bb94:9c97]) by HE1PR04MB3004.eurprd04.prod.outlook.com
 ([fe80::d1a6:2b89:bb94:9c97%5]) with mapi id 15.20.0930.016; Wed, 11 Jul 2018
 13:30:04 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Topic: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Index: AQHUFsxVUtUWHAUKa0KHHKdrqS9K4KSIhHsAgAEfxQCAAGQzgA==
Date:   Wed, 11 Jul 2018 13:30:04 +0000
Message-ID: <HE1PR04MB3004A524FF80D8BCA79E9DE0885A0@HE1PR04MB3004.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [121.236.244.43]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1436;7:9f98S7HF6yzVXA0nexQTrd/gFOqbhAFnruXoLpLZPqZQMXZVOemMrneJQeYSJRhOLp8lxnx4pTsRFO64irhgyanQMyIfa8qCl0Bow1i8b+eW7u7w0+8rX3d9PJwtEzYtlhRXCBwJZvzLX2mSptnIxQd8BkIfry1rmnlL6GG5c4STawC+iwfH35GbsnJU9OTb3ceko62tDJJhV1A/uCLiT6557gKUac2CbYQKpVBcVKEUV0PdAAPRBBYyLjjAcpJX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bdd8a9ca-53a3-4311-24d4-08d5e732698b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1436;
x-ms-traffictypediagnostic: HE1PR04MB1436:
x-microsoft-antispam-prvs: <HE1PR04MB14360A4B95111A5E8A82773C885A0@HE1PR04MB1436.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1436;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1436;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(13464003)(229853002)(93886005)(5660300001)(66066001)(68736007)(6436002)(105586002)(55016002)(476003)(6306002)(44832011)(74316002)(2906002)(446003)(102836004)(486006)(81156014)(97736004)(26005)(305945005)(256004)(53546011)(6506007)(11346002)(86362001)(81166006)(7736002)(53936002)(4326008)(25786009)(39060400002)(45080400002)(15650500001)(8676002)(110136005)(478600001)(14444005)(7696005)(9686003)(76176011)(33656002)(316002)(8936002)(6246003)(14454004)(99286004)(106356001)(5250100002)(54906003)(2900100001)(6116002)(3846002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1436;H:HE1PR04MB3004.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: shn0msNMA8zqALk8ZU4MOC6CzC7ySTzWXRfpxFUtpkEy2ZkXEWpkQh1OVYMLicUvIdLtgRK+JioNRrZxXBAa11HVwzCKJI2/PigBhQo0jqdWGzqqwfgKKFID04zSchlMfi8J+O5QWD1djFyQrz2A+IRBNPr4e/oCgZsiJzn8XVZWoUpGq/g1urB+qgZ2v3Sl1AtE/PnK9oOLYi7NpQbpPMXAmEOuRJ0xCsJUawxED75qmHp0G74gkde5eQET5emjORh1qO8FNOCaumqL5kL9pKDJip7sw4igvpuy2m5WOy1GqEHnbSKt2zT3TkC+FgtW8aUcBgaaKrpOf4LD2w5LYxHqVeJZlFkdHbiX+78RlYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd8a9ca-53a3-4311-24d4-08d5e732698b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 13:30:04.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQS5TDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQS5zLiBEb25n
DQo+IFNlbnQ6IDIwMTjE6jfUwjExyNUgMTU6MzANCj4gVG86IFNhc2NoYSBIYXVlciA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgZG9uZ2FzODZAZ21haWwuY29tOyBKYXNzaSBCcmFyDQo+IDxqYXNzaXNpbmdoYnJhckBn
bWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBPbGVrc2lqIFJlbXBlbA0K
PiA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3Rl
dmFtQG54cC5jb20+Ow0KPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggVjQgMy81XSBtYWlsYm94OiBpbXg6IGFkZCBpbXggbXUgc3VwcG9ydA0KPiANCj4gSGkgU2Fz
Y2hhLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFNhc2No
YSBIYXVlciBbbWFpbHRvOnMuaGF1ZXJAcGVuZ3V0cm9uaXguZGVdDQo+ID4gU2VudDogVHVlc2Rh
eSwgSnVseSAxMCwgMjAxOCAxMDoyMCBQTQ0KPiA+IFRvOiBBLnMuIERvbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KPiA+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRvbmdhczg2QGdtYWlsLmNvbTsgSmFzc2kNCj4gPiBCcmFyIDxqYXNzaXNpbmdoYnJhckBnbWFp
bC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBPbGVrc2lqDQo+ID4gUmVtcGVs
IDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+Ow0KPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0
ZXZhbUBueHAuY29tPjsNCj4gPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCBWNCAzLzVdIG1haWxib3g6IGlteDogYWRkIGlteCBtdSBzdXBwb3J0DQo+ID4NCj4g
PiBIaSwNCj4gPg0KPiA+IE9uIFN1biwgSnVsIDA4LCAyMDE4IGF0IDEwOjU2OjU1UE0gKzA4MDAs
IERvbmcgQWlzaGVuZyB3cm90ZToNCj4gPiA+IFRoaXMgaXMgdXNlZCBmb3IgaS5NWCBtdWx0aSBj
b3JlIGNvbW11bmljYXRpb24uDQo+ID4gPiBlLmcuIEEgY29yZSB0byBTQ1UgZmlybXdhcmUoTSBj
b3JlKSBvbiBNWDguDQo+ID4gPg0KPiA+ID4gVHggaXMgdXNpbmcgcG9sbGluZyBtb2RlIHdoaWxl
IFJ4IGlzIGludGVycnVwdCBkcml2ZW4gYW5kIHNjaGVkdWxlIGENCj4gPiA+IGhydGltZXIgdG8g
cmVjZWl2ZSByZW1haW4gd29yZHMgaWYgaGF2ZSBtb3JlIHRoYW4NCj4gPiA+IDQgd29yZHMuDQo+
ID4NCj4gPiBZb3UgdG9sZCB1cyB0aGF0IHVzaW5nIGludGVycnVwdHMgaXMgbm90IHBvc3NpYmxl
IGR1ZSB0byBtaXNlcmFibGUNCj4gPiBwZXJmb3JtYW5jZSwgd2UgdGhlbiBwcm92aWRlZCB5b3Ug
YSB3YXkgd2l0aCB3aGljaCB5b3UgY291bGQgcG9sbC4NCj4gPiBXaHkgYXJlIHlvdSB1c2luZyBp
bnRlcnJ1cHRzIG5vdz8NCj4gPg0KPiANCj4gQmVjYXVzZSBtYWlsYm94IGZyYW1ld29yayBkb2Vz
IG5vdCBzdXBwb3J0IHN5bmMgcnggbm93LCBJIHRoaW5rIHdlIGRvIG5vdA0KPiBuZWVkIHRvIHdh
aXQgZm9yIHRoYXQgZmVhdHVyZSBkb25lIGZpcnN0IGFzIGl0J3MgaW5kZXBlbmRlbnQgYW5kICBz
ZXBhcmF0ZQ0KPiBmZWF0dXJlcyBvZiBmcmFtZXdvcmsuDQo+IA0KPiBTbyBmb3Igbm93LCB3ZSdy
ZSBqdXN0IHVzaW5nIHRoZSBjb21tb24gd2F5IGluIGtlcm5lbCBhcyBhcm0gc2NwaSBhbmQgdGkg
c2NpLg0KPiBXaGVuIGZyYW1ld29yayBzdXBwb3J0cyBpdCwgd2UgY2FuIGVhc2lseSBzd2l0Y2gg
dG8gaXQuDQo+IA0KPiBJIG9wdGltaXplZCB0aGUgcGVyZm9ybWFuY2UgYSBiaXQgYnkgcmVtb3Zp
bmcgdGhlIHVubmVjZXNzYXJ5IG1lbWNvcHkNCj4gYmV0d2VlbiB0eC90eCBtZXNzYWdlcy4gVGhl
IHRlc3QgcmVzdWx0IG9mIGJvb3RpbmcgdGltZSBzaG93cyB0aGVyZSdzIG5vDQo+IG9idmlvdXMg
cmVncmVzc2lvbnMuIEknbSBub3Qgc3VyZSB3aGV0aGVyIGl0J3MgZHVlIHRvIHdlJ3JlIGJvb3Rp
bmcgYSBtaW5pbXVtDQo+IHN5c3RlbSBvciB0aGUgZXh0cmEgY29zdCBpcyB2ZXJ5IG1pbm9yIHRv
IGJlIG5vdGljZWQgZHVlIHRvIG5vdCB0b28gbXVjaCBjbWRzDQo+IHNlbnQgZHVyaW5nIGJvb3Rp
bmcuDQo+IChDb3B5IFBlbmcgdG8gY29tbWVudHMgbW9yZSBhcyBoZSB0cmllZCBhbmQgcmVwb3J0
ZWQgdGhhdCBwZXJmb3JtYW5jZSBkcm9wDQo+IHdpdGggdmVuZG9yIHRyZWUpDQoNClRoZSB0eHBv
bGxfcGVyaW9kIGlzIHNldCAxLCB0aGUgbWluaW11bSBpcyAxbXMuIFNvIGl0IGludHJvZHVjZXMg
bGF0ZW5jeSBpbiB0aGUgaW5pdGlhbCBtYWlsYm94DQpmb3IgU0NVIGNvbW11bmljYXRpb24uDQoN
ClJlZ2FyZHMsDQpQZW5nDQoNCj4gDQo+IEZyb20gdGhlIHRpbWUgbWVhc3VyZW1lbnQgb2Ygc2Nf
Y2FsbF9ycGMsIHdlIGNhbiBzZWUgdGhhdCBtb3N0IHJwYyBjb21tYW5kDQo+IEluIHBvbGxpbmcg
bW9kZSBjYW4gZmluaXNoIHdpdGhpbiAxMHVzIGFuZCB2ZXJ5IHJhcmUgb25lcyBvdmVyIDIwdXMu
DQo+IElmIHN3aXRjaGVkIHRvIGlycSBtb2RlLCB0aG9zZSAxMHVzIGNtZHMgd2lsbCBjaGFuZ2Ug
dG8gYWJvdXQgMjB1cy4NCj4gDQo+IEJ1dCB0aGUgb3ZlcmFsbCBib290aW5nIHRpbWUgZGlkIG5v
dCBpbmNyZWFzZSBtdWNoLiBNYXliZSB0aGUgaXJxIG1vZGUgYWxzbw0KPiBzYXZlcyBzb21lIENQ
VSBNSVBTIHRvIGV4ZWN1dGUgb3RoZXIgd29ya3MgaW4gcGFyYWxsZWw/DQo+IA0KPiA+IFdlIGFs
c28gc3VnZ2VzdGVkIGEgd2F5IGhvdyB0aGUgU0NVIG1vZGUgY291bGQgYmUgaW50ZWdyYXRlZCBp
bnRvIHRoZQ0KPiA+IGdlbmVyaWMgTVUgc3VwcG9ydCBkcml2ZXIgT2xla3NpaiBwb3N0ZWQgYW5k
IG5vdyB5b3Ugc2VuZCBhIGRyaXZlcg0KPiA+IHdoaWNoIHVzZXMgdGhlIHNhbWUgbmFtZSBhcyBP
bGVrc2lqcyBkcml2ZXIsIGJ1dCBpdCBvbmx5IGFuZA0KPiA+IGV4Y2x1c2l2ZWx5IHdvcmtzIGlu
IFNDVSBtb2RlLiBUaGlzIGRvZXNuJ3QgYnJpbmcgdXMgZm9yd2FyZC4NCj4gPg0KPiANCj4gQ2Fu
IE9sZWtzaWoncyBwYXRjaCBiZSBpbXBsZW1lbnRlZCBhZ2FpbnN0IHRoaXMgb25lPw0KPiBBcyBJ
IHJlbWVtYmVyIHlvdSBzYWlkIHdlJ3ZlIHN0aWxsIG5vdCBkZXRlcm1pbmVkIHdoZXRoZXIgT2xl
a3NpaidzIGFwcHJvYWNoIGlzDQo+IHRoZSBtb3N0IHN1aXRhYmxlIHdheSBhbmQgaXQncyBzdGls
bCB1bmRlciBkaXNjdXNzaW9uLg0KPiAoQWN0dWFsbHkgVEkncyBhcHByb2FjaCBsb29rcyBiZXR0
ZXIgd2hpY2ggaXMgbW9yZSBzaW1pYXIgYXMgU0NVIHdheT8pDQo+IA0KPiBGdXJ0aGVybW9yZSwg
ZnJvbSB0aGlzIHBhdGNoLCB5b3Ugd2lsbCBub3RpY2UgdGhhdCBPbGVrc2lqJ3MgcGF0Y2ggYWxt
b3N0IGRpZCBub3QNCj4gd29yayBmb3IgU0NVIGF0IGFsbC4gSSBoYXZlIHRvIHRvdGFsbHkgcmV3
cml0ZSBvbmUgZm9yIFNDVS4NCj4gU28gSSBkaWQgbm90IHdyaXRlIGFnYWluc3QgaGlzIHBhdGNo
IGFzIGl0IGRvZXMgbm90IGhlbHAuDQo+IEFuZCBPbGVrc2lqJ3MgcGF0Y2ggaXMgcXVpdGUgc2lt
cGxlIHdoaWxlIHRoZSBTQ1Ugb25lIGlzIG11Y2ggY29tcGxpY2F0ZWQgdGhhbg0KPiBoaXMgb25l
LiBTbyB3ZSBwcm9iYWJseSBiZXR0ZXIgZ2V0IFNDVSBkb25lIGZpcnN0Lg0KPiANCj4gPiBXZSBz
dWdnZXN0ZWQgYSBiaW5kaW5nIHRoYXQgYWxsb3dzIGNvZXhpc3Rpbmcgb2YgdGhlIFNDVSBtb2Rl
IGFuZCB0aGUNCj4gPiBnZW5lcmljIG1vZGUgb2YgdGhlIE1VIGJ5IHB1dHRpbmcgdGhlIG1vZGUg
aW5mb3JtYXRpb24gaW50byB0aGUgc2Vjb25kDQo+ID4gbWJveC1jZWxsLiBXaHkgZG9uJ3QgeW91
IHVzZSB0aGlzPw0KPiA+DQo+IA0KPiBZb3UgbWVhbiB0aGlzPw0KPiArI2RlZmluZSBJTVhfTVVf
Q0hBTk5FTDAJCTANCj4gKyNkZWZpbmUgSU1YX01VX0NIQU5ORUwxCQkxDQo+ICsjZGVmaW5lIElN
WF9NVV9DSEFOTkVMMgkJMg0KPiArI2RlZmluZSBJTVhfTVVfQ0hBTk5FTDMJCTMNCj4gKyNkZWZp
bmUgSU1YX01VX0NIQU5ORUxfSU1YOF9TQ1UgNA0KPiANCj4gSXQncyBoYXJkIGZvciBtZSB0byBi
ZWxpZXZlIGl0J3MgY29ycmVjdCBhbmQgaXQncyBvdmVyIGFic3RyYWN0IHRvIEhXLg0KPiBTbyBJ
IHRob3VnaHQgdXNpbmcgbWJveC1jZWxscyB0byBkaXN0aW5ndWlzaCBzZWVtcyB0byBiZSBiZXR0
ZXIuDQo+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgaXQncyBuZWNlc3NhcnkgdG8gcmV3cml0ZSBPbGVr
c2lqcyBkcml2ZXIsIGluc3RlYWQgaXQNCj4gPiBzaG91bGQgcmF0aGVyIGJlIGV4dGVuZGVkIHdp
dGggdGhlIGNvZGUgSSBhbHJlYWR5IHByb3ZpZGVkIGFzIGFuDQo+ID4gZXhhbXBsZS4gV2l0aCB0
aGF0IHdlIGNvdWxkIG1ha2UgYm90aCBvZiB1cyBoYXBweSBzaW5jZSB3ZSBjYW4gYm90aA0KPiA+
IGhhdmUgYSBzdWl0YWJsZSBkcml2ZXIgYW5kIGV2ZW4gc2hhcmUgbW9zdCBvZiB0aGUgTVUgY29k
ZS4NCj4gDQo+IEFzIEkgc2FpZCBhYm92ZSwgSSBldmVuIGNhbid0IHJldXNlIDkwJSsgY29kZSBv
ZiBPbGVrc2lqcyBkcml2ZXIuIFNvIEkgY2FuJ3Qgc2VlIHRoZQ0KPiBtZWFuaW5nIHRvIGRlbW8g
dGhlIGNvZGUgb24gdG9wIG9mIHRoaXMgZHJpdmVyLiBXZSBjYW4gcmV2aWV3IHRoZSBTQ1UNCj4g
aW1wbGVtZW50YXRpb24gZGlyZWN0bHkgd2l0aCB0aGlzIGRyaXZlciB3aGljaCBpcyBtb3JlIGVh
c3kuDQo+IFRoZW4gd2UgY2FuIGRlY2lkZSBob3cgdG8gbWVyZ2UgdGhlbSB0b2dldGhlci4NCj4g
DQo+IFJlZ2FyZHMNCj4gRG9uZyBBaXNoZW5nDQo+IA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBT
YXNjaGENCj4gPg0KPiA+IC0tDQo+ID4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCj4gfA0KPiA+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAg
ICAgICAgICB8DQo+ID4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3cNCj4gPiB3LnBlbmd1dHJvbml4LmRlJTJGJmFtcDtk
YXRhPTAyJTdDMDElN0NhaXNoZW5nLmRvbmclNDBueHAuY29tJTcNCj4gPg0KPiBDYjM1OWEzZWRk
ZWU1NGJmMWI0MGEwOGQ1ZTY3MDJmMjIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMQ0K
PiA+DQo+IDYzNSU3QzAlN0MwJTdDNjM2NjY4MjkxODYzODQ2NjM5JmFtcDtzZGF0YT1oU3VjYUxS
ZkNCMWoxTWN3bGZPJQ0KPiA+IDJGTDA5MjFRWGlIZzY4c2wlMkIyM0N2RXA0USUzRCZhbXA7cmVz
ZXJ2ZWQ9MCAgfA0KPiA+IFBlaW5lciBTdHIuIDYtOCwgMzExMzcgSGlsZGVzaGVpbSwgR2VybWFu
eSB8IFBob25lOiArNDktNTEyMS0yMDY5MTctMA0KPiB8DQo+ID4gQW10c2dlcmljaHQgSGlsZGVz
aGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8
DQo=
