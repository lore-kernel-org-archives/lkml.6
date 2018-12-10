Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62240C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B3320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Ye3V/ieO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B3320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeLJLPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:15:52 -0500
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:53408
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbeLJLPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USyTACkHzU5AYs75MesTh1r+KV8hbFfHisjuu5RDUss=;
 b=Ye3V/ieOgAGoLEfdr/IEosu4HT2AS9e/pnLZ2HIp7D3HU2byJqyZzapCiAKuMTtCxFZi06IdUAit+6uqwinyvsoexYIBXabel7v3SDhCtet/hMEDZDN2wQ0e/9gtliZpR+echNjb4G0s2dBnKUBEiKizeo9T2vtAXHE4KXeYpqA=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5354.eurprd04.prod.outlook.com (20.178.85.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 11:15:05 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 11:15:05 +0000
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
Thread-Index: AQHUjWllpnSfybe6SEqAejrjFKHx0aVxvNwAgAAbnoCAAArBAIAF9SIA
Date:   Mon, 10 Dec 2018 11:15:05 +0000
Message-ID: <8b88d225-efc7-623a-d1a6-8b3cfcfd5e07@ysoft.com>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181206135902.un2nbreqfmi6mpd6@pengutronix.de>
 <01aaa6ff-fb3e-37a7-0e72-099ad013ee2a@ysoft.com>
 <20181206161622.okpfiecfphar77jk@pengutronix.de>
In-Reply-To: <20181206161622.okpfiecfphar77jk@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::42) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5354;6:dWnU/HV5LNEABPjBerscAWAmJ5jOP4pK7Ktw7IDeO33C2edmKHd/MDxGIBj3qLO9C8UidYUN8Y8pdcoK9aZza/1JpCE4SqdePzVbLME++3dlxL45DWkyX5SucaZXjTDPU51nGilKnXY5Z+Xm8Ucv4KjvkTwMnVFDr1JFBWU/YwgZ0/sRYcFD8qRc2TLS/H7QyhKtXbGKmfAbntctUETcTcmFy5T4LZUk78ij0EyYhNxUiMfAw2iXurHu1Kn5t8RlxreVRhW6tRbmd3jtsoxpDSQbyO4YV3wT/62pbxrXdS6gZ9T4+Rbah3qPd2iKtan1Vcq5URf5R6uJZ4xAzvbr9Bz6mJ0t4SKgT/qLet4zDRaU2lhS+o/JizqAVstCEBREFu450Bmi31mC7JqjRQrUDEyi7gT/mRxuJIe+8Obb+oigfP0+NMuUPui7Lmkmglem0qbZPbEXd4F/idXnsXs9Vg==;5:nEmQ3jCXYlaYbP1H+GyiXMrXUiO3xlASTzrQxBYvGfp96wtz0fpoIeGNDnO+YwMYhUP5XwaKujdYx1dFnpBzMD0Xj6WOJqXtr18errnP+/JMTJFUsX46j6BcuQbcVoc68o9Ni/ZvLP8NK189ozVCeyQpZgWcSyg6sOqwb3RSt0k=;7:K03nhkU8bWcrDDNvJZ49Q6kjK4HhiYBRqMni19Ffues8hhHv+O5U/k3PaYI7QLwnv3W5Luz3q5AmWnLF0V5YASv17EONN9rPlAEyxDPk1p2T1yOsAJ1msT/TKW6aI6et1eirF+Y7h6CcCtyE/SFuQg==
x-ms-office365-filtering-correlation-id: aad58550-a028-4810-7b23-08d65e90bc61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5354;
x-ms-traffictypediagnostic: DB7PR04MB5354:
x-microsoft-antispam-prvs: <DB7PR04MB53549CE3997B9DF1A885421F9EA50@DB7PR04MB5354.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5354;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5354;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39850400004)(136003)(51444003)(199004)(189003)(53546011)(97736004)(5660300001)(6116002)(102836004)(3846002)(6506007)(386003)(26005)(4326008)(476003)(2616005)(25786009)(7736002)(36756003)(93886005)(186003)(305945005)(229853002)(446003)(478600001)(11346002)(85182001)(486006)(72206003)(966005)(14454004)(2906002)(105586002)(7416002)(52116002)(71190400001)(66066001)(71200400001)(6512007)(6306002)(53936002)(54906003)(106356001)(66574011)(99286004)(217873002)(14444005)(81166006)(256004)(81156014)(68736007)(76176011)(8936002)(6916009)(316002)(6246003)(31696002)(6486002)(6436002)(8676002)(39060400002)(31686004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5354;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g399IJ2qv3Bt72e+5UJg88WqvmpgCSl4S4co6Za88KdBZoR0YfIE/m7jpombRLu45N45VnrRQ4vLEu4kqQdc08YaOCi9PRmBuRTxfwbvuh49r5NrCd2h1aDICY+1Q5SxpruZyJEcIFl/b/BETp92u0E0KYANtxT6Rc0DtAmkRxtwrx8yl2BHJrUn/KDtL7jRV9XBoWrEMoCc1E+17eZuIJBmu8lSegKBHNUaAetwNovwpF2zu/dwGb9gZbdlgy/ponqr3/9owCXPDOX0MMgz4jrbVoqE+JHF15E9x3sjoe3TzFr08mBUZ/Zlz4IcXZNs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A540BF86846DBB45975E809519E97EAD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad58550-a028-4810-7b23-08d65e90bc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 11:15:05.1123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi4xMi4yMDE4IDE3OjE2LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gT24gVGh1LCBE
ZWMgMDYsIDIwMTggYXQgMDM6Mzc6NTVQTSArMDAwMCwgVm9rw6HEjSBNaWNoYWwgd3JvdGU6DQo+
PiBPbiA2LjEyLjIwMTggMTQ6NTksIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPj4+IE9uIFRo
dSwgRGVjIDA2LCAyMDE4IGF0IDAxOjQxOjMxUE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3Rl
Og0KPj4+DQo+Pj4gQ2FuIGl0IGhhcHBlbiwgdGhhdCBwaW5jdHJsX3BpbnNfcHdtIGlzIFBUUl9F
UlIoLUVQUk9CRV9ERUZFUik/DQo+Pg0KPj4gTm8uIFRoZSBwaW5jdHJsX2xvb2t1cF9zdGF0ZSBl
aXRoZXIgcmV0dXJucyBwb2ludGVyIHRvIHRoZSBwaW5jdHJsIHN0YXRlDQo+PiBvciBFUlJfUFRS
KC1FTk9ERVYpLiBCdXQgSSBkbyBub3QgZXhwbGljaXRseSB0ZXN0IHRoZSBwaW5jdHJsX3BpbnNf
cHdtDQo+PiBmb3IgUFRSX0VSUigtRVBST0JFX0RFRkVSKSwgb3IgZG8gST8NCj4gDQo+IFlvdSBk
b24ndCwgSSBqdXN0IHdvbmRlcmVkIGlmIHRoaXMgY291bGQgaGFwcGVuIGFuZCB0aGUgZnVuY3Rp
b24gc2hvdWxkDQo+IHJldHVybiAtRVBST0JFX0RFRkVSIGluIHRoaXMgY2FzZSwgdG9vLg0KDQpP
Sy4NCg0KPj4+IE1heWJlIHlvdSBvbmx5IHdhbnQgdG8gaWdub3JlIFBUUl9FUlIoLUVOT0RFVikg
YW5kIGZvciBleGFtcGxlIHByb3BhZ2F0ZQ0KPj4+IC1FSU8/IEkgdGhpbmsgeW91IHdhbnQgdG8g
cHV0IHRoZSBncGlvIGlmIHRoZSBmYWlsdXJlIGlzIGJlY2F1c2UgdGhlcmUNCj4+PiBpcyBhIHBp
bmN0cmwgcmVsYXRlZCBlcnJvci4NCj4+DQo+PiBJIHRoaW5rIHRoYXQgaXMgd2hhdCBJIGFtIGRv
aW5nLiBJbiBjYXNlIHRoZSBHUElPIGlzIG5vdCByZWFkeSB0aGUgcHJvYmUNCj4+IGlzIGRlZmVy
cmVkLiBJbiBjYXNlIG9mIGFueSBvdGhlciBlcnJvciB3aXRoIHRoZSBHUElPIG9yIHBpbmN0cmwg
ZmFpbHVyZQ0KPj4gSSBwdXQgdGhlIHBpbmN0cmwuIE9yIG1heWJlIEkgZG8gbm90IHJlYWxseSB1
bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uDQo+IA0KPiBZZXMsIHlvdSBwdXQgdGhlIHBpbmN0cmws
IGJ1dCBub3QgdGhlIEdQSU8uIEkuZS4geW91J3JlIG5vdCB1bmRvaW5nDQo+IGRldm1fZ3Bpb2Rf
Z2V0X29wdGlvbmFsKCkuIE1heWJlIG9ubHkgZG8gdGhpcyBpZiB0aGUgcGluY3RybCBzdHVmZg0K
PiBzdWNjZWVkZWQgdG8gbm90IHRvdWNoIHRoZSBHUElPIGlmIGl0IHdvbid0IGJlIHVzZWQ/DQoN
Ck9LLCBJIGFncmVlIGl0IHNlZW1zIGJldHRlciB0byBnZXQgdGhlIHBpbmN0cmwgZmlyc3QgYW5k
IGlmIGl0IHN1Y2NlZWRzDQpvbmx5IHRoZW4gdHJ5IHRvIGdldCB0aGUgR1BJTy4gSW4gdGhhdCBj
YXNlIEkgbmVlZCB0byB1c2UgdGhlIG5vbi1vcHRpb25hbA0KdmFyaWFudCBvZiBkZXZtX2dwaW9f
Z2V0KCkuIE5vdGUgdGhhdCB0aGVuIEkgZG8gbm90IHJlYWxseSBuZWVkIHRvIHB1dCB0aGUNCkdQ
SU8gaW4gdGhlIGVycm9yIHBhdGggYXMgaXQgbWVhbnMgSSBkaWQgbm90IGdldCBpdC4NClRoZSBj
b2RlIHdvdWxkIGxvb2sgbGlrZToNCg0KK3N0YXRpYyBpbnQgaW14X3B3bV9pbml0X3BpbmN0cmxf
aW5mbyhzdHJ1Y3QgaW14X2NoaXAgKmlteF9jaGlwLA0KKwkJCQkgICAgICBzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KK3sNCisJaW14X2NoaXAtPnBpbmN0cmwgPSBkZXZtX3BpbmN0cmxf
Z2V0KCZwZGV2LT5kZXYpOw0KKwlpZiAoSVNfRVJSKGlteF9jaGlwLT5waW5jdHJsKSkgew0KKwkJ
ZGV2X2RiZygmcGRldi0+ZGV2LCAiY2FuIG5vdCBnZXQgcGluY3RybFxuIik7DQorCQlyZXR1cm4g
UFRSX0VSUihpbXhfY2hpcC0+cGluY3RybCk7DQorCX0NCisNCisJaW14X2NoaXAtPnBpbmN0cmxf
cGluc19wd20gPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShpbXhfY2hpcC0+cGluY3RybCwNCisJCQkJ
CQkJICAicHdtIik7DQorCWlteF9jaGlwLT5waW5jdHJsX3BpbnNfZ3BpbyA9IHBpbmN0cmxfbG9v
a3VwX3N0YXRlKGlteF9jaGlwLT5waW5jdHJsLA0KKwkJCQkJCQkgICAiZ3BpbyIpOw0KKw0KKwlp
ZiAoSVNfRVJSKGlteF9jaGlwLT5waW5jdHJsX3BpbnNfcHdtKSB8fA0KKwkgICAgSVNfRVJSKGlt
eF9jaGlwLT5waW5jdHJsX3BpbnNfZ3BpbykpIHsNCisJCWRldl9kYmcoJnBkZXYtPmRldiwgInBp
bmN0cmwgaW5mb3JtYXRpb24gaW5jb21wbGV0ZVxuIik7DQorCQlnb3RvIG91dDsNCisJfQ0KKw0K
KwlpbXhfY2hpcC0+cHdtX2dwaW9kID0gZGV2bV9ncGlvZF9nZXQoJnBkZXYtPmRldiwgInB3bSIs
IEdQSU9EX0lOKTsNCisJaWYgKFBUUl9FUlIoaW14X2NoaXAtPnB3bV9ncGlvZCkgPT0gLUVQUk9C
RV9ERUZFUikgew0KKwkJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQorCX0gZWxzZSBpZiAoSVNfRVJS
KGlteF9jaGlwLT5wd21fZ3Bpb2QpKSB7DQorCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJHUElPIGlu
Zm9ybWF0aW9uIGluY29tcGxldGVcbiIpOw0KKwkJZ290byBvdXQ7DQorCX0NCisNCisJcmV0dXJu
IDA7DQorDQorb3V0Og0KKwlkZXZtX3BpbmN0cmxfcHV0KGlteF9jaGlwLT5waW5jdHJsKTsNCisJ
aW14X2NoaXAtPnBpbmN0cmwgPSBOVUxMOw0KKw0KKwlyZXR1cm4gMDsNCit9DQoNCj4+PiBJU1RS
IHRoYXQgdGhlcmUgd2FzIGEgcGF0Y2ggdGhhdCBpbXBsZW1lbnRzIGdldF9zdGF0ZSBmb3IgaW14
LiBJcyB0aGVyZQ0KPj4+IGEgZGVwZW5kZW5jeSBvbiB0aGF0IG9uZT8gT3RoZXJ3aXNlIHRoZSBz
dGF0ZSByZXR1cm5lZCBieQ0KPj4+IHB3bV9nZXRfc3RhdGUoKSBtaWdodCBub3QgYmUgd2hhdCBp
cyBhY3R1YWxseSBjb25maWd1cmVkLg0KPj4NCj4+IE5vLCBpdCBzaG91bGQgYmUgaW5kZXBlbmRl
bnQuIE9uZSBjYW4gZ28gd2l0aG91dCB0aGUgb3RoZXIuIEkgdGVzdGVkIGFsbA0KPj4gdGhyZWUg
Y29tYmluYXRpb25zIChtYWlubGluZSB3aXRoIC5nZXRfc3RhdGUsIG1haW5saW5lIHdpdGggdGhp
cyBzZXJpZXMsDQo+PiBtYWlubGluZSB3aXRoIC5nZXRfc3RhdGUgQU5EIHRoaXMgc2VyaWVzKSBh
bmQgZ290IHRoZSBleHBlY3RlZCByZXN1bHRzLg0KPj4gV2l0aG91dCB0aGUgLmdldF9zdGF0ZSgp
IHBhdGNoIHRoZSBjb3JlIGFsd2F5cyByZXR1cm5zIHRoZSBkZWZhdWx0IHdoaWNoDQo+PiBpcyBk
aXNhYmxlZCBzdGF0ZSBzbyB0aGUgZ3BpbyBwaW5jdHJsIHN0YXRlIGlzIHNlbGVjdGVkIGluIHBy
b2JlLg0KPiANCj4gV2l0aG91dCAuZ2V0X3N0YXRlIGl0IHdvbid0IGJlIHBvc3NpYmxlIHRvIHNt
b290aGx5IHRha2Ugb3ZlciBhIHJ1bm5pbmcNCj4gUFdNLg0KDQpCdXQgdGhhdCBpcyBleGFjdGx5
IGhvdyB0aGUgY3VycmVudCBwd20taW14IGNvZGUgd29ya3MsIHJpZ2h0Pw0KDQo+IEl0IGRvZXNu
J3QgaHVydCBpZiB0aGUgUFdNIGlzbid0IHJ1bm5pbmcgdGhvdWdoLiBTdGlsbCBJJ2QgbGlrZSB0
bw0KPiBzZWUgdGhlIC5nZXRfc3RhdGUgcGF0Y2ggdG8gZ28gaW4gZmlyc3QgdG8gbm90IGdldCB0
aGlzIChhZG1pdHRlZGx5DQo+IHNtYWxsKSByZWdyZXNzaW9uLg0KDQpJIHdvdWxkIG5vdCBtaW5k
IHRoYXQuIFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIC5nZXRfc3RhdGUgcGF0Y2ggaGF2ZQ0Kbm90
IHJlY2VpdmVkIGFueSBjb21tZW50cyB5ZXQuIEkgcGxhbm5lZCB0byByZXNlbmQgaXQgb25jZSB0
aGlzIHNlcmllcw0KaXMgaW4uIElmIHdlIGNob29zZSB0byBmaW5lLXR1bmUgdGhlIC5nZXRfc3Rh
dGUgcGF0Y2ggZmlyc3QgYW5kIHRoZW4NCnB1dCB0aGlzIHNlcmllcyBvbiB0b3Agb2YgdGhhdCBJ
IGFtIGFmcmFpZCB3ZSB3aWxsIG1pc3MgYW5vdGhlciBmZXcNCnJlbGVhc2VzLg0KDQo+Pj4gRG8g
eW91IGtub3cgaWYgdGhpcyBpcyByZXF1aXJlZCBmb3IgdGhlIG9sZCBpLk1YIHB3bSwgZS5nLiBv
biBpLk1YMjE/DQo+Pj4gSSBhc2sgYmVjYXVzZSBvZiBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3BhdGNoLzEwMDAwNzEvDQo+Pg0KPj4gWWVwLCBJIGFtIGF3YXJlIG9mIHRoYXQgcGF0Y2gu
IElNSE8gdGhpcyBpcyBub3QgbmVlZGVkIGZvciB0aGUgdjEgb24NCj4+IG9sZGVyIGkuTVggU29D
cyBidXQgSSBkbyBub3QgaGF2ZSBhIGhhbmRzLW9uIGV4cGVyaWVuY2Ugd2l0aCB0aG9zZS4NCj4g
DQo+IE9LLiBJZiB5b3UgYWdyZWUgd2l0aCBteSBzcGxpdCBhbmQgYXMgeW91IGhhdmUgdG8gcmV3
b3JrIHlvdXIgcGF0Y2gNCj4gYW55aG93OiBXb3VsZCB5b3UgbWluZCB0byByZWJhc2Ugb24gdG9w
IG9mIG15IHBhdGNoIHNlcmllcz8gKFVubGVzcw0KPiBUaGllcnJ5IGRpc2FncmVlcyB3aXRoIG15
IHBhdGNoZXMsIGJ1dCB1bmZvcnR1bmF0ZWx5IGhlIGRpZG4ndCBjb21tZW50DQo+IHlldC4pDQoN
Ck5vIHByb2JsZW0gZm9yIG1lIHRvIHJlYmFzZSBvbiB0b3Agb2YgeW91ciBzZXJpZXMuIEJ1dCBp
dCByZWFsbHkNCmRlcGVuZHMgb24gVGhpZXJyeS4gQW5kIGl0IGdlbmVyYXRlcyB0aGUgc2FtZSBw
cm9ibGVtIGFzIEkgbWVudGlvbmVkDQphYm92ZS4gVW5saWtlIHlvdXIgc3BsaXQgYW5kIG15IC5n
ZXRfc3RhdGUgc2VyaWVzIHRoZSBwaW5jdHJsL0dQSU8NCnNlcmllcyBoYXMgYWxyZWFkeSBiZWVu
IHRob3JvdWdobHkgZGlzY3Vzc2VkIGFuZCBzZWVtcyB0byBiZSBxdWl0ZQ0KY2xvc2UgdG8gYmUg
YWNjZXB0ZWQuIE1heWJlIGl0IGlzIG5vdCBhIGdvb2QgaWRlYSB0byBwb3N0cG9uZSB0aGF0DQp3
aXRoIHRoZSBjdXJyZW50IHBhY2Ugb2YgcGF0Y2hlcyBtZXJnZWQgcGVyIHJlbGVhc2UgaW50byBQ
V00gc3Vic3lzdGVtLg0KDQpUaGUgb3RoZXIgdGhpbmcgaXMgd2UgbW9zdGx5IGRpc2N1c3NlZCB0
aGUgY29uY2VwdCBzbyBmYXIuIFNvIG5vdw0KYXMgaXQgbG9va3MgbGlrZSB0aGlzIHBpbmN0cmwv
R1BJTyBzZXJpZXMgbWF5IGJlIGV2ZW50dWFsbHkgbWVyZ2VkDQphIHJldmlldyBvbiB0aGUgZHQt
YmluZGluZyBwYXJ0IGlzIGFsc28gbmVlZGVkLiBIb3BlZnVsbHkgaXQgZ2V0cw0KUm9iJ3MgYXR0
ZW50aW9uIG9uY2Ugc3VibWl0dGVkIGFzIG5vbi1SRkMuDQoNCkJlc3QgcmVnYXJkcywNCk1pY2hh
bA0K
