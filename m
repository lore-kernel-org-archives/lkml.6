Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E7CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BA7206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="YJaq3CBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BA7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440231AbeKXB7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:59:52 -0500
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:18704
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394903AbeKXB7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p86VqWkhXYLzPA16C9fgQ3bzrivFIIaj0w+f9jI+rSA=;
 b=YJaq3CBEnPEpp8l2E7c4mCdTBeNArqzw+EfyRuCg8ajrbrK4i6EfWVmfpyEQAmtdwSFhFyLT0b7L9ZrYVBWwG0bvamp3u0YoZ31tfTjXcoAUgugF5ten/yKCFL78KhplFsSS+fVYSJ6/owAI3usqUeBh5YI+BYD4oGhj98lmUYM=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4489.eurprd04.prod.outlook.com (52.135.138.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Fri, 23 Nov 2018 15:15:12 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Fri, 23 Nov 2018
 15:15:11 +0000
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
Thread-Index: AQHUfX7SCRu1RfBnYE+mazOHv61qtqVSEQGAgAnn4ACAAAusgIAABlOAgAAmNICAAVKTgA==
Date:   Fri, 23 Nov 2018 15:15:11 +0000
Message-ID: <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
References: <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo> <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo> <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
 <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
 <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
In-Reply-To: <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0132.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::34) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4489;6:nOtJp2Sk3eW1K9AGKGblJs+qp3/Bw/f72CstU1MjQGf/oZN+f3f5BHVb9mKiIPBiIIi5MH4mfY667Hp6hXK38qxVMzUOfkgshckVp1WAd7TCdJ9F/oGD68XGta3OyjbDaHAcw7/xeB+LjeJLKCZpdB3AGi9uoy760Js7rIKZept26YDz1kj1+P5O7iwb0OWqJ0p58BVAiwcSx4Yn+p/KxCX3pJlx9d4aLSiZwKFg6k6BbTW7zzQLBod2YI0YVtOg7SUhHP5Mfw/bmPBLISpY6MLYjPJ+6UFsWLbpg38/l8pmICpGrGufszbmFLKT8h5OmtZoJQysW3o7K4M6h7yumy7s85lD3UbocXx9Y11WUewbE4GBFYMMUR0JAOeKPVEiY2tyZg2qsZGs4nG5nu8g/hmDaq4NjIzNi/GRqK9DI5X/aPL3IjjyCthISiOW+hEr5kYYd5jcBZiJZKnEJD95SQ==;5:uAn4yQrZoy082IreZjD0iR0oGzWQf4VI/OdyG3T8qfLD3STrFoJQro7VhQ0M3LygVwnI9TYTwPaZs03t0D+FgpHfOhuh7uIGc9mJhaVMdOgcTahcIGcK8ND21BK2icK2IWc44XMXj+KswohnFZ/tiRlHPomdZNbpc53/zKIWOgk=;7:j/RTqCsyHl5WIrq+mDts2HFf/iuY8QOEjFccIsTbO8ZRB2Pq8q1ByYFFjtcjzsshdfwdwLJsdCqx00a1Y0n6gHTke05mUhEp0qf0lv8EA2w95Mq+Y1XZgeUR8S83fPM3oSL1HkD652IeOdQlRq7Ojw==
x-ms-office365-filtering-correlation-id: 61009057-5b3d-4376-8bcd-08d65156765f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4489;
x-ms-traffictypediagnostic: DB7PR04MB4489:
x-microsoft-antispam-prvs: <DB7PR04MB4489FC817C4FE62EB725C6259ED40@DB7PR04MB4489.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4489;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4489;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39850400004)(366004)(376002)(136003)(189003)(199004)(85664002)(229853002)(6916009)(6436002)(305945005)(6486002)(7736002)(316002)(7416002)(2616005)(71190400001)(71200400001)(31696002)(72206003)(97736004)(486006)(25786009)(14444005)(81166006)(81156014)(66574009)(256004)(446003)(8936002)(11346002)(8676002)(86362001)(36756003)(476003)(478600001)(105586002)(26005)(85182001)(386003)(76176011)(53546011)(66066001)(31686004)(5660300001)(99286004)(102836004)(6506007)(14454004)(2900100001)(4326008)(53936002)(68736007)(6116002)(93886005)(52116002)(54906003)(106356001)(3846002)(2906002)(6246003)(6512007)(186003)(39060400002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4489;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: E6mavYH+HE1Vkdm5nXEPgZIN4v/NJsqQmgUR/C+r4XHAoquLoZQDJhwWuEFVbDvr9lDWtP2us9yS6nXYvcLwH6SiziXh84Z9hApMW/TwYcK4RU/ap0GAWdssIHofOn48QCnlwdmvrLPRmn1w6qN5mX6B8NdVJOYTiYPh1anLmobGChaj8nySmhsILwK4xSwO9dx3u3INNiHTnDV80wr9X/mf6orJC3JhFoUt/YxY8fnI28yQN/rthuzs85rDVx1o41N2pAEz8CX8b6Fahj3OjNSd8Bp1ISYtgfhRifD07mowATspLVex+Qh8sbdScSLk3OrNcfxWeIGm6UZMnEyktO6SYFRls3yFDyLD/PyNRIM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5589E540D28C4D4E9600DF710858549B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61009057-5b3d-4376-8bcd-08d65156765f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 15:15:11.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4489
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMTEuMjAxOCAyMDowMywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IE9uIFRodSwg
Tm92IDIyLCAyMDE4IGF0IDA0OjQ2OjM5UE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0K
Pj4gT24gMjIuMTEuMjAxOCAxNzoyMywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+Pj4gT24g
VGh1LCBOb3YgMjIsIDIwMTggYXQgMDM6NDI6MTRQTSArMDAwMCwgVm9rw6HEjSBNaWNoYWwgd3Jv
dGU6DQo+Pj4+IE9uIDE2LjExLjIwMTggMDk6MjUsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0K
Pj4+Pj4gT24gRnJpLCBOb3YgMTYsIDIwMTggYXQgMDg6MzQ6MzBBTSArMDEwMCwgTG90aGFyIFdh
w59tYW5uIHdyb3RlOg0KPj4+Pj4+IE5vLiBZb3UgY2FuIGRpc2FibGUgdGhlIG91dHB1dCBkcml2
ZXIgdmlhIHBpbmN0cmwsIHNvIHRoYXQgb25seSB0aGUNCj4+Pj4+PiBzZWxlY3RlZCBwdWxsLXVw
L2Rvd24gaXMgcmVsZXZhbnQuIFRoZSBwaW4gZnVuY3Rpb24gYW5kIEdQSU8gcmVnaXN0ZXINCj4+
Pj4+PiBzZXR0aW5ncyBkb24ndCBtYXR0ZXIgYXQgYWxsIGluIHRoaXMgY2FzZS4NCj4+Pj4NCj4+
Pj4gTG90aGFyLCBwbGVhc2UgY2FuIHlvdSBiZSBtb3JlIHNwZWNpZmljIGhvdyB3b3VsZCB5b3Ug
ZG8gdGhhdD8gSUZBSUsgdGhlDQo+Pj4+IHB1bGwtdXAvZG93biBpbnRlcm5hbCByZXNpc3RvcnMg
aGF2ZSBlZmZlY3Qgb25seSBpZiB0aGUgcGluIGlzIGNvbmZpZ3VyZWQNCj4+Pj4gYXMgR1BJTyAq
aW5wdXQqIChvbiBpLk1YNiBhdCBsZWFzdCkuIFNlZSB0aGUgVFJNLCAyOS40LjIuMiBPdXRwdXQg
ZHJpdmVyOg0KPj4+Pg0KPj4+PiAgICAgIkludGVybmFsIHB1bGwtdXAsIHB1bGwtZG93biByZXNp
c3RvcnMsIGFuZCBwYWQga2VlcGVyIGFyZSBkaXNhYmxlZCBpbg0KPj4+PiAgICAgIG91dHB1dCBt
b2RlLiINCj4gDQo+IFRoaXMgd291bGQgbWVhbiB5b3UnZCBoYXZlIHRvIHJlbHkgb24gYW4gZXh0
ZXJuYWwgcHVsbCB1cCBmb3IgeW91ciB1c2UNCj4gY2FzZS4gSSB3b3VsZG4ndCBiZSBzdXJwcmlz
ZWQgaG93ZXZlciBpZiBEU0U9MCB3b3VsZG4ndCBjb3VudCBhcyAib3V0cHV0DQo+IG1vZGUiLiBH
aXZlbiB0aGUgcmVsaWFiaWxpdHkgb2YgTlhQIGRvY3VtZW50YXRpb24gSSB3b3VsZG4ndCBiZXQg
bmVpdGhlcg0KPiBvbiBvbmUgbm9yIHRoZSBvdGhlciBwb3NzaWJpbGl0eS4NCg0KWWVhaCwgdGhl
IE5YUCBkb2N1bWVudGF0aW9uIHNvbWV0aW1lcyBkb2VzIG5vdCByZWFsbHkgbWF0Y2ggcmVhbGl0
eS4NCk15IHVzZSBjYXNlIGlzIGJhc2VkIG9uIHRoZSBmYWN0IHRoYXQgSSBjb25maWd1cmUgdGhl
IHBpbiBhcyBpbnB1dCBpbg0KdGhlIGRyaXZlci4gVGhlbiBpdCB3b3JrcyBqdXN0IGZpbmUuDQoN
Cj4+PiBTbyBJJ2QgZXhwZWN0IHRoaXMgdG8gcmVhbGx5IHdvcmsgb24gaS5NWDYgYnV0IG5vdCB0
aGUgZWFybGllciBTb0NzDQo+Pj4gd2l0aG91dCBhIGdwaW8gc3BlY2lmaWVyLg0KPj4NCj4+IE1h
eWJlIHlvdSB3b3VsZCBleHBlY3QgaXQgdG8gd29yayBidXQgSSBhbHJlYWR5IHRlc3RlZCBhbmQg
bWVhc3VyZWQNCj4+IHRoYXQgd2Vla3MgYWdvIDspIEl0IGRpZCBub3Qgd29yay4NCj4gDQo+IFdo
aWNoIHBpbi9ncGlvIGRvIHdlIHRhbGsgYWJvdXQ/IFdoaWNoIGkuTVg2IHZhcmlhbnQgZGlkIHlv
dSB0ZXN0IHRoaXMNCj4gb24/IChBc3N1bWluZyBpLk1YNkQgb3IgaS5NWDZRIGFuZCBQQURfRElT
UDBfREFUQTA5LCBkaWQgeW91IHRyeSBzZXR0aW5nDQo+IA0KPiAJSU9NVVhDX1NXX01VWF9DVExf
UEFEX0RJU1AwX0RBVEEwOSAoMHgwMjBFMDE5NCkgPSAweDAwMDAwMDA1DQo+IAlJT01VWENfU1df
UEFEX0NUTF9QQURfRElTUDBfREFUQTA5ICgweDAyMEUwNEE4KSA9IDB4MDAwMGIwODANCj4gDQo+
IGFuZCB0aGVuIHBsYXkgd2l0aCBHUElPIDQuMzAgZGlyZWN0aW9uIGFuZCBvdXRwdXQgdmFsdWU/
KQ0KDQpNeSB0ZXN0IHNldHVwIGlzIGFzIGZvbGxvd3M6DQotIFNvQyBpcyBpLk1YNkRMIG9yIGku
TVg2UyAtIEkgaGF2ZSB0aHJlZSBib2FyZCB2YXJpYW50cyBpbiB0b3RhbC4NCi0gUGluIHVzZWQg
Zm9yIFBXTS9HUElPIGlzIFBBRF9HUElPOS4NCi0gVGhlIHBpbiBpcyBub3QgY29ubmVjdGVkIHRv
IGFueSBjaXJjdWl0LiBKdXN0IGEgdGVzdCBwb2ludC4NCi0gcGluY3RybCBzZXR1cCBpbiBEVDoN
CiAgIC0gZm9yICJwd20iOg0KICAgICAtIGZzbCxwaW5zID0gPE1YNlFETF9QQURfR1BJT185X19Q
V00xX09VVCAweDg+DQogICAgIC0gSU9NVVhDX1NXX01VWF9DVExfUEFEX0dQSU8wOSA9IDB4MDAw
MDAwMDQNCiAgICAgLSBJT01VWENfU1dfUEFEX0NUTF9QQURfR1BJTzA5ID0gMHgwMDAwMDAwOA0K
DQogICAtIGZvciAiZ3BpbyI6DQogICAgLSBmc2wscGlucyA9IDxNWDZRRExfUEFEX0dQSU9fOV9f
R1BJTzFfSU8wOSAweGIwMDA+DQogICAgLSBJT01VWENfU1dfTVVYX0NUTF9QQURfR1BJTzA5ID0g
MHgwMDAwMDAwNQ0KICAgIC0gSU9NVVhDX1NXX1BBRF9DVExfUEFEX0dQSU8wOSA9IDB4MDAwMGIw
MDANCg0KVGVzdCBzY2VuYXJpbzoNCg0KLSBJbiBib290bG9hZGVyIGNvbmZpZ3VyZSB0aGUgcGlu
IGFzIEdQSU8gb3V0cHV0LCBzZXQgaXQgTE9XICgwVikuDQogICBJIHNldCBpdCBMT1cgdG8gc3Rh
cnQgaW4gdGhlIG9wb3NpdGUgc3RhdGUgdGhhbiBJIHdhbnQgdG8gZW5kIHVwIGluLg0KLSBCb290
IExpbnV4DQotIFVzZSBzeXNmcyB0byBjb25maWd1cmUgdGhlIFBXTSB0byBwcm9kdWNlIHNvbWUg
c2lnbmFsLg0KLSBJbiB0aGUgUFdNIGRyaXZlciBzZWxlY3QgdGhlICJwd20iIHBpbmN0cmwgc3Rh
dGUuDQotIE1lYXN1cmUgdGhlIG91dHB1dCAtIGV4cGVjdGVkIHdhdmVmb3JtIG9uIHRoZSBzY29w
ZS4NCi0gVXNlIHN5c2ZzIHRvIHN0b3AgdGhlIFBXTSAiZWNobyAwID4gL3N5cy9jbGFzcy9wd20v
cHdtY2hpcDAvcHdtMC9lbmFibGXCsA0KLSBJbiB0aGUgUFdNIGRyaXZlciBzZWxlY3QgdGhlICJn
cGlvIiBwaW5jdHJsIHN0YXRlLg0KLSBUaGVuIGluIHRoZSBQV00gZHJpdmVyOg0KDQphKSBub24t
d29ya2luZyB2YXJpYW50DQotIERvIG5vdCByZXF1ZXN0IHRoZSBHUElPIC0gc28gZG8gbm90IHRv
dWNoIGl0cyBwYWQgY29udHJvbCByZWcuDQogICBJdCBpcyBzZXQgYXMgb3V0cHV0IGZyb20gdGhl
IGJvb3Rsb2FkZXIsIGRhdGEgcmVnaXN0ZXIgPSAwLg0KLSBNZWFzdXJlIHZvbHRhZ2Ugb24gdGhl
IG91dHB1dA0KICAgLSBhZ2FpbnN0IEdORCA9IDBWDQogICAtIGFnYWluc3QgVkNDID0gMFYNCi0g
TWVhc3VyZSByZXNpc3RhbmNlIGFnYWluc3QgVkNDOiBIaS1aDQoNClRoZSBwaW4gaXMgaW4gSGkt
WiBtb2RlLiBUaGF0IGlzIGZpbmUgYnV0IHRoYXQgZG9lcyBub3Qgc2F0aXNmeSBhbnkNCmxvZ2lj
IGxldmVsLg0KDQpiKSB3b3JraW5nIHZhcmlhbnQNCi0gUmVxdWVzdCB0aGUgR1BJTywgY29uZmln
dXJlIGl0IGFzIGlucHV0Lg0KLSBNZWFzdXJlIHZvbHRhZ2Ugb24gdGhlIG91dHB1dA0KICAgLSBh
Z2FpbnN0IEdORCA9IFZDQyAoMy4zVikNCiAgIC0gYWdhaW5zdCBWQ0MgPSAwVg0KLSBNZWFzdXJl
IHJlc2lzdGFuY2UgYWdhaW5zdCBWQ0MgPSA5MS4xa09obQ0KDQpUaGUgcHVsbC11cCBpcyBhY3Rp
dmUuDQoNCkkgY2FuIHJlcGVhdCB0aGUgcmVzdWx0cyBvbiBib3RoIGkuTVg2REwgYW5kIGkuTVg2
UyBvbiBwd20xIGFuZCBwd200Lg0KQWxsIHB1bGwtdXAgYW5kIHB1bGwtZG93biBjb21iaW5hdGlv
bnMgZ2F2ZSBtZSB0aGUgZXhwZWN0ZWQgcmVzdWx0cw0Kb25seSBpZiB0aGUgcGluIGlzIGNvbmZp
Z3VyZWQgYXMgaW5wdXQuIFNvIGlmIEkgcmVwZWF0IHRoZSB0ZXN0IGFuZA0KZG8gbm90IHRvdWNo
IHRoZSBwaW4gaW4gYm9vdGxvYWRlciBhdCBhbGwsIGl0IHdvcmtzIGFzIHdlbGwgZXZlbiBpZg0K
SSBkbyBub3QgcmVxdWVzdC9jb25maWd1cmUgdGhlIEdQSU8gaW4gdGhlIFBXTSBkcml2ZXIuDQoN
CkJ1dCB3ZSBjYW4gbm90IHJlbHkgb24gdGhlIGZhY3QgdGhhdCB0aGUgcGluIGlzIGNvcnJlY3Rs
eSBjb25maWd1cmVkDQpmcm9tIGJvb3Rsb2FkZXIgb3IgdGhhdCBpdCBpcyBpbiB0aGUgYWZ0ZXIt
cmVzZXQgc3RhdGUuIEl0IHNob3VsZA0KanVzdCB3b3JrIHJlZ2FyZGxlc3Mgb2Ygd2hhdCBzdGF0
ZSBpdCB3YXMgbGVmdCBpbi4NCg0KQmVzdCByZWdhcmRzLA0KTWljaGFsDQo=
