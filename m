Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B206720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="HXBIAp/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B206720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeLJLib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:38:31 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:34386
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeLJLia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUyYUZZoeI3OyaBAasalzYb2Zy1UNTddp3AOb1HqHjw=;
 b=HXBIAp/+/NndCmMQz0G/E7lpTMQZiliqgT3En25KIH4KcGzqurmuDSTbLfyZE8SbuJt0XEZhiVWBlbERKIwAAtrybWUDGK6Jj1o3ZuIR20wukmIHC5X2rdQ+WhGGQR6nyw8MP35L30hVYTL7qR56C+x0y9u4JT+TTUofATV5goo=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4602.eurprd04.prod.outlook.com (52.135.138.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 11:38:25 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 11:38:25 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in disabled
 state
Thread-Topic: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Thread-Index: AQHUjWllpnSfybe6SEqAejrjFKHx0aVxvNwAgAAbnoCAAArBAIAF9SIAgAAAxACAAAXDAA==
Date:   Mon, 10 Dec 2018 11:38:25 +0000
Message-ID: <8295c13f-9381-d994-71d4-f4fc350804fd@ysoft.com>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
 <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
 <20181206161622.okpfiecfphar77jk@pengutronix.de>
 <8b88d225-efc7-623a-d1a6-8b3cfcfd5e07@ysoft.com>
 <20181210111746.36zyedeaajfcdfeh@pengutronix.de>
In-Reply-To: <20181210111746.36zyedeaajfcdfeh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0017.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::30) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4602;6:VBfkEL9srgeolSFL4FQCbMoNaVCKCxomvFsHPMESPYzn/C/7AqqfYrJFfeNo+BQhlR3aT7N3aL1n4aiZYLa7oD3KvxaWKomQlY8AbWuYVrJC2+t4ziA1RyQ96IsXEyMhH4oCi6SzlcehZIoYa1+lpjP1Vwkq3nbgP5dT/wZktT/DAGJYmxf/PzADl2JYc86rjrGBwv8nt2frnspOcf6h70sBnvwU0NGPk2Z3D2QImbglLM1DsFxQP0UMg1unJaFIgnZUufEMS7gWjX09pMXbsn+mM5751Ix4xO7JZHeLbzhXKN3dQEdKv8/MfguoRP+2gMbO96L4vCFVIIYKWaKmw35rXlnqAfaxFOyk2DJMkdy2gJgQxavJmXnwxi80QdLFRMwdoIc79MpPe92AOHsNHENGQv72mQnE8xBQZHYMtFVT5uBxwcTKOy/+G1pfWTgXvGVLF/S4oTT2NNFmv13woQ==;5:ybHjJABveUJ11zORFXFt9+muG0KeJCWC/ldIW0wwyWXnXHwlFBHcWmDNH+MA7LOluyzDLtcxc5c3HZJjP+LyxcgJYR4TSlKyzW7Q0iL3jLb4c9Qx8l2eO+iR8H2qu/cm0sat+aevPlWJUX4/oQlqGEJf17bRGVOLEgzrqujZgwI=;7:ovWNodUB5GtmsgXMVuCFjNkuo7WPLmMJcYeWoomqH81aFqrsDEkoexNpcQm9oyWRj+Ja3BrOMd+y7geVVG90rjKyJnvGRrntMo83z4GhUmO/innqG7bVBRvPcnaT3gwayTC6hx/4DXWYqimjWniRGA==
x-ms-office365-filtering-correlation-id: 08e1bfe3-9bfa-4962-029c-08d65e93ff37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4602;
x-ms-traffictypediagnostic: DB7PR04MB4602:
x-microsoft-antispam-prvs: <DB7PR04MB46025A3A5EB922BB306FFDED9EA50@DB7PR04MB4602.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4602;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4602;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39850400004)(136003)(366004)(51444003)(199004)(189003)(11346002)(68736007)(386003)(53936002)(39060400002)(476003)(31696002)(76176011)(7416002)(66066001)(2616005)(6506007)(86362001)(93886005)(99286004)(6916009)(229853002)(6246003)(85182001)(5660300001)(36756003)(105586002)(52116002)(31686004)(14444005)(106356001)(446003)(2906002)(305945005)(256004)(486006)(7736002)(478600001)(71200400001)(71190400001)(6486002)(25786009)(6436002)(4326008)(102836004)(316002)(186003)(6512007)(53546011)(26005)(66574011)(14454004)(3846002)(72206003)(6116002)(8936002)(217873002)(81156014)(81166006)(8676002)(54906003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4602;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TXd3Y660XcrKPkGSuOCxT9XU45eqFjYdRwrWPoFCEUK2pa2SSvWGNNdUOopucgSDP7SeBHb2GXUjMcneyhpVM2Rt7jIkgABU8MZf5NpGgGFpu7Ml4DOPCZJFU4RpmwTuYwUwstPbUTTnudICRlIdB9w+1nu8ERqjrSodUl/VjfDy3exB07xzwXPc+2iaK+MZ4VYa1KpTfh6txRvTMEgjvAgL8Ztho9vHbc2oR+D/8RsoJecquekW+et64ORSlc3xlqdrwRFo+0ie6zF5GAOrgeXALWQT/GRzXrsWqSX07TYUf+a4n10XGjczeZclb822
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7D44DB7A2FCAC41ABA898D8F749031D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e1bfe3-9bfa-4962-029c-08d65e93ff37
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 11:38:25.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMTIuMjAxOCAxMjoxNywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IE9uIE1vbiwg
RGVjIDEwLCAyMDE4IGF0IDExOjE1OjA1QU0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0K
Pj4gT24gNi4xMi4yMDE4IDE3OjE2LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4+PiBPbiBU
aHUsIERlYyAwNiwgMjAxOCBhdCAwMzozNzo1NVBNICswMDAwLCBWb2vDocSNIE1pY2hhbCB3cm90
ZToNCj4+Pj4gT24gNi4xMi4yMDE4IDE0OjU5LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4+
Pj4+IE9uIFRodSwgRGVjIDA2LCAyMDE4IGF0IDAxOjQxOjMxUE0gKzAwMDAsIFZva8OhxI0gTWlj
aGFsIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IENhbiBpdCBoYXBwZW4sIHRoYXQgcGluY3RybF9waW5z
X3B3bSBpcyBQVFJfRVJSKC1FUFJPQkVfREVGRVIpPw0KPj4+Pg0KPj4+PiBOby4gVGhlIHBpbmN0
cmxfbG9va3VwX3N0YXRlIGVpdGhlciByZXR1cm5zIHBvaW50ZXIgdG8gdGhlIHBpbmN0cmwgc3Rh
dGUNCj4+Pj4gb3IgRVJSX1BUUigtRU5PREVWKS4gQnV0IEkgZG8gbm90IGV4cGxpY2l0bHkgdGVz
dCB0aGUgcGluY3RybF9waW5zX3B3bQ0KPj4+PiBmb3IgUFRSX0VSUigtRVBST0JFX0RFRkVSKSwg
b3IgZG8gST8NCj4+Pg0KPj4+IFlvdSBkb24ndCwgSSBqdXN0IHdvbmRlcmVkIGlmIHRoaXMgY291
bGQgaGFwcGVuIGFuZCB0aGUgZnVuY3Rpb24gc2hvdWxkDQo+Pj4gcmV0dXJuIC1FUFJPQkVfREVG
RVIgaW4gdGhpcyBjYXNlLCB0b28uDQo+Pg0KPj4gT0suDQo+Pg0KPj4+Pj4gTWF5YmUgeW91IG9u
bHkgd2FudCB0byBpZ25vcmUgUFRSX0VSUigtRU5PREVWKSBhbmQgZm9yIGV4YW1wbGUgcHJvcGFn
YXRlDQo+Pj4+PiAtRUlPPyBJIHRoaW5rIHlvdSB3YW50IHRvIHB1dCB0aGUgZ3BpbyBpZiB0aGUg
ZmFpbHVyZSBpcyBiZWNhdXNlIHRoZXJlDQo+Pj4+PiBpcyBhIHBpbmN0cmwgcmVsYXRlZCBlcnJv
ci4NCj4+Pj4NCj4+Pj4gSSB0aGluayB0aGF0IGlzIHdoYXQgSSBhbSBkb2luZy4gSW4gY2FzZSB0
aGUgR1BJTyBpcyBub3QgcmVhZHkgdGhlIHByb2JlDQo+Pj4+IGlzIGRlZmVycmVkLiBJbiBjYXNl
IG9mIGFueSBvdGhlciBlcnJvciB3aXRoIHRoZSBHUElPIG9yIHBpbmN0cmwgZmFpbHVyZQ0KPj4+
PiBJIHB1dCB0aGUgcGluY3RybC4gT3IgbWF5YmUgSSBkbyBub3QgcmVhbGx5IHVuZGVyc3RhbmQg
d2hhdCB5b3UgbWVhbi4NCj4+Pg0KPj4+IFllcywgeW91IHB1dCB0aGUgcGluY3RybCwgYnV0IG5v
dCB0aGUgR1BJTy4gSS5lLiB5b3UncmUgbm90IHVuZG9pbmcNCj4+PiBkZXZtX2dwaW9kX2dldF9v
cHRpb25hbCgpLiBNYXliZSBvbmx5IGRvIHRoaXMgaWYgdGhlIHBpbmN0cmwgc3R1ZmYNCj4+PiBz
dWNjZWVkZWQgdG8gbm90IHRvdWNoIHRoZSBHUElPIGlmIGl0IHdvbid0IGJlIHVzZWQ/DQo+Pg0K
Pj4gT0ssIEkgYWdyZWUgaXQgc2VlbXMgYmV0dGVyIHRvIGdldCB0aGUgcGluY3RybCBmaXJzdCBh
bmQgaWYgaXQgc3VjY2VlZHMNCj4+IG9ubHkgdGhlbiB0cnkgdG8gZ2V0IHRoZSBHUElPLiBJbiB0
aGF0IGNhc2UgSSBuZWVkIHRvIHVzZSB0aGUgbm9uLW9wdGlvbmFsDQo+PiB2YXJpYW50IG9mIGRl
dm1fZ3Bpb19nZXQoKS4gTm90ZSB0aGF0IHRoZW4gSSBkbyBub3QgcmVhbGx5IG5lZWQgdG8gcHV0
IHRoZQ0KPj4gR1BJTyBpbiB0aGUgZXJyb3IgcGF0aCBhcyBpdCBtZWFucyBJIGRpZCBub3QgZ2V0
IGl0Lg0KPj4gVGhlIGNvZGUgd291bGQgbG9vayBsaWtlOg0KPj4NCj4+ICtzdGF0aWMgaW50IGlt
eF9wd21faW5pdF9waW5jdHJsX2luZm8oc3RydWN0IGlteF9jaGlwICppbXhfY2hpcCwNCj4+ICsJ
CQkJICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICt7DQo+PiArCWlteF9j
aGlwLT5waW5jdHJsID0gZGV2bV9waW5jdHJsX2dldCgmcGRldi0+ZGV2KTsNCj4+ICsJaWYgKElT
X0VSUihpbXhfY2hpcC0+cGluY3RybCkpIHsNCj4+ICsJCWRldl9kYmcoJnBkZXYtPmRldiwgImNh
biBub3QgZ2V0IHBpbmN0cmxcbiIpOw0KPj4gKwkJcmV0dXJuIFBUUl9FUlIoaW14X2NoaXAtPnBp
bmN0cmwpOw0KPj4gKwl9DQo+PiArDQo+PiArCWlteF9jaGlwLT5waW5jdHJsX3BpbnNfcHdtID0g
cGluY3RybF9sb29rdXBfc3RhdGUoaW14X2NoaXAtPnBpbmN0cmwsDQo+PiArCQkJCQkJCSAgInB3
bSIpOw0KPj4gKwlpbXhfY2hpcC0+cGluY3RybF9waW5zX2dwaW8gPSBwaW5jdHJsX2xvb2t1cF9z
dGF0ZShpbXhfY2hpcC0+cGluY3RybCwNCj4+ICsJCQkJCQkJICAgImdwaW8iKTsNCj4+ICsNCj4+
ICsJaWYgKElTX0VSUihpbXhfY2hpcC0+cGluY3RybF9waW5zX3B3bSkgfHwNCj4+ICsJICAgIElT
X0VSUihpbXhfY2hpcC0+cGluY3RybF9waW5zX2dwaW8pKSB7DQo+PiArCQlkZXZfZGJnKCZwZGV2
LT5kZXYsICJwaW5jdHJsIGluZm9ybWF0aW9uIGluY29tcGxldGVcbiIpOw0KPj4gKwkJZ290byBv
dXQ7DQo+PiArCX0NCj4+ICsNCj4+ICsJaW14X2NoaXAtPnB3bV9ncGlvZCA9IGRldm1fZ3Bpb2Rf
Z2V0KCZwZGV2LT5kZXYsICJwd20iLCBHUElPRF9JTik7DQo+PiArCWlmIChQVFJfRVJSKGlteF9j
aGlwLT5wd21fZ3Bpb2QpID09IC1FUFJPQkVfREVGRVIpIHsNCj4+ICsJCXJldHVybiAtRVBST0JF
X0RFRkVSOw0KPj4gKwl9IGVsc2UgaWYgKElTX0VSUihpbXhfY2hpcC0+cHdtX2dwaW9kKSkgew0K
Pj4gKwkJZGV2X2RiZygmcGRldi0+ZGV2LCAiR1BJTyBpbmZvcm1hdGlvbiBpbmNvbXBsZXRlXG4i
KTsNCj4+ICsJCWdvdG8gb3V0Ow0KPj4gKwl9DQo+PiArDQo+PiArCXJldHVybiAwOw0KPj4gKw0K
Pj4gK291dDoNCj4+ICsJZGV2bV9waW5jdHJsX3B1dChpbXhfY2hpcC0+cGluY3RybCk7DQo+PiAr
CWlteF9jaGlwLT5waW5jdHJsID0gTlVMTDsNCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0K
PiANCj4gVGhpcyBsb29rcyByaWdodC4NCg0KV293LCB5b3UncmUgcXVpY2shIE9LLCB0aGFua3Mu
DQoNCj4+Pj4+IElTVFIgdGhhdCB0aGVyZSB3YXMgYSBwYXRjaCB0aGF0IGltcGxlbWVudHMgZ2V0
X3N0YXRlIGZvciBpbXguIElzIHRoZXJlDQo+Pj4+PiBhIGRlcGVuZGVuY3kgb24gdGhhdCBvbmU/
IE90aGVyd2lzZSB0aGUgc3RhdGUgcmV0dXJuZWQgYnkNCj4+Pj4+IHB3bV9nZXRfc3RhdGUoKSBt
aWdodCBub3QgYmUgd2hhdCBpcyBhY3R1YWxseSBjb25maWd1cmVkLg0KPj4+Pg0KPj4+PiBObywg
aXQgc2hvdWxkIGJlIGluZGVwZW5kZW50LiBPbmUgY2FuIGdvIHdpdGhvdXQgdGhlIG90aGVyLiBJ
IHRlc3RlZCBhbGwNCj4+Pj4gdGhyZWUgY29tYmluYXRpb25zIChtYWlubGluZSB3aXRoIC5nZXRf
c3RhdGUsIG1haW5saW5lIHdpdGggdGhpcyBzZXJpZXMsDQo+Pj4+IG1haW5saW5lIHdpdGggLmdl
dF9zdGF0ZSBBTkQgdGhpcyBzZXJpZXMpIGFuZCBnb3QgdGhlIGV4cGVjdGVkIHJlc3VsdHMuDQo+
Pj4+IFdpdGhvdXQgdGhlIC5nZXRfc3RhdGUoKSBwYXRjaCB0aGUgY29yZSBhbHdheXMgcmV0dXJu
cyB0aGUgZGVmYXVsdCB3aGljaA0KPj4+PiBpcyBkaXNhYmxlZCBzdGF0ZSBzbyB0aGUgZ3BpbyBw
aW5jdHJsIHN0YXRlIGlzIHNlbGVjdGVkIGluIHByb2JlLg0KPj4+DQo+Pj4gV2l0aG91dCAuZ2V0
X3N0YXRlIGl0IHdvbid0IGJlIHBvc3NpYmxlIHRvIHNtb290aGx5IHRha2Ugb3ZlciBhIHJ1bm5p
bmcNCj4+PiBQV00uDQo+Pg0KPj4gQnV0IHRoYXQgaXMgZXhhY3RseSBob3cgdGhlIGN1cnJlbnQg
cHdtLWlteCBjb2RlIHdvcmtzLCByaWdodD8NCj4gDQo+IEJ1dCB0aGVuIGF0IGxlYXN0IHRoZSBw
d20gd291bGQgcnVuIHVudGlsIHRoZSBmaXJzdCBjb25zdW1lcg0KPiByZWNvbmZpZ3VyZXMgaXQu
DQoNClRoYXQgaXMgcmlnaHQuIEkgdGhpbmsgaXQgaXMgYWN0dWFsbHkgcG9zc2libGUgKGFuZCBt
YXliZSBnb29kIGlkZWE/KQ0KdG8gZHJvcCB0aGUgcHJvYmUgcGFydCBmcm9tIHRoaXMgcGluY3Ry
bC9HUElPIHNlcmllcyBhbmQgcHV0IGl0IGludG8NCnRoZSAuZ2V0X3N0YXRlIHNlcmllcyBpZiB0
aGUgLmdldF9zdGF0ZSBzZXJpZXMgd291bGQgbGFuZCBpbiBsYXRlci4NCldoYXQgZG8geW91IHRo
aW5rPw0KDQpNaWNoYWwNCg==
