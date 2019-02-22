Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23339C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E652077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="N0z3fGbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfBVJIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:08:04 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:32615 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfBVJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:08:02 -0500
X-IronPort-AV: E=Sophos;i="5.58,398,1544511600"; 
   d="scan'208";a="26723644"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Feb 2019 02:08:01 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 22 Feb 2019 02:08:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGIi/Pw3DDC0pyaw7+8UWD3aVnMmQDNiJp4XUW+BNCU=;
 b=N0z3fGbdpTMSFUu/hnFJn9mhUGbZ0VEQp3TImYTgWHNTOG/tDQljnwxKd3otZud8Lup+Cyyy7/mcbZgJRiAarTv6s90bGZVAqQ1MgNwyLlDCbmHCdw05W3xiVCEQyk9OlS1eYb+8wJPOW+j6B8KGyvAuROEQ9PqldStV1n8IXDM=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1487.namprd11.prod.outlook.com (10.172.53.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Fri, 22 Feb 2019 09:07:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 09:07:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] pwm: atmel: add support for SAM9X60's PWM
 controller
Thread-Topic: [PATCH v2 3/4] pwm: atmel: add support for SAM9X60's PWM
 controller
Thread-Index: AQHUyDsiDT3T0eJSS0SM7JH09g6VaqXqvC4AgADPgYA=
Date:   Fri, 22 Feb 2019 09:07:57 +0000
Message-ID: <12a63031-596c-77a3-f10c-be276d75e82c@microchip.com>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
 <1550570914-26391-4-git-send-email-claudiu.beznea@microchip.com>
 <20190221204503.w2xh4rw6rh4e5rg4@pengutronix.de>
