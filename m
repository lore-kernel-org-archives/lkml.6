Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF02C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D26206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QRvDsFi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfBWDNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:13:43 -0500
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:41187
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbfBWDNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHsJo6ClWnqHwUUzrncaosEqGslMuDXlU5cEaZNyNQ8=;
 b=QRvDsFi2oF/z4n4dz0d5HsH9eP6iVKvGq15CjS8eoHo+aUd2UFqadczJjPoWpUXxH6mjHs9DLftuZ2kOxOHdGVSOjdQddud9QVi1WLse91vKjWjoEjvZfYFfy24VdMIxI5BBQGVhu6orz0+/kyGNqPwgvNofvxLvNdgorCrjedo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3689.eurprd04.prod.outlook.com (52.134.69.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Sat, 23 Feb 2019 03:13:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 03:13:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Topic: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Index: AQHUypLopgE4RdwU6k2TGErI1f+TZ6XrpOeAgAEOh3CAAAKScA==
Date:   Sat, 23 Feb 2019 03:13:36 +0000
Message-ID: <DB3PR0402MB39169297EDA985F94C0B306DF5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
 <66e1685e5cc3fdcaba6ab55b3d030628c37ef8e2.camel@pengutronix.de>
 <DB3PR0402MB39163B39C2E45C86FA4B1FA8F5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39163B39C2E45C86FA4B1FA8F5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1f83dd6-06e4-43cd-b87e-08d6993ce6ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3689;
x-ms-traffictypediagnostic: DB3PR0402MB3689:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM2ODk7MjM6dlVROGQzY2Q3amhUbm82TkpZb2dWMFBI?=
 =?utf-8?B?OStNLy9TcjJYQnd4K1dRREZpN0FMNkZENURWQmw0TmFIeW5xUThqOFVGcFRL?=
 =?utf-8?B?djlGNEhHL3RiSkUwcWRndTl0bzhtcnJXRVJwbFFLcFA0OGZqLzc3S0dncEkz?=
 =?utf-8?B?dW1KUjc5UzZ6RVJVN0k5YjFvUWdReDFFZXgzRTNnMmdBRk43ZUlYRWg0QUF3?=
 =?utf-8?B?SG0waVIreFNWWEw4WVRjUjBlR0Y1bFZ5Wno3Yll4MzI1cXRSYVlTQ2xHZ3d6?=
 =?utf-8?B?c1VDbmU5NEsrQUh5bzVsTjQrVXJ5RW4yVGZMK0ZMVzlCYzJHNmNYc2xMVS9B?=
 =?utf-8?B?alR1bDgvczZrSVlKUzlrdGJsa1MyNmxyTmkrSE5scHFneDFueDA2eHFtd2p3?=
 =?utf-8?B?MWNFRUVSQVZvdk1TdjdEazA0TTJpd1JjblUzWU9laEVEemxtQUtJRi9yakVE?=
 =?utf-8?B?V0pmWlBoWW1jc0JlRHdLdk1EcHk3MzFpSHVkRlZ6NzUzNCs3RnltRUx4dWcz?=
 =?utf-8?B?bERaQ1lBaTBrbDBtOTBsajBNKzVjREhta0NMQzljekc4T01hT1A0NVI2VXJy?=
 =?utf-8?B?Wjlhb3RWa1p5dTlUQlpIV3d4WVFjRW5NQTdJU1k5em5peGMrS09FSk1HeDRE?=
 =?utf-8?B?cTZDb3dzRndsU3VpdDhQZjFsSUQ3aU9rbjRwUFBBa2pyOGVXRW1LWm9kU0VK?=
 =?utf-8?B?RGtnajNZbCtxOVhaaHFHZFdkSzBlbEhzWXA0VlB1L280R3RCWEZ0cjh6eEVQ?=
 =?utf-8?B?cWYzRUszVzg0N04wMTVka1JxazZVQVFPRTVFalU3VDJCWlV5ektDbjFlb3Zt?=
 =?utf-8?B?Mm1JbGZ5di9nY0dSSW5OZS9DVWxhREZjbndGVVIxd1pvYW9Pc3ZUUDdINDNN?=
 =?utf-8?B?c284dG5zbkVpZnVRMXlLb1FxZm5Ha1h6NktXNnFXeDF6bWJRZ2ZRTzZ3TnZk?=
 =?utf-8?B?SzM0c1c2cVZHR1YwY3lvTCs2bW5WQ1M1V1V0MTJnQnp5SkpWWnpzbkpKQmxI?=
 =?utf-8?B?WHRrbnJ3UGlVUi9TdWZQQkRHdVpteUpuN1V2TTFPb0VUZjRzK2N6VVFlT1BR?=
 =?utf-8?B?bGRlT1EwdzFTaDZHOWNpbHpWbE8vcDV5N2NNS0lMamV5emR4bUlzOFpXLzV3?=
 =?utf-8?B?b25LdnRua3VvamEwMHpaM3Z1VXVkaTg1dlJzRlF4b1NRYVN6NndnUUt6Z1ln?=
 =?utf-8?B?NlgxbG1lOFM0VXg5WTZpYmc4b2FKTXNzRjV2dmZCMWgxTlZPQVR0ZW1BNnVI?=
 =?utf-8?B?TTc2YzVGOHBmTGhMaFJIUnR4T092ek5lVWVicFhSYUFJUTgwdFZ0SmEvZnFx?=
 =?utf-8?B?b1VrVndkVzlKZU84OW1iYXZQOFBvdWI0MmIyNUZlUVpyNHdpK1JobFBudlYz?=
 =?utf-8?B?UVBUTmRUMk1Ba0w0VjVRQTNxcFJadHUzRTEzMTM0N20yWkJNelNFVnlQYWZL?=
 =?utf-8?B?RVlHdG5wSTh6THpZTnJIWEJMWkF6cTBSUDFvWUowcGVEWjVxZFNpajIvUncz?=
 =?utf-8?B?UUlrZ0cySlNIQVJHOE1uMWd1eWsvbHNqVmJaeWQvT1VwUUlSTWdOOFBodHUv?=
 =?utf-8?B?OVk5N29HaUZNTndqQ2RNN2pvUmlocUVBdXFYdUM4MEFmMkxHdGFUZGNjYkwr?=
 =?utf-8?B?ZlRsNCtSYmtpTDlZbEpKQVduOUh0cUw5SHlwTHZIdUJZVjRmYy8wRWg3cXpC?=
 =?utf-8?B?TXlhZ0pYRDVOQm5kKzJtU2dmK25YZUlyc1pNQ3JXWkFjVGZYRTk5cm0zNmNC?=
 =?utf-8?B?MndmNU1keHowMFBOM3V1STB6K3lyc2pTc0FRRG1KeExjUEg1b1hOK1lZNmxh?=
 =?utf-8?B?OXVlZFdoZGw2RTc5NWhpUVp4SkZHcWFmRHZOMkhBSWhDWHNkL0Z5U2VvTGdJ?=
 =?utf-8?B?VE5jc3IzcEpLcFlYQVZnQXlvZ1kveGdNNW13WDNMbFpndkxpc3pHN0JYTWtl?=
 =?utf-8?B?K1U4djBEOFd4K1E9PQ==?=
x-microsoft-antispam-prvs: <DB3PR0402MB36890D8342811E243F8A4E08F5780@DB3PR0402MB3689.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(136003)(13464003)(199004)(189003)(53546011)(76176011)(6506007)(186003)(106356001)(11346002)(102836004)(316002)(26005)(2501003)(446003)(99286004)(68736007)(110136005)(229853002)(2940100002)(105586002)(7416002)(53936002)(9686003)(6436002)(97736004)(6246003)(4326008)(2906002)(55016002)(476003)(7696005)(44832011)(71190400001)(7736002)(71200400001)(486006)(33656002)(5660300002)(81156014)(305945005)(93156006)(8676002)(25786009)(478600001)(81166006)(86362001)(256004)(74316002)(8936002)(66066001)(6116002)(3846002)(14454004)(2201001)(52536013)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3689;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 78gQS3aE6JL6xWVMT35nWwKYuw8yI6eje7GdZT9DEooFnoCpnPTaao9KeJh97fwBoLWNBDQkvXAQQi3EXw4ErbigwiGvCS3cT7tLTl1uACb3KB0utV3blt6EwggBtVLqHwDrD+HxV0u43C7Wn90Eb7zeVqUmQLJFKUYbCfCV12oCVZOxOk0hsrAieh7kKiGiz6ANJ4Fo50Sh7H1K2MQTeLOX9m4zX4csVqTRXpPuvmhTnkB9HKIyUmeAn+k2o8HluvG1pD3z5HXty834sNqWJskxNr7VDqaeoi/Wy0/4hBUdpEsGXUUPuqEN7aedCLi9AaPoQgdsEh35ESKXXD4WRI/5Cp/lhvcnlXCnQKPP3rROLoXiTjt8LLJMU5WdWTOs6pzbrzGYAzmFMC+6kvAsXfEVonGHnQhqajy6hQnIlqo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f83dd6-06e4-43cd-b87e-08d6993ce6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 03:13:36.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQW5zb24gSHVhbmcNCj4gU2VudDogMjAxOeW5tDLmnIgyM+aXpSAxMTow
NA0KPiBUbzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+OyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGtlcm5lbC5vcmc7
IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54cC5jb20+OyBjY2Fpb25lQGJheWxpYnJlLmNvbTsNCj4g
YWd4QHNpZ3hjcHUub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0K
PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGlu
dXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8zXSBjbGs6IGlteDhtcTog
aW5pdGlhbGl6ZSBjbG9jayB0cmVlIGVhcmxpZXINCj4gDQo+IEhpLCBMdWNhcw0KPiANCj4gQmVz
dCBSZWdhcmRzIQ0KPiBBbnNvbiBIdWFuZw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IEx1Y2FzIFN0YWNoIFttYWlsdG86bC5zdGFjaEBwZW5ndXRyb25peC5k
ZV0NCj4gPiBTZW50OiAyMDE55bm0MuaciDIy5pelIDE4OjU1DQo+ID4gVG86IEFuc29uIEh1YW5n
IDxhbnNvbi5odWFuZ0BueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+IG1hcmsucnV0
bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
Ow0KPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBtdHVycXVl
dHRlQGJheWxpYnJlLmNvbTsNCj4gPiBzYm95ZEBrZXJuZWwub3JnOyBBYmVsIFZlc2EgPGFiZWwu
dmVzYUBueHAuY29tPjsNCj4gY2NhaW9uZUBiYXlsaWJyZS5jb207DQo+ID4gYWd4QHNpZ3hjcHUu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiA+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4gPiBjbGtAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGNsazogaW14OG1xOiBpbml0
aWFsaXplIGNsb2NrIHRyZWUgZWFybGllcg0KPiA+DQo+ID4gQW0gRnJlaXRhZywgZGVuIDIyLjAy
LjIwMTksIDA5OjQyICswMDAwIHNjaHJpZWIgQW5zb24gSHVhbmc6DQo+ID4gPiBDdXJyZW50bHkg
b24gaS5NWDhNUSBwbGF0Zm9ybSwgY2xvY2sgZHJpdmVyIGlzIHByb2JlZCBsYXRlciB0aGFuDQo+
ID4gPiBHUElPIGRyaXZlciwgYW5kIEdQSU8gZHJpdmVyIGRvZXMgTk9UIGhhdmUgZGVmZXIgcHJv
YmUgbWVjaGFuaXNtDQo+ID4gPiBzaW5jZSB0aGUgR1BJTyBjbG9jayBpcyBvcHRpb25hbCwNCj4g
Pg0KPiA+IFNvIHRoaXMgaXMgd2hhdCBzaG91bGQgYmUgZml4ZWQuIElmIHRoZXJlIGlzIGEgY2xv
Y2sgcmVmZXJlbmNlIGluIHRoZQ0KPiA+IERULCBoYXZpbmcgdGhlIGNsb2NrIGRyaXZlciByZWFk
eSBpcyBub3Qgb3B0aW9uYWwuIE9wdGlvbmFsIHRvIHRoZQ0KPiA+IEdQSU8gZHJpdmVyIGp1c3Qg
bWVhbnMgaXQgd29uJ3QgZmFpbCBpZiB0aGVyZSBpcyBubyBjbG9jayByZWZlcmVuY2UgYXQgYWxs
Lg0KPiA+IElmIHRoZXJlIGlzIGFuZCB0aGUgY2xvY2sgcHJvdmlkZXIgaXMgbm90IHlldCB0aGVy
ZSwgaXQgbmVlZHMgdG8gZG8gYQ0KPiA+IFBST0JFX0RFRkVSLg0KPiA+DQo+ID4gU28gdGhhdCdz
IGEgTkFDSyBvbiB0aGlzIHBhdGNoLg0KPiANCj4gT0ssIEkgc2VlLiBUaGVuIEkgd2lsbCBkbyBh
IHBhdGNoIGZvciBHUElPIGRyaXZlciwgYW5kIEkganVzdCBjaGVjayBvdGhlciBkcml2ZXJzLA0K
PiBsb29rcyBsaWtlIGlteDIgd2F0Y2hkb2cgZHJpdmVyIGFsc28gaGFzIHNpbWlsYXIgaXNzdWUs
IEkgd2lsbCBkbyBhIHBhdGNoIHRvby4NCg0KSnVzdCBkb3VibGUgY2hlY2sgdGhlIHdhdGNoIGRv
ZyBkcml2ZXIsIGl0cyBjbG9jayBpcyBOT1Qgb3B0aW9uYWwsIGFuZCBqdXN0IHJldHVybg0KdGhl
IGVycm9yIHZhbHVlLCBzbyBpdCBzaG91bGQgYmUgT0ssIHNvcnJ5IGZvciB0aGUgbm9pc2UuDQoN
CkFuc29uLg0KDQo+IA0KPiBUaGFua3MsDQo+IEFuc29uLg0KPiANCj4gPg0KPiA+IFJlZ2FyZHMs
DQo+ID4gTHVjYXMNCj4gPg0KPiA+ID4gc29tZSBwbGF0Zm9ybXMgaGF2ZSBHUElPIGNsb2NrcyBh
bmQgc29tZSBhcmUgTk9ULiBTbyBpdCBpcyBhbiBpc3N1ZQ0KPiA+ID4gdGhhdCBvbiBpLk1YOE1R
IHBsYXRmb3JtLCB0aGVyZSBhcmUgR1BJTyBjbG9ja3MgZGVmaW5lZCwgYnV0IGR1ZSB0bw0KPiA+
ID4gY2xvY2sgdHJlZSBpcyBOT1QgcmVhZHkgZHVyaW5nIEdQSU8gZHJpdmVyIHByb2JlLCB0aGUg
R1BJTyBjbG9jaw0KPiA+ID4gbWFuYWdlbWVudCB3aWxsIGZhaWwgYW5kIGNhdXNlIHN5c3RlbSBo
YW5nIGlmIEdQSU8gY2xvY2tzIGFyZSBPRkYgYnkNCj4gPiA+IGRlZmF1bHQuDQo+ID4gPg0KPiA+
ID4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBpLk1YOE1RIGNsb2NrIHRyZWUgaW5pdGlhbGl6YXRp
b24gdXNpbmcNCj4gPiA+IENMS19PRl9ERUNMQVJFIGluc3RlYWQgb2YgcGxhdGZvcm0gZHJpdmVy
IG1vZGVsIHRvIG1ha2UgY2xvY2sgdHJlZQ0KPiA+ID4gcmVhZHkgZWFybGllciB0aGFuIEdQSU8g
ZHJpdmVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4
bXEuYyB8IDMzICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jIGIvZHJpdmVycy9jbGsv
aW14L2Nsay0NCj4gPiA+IGlteDhtcS5jIGluZGV4IDI2YjU3ZjQuLjJkZjE1NzUgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jDQo+ID4gPiBAQCAtMjY5LDEwICsyNjksOSBAQCBzdGF0
aWMgY29uc3QgY2hhciAqaW14OG1xX2Nsa28yX3NlbHNbXSA9DQo+ID4gPiB7Im9zY18yNW0iLCAi
c3lzMl9wbGxfMjAwbSIsICJzeXMxX3BsbF8NCj4gPiA+DQo+ID4gPiAgc3RhdGljIHN0cnVjdCBj
bGtfb25lY2VsbF9kYXRhIGNsa19kYXRhOw0KPiA+ID4NCj4gPiA+IC1zdGF0aWMgaW50IGlteDht
cV9jbG9ja3NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ICtzdGF0
aWMgdm9pZCBfX2luaXQgaW14OG1xX2Nsb2Nrc19pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAp
DQo+ID4gPiAgew0KPiA+ID4gLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+
ID4gLQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiA+ID4gKwlzdHJ1
Y3QgZGV2aWNlX25vZGUgKmFuYXRvcF9ucDsNCj4gPiA+ICAJdm9pZCBfX2lvbWVtICpiYXNlOw0K
PiA+ID4gIAlpbnQgZXJyOw0KPiA+ID4gIAlpbnQgaTsNCj4gPiA+IEBAIC0yODYsMTAgKzI4NSwx
MCBAQCBzdGF0aWMgaW50IGlteDhtcV9jbG9ja3NfcHJvYmUoc3RydWN0DQo+ID4gPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgCWNsa3NbSU1YOE1RX0NMS19FWFQzXSA9IG9mX2Nsa19n
ZXRfYnlfbmFtZShucCwgImNsa19leHQzIik7DQo+ID4gPiAgCWNsa3NbSU1YOE1RX0NMS19FWFQ0
XSA9IG9mX2Nsa19nZXRfYnlfbmFtZShucCwgImNsa19leHQ0Iik7DQo+ID4gPg0KPiA+ID4gLQlu
cCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wsaW14OG1xLWFuYXRv
cCIpOw0KPiA+ID4gLQliYXNlID0gb2ZfaW9tYXAobnAsIDApOw0KPiA+ID4gKwlhbmF0b3BfbnAg
PSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiZnNsLGlteDhtcS0NCj4gPiA+
IGFuYXRvcCIpOw0KPiA+ID4gKwliYXNlID0gb2ZfaW9tYXAoYW5hdG9wX25wLCAwKTsNCj4gPiA+
ICAJaWYgKFdBUk5fT04oIWJhc2UpKQ0KPiA+ID4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiAr
CQlyZXR1cm47DQo+ID4gPg0KPiA+ID4gIAljbGtzW0lNWDhNUV9BUk1fUExMX1JFRl9TRUxdID0g
aW14X2Nsa19tdXgoImFybV9wbGxfcmVmX3NlbCIsDQo+ID4gYmFzZSArDQo+ID4gPiAweDI4LCAx
NiwgMiwgcGxsX3JlZl9zZWxzLCBBUlJBWV9TSVpFKHBsbF9yZWZfc2VscykpOw0KPiA+ID4gIAlj
bGtzW0lNWDhNUV9HUFVfUExMX1JFRl9TRUxdID0gaW14X2Nsa19tdXgoImdwdV9wbGxfcmVmX3Nl
bCIsDQo+ID4gYmFzZSArDQo+ID4gPiAweDE4LCAxNiwgMiwgcGxsX3JlZl9zZWxzLCBBUlJBWV9T
SVpFKHBsbF9yZWZfc2VscykpOyBAQCAtMzg5LDEwDQo+ID4gPiArMzg4LDkgQEAgc3RhdGljIGlu
dCBpbXg4bXFfY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiA+ICsqcGRl
dikNCj4gPiA+ICAJY2xrc1tJTVg4TVFfU1lTMl9QTExfNTAwTV0gPQ0KPiA+ID4gaW14X2Nsa19m
aXhlZF9mYWN0b3IoInN5czJfcGxsXzUwMG0iLCAic3lzMl9wbGxfb3V0IiwgMSwgMik7DQo+ID4g
PiAgCWNsa3NbSU1YOE1RX1NZUzJfUExMXzEwMDBNXSA9DQo+ID4gPiBpbXhfY2xrX2ZpeGVkX2Zh
Y3Rvcigic3lzMl9wbGxfMTAwMG0iLCAic3lzMl9wbGxfb3V0IiwgMSwgMSk7DQo+ID4gPg0KPiA+
ID4gLQlucCA9IGRldi0+b2Zfbm9kZTsNCj4gPiA+ICAJYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsN
Cj4gPiA+ICAJaWYgKFdBUk5fT04oIWJhc2UpKQ0KPiA+ID4gLQkJcmV0dXJuIC1FTk9NRU07DQo+
ID4gPiArCQlyZXR1cm47DQo+ID4gPg0KPiA+ID4gIAkvKiBDT1JFICovDQo+ID4gPiAgCWNsa3Nb
SU1YOE1RX0NMS19BNTNfU1JDXSA9IGlteF9jbGtfbXV4MigiYXJtX2E1M19zcmMiLCBiYXNlICsN
Cj4gPiA+IDB4ODAwMCwgMjQsIDMsIGlteDhtcV9hNTNfc2VscywgQVJSQVlfU0laRShpbXg4bXFf
YTUzX3NlbHMpKTsgQEANCj4gPiA+IC01NjgsMjIgKzU2Niw1IEBAIHN0YXRpYyBpbnQgaW14OG1x
X2Nsb2Nrc19wcm9iZShzdHJ1Y3QNCj4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+
DQo+ID4gPiAgCWVyciA9IG9mX2Nsa19hZGRfcHJvdmlkZXIobnAsIG9mX2Nsa19zcmNfb25lY2Vs
bF9nZXQsICZjbGtfZGF0YSk7DQo+ID4gPiAgCVdBUk5fT04oZXJyKTsNCj4gPiA+IC0NCj4gPiA+
IC0JcmV0dXJuIGVycjsNCj4gPiA+ICB9DQo+ID4gPiAtDQo+ID4gPiAtc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgaW14OG1xX2Nsa19vZl9tYXRjaFtdID0gew0KPiA+ID4gLQl7IC5j
b21wYXRpYmxlID0gImZzbCxpbXg4bXEtY2NtIiB9LA0KPiA+ID4gLQl7IC8qIFNlbnRpbmVsICov
IH0sDQo+ID4gPiAtfTsNCj4gPiA+IC1NT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXg4bXFfY2xr
X29mX21hdGNoKTsNCj4gPiA+IC0NCj4gPiA+IC0NCj4gPiA+IC1zdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciBpbXg4bXFfY2xrX2RyaXZlciA9IHsNCj4gPiA+IC0JLnByb2JlID0gaW14OG1x
X2Nsb2Nrc19wcm9iZSwNCj4gPiA+IC0JLmRyaXZlciA9IHsNCj4gPiA+IC0JCS5uYW1lID0gImlt
eDhtcS1jY20iLA0KPiA+ID4gLQkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGlteDht
cV9jbGtfb2ZfbWF0Y2gpLA0KPiA+ID4gLQl9LA0KPiA+ID4gLX07DQo+ID4gPiAtbW9kdWxlX3Bs
YXRmb3JtX2RyaXZlcihpbXg4bXFfY2xrX2RyaXZlcik7DQo+ID4gPiArQ0xLX09GX0RFQ0xBUkUo
aW14OG1xLCAiZnNsLGlteDhtcS1jY20iLCBpbXg4bXFfY2xvY2tzX2luaXQpOw0KDQo=
