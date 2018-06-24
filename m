Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9364FC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FF0244E9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gUg19MbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FF0244E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeFXEXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 00:23:41 -0400
Received: from mail-ve1eur01on0069.outbound.protection.outlook.com ([104.47.1.69]:22567
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750713AbeFXEXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 00:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN0fW26R01C8EI1sHnUH8lk67TsLOl/pXE+3E/uvBEw=;
 b=gUg19MbSsqWfaDmhCPgdXXvOaAqsWhbWbLTzHAatl/fpCB2Jr/IDboI79oaVlJSQQXxRONbafcEBUjCSjWZAefhb2ZY3RdreYs+Z0bsVHZADAmqENpRXjHe253yOt/yek2flhsq0orkIBugsCpEZur9gShw1gdlLulDH9qkAqdY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4273.eurprd04.prod.outlook.com (52.134.126.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Sun, 24 Jun 2018 04:23:34 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0884.023; Sun, 24 Jun 2018
 04:23:34 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Frank Li <frank.li@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
Thread-Topic: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
Thread-Index: AQHUAl9pYBbZ62f8UEeJ1a4UTLMPsaRu3l7Q
Date:   Sun, 24 Jun 2018 04:23:34 +0000
Message-ID: <AM0PR04MB42111E25172F6068F937ECCB804B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
 <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
In-Reply-To: <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4273;7:plqvNWTeQ/rVHOqzy6yR8z0qDsXFxZlrEb3Bz422KLesJay4ZLwnXWGjyizC+bJ4RGZjJ6Kjw5Q7eDjsSrBg/S/wzUsW3IN1rksQGNoWpsv1sCpHBl9ZUN2FXbsbL0HZq+NMv5yK2C3YAupvmlALYpzhL+z2+yr2qAorp8rdS48BL6KJM3R1Z45HC0NW2XxsHC18tv0JCy7WN2gcb4IgCDCIuVOsgRLvK3HU2pHPpJRz7yASHgvcCPJ4s4iCI3nx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 303d5ac1-d9f7-4ebc-bc96-08d5d98a400b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4273;
x-ms-traffictypediagnostic: AM0PR04MB4273:
x-microsoft-antispam-prvs: <AM0PR04MB427337CB1922B73D14DE3EF4804B0@AM0PR04MB4273.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4273;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4273;
x-forefront-prvs: 0713BC207F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(13464003)(51874003)(486006)(53936002)(59450400001)(55016002)(305945005)(7736002)(7696005)(106356001)(105586002)(76176011)(68736007)(102836004)(26005)(14454004)(53546011)(6506007)(6306002)(6246003)(45080400002)(446003)(11346002)(66066001)(6116002)(966005)(5660300001)(3846002)(478600001)(476003)(316002)(9686003)(33656002)(2900100001)(229853002)(74316002)(7416002)(6636002)(25786009)(81156014)(86362001)(81166006)(4326008)(186003)(110136005)(99286004)(97736004)(8936002)(5250100002)(3280700002)(2501003)(39060400002)(2906002)(54906003)(3660700001)(8676002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4273;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q7QpfWQDjd+kZAUjdNirBHAWDs54VRNkGpPGmDqWo4sWuC2b6YFxL2kvcIOUPCfsANufdsil21oOyp1N0BhZvlagdHXpQdsVPHKVfgKtQ9a+p0N7Ue+bLZrrm+3XtN8SUy9FG9bh2Od7gBtV/uni9TeVzbIlxvfziqIOl0uNhZ6aD1kgnTH5ejjF81EjUu243ZN1gJaAdTs7cuRJt5H+VRUT1zdWeJzdOCAujBa1TORoEGXHKa8ORQqX+cnp651Dd8QEPbRKo/Yi9gqdJaAfAzVUWqysHgdL7rO610mh/FTKnWaKkKsf9NiSzSHVXzXIKVbkilNc2qI5OJPn7Mk/n6noVir6IB9hVoKmn7ppcnY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303d5ac1-d9f7-4ebc-bc96-08d5d98a400b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2018 04:23:34.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4273
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29weSBBbmR5ICYgRnJhbmssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogTWljaGFsIFZva8OhxI0gW21haWx0bzptaWNoYWwudm9rYWNAeXNvZnQuY29tXQ0KPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDEyLCAyMDE4IDExOjEwIFBNDQo+IFRvOiBsaW51eC1ncGlvQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBT
aGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPGtlcm5lbEBw
ZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47
IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgQS5zLiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEZhYmlvDQo+IEVzdGV2
YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47
DQo+IFN0ZWZhbiBBZ25lciA8c3RlZmFuQGFnbmVyLmNoPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRl
YW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUkZDXSBDb25maWd1cmUgaS5NWDYgUkdNSUkgcGFkIGdyb3VwIGNvbnRyb2wgcmVn
aXN0ZXJzIGZyb20NCj4gZGV2aWNlIHRyZWUNCj4gDQo+IE9uIDExLjYuMjAxOCAxNDozNiwgTWlj
aGFsIFZva8OhxI0gd3JvdGU6DQo+ID4gQWhvaiwNCj4gPg0KPiA+IFRvIGNvbmZpZ3VyZSBpbmRp
dmlkdWFsIHBhZCdzIGNoYXJhY3RlcmlzdGljcyBvbiBpLk1YNiBTb0MgYSBmc2wscGlucw0KPiA+
ID0gPFBJTl9GVU5DX0lEIENPTkZJRz4gcHJvcGVydHkgY2FuIGJlIHVzZWQuIElzIHRoZXJlIGFu
eSBjb252ZW5pZW50DQo+ID4gd2F5IHRvIGNvbmZpZ3VyZSB0aGUgcGFkIGdyb3VwIGNvbnRyb2wg
cmVnaXN0ZXJzPw0KPiA+DQo+ID4gVGhlIGlzc3VlIGlzIHRoYXQgc29tZSBiaXRzIChERFJfU0VM
IGFuZCBPRFQpIGluIHRoZSBpbmRpdmlkdWFsIFJHTUlJDQo+ID4gcGFkIGNvbnRyb2wgcmVnaXN0
ZXJzIGFyZSByZWFkLW9ubHkuIFRvIHR3ZWFrIHRob3NlIHBhcmFtZXRlcnMgKHNpZ25hbA0KPiA+
IHZvbHRhZ2UgYW5kIHRlcm1pbmF0aW9uIHJlc2lzdG9ycykgb25lIG5lZWQgdG8gd3JpdGUgdG8g
dGhlIHBhZCBncm91cA0KPiA+IGNvbnRyb2wgcmVnaXN0ZXJzIGZvciB0aGUgd2hvbGUgUkdNSUkg
cGFkIGdyb3VwLiBOYW1lbHkNCj4gPiBJT01VWENfU1dfUEFEX0NUTF9HUlBfRERSX1RZUEVfUkdN
SUkgYW5kDQo+ID4gSU9NVVhDX1NXX1BBRF9DVExfR1JQX1JHTUlJX1RFUk0uIFRoZSBncm91cCBy
ZWdpc3RlcnMgaW4gZ2VuZXJhbA0KPiBhcmUgbm90IGFjY2Vzc2libGUgZnJvbSB0aGUgbGlzdCBp
biBhcmNoL2FybS9ib290L2R0cy9pbXg2ZGwtcGluZnVuYy5oLg0KPiA+DQo+ID4gSSBjb3VsZCBu
b3QgZmluZCBhbnkgb3RoZXIgd2F5IHRvIGNoYW5nZSB0aGUgZ3JvdXAgcmVnaXN0ZXJzIHRoYW4N
Cj4gPiBoYWNraW5nLWluIHNvbWUgbGluZXMgaW50byB0aGUgaW14NnFfaW5pdF9tYWNoaW5lKHZv
aWQpIGZ1bmN0aW9uIGluDQo+ID4gYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2cS5jIHNvdXJj
ZS4gQXMgSSB3b3JrIHRvd2FyZHMgdXBzdHJlYW1pbmcNCj4gPiBteSBib2FyZCB0aGlzIHNob3Vs
ZCBiZSBkb25lIGZyb20gbXkgZGV2aWNlIHRyZWUgb3Igc29sdmVkIGluIHNvbWUNCj4gdW5pdmVy
c2FsIHdheS4NCj4gPg0KPiA+IEFueSBoaW50cyB3aWxsIGJlIG11Y2ggYXBwcmVjaWF0ZWQuDQo+
ID4gTWljaGFsDQo+IA0KPiBJIGZpZ3VyZWQgb3V0IHRoaXMgaXMgbW9yZSAicGluY3RybC1pbXgu
YyIgdGhhbiAiZGV2aWNlLXRyZWUiIHJlbGF0ZWQgc28gSSBhbQ0KPiBraW5kbHkgYWRkaW5nIG1h
aW50YWluZXJzIG9mIHRoYXQgZmlsZSBpbiBob3BlIHNvbWVib2R5IHdpbGwgc2hlZCBzb21lIGxp
Z2h0DQo+IHRvIGl0Lg0KPiANCj4gSSBhbSBkaXZpbmcgZGVlcGVyIGludG8gdGhlIGNvZGUgYW5k
IGl0IHNlZW1zIHRoZXJlIHJlYWxseSBpcyBubyBnZW5lcmljDQo+IG9wdGlvbiB0byBzZXQgdGhl
IGkuTVg2IHBhZCBncm91cCBjb250cm9sIHJlZ2lzdGVycyBmcm9tIGRldmljZSB0cmVlLg0KPiBP
ciBhbSBJIGxvb2tpbmcgYXQgdGhlIHByb2JsZW0gZnJvbSBhIHdyb25nIGFuZ2xlPw0KPiANCg0K
WWVzLCB0aGVyZSdzIGEgZmV3IHNwZWNpYWwgcGFkIGdyb3VwIGN0cmwgcmVnaXN0ZXJzIChlLmcu
IERSQU0gYW5kIFJHTUlJIGZvciBteDZxKQ0Kd2hpY2ggYXJlIG5vdCBhZGRlZCBJbiB0aGUgcGlu
Y3RybCBkcml2ZXIgc3VwcG9ydC4NCg0KPiBIb3cgc2hvdWxkIHdlIGRlYWwgd2l0aCBib2FyZHMg
dGhhdCBuZWVkIHRvIGNvbmZpZ3VyZSBzb21lIHBhZA0KPiBjaGFyYWN0ZXJpc3RpY3MgYXZhaWxh
YmxlIG9ubHkgdGhyb3VnaCB0aGUgcGFkIGdyb3VwIGNvbnRyb2wgcmVnaXN0ZXJzPw0KPiANCg0K
QW5keSwNCkhvdyBkbyB3ZSBoYW5kbGUgaXQgaW50ZXJuYWxseT8NCg0KPiBJIGFsc28gcmFpc2Vk
IHRoaXMgcXVlc3Rpb24gYXQgdGhlIE5YUCBjb21tdW5pdHkgZm9ydW0gWzFdIGFuZCBnZXQgcXVp
dGUNCj4gdW5zYXRpc2Z5aW5nIGFuc3dlciBzbyBmYXIuIEkgd291bGQgbG92ZSB0byBmaW5kL2lt
cGxlbWVudCBhIHByb3BlciBhbmQNCj4gdW5pdmVyc2FsIHNvbHV0aW9uLg0KPiANCg0KVGhlcmUn
cmUgcHJvYmFibHkgdHdvIHdheXMgdG8gZG8gaXQ6DQoxKSBoYW5kbGUgaXQgaW4gZmVjIGRyaXZl
ciBieSBwYXJzaW5nIGEgc3BlY2lmaWMgcHJvcGVydHkNCjIpIEFkZCBhIG5ldyBwYWQgZ3JvdXAg
aW50byBwaW5jdHJsIGRyaXZlciBzdXBwb3J0DQplLmcuDQpNWDZRX1BBRF9DVExfR1JQX1JHTUlJ
X1RFUk0NCk1YNlFfUEFEX0NUTF9HUlBfRERSX1RZUEVfUkdNSUkNCg0KSSBtYXkgcHJlZmVyIHRv
IDIpLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiBUaGFua3MgaW4gYWR2YW5jZSBmb3Ig
eW91ciB0aW1lLA0KPiBNaWNoYWwNCj4gDQo+IFsxXQ0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGY28NCj4gbW11bml0
eS5ueHAuY29tJTJGdGhyZWFkJTJGNDc3NDY0JmRhdGE9MDIlN0MwMSU3Q2Fpc2hlbmcuZG9uZyU0
DQo+IDBueHAuY29tJTdDYTNlNTQ2M2ViMDZhNDdmMTEyMTAwOGQ1ZDA3NjhhMDQlN0M2ODZlYTFk
M2JjMmI0YzZmYTkNCj4gMmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNjY0NDEyOTkxNDE2MjQ5
NSZzZGF0YT14cXRCUzh1WCUyQlN6cQ0KPiA1bTZ0Yk5hTHpDa0I3ZXpnSFNueXU5R1EzSzEzY1c4
JTNEJnJlc2VydmVkPTANCg==
