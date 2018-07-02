Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC33C25774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kutaJBqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC33C25774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbeGBCcP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:32:15 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:16448
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbeGBCcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojMT6vNnaMzxAW1M3mO8/keR965PbgZeSoivvKrbuUM=;
 b=kutaJBqjqQCPIvIfPgUL4pTI1ZROGyFozUBrYzys7F3XsDOJagDu4y+Xn5G14/JI4gD0HcTCqvgfa+fc8RWIUoGr5g2cNr6ovDWZW/uZ2YR1VhZuRvDrDqFnAXq27xcZAZxJEtK9Rr3mpvWg76moHS6uajHEq9w3hB6/kQmdLlE=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3142.eurprd04.prod.outlook.com (10.170.214.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Mon, 2 Jul 2018 02:32:06 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9%5]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 02:32:06 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Topic: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Index: AQHUB6ubqqf+VcikvUmzLvpSTD8gdKRyrn4AgAkh14A=
Date:   Mon, 2 Jul 2018 02:32:05 +0000
Message-ID: <1530527489.15665.22.camel@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
         <1530025442.9910.44.camel@pengutronix.de>
In-Reply-To: <1530025442.9910.44.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3142;7:QF6/U30rEZeSbddbrvp/g2XNt/4w3xQbrQWnHzwnzYh4ujbO/B4ihvpBHNrHX8O8KVMsh/Mw9LPq3LsF4Ml3JzF7TS8Mac9+p+mwpt7t6BEVbjNcvGpKzkSLXxQjJHIY3k5asw5IZUGtmxVGVmh1cSqTL+dBbW2dWtT/LiBClVZ9LhWZDHSw7+fo9wOWzA4/qY/Cho9zwa8wHlKhu29BxowTp4PIDWZC/Kvjh+LuGLQfksWuYYWhBffE8/Dm6MKl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e3d9aee7-f71e-48a2-4bf3-08d5dfc400a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3142;
x-ms-traffictypediagnostic: DB6PR04MB3142:
x-microsoft-antispam-prvs: <DB6PR04MB3142CB9CF5868CCB52B620F789430@DB6PR04MB3142.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3142;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3142;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(54906003)(81156014)(4326008)(6486002)(476003)(11346002)(14444005)(186003)(81166006)(256004)(26005)(8936002)(8676002)(2616005)(110136005)(102836004)(103116003)(446003)(2501003)(7416002)(76176011)(486006)(5250100002)(6512007)(36756003)(6246003)(478600001)(6436002)(6506007)(97736004)(7736002)(2201001)(5660300001)(229853002)(316002)(14454004)(305945005)(86362001)(68736007)(53936002)(66066001)(106356001)(105586002)(2900100001)(6116002)(3846002)(99286004)(50226002)(25786009)(2906002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3142;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 16fjRxrKR8VKxlcTUIFYmZ1TQC7PWsF6gg8R318UdDt5Q5Igqu1T33kM4B3gOcERPLOOSfjF1dHh+mN+CHCVH+mkIWcbWmryK2SEx8ZE/VM0OjVLgQuKJSHX45qq2cxvmo1dDW7znXfYoS7I6NNP3qkz0zwuREX4ZsRyDp9gnjvGuL3pKsCXlsKm6hEs46aMjtRLKROBP5hVXsmTcgMcqDEa96qCG2CeGdF1iKWsrdbauCTVBwnvrDN1cw5b/QrR2IlVwvpKZRMrokfBC6Y4lTt/UkB7ESrsIK20MPWfmCcHXgJY0MciVSF7rUazFXxhVyL1HbAMmGC/l96qNLdKsiJxE6m7wUmYU9um9SQC8Zg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BECDD57B9DFA645AD0B258DF54ACD41@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d9aee7-f71e-48a2-4bf3-08d5dfc400a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 02:32:05.9460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlub2QsDQoJRG8geW91IGhhdmUgYW55IGNvbW1lbnQgZm9yIHRoaXMgcGF0Y2hzZXQ/IEx1
Y2FzIGFuZCBTYXNjaGENCmFja2VkIGl0IGFuZCB0dHkgcGF0Y2ggYWxyZWFkeSBtZXJnZWQgaW4u
DQoNCk9uIOS6jCwgMjAxOC0wNi0yNiBhdCAxNzowNCArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6
DQo+IEhpIFJvYmluLA0KPiANCj4gSSd2ZSB0ZXN0ZWQgdGhpcyB3aG9sZSBzZXJpZXMgd2l0aCB0
aGUgU0RNQSBiZWluZyB1c2VkIGZvciBTUEksIFVBUlQNCj4gYW5kIFNTSSB3aXRoIG5vIHJlZ3Jl
c3Npb25zIHNwb3R0ZWQuIEFzIHRoaXMgc2hvdWxkIGNvdmVyIG1vc3QgY29tbW9uDQo+IHVzZS1j
YXNlcywgSSB0aGluayB0aGlzIHNlcmllcyBpcyBnb29kIHRvIGdvIGluLg0KPiANCj4gVGVzdGVk
LWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gDQo+IFJlZ2FyZHMs
DQo+IEx1Y2FzDQo+IA0KPiBBbSBNaXR0d29jaCwgZGVuIDIwLjA2LjIwMTgsIDAwOjU2ICswODAw
IHNjaHJpZWIgUm9iaW4gR29uZzoNCj4gPiANCj4gPiBUaGUgbGVnYWN5IHNkbWEgZHJpdmVyIGhh
cyBiZWxvdyBsaW1pdGF0aW9ucyBvciBkcmF3YmFja3M6DQo+ID4gwqAgMS4gSGFyZGNvZGUgdGhl
IG1heCBCRHMgbnVtYmVyIGFzICJQQUdFX1NJWkUgLyBzaXplb2YoKikiLCBhbmQNCj4gPiBhbGxv
Yw0KPiA+IMKgwqDCoMKgwqBvbmUgcGFnZSBzaXplIGZvciBvbmUgY2hhbm5lbCByZWdhcmRsZXNz
IG9mIG9ubHkgZmV3IEJEcw0KPiA+IG5lZWRlZA0KPiA+IMKgwqDCoMKgwqBtb3N0IHRpbWUuIEJ1
dCBpbiBmZXcgY2FzZXMsIHRoZSBtYXggUEFHRV9TSVpFIG1heWJlIG5vdA0KPiA+IGVub3VnaC4N
Cj4gPiDCoCAyLiBPbmUgU0RNQSBjaGFubmVsIGNhbid0IHN0b3AgaW1tZWRpYXRsZXkgb25jZSBj
aGFubmVsIGRpc2FibGVkDQo+ID4gd2hpY2gNCj4gPiDCoMKgwqDCoMKgbWVhbnMgU0RNQSBpbnRl
cnJ1cHQgbWF5IGNvbWUgaW4gYWZ0ZXIgdGhpcyBjaGFubmVsDQo+ID4gdGVybWluYXRlZC5UaGVy
ZQ0KPiA+IMKgwqDCoMKgwqBhcmUgc29tZSBwYXRjaGVzIGZvciB0aGlzIGNvcm5lciBjYXNlIHN1
Y2ggYXMgY29tbWl0DQo+ID4gIjI3NDZlMmMzODlmOSIsDQo+ID4gwqDCoMKgwqDCoGJ1dCBub3Qg
Y292ZXIgbm9uLWN5Y2xpYy4NCj4gPiANCj4gPiBUaGUgY29tbW9uIHZpcnQtZG1hIG92ZXJjb21l
cyB0aGUgYWJvdmUgbGltaXRhdGlvbnMuIEl0IGNhbiBhbGxvYw0KPiA+IGJkDQo+ID4gZHluYW1p
Y2FsbHkgYW5kIGZyZWUgYmQgb25jZSB0aGlzIHR4IHRyYW5zZmVyIGRvbmUuIE5vIG1lbW9yeQ0K
PiA+IHdhc3RlZCBvcg0KPiA+IG1heGltdW0gbGltaXRpdGF0aW9uIGhlcmUsIG9ubHkgZGVwZW5k
cyBvbiBob3cgbWFueSBtZW1vcnkgY2FuIGJlDQo+ID4gcmVxdWVzdGVkDQo+ID4gZnJvbSBrZXJu
ZWwuIEZvciBOby4yLCBzdWNoIGlzc3VlIGNhbiBiZSB3b3JrYXJvdW5kIGJ5IGNoZWNraW5nIGlm
DQo+ID4gdGhlcmUNCj4gPiBpcyBhdmFpbGFibGUgZGVzY3JpcHQoInNkbWFjLT5kZXNjIikgbm93
IG9uY2UgdGhlIHVud2FudGVkDQo+ID4gaW50ZXJydXB0DQo+ID4gY29taW5nLiBBdCBsYXN0IHRo
ZSBjb21tb24gdmlydC1kbWEgaXMgZWFzaWVyIGZvciBzZG1hIGRyaXZlcg0KPiA+IG1haW50YWlu
Lg0KPiA+IA0KPiA+IENoYW5nZSBmcm9tIHY0Og0KPiA+IMKgIDEuIGlkZW50aWZ5IGxvY2tkZXAg
aXNzdWUgd2hpY2ggY2F1c2VkIGJ5IGFsbG9jYXRlIG1lbW9yeSB3aXRoDQo+ID4gwqDCoMKgwqDC
oCdHRlBfS0VSTkVMJywgY2hhbmdlIHRvICdHRlBfTk9XQUlUJyBpbnN0ZWFkIHNvIHRoYXQgbG9j
a2RlcA0KPiA+IMKgwqDCoMKgwqBpZ25vcmUgY2hlY2suIFRoYXQgYWxzbyBtYWtlIHNlbnNlIHNp
bmNlIEF1ZGlvL3VhcnQgZHJpdmVyIG1heQ0KPiA+IMKgwqDCoMKgwqBjYWxsIGRtYSBmdW5jdGlv
biBhZnRlciBzcGluX2xvY2tfaXJxc2F2ZSgpLi4uDQo+ID4gwqAgMi4gdXNlIGRtYSBwb29sIGlu
c3RlYWQgZm9yIGJkIGRlc2NyaXB0aW9uIGFsbG9jYXRlZCxzaW5jZSBhdWRpbw0KPiA+IMKgwqDC
oMKgwqBkcml2ZXIgbWF5IGNhbGwgZG1hX3Rlcm1pbmF0ZV9hbGwgaW4gaXJxLiBQbGVhc2UgcmVm
ZXIgdG8gNy83Lg0KPiA+IMKgIDMuIHJlbW92ZSA3Lzcgc2VyaWFsIHBhdGNoIGluIHY0LCBzaW5j
ZSBsb2NrZGVwIGlzc3VlZCBmaXhlZCBieQ0KPiA+IE5vLjHCoA0KPiA+IA0KPiA+IENoYW5nZSBm
cm9tIHYzOg0KPiA+IMKgIDEuIGFkZCB0d28gdWFydCBwYXRjaGVzIHdoaWNoIGltcGFjdGVkIGJ5
IHRoaXMgcGF0Y2hzZXQuDQo+ID4gwqAgMi4gdW5sb2NrICd2Yy5sb2NrJyBiZWZvcmUgY3ljbGlj
IGRtYSBjYWxsYmFjayBhbmQgbG9jayBhZ2Fpbg0KPiA+IGFmdGVyDQo+ID4gwqDCoMKgwqDCoGl0
IGJlY2F1c2Ugc29tZSBkcml2ZXIgc3VjaCBhcyB1YXJ0IHdpbGwgY2FsbA0KPiA+IGRtYWVuZ2lu
ZV90eF9zdGF0dXMNCj4gPiDCoMKgwqDCoMKgd2hpY2ggd2lsbCBhY3F1aXJlICd2Yy5sb2NrJyBh
Z2FpbiBhbmQgZGVhZCBsb2NrIGNvbWVzIG91dC4NCj4gPiDCoCAzLiByZW1vdmUgJ1JldmVydCBj
b21taXQnIHN0dWZmIHNpbmNlIHRoYXQgcGF0Y2ggaXMgbm90IHdyb25nIGFuZA0KPiA+IMKgwqDC
oMKgwqBjb21iaW5lIHR3byBwYXRjaCBpbnRvIG9uZSBwYXRjaCBhcyBTYXNjaGEncyBjb21tZW50
Lg0KPiA+IA0KPiA+IENoYW5nZSBmcm9tIHYyOg0KPiA+IMKgIDEuIGluY2x1ZGUgU2FzY2hhJ3Mg
cGF0Y2ggdG8gbWFrZSB0aGUgbWFpbiBwYXRjaCBlYXNpZXIgdG8NCj4gPiByZXZpZXcuDQo+ID4g
wqDCoMKgwqDCoFRoYW5rcyBTYWNoYS4NCj4gPiDCoCAyLiByZW1vdmUgdXNlbGVzcyAnZGVzYycv
J2NoYW4nIGluIHN0cnVjdCBzZG1hX2NoYW5uZS4NCj4gPiANCj4gPiBDaGFuZ2UgZnJvbSB2MToN
Cj4gPiDCoCAxLiBzcGxpdCB2MSBwYXRjaCBpbnRvIDUgcGF0Y2hlcy4NCj4gPiDCoCAyLiByZW1v
dmUgc29tZSB1bm5lY2Vzc2FyeSBjb25kaXRpb24gY2hlY2suDQo+ID4gwqAgMy4gcmVtb3ZlIHVu
bmVjZXNzYXJ5ICdwZW5kaW5nJyBsaXN0Lg0KPiA+IA0KPiA+IFJvYmluIEdvbmcgKDYpOg0KPiA+
IMKgIHR0eTogc2VyaWFsOiBpbXg6IGNvcnJlY3QgZG1hIGNvb2tpZSBzdGF0dXMNCj4gPiDCoCBk
bWFlbmdpbmU6IGlteC1zZG1hOiBhZGQgdmlydC1kbWEgc3VwcG9ydA0KPiA+IMKgIGRtYWVuZ2lu
ZTogaW14LXNkbWE6IHJlbW92ZSB1c2VsZXNzICdsb2NrJyBhbmQgJ2VuYWJsZWQnIGluDQo+ID4g
J3N0cnVjdA0KPiA+IMKgwqDCoMKgc2RtYV9jaGFubmVsJw0KPiA+IMKgIGRtYWVuZ2luZTogaW14
LXNkbWE6IHJlbW92ZSB0aGUgbWF4aW11bSBsaW1pdGF0aW9uIGZvciBiZCBudW1iZXJzDQo+ID4g
wqAgZG1hZW5naW5lOiBpbXgtc2RtYTogYWRkIHNkbWFfdHJhbnNmZXJfaW5pdCB0byBkZWNyZWFz
ZSBjb2RlDQo+ID4gb3ZlcmxhcA0KPiA+IMKgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFsbG9jbGF0
ZSBiZCBtZW1vcnkgZnJvbSBkbWEgcG9vbA0KPiA+IA0KPiA+IFNhc2NoYSBIYXVlciAoMSk6DQo+
ID4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogZmFjdG9yIG91dCBhIHN0cnVjdCBzZG1hX2Rlc2Mg
ZnJvbSBzdHJ1Y3QNCj4gPiDCoMKgwqDCoHNkbWFfY2hhbm5lbA0KPiA+IA0KPiA+IMKgZHJpdmVy
cy9kbWEvS2NvbmZpZ8KgwqDCoMKgwqDCoHzCoMKgwqAxICsNCj4gPiDCoGRyaXZlcnMvZG1hL2lt
eC1zZG1hLmPCoMKgwqB8IDQwMCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4g
PiAtLS0tLS0tLS0tLS0tLQ0KPiA+IMKgZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHzCoMKgwqAy
ICstDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDIzNSBpbnNlcnRpb25zKCspLCAxNjggZGVsZXRp
b25zKC0pDQo+ID4g
