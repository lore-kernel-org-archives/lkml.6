Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53BDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560B7214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="sW5NA1IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560B7214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLFPiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:38:00 -0500
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:13602
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeLFPh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWf6rqYb9rNsBLTsdt/Ht0Q+lwkvv/ZZffzoLx1IYE8=;
 b=sW5NA1IVqIZpu7pg5SQPOwA/N1abTKAkcgRBuv3uF2XPjt01TByxx2Kiwb9Krtt+jh81nzsBTV1+tQ7eQ6aEBDCBeefPyCq0MfBtIG67tJwPhkacLI6Vpui539Nm8BBFWtOo6JT66eLCR95NgtD6cq9CUc+hzWDgSm4EryRaamQ=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4905.eurprd04.prod.outlook.com (20.176.234.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 15:37:55 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 15:37:55 +0000
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
Thread-Index: AQHUjWllpnSfybe6SEqAejrjFKHx0aVxvNwAgAAbnoA=
Date:   Thu, 6 Dec 2018 15:37:55 +0000
Message-ID: <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
In-Reply-To: <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P193CA0003.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::13) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4905;6:7Yswvm9/yv7kxdkzcpKsfsooBUKh6ootMeozVVaUGGmssCHkToqT5oHlv/9Q94zXR/DrlPhCn5pxSrj1OtyExJ9P0e3mpHfgar45jqUCkFFeycMk+t4FgV3BvWZRugGuHSPbJFRWGvLvz7Y35VYNtSPlRBKFsStFPQB3rAUUzjAgZGC9C1nocYpUbi8+TEFFF6OWX9R1N4ukHTxoHTV8tR4M6mSbGQo5y7itOOugZy2EsaLS8Y6bxM0H5VSkcCq9tuUOqXyCVtyS9n3bmEWxKsyUhwnxnDx0hQgtjpGT8QdDsGA1BwPYfnxznFST355pR4UgDY2YzL0OgUiZnC/+vxV5iDxjyEE8QgRyK3h2kWEkLre5bB+0fdg4NR2qpG5s9z1Rx/6lsdApR5RH4hqSUKo4yWUkfr3B+wkWwy3x/WJG0kvSC93eKLkeOv71miMHleyhTJJeSjdwiNHFpVgFng==;5:ngx25crHstv05qnFakJRG4UIjT7VZ0RuHgMtIeNKSGWHnD6t5WWuMvD6oI+H6O/8M6oWxgw7LbRV3+7HLJCp9z0sBn11mZdb5oqTjX1cP+m+Mk9iQitx5J/Gbpg8MWjR2+SQBVonmyPW9dRYWtCQfMfih8jHKbbla9bGf+A2cv0=;7:bwO9YEvxKWo756R8P5/uG7CqRgvmk/4jrqIz6VheNL7NxAw0AyreNne8jPB/CtaCiWMP/MLMVBLDA5p1DU9KSFT3zftmPaiO7hc0vAZK0NN1VpvxG3+ePZWqejPh3cWet7EG+od3/vPUrdKCKsFe0Q==
x-ms-office365-filtering-correlation-id: 309c37f2-20b4-403d-86fd-08d65b90ca87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4905;
x-ms-traffictypediagnostic: DB7PR04MB4905:
x-microsoft-antispam-prvs: <DB7PR04MB4905956031908F00D15A7D749EA90@DB7PR04MB4905.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4905;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4905;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39850400004)(366004)(376002)(51444003)(189003)(199004)(105586002)(72206003)(6512007)(31686004)(6486002)(966005)(106356001)(486006)(66066001)(54906003)(6436002)(217873002)(68736007)(36756003)(6306002)(256004)(99286004)(476003)(478600001)(76176011)(5660300001)(2616005)(2906002)(11346002)(229853002)(71200400001)(8936002)(446003)(6916009)(71190400001)(26005)(6506007)(386003)(345774005)(14444005)(316002)(102836004)(85182001)(3846002)(53546011)(6116002)(66574009)(8676002)(81166006)(4326008)(81156014)(14454004)(52116002)(53936002)(97736004)(6246003)(31696002)(7416002)(86362001)(25786009)(39060400002)(186003)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4905;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hBkgyLbIJOhH/9krTjpHzgcOny1/vnrWkRSfsFAmEJCO+6zU2faNEthqmg9pTeN/JxQ/LLWw6uxwEPo5YVZvDrnBaBkKGP0SjDDJ8zVQIt9l8DdGcf4LpqLBsK/RzR8UFNlFuq/VEnUDDKlHHiUJ6XttJOquxsNB6rQ4lysrVv37I48V+2JM/s6puiG11aPq6M0Lcbdasi7fWEqkYMQNY1pbWls+VzZd0gJwSCcK58gGgIcNhd52TgqbiQp8jz/yJKPLD8mI/Ijnm5N8rMtWwu7lUvahARQYCN78Z6E0qTXdzBkVIpBHilVssd5gdraxgvFLLLbQbl1Nsx7tCdDM6T7L6tclNMxknVPHORLdN3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4170B5E0AFD68B46AC61F4928F236CF8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309c37f2-20b4-403d-86fd-08d65b90ca87
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 15:37:55.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi4xMi4yMDE4IDE0OjU5LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gT24gVGh1LCBE
ZWMgMDYsIDIwMTggYXQgMDE6NDE6MzFQTSArMDAwMCwgVm9rw6HEjSBNaWNoYWwgd3JvdGU6DQo+
PiAgIA0KPj4gK3N0YXRpYyBpbnQgaW14X3B3bV9pbml0X3BpbmN0cmxfaW5mbyhzdHJ1Y3QgaW14
X2NoaXAgKmlteF9jaGlwLA0KPj4gKwkJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
DQo+IFBsZWFzZSBpbmRlbnQgdGhlIGZvbGxvdyB1cCBsaW5lIHRvIHRoZSBvcGVuaW5nIHBhcmVu
dGhlc2lzLg0KDQpNZWgsIEkgb3Zlcmxvb2tlZCB0aGF0IG9uZS4gSSB3aWxsIGZpeCBpdC4NCg0K
Pj4gK3sNCj4+ICsJaW14X2NoaXAtPnBpbmN0cmwgPSBkZXZtX3BpbmN0cmxfZ2V0KCZwZGV2LT5k
ZXYpOw0KPj4gKwlpZiAoSVNfRVJSKGlteF9jaGlwLT5waW5jdHJsKSkgew0KPj4gKwkJZGV2X2Ri
ZygmcGRldi0+ZGV2LCAiY2FuIG5vdCBnZXQgcGluY3RybFxuIik7DQo+PiArCQlyZXR1cm4gUFRS
X0VSUihpbXhfY2hpcC0+cGluY3RybCk7DQo+PiArCX0NCj4+ICsNCj4+ICsJaW14X2NoaXAtPnBp
bmN0cmxfcGluc19wd20gPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShpbXhfY2hpcC0+cGluY3RybCwN
Cj4+ICsJCQkJCQkJICAicHdtIik7DQo+PiArCWlteF9jaGlwLT5waW5jdHJsX3BpbnNfZ3BpbyA9
IHBpbmN0cmxfbG9va3VwX3N0YXRlKGlteF9jaGlwLT5waW5jdHJsLA0KPj4gKwkJCQkJCQkgICAi
Z3BpbyIpOw0KPj4gKwlpbXhfY2hpcC0+cHdtX2dwaW9kID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9u
YWwoJnBkZXYtPmRldiwgInB3bSIsDQo+PiArCQkJCQkJICAgICAgR1BJT0RfSU4pOw0KPj4gKw0K
Pj4gKwlpZiAoUFRSX0VSUihpbXhfY2hpcC0+cHdtX2dwaW9kKSA9PSAtRVBST0JFX0RFRkVSKSB7
DQo+PiArCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4+ICsJfSBlbHNlIGlmIChJU19FUlIoaW14
X2NoaXAtPnB3bV9ncGlvZCkgfHwNCj4+ICsJCSAgIElTX0VSUihpbXhfY2hpcC0+cGluY3RybF9w
aW5zX3B3bSkgfHwNCj4+ICsJCSAgIElTX0VSUihpbXhfY2hpcC0+cGluY3RybF9waW5zX2dwaW8p
KSB7DQo+PiArCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJQV00gcGluY3RybCBpbmZvcm1hdGlvbiBp
bmNvbXBsZXRlXG4iKTsNCj4+ICsJCWRldm1fcGluY3RybF9wdXQoaW14X2NoaXAtPnBpbmN0cmwp
Ow0KPj4gKwkJaW14X2NoaXAtPnBpbmN0cmwgPSBOVUxMOw0KPiANCj4gQ2FuIGl0IGhhcHBlbiwg
dGhhdCBwaW5jdHJsX3BpbnNfcHdtIGlzIFBUUl9FUlIoLUVQUk9CRV9ERUZFUik/DQoNCk5vLiBU
aGUgcGluY3RybF9sb29rdXBfc3RhdGUgZWl0aGVyIHJldHVybnMgcG9pbnRlciB0byB0aGUgcGlu
Y3RybCBzdGF0ZQ0Kb3IgRVJSX1BUUigtRU5PREVWKS4gQnV0IEkgZG8gbm90IGV4cGxpY2l0bHkg
dGVzdCB0aGUgcGluY3RybF9waW5zX3B3bQ0KZm9yIFBUUl9FUlIoLUVQUk9CRV9ERUZFUiksIG9y
IGRvIEk/DQoNCj4gTWF5YmUgeW91IG9ubHkgd2FudCB0byBpZ25vcmUgUFRSX0VSUigtRU5PREVW
KSBhbmQgZm9yIGV4YW1wbGUgcHJvcGFnYXRlDQo+IC1FSU8/IEkgdGhpbmsgeW91IHdhbnQgdG8g
cHV0IHRoZSBncGlvIGlmIHRoZSBmYWlsdXJlIGlzIGJlY2F1c2UgdGhlcmUNCj4gaXMgYSBwaW5j
dHJsIHJlbGF0ZWQgZXJyb3IuDQoNCkkgdGhpbmsgdGhhdCBpcyB3aGF0IEkgYW0gZG9pbmcuIElu
IGNhc2UgdGhlIEdQSU8gaXMgbm90IHJlYWR5IHRoZSBwcm9iZQ0KaXMgZGVmZXJyZWQuIEluIGNh
c2Ugb2YgYW55IG90aGVyIGVycm9yIHdpdGggdGhlIEdQSU8gb3IgcGluY3RybCBmYWlsdXJlDQpJ
IHB1dCB0aGUgcGluY3RybC4gT3IgbWF5YmUgSSBkbyBub3QgcmVhbGx5IHVuZGVyc3RhbmQgd2hh
dCB5b3UgbWVhbi4NCg0KPj4gKwl9DQo+PiArDQo+PiArCXJldHVybiAwOw0KPj4gK30NCj4+ICsN
Cg0KWy4uLl0NCg0KPj4gQEAgLTMwMyw2ICszNjIsMjQgQEAgc3RhdGljIGludCBpbXhfcHdtX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgIAlpZiAocmV0IDwgMCkNCj4+
ICAgCQlyZXR1cm4gcmV0Ow0KPj4gICANCj4+ICsJaWYgKGlteC0+cGluY3RybCkgew0KPj4gKwkJ
LyoNCj4+ICsJCSAqIFVwZGF0ZSBjc3RhdGUgYWZ0ZXIgcHdtY2hpcF9hZGQoKSBjYWxsIGFzIHRo
ZSBjb3JlIG1pZ2h0DQo+PiArCQkgKiBjYWxsIHRoZSBnZXRfc3RhdGUoKSBmdW5jdGlvbiB0byBy
ZWFkIHRoZSBQV00gcmVnaXN0ZXJzDQo+PiArCQkgKiB0byBnZXQgdGhlIGFjdHVhbCBIVyBzdGF0
ZS4NCj4+ICsJCSAqLw0KPj4gKwkJcHdtX2dldF9zdGF0ZShpbXgtPmNoaXAucHdtcywgJmNzdGF0
ZSk7DQo+PiArCQlpZiAoY3N0YXRlLmVuYWJsZWQpIHsNCj4+ICsJCQlkZXZfZGJnKCZwZGV2LT5k
ZXYsDQo+PiArCQkJCSJQV00gZW50ZXJlZCBwcm9iZSBpbiBlbmFibGVkIHN0YXRlXG4iKTsNCj4+
ICsJCQlwaW5jdHJsX3NlbGVjdF9zdGF0ZShpbXgtPnBpbmN0cmwsDQo+PiArCQkJCQkgICAgIGlt
eC0+cGluY3RybF9waW5zX3B3bSk7DQo+PiArCQl9IGVsc2Ugew0KPj4gKwkJCXBpbmN0cmxfc2Vs
ZWN0X3N0YXRlKGlteC0+cGluY3RybCwNCj4+ICsJCQkJCSAgICAgaW14LT5waW5jdHJsX3BpbnNf
Z3Bpbyk7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCj4gDQo+IElTVFIgdGhhdCB0aGVyZSB3YXMg
YSBwYXRjaCB0aGF0IGltcGxlbWVudHMgZ2V0X3N0YXRlIGZvciBpbXguIElzIHRoZXJlDQo+IGEg
ZGVwZW5kZW5jeSBvbiB0aGF0IG9uZT8gT3RoZXJ3aXNlIHRoZSBzdGF0ZSByZXR1cm5lZCBieQ0K
PiBwd21fZ2V0X3N0YXRlKCkgbWlnaHQgbm90IGJlIHdoYXQgaXMgYWN0dWFsbHkgY29uZmlndXJl
ZC4NCg0KTm8sIGl0IHNob3VsZCBiZSBpbmRlcGVuZGVudC4gT25lIGNhbiBnbyB3aXRob3V0IHRo
ZSBvdGhlci4gSSB0ZXN0ZWQgYWxsDQp0aHJlZSBjb21iaW5hdGlvbnMgKG1haW5saW5lIHdpdGgg
LmdldF9zdGF0ZSwgbWFpbmxpbmUgd2l0aCB0aGlzIHNlcmllcywNCm1haW5saW5lIHdpdGggLmdl
dF9zdGF0ZSBBTkQgdGhpcyBzZXJpZXMpIGFuZCBnb3QgdGhlIGV4cGVjdGVkIHJlc3VsdHMuDQpX
aXRob3V0IHRoZSAuZ2V0X3N0YXRlKCkgcGF0Y2ggdGhlIGNvcmUgYWx3YXlzIHJldHVybnMgdGhl
IGRlZmF1bHQgd2hpY2gNCmlzIGRpc2FibGVkIHN0YXRlIHNvIHRoZSBncGlvIHBpbmN0cmwgc3Rh
dGUgaXMgc2VsZWN0ZWQgaW4gcHJvYmUuDQoNCj4gRG8geW91IGtub3cgaWYgdGhpcyBpcyByZXF1
aXJlZCBmb3IgdGhlIG9sZCBpLk1YIHB3bSwgZS5nLiBvbiBpLk1YMjE/DQo+IEkgYXNrIGJlY2F1
c2Ugb2YgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMDAwMDcxLw0KDQpZZXAs
IEkgYW0gYXdhcmUgb2YgdGhhdCBwYXRjaC4gSU1ITyB0aGlzIGlzIG5vdCBuZWVkZWQgZm9yIHRo
ZSB2MSBvbg0Kb2xkZXIgaS5NWCBTb0NzIGJ1dCBJIGRvIG5vdCBoYXZlIGEgaGFuZHMtb24gZXhw
ZXJpZW5jZSB3aXRoIHRob3NlLg0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgVXdlIQ0KTWlj
aGFsDQo=
