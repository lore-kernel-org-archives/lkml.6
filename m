Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60917C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2604C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vLVusaK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfARJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:49:49 -0500
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:28896
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfARJts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRl0xQTuu9dX76rJL1qKDryW3r2elznaX/T/8fKZkTk=;
 b=vLVusaK6dyhof0Jkj++JhylU80w2IdKj5fxyM3MgeG3BqTmAzTZ8j9yMAxvBezhCMAWfJhS/U+Fzz+mHEpJSiENZ9gRQSwGYiyRET2/EzUqTz0gsYZ8s+OZk4XeHnFORnapwiaL1uwRXW+N39bdp+jmSbIo3HcBnmT3faD+F5yM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5923.eurprd04.prod.outlook.com (20.178.117.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Fri, 18 Jan 2019 09:49:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 09:49:43 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Topic: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Index: AQHUrwExKd8SdkCETUqu4TDod0IgjqW0vfmAgAAJiQA=
Date:   Fri, 18 Jan 2019 09:49:43 +0000
Message-ID: <AM0PR04MB421158B2E042D623792A296E809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547796918-29790-1-git-send-email-aisheng.dong@nxp.com>
 <25cd3e29-e365-f0d4-65a3-b3af69acd9cd@arm.com>
In-Reply-To: <25cd3e29-e365-f0d4-65a3-b3af69acd9cd@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5923;6:LdH5pZ5pPO5Akf1ttrcKnyqQcMKkXPXGspmnJctmd9FWlHzRhedGnDeJX4i4M4QgpGeZGXak6y4TXOrgZAuRMSrWn02hlTv4uml0uHOUJFLMx57FXcKOJ8WN+BxTuolUnE1AXlCFSpcKsUEA44mlDLP3sObqwwcYLZ/VfORG1k3PIyvTDWmfxZLMgitlpm23CQCtQ0f6R6ZXTZT7WDQIfN9heMy0xTj6cXnOmYGYNRxD7304sRwOl/8/66qkE4NSXRtk2pF5XRdVVK3w8ERTP1/lwwLJ5yMPn3Jtli+XgsQRXvq3ON1Mh7HYOaP/9akvgSYtby5nOvkUjGO0HVVB4UO47MdjWNFvfgvE3/7wWleudFW/Y8e0Ghke/J0SpohFYScjMIvguUC3yP/Z7sk+LUfVUyQPOrlQv4G3U9smyaFxqBPcxzf6SLQRryax7OXYlltKKqqTASZtrK8Al5cF0w==;5:OuJliVmdQqZLU6ki4F8KVl2d2QKWGoJG71zSXnf5felUmQhKCchXu1J1PpGP9FXPJaaelLQArvEId+QTtwdVgnvpO9CcVp4G0y7im/Z4OF9Z0MFxHdTQJS+mMb7I6U+RsYRUXFWxxngSqLKxDkYiwW8zqEkIIoTarA6eolfv4V4ywy7L8t3UcmfCV9sgkgI0QhSdo8D8AYgKbAGmdOKnSw==;7:CgUStssGVkKeqH/1AcQGeQLVLd++noGx1fwS7Yskac1lbJgOauliIgnNipEr5rY8b5I9Qoppe7TMF39k4tbhaF9y6tfY2fAll3pJB0QuG06X0QKl3Cd4z+mgp0q8Dr96Umk9tYDbs0KjQC/easWJJw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 67d2b6b2-3018-41ff-7f1b-08d67d2a4614
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5923;
x-ms-traffictypediagnostic: AM0PR04MB5923:
x-microsoft-antispam-prvs: <AM0PR04MB59236E684086B3A7323B3775809C0@AM0PR04MB5923.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(25786009)(97736004)(99286004)(6246003)(76176011)(256004)(71190400001)(53546011)(14444005)(102836004)(53936002)(9686003)(6506007)(39060400002)(7696005)(4326008)(81156014)(476003)(33656002)(446003)(8936002)(2906002)(8676002)(71200400001)(81166006)(11346002)(2501003)(6436002)(486006)(229853002)(3846002)(110136005)(106356001)(55016002)(44832011)(105586002)(316002)(68736007)(6116002)(54906003)(305945005)(74316002)(186003)(26005)(5660300001)(14454004)(478600001)(7736002)(86362001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5923;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: shxC1lXlmhEGVLv54hod2mLRAv7/vQ1pg53daFiHUgOA5GgnInDAkHzieNs9k4DKGV3pb5GWvtKd0dsp6/1GV0FFn4UGV1F9N0tEuolC9HK2lxNbljs87CK5rfEC4NJblYRHv0pQaWElIfo+kNm7BInmnPnwxY8Ru0Zf1QJ85BgO2t0YdnOViP0nlSVshLwkWLP5q9y7t5sl3fjzRGZcaAFYwjN807UHvO1YT9eRg1ScaycUeQWsk7eQDmWXWkp6JID/nv6PyQSwNb8bAOs7OqRAHIIFrjQbS8iqf9C+3OP3UOwo5+SPLEuiyXGBE4FNdhRoqKiq9mTYiVgZOyZLcgwZnNiiaqecXajrGr24xl9wEtVINuSMkk5jC+xD5fNfs/l1lRAOcdkEUVAt/iv7dbtAi7YebpqCAk9Fw92jiyk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d2b6b2-3018-41ff-7f1b-08d67d2a4614
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 09:49:43.6450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJjIFp5bmdpZXIgW21haWx0bzptYXJjLnp5bmdpZXJAYXJtLmNvbV0NCj4gU2Vu
dDogRnJpZGF5LCBKYW51YXJ5IDE4LCAyMDE5IDU6MTMgUE0NCj4gT24gMTgvMDEvMjAxOSAwNzo0
MSwgQWlzaGVuZyBEb25nIHdyb3RlOg0KPiA+IE1ha2UgR1BDdjIgY29uZmlnIG9wdGlvbiB2aXNp
YmxlLCB0aGVuIHVzZXIgY2FuIHNlbGVjdCBpdCBpbiBkZWZjb25maWcNCj4gPiBmb3IgQVJNdjgg
cGxhdGZvcm1zLg0KPiA+DQo+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPg0KPiA+IENjOiBKYXNvbiBDb29wZXIgPGphc29uQGxha2VkYWVtb24ubmV0Pg0KPiA+IENj
OiBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPg0KPiA+IENjOiBTaGF3biBHdW8g
PHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1
dHJvbml4LmRlPg0KPiA+IENjOiBBbmRyZXkgU21pcm5vdiA8YW5kcmV3LnNtaXJub3ZAZ21haWwu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaXJxY2hpcC9LY29uZmlnIHwgMyArKy0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9LY29uZmlnIGIvZHJpdmVycy9pcnFjaGlwL0tj
b25maWcgaW5kZXgNCj4gPiAzZDFlNjA3Li5lZDA0ZDQ3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvaXJxY2hpcC9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL0tjb25maWcNCj4g
PiBAQCAtMjg5LDcgKzI4OSw4IEBAIGNvbmZpZyBSRU5FU0FTX0g4U19JTlRDDQo+ID4gIAlzZWxl
Y3QgSVJRX0RPTUFJTg0KPiA+DQo+ID4gIGNvbmZpZyBJTVhfR1BDVjINCj4gPiAtCWJvb2wNCj4g
PiArCWJvb2wgImkuTVggR1BDdjIgSVJRIGNoaXAiDQo+ID4gKwlkZXBlbmRzIG9uIEFSQ0hfTVhD
IHx8IChDT01QSUxFX1RFU1QgJiYgT0YpDQo+ID4gIAlzZWxlY3QgSVJRX0RPTUFJTg0KPiA+ICAJ
aGVscA0KPiA+ICAJICBFbmFibGVzIHRoZSB3YWtldXAgSVJRcyBmb3IgSU1YIHBsYXRmb3JtcyB3
aXRoIEdQQ3YyIGJsb2NrDQo+ID4NCj4gDQo+IEhvdyBkb2VzIGl0IGhlbHAgZXhhY3RseT8gSXQg
aXMgcHJldHR5IGRpZmZpY3VsdCBmb3IgYSB1c2VyIHRvIGtub3cgZXhhY3RseSB3aGF0DQo+IHRo
ZXkgbmVlZC4gSSdkIHJhdGhlciBzZWUgaXQgc2VsZWN0ZWQgYnkgQVJDSF9NWEMsIHdoaWNoIG1h
a2VzIGl0DQoNCkFSTTY0IFNvQyBtYWludGFpbmVycyBzdWdnZXN0IG5vdCBhZGQgbW9yZSBkcml2
ZXIgc3BlY2lmaWMgb3B0aW9ucyBleGNlcHQgYW4NCkdlbmVyaWMgQVJDSCBvcHRpb24uDQoNCkFz
IEdQQ3YyIGlzIGFsc28gdXNlZCBpbiBNWDhNUS4gU28gd2UgbWF5IHNlbGVjdCBpdCBpbiBhcm12
OCBkZWZjb25maWcuDQpJZiB0aGlzIG9wdGlvbiBpcyBpbnZpc2libGUsIHdlIGNhbid0IHNlbGVj
dCBpdC4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gdW5hbWJpZ3VvdXMuDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiAJTS4NCj4gLS0NCj4gSmF6eiBpcyBub3QgZGVhZC4gSXQganVzdCBzbWVs
bHMgZnVubnkuLi4NCg==