In-Reply-To: <20190221204503.w2xh4rw6rh4e5rg4@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0250.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::23) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190222110745438
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ad1776-9944-4da4-98b1-08d698a53c38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1487;
x-ms-traffictypediagnostic: MWHPR11MB1487:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNDg3OzIzOkwrNXRjZDVpU0plZnhGMTZuOHIxZU9HSVVU?=
 =?utf-8?B?YkJYUFBNZDQ2bkJqYUJTWkVvMEp2NWlWbG5wVFVQRkg2YjIrSHRmbkE5WXJ0?=
 =?utf-8?B?TE1OemhIdUNyWnp3UDR6NTRVczBBeXNQUG9CZHJIVFgveWZsclkrOWtMSndk?=
 =?utf-8?B?NDNVRXhPKzY4SThCUmpPOUJRQzVZdGh4RWNVSlhJcUJGMGtMODRWbnRmYWFt?=
 =?utf-8?B?dFdBSEluVlNwQlNoWklKeC8raGZkZW4vanFoTmpTT0dWS0FSOEtXYWtHZVNp?=
 =?utf-8?B?TUdiWCtoeVdtT2JNS2pyaUltK1EwUFp2ZkhUS3NsUzl1TlBjOGRnL2ZuSWtH?=
 =?utf-8?B?cVVkVE82Tk5TL3hoNVhVaVBvZGFYbFQxbWhmM3RyUEFPTDBMdG14Mkw5VERk?=
 =?utf-8?B?YVg5Z080ZURyTnBtZHMwem5IcGk4OU9YMVZmME1DYlptRVg3NGZ0bE8xOFUr?=
 =?utf-8?B?WSt3T01kUUdZWVNYdThodklnQTVQMnljYlh0Z0RHbTMvMTlWTkFIOEZyQ0hS?=
 =?utf-8?B?Vm9MT2Uwa0FKVTZ6Q244K0N3SC9TR2srbTdLSVBKcUVHaUpjTWdOMi9yYzJL?=
 =?utf-8?B?OHE1Z241NXpKOVNnOHRYR3VSVkcwaHpSQ0RFUGk2YkcyUjB6VjdCd1Raamkv?=
 =?utf-8?B?QVNtNnpqMWNMbVgzTHRNVWlnaWRGVjRqbzFTc0V5VEViT0Y5WlpqOHcyaU1k?=
 =?utf-8?B?cmszRVpWb28ydWF6WFdOcUxFM2xEQXVvZXZyeWFwbGxKOHNtd3paRlM4N3pZ?=
 =?utf-8?B?ODZNd2t4MHBaZDJuUlNYU01hdjgzakhCcWw0eU9pY2xpdEg3a3JrVzUrT2dW?=
 =?utf-8?B?YjY5ZWRrSW10OXk3WVo5Z3NaVmVlV0dnTWd6dFBEK1RWdFo4UENnSXlLcTdn?=
 =?utf-8?B?enNkaE9Xc3h5SUxBU0lvcElxRG1LRUJGb1k3b2pMeDB6c3M4dkx4b1J5U0VP?=
 =?utf-8?B?YklHaXdwSXZENUFiY2tUZUJXT2l4OW5ER0gwMXFhTWpHZWFCNVo2WEYrYnFK?=
 =?utf-8?B?MytjdFUxM2xERFFVblBHb1FBM0VOeUxGREdZZ2t4cEhlTlhSaVpjekRhdnU5?=
 =?utf-8?B?blU2WkIyWnZjNUpROWNEVnl4TXlmTHowcFl5eHdCakFnbDlaZy9jZVRvTXRm?=
 =?utf-8?B?TnlrWVpYcy9HQjhaekVxYjVuVC8wczAxRFpna0NrYkZBcFdudUVuclhlOHhB?=
 =?utf-8?B?c1hjMW5uelRjViswaG1Lc2ROUEVNODFzaEJrNW5hWS9ESjdSdTNyL1F6Tnli?=
 =?utf-8?B?ajRBbFVlSk9nNDJsR2I4QnpNRVNpNHRZTVV3a295QzVvaEFaQUZqT2s4d3Ft?=
 =?utf-8?B?NjdLSmJZZlBKMHRObStkUlF5dzBFWjFxbVJPMHFxQ2VmNE9UMGJFTUdOZGY5?=
 =?utf-8?B?Mi9GMTVTL2pQZzJxUHBhUDJ3NFNiZmdmWm1EdHFOT0lqMkp1QmZlS1A0amJt?=
 =?utf-8?B?eVZaZE1PL3ZSamFSWDdGWmU4U1pwdnVPbmFXdEg1VkxuMHQzUW1tUE15cEdT?=
 =?utf-8?B?NGozUmdLdUVtMnZPYWVtOGdKV3pVLys4K2IwWVNkbDlHUm1MTEwrdXhuRkUz?=
 =?utf-8?B?REkvSExFT0tOMHRRNjMyTUVOWjZrV3ZObmRJRFpnVXIwcm1NNzlBR09ad2h3?=
 =?utf-8?B?K1gyY05mVWdzUUpLU0FwTjZaMGllVnM3MVNzZE90WlJ5aWVjeDE1eTNFVXJu?=
 =?utf-8?B?Y2hCS3VhYUJBeFhEaUR1KzE5elE5VzIxNmNUcGllUVRLSUlmR2ZrN3QyV2xC?=
 =?utf-8?B?Y2QvYkViTmlxYm5jWWIxMnZ0SW53T2lyMGlEVUdXZEd1MUI5d1RWZURBaTNh?=
 =?utf-8?Q?zHM5tCjW2Qm52?=
