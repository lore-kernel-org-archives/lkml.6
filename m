Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755F220824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jmfbZiHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755F220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391525AbeKWD1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:27:34 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:19264
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732442AbeKWD1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kYl8taYapis3HL2S7QejK/J/S5/ExAiAGqej0PHnwE=;
 b=jmfbZiHl0UNvSnZs4EPcYzIMCaFdxKirqvoPLKG+xCAzqBVsitGcfWb8swWg7iqCxV3HWVE+u1u9BYXRm2+ylPhCrRTo+X0Qhlhxz9gtqX6f4ichPHyyvRBHzoUYuuZ2CA7vDJHDPP7BO2nwgCQJvYnNBpkjy976KLmLfbBS6h0=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5403.eurprd04.prod.outlook.com (20.178.104.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 16:46:39 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Thu, 22 Nov 2018
 16:46:39 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in disabled
 state
Thread-Topic: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Thread-Index: AQHUfX7SCRu1RfBnYE+mazOHv61qtqVSEQGAgAnn4ACAAAusgIAABlOA
Date:   Thu, 22 Nov 2018 16:46:39 +0000
Message-ID: <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
References: <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de> <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de> <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
In-Reply-To: <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::21) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5403;6:iuQqnlmGIVyF5uWeF0Mxl3QvuLCQrICpsKTXUbivsmv7sanif5Z/PKxxyWg35WgngfXnEo1vF8wkgLd/JO8OPOEVWMwz7+Qwis5Z/+K6BP1UV48G7mOCUbhVnnGNqjuXpYU5cF7fa4OM2cwb3rCh4kzmaVWifgENQdS4+XfkGhzbGefuEht1YDiBxkp5KvGVWKV/3yUuRXvyFPjLfH2K4lr8olZMVit2758DuYrlpwgYifA/y1Xg3wsWQym9YO15gdxy0wX8iW37KsoVJq+jSIQ0yCD4UapjP8EV2nunUYvhndT+r0uZ8VladD/7ykyohP55JRSGC1NGAdPfHP21ut2FOr89NPO20I4y7g0SHT8N2rN/DS79Xs+d52csoIp4hGDYeI5WSH+fCrVXvQRPAOjOEW5/jN3hg55HHx5bGKGozgVBLw0xqMCMChJbiUojusIEJhwtvf+5Ouv08S22wg==;5:fABTPNVEH4hEzolrsKCMZ712W2F591uQqajPhvECosXyIFxLn9SLboo2uWalMcFUBvfCx/FMT0YNsdCJvIonxhFt8B7jfFqLXQuGByiMDY6NVSwY/HxqMMWAygqW1F+rd94X79IVVUXUgP/CA3vp+ysY8LbAOw2TjINrCW+QYdg=;7:IlXAPIkRxo06cAg032p53O2Cip6EWe+zI1MB/W2HVUytVkjpWtrYmOg4AtVdy5OUKfwOVruS7GnKDiWFVITLJbrHIC8PQrygQE6D9mXgI26QD76pgCwvbMm9UMb7bddTvSrMBrBO+S1RoNG89nR2cA==
x-ms-office365-filtering-correlation-id: ac543df2-b4c1-4893-3480-08d6509a133a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5403;
x-ms-traffictypediagnostic: DB7PR04MB5403:
x-microsoft-antispam-prvs: <DB7PR04MB540315A4C36EE660427171F39EDB0@DB7PR04MB5403.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5403;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5403;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39850400004)(189003)(199004)(486006)(6506007)(229853002)(8936002)(68736007)(72206003)(6512007)(66066001)(14454004)(386003)(7416002)(97736004)(53546011)(476003)(6246003)(31696002)(316002)(2906002)(93886005)(6916009)(86362001)(53936002)(478600001)(6486002)(6116002)(52116002)(54906003)(2616005)(11346002)(446003)(102836004)(7736002)(256004)(66574009)(105586002)(99286004)(31686004)(25786009)(39060400002)(8676002)(81156014)(81166006)(106356001)(14444005)(305945005)(26005)(186003)(36756003)(4326008)(85182001)(2900100001)(6436002)(76176011)(71200400001)(71190400001)(3846002)(5660300001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5403;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lVVXi4D9jG/fY1QnckaCdmDHLQEZO9z0chhwpEtHCH4chjgiLAvTNq5K8S7Nslm/aH27dTNAXUumb1hKs8py33/RpRIgQtv9/thShCoHKTd9nQ/fEo4NlA3CujjOSsLxwem5Ay0LnZRd6q68YA3SgRTjuL9CAKr9oPb7efijeb9X6VU9qWAf2aR4EzhjUZp66Fhgv3zOOTApnV0FSL6ldwaq5h5u7jRMzeQBV8nvgkMwwybJgcebsGy7Xvm2vMDA7t5803f4tKCWjz+uZNHaGKlH2Jf0QP+H+5Ys2g5kAozt5hS2vR/naaqyc7ZFEpmU9al9kILVpM4pvdw95l4GQy04FAb5pYqm4Y0/tyg160c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C5D3BCA2552294A8D6874CDFE1D41CB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac543df2-b4c1-4893-3480-08d6509a133a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 16:46:39.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5403
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMTEuMjAxOCAxNzoyMywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEhlbGxvIE1p
Y2hhbCwNCj4gDQo+IE9uIFRodSwgTm92IDIyLCAyMDE4IGF0IDAzOjQyOjE0UE0gKzAwMDAsIFZv
a8OhxI0gTWljaGFsIHdyb3RlOg0KPj4gT24gMTYuMTEuMjAxOCAwOToyNSwgVXdlIEtsZWluZS1L
w7ZuaWcgd3JvdGU6DQo+Pj4gT24gRnJpLCBOb3YgMTYsIDIwMTggYXQgMDg6MzQ6MzBBTSArMDEw
MCwgTG90aGFyIFdhw59tYW5uIHdyb3RlOg0KPj4+PiBOby4gWW91IGNhbiBkaXNhYmxlIHRoZSBv
dXRwdXQgZHJpdmVyIHZpYSBwaW5jdHJsLCBzbyB0aGF0IG9ubHkgdGhlDQo+Pj4+IHNlbGVjdGVk
IHB1bGwtdXAvZG93biBpcyByZWxldmFudC4gVGhlIHBpbiBmdW5jdGlvbiBhbmQgR1BJTyByZWdp
c3Rlcg0KPj4+PiBzZXR0aW5ncyBkb24ndCBtYXR0ZXIgYXQgYWxsIGluIHRoaXMgY2FzZS4NCj4+
DQo+PiBMb3RoYXIsIHBsZWFzZSBjYW4geW91IGJlIG1vcmUgc3BlY2lmaWMgaG93IHdvdWxkIHlv
dSBkbyB0aGF0PyBJRkFJSyB0aGUNCj4+IHB1bGwtdXAvZG93biBpbnRlcm5hbCByZXNpc3RvcnMg
aGF2ZSBlZmZlY3Qgb25seSBpZiB0aGUgcGluIGlzIGNvbmZpZ3VyZWQNCj4+IGFzIEdQSU8gKmlu
cHV0KiAob24gaS5NWDYgYXQgbGVhc3QpLiBTZWUgdGhlIFRSTSwgMjkuNC4yLjIgT3V0cHV0IGRy
aXZlcjoNCj4+DQo+PiAgICAiSW50ZXJuYWwgcHVsbC11cCwgcHVsbC1kb3duIHJlc2lzdG9ycywg
YW5kIHBhZCBrZWVwZXIgYXJlIGRpc2FibGVkIGluDQo+PiAgICAgb3V0cHV0IG1vZGUuIg0KPj4N
Cj4+PiBJcyB0aGlzIGFib3V0IERTRT1ISS1aIGluIHRoZSBwYWQgY29udHJvbCByZWdpc3Rlcj8g
SSBkaWRuJ3Qga25vdyBhYm91dA0KPj4+IHRoaXMuIEkgc2VlIHRoaXMgZXhpc3RzIG9uIGkuTVg2
IGJ1dCBub3Qgb24gaS5NWDI1LiBBbHNvIGkuTVg1MSBkb2Vzbid0DQo+Pj4gc2VlbSB0byBoYXZl
IHRoaXMgZmVhdHVyZS4NCj4+DQo+PiBVd2UsIEkgYWxzbyBkaWQgbm90IGZpbmQgdGhlIERTRSBv
cHRpb24gb24gb3RoZXIgU29DcyBpbiB0aGVpciByZXNwZWN0aXZlDQo+PiBtYW51YWxzIGFuZCBz
b3VyY2UgY29kZS4gQnV0IGV2ZW4gaWYgaXQgd291bGQgYmUgYXZhaWxhYmxlIG9uIGFsbCBTb0Nz
DQo+PiBJIHN0aWxsIHRoaW5rIGl0IGlzIG5vdCBlbm91Z2guDQo+IA0KPiBJZiBJIHVuZGVyc3Rh
bmQgTG90aGFyIGNvcnJlY3RseSBhbmQgdGhpcyBpcyBhYm91dCB0aGUgcGFkIGNvbnRyb2wNCj4g
cmVnaXN0ZXIsIHRoZXJlIGlzIG5vIG5lZWQgZm9yIHNvZnR3YXJlIHN1cHBvcnQuIFlvdSBqdXN0
IHNwZWNpZnkgdGhlDQo+IHZhbHVlIHlvdSB3YW50IHRvIGhhdmUgd3JpdHRlbiB0byB0aGUgcGFk
IHJlZ2lzdGVyIGluIHRoZSBkZXZpY2UgdHJlZS4NCg0KSSBhZ3JlZS4gQnV0IHRoZSBwYWQgY29u
dHJvbCByZWdpc3RlciBpcyBub3QgdGhlIG9uZSB0aGF0IGNvbnRyb2xzIGlmDQp0aGUgcGFkIGlz
IGNvbmZpZ3VyZWQgYXMgaW5wdXQgb3Igb3V0cHV0LiBTbyBpZiB0aGUgcGluIGhhcHBlbnMgdG8g
YmUNCmNvbmZpZ3VyZWQgYXMgb3V0cHV0IHRoZSBwdWxsL2tlZXBlciBzZXR0aW5nIHNpbXBseSBo
YXMgbm8gZWZmZWN0Lg0KDQo+IFNvIEknZCBleHBlY3QgdGhpcyB0byByZWFsbHkgd29yayBvbiBp
Lk1YNiBidXQgbm90IHRoZSBlYXJsaWVyIFNvQ3MNCj4gd2l0aG91dCBhIGdwaW8gc3BlY2lmaWVy
Lg0KDQpNYXliZSB5b3Ugd291bGQgZXhwZWN0IGl0IHRvIHdvcmsgYnV0IEkgYWxyZWFkeSB0ZXN0
ZWQgYW5kIG1lYXN1cmVkDQp0aGF0IHdlZWtzIGFnbyA7KSBJdCBkaWQgbm90IHdvcmsuDQoNCk1p
Y2hhbA0K
