Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3BCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B20320871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LxZEqZhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B20320871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbeGKQqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:46:22 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:43724
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387947AbeGKQqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKoE8s0QQsAN9Q2pM0qKLGm9k1Jc37GdXEttxbPdN10=;
 b=LxZEqZhctokd0uglkeYhUtEEswcJ7t8zi5CLr9a6+fN565DyeDU9CUWb7aVMhJ1bKdmA97IiI78IL47t5qFFcZooMMyMvfbOsIt3ZjeMug8n4GYHP7w98a9KNJsfe17QIDV+KlavinA3aHQH88iKl4HqzBhfJ589XVFF9NPR46s=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4497.eurprd04.prod.outlook.com (52.135.148.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 16:41:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 16:41:08 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Topic: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Index: AQHUFsxVRb7g/AGotk2h6FoTYgzkeKSIhHsAgAEHGTCAAB+9AIAAGVgwgAAV8QCAAB88IIAAQe4AgAABAxA=
Date:   Wed, 11 Jul 2018 16:41:08 +0000
Message-ID: <AM0PR04MB4211F30775A0C806F44626C8805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
 <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
 <AM0PR04MB4211AD523CFB8DA99AB05EFC805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0SqUFfS0ts9QHnKbqH0YW5-dLw7PxcjVa3eK_c3zrNpA@mail.gmail.com>
In-Reply-To: <CABb+yY0SqUFfS0ts9QHnKbqH0YW5-dLw7PxcjVa3eK_c3zrNpA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4497;7:21JCs62pP17cZS1dgRgXTnxlDzNAW59wsjXMPSPdx5bTs3lojpOqxKOiTwS+fbm7xvkF6uZP1Z0OdOXYaDZSLYy67b3Zlm6BDNGChGcoZmqXjDlpvighn+XiLsxX3uedaEm2IImDCd+bT7eP8xrirVOtkJh2TdCGnBv84QXxUyb9HtM1omJE5G1OTZqdDQOp4QW6xpAgZICuqTPxfz7NJ3OdyWqqrzBLEiNPJvFBou+c/jr4LuMap4/e/9XKVN03
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 32c3b939-08c1-43ea-bd7f-08d5e74d1a4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4497;
x-ms-traffictypediagnostic: AM0PR04MB4497:
x-microsoft-antispam-prvs: <AM0PR04MB4497726F9F9C0C7CB17A160F805A0@AM0PR04MB4497.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4497;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4497;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(13464003)(189003)(199004)(51914003)(39060400002)(6246003)(316002)(6916009)(4326008)(486006)(3846002)(11346002)(6116002)(476003)(66066001)(26005)(15650500001)(54906003)(99286004)(86362001)(53936002)(256004)(76176011)(446003)(14454004)(93886005)(2900100001)(6506007)(53546011)(25786009)(102836004)(5660300001)(186003)(7696005)(5250100002)(74316002)(305945005)(478600001)(7736002)(106356001)(105586002)(97736004)(1411001)(68736007)(33656002)(9686003)(55016002)(2906002)(229853002)(8676002)(8936002)(81156014)(81166006)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4497;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kBDtlCN0W4N+u7H/qvbhh86Up8vyDiWm9Jz2GStePiwZngiUnM77iLnBZD9oyYXps6UrjFiE4K4tOEnoWtRlxs4/YnjoFjHk3zIIDw/uc4lLqCNV79I6Rbny4ROmtS103k0DSQbJ0DWIPHtUU65Aj2PB4xYolsaaJ7SIeY58Ntv+fBm3UCYaHiROa7qjqGI3Jc0UvNaYWjhxq1V/sEvckU2F1gPhsoP9VzFaITzjeHlsUHOEaGgcTBHJUlFfcK6esqLIIOMGmUaZkt26XheWb7cm5Kdpu6U/N2fwiX86oebHhAIIBsBmkt6AXHH0N2+B0Y+O6XgvdUR+TnOW7geXNCOiSumO3v+B4qyHJCtLch8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c3b939-08c1-43ea-bd7f-08d5e74d1a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 16:41:08.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4497
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzc2kg
QnJhciBbbWFpbHRvOmphc3Npc2luZ2hicmFyQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXks
IEp1bHkgMTIsIDIwMTggMTI6MzIgQU0NCj4gVG86IEEucy4gRG9uZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+DQo+IENjOiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBsaW51
eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkb25nYXM4NkBnbWFpbC5jb207
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBPbGVrc2lqIFJlbXBlbCA8by5yZW1w
ZWxAcGVuZ3V0cm9uaXguZGU+OyBkbC0NCj4gbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmFiaW8uZXN0ZXZhbUBu
eHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDMv
NV0gbWFpbGJveDogaW14OiBhZGQgaW14IG11IHN1cHBvcnQNCj4gDQo+IE9uIFdlZCwgSnVsIDEx
LCAyMDE4IGF0IDY6MjggUE0sIEEucy4gRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+IHdyb3Rl
Og0KPiA+IEhpIEphc3NpLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IEphc3NpIEJyYXIgW21haWx0bzpqYXNzaXNpbmdoYnJhckBnbWFpbC5jb21dDQo+
ID4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMSwgMjAxOCA2OjQ0IFBNDQo+ID4+IFRvOiBBLnMu
IERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+PiBDYzogU2FzY2hhIEhhdWVyIDxzLmhh
dWVyQHBlbmd1dHJvbml4LmRlPjsgbGludXgtYXJtLQ0KPiA+PiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZG9uZ2FzODZAZ21haWwuY29tOyBsaW51eC0NCj4gPj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPjsgZGwtDQo+
ID4+IGxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
IEZhYmlvIEVzdGV2YW0NCj4gPj4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IHNoYXduZ3VvQGtl
cm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAzLzVdIG1haWxib3g6IGlteDog
YWRkIGlteCBtdSBzdXBwb3J0DQo+ID4+DQo+ID4+IE9uIFdlZCwgSnVsIDExLCAyMDE4IGF0IDQ6
MDcgUE0sIEEucy4gRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+PiA+
DQo+ID4+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiA+ID4gRnJvbTogU2Fz
Y2hhIEhhdWVyIFttYWlsdG86cy5oYXVlckBwZW5ndXRyb25peC5kZV0NCj4gPj4gPiA+IFNlbnQ6
IFdlZG5lc2RheSwgSnVseSAxMSwgMjAxOCAzOjU1IFBNDQo+ID4+ID4gPiBUbzogQS5zLiBEb25n
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPj4gPiA+IENjOiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRvbmdhczg2QGdtYWlsLmNvbTsNCj4gPj4gPiA+IEphc3NpIEJy
YXIgPGphc3Npc2luZ2hicmFyQGdtYWlsLmNvbT47DQo+ID4+ID4gPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBPbGVrc2lqIFJlbXBlbA0KPiA+PiA+ID4gPG8ucmVtcGVsQHBlbmd1dHJv
bml4LmRlPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+ID4+ID4gPiBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47
DQo+ID4+ID4gPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+ID4+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIFY0IDMvNV0gbWFpbGJveDogaW14OiBhZGQgaW14IG11IHN1cHBvcnQNCj4gPj4gPiA+DQo+
ID4+ID4gPiBPbiBXZWQsIEp1bCAxMSwgMjAxOCBhdCAwNzoyOTozOEFNICswMDAwLCBBLnMuIERv
bmcgd3JvdGU6DQo+ID4+ID4gPiA+IEhpIFNhc2NoYSwNCj4gPj4gPiA+ID4NCj4gPj4gPiA+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiA+ID4gPiA+IEZyb206IFNhc2NoYSBI
YXVlciBbbWFpbHRvOnMuaGF1ZXJAcGVuZ3V0cm9uaXguZGVdDQo+ID4+ID4gPiA+ID4gU2VudDog
VHVlc2RheSwgSnVseSAxMCwgMjAxOCAxMDoyMCBQTQ0KPiA+PiA+ID4gPiA+IFRvOiBBLnMuIERv
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+PiA+ID4gPiA+IENjOiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRvbmdhczg2QGdtYWlsLmNvbTsNCj4gPj4gPiA+ID4g
PiBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJhckBnbWFpbC5jb20+Ow0KPiA+PiA+ID4gPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE9sZWtzaWogUmVtcGVsDQo+ID4+ID4gPiA+ID4g
PG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNv
bT47DQo+ID4+ID4gPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtDQo+
IDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiA+PiA+ID4gPiA+IHNoYXduZ3VvQGtlcm5lbC5v
cmcNCj4gPj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDMvNV0gbWFpbGJveDogaW14
OiBhZGQgaW14IG11IHN1cHBvcnQNCj4gPj4gPiA+ID4gPg0KPiA+PiA+ID4gPiA+IEhpLA0KPiA+
PiA+ID4gPiA+DQo+ID4+ID4gPiA+ID4gT24gU3VuLCBKdWwgMDgsIDIwMTggYXQgMTA6NTY6NTVQ
TSArMDgwMCwgRG9uZyBBaXNoZW5nIHdyb3RlOg0KPiA+PiA+ID4gPiA+ID4gVGhpcyBpcyB1c2Vk
IGZvciBpLk1YIG11bHRpIGNvcmUgY29tbXVuaWNhdGlvbi4NCj4gPj4gPiA+ID4gPiA+IGUuZy4g
QSBjb3JlIHRvIFNDVSBmaXJtd2FyZShNIGNvcmUpIG9uIE1YOC4NCj4gPj4gPiA+ID4gPiA+DQo+
ID4+ID4gPiA+ID4gPiBUeCBpcyB1c2luZyBwb2xsaW5nIG1vZGUgd2hpbGUgUnggaXMgaW50ZXJy
dXB0IGRyaXZlbiBhbmQNCj4gPj4gPiA+ID4gPiA+IHNjaGVkdWxlIGEgaHJ0aW1lciB0byByZWNl
aXZlIHJlbWFpbiB3b3JkcyBpZiBoYXZlIG1vcmUNCj4gPj4gPiA+ID4gPiA+IHRoYW4NCj4gPj4g
PiA+ID4gPiA+IDQgd29yZHMuDQo+ID4+ID4gPiA+ID4NCj4gPj4gPiA+ID4gPiBZb3UgdG9sZCB1
cyB0aGF0IHVzaW5nIGludGVycnVwdHMgaXMgbm90IHBvc3NpYmxlIGR1ZSB0bw0KPiA+PiA+ID4g
PiA+IG1pc2VyYWJsZSBwZXJmb3JtYW5jZSwgd2UgdGhlbiBwcm92aWRlZCB5b3UgYSB3YXkgd2l0
aCB3aGljaA0KPiA+PiA+ID4gPiA+IHlvdQ0KPiA+PiBjb3VsZCBwb2xsLg0KPiA+PiA+ID4gPiA+
IFdoeSBhcmUgeW91IHVzaW5nIGludGVycnVwdHMgbm93Pw0KPiA+PiA+ID4gPiA+DQo+ID4+ID4g
PiA+DQo+ID4+ID4gPiA+IEJlY2F1c2UgbWFpbGJveCBmcmFtZXdvcmsgZG9lcyBub3Qgc3VwcG9y
dCBzeW5jIHJ4IG5vdywgSSB0aGluaw0KPiA+PiA+ID4gPiB3ZSBkbyBub3QgbmVlZCB0byB3YWl0
IGZvciB0aGF0IGZlYXR1cmUgZG9uZSBmaXJzdCBhcyBpdCdzDQo+ID4+ID4gPiA+IGluZGVwZW5k
ZW50IGFuZCBzZXBhcmF0ZSBmZWF0dXJlcyBvZiBmcmFtZXdvcmsuDQo+ID4+ID4gPg0KPiA+PiA+
ID4gWW91IGNhbiB3YWl0IGZvcmV2ZXIgZm9yIHRoaXMgZmVhdHVyZSwgbm9ib2R5IHdpbGwgYWRk
IGl0IGZvciB5b3UuDQo+ID4+ID4gPiBJdCdzIHVwIHRvIHlvdSB0byBhZGQgc3VwcG9ydCBmb3Ig
dGhhdCBmZWF0dXJlLiBXaG8gZWxzZSBzaG91bGQNCj4gPj4gPiA+IGFkZCB0aGlzDQo+ID4+IGZl
YXR1cmUgaWYgbm90IHlvdT8NCj4gPj4gPiA+IEFuZCB3aGVuIHdpbGwgeW91IGFkZCB0aGF0IGZl
YXR1cmUgaWYgbm90IG5vdyB3aGVuIHlvdSBhY3R1YWxseSBuZWVkDQo+IGl0Pw0KPiA+PiA+ID4g
SXQgaXMgY29tbW9uIHByYWN0aWNlIHRoYXQgeW91IGFkanVzdCB0aGUgZnJhbWV3b3JrcyB0byB5
b3VyDQo+ID4+ID4gPiBuZWVkcyByYXRoZXIgdGhhbiB3b3JraW5nIGFyb3VuZCB0aGVtLg0KPiA+
PiA+ID4NCj4gPj4gPg0KPiA+PiA+IEknbSB3aWxsaW5nIHRvIGFkZCBpdC4gSnVzdCBiZWNhdXNl
IHlvdSBzYWlkIEphc3NpIGFscmVhZHkgaGFkIHRoZQ0KPiA+PiA+IGlkZWEgb24gaG93IHRvIElt
cGxlbWVudCBpdCBhbmQgZG9lcyBub3QgYWRkIG11Y2ggY29tcGxleGl0eS4gU28gSQ0KPiA+PiA+
IGp1c3QNCj4gPj4gd2FudCB0byBzZWUgaGlzIHBhdGNoZXMuDQo+ID4+ID4gQnV0IGlmIGhlIGRp
ZCBub3Qgd29yayBvbiBpdCwgSSBjYW4gYWxzbyBoZWxwIG9uIGl0Lg0KPiA+PiA+DQo+ID4+IEkg
YW0gbm90IG11Y2ggYXdhcmUgb2YgdGhlIGhpc3Rvcnkgb2YgdGhpcyBjb252ZXJzYXRpb24uLi4g
YnV0IGl0DQo+ID4+IHNlZW1zIHlvdSBuZWVkIHRvIG1ha2UgdXNlIG9mIG1ib3hfY2hhbl9vcHMu
cGVla19kYXRhKCkuDQo+ID4+DQo+ID4+IElmIG5vdCB0aGF0LCBwbGVhc2UgbGV0IG1lIGtub3cg
dGhlIHJlcXVpcmVtZW50Lg0KPiA+Pg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
bi4NCj4gPiBJdCBsb29rcyB0byBtZSBtYXkgd29yay4NCj4gPg0KPiA+IEZyb20gdGhlIGRlZmlu
aXRpb24sIGl0IHNlZW1zIGl0J3MgdXNlZCB0byBwdWxsIGRhdGEgZnJvbSByZW1vdGUgc2lkZS4N
Cj4gPiAvKioNCj4gPiAgKiBtYm94X2NsaWVudF9wZWVrX2RhdGEgLSBBIHdheSBmb3IgY2xpZW50
IGRyaXZlciB0byBwdWxsIGRhdGENCj4gPiAgKiAgICAgICAgICAgICAgICAgICAgICByZWNlaXZl
ZCBmcm9tIHJlbW90ZSBieSB0aGUgY29udHJvbGxlci4NCj4gPiAgKiBAY2hhbjogTWFpbGJveCBj
aGFubmVsIGFzc2lnbmVkIHRvIHRoaXMgY2xpZW50Lg0KPiA+ICAqDQo+ID4gICogQSBwb2tlIHRv
IGNvbnRyb2xsZXIgZHJpdmVyIGZvciBhbnkgcmVjZWl2ZWQgZGF0YS4NCj4gPiAgKiBUaGUgZGF0
YSBpcyBhY3R1YWxseSBwYXNzZWQgb250byBjbGllbnQgdmlhIHRoZQ0KPiA+ICAqIG1ib3hfY2hh
bl9yZWNlaXZlZF9kYXRhKCkNCj4gPiAgKiBUaGUgY2FsbCBjYW4gYmUgbWFkZSBmcm9tIGF0b21p
YyBjb250ZXh0LCBzbyB0aGUgY29udHJvbGxlcidzDQo+ID4gICogaW1wbGVtZW50YXRpb24gb2Yg
cGVla19kYXRhKCkgbXVzdCBub3Qgc2xlZXAuDQo+ID4gICoNCj4gPiAgKiBSZXR1cm46IFRydWUs
IGlmIGNvbnRyb2xsZXIgaGFzLCBhbmQgaXMgZ29pbmcgdG8gcHVzaCBhZnRlciB0aGlzLA0KPiA+
ICAqICAgICAgICAgIHNvbWUgZGF0YS4NCj4gPiAgKiAgICAgICAgIEZhbHNlLCBpZiBjb250cm9s
bGVyIGRvZXNuJ3QgaGF2ZSBhbnkgZGF0YSB0byBiZSByZWFkLg0KPiA+ICAqLw0KPiA+IGJvb2wg
bWJveF9jbGllbnRfcGVla19kYXRhKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pIHsNCj4gPiAgICAg
ICAgIGlmIChjaGFuLT5tYm94LT5vcHMtPnBlZWtfZGF0YSkNCj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIGNoYW4tPm1ib3gtPm9wcy0+cGVla19kYXRhKGNoYW4pOw0KPiA+DQo+ID4gICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+ID4gfQ0KPiA+IEVYUE9SVF9TWU1CT0xfR1BMKG1ib3hfY2xpZW50
X3BlZWtfZGF0YSk7DQo+ID4gQnV0IGl0IHNlZW1zIG1vc3QgdXNlcnMgaW4ga2VybmVsIHNpbXBs
eSBpbXBsZW1lbnQgaXQgYXMgYSBkYXRhDQo+ID4gYXZhaWxhYmxlIENoZWNraW5nIHJhdGhlciB0
aGFuIHJlY2VpdmluZyBpdC4NCj4gPiBTZWU6DQo+ID4gZHJpdmVycy9tYWlsYm94L3RpLW1zZ21n
ci5jDQo+ID4gZHJpdmVycy9tYWlsYm94L21haWxib3gtYWx0ZXJhLmMNCj4gPg0KPiA+IE9ubHkg
YmNtIHVzZXMgaXQgdG8gcmVjZWl2ZSBkYXRhLg0KPiA+IGRyaXZlcnMvbWFpbGJveC9iY20tZmxl
eHJtLW1haWxib3guYw0KPiA+DQo+ID4gRm9yIG91ciByZXF1aXJlbWVudCwgd2Ugd2FudCB0byBp
bXBsZW1lbnQgc3luYyByZWNlaXZpbmcgcHJvdG9jb2wgbGlrZToNCj4gPiBTY19jYWxsX3JwYygp
DQo+ID4gew0KPiA+ICAgICAgICAgbWJveF9zZW5kX21lc3NhZ2UoY2hhbiwgbXNnKQ0KPiA+ICAg
ICAgICAgSWYgKCFub19yZXNwKQ0KPiA+ICAgICAgICAgICAgICAgICAvLyByeCBhbHNvIHN0b3Jl
ZCBpbiBtc2cNCj4gPiAgICAgICAgICAgICAgICAgbWJveF9yZWNlaXZlX21zZ19pbl9wb2xsaW5n
KGNoYW4sIG1zZyk7DQo+ID4gICAgICAgICBtYm94X2NsaWVudF90eGRvbmUoKTsNCj4gPiB9DQo+
ID4NCj4gPiBJZiB1c2luZyBwZWVrX2RhdGEsIGl0IGNhbiBiZToNCj4gPiBTY19jYWxsX3JwYygp
DQo+ID4gew0KPiA+ICAgICAgICAgbWJveF9zZW5kX21lc3NhZ2UoY2hhbiwgbXNnKQ0KPiA+ICAg
ICAgICAgSWYgKCFub19yZXNwKQ0KPiA+ICAgICAgICAgICAgICAgICAvLyByeCBhbHNvIHN0b3Jl
ZCBpbiBtc2cNCj4gPiAgICAgICAgICAgICAgICAgTWJveF9jbGllbnRfcGVla19kYXRhKGNoYW4p
Ow0KPiA+DQo+IFllcywgYW5kIHlvdSBtYXkgd2FudCB0byBsb29wIGZvciBhIGNlcnRhaW4gYW1v
dW50IG9mIHRpbWUgaWYgcGVlayBrZWVwcw0KPiByZXR1cm5pbmcgZmFsc2UuDQo+IA0KPiA+ICAg
ICAgICAgbWJveF9jbGllbnRfdHhkb25lKCk7DQo+ID4gfQ0KPiA+DQo+ID4gQW5kIGZvciBtdSBj
b250cm9sbGVyIGRyaXZlciAucGVla19kYXRhKCk6DQo+ID4gaW14X211X3BlZWtfZGF0YShjaGFu
KQ0KPiA+IHsNCj4gPiAgICAgICAgIC8vIGdldCBmaXJzdCB3b3JkIGFuZCBwYXJzZSBkYXRhIHNp
emUNCj4gPiAgICAgICAgIGlteF9tdV9yZWNlaXZlX21zZygmbXUtPmNoYW5zLCAwLCBtdS0+bXNn
KTsNCj4gPg0KPiA+ICAgICAgICAgcmF3X2RhdGEgPSAodTggKiltdS0+bXNnOw0KPiA+ICAgICAg
ICAgc2l6ZSA9IHJhd19kYXRhWzFdOw0KPiA+DQo+ID4gICAgICAgICAvLyByZWNlaXZlIHJlc3Qg
b2YgdGhlbQ0KPiA+ICAgICAgICAgZm9yIChpID0gMTsgaSA8IHNpemU7IGkrKykgew0KPiA+ICAg
ICAgICAgICAgICAgICByZXQgPSBpbXhfbXVfcmVjZWl2ZV9tc2coJm11LT5jaGFucywgaSAlIDQs
IG11LT5tc2cgKyBpKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAg
ICAgICAgIG1ib3hfY2hhbl9yZWNlaXZlZF9kYXRhKCZtdS0+Y2hhbnMsICh2b2lkICopbXUtPm1z
Zyk7DQo+ID4NCj4gTm90IHN1cmUgaG93IHlvdXIgY29udHJvbGxlciB3b3Jrcy4gQnV0IHRoZSBw
ZWVrKCkgY2FsbGJhY2sgb25seSBfY2hlY2tzXyBpZg0KPiB0aGVyZSBpcyBzb21lIGRhdGEgYXZh
aWxhYmxlIHRvIGJlIHJlYWQuIFBsZWFzZSBub3RlIHRoYXQNCj4gcGVlaygpIGNhbiBub3Qgc2xl
ZXAuDQo+IFNvIGlmIHRoZSBkYXRhIGZldGNoaW5nIGRvZXNuJ3Qgc2xlZXAgeW91IGNhbiBkbyB0
aGF0IGhlcmUsIG90aGVyd2lzZSBwZWVrDQo+IGhhcyB0byBzY2hlZHVsZSB0aGUgYWN0dWFsIGZl
dGNoaW5nIG9mIGRhdGEgZnJvbSByZW1vdGUgYW5kIHByb3ZpZGluZyB0byB0aGUNCj4gY2xpZW50
IHZpYSBtYm94X2NoYW5fcmVjZWl2ZWRfZGF0YS4NCj4gDQoNCmJjbSBzZWVtcyBpcyB1c2luZyBw
ZWVrIHRvIHJlY2VpdmUgZGF0YSwgbm90IG9ubHkgY2hlY2tpbmcgdGhlIGRhdGEgYXZhaWxhYmls
aXR5LA0KcmlnaHQ/DQpkcml2ZXJzL21haWxib3gvYmNtLWZsZXhybS1tYWlsYm94LmMNCg0KU28g
SSBkaWQgdGhlIHNpbWlsYXIgd2F5IGZvciBpLk1YLiBJIGp1c3Qgc2VudCBvdXQgdGhhdCBuZXcg
cGF0Y2ggc2VyaWVzLg0KUGxlYXNlIGhlbHAgcmV2aWV3IGlmIGFueSBwcm9ibGVtIG9mIGl0Lg0K
QlRXIGkuTVggcGVlayBpcyB1c2luZyBidXN5IHBvbGxpbmcsIHNvIHdvbid0IHNsZWVwLg0KDQpS
ZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiAtamFzc2kNCg==
