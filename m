Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECECC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465DF2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o15rBFan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465DF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbeGKNC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:02:57 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:43280
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbeGKNC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztxJwJ6/M/ysHAEogAjdpbrMZ+wYTIgEBv6Kl2lccpk=;
 b=o15rBFanAFHukaojXmpgFljGcRVacS5Y/pRkULMmSErSElSPmRt8p+f3WYfmpO25KtcMXUTTyX1pNSr+OaRFWtRlbOl4n8Ip7s8rqbhEgCPDBJYcA4KG5U0KJYL2aEv6yJI8cgqu1oGBgpd2tjpuM4L7hBIxKpsuCV0vO8c+5IA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4769.eurprd04.prod.outlook.com (20.176.215.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Wed, 11 Jul 2018 12:58:39 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 12:58:39 +0000
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
Thread-Index: AQHUFsxVRb7g/AGotk2h6FoTYgzkeKSIhHsAgAEHGTCAAB+9AIAAGVgwgAAV8QCAAB88IA==
Date:   Wed, 11 Jul 2018 12:58:39 +0000
Message-ID: <AM0PR04MB4211AD523CFB8DA99AB05EFC805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
 <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
In-Reply-To: <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4769;7:LyS35xjOgsr2vbysnTccmsRRSlH9kOoWP8hzuZBP6zjhIlb/01B7cu+bQRFltvtFROlts7ka7pMxBvuvSxBT+WrBKSJHCDYC7P7PLDIGVnSEl+SbFH0vIVpq//kAU9zoiz2cBAvOJYzfw5OfnmMKg55+o8XFzVFlbnbPTESrEdbQbvKzhTTgy/d+fcw6M35hPWYwYv7OQEusC+XBkzEy4GjFaQVGoaIh/Rsx5ychm4Dy7W2W6g+Y61GoY2ReANYF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 03061167-e9eb-4dda-e64e-08d5e72e05a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4769;
x-ms-traffictypediagnostic: AM0PR04MB4769:
x-microsoft-antispam-prvs: <AM0PR04MB4769A01F05A8FA20EA36249E805A0@AM0PR04MB4769.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4769;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4769;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(13464003)(51914003)(5250100002)(14454004)(478600001)(105586002)(81166006)(2906002)(25786009)(86362001)(305945005)(106356001)(7696005)(76176011)(7736002)(74316002)(8676002)(446003)(11346002)(15650500001)(486006)(55016002)(5660300001)(4326008)(39060400002)(53936002)(33656002)(256004)(81156014)(8936002)(6246003)(476003)(9686003)(1411001)(93886005)(229853002)(6916009)(97736004)(2900100001)(66066001)(68736007)(99286004)(26005)(6436002)(316002)(6116002)(186003)(54906003)(3846002)(102836004)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4769;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CGPnCQN5gKBK9cRFUzSAk5a+0aluTZSln4ut8KV8Cfs3XbilZHMsVeDe6W1dVvC6Jwx+BRd1q9dUn2rEiRNYN8/+mIxmvDfNl919fo0SRtsae3O+bG3hXOXoVEtgwQ5Km+U83ZterHXpvwqcqAvo5lnvfisQeDen7m9NyoHLnBpjZeYSsMHHSbfCIxpSfy7IbpO2OyZYavKhs2UJDnkBLZSHqcicxVai7eoeyenWLMYIMDBUP668h/BTm43rLO3nd2781qwJMbnJDgLhKat3PXjieVWQCu6cGgLGNwYhuV4fz8xxAX2h6EFO7nYJrk8xOSmsCo0zVdCx5R5/mmyIgfDEe2P4WmHVXJLJCvg/JdA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03061167-e9eb-4dda-e64e-08d5e72e05a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 12:58:39.0789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzc2kg
QnJhciBbbWFpbHRvOmphc3Npc2luZ2hicmFyQGdtYWlsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5
LCBKdWx5IDExLCAyMDE4IDY6NDQgUE0NCj4gVG86IEEucy4gRG9uZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+DQo+IENjOiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBsaW51
eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkb25nYXM4NkBnbWFpbC5jb207
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBPbGVrc2lqIFJlbXBlbCA8by5yZW1w
ZWxAcGVuZ3V0cm9uaXguZGU+OyBkbC0NCj4gbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmFiaW8uZXN0ZXZhbUBu
eHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDMv
NV0gbWFpbGJveDogaW14OiBhZGQgaW14IG11IHN1cHBvcnQNCj4gDQo+IE9uIFdlZCwgSnVsIDEx
LCAyMDE4IGF0IDQ6MDcgUE0sIEEucy4gRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogU2Fz
Y2hhIEhhdWVyIFttYWlsdG86cy5oYXVlckBwZW5ndXRyb25peC5kZV0NCj4gPiA+IFNlbnQ6IFdl
ZG5lc2RheSwgSnVseSAxMSwgMjAxOCAzOjU1IFBNDQo+ID4gPiBUbzogQS5zLiBEb25nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiA+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRvbmdhczg2QGdtYWlsLmNvbTsgSmFzc2kNCj4gPiA+IEJyYXIgPGphc3Npc2lu
Z2hicmFyQGdtYWlsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBP
bGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+OyBkbC1saW51eC1pbXgNCj4g
PiA+IDxsaW51eC1pbXhAbnhwLmNvbT47IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0
ZXZhbQ0KPiA+ID4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmcN
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMy81XSBtYWlsYm94OiBpbXg6IGFkZCBpbXgg
bXUgc3VwcG9ydA0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgSnVsIDExLCAyMDE4IGF0IDA3OjI5OjM4
QU0gKzAwMDAsIEEucy4gRG9uZyB3cm90ZToNCj4gPiA+ID4gSGkgU2FzY2hhLA0KPiA+ID4gPg0K
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogU2Fz
Y2hhIEhhdWVyIFttYWlsdG86cy5oYXVlckBwZW5ndXRyb25peC5kZV0NCj4gPiA+ID4gPiBTZW50
OiBUdWVzZGF5LCBKdWx5IDEwLCAyMDE4IDEwOjIwIFBNDQo+ID4gPiA+ID4gVG86IEEucy4gRG9u
ZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+ID4gPiA+ID4gQ2M6IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgZG9uZ2FzODZAZ21haWwuY29tOw0KPiA+ID4gPiA+IEphc3Np
IEJyYXIgPGphc3Npc2luZ2hicmFyQGdtYWlsLmNvbT47DQo+ID4gPiA+ID4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgT2xla3NpaiBSZW1wZWwNCj4gPiA+ID4gPiA8by5yZW1wZWxAcGVu
Z3V0cm9uaXguZGU+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gPiA+ID4g
PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1Abnhw
LmNvbT47DQo+ID4gPiA+ID4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPiA+ID4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggVjQgMy81XSBtYWlsYm94OiBpbXg6IGFkZCBpbXggbXUgc3VwcG9ydA0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBTdW4sIEp1bCAw
OCwgMjAxOCBhdCAxMDo1Njo1NVBNICswODAwLCBEb25nIEFpc2hlbmcgd3JvdGU6DQo+ID4gPiA+
ID4gPiBUaGlzIGlzIHVzZWQgZm9yIGkuTVggbXVsdGkgY29yZSBjb21tdW5pY2F0aW9uLg0KPiA+
ID4gPiA+ID4gZS5nLiBBIGNvcmUgdG8gU0NVIGZpcm13YXJlKE0gY29yZSkgb24gTVg4Lg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFR4IGlzIHVzaW5nIHBvbGxpbmcgbW9kZSB3aGlsZSBSeCBp
cyBpbnRlcnJ1cHQgZHJpdmVuIGFuZA0KPiA+ID4gPiA+ID4gc2NoZWR1bGUgYSBocnRpbWVyIHRv
IHJlY2VpdmUgcmVtYWluIHdvcmRzIGlmIGhhdmUgbW9yZSB0aGFuDQo+ID4gPiA+ID4gPiA0IHdv
cmRzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWW91IHRvbGQgdXMgdGhhdCB1c2luZyBpbnRlcnJ1
cHRzIGlzIG5vdCBwb3NzaWJsZSBkdWUgdG8NCj4gPiA+ID4gPiBtaXNlcmFibGUgcGVyZm9ybWFu
Y2UsIHdlIHRoZW4gcHJvdmlkZWQgeW91IGEgd2F5IHdpdGggd2hpY2ggeW91DQo+IGNvdWxkIHBv
bGwuDQo+ID4gPiA+ID4gV2h5IGFyZSB5b3UgdXNpbmcgaW50ZXJydXB0cyBub3c/DQo+ID4gPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gQmVjYXVzZSBtYWlsYm94IGZyYW1ld29yayBkb2VzIG5vdCBz
dXBwb3J0IHN5bmMgcnggbm93LCBJIHRoaW5rIHdlDQo+ID4gPiA+IGRvIG5vdCBuZWVkIHRvIHdh
aXQgZm9yIHRoYXQgZmVhdHVyZSBkb25lIGZpcnN0IGFzIGl0J3MNCj4gPiA+ID4gaW5kZXBlbmRl
bnQgYW5kIHNlcGFyYXRlIGZlYXR1cmVzIG9mIGZyYW1ld29yay4NCj4gPiA+DQo+ID4gPiBZb3Ug
Y2FuIHdhaXQgZm9yZXZlciBmb3IgdGhpcyBmZWF0dXJlLCBub2JvZHkgd2lsbCBhZGQgaXQgZm9y
IHlvdS4NCj4gPiA+IEl0J3MgdXAgdG8geW91IHRvIGFkZCBzdXBwb3J0IGZvciB0aGF0IGZlYXR1
cmUuIFdobyBlbHNlIHNob3VsZCBhZGQgdGhpcw0KPiBmZWF0dXJlIGlmIG5vdCB5b3U/DQo+ID4g
PiBBbmQgd2hlbiB3aWxsIHlvdSBhZGQgdGhhdCBmZWF0dXJlIGlmIG5vdCBub3cgd2hlbiB5b3Ug
YWN0dWFsbHkgbmVlZCBpdD8NCj4gPiA+IEl0IGlzIGNvbW1vbiBwcmFjdGljZSB0aGF0IHlvdSBh
ZGp1c3QgdGhlIGZyYW1ld29ya3MgdG8geW91ciBuZWVkcw0KPiA+ID4gcmF0aGVyIHRoYW4gd29y
a2luZyBhcm91bmQgdGhlbS4NCj4gPiA+DQo+ID4NCj4gPiBJJ20gd2lsbGluZyB0byBhZGQgaXQu
IEp1c3QgYmVjYXVzZSB5b3Ugc2FpZCBKYXNzaSBhbHJlYWR5IGhhZCB0aGUNCj4gPiBpZGVhIG9u
IGhvdyB0byBJbXBsZW1lbnQgaXQgYW5kIGRvZXMgbm90IGFkZCBtdWNoIGNvbXBsZXhpdHkuIFNv
IEkganVzdA0KPiB3YW50IHRvIHNlZSBoaXMgcGF0Y2hlcy4NCj4gPiBCdXQgaWYgaGUgZGlkIG5v
dCB3b3JrIG9uIGl0LCBJIGNhbiBhbHNvIGhlbHAgb24gaXQuDQo+ID4NCj4gSSBhbSBub3QgbXVj
aCBhd2FyZSBvZiB0aGUgaGlzdG9yeSBvZiB0aGlzIGNvbnZlcnNhdGlvbi4uLiBidXQgaXQgc2Vl
bXMgeW91DQo+IG5lZWQgdG8gbWFrZSB1c2Ugb2YgbWJveF9jaGFuX29wcy5wZWVrX2RhdGEoKS4N
Cj4gDQo+IElmIG5vdCB0aGF0LCBwbGVhc2UgbGV0IG1lIGtub3cgdGhlIHJlcXVpcmVtZW50Lg0K
PiANCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCkl0IGxvb2tzIHRvIG1lIG1heSB3b3Jr
Lg0KDQpGcm9tIHRoZSBkZWZpbml0aW9uLCBpdCBzZWVtcyBpdCdzIHVzZWQgdG8gcHVsbCBkYXRh
IGZyb20gcmVtb3RlIHNpZGUuDQovKioNCiAqIG1ib3hfY2xpZW50X3BlZWtfZGF0YSAtIEEgd2F5
IGZvciBjbGllbnQgZHJpdmVyIHRvIHB1bGwgZGF0YQ0KICogICAgICAgICAgICAgICAgICAgICAg
cmVjZWl2ZWQgZnJvbSByZW1vdGUgYnkgdGhlIGNvbnRyb2xsZXIuDQogKiBAY2hhbjogTWFpbGJv
eCBjaGFubmVsIGFzc2lnbmVkIHRvIHRoaXMgY2xpZW50Lg0KICogICAgICAgICAgDQogKiBBIHBv
a2UgdG8gY29udHJvbGxlciBkcml2ZXIgZm9yIGFueSByZWNlaXZlZCBkYXRhLg0KICogVGhlIGRh
dGEgaXMgYWN0dWFsbHkgcGFzc2VkIG9udG8gY2xpZW50IHZpYSB0aGUNCiAqIG1ib3hfY2hhbl9y
ZWNlaXZlZF9kYXRhKCkNCiAqIFRoZSBjYWxsIGNhbiBiZSBtYWRlIGZyb20gYXRvbWljIGNvbnRl
eHQsIHNvIHRoZSBjb250cm9sbGVyJ3MNCiAqIGltcGxlbWVudGF0aW9uIG9mIHBlZWtfZGF0YSgp
IG11c3Qgbm90IHNsZWVwLg0KICoNCiAqIFJldHVybjogVHJ1ZSwgaWYgY29udHJvbGxlciBoYXMs
IGFuZCBpcyBnb2luZyB0byBwdXNoIGFmdGVyIHRoaXMsDQogKiAgICAgICAgICBzb21lIGRhdGEu
DQogKiAgICAgICAgIEZhbHNlLCBpZiBjb250cm9sbGVyIGRvZXNuJ3QgaGF2ZSBhbnkgZGF0YSB0
byBiZSByZWFkLg0KICovICAgICANCmJvb2wgbWJveF9jbGllbnRfcGVla19kYXRhKHN0cnVjdCBt
Ym94X2NoYW4gKmNoYW4pDQp7DQogICAgICAgIGlmIChjaGFuLT5tYm94LT5vcHMtPnBlZWtfZGF0
YSkNCiAgICAgICAgICAgICAgICByZXR1cm4gY2hhbi0+bWJveC0+b3BzLT5wZWVrX2RhdGEoY2hh
bik7DQogICAgICAgIA0KICAgICAgICByZXR1cm4gZmFsc2U7DQp9ICAgICAgIA0KRVhQT1JUX1NZ
TUJPTF9HUEwobWJveF9jbGllbnRfcGVla19kYXRhKTsNCkJ1dCBpdCBzZWVtcyBtb3N0IHVzZXJz
IGluIGtlcm5lbCBzaW1wbHkgaW1wbGVtZW50IGl0IGFzIGEgZGF0YSBhdmFpbGFibGUNCkNoZWNr
aW5nIHJhdGhlciB0aGFuIHJlY2VpdmluZyBpdC4NClNlZToNCmRyaXZlcnMvbWFpbGJveC90aS1t
c2dtZ3IuYw0KZHJpdmVycy9tYWlsYm94L21haWxib3gtYWx0ZXJhLmMNCg0KT25seSBiY20gdXNl
cyBpdCB0byByZWNlaXZlIGRhdGEuDQpkcml2ZXJzL21haWxib3gvYmNtLWZsZXhybS1tYWlsYm94
LmMNCg0KRm9yIG91ciByZXF1aXJlbWVudCwgd2Ugd2FudCB0byBpbXBsZW1lbnQgc3luYyByZWNl
aXZpbmcgcHJvdG9jb2wgbGlrZToNClNjX2NhbGxfcnBjKCkNCnsNCgltYm94X3NlbmRfbWVzc2Fn
ZShjaGFuLCBtc2cpDQoJSWYgKCFub19yZXNwKQ0KCQkvLyByeCBhbHNvIHN0b3JlZCBpbiBtc2cN
CgkJbWJveF9yZWNlaXZlX21zZ19pbl9wb2xsaW5nKGNoYW4sIG1zZyk7DQoJbWJveF9jbGllbnRf
dHhkb25lKCk7DQp9DQoNCklmIHVzaW5nIHBlZWtfZGF0YSwgaXQgY2FuIGJlOg0KU2NfY2FsbF9y
cGMoKQ0Kew0KCW1ib3hfc2VuZF9tZXNzYWdlKGNoYW4sIG1zZykNCglJZiAoIW5vX3Jlc3ApDQoJ
CS8vIHJ4IGFsc28gc3RvcmVkIGluIG1zZw0KCQlNYm94X2NsaWVudF9wZWVrX2RhdGEoY2hhbik7
DQoJbWJveF9jbGllbnRfdHhkb25lKCk7DQp9DQoNCkFuZCBmb3IgbXUgY29udHJvbGxlciBkcml2
ZXIgLnBlZWtfZGF0YSgpOg0KaW14X211X3BlZWtfZGF0YShjaGFuKQ0Kew0KICAgICAgICAvLyBn
ZXQgZmlyc3Qgd29yZCBhbmQgcGFyc2UgZGF0YSBzaXplDQogICAgICAgIGlteF9tdV9yZWNlaXZl
X21zZygmbXUtPmNoYW5zLCAwLCBtdS0+bXNnKTsNCg0KICAgICAgICByYXdfZGF0YSA9ICh1OCAq
KW11LT5tc2c7DQogICAgICAgIHNpemUgPSByYXdfZGF0YVsxXTsNCg0KICAgICAgICAvLyByZWNl
aXZlIHJlc3Qgb2YgdGhlbSANCiAgICAgICAgZm9yIChpID0gMTsgaSA8IHNpemU7IGkrKykgew0K
ICAgICAgICAgICAgICAgIHJldCA9IGlteF9tdV9yZWNlaXZlX21zZygmbXUtPmNoYW5zLCBpICUg
NCwgbXUtPm1zZyArIGkpOw0KICAgICAgICAgICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQogICAgICAgIH0NCg0KICAgICAgICBtYm94X2NoYW5f
cmVjZWl2ZWRfZGF0YSgmbXUtPmNoYW5zLCAodm9pZCAqKW11LT5tc2cpOw0KDQogICAgICAgIHJl
dHVybiB0cnVlOw0KfQ0KSXQgaXMgbXVjaCBzcGVjaWZpYyB0byBTQ1UuDQpEbyB5b3UgdGhpbmsg
c3VjaCBwZWVrX2RhdGEgdXNpbmcgZm9yIHN5bmMgcmVjZWl2aW5nIG1vZGUgaXMgb2s/DQoNClJl
Z2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IENoZWVycyENCg==
