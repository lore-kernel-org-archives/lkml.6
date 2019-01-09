Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87307C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0AA214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VRIiQ1jU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfAIJCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:02:48 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:41040 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfAIJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:02:47 -0500
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="26175965"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jan 2019 02:02:46 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 9 Jan 2019 02:02:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHSJGpYCPczU6w8SjMvN+aMeiHa229Jwy8FMzUavX64=;
 b=VRIiQ1jUjoKT6QiQRqbQIWjEoBwnfhEtGI80SCt2C+ESuW/52nX3uzHfz/6I1yXX19+tRGF14aWhKANDqqvbtNz6lwybMZEZDca3IClOmFWhqkHVp/Lro4TejlG5WiuefAPdSgGawAV7vQmwgudTazCDpinLZQpJEyaTypEQ94s=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1312.namprd11.prod.outlook.com (10.169.237.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 9 Jan 2019 09:02:44 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 09:02:44 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <thierry.reding@gmail.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Topic: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUo2hjF9SHYVC+/UyvQjeBLKSGN6WhLe0AgAJimACAANRQAIAAu2iAgADWWwCAALa4AA==
Date:   Wed, 9 Jan 2019 09:02:44 +0000
Message-ID: <085ac33b-89ee-dcdb-6085-735ae5fa08cb@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
 <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
 <0ef0b4f1-45c3-0280-c1f0-6d499957f74c@microchip.com>
 <20190108220838.amrun6jsa24yeisg@pengutronix.de>
In-Reply-To: <20190108220838.amrun6jsa24yeisg@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::20) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1312;6:v1XRSUYmT3CwCCLp47jKCaONQwTb3uAXeRtABUKSqQnbI7+0RMLMcvMm0fXRP2MJgeeIeVZKFcCMmew6tMhiBr0a2B+IW57EY0vDw1sBBvr3EXcmoI/JI5ZcxQ0ZQAkWD7DBQoii7j7F8Iu33r+v4Wp5CgBZz0iI9YpRYM3wCuvzg9rbTbwvxcsFlAqJ6exl14xAYj3k8jJ55YD/JxRm2mBNCp2Y8IisB5EAQN1pDaE5uGiUagFypl3+z1ebRCGQUupge0MieacvnSLRGiN4z9fGowlL2f5lktaDun7lY2VdpzD5HlDUI/5JlnB/IlN1rrje9zSkFupxKSgkzY7YiANDAfNMVNnGjcPM3EnAiCLCOCoW2SlSIwSbcOhJsWFYxU4YMbsykjg9tPbu9Wyzr+9q88A+3cH5b5xHYwjTZ8Z4MZ3BHZyw82Zq+ME0P88MmkAu5JH7bu7evOkr7HrR9Q==;5:ag6vp+Br/0LuNMkKZpIPeFj2tJgLJ1lqCFyxRc/dM24kbpBjZLSIjheGzxwZv99TZPbioPlnwO91/d/gQl5j2SlWG5/9HNQAljRiITqpSpuWmSLHY5YzXzjs+qXwWM9Fn6r3sDgOV71Vp6FiO9jhaRj28amcewSFWLLrVCCU9z4YhvSMrfjeLrgO77YMzzamFmc+TvCvKa3MMhPdsz14Mg==;7:xX+frUZ+saQkB4FWuQ+q0Pq05l3pnmaXV6k7XaX4aeolT27IFlixQUJFqBja0hdTSlgWGtqnUWuoF5ob5fg1ARdl19uItajl8zLUOdQ5Kd5hg/SRfQo7IeVHAC/R+1EZaQhS3P08ioWsh6tOEhLaMw==
x-ms-office365-filtering-correlation-id: f8f785b0-c447-4f59-3c9e-08d6761137bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1312;
x-ms-traffictypediagnostic: MWHPR11MB1312:
x-microsoft-antispam-prvs: <MWHPR11MB13126C0E4D507AA7056B2266878B0@MWHPR11MB1312.namprd11.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(2906002)(186003)(71190400001)(71200400001)(3846002)(68736007)(81156014)(5660300001)(106356001)(8936002)(102836004)(31696002)(11346002)(81166006)(6506007)(486006)(6116002)(86362001)(6916009)(446003)(256004)(26005)(2616005)(476003)(8676002)(66066001)(54906003)(93886005)(25786009)(14454004)(39060400002)(4326008)(316002)(99286004)(53936002)(53546011)(7736002)(6436002)(386003)(6512007)(229853002)(305945005)(6486002)(36756003)(52116002)(97736004)(478600001)(6246003)(72206003)(76176011)(105586002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1312;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: riIewCfSTN2dGFke9SBNo69PhEY+GeHi+uhCLxJtQYtGDeUMCfESyJj1nzns9g0CJU8xznywCRwx7DKaKnS27qw39dNsKrd3/rHm102CzllwO2jLR+q7tGzXhQZF4P9UJTLuI2jMrdo0TDz8hGANO+DxESjaST194U1d1kJyuLAEMYJ/QiBi8AnteNo3GGanheSwOWjCu1XNoPdRVS1l8JNzEkt7KNEPbgox9UTHrowvITps1ngY04dMV+98ONGa+J5P9Pv/BSMLPZ/RNWqzIBraVclN65BBWjQ0/bCFKmuh1+hCye8F4SVW18PbHGHw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <346409511435DF4D8E17F9C9E23C6E41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f785b0-c447-4f59-3c9e-08d6761137bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 09:02:44.3186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1312
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LjAxLjIwMTkgMDA6MDgsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBU
dWUsIEphbiAwOCwgMjAxOSBhdCAwOToyMTozNEFNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4gSGkgVXdlLA0KPj4NCj4+IE9uIDA4LjAxLjIwMTkgMDA6MTAs
IFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPj4+IEhlbGxvIENsYXVkaXUsDQo+Pj4NCj4+PiBP
biBNb24sIEphbiAwNywgMjAxOSBhdCAwOTozMDo1NUFNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBt
aWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+PiBPbiAwNS4wMS4yMDE5IDIzOjA1LCBVd2UgS2xlaW5l
LUvDtm5pZyB3cm90ZToNCj4+Pj4+IE9uIFRodSwgSmFuIDAzLCAyMDE5IGF0IDAxOjI5OjQ0UE0g
KzAwMDAsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+Pj4gRnJvbTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+Pj4+Pj4NCj4+
Pj4+PiBBZGQgYmFzaWMgUFdNIG1vZGVzOiBub3JtYWwgYW5kIGNvbXBsZW1lbnRhcnkuIFRoZXNl
IG1vZGVzIHNob3VsZA0KPj4+Pj4+IGRpZmZlcmVudGlhdGUgdGhlIHNpbmdsZSBvdXRwdXQgUFdN
IGNoYW5uZWxzIGZyb20gdHdvIG91dHB1dHMgUFdNDQo+Pj4+Pj4gY2hhbm5lbHMuIFRoZXNlIG1v
ZGVzIGNvdWxkIGJlIHNldCBhcyBmb2xsb3c6DQo+Pj4+Pj4gMS4gUFdNIGNoYW5uZWxzIHdpdGgg
b25lIG91dHB1dCBwZXIgY2hhbm5lbDoNCj4+Pj4+PiAtIG5vcm1hbCBtb2RlDQo+Pj4+Pj4gMi4g
UFdNIGNoYW5uZWxzIHdpdGggdHdvIG91dHB1dHMgcGVyIGNoYW5uZWw6DQo+Pj4+Pj4gLSBub3Jt
YWwgbW9kZQ0KPj4+Pj4+IC0gY29tcGxlbWVudGFyeSBtb2RlDQo+Pj4+Pj4gU2luY2UgdXNlcnMg
Y291bGQgdXNlIGEgUFdNIGNoYW5uZWwgd2l0aCB0d28gb3V0cHV0IGFzIG9uZSBvdXRwdXQgUFdN
DQo+Pj4+Pj4gY2hhbm5lbCwgdGhlIFBXTSBub3JtYWwgbW9kZSBpcyBhbGxvd2VkIHRvIGJlIHNl
dCBmb3IgUFdNIGNoYW5uZWxzIHdpdGgNCj4+Pj4+PiB0d28gb3V0cHV0czsgaW4gZmFjdCBQV00g
bm9ybWFsIG1vZGUgc2hvdWxkIGJlIHN1cHBvcnRlZCBieSBhbGwgUFdNcy4NCj4+Pj4+DQo+Pj4+
PiBJIHN0aWxsIHRoaW5rIHRoYXQgbXkgc3VnZ2VzdGlvbiB0aGF0IEkgc2VudCBpbiByZXBseSB0
byB5b3VyIHY1IHVzaW5nDQo+Pj4+PiAuYWx0X2R1dHlfY3ljbGUgYW5kIC5hbHRfb2Zmc2V0IGlz
IHRoZSBiZXR0ZXIgb25lIGFzIGl0IGlzIG1vcmUgZ2VuZXJpYy4NCj4+Pj4NCj4+Pj4gSSBsaWtl
IGl0IGJldHRlciBteSB3YXksIEkgZXhwbGFpbmVkIG15c2VsZiB3aHkuDQo+Pj4NCj4+PiBJIGNv
dWxkbid0IHJlYWxseSBmb2xsb3cgeW91ciBhcmd1bWVudCB0aG91Z2guIFlvdSBzZWVtZWQgdG8g
YWNrbm93bGVkZ2UNCj4+PiB0aGF0IHVzaW5nIC5hbHRfZHV0eV9jeWNsZSBhbmQgLmFsdF9vZmZz
ZXQgaXMgbW9yZSBnZW5lcmljLg0KPj4NCj4+IFRydWUgaXQgaXMgbW9yZSBnZW5lcmljIGluIHRo
ZSB3YXkgdGhhdCBpdCBnaXZlcyB0aGUgcG9zc2liaWxpdHkgdG8NCj4+IGNvbmZpZ3VyZSBhbGwg
a2luZCBvZiB3YXZlZm9ybXMuIEJ1dCBub3QgYWxsIGNvbnRyb2xsZXJzIHN1cHBvcnRzIHRoaXMu
DQo+PiBUaGUgdXNlIGNhc2Ugb2YgdGhpcyB3b3VsZCBiZSB0byBoYXZlIGRlYWQtdGltZXMgd2l0
aCBhbnkgdmFsdWVzLCByaWdodD8NCj4gDQo+IFdlbGwsIEkgZGlkbid0IHRhcmdldCB0aGF0LiBU
aGUgbW9kZWwgSSBzdWdnZXN0ZWQgaXMganVzdCBhIGdlbmVyaWMgc2V0DQo+IG9mIHBhcmFtZXRl
cnMgdGhhdCBhcmUgYWJsZSB0byBkZXNjcmliZSB0aGUgd2F2ZSBmb3JtcyBmb3IgYWxsIHRocmVl
DQo+IG1vZGVzIHlvdSBzdWdnZXN0ZWQuIFRoYXQgaXQgYWxsb3dzIHRvIGV4cHJlc3MgZGVhZC10
aW1lcyBpcyBqdXN0IGEgbmljZQ0KPiBieS1wcm9kdWN0Lg0KPiANCj4+Pj4+IEkgZmFpbCB0byBz
ZWUgdGhlIHVwc2lkZSBvZiBzdG9yaW5nIHRoZSBtb2RlIGFzIDJebW9kZSBpbnN0ZWFkIG9mIGEN
Cj4+Pj4+IHBsYWluIGVudW0gcHdtX21vZGUuIEdpdmVuIHRoYXQgc3RydWN0IHB3bV9zdGF0ZSBp
cyB2aXNpYmxlIGZvciBwd20NCj4+Pj4+IHVzZXJzIGEgcGxhaW4gcHdtX21vZGUgd291bGQgYXQg
bGVhc3QgYmUgbW9yZSBpbnR1aXRpdmUuDQo+Pj4+DQo+Pj4+IFRvIGhhdmUgYWxsIG1vZGVzIHN1
cHBvcnRlZCBieSBhIGNvbnRyb2xsZXIgZ3JvdXBlZCBpbiBwd21fY2Fwczo6bW9kZXNfbXNrLg0K
Pj4+DQo+Pj4gTXkgcXVlc3Rpb24gd2FzIG5vdCBhYm91dCBzdHJ1Y3QgcHdtX2NhcHM6Om1vZGVz
X21zayBidXQgYWJvdXQNCj4+PiBzdHJ1Y3QgcHdtX3N0YXRlOjptb2RlYml0LiBBcyBzdHJ1Y3Qg
cHdtX3N0YXRlIGhhcyB2aXNpYmlsaXR5IGV2ZW4NCj4+PiBvdXRzaWRlIG9mIHRoZSBwd20gQVBJ
IChpLmUuIGl0IGlzIHVzZWQgYnkgY29uc3VtZXJzKSBpdCBpcyBiZW5lZmljaWFsDQo+Pj4gdG8g
a2VlcCB0aGF0IHNpbXBsZS4gTGV0dGluZyBhIGNvbnN1bWVyIHBhc3MgaW4gdGhlIG1vZGUgaGUg
d2FudHMgaXMNCj4+PiBlYXNpZXIgdG8gZXhwbGFpbiB0aGFuIHNldHRpbmcgYSBzaW5nbGUgYml0
LiBBbHNvIGVycm9yIGNoZWNraW5nIHdpdGggYQ0KPj4+IHBsYWluIGVudW0gaXMgZWFzaWVyIGJl
Y2F1c2UgeW91IGp1c3QgZG86DQo+Pj4NCj4+PiAJaWYgKG1vZGUgPj0gTU9ERV9DTlQpDQo+Pj4g
CQllcnJvcigpDQo+Pj4NCj4+PiB3aGljaCBpcyBlYXN5IHRvIGdyYXNwLiBDb21wYXJlIHRoYXQg
dG8NCj4+Pg0KPj4+IAlpZiAoIWlzX3Bvd2VyX29mX3R3byhtb2RlYml0KSB8fCBtb2RlYml0ID49
IFBXTV9NT0RFX0JJVChDTlQpKQ0KPj4+IAkJZXJyb3IoKQ0KPj4+DQo+Pj4gKG1vZHVsbyBzeW50
YWN0aWNhbCBjb3JyZWN0bmVzcykuDQo+Pg0KPj4gVGhlIHJlYXNvbiBJIGNob29zZSB0byBoYXZl
IGl0IGFzIGJpdCB3YXMgdGhlIG1lbWNtcCgpIGF0IHRoZSBiZWdpbm5pbmcgb2YNCj4+IHB3bV9h
cHBseV9zdGF0ZSgpIGFuZCB0byBhdm9pZCBzdGFydGluZyBlbnVtIHB3bV9tb2RlIGZyb20gMSBh
bmQgdG8gYXZvaWQNCj4+IGhhdmluZyBiaXQgMCBvZiBwd21fY2Fwczo6bW9kZXNfbXNrIHVudXNl
ZCAoaW4gdGhlIGRyaXZlciBJJ20gdXNpbmcNCj4+IFBXTV9NT0RFX0JJVCgpIG1hY3JvIHRvIGZp
bGwgaW4gdGhlIGRyaXZlcidzIHN1cHBvcnRlZCBtb2RlcykuDQo+IA0KPiBEb2VzIHRoYXQgbWVh
biB5b3UgYXJlIGNvbnZpbmNlZCBieSBteSBhcmd1bWVudD8NCg0KSSBrbm93IHdoYXQgeW91IGFy
ZSB0YWxraW5nIGFib3V0LiBJIGJhbGFuY2VkIGluIGJldHdlZW4gdGhlc2UgdHdvIHBhdGhzDQp3
aGlsZSBJIHdyb3RlIHRoZSBjb2RlLiBUaGUgYXBwcm9hY2ggSSBjaG9zZSBsb29rZWQgdG8gbWUg
dG8gYmUgbW9yZSBlYXN5DQp0byByZWFkLiBOb3csIHNpbmNlIHRoZXJlIGlzIGFub3RoZXIgcGVy
c29uICh5b3UpIHRoaW5raW5nIHRoZSBvdGhlcg0KYXBwcm9hY2ggaXMgYmVzdCwgSSdtIHRoaW5r
aW5nIHRvIGNoYW5nZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFuayB5b3UsDQpDbGF1
ZGl1IEJlem5lYQ0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0K
