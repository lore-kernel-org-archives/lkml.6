Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448B4217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FnS2KU0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfBRK7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:59:33 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:46614 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbfBRK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:59:33 -0500
X-IronPort-AV: E=Sophos;i="5.58,384,1544511600"; 
   d="scan'208";a="26734933"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 03:59:17 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 03:59:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XoTRfBAYkpFXAXZIXo1/N6La3NR3Tjw8gEQnpLNolY=;
 b=FnS2KU0MzNKrKXTwtYDfEccbWIIBldk8BiFqiQj0jeec/s11wjdXXbNji5+gk6ukxHHfFqKYifzCvhei81LHT4SI3W0cYSP6qO+Lat/TvBeQAmzv4oYGBxVZX6Ak9/m99wnVUVqOi+Ll4E1KfHFywE6JLS3qdNYS/Ic8WUWb6Hg=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1279.namprd11.prod.outlook.com (10.169.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 10:59:15 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 10:59:15 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/3] power: reset: at91-poweroff: add RTT wakeup
 capability
Thread-Topic: [PATCH 1/3] power: reset: at91-poweroff: add RTT wakeup
 capability
Thread-Index: AQHUx3j8EFNnbpKEtkS3tfjVpj7SUg==
Date:   Mon, 18 Feb 2019 10:59:15 +0000
Message-ID: <10737217-cbf5-765c-7bad-2d9f4b038f28@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-2-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-2-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0377.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::29) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6d1a545-4e68-4200-6015-08d695901f03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1279;
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMjc5OzIzOkxOT0RScFU0ek1ITUk3VFdDd0FrOUxyY0lm?=
 =?utf-8?B?R0JGWnQ1RVJ3c241Mi93ZjBEaFlYQWFVaTR4cithc1pTa285QlhuczUrT1dh?=
 =?utf-8?B?d2szU2d6YnpJK0FHREJSYy9LdDBFMUVGaXhnZUt6bi9URWN4ZGVqZ0JBZE15?=
 =?utf-8?B?TXFZT2hGZWVnRkhIbFA5eHpRWFVPRmF3VzdPYUZYM3A3TWhzamtXMDhTZWNS?=
 =?utf-8?B?cnNzU1JEQ2JORHFJZE5yNDF5WHJvZE1LUzVvZ1VqS21kelcrZXF5NUpvZ2c0?=
 =?utf-8?B?TUdKRzlHOFRzZDRhREZBYTJUQkFDak9LNkN4QnNBeXNSV05zajJjTkI3Ukln?=
 =?utf-8?B?UVFuRm11VklqcituWVhKQm5UQjkra0dLR3ZpaWJOc1pwdEJoRkYxblJ1bzE0?=
 =?utf-8?B?NGRtRU9ScGpxdktRNlpsSWFLTDFDQ0JVd0IrSE1pd0dVRndoUUhwTlVBRUdi?=
 =?utf-8?B?aUNwWURrYnJ3OTdybnhVWTVTWFhsZ09nM3NDZkM5eFl2VVQ3dFJrblRkcnpn?=
 =?utf-8?B?elljdHIxNlRDRjc4dHZjQk41OFZnM2x2ZUYxYVZtV0NMUDFiUnU1bGZIaThD?=
 =?utf-8?B?OXRKYnJCWkZ3VmxiUEljck9UMGhML0VtNDR5Mm95Y0hWdStnT2ZSbG9oekwv?=
 =?utf-8?B?S3M4c1NOaXlnWjlPYVR3VGtUR1cvay90ZEJjQkxvUUtsa09hd0ZnY0pPYTJm?=
 =?utf-8?B?YnVFazRwN0pDLzBScVVCT1dTQjljNkZORzloa2I5NXBmd0FEQXdPS2x4ZFlT?=
 =?utf-8?B?ODNVL0k5aHAvbFhaOU5hWkJLYTlPaXU1RHZqQTcyVUpWOTB6RFdOekQ3dW8v?=
 =?utf-8?B?SVU3QUtodWlvRU5McGVqcWtKbmdaUDVSZFkrZXl4WktSMURCYm1ncExUbGZx?=
 =?utf-8?B?YmllUCsydjdiVStNUENWTzBIdWYwNUUrZ2JtcVNTVU55WUM3dGRuai9hN250?=
 =?utf-8?B?ajVSSGpkVDl4S25Oc3BqdjBnN2hyVnVERzk0QnN2cUFVbFRwNFo4QkJzQllC?=
 =?utf-8?B?d1Ezd0FLR2Z2dDFnZWpxb0dXSGwyY25kOC9pdUNFbDZWbE1zYm1Qa0RXWGpJ?=
 =?utf-8?B?M0M5NlBZcTgzUkpWNU04NEg5RWFWaE5sL1pxM0Z4QnIzM3ZpNW03cUdOR00r?=
 =?utf-8?B?WFFyVXpnNXAwRy8xeGZ4UG5mSGhUU3dycXZLTUdzejU4bElxSFUxMExBK0VO?=
 =?utf-8?B?K2pZUHRESkp1aTZLNlpVeEc2WWVuMHFYN3RFTnJEZTlsaEhGZFRqMG53SnNw?=
 =?utf-8?B?RS9XRUlpSnlSa1ZQSlluOHNleStUdTVjRXJ3OS9EQXV6dE1sMlBKUFlwSVhT?=
 =?utf-8?B?V1IvNTJObDFoNjA0VUJReExjMEZFWEpTWlNYUDhuR1k4b0hkQWVWbGdNVG0y?=
 =?utf-8?B?NzNUS0NGMkxrT053cGZaYkhzdFVCK3FwSFZvYUJwUWhlVVllZ1NGNGYzdjYx?=
 =?utf-8?B?QWt5S1VodzFqQmhxQnppMGFUaUxoODdNM3k0TWxxeVJZN2xJWUE4Y1AwaFJI?=
 =?utf-8?B?c3IyaUIxZTZjNStuT1V2SWZnZldQS2Vzd0drc21TQ2o4UHVYZGJLVmpKUzJu?=
 =?utf-8?B?cEhYV1dzK2h2eEpJclQ0Y2tQcEROQWY2ZFhheGFNNUZxYU10ODdJR3lpSUlT?=
 =?utf-8?B?RHdaQk9vdW9wb2hSK3FPNW1OdXk5K2kvRG4rOFYxaGlpLzZ0VFBnZEJPVEJi?=
 =?utf-8?B?VklkOTZDSnJjK0p4ZGlkVlpQZU5NMXhTbnVybW94eUs1VU5ackYrT2FLbUJN?=
 =?utf-8?Q?jHl6iUrvAP8Yq3W4XjsVz9Ehv+ILtA914XMR0=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB127986C04F8C34025473E316E0630@MWHPR11MB1279.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(14454004)(229853002)(6436002)(6486002)(186003)(478600001)(26005)(8936002)(81156014)(486006)(8676002)(72206003)(446003)(476003)(36756003)(2616005)(71190400001)(305945005)(5660300002)(81166006)(71200400001)(66066001)(256004)(4326008)(7736002)(11346002)(6246003)(25786009)(3846002)(6116002)(2906002)(52116002)(99286004)(76176011)(97736004)(102836004)(316002)(53546011)(386003)(6506007)(53936002)(54906003)(68736007)(2501003)(105586002)(110136005)(6512007)(106356001)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1279;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bnlEThrmliBtto5kuIkhBnPyU2WZbxeH88atARO1aIKKcOUyA3G857FCLn91l73tJRGBxDFbh26jsoFzT49UxL0uNkHu/Wn0+ZwxPBakHuGdnURNPZRBQDpKTYjN9udtVUmJb8prwEwGc/GfGzroRi33nZZylMtUBjVN+5A8a8pVqYnTtv87SIi1xPQJluaTmSKxAMCgPQEHhlDSiWJjHNm3DRHP/F4ycWedgLcYyZ6Cpr2QNPAIAWDZzal5wbFjkJpJN7GFuPLrcsFnNuG09MSk+AchQm36jsRYkmJv/yvnBzhPnHfmj6DDz4wg7TIOw1Ebjdl2wuaDo9S6YYwIi0M85Y6gtkmKywx0BzmgMR/aH2oqoaqe98nWhX9Ggp2SiF9g7d09wrusKRpsuFUxo79Fsgl/mncDP3RD0GXoBG8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F3E343DC83520438EF3A6C8A1D1E53B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d1a545-4e68-4200-6015-08d695901f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 10:59:12.0655
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
Cj4gQWRkIFJUVCB3YWtldXAgY2FwYWJpbGl0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpBY2tlZC1ieTogTmlj
b2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgIGRy
aXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMgfCAxNCArKysrKysrKysrKysr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYyBiL2RyaXZlcnMvcG93
ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMNCj4gaW5kZXggMmI2ODZjNTViNzE3Li4wNzQ3
ZTBjZGYzNTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQy
X3NoZHdjLmMNCj4gKysrIGIvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2Mu
Yw0KPiBAQCAtNTcsMTUgKzU3LDIxIEBADQo+ICAgDQo+ICAgI2RlZmluZSBTSERXX1dLX1BJTihy
ZWcsIGNmZykJKChyZWcpICYgQVQ5MV9TSERXX1dLVVBJUygoY2ZnKS0+d2t1cF9waW5faW5wdXQp
KQ0KPiAgICNkZWZpbmUgU0hEV19SVENXSyhyZWcsIGNmZykJKCgocmVnKSA+PiAoKGNmZyktPnNy
X3J0Y3drX3NoaWZ0KSkgJiAweDEpDQo+ICsjZGVmaW5lIFNIRFdfUlRUV0socmVnLCBjZmcpCSgo
KHJlZykgPj4gKChjZmcpLT5zcl9ydHR3a19zaGlmdCkpICYgMHgxKQ0KPiAgICNkZWZpbmUgU0hE
V19SVENXS0VOKGNmZykJKDEgPDwgKChjZmcpLT5tcl9ydGN3a19zaGlmdCkpDQo+ICsjZGVmaW5l
IFNIRFdfUlRUV0tFTihjZmcpCSgxIDw8ICgoY2ZnKS0+bXJfcnR0d2tfc2hpZnQpKQ0KPiAgIA0K
PiAgICNkZWZpbmUgREJDX1BFUklPRF9VUyh4KQlESVZfUk9VTkRfVVBfVUxMKCgxMDAwMDAwICog
KHgpKSwgXA0KPiAgIAkJCQkJCQlTTE9XX0NMT0NLX0ZSRVEpDQo+ICAgDQo+ICsjZGVmaW5lIFNI
RFdfQ0ZHX05PVF9VU0VECSgzMikNCj4gKw0KPiAgIHN0cnVjdCBzaGR3Y19jb25maWcgew0KPiAg
IAl1OCB3a3VwX3Bpbl9pbnB1dDsNCj4gICAJdTggbXJfcnRjd2tfc2hpZnQ7DQo+ICsJdTggbXJf
cnR0d2tfc2hpZnQ7DQo+ICAgCXU4IHNyX3J0Y3drX3NoaWZ0Ow0KPiArCXU4IHNyX3J0dHdrX3No
aWZ0Ow0KPiAgIH07DQo+ICAgDQo+ICAgc3RydWN0IHNoZHdjIHsNCj4gQEAgLTEwNCw2ICsxMTAs
OCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYXQ5MV93YWtldXBfc3RhdHVzKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAgCQlyZWFzb24gPSAiV0tVUCBwaW4iOw0KPiAgIAllbHNlIGlm
IChTSERXX1JUQ1dLKHJlZywgc2hkdy0+Y2ZnKSkNCj4gICAJCXJlYXNvbiA9ICJSVEMiOw0KPiAr
CWVsc2UgaWYgKFNIRFdfUlRUV0socmVnLCBzaGR3LT5jZmcpKQ0KPiArCQlyZWFzb24gPSAiUlRU
IjsNCj4gICANCj4gICAJcHJfaW5mbygiQVQ5MTogV2FrZS1VcCBzb3VyY2U6ICVzXG4iLCByZWFz
b24pOw0KPiAgIH0NCj4gQEAgLTIyMSw2ICsyMjksOSBAQCBzdGF0aWMgdm9pZCBhdDkxX3NoZHdj
X2R0X2NvbmZpZ3VyZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAlpZiAob2Zf
cHJvcGVydHlfcmVhZF9ib29sKG5wLCAiYXRtZWwsd2FrZXVwLXJ0Yy10aW1lciIpKQ0KPiAgIAkJ
bW9kZSB8PSBTSERXX1JUQ1dLRU4oc2hkdy0+Y2ZnKTsNCj4gICANCj4gKwlpZiAob2ZfcHJvcGVy
dHlfcmVhZF9ib29sKG5wLCAiYXRtZWwsd2FrZXVwLXJ0dC10aW1lciIpKQ0KPiArCQltb2RlIHw9
IFNIRFdfUlRUV0tFTihzaGR3LT5jZmcpOw0KPiArDQo+ICAgCWRldl9kYmcoJnBkZXYtPmRldiwg
IiVzOiBtb2RlID0gJSN4XG4iLCBfX2Z1bmNfXywgbW9kZSk7DQo+ICAgCXdyaXRlbChtb2RlLCBz
aGR3LT5zaGR3Y19iYXNlICsgQVQ5MV9TSERXX01SKTsNCj4gICANCj4gQEAgLTIzMSw3ICsyNDIs
MTAgQEAgc3RhdGljIHZvaWQgYXQ5MV9zaGR3Y19kdF9jb25maWd1cmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHNoZHdjX2NvbmZpZyBzYW1h
NWQyX3NoZHdjX2NvbmZpZyA9IHsNCj4gICAJLndrdXBfcGluX2lucHV0ID0gMCwNCj4gICAJLm1y
X3J0Y3drX3NoaWZ0ID0gMTcsDQo+ICsJLm1yX3J0dHdrX3NoaWZ0CT0gU0hEV19DRkdfTk9UX1VT
RUQsDQo+ICAgCS5zcl9ydGN3a19zaGlmdCA9IDUsDQo+ICsJLnNyX3J0dHdrX3NoaWZ0ID0gU0hE
V19DRkdfTk9UX1VTRUQsDQo+ICt9Ow0KPiAgIH07DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgYXQ5MV9zaGR3Y19vZl9tYXRjaFtdID0gew0KPiANCg0KDQotLSAN
Ck5pY29sYXMgRmVycmUNCg==
