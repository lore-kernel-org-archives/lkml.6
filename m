Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D299C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942520865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="R28M9jPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6942520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeK0Cp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:45:27 -0500
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:50291
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbeK0Cp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb9vgycwH0zeX8htmUDki2v3nqyDRWlU4ThEJ/0o7Gw=;
 b=R28M9jPbvEkNRwf8+clsKJeO5FDDwnHxXaqjiAykWcc1NeH4HKtkAN1BIDRhn1VmC5AnwNV15I1Jzj1EXQTUZ8CRcth7DGG5jdMlbhw9qvUsqRfBSYfgt6q3y0WPsMVucoLoDEfFFE0Ibe+3Phf/3C1XcrIPWzjQxSAZcePe7Mo=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5114.eurprd04.prod.outlook.com (20.176.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Mon, 26 Nov 2018 15:50:49 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Mon, 26 Nov 2018
 15:50:49 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
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
Thread-Index: AQHUfX7SCRu1RfBnYE+mazOHv61qtqVSEQGAgAnn4ACAAAusgIAABlOAgAAmNICAAVKTgIAEfhCAgAAI6ACAABP0gIAAJgeA
Date:   Mon, 26 Nov 2018 15:50:49 +0000
Message-ID: <f417d672-4335-13f3-1525-d43003740018@ysoft.com>
References: <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
 <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
 <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
 <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
 <20181126115123.GA15164@ulmo> <20181126132316.541a4131@ipc1.ka-ro>
 <20181126133441.GA19710@ulmo>
In-Reply-To: <20181126133441.GA19710@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0049.eurprd07.prod.outlook.com
 (2603:10a6:203:2::11) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5114;6:YeNySXd+IoEd0AJhjSFGCwNq7QxAn/KJtca0vDgdF5qt0qjz2rkwF9no0MdpLj12W/haNaTR2I2VoUrR26uPkHWrhojm6/wH2vI0QZAT3KywReqwJFJc4eMcmxaja3+6xZj5rPOpBkqXvnXDZSuK3n2sT3xQhLzStQKHgJU4D9pVX5kQ940Naqrfo7x50hoZW70fQDo4TyT3OkpD7dEWLR6DYHOTBxJH8YwhGELuQX8t1ioEWr6m3bDaK1ivqMmv6SgttUUtxD6CP1v6PCnnEW0eObRX5+rqz18fPz/iJ1RBhrWSSmQTn0BNrR4IvvRll/yrUDf0wcWMVkr/qyZsJIQdsjAw8uDYcRWrqeDzVWrF9yKlWH7FRC4nDbgitNCkUSBqygdK7Dgm7wWQ5nxCtRjyWp4+jKMyP7Yr/+3YKwo9yMY6huALKGut766edhbYe863LA2/uBcQTqEIHt5OqA==;5:FEI6+ICjM7tMbZH4OLyhAQYR/lw5YKlEDnxICtN8lo9x4E6GQwvHGroAcp0UbWhkUX/uCKxQiAawo4UZprWG3ixjFsa3f/Qk0YMOk0BWkghnNy+aACMwqa5mAkIeOdJ0dSvpWyooF8nTC7iZ5vQnhJFTkenRiB+wseWcp0QRaxI=;7:wWaoX53yIQZIqFgDYF9wJJu0Oz2pxAMa2309pNXHzU4YmZJW7Z/+E9oYdPxMv3F/eaKVHwxN19p2iUXb2KUOdHW6Yth/fM3eFkaMhI8jUuhqKLiU76W0NYzHp51zRE7HaHdhNMFP2Y0SDoQXg/LsOw==
x-ms-office365-filtering-correlation-id: 12e41a5f-2fac-408d-b983-08d653b6efa9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5114;
x-ms-traffictypediagnostic: DB7PR04MB5114:
x-microsoft-antispam-prvs: <DB7PR04MB51145474F365A6CD85827DD49ED70@DB7PR04MB5114.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5114;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5114;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(366004)(346002)(136003)(85664002)(199004)(189003)(6916009)(305945005)(5660300001)(11346002)(7736002)(99286004)(36756003)(68736007)(446003)(85182001)(86362001)(7416002)(71190400001)(71200400001)(6436002)(54906003)(6486002)(2616005)(476003)(486006)(229853002)(66066001)(25786009)(256004)(14444005)(31696002)(478600001)(72206003)(4326008)(6246003)(97736004)(316002)(53936002)(81156014)(81166006)(8676002)(39060400002)(6512007)(3846002)(8936002)(106356001)(2906002)(105586002)(386003)(6506007)(26005)(102836004)(53546011)(52116002)(76176011)(66574009)(6116002)(186003)(14454004)(93886005)(31686004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5114;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1V1cse+onjuj4SumX+8tObej0qeXl/ooAQMo2lXpB7Nx9dcNcYPJ4JnRRv6ao+cYL+r3hSgr7/I1pUOGwfqG/vAlW3Th4nbQLfCEMGxWxq/VAETOnt4DqTR+9K0TuccPWZ7jScZ4Kh9qwfeIbiyaFkbKHZc5A763XCVSpafLZWzM5z8q9+MjGQhdiuAwPUL77CrzBLArg29fH0ZXdAt06e38l4m0Kgrb333W8u4byZAsrsC+74KxnnHzoAnlR933hR8vGZk0bbJHR9XsRa1juFaRlK8O07Phj7hX9jl8VVSxBz2SKIotqk7rZVDAM529HmdnBl73lmlLo9w6AGohx3on/C2AGFGfMiz298OH7A4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <68A86F31AB514F4AB494D2F801F9FD76@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e41a5f-2fac-408d-b983-08d653b6efa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 15:50:49.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMTEuMjAxOCAxNDozNCwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6DQo+IE9uIE1vbiwgTm92
IDI2LCAyMDE4IGF0IDAxOjIzOjE2UE0gKzAxMDAsIExvdGhhciBXYcOfbWFubiB3cm90ZToNCj4+
IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+
PiBPbiBGcmksIE5vdiAyMywgMjAxOCBhdCAwMzoxNToxMVBNICswMDAwLCBWb2vDocSNIE1pY2hh
bCB3cm90ZToNCj4+Pj4gT24gMjIuMTEuMjAxOCAyMDowMywgVXdlIEtsZWluZS1Lw7ZuaWcgd3Jv
dGU6DQo+Pj4+PiBPbiBUaHUsIE5vdiAyMiwgMjAxOCBhdCAwNDo0NjozOVBNICswMDAwLCBWb2vD
ocSNIE1pY2hhbCB3cm90ZToNCj4+Pj4+PiBPbiAyMi4xMS4yMDE4IDE3OjIzLCBVd2UgS2xlaW5l
LUvDtm5pZyB3cm90ZToNCj4+Pj4+Pj4gT24gVGh1LCBOb3YgMjIsIDIwMTggYXQgMDM6NDI6MTRQ
TSArMDAwMCwgVm9rw6HEjSBNaWNoYWwgd3JvdGU6DQo+Pj4+Pj4+PiBPbiAxNi4xMS4yMDE4IDA5
OjI1LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4+Pj4+Pj4+PiBPbiBGcmksIE5vdiAxNiwg
MjAxOCBhdCAwODozNDozMEFNICswMTAwLCBMb3RoYXIgV2HDn21hbm4gd3JvdGU6DQo+Pj4+Pj4+
Pj4+IE5vLiBZb3UgY2FuIGRpc2FibGUgdGhlIG91dHB1dCBkcml2ZXIgdmlhIHBpbmN0cmwsIHNv
IHRoYXQgb25seSB0aGUNCj4+Pj4+Pj4+Pj4gc2VsZWN0ZWQgcHVsbC11cC9kb3duIGlzIHJlbGV2
YW50LiBUaGUgcGluIGZ1bmN0aW9uIGFuZCBHUElPIHJlZ2lzdGVyDQo+Pj4+Pj4+Pj4+IHNldHRp
bmdzIGRvbid0IG1hdHRlciBhdCBhbGwgaW4gdGhpcyBjYXNlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+
IExvdGhhciwgcGxlYXNlIGNhbiB5b3UgYmUgbW9yZSBzcGVjaWZpYyBob3cgd291bGQgeW91IGRv
IHRoYXQ/IElGQUlLIHRoZQ0KPj4+Pj4+Pj4gcHVsbC11cC9kb3duIGludGVybmFsIHJlc2lzdG9y
cyBoYXZlIGVmZmVjdCBvbmx5IGlmIHRoZSBwaW4gaXMgY29uZmlndXJlZA0KPj4+Pj4+Pj4gYXMg
R1BJTyAqaW5wdXQqIChvbiBpLk1YNiBhdCBsZWFzdCkuIFNlZSB0aGUgVFJNLCAyOS40LjIuMiBP
dXRwdXQgZHJpdmVyOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICAgICAgIkludGVybmFsIHB1bGwtdXAs
IHB1bGwtZG93biByZXNpc3RvcnMsIGFuZCBwYWQga2VlcGVyIGFyZSBkaXNhYmxlZCBpbg0KPj4+
Pj4+Pj4gICAgICAgb3V0cHV0IG1vZGUuIg0KPj4+Pj4NCj4+Pj4+IFRoaXMgd291bGQgbWVhbiB5
b3UnZCBoYXZlIHRvIHJlbHkgb24gYW4gZXh0ZXJuYWwgcHVsbCB1cCBmb3IgeW91ciB1c2UNCj4+
Pj4+IGNhc2UuIEkgd291bGRuJ3QgYmUgc3VycHJpc2VkIGhvd2V2ZXIgaWYgRFNFPTAgd291bGRu
J3QgY291bnQgYXMgIm91dHB1dA0KPj4+Pj4gbW9kZSIuIEdpdmVuIHRoZSByZWxpYWJpbGl0eSBv
ZiBOWFAgZG9jdW1lbnRhdGlvbiBJIHdvdWxkbid0IGJldCBuZWl0aGVyDQo+Pj4+PiBvbiBvbmUg
bm9yIHRoZSBvdGhlciBwb3NzaWJpbGl0eS4NCj4+Pj4NCj4+Pj4gWWVhaCwgdGhlIE5YUCBkb2N1
bWVudGF0aW9uIHNvbWV0aW1lcyBkb2VzIG5vdCByZWFsbHkgbWF0Y2ggcmVhbGl0eS4NCj4+Pj4g
TXkgdXNlIGNhc2UgaXMgYmFzZWQgb24gdGhlIGZhY3QgdGhhdCBJIGNvbmZpZ3VyZSB0aGUgcGlu
IGFzIGlucHV0IGluDQo+Pj4+IHRoZSBkcml2ZXIuIFRoZW4gaXQgd29ya3MganVzdCBmaW5lLg0K
Pj4+PiAgICANCj4+Pj4+Pj4gU28gSSdkIGV4cGVjdCB0aGlzIHRvIHJlYWxseSB3b3JrIG9uIGku
TVg2IGJ1dCBub3QgdGhlIGVhcmxpZXIgU29Dcw0KPj4+Pj4+PiB3aXRob3V0IGEgZ3BpbyBzcGVj
aWZpZXIuDQo+Pj4+Pj4NCj4+Pj4+PiBNYXliZSB5b3Ugd291bGQgZXhwZWN0IGl0IHRvIHdvcmsg
YnV0IEkgYWxyZWFkeSB0ZXN0ZWQgYW5kIG1lYXN1cmVkDQo+Pj4+Pj4gdGhhdCB3ZWVrcyBhZ28g
OykgSXQgZGlkIG5vdCB3b3JrLg0KPj4+Pj4NCj4+Pj4+IFdoaWNoIHBpbi9ncGlvIGRvIHdlIHRh
bGsgYWJvdXQ/IFdoaWNoIGkuTVg2IHZhcmlhbnQgZGlkIHlvdSB0ZXN0IHRoaXMNCj4+Pj4+IG9u
PyAoQXNzdW1pbmcgaS5NWDZEIG9yIGkuTVg2USBhbmQgUEFEX0RJU1AwX0RBVEEwOSwgZGlkIHlv
dSB0cnkgc2V0dGluZw0KPj4+Pj4NCj4+Pj4+IAlJT01VWENfU1dfTVVYX0NUTF9QQURfRElTUDBf
REFUQTA5ICgweDAyMEUwMTk0KSA9IDB4MDAwMDAwMDUNCj4+Pj4+IAlJT01VWENfU1dfUEFEX0NU
TF9QQURfRElTUDBfREFUQTA5ICgweDAyMEUwNEE4KSA9IDB4MDAwMGIwODANCj4+Pj4+DQo+Pj4+
PiBhbmQgdGhlbiBwbGF5IHdpdGggR1BJTyA0LjMwIGRpcmVjdGlvbiBhbmQgb3V0cHV0IHZhbHVl
PykNCj4+Pj4NCj4+Pj4gTXkgdGVzdCBzZXR1cCBpcyBhcyBmb2xsb3dzOg0KPj4+PiAtIFNvQyBp
cyBpLk1YNkRMIG9yIGkuTVg2UyAtIEkgaGF2ZSB0aHJlZSBib2FyZCB2YXJpYW50cyBpbiB0b3Rh
bC4NCj4+Pj4gLSBQaW4gdXNlZCBmb3IgUFdNL0dQSU8gaXMgUEFEX0dQSU85Lg0KPj4+PiAtIFRo
ZSBwaW4gaXMgbm90IGNvbm5lY3RlZCB0byBhbnkgY2lyY3VpdC4gSnVzdCBhIHRlc3QgcG9pbnQu
DQo+Pj4+IC0gcGluY3RybCBzZXR1cCBpbiBEVDoNCj4+Pj4gICAgIC0gZm9yICJwd20iOg0KPj4+
PiAgICAgICAtIGZzbCxwaW5zID0gPE1YNlFETF9QQURfR1BJT185X19QV00xX09VVCAweDg+DQo+
Pj4+ICAgICAgIC0gSU9NVVhDX1NXX01VWF9DVExfUEFEX0dQSU8wOSA9IDB4MDAwMDAwMDQNCj4+
Pj4gICAgICAgLSBJT01VWENfU1dfUEFEX0NUTF9QQURfR1BJTzA5ID0gMHgwMDAwMDAwOA0KPj4+
Pg0KPj4+PiAgICAgLSBmb3IgImdwaW8iOg0KPj4+PiAgICAgIC0gZnNsLHBpbnMgPSA8TVg2UURM
X1BBRF9HUElPXzlfX0dQSU8xX0lPMDkgMHhiMDAwPg0KPj4+PiAgICAgIC0gSU9NVVhDX1NXX01V
WF9DVExfUEFEX0dQSU8wOSA9IDB4MDAwMDAwMDUNCj4+Pj4gICAgICAtIElPTVVYQ19TV19QQURf
Q1RMX1BBRF9HUElPMDkgPSAweDAwMDBiMDAwDQo+Pj4NCj4+PiBEb2VzIGl0IGhlbHAgaWYgeW91
IGFkZGl0aW9uYWxseSBzZXQgdGhlIE9ERSBiaXQgKGJpdCAxMSkgaGVyZT8NCj4+Pg0KPj4gVGhh
dCBvbmx5IGhlbHBzIHRvIE5PVCBhY3RpdmVseSBwdWxsaW5nIHRoZSBwaW4gSElHSCwgYnV0IHRo
ZSBvcHBvc2l0ZQ0KPj4gaXMgd2hhdCBpcyBuZWVkZWQgaGVyZS4NCj4gDQo+ICBGcm9tIHRoZSBk
ZXNjcmlwdGlvbiBpbiB0aGUgcmVmZXJlbmNlIG1hbnVhbCBpdCBzb3VuZGVkIGxpa2UgdGhlIE9E
RQ0KPiB3b3VsZCBhdm9pZCB0aGUgcGluIGZyb20gYWN0aXZlbHkgYmVpbmcgZHJpdmVuIGFueXdo
ZXJlIGlmIGNvbmZpZ3VyZWQgYXMNCj4gb3V0cHV0LiBTbyBJIHdhcyBob3BpbmcgdGhhdCBpbiBj
b25qdW5jdGlvbiB3aXRoIHRoZSBwdWxsLXVwIGl0IHdvdWxkDQo+IGFjdHVhbGx5IGRvIHRoZSBy
aWdodCB0aGluZy4NCg0KTm90IGV4YWN0bHkuIEkgdGVzdGVkL21lYXN1cmVkIHRoaXMgYW5kIHRo
ZSBPREUgc2V0dGluZyB3b3JrcyBsaWtlDQpMb3RoYXIgc2FpZC4NCg0KSWYgT0RFPTEgYW5kIEdQ
SU8gaXMgaW4gb3V0cHV0IG1vZGU6DQoNCi0gVGhlIGludGVybmFsIHB1bGwgcmVzaXN0b3JzIGFy
ZSBlbmFibGVkIGV2ZW4gaWYgUEtFPTAgKHB1bGwva2VlcGVyDQogICBpcyBkaXNhYmxlZCkuIFRo
YXQncyBuZXdzIHRvIG1lIGJ1dCBpdCBhY3R1YWxseSBtYXRjaGVzIHRoZSBHUElPIHBhZA0KICAg
ZnVuY3Rpb25hbCBkaWFncmFtLiBTZWUgRmlndXJlIDI5LTMgaW4gUk0uDQoNCi0gSWYgdGhlIEdQ
SU8gb3V0cHV0IGlzIHNldCBMT1csIHRoZSBvdXRwdXQgaXMgYWN0aXZlbHkgcHVsbGVkIGRvd24g
YnkNCiAgIHRoZSBsb3cgc2lkZSB0cmFuc2lzdG9yLg0KDQotIElmIHRoZSBHUElPIG91dHB1dCBp
cyBzZXQgSElHSCB0aGUgb3V0cHV0IGlzIHBhc3NpdmVseSBwdWxsZWQgdXAgYnkNCiAgIHRoZSBp
bnRlcm5hbCBwdWxsLXVwIHJlc2lzdG9yLiBUaGUgdmFsdWUgb2YgdGhlIHJlc2lzdG9yIGNhbiBi
ZQ0KICAgc2VsZWN0ZWQgYnkgUFVTIGFuZCBJIGFtIGFibGUgdG8gbWVhc3VyZSBpdC4NCg0KVGhh
dCBkb2VzIG5vdCBzb2x2ZSB0aGUgaXNzdWUgdGhhdCB0aGUgcGluIG1heSBtZSBjb25maWd1cmVk
IGFzIG91dHB1dA0KYW5kIHNldCBMT1cgZnJvbSBib290bG9hZGVyIHRob3VnaC4NCg0KTWljaGFs
DQo=
