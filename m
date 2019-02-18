Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D144C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F138D217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="21dfvSC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfBRK7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:59:40 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:8300 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbfBRK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:59:38 -0500
X-IronPort-AV: E=Sophos;i="5.58,384,1544511600"; 
   d="scan'208";a="24028582"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 03:59:37 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 03:59:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LE0r+aigKfTcp6Da4algoURDktudvEIdqtTA/q/q9w=;
 b=21dfvSC/0b6j9Ev6LURQnTObSicrkDV0SvyHRMzuxmXtGIdwGxw/EjBsgIKRsNwY8GEaeQvhmysTixzUFgky+hq9JoQk/FaWpZVvT2YsPO7EensOiqEb5WMmcvnRj2bktu2vq0UWEkBvNLO9+PRwewZ5ma6qrNFsXWGQD/F8YMI=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1279.namprd11.prod.outlook.com (10.169.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 10:59:35 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 10:59:35 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/3] power: reset: at91-poweroff: add support for SAM9X60
Thread-Topic: [PATCH 2/3] power: reset: at91-poweroff: add support for SAM9X60
Thread-Index: AQHUx3kI6ahwvj6khkqpmWiuSd93HA==
Date:   Mon, 18 Feb 2019 10:59:35 +0000
Message-ID: <861b5292-5b2c-5d51-150f-f319b7f433c9@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-3-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-3-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0383.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::35) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa6db77-f67f-4752-f71f-08d695902aea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1279;
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMjc5OzIzOm1USmhPYU1KUWdMZ3lZazVKakMwZHRtTnNs?=
 =?utf-8?B?Y0F1Z2hnZG5PdTFSQkdVaFZXTlFoVm95bkVVeGhkVzQ5R0dnak1vK0FpVnRs?=
 =?utf-8?B?dmQvb2FybFgyU2Y0WVVGcDlKV0NRcUovUjd0bTVva0FrVEdDV0JsWTIrWmRU?=
 =?utf-8?B?cTBuM2t6WXA1WWRSTkpVcm03ZzRiYStSTzc2aEhKcGV0TDA1NkMvL3kxQlZu?=
 =?utf-8?B?OWphV0JTSWUvU1ZDUGt2clMwNE0wTzNIdTlMM1Z3ZUFFZWRYODR3ODRxSUd0?=
 =?utf-8?B?Z3g5Zml5bXI4aFRlR21wcGtBUkE0OE9aZ29HMTRTTFlQVHROamFrTENjazNX?=
 =?utf-8?B?N3pHM3NhZzBhcUtUT0cxSVI2RFhiaXh4RjdBWWlsenBIaGVxcEVqZFNNc2I1?=
 =?utf-8?B?a1VJS2xScmtrT0xYdmRtVllTeTNXaFNCa1hxY2ttWnZTaEpmb2ZrVWcyQzEr?=
 =?utf-8?B?VXFEZ2NvSk9iNjV4NDZ0YzRXcUZqUXg4ODRBaTQxdWxuZFUyZXFmUFQ3NTBt?=
 =?utf-8?B?L2QzVmVJLzZ1c2w3NGpsYm9GL1FZR3JzaExEb2xoaDFnVWp2MVRiQnoydU9G?=
 =?utf-8?B?VmRaN3NORktCblYwTDRGSThjUmNEOEdTYThJU3p5M3hZcGxOelRSMzlaYk5t?=
 =?utf-8?B?ZTFTK1lmeDdvZ3BnOUJQc2Y2VjIrbE9jRCs4RXo2RHZaZmNjR2JQcmlRaG4r?=
 =?utf-8?B?UWFZQjhIRzJtM3FWQmtGaGZUKzZTQzhmSlZFZXE4eG1IN01pTENwTnVhWjlw?=
 =?utf-8?B?VU5oaEExajlrVFRFMEJSOWJFNW5SZXJSU3F5QllNVHlCYW5HU1FCaERDQUxu?=
 =?utf-8?B?Rkh6bE1zSGh6Njc2ODV2ZWVtK3pjYnBMbXRmZW9qUmRuMDR2bytUd1h0dTRF?=
 =?utf-8?B?Nk0wMFliR0pCUWhDQjBJQmgwa3NRRTVLRG5tay9sQzUwSnVrN3F4Tk1mbS9W?=
 =?utf-8?B?NG9aR1RYM1d0QUJ0L1ZzMndBK1JBSFFubnFxU2xjZzNCVFpxOFQySkFJVmlj?=
 =?utf-8?B?Z3o5OVh6dHRoeTlib3VxSEJ4b3JJQTdnRkgzaEVnMUY0ZjB5SnhjT3BjaE52?=
 =?utf-8?B?RmtGOCs5YXZmUU5NbG1jcEJEcXVXNjRySVZCYmpQNWtLZzZzNHRla2lRODhL?=
 =?utf-8?B?dEQ4cDdvTDd6YlJMenRjQnVHd2pWNC91ZFZTakMxWTRZMHYxWlNUMk5haFJ5?=
 =?utf-8?B?dkVicEhwek9HUHBDNVlTc3lrVG0xWkl2bTNNWkkvSkZJQ054aDUxK0htU1U0?=
 =?utf-8?B?MUx3Y1RyV1NNUDJ5cW1ZNUVWbk8rbFhENWVZczBMandQK1RCby90Z0J2K2hv?=
 =?utf-8?B?WGhUd3o5WnBZRktCd1ByMUZsWkRJbSt2TndJbGhiNDZYNlpzZ1JtMnVVRUtS?=
 =?utf-8?B?YVJHc29QZnVKSlNPeEVzRE41Z2pNU0pEZFNiOUNoZVV4elJPRlBRbmVuT1Ur?=
 =?utf-8?B?MVdQTHdWREd1OTNiZXpGTTU5cGhwMW9VMmxWblI3L3ZORU80ZmN1OGMwcTEy?=
 =?utf-8?B?UFE1UXdOdUpCZytOOEZHMWwwN1BUbHBudkpQNTBPTkR5dHpBNi9QWlZySlQx?=
 =?utf-8?B?bHBaWUFlZU9DSFZaQjFoWms4VzBwaTNLSFhpb0FpMXpRa2VIM2FGSVlSVTNE?=
 =?utf-8?B?MnhpMFNnMVd1dGx6Vnd6Mkc2SnB1NGFwa1BqQUQ1eXdUYmI3SDFGR2txS2c2?=
 =?utf-8?B?bEF4eHhRZy92NUpxaXBSNFB5a0ZxSFBrNEo2djRDUFZnTlNmNUY3WE04K3Zz?=
 =?utf-8?Q?BMHpVhV6Vr21zARWpPkhihLf2MsiPeDiwrT9s=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB1279B19AFFCF2170F5CD4BFFE0630@MWHPR11MB1279.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(14454004)(229853002)(6436002)(6486002)(186003)(478600001)(26005)(8936002)(81156014)(486006)(8676002)(72206003)(446003)(476003)(36756003)(2616005)(71190400001)(305945005)(5660300002)(81166006)(71200400001)(66066001)(256004)(4326008)(7736002)(11346002)(6246003)(25786009)(3846002)(6116002)(2906002)(52116002)(99286004)(76176011)(97736004)(102836004)(316002)(53546011)(386003)(6506007)(53936002)(54906003)(68736007)(2501003)(105586002)(110136005)(6512007)(106356001)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1279;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sj2k0DTpP80di5puykYnvmW0RYNe+gDE+EF5rRAxVDw4AAN24j/T7SmIJ0zF1PsW3bvWPlitu6h5/aiVkvem4ajc17Pvkr+l5dz3s6L702OE6kHfyz1FwpYaL7vMETstqtBUbP0SkJPGGuC01x6QGi8e+zoZ5i0KlH2wsJ40xPwZyRitp5BPi37vuIBL6Cd8mEpEp2PJVHeDA0/YBavYr2P3Q/9cyDHKjwx2FPAXk/1alvyxkgDdku8Vgaf7N0fhw6dPJtXyTrw8Tc8RDNQZOxfgQ4yHGw3wCuUKMO+Jxh0MS3v+ntk98A1UK1suIpbWc24V5kLlCZvnEpbrp8OIMHToaix6JmwsKgYTDneFUp1lKFQoEaZ9uVsr60MUqpZHGNGoNZS49rYFQuRBP1+BsdbHXhnOns0B0nwJFt68C2A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42BF1E808F12E04FBA14D92CB0AFE49E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: caa6db77-f67f-4752-f71f-08d695902aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 10:59:32.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDIvMjAxOSBhdCAxMjoyNCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gQWRkIHN1cHBvcnQgZm9yIFNBTTlYNjAgc2h1dGRvd24gY29udHJvbGxlci4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KDQpBY2tlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29t