x-microsoft-antispam-prvs: <MWHPR11MB1487F27B939726BB476A207E877F0@MWHPR11MB1487.namprd11.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(105586002)(106356001)(102836004)(316002)(31686004)(478600001)(72206003)(6916009)(14454004)(31696002)(8936002)(66066001)(97736004)(81156014)(8676002)(99286004)(2906002)(68736007)(81166006)(486006)(476003)(2616005)(76176011)(11346002)(25786009)(446003)(52116002)(53546011)(6506007)(386003)(7736002)(4326008)(6246003)(26005)(6512007)(6436002)(71190400001)(5660300002)(71200400001)(14444005)(256004)(36756003)(305945005)(54906003)(229853002)(186003)(53936002)(6486002)(86362001)(6116002)(66574012)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1487;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TBU4Y2ZPIP5Lru714h2q2aKXSmsGwowPRLjVOomkty3sQgFN8lX4fg/njoAoMaDGO9P/CuAR/fzz4AWD24/kjrZ6DgQfkKBjg5UsiZbXdf1OhVLzIlCBC4my+2ciC2ZAHYpI1O31yOENJaG1NWh/b/hHCAjP6jKv2o5D+cSJHnkNrJoYleEFxzGShzH4qEGw8FjhahR/kgwbecVkpdKPX5ctJ534viZ/JsN8Ex8pFYILkRoonLbIidoExhx7vaMRAHBRO8GBtHN6K/mWbTEwLm1kXbK/d647lEkSuYDOM+EDNsXf+imTO1qsReUkMLtxPwLw00m2RhE6KBZfX44p6RuU/jnvhN0ROoQyNr3pGnQxbII3Td4QgPDJLOIUP0BhibpOeA/vlmBOwGbTjiJp+/hzWKhEV4aOQmKNSlOxq9Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A6ED854A060F44D88C6B462F9D1E694@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ad1776-9944-4da4-98b1-08d698a53c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 09:07:52.7209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1487
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLjAyLjIwMTkgMjI6NDUsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBU
dWUsIEZlYiAxOSwgMjAxOSBhdCAxMDowOTowMEFNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQWRkIHN1cHBvcnQgZm9yIFNBTTlYNjAncyBQV00gY29u
dHJvbGxlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvcHdtL3B3bS1hdG1lbC5j
IHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jIGIvZHJp
dmVycy9wd20vcHdtLWF0bWVsLmMNCj4+IGluZGV4IDY0N2QwNjM1NjJkYi4uMjI5Y2VkYjAyNzcw
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMNCj4+ICsrKyBiL2RyaXZl
cnMvcHdtL3B3bS1hdG1lbC5jDQo+PiBAQCAtNTIsNiArNTIsOCBAQA0KPj4gIA0KPj4gIC8qIE9u
bHkgdGhlIExTQiAxNiBiaXRzIGFyZSBzaWduaWZpY2FudC4gKi8NCj4+ICAjZGVmaW5lIFBXTV9N
QVhWMV9QUkQJCTB4RkZGRg0KPj4gKy8qIEFsbCAzMiBiaXRzIGFyZSBzaWduaWZpY2FudC4gKi8N
Cj4+ICsjZGVmaW5lIFBXTV9NQVhWMl9QUkQJCTB4RkZGRkZGRkYNCj4+ICAjZGVmaW5lIFBSRF9N
QVhWMV9QUkVTCQkxMA0KPj4gIA0KPj4gIHN0cnVjdCBhdG1lbF9wd21fcmVnaXN0ZXJzIHsNCj4+
IEBAIC0zMTEsNiArMzEzLDIwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXRtZWxfcHdtX2RhdGEg
YXRtZWxfcHdtX2RhdGFfdjIgPSB7DQo+PiAgCX0sDQo+PiAgfTsNCj4+ICANCj4+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IGF0bWVsX3B3bV9kYXRhIGF0bWVsX3B3bV9kYXRhX3YzID0gew0KPiANCj4g
RG9lcyBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gY2FsbCB0aGlzIC4uLl9zYW05eDYwIHRvIG1hdGNo
IHRoZQ0KPiBjb21wYXRpYmxlPyAoSWYgeWVzLCBwYXRjaCAxIHNob3VsZCBiZSBjaGFuZ2VkIGFj
Y29yZGluZ2x5LikNCg0KSXQgY291bGQgYmUgY2hhbmdlZCwgeWVwLg0KDQo+IA0KPiBJIHdvbmRl
ciBob3cgdGhlIG5hbWluZyBvZiB0aGUgZGVmaW5lcyBpcyBjaG9zZW4gZ2l2ZW4gdGhhdCBwd21f
ZGF0YV92Mw0KPiBpcyB0aGUgZmlyc3QgdGhhdCBuZWVkcyBQV01fTUFYVjJfUFJELiBMb29rcyBp
bmNvbnNpc3RlbnQuDQoNCkkga25vdy4uLiBJJ20gYXdhcmUgb2YgdGhhdC4gVGhlIHRoaW5nIGlz
IGNvbnRyb2xsZXJzIG1heSBkaWZmZXIgd2l0aA0KcmVnYXJkcyB0byBpbi1mbGlnaHQgZHV0eSB1
cGRhdGUgYW5kIG5vdyB0aGVyZSBpcyB0aGlzIG5ldyBkaWZmZXJlbmNlIHcvDQpyZWdhcmRzIHRv
IGNvdW50ZXJzIHNpemUuDQoNClJlbmFtaW5nIHRoZSBvYmplY3RzIG9mIHR5cGUgYXRtZWxfcHdt
X2RhdGEgaW4gc29tZXRoaW5nIGxpa2UNCmF0bWVsX3B3bV9kYXRhXzxjaGlwLW5hbWU+IGFzIHlv
dSBzdWdnZXN0ZWQgYmVmb3JlIHdvdWxkIG1ha2UgdGhpbmdzIGNsZWFyDQpmb3IgeW91Pw0KDQpU
aGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+
IA0K
