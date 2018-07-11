Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD5CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A84D208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G5L4lNc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A84D208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeGKGjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:39:51 -0400
Received: from mail-he1eur01on0072.outbound.protection.outlook.com ([104.47.0.72]:48768
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeGKGju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9asBddZr7Uv9jYc2+RNPEi4+y2YPrSWPRyV2IOPTX1M=;
 b=G5L4lNc5mWbEZILYaAecuO+qulj6f9gfcIL7KLLa3Ht4NRcbNNQUfVzF12vWeiiYDTsbNjeLXjbBFsAjQI+DZRiMLJeyTTpmBKwEX4kx4I5wq/G3gVu95BfQ944/2tY2i4jIHn22hB8mg6ZwVbmYk56f3YEMXIG+lLmeZDL309g=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3093.eurprd04.prod.outlook.com (10.170.213.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Wed, 11 Jul 2018 06:37:02 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 06:37:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Thread-Topic: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Thread-Index: AQHUGCdtKxI/TRPiJk21nKgSpY3ZgaSIlmEAgADzhiA=
Date:   Wed, 11 Jul 2018 06:37:02 +0000
Message-ID: <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
 <20180710153326.GG3219@vkoul-mobl>
In-Reply-To: <20180710153326.GG3219@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3093;7:DE/dbMk33qusRWN3utwGsRe01r2qdGF8EyOZEknqqb5UUktIk0T36T0eoMdJ2LiANi6Tm2iLiUVrcqdfH3M0b6Nnsg65NDcanfNTEu2c6TPc6IS2KOvM/VRTXs49FSouHtl8ZBCK50q7WgjI5xT+4vLIeTaDXtLAiZv9CKaUXUo024UzumT+1msalubqChoJsrIGVukGNPJIbI2u6zrWZIHX3eYs1xWnyh6OGx9pf5ztMum/WsGUMZRvKntfygjw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eaa430c9-e1cc-46b6-c5fd-08d5e6f8b5fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3093;
x-ms-traffictypediagnostic: DB6PR04MB3093:
x-microsoft-antispam-prvs: <DB6PR04MB30936723962BC074628B7E4F895A0@DB6PR04MB3093.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3093;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3093;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(13464003)(256004)(6506007)(26005)(81156014)(186003)(6436002)(3846002)(7696005)(486006)(9686003)(316002)(66066001)(54906003)(76176011)(476003)(25786009)(86362001)(8676002)(55016002)(11346002)(6116002)(53546011)(8936002)(81166006)(14444005)(53936002)(99286004)(446003)(68736007)(2906002)(102836004)(33656002)(229853002)(74316002)(14454004)(7736002)(2900100001)(6916009)(478600001)(4326008)(105586002)(106356001)(5250100002)(97736004)(305945005)(6246003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3093;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cw1hvxB7V0rjXdtmaT5v4ZONiTckxLa5sE7fTlcwT5DzglPGnNtKER2Ece7KDJn9tHakQnFiDLqHtycUznso/Qrl35kvypZddhQk1xdbxaic2PVA6aAf1WcBxU8Z3e5ZUJoq7YjxeV4MMHuE3VDWle3WKw5MgR7ZT9jI+oNFtFbggQ8G/hc3qO3Y4i0AhsKS0SgR8BdzLeCaZslB7fWzsj393qv/Oqp9BC28DiPWF5J3UuWvX7TWmRBvD73NzMOzeuhAZNHtaIivL+P/ZRy2nsbJmySvxUbK60iEIBip1VAj2rAqoE0q3IJR2MuKMBa2+UkoqxNP1S1XJHrQfQn31TifujXtp66NCEL+PV+HtEA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa430c9-e1cc-46b6-c5fd-08d5e6f8b5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 06:37:02.1296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbm9kIFttYWlsdG86dmtv
dWxAa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOMTqN9TCMTDI1SAyMzozMw0KPiBUbzogUm9iaW4g
R29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiBDYzogZGFuLmoud2lsbGlhbXNAaW50ZWwuY29t
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxIDMvNF0gZG1hZW5naW5lOiBpbXgtc2RtYTogc3VwcG9ydCBkbWF0ZXN0DQo+
IA0KPiBPbiAxMS0wNy0xOCwgMDA6MjMsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gZG1hdGVzdCht
ZW1jcHkpIHdpbGwgbmV2ZXIgY2FsbCBkbWFlbmdpbmVfc2xhdmVfY29uZmlnIGJlZm9yZSBwcmVw
LA0KPiANCj4gYW5kIHRoYXQgc2hvdWxkIGhhdmUgYmVlbiBhIGhpbnQgdG8geW91IHRoYXQgeW91
IHNob3VsZCBub3QgZXhwZWN0IHRoYXQNCj4gDQo+ID4gc28gam9icyBpbiBkbWFlbmdpbmVfc2xh
dmVfY29uZmlnIG5lZWQgdG8gYmUgbW92ZWQgaW50byBzb21ld2hlcmUNCj4gPiBiZWZvcmUgZGV2
aWNlX3ByZXBfZG1hX21lbWNweS4gQmVzaWRlcywgZG1hdGVzdCBuZXZlciBzZXR1cCBjaGFuDQo+
ID4gLT5wcml2YXRlIGFzIG90aGVyIGNvbW1vbiBjYXNlIGxpa2UgdWFydC9hdWRpby9zcGkgd2ls
bCBhbHdheXMgc2V0dXANCj4gPiBjaGFuLT5wcml2YXRlLiBIZXJlIGNoZWNrIGl0IHRvIGp1ZGdl
IGlmIGl0J3MgZG1hdGVzdCBjYXNlIGFuZCBkbw0KPiA+IGpvYnMgaW4gc2xhdmVfY29uZmlnLg0K
PiANCj4gYW5kIHlvdSBzaG91bGQgbm90IGRvIGFueXRoaW5nIGZvciBkbWF0ZXN0LiBTdXBwb3J0
aW5nIGl0IG1lYW5zIG1lbWNweQ0KPiBpbXBsZW1lbnRhdGlvbiBpcyBub3QgY29ycmVjdCA6KQ0K
T2theSwgSSB3aWxsIGFueSB3b3JkIGFib3V0IGRtYXRlc3QgaGVyZSBzaW5jZSBtZW1jcHkgYXNz
dW1lIG5vIGNhbGxpbmcNCnNsYXZlX2NvbmZpZy4NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
ZG1hL2lteC1zZG1hLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2Rt
YS9pbXgtc2RtYS5jIGluZGV4DQo+ID4gZWQyMjY3ZC4uNDhmMzc0OSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEu
Yw0KPiA+IEBAIC0xMjIyLDEwICsxMjIyLDM2IEBAIHN0YXRpYyBpbnQgc2RtYV9hbGxvY19jaGFu
X3Jlc291cmNlcyhzdHJ1Y3QNCj4gPiBkbWFfY2hhbiAqY2hhbikgIHsNCj4gPiAgCXN0cnVjdCBz
ZG1hX2NoYW5uZWwgKnNkbWFjID0gdG9fc2RtYV9jaGFuKGNoYW4pOw0KPiA+ICAJc3RydWN0IGlt
eF9kbWFfZGF0YSAqZGF0YSA9IGNoYW4tPnByaXZhdGU7DQo+ID4gKwlzdHJ1Y3QgaW14X2RtYV9k
YXRhIGRlZmF1bHRfZGF0YTsNCj4gPiAgCWludCBwcmlvLCByZXQ7DQo+ID4NCj4gPiAtCWlmICgh
ZGF0YSkNCj4gPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCXJldCA9IGNsa19lbmFibGUoc2Rt
YWMtPnNkbWEtPmNsa19pcGcpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0K
PiA+ICsJcmV0ID0gY2xrX2VuYWJsZShzZG1hYy0+c2RtYS0+Y2xrX2FoYik7DQo+ID4gKwlpZiAo
cmV0KQ0KPiA+ICsJCWdvdG8gZGlzYWJsZV9jbGtfaXBnOw0KPiA+ICsJLyoNCj4gPiArCSAqIGRt
YXRlc3QobWVtY3B5KSB3aWxsIG5ldmVyIGNhbGwgZG1hZW5naW5lX3NsYXZlX2NvbmZpZyBiZWZv
cmUgcHJlcCwNCj4gPiArCSAqIHNvIGpvYnMgaW4gZG1hZW5naW5lX3NsYXZlX2NvbmZpZyBuZWVk
IHRvIGJlIG1vdmVkIGludG8gc29tZXdoZXJlDQo+ID4gKwkgKiBiZWZvcmUgZGV2aWNlX3ByZXBf
ZG1hX21lbWNweS4gQmVzaWRlcywgZG1hdGVzdCBuZXZlciBzZXR1cCBjaGFuDQo+ID4gKwkgKiAt
PnByaXZhdGUgYXMgb3RoZXIgY29tbW9uIGNhc2VzIGxpa2UgdWFydC9hdWRpby9zcGkgd2lsbCBz
ZXR1cA0KPiA+ICsJICogY2hhbi0+cHJpdmF0ZSBhbHdheXMuIEhlcmUgY2hlY2sgaXQgdG8ganVk
Z2UgaWYgaXQncyBkbWF0ZXN0IGNhc2UNCj4gPiArCSAqIGFuZCBkbyBqb2JzIGluIHNsYXZlX2Nv
bmZpZy4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKCFkYXRhKSB7DQo+ID4gKwkJZGV2X3dhcm4oc2Rt
YWMtPnNkbWEtPmRldiwgImRtYXRlc3QgaXMgcnVubmluZz9cbiIpOw0KPiANCj4gd2h5IGlzIHRo
YXQgYSB3YXJuaW5nIQ0KQ3VycmVudCBTRE1BIGRyaXZlciBhc3N1bWUgZmlsdGVyIGZ1bmN0aW9u
IHRvIHNldCBjaGFuLT5wcml2YXRlIHdpdGggc3BlY2lmaWMgZGF0YSANCihzdHJ1Y3QgaW14X2Rt
YV9kYXRhIGRtYV9kYXRhKWxpa2UgYmVsb3cgKHNvdW5kL3NvYy9mc2wvZnNsX2FzcmNfZG1hLmMp
Og0Kc3RhdGljIGJvb2wgZmlsdGVyKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwgdm9pZCAqcGFyYW0p
DQp7DQogICAgICAgIGlmICghaW14X2RtYV9pc19nZW5lcmFsX3B1cnBvc2UoY2hhbikpDQogICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICAgICBjaGFuLT5wcml2YXRlID0gcGFyYW07
DQogICAgICAgIHJldHVybiB0cnVlOw0KfQ0KDQpCdXQgaW4gbWVtY3B5IGNhc2UsIGF0IGxlYXNl
IGRtYXRlc3QgY2FzZSwgbm8gY2hhbi0+cHJpdmF0ZSBzZXQgaW4gaXRzIGZpbHRlciBmdW5jdGlv
bi4NClNvIGhlcmUgdGFrZSBkbWF0ZXN0IGEgc3BlY2lhbCBjYXNlIGFuZCBkbyBzb21lIHByZXBh
cmUgam9icyBmb3IgbWVtY3B5LiBCdXQgaWYgdGhlDQpVcHBlciBkZXZpY2UgZHJpdmVyIGNhbGwg
ZG1hX3JlcXVlc3RfY2hhbm5lbCgpIHdpdGggdGhlaXIgc3BlY2lmaWMgZmlsdGVyIHdpdGhvdXQN
CidjaGFuLT5wcml2YXRlJyBzZXR0aW5nIGluIHRoZSBmdXR1cmUuIFRoZSB3YXJuaW5nIG1lc3Nh
Z2UgaXMgYSB1c2VmdWwgaGludCB0byB0aGVtIHRvDQpBZGQgJ2NoYW4tPnByaXZhdGUnIGluIGZp
bHRlciBmdW5jdGlvbi4gIE9yIGRvYyBpdCBzb21ld2hlcmU/DQo+IA0KPiA+ICsJCXNkbWFjLT53
b3JkX3NpemUgID0gIHNkbWFjLT5zZG1hLT5kbWFfZGV2aWNlLmNvcHlfYWxpZ247DQo+ID4gKwkJ
ZGVmYXVsdF9kYXRhLnByaW9yaXR5ID0gMjsNCj4gPiArCQlkZWZhdWx0X2RhdGEucGVyaXBoZXJh
bF90eXBlID0gSU1YX0RNQVRZUEVfTUVNT1JZOw0KPiA+ICsJCWRlZmF1bHRfZGF0YS5kbWFfcmVx
dWVzdCA9IDA7DQo+ID4gKwkJZGVmYXVsdF9kYXRhLmRtYV9yZXF1ZXN0MiA9IDA7DQo+ID4gKwkJ
ZGF0YSA9ICZkZWZhdWx0X2RhdGE7DQo+ID4gKw0KPiA+ICsJCXNkbWFfY29uZmlnX293bmVyc2hp
cChzZG1hYywgZmFsc2UsIHRydWUsIGZhbHNlKTsNCj4gPiArCQlzZG1hX2dldF9wYyhzZG1hYywg
SU1YX0RNQVRZUEVfTUVNT1JZKTsNCj4gPiArCQlzZG1hX2xvYWRfY29udGV4dChzZG1hYyk7DQo+
ID4gKwl9DQo+IA0KPiB0aGlzIG5lZWRzIHRvIGJlIGRlZmF1bHQgZm9yIG1lbWNweQ0KPiANCj4g
LS0NCj4gflZpbm9kDQo=
