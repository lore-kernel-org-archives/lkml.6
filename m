Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB66C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A1C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kaWPi8VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfARJqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:46:42 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:56587
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfARJql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsEUAB7JwjIavoXB2iwni60rmnTFbLZbZMCqRi8mjpQ=;
 b=kaWPi8VWW4M8GDzK77Bc069Lja9F63q/lhz/9XF/f6o+VqcB3zLFa578aIWxsjqypwsCs5GfjDUykLi38F9aHEKbiV+GskeirHMerwsws5a5628vjhKa53JnFCdjfNcmSbMO0TFVIeiWl7acVSqNnvyZsgSc3QTN+v0Bv/S9oKk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5971.eurprd04.prod.outlook.com (20.178.113.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Fri, 18 Jan 2019 09:46:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 09:46:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Topic: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Index: AQHUrwLwJbVcVt8a/UCLFkmrL3vOD6W0tw+AgAAOR4CAAAGp8A==
Date:   Fri, 18 Jan 2019 09:46:37 +0000
Message-ID: <AM0PR04MB42114D5B25B23C0D7FFF95BA809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
 <1547801291.2626.3.camel@pengutronix.de>
 <45c7e5b6-26bb-81b1-093b-96312a1788ec@arm.com>
In-Reply-To: <45c7e5b6-26bb-81b1-093b-96312a1788ec@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5971;6:yOXMgw8oaBRhWb7g9CRd6mSvFjsofTp7oVp2U9s9bk1hxxjSt9G/leDAdn7wRy4bFxvVfu+64/COIDy9hxELcuCtXXZU63n/PqsG0iBnDatqEgdrECz/eRJICB0tTKgBth4T+bonQsisQ8zDlzKHI+o8tZRnwvDyy7EuZV8AO2Ymv6BkRxJtxxI+kbN39S68iPRE/pK1pF2pE2waSm3aQV49vwLLCu22+DudcRdPIXBQin9Xyp0AakojA4ZAfKazxyw1JeQICiELZf3POzPo3QTyAnNNMuenrskPPnnabg81S+9BuIPM8G5+Of7OcUnNMFwj5wQP7DZAfy1rAN71+8/MH4H13m1jhnCPObax9oKXD4LCIvoMXTs3tjl52h2+aNNkGxAI+B409qe4+k1TvRUYoYySwlZDvKi1Q50xPBpNjJ3Bp4nVFmZjHAR6dQCthMPjUPeuCQY116KgVB9vLQ==;5:6OP+oY8E8oVQ5VZ4SFvU6JZxlLRIMJ2fIrX7aBuDT3vsKIClvAAM5DYBLHTVRbk1r36zkWQNDyIldHXAc3h0tCUDtzsr57/fasAdKF0qZ+KVGgPgIlEF/t/7e2sythZeacUEm1FSDw8BYbE/bZN6hSDcb+gGtGxg1y0T1eaklfy5vj2jBYbVqaWcB2dSNKLZnQq/kcApVtDuxvNXRFkP3w==;7:coU+URfxdQau70RQQL1kQcqRBxvcVylkwnA7V43DStU/vc0cFAiluvZYLYGkU0DZoka9rGJgipyXMFzDtXIKLmRFWO5w6FKA+Hxr3rbY52i9beak4HIPuw6yXo5ONQD7S/xcvFx6fC6pkCUw+WmkIg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 542cf225-935b-431c-88ce-08d67d29d762
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5971;
x-ms-traffictypediagnostic: AM0PR04MB5971:
x-microsoft-antispam-prvs: <AM0PR04MB59710DD7ABD06A06FA616C63809C0@AM0PR04MB5971.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(3846002)(102836004)(6506007)(8676002)(2906002)(81166006)(81156014)(76176011)(7736002)(305945005)(6116002)(7696005)(54906003)(33656002)(93886005)(110136005)(68736007)(4326008)(6246003)(316002)(14454004)(8936002)(71190400001)(6436002)(25786009)(71200400001)(74316002)(9686003)(256004)(105586002)(229853002)(55016002)(106356001)(6346003)(53936002)(2501003)(14444005)(99286004)(66066001)(53546011)(26005)(446003)(478600001)(11346002)(86362001)(97736004)(44832011)(186003)(486006)(476003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5971;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: chYdcPe/Uq/aAAnx7OeFoFpRlkXzzRIFQPouJi5oEYRmGRjCvUzD6D2eo3fTBPurtADkcrEGI4xmU2fRInHm53dJyj+NnicGOg9s+TimAcG+hU7fCRM6mb847YKV6xwZSQRHXRh/ueHR0oxRBVMB8epu09HqArsJ/APXaadRui6rvSn9M4WV1c6LVrKVFQi0sfoGuiHQaKzq2fJRPbOzEt9Lc5AF1J0/eakI8Wm2taz7tIXeROgZLDAXC2GqaJZopMq7NRnFUeEDm8rjHJvf2a0hPbMqq1w5wS4icrUzSBhXuMjGLi8Frc+jtPuz9SMsV0RQtePKk7tnG+/aYEQyV00kuPiHgIH86451rsfxbw8cv8h55MYKA4t3oWC2Gqa2Go7EzqgbL2WkTwE+FGu17gmx7fxOPbporgcix8CKl8A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542cf225-935b-431c-88ce-08d67d29d762
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 09:46:37.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5971
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJjIFp5bmdpZXIgW21haWx0bzptYXJjLnp5bmdpZXJAYXJtLmNvbV0NCj4gU2Vu
dDogRnJpZGF5LCBKYW51YXJ5IDE4LCAyMDE5IDU6MzkgUE0NCj4gT24gMTgvMDEvMjAxOSAwODo0
OCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+ID4gQW0gRnJlaXRhZywgZGVuIDE4LjAxLjIwMTksIDA3
OjUzICswMDAwIHNjaHJpZWIgQWlzaGVuZyBEb25nOg0KPiA+PiBOb3QgYWxsIDY0IGludGVycnVw
dHMgbWF5IGJlIHVzZWQgaW4gb25lIGdyb3VwLiBlLmcuIG1vc3QgaXJxc3RlZXIgaW4NCj4gPj4g
aW14OHF4cCBhbmQgaW14OHFtIHN1YnN5c3RlbXMgc3VwcG9ydHMgb25seSAzMiBpbnRlcnJ1cHRz
Lg0KPiA+Pg0KPiA+PiBBcyB0aGUgSVAgaW50ZWdyYXRpb24gcGFyYW1ldGVycyBhcmUgQ2hhbm5l
bCBudW1iZXIgYW5kIGludGVycnVwdHMNCj4gPj4gbnVtYmVyLCBsZXQncyB1c2UgZnNsLGlycXMt
cGVyLWNoYW4gdG8gcmVwcmVzZW50cyBob3cgbWFueSBpbnRlcnJ1cHRzDQo+ID4+IHN1cHBvcnRl
ZCBieSB0aGlzIGlycXN0ZWVyIGNoYW5uZWwuDQo+ID4NCj4gPiBTb3JyeSwgYnV0IHRvdGFsIE5B
Q0suIEkndmUgZ290IHRvIGdyZWF0IGxlbmd0aHMgd2l0aCBkdW1waW5nIHRoZQ0KPiA+IGFjdHVh
bGx5IGltcGxlbWVudGVkIHJlZ2lzdGVyIGxheW91dCBvbiBpLk1YOE0gYW5kIEFGQUlDUyB0aGUg
SVJRcyBhcmUNCj4gPiBhbHdheXMgbWFuYWdlZCBpbiBncm91cHMgb2YgNjQgSVJRcywgZXZlbiBp
ZiBsZXNzIHRoYW4gdGhhdCBhcmUNCj4gPiBjb25uZWN0ZWQgYXMgaW5wdXQgSVJRcy4gVGhpcyBp
cyB3aGF0IHRoZSBhY3R1YWxseSBwcmVzZW50IHJlZ2lzdGVyDQo+ID4gc2V0IG9uIGkuTVg4TSB0
ZWxscyB1cy4NCj4gDQo+IEFsc28sIEknZCByZWFsbHkgbGlrZSB0aGUgRFQgYmluZGluZ3Mgbm90
IHRvIGNoYW5nZSBhdCBldmVyeSByZWxlYXNlLiBTbyB3aGF0ZXZlcg0KPiBjaGFuZ2UgKGlmIGFu
eSkgaGFzIHRvIGJlIGRvbmUgZm9yIHRoaXMgZHJpdmVyIHRvIHN1cHBvcnQgZXhpc3RpbmcgSFcs
IHBsZWFzZQ0KPiBtYWtlIHN1cmUgdGhhdCB0aGUgRFQgYmluZGluZ3MgYXJlIGtlcHQgYXMgc3Rh
YmxlIGFzIHBvc3NpYmxlLg0KPiANCg0KU29ycnkgSSBzaG91bGQgY2xhcmlmeSBpdCBhIGJpdC4N
ClRoZXJlJ3Mgc3RpbGwgbm8gdXNlcnMgaW4gRGV2aWNldHJlZS4NClNvIEkgZ3Vlc3Mgd2UgY2Fu
IHVwZGF0ZSBpdCwgcmlnaHQ/IE9yIG5vdD8NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4g
VGhhbmtzLA0KPiANCj4gCU0uDQo+IC0tDQo+IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21l
bGxzIGZ1bm55Li4uDQo=