Pg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMg
fCAxMSArKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2Mu
YyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMNCj4gaW5kZXggMDc0
N2UwY2RmMzUwLi5lMzQxY2M1YzBlYTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcmVz
ZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMNCj4gKysrIGIvZHJpdmVycy9wb3dlci9yZXNldC9hdDkx
LXNhbWE1ZDJfc2hkd2MuYw0KPiBAQCAtMjQ2LDEyICsyNDYsMjMgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBzaGR3Y19jb25maWcgc2FtYTVkMl9zaGR3Y19jb25maWcgPSB7DQo+ICAgCS5zcl9ydGN3
a19zaGlmdCA9IDUsDQo+ICAgCS5zcl9ydHR3a19zaGlmdCA9IFNIRFdfQ0ZHX05PVF9VU0VELA0K
PiAgIH07DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2hkd2NfY29uZmlnIHNhbTl4NjBf
c2hkd2NfY29uZmlnID0gew0KPiArCS53a3VwX3Bpbl9pbnB1dCA9IDAsDQo+ICsJLm1yX3J0Y3dr
X3NoaWZ0ID0gMTcsDQo+ICsJLm1yX3J0dHdrX3NoaWZ0ID0gMTYsDQo+ICsJLnNyX3J0Y3drX3No
aWZ0ID0gNSwNCj4gKwkuc3JfcnR0d2tfc2hpZnQgPSA0LA0KPiAgIH07DQo+ICAgDQo+ICAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXQ5MV9zaGR3Y19vZl9tYXRjaFtdID0gew0K
PiAgIAl7DQo+ICAgCQkuY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLXNoZHdjIiwNCj4gICAJ
CS5kYXRhID0gJnNhbWE1ZDJfc2hkd2NfY29uZmlnLA0KPiArCX0sDQo+ICsJew0KPiArCQkuY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1zaGR3YyIsDQo+ICsJCS5kYXRhID0gJnNhbTl4
NjBfc2hkd2NfY29uZmlnLA0KPiAgIAl9LCB7DQo+ICAgCQkvKnNlbnRpbmVsKi8NCj4gICAJfQ0K
PiANCg0KDQotLSANCk5pY29sYXMgRmVycmUNCg==
