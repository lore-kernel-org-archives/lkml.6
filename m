Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364CBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE628219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mdtbLw8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE628219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeHFKMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:12:42 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:61360
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbeHFKMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D63getWSRJfev3e3YHbc8tyW+wbIpbb3ACo/b7kM/ss=;
 b=mdtbLw8fKfRY4Qx2rzg0YMYyOlp76Dr+VkIXA42uYlrBy/Eu74c+x56BYqpCLpOXmf/QVN/9Ch7/xl3wAarXAFQ4PcV6YenzRUJ8n9i3XFeSto166D3QejLlNxksBGEr8JhrVOdbTPDh+27/ZrK5uhtInxIvWZC0Ut0wsN+GOsM=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3288.eurprd04.prod.outlook.com (10.170.216.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 08:04:46 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::5a5:2607:a2c7:681c]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::5a5:2607:a2c7:681c%2]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 08:04:46 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
Thread-Topic: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
Thread-Index: AQHUImnwBRfF8kmj8ke3SHRmSu0CG6ScoiYAgAARf8CAAWcnAIABBEDggBNTbpA=
Date:   Mon, 6 Aug 2018 08:04:46 +0000
Message-ID: <DB6PR04MB3223BB3159EB8D376BE64B3E89200@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
         <1532367972-29707-4-git-send-email-yibin.gong@nxp.com>
         <1532343252.3163.99.camel@pengutronix.de>
         <DB6PR04MB322323354B2184421502FC5889560@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532424136.32306.3.camel@pengutronix.de>
 <DB6PR04MB32233768DB36BB208206EBCE89540@DB6PR04MB3223.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB32233768DB36BB208206EBCE89540@DB6PR04MB3223.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3288;6:4b+hCT2mK6MRHKulDha6oIPZ+VPGd2r3ar8hyGpD8DbCAcPuwzRqlHghyQrt80wLILyTNvOlXiaX6aVJmcWCr321osZ8nKCKxLBXO2Vy5VvaNmrOlUZoFmA3d4MoQJQT4AYd43aPw+qDHy/e8SckPbrv/JauEuGjNiyyDz6AH/ne6bWBSSKCLJV6LtXXtAEj029fs8x2sC5qbrieikmTYAmIN8kIg58bREh+fUA2NKOyWafM+Bv1ZxwxO3I7a7QJSUWbi1P6rV72xgFckEgVtBb2xdxY4w8Y5yvJfczGLz3EbiJ6AxAp6jf/dGctML8ECq/alNAPEPoFAfvSkYRcDa7/mIkaJfLCLru9YkTY8q3lXX5WImQwh3M1BOZuotIA0DCunSilDFlvSXxKuBsGirddA4hiqaTefSz/kvhql+erfqmXY//jjfYgWyIDqilFhGJw9IgfDggLrimKhN+vvA==;5:pUq7OJQ5NFQLKf6Y37yavg1yVEfxyW8WQshNu+tAZjDZN98nwrEYYWB0hGe4yAmpGzneV9GN54qDD93K2E9i8eeCj6a5pv7B13TRyra00VWQ2mGqblbpHSMqtmJzi6TfhEq8auwJ4vZPZT4ay1dS7GTYSkFbXlKy/xcM4+lYHcs=;7:riBk4QdDIVeMcgoCgKjwQbtsRYlsxGQyybm/tyiPSC3xWfrxtvjPnjS42zLyQW5Te5q0J09jXd0Y0W0uoSiB+Sf4zh/0TmIp9EGYY5PWfJVzu7z2AF2IE7uu77A/M1ptiaixCTdLllo59/crHh7rDmVFfAZ3mcfN19ChvAtIWx5uv+zcGRdfXZQz6qq58CUYa3xLDgB8LFiwX4C2ttnFLaXHoLrIkKO36Asvlbn1bbqM1RRDQTac+9spta0eI1gO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a9ccaf37-75ff-418a-a7bc-08d5fb734667
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3288;
x-ms-traffictypediagnostic: DB6PR04MB3288:
x-microsoft-antispam-prvs: <DB6PR04MB3288A8DF31F1FED0FAFD7F7C89200@DB6PR04MB3288.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3288;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3288;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(13464003)(6246003)(476003)(8676002)(93886005)(81166006)(4326008)(14454004)(7696005)(76176011)(81156014)(26005)(2906002)(5250100002)(66066001)(74316002)(6436002)(54906003)(53936002)(446003)(9686003)(55016002)(11346002)(305945005)(186003)(25786009)(5660300001)(110136005)(256004)(99286004)(316002)(486006)(7736002)(53546011)(6506007)(478600001)(102836004)(33656002)(2201001)(86362001)(2900100001)(8936002)(106356001)(68736007)(97736004)(105586002)(6116002)(2501003)(229853002)(3846002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3288;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BUg9CCh/JI1jIRkx4L+4c71v2QVt7TVmPUVGRIEoGZ2yD2rruJWS3tCJmagURFoMmh1ejIdGMeWy4aHPCzdKj5fpfotgWlgf6y8F9xQywzYcs9Lqe0o2FNHKdhTzdInlJwCybmrMYeKnPX6hpYqFpIJFOb1MPlbfGisEHkPI+es9hnlbdMdaAjyKdnZO64br4J7DhkcVGZnrKQbdF8Vrfjq4tfY7qNa+ksTnjfLP58uzP2nCMTC+/uQDNwta/U7ioHhayitAtMRCK6V4mDx67Dd93mIqAMvnMFWn8FnDNKucIzkOnryjkA3foHhk6nKEL482d6wsi1Tyw5H0rbOzc3kFwv0vzj/Z34VIFEe2hYA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ccaf37-75ff-418a-a7bc-08d5fb734667
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 08:04:46.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTHVjYXMsDQoJQW55IGNvbW1lbnQgZm9yIG15IHJlcGx5Pw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYmluIEdvbmcNCj4gU2VudDogMjAxOOW5tDfmnIgy
NeaXpSA5OjI1DQo+IFRvOiAnTHVjYXMgU3RhY2gnIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPjsg
dmtvdWxAa2VybmVsLm9yZzsNCj4gZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBsaW51eEBhcm1saW51eC5vcmcudWsNCj4gQ2M6IGRtYWVuZ2luZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYzIDMv
M10gZG1hZW5naW5lOiBpbXgtc2RtYTogYWxsb2NhdGUgbWF4IDIwIGJkcyBmb3Igb25lDQo+IHRy
YW5zZmVyDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTHVj
YXMgU3RhY2ggW21haWx0bzpsLnN0YWNoQHBlbmd1dHJvbml4LmRlXQ0KPiA+IFNlbnQ6IDIwMTjl
ubQ35pyIMjTml6UgMTc6MjINCj4gPiBUbzogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29t
PjsgdmtvdWxAa2VybmVsLm9yZzsNCj4gPiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4gbGludXhAYXJtbGludXgub3JnLnVrDQo+ID4gQ2M6IGRt
YWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
Ow0KPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDMvM10gZG1hZW5naW5lOiBpbXgtc2RtYTogYWxsb2NhdGUgbWF4IDIw
IGJkcw0KPiA+IGZvciBvbmUgdHJhbnNmZXINCj4gPg0KPiA+IEFtIE1vbnRhZywgZGVuIDIzLjA3
LjIwMTgsIDEzOjU1ICswMDAwIHNjaHJpZWIgUm9iaW4gR29uZzoNCj4gPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogTHVjYXMgU3RhY2ggW21haWx0bzpsLnN0
YWNoQHBlbmd1dHJvbml4LmRlXQ0KPiA+ID4gPiBTZW50OiAyMDE45bm0N+aciDIz5pelIDE4OjU0
DQo+ID4gPiA+IFRvOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyB2a291bEBrZXJu
ZWwub3JnOw0KPiA+ID4gPiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7DQo+ID4gPiA+IGxpbnV4QGFybWxpbnV4Lm9yIGcudWsNCj4gPiA+ID4gQ2M6IGRt
YWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
Ow0KPiA+ID4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvM10gZG1hZW5naW5lOiBpbXgtc2RtYTogYWxs
b2NhdGUgbWF4IDIwDQo+ID4gPiA+IGJkcyBmb3Igb25lIHRyYW5zZmVyDQo+ID4gPiA+DQo+ID4g
PiA+IEFtIERpZW5zdGFnLCBkZW4gMjQuMDcuMjAxOCwgMDE6NDYgKzA4MDAgc2NocmllYiBSb2Jp
biBHb25nOg0KPiA+ID4gPiA+IElmIG11bHRpLWJkcyB1c2VkIGluIG9uZSB0cmFuc2ZlciwgYWxs
IGJkcyBzaG91bGQgYmUgY29uc2lzdGVuDQo+ID4gPiA+ID4gbWVtb3J5LlRvIGVhc2lseSBmb2xs
b3cgaXQsIGVubGFyZ2UgdGhlIGRtYSBwb29sIHNpemUgaW50byAyMA0KPiA+ID4gPiA+IGJkcywg
YW5kIGl0IHdpbGwgcmVwb3J0IGVycm9yIGlmIHRoZSBudW1iZXIgb2YgYmRzIGlzIG92ZXIgdGhh
bg0KPiA+ID4gPiA+IDIwLiBGb3IgZG1hdGVzdCwgdGhlIG1heCBjb3VudCBmb3Igc2luZ2xlIHRy
YW5zZmVyIGlzIE5VTV9CRCAqDQo+ID4gPiA+DQo+ID4gPiA+IFNETUFfQkRfTUFYX0NOVA0KPiA+
ID4gPiA+ID0gMjAgKiA2NTUzNSA9IH4xLjI4TUIuDQo+ID4gPiA+DQo+ID4gPiA+IEJvdGggdGhl
IGNvbW1pdCBtZXNzYWdlIGFuZCB0aGUgY29tbWVudCBuZWVkIGEgbG90IG1vcmUgY2FyZSB0bw0K
PiA+ID4gPiBhY3R1YWxseSB0ZWxsIHdoYXQgdGhpcyBjb21taXQgaXMgdHJ5aW5nIHRvIGFjaGll
dmUuIEN1cnJlbnRseSBJDQo+ID4gPiA+IGRvbid0IGZvbGxvdyBhdCBhbGwuIFdoYXQgZG9lcyAi
Y29uc2lzdGVuIiBtZWFuPyBEbyB5b3UgbWVhbiBCRHMNCj4gPiA+ID4gc2hvdWxkIGJlIGNvbnRp
Z3VvdXMgaW4gbWVtb3J5Pw0KPiA+ID4NCj4gPiA+IFllcywgQkRzIHNob3VsZCBiZSBjb250aWd1
b3VzwqDCoG9uZSBieSBvbmUgaW4gbWVtb3J5Lg0KPiA+DQo+ID4gT2theSwgYnV0IHRoaXMgaXNu
J3Qgd2hhdCB0aGUgY29kZSBjaGFuZ2UgZG9lcy4gQnkgaW5jcmVhc2luZyB0aGUgc2l6ZQ0KPiA+
IHBhcmFtZXRlciBvZiB0aGUgZG1hIHBvb2wgeW91IGp1c3QgYWxsb2NhdGUgMjAgdGltZXMgYXMg
bXVjaCBtZW1vcnkgYXMNCj4gPiBuZWVkZWQgZm9yIGVhY2ggQkQuIFNvIGFjdHVhbGx5IHRoZSBC
RHMgZW5kIHVwIGJlaW5nIHZlcnkgbm9uLQ0KPiA+IGNvbnRpZ3VvdXMgaW4gbWVtb3J5IGFzIHRo
ZXJlIGFyZSBub3cgaG9sZXMgb2YgMTkgQkQgc2l6ZXMgYmV0d2VlbiB0aGUNCj4gc3RhcnQgb2Yg
ZWFjaCBCRC4NCj4gUGxlYXNlIG5vdGljZSBvbmx5IGFsbG9jYXRlIGJkcyBtZW1vcnkgZnJvbSBk
bWEgcG9vbCBvbmUgdGltZSBldmVuIGluIG11bHRpDQo+IGJkcy4NCj4gVGhhdCdzIGRpZmZlcmVu
dCB3aXRoIHRoZSBjb21tb24gdXNlIGNhc2UgdGhhdCBhbGxvY2F0ZSBtZW1vcnkgZnJvbSBkbWEN
Cj4gcG9vbCBldmVyeXRpbWUgZm9yIGV2ZXJ5IGJkLiBXaHkgZG8gdGhpcyBpcyB0byBtYWtlIHN1
cmUgYWxsIGJkIG1lbW9yeSBpcw0KPiBjb250aWd1b3VzIGZvciBzaW5nbGUgdHJhbnNmZXIgd2hh
dGV2ZXIgc2luZ2xlIGJkIG9yIG11bHRpLWJkcywgc2luY2UgdHdvIGNhbGwNCj4gZG1hX3Bvb2xf
YWxsb2MoKSBjYW4ndCBwcm9taXNlIHRoZSBhZGRyZXNzIGlzIGNvbnRpZ3VvdXMgZXNwZWNpYWxs
eSBmb3IgbXVsdGkNCj4gdGhyZWFkIGNhc2Ugc3VjaCBhcyBkbWF0ZXN0ICd0aHJlYWRzX3Blcl9j
aGFuID0gNScuIFlvdSBjYW4gY2hhbmdlIHRvICcNCj4gbm9yYW5kb209dHJ1ZSAnIGFuZCAnIHRl
c3RfYnVmX3NpemUgPSAxNjM4NDAnIGluIGRtYXRlc3QuYyB0byBsb29rIHdoYXQgaXNzdWUNCj4g
Y29taW5nIHdpdGhvdXQgdGhpcyBwYXRjaC4NCj4gPg0KPiA+IFNvIHNvbWV0aGluZyBpc24ndCBy
aWdodCB3aXRoIHRoaXMgY2hhbmdlLg0KPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgdGhlIGVhc3kg
d2F5IHRvIHJlc29sdmUgdGhlIGJkIGNvbnRpZ3VvdXMgaXNzdWUsIGJ1dCB0aGUNCj4gY29zdCBp
cyB0byBhbGxvY2F0ZSBtb3JlIGRtYSBwb29sIG1lbW9yeSB3aGljaCBtYXkgbm90IHVzZWQuDQo+
ID4NCj4gPiBSZWdhcmRzLA0KPiA+IEx1Y2FzDQo+ID4NCj4gPiA+ID4NCj4gPiA+ID4gV2hhdCBk
byB5b3UgZ2FpbiBieSBvdmVyLWFsbG9jYXRpbmcgZWFjaCBCRCBieSBhIGZhY3RvciBvZiAyMD8N
Cj4gPiA+DQo+ID4gPiBJIGd1ZXNzIGRtYV9wb29sX2FsbG9jIHdpbGwgcmV0dXJuIGVycm9yIGlu
IHN1Y2ggY2FzZSwgYW5kIHRoZW4NCj4gPiA+IGNhdXNlIGRtYSBzZXR1cCB0cmFuc2ZlciBmYWls
dXJlLg0KPiA+ID4gPg0KPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiBMdWNhcw0KPiA+ID4gPg0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4N
Cj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiDCoGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgfCAxNyAr
KysrKysrKysrKysrKysrLQ0KPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiA+ID4gPiA+
IGluZGV4DQo+ID4gPiA+ID4gYjRlYzJkMi4uNTk3MzQ4OSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9kbWEvaW14
LXNkbWEuYw0KPiA+ID4gPiA+IEBAIC0yOTgsNiArMjk4LDE1IEBAIHN0cnVjdCBzZG1hX2NvbnRl
eHRfZGF0YSB7DQo+ID4gPiA+ID4gPiDCoAl1MzLCoMKgc2NyYXRjaDc7DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiDCoH0gX19hdHRyaWJ1dGVfXyAoKHBhY2tlZCkpOw0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gKy8qDQo+ID4gPiA+ID4gKyAqIEFsbCBiZHMgaW4gb25lIHRyYW5zZmVyIHNob3VsZCBiZSBj
b25zaXRlbnQgb24gU0RNQS4gVG8NCj4gPiA+ID4gPiBlYXNpbHkNCj4gPiA+ID4gPiArZm9sbG93
IGl0LGp1c3QNCj4gPiA+ID4gPiArICogc2V0IHRoZSBkbWEgcG9vbCBzaXplIGFzIHRoZSBlbm91
Z2ggYmRzLiBGb3IgZXhhbXBsZSwgaW4NCj4gPiA+ID4gPiBkbWF0ZXN0DQo+ID4gPiA+ID4gK2Nh
c2UsIHRoZQ0KPiA+ID4gPiA+ICsgKiBtYXggMjAgYmRzIG1lYW5zIHRoZSBtYXggZm9yIHNpbmds
ZSB0cmFuc2ZlciBpcyBOVU1fQkQgKg0KPiA+ID4gPiA+ICtTRE1BX0JEX01BWF9DTlQgPSAyMA0K
PiA+ID4gPiA+ICsgKiAqIDY1NTM1ID0gfjEuMjhNQi4gMjAgYmRzIHN1cHBvc2VkIHRvIGJlIGVu
b3VnaCBiYXNpY2FsbHkuSWYNCj4gPiA+ID4gPiBpdCdzDQo+ID4gPiA+ID4gK3N0aWxsIG5vdA0K
PiA+ID4gPiA+ICsgKiBlbm91Z2ggaW4gc29tZSBzcGVjaWZpYyBjYXNlcywgZW5sYXJnZSBpdCBo
ZXJlLldhcm5pbmcNCj4gPiA+ID4gPiBtZXNzYWdlDQo+ID4gPiA+ID4gK3dvdWxkIGFsc28NCj4g
PiA+ID4gPiArICogYXBwZWFyIGlmIHRoZSBiZCBudW1iZXJzIGlzIG92ZXIgdGhhbiAyMC4NCj4g
PiA+ID4gPiArICovDQo+ID4gPiA+ID4gKyNkZWZpbmUgTlVNX0JEIDIwDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiDCoHN0cnVjdCBzZG1hX2VuZ2luZTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEBAIC0x
MjczLDcgKzEyODIsNyBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ID4gc2RtYV9hbGxvY19jaGFuX3Jl
c291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pDQo+ID4gPiA+ID4gPiDCoAkJZ290byBkaXNh
YmxlX2Nsa19haGI7DQo+ID4gPiA+ID4gPiDCoAlzZG1hYy0+YmRfcG9vbCA9IGRtYV9wb29sX2Ny
ZWF0ZSgiYmRfcG9vbCIsIGNoYW4tDQo+ID4gPiA+ID4gPiA+ZGV2aWNlLT5kZXYsDQo+ID4gPiA+
ID4gPiAtCQkJCXNpemVvZihzdHJ1Y3QNCj4gPiA+ID4gPiA+IHNkbWFfYnVmZmVyX2Rlc2NyaXB0
b3IpLA0KPiA+ID4gPiA+ID4gKwkJCQlOVU1fQkQgKiBzaXplb2Yoc3RydWN0DQo+ID4gPiA+ID4g
PiBzZG1hX2J1ZmZlcl9kZXNjcmlwdG9yKSwNCj4gPiA+ID4gPiA+IMKgCQkJCTMyLCAwKTsNCj4g
PiA+ID4gPiA+IMKgCXJldHVybiAwOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQEAgLTEzMTQsNiAr
MTMyMywxMiBAQCBzdGF0aWMgc3RydWN0IHNkbWFfZGVzYw0KPiA+ID4gPiA+ICpzZG1hX3RyYW5z
ZmVyX2luaXQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMsDQo+ID4gPiA+ID4gwqB7DQo+ID4g
PiA+ID4gPiDCoAlzdHJ1Y3Qgc2RtYV9kZXNjICpkZXNjOw0KPiA+ID4gPiA+ID4gKwlpZiAoYmRz
ID4gTlVNX0JEKSB7DQo+ID4gPiA+ID4gPiArCQlkZXZfZXJyKHNkbWFjLT5zZG1hLT5kZXYsICIl
ZCBiZHMgZXhjZWVkIHRoZQ0KPiA+ID4gPiA+ID4gbWF4ICVkXG4iLA0KPiA+ID4gPiA+ID4gKwkJ
CWJkcywgTlVNX0JEKTsNCj4gPiA+ID4gPiA+ICsJCWdvdG8gZXJyX291dDsNCj4gPiA+ID4gPiA+
ICsJfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gwqAJZGVzYyA9IGt6YWxs
b2MoKHNpemVvZigqZGVzYykpLCBHRlBfTk9XQUlUKTsNCj4gPiA+ID4gPiA+IMKgCWlmICghZGVz
YykNCj4gPiA+ID4gPiA+IMKgCQlnb3RvIGVycl9vdXQ7DQo=
