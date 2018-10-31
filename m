Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442CBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43EA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emutex.onmicrosoft.com header.i=@emutex.onmicrosoft.com header.b="V9hc0PAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43EA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeKAEzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:55:16 -0400
Received: from mail-ve1eur01on0109.outbound.protection.outlook.com ([104.47.1.109]:57546
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbeKAEzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emutex.onmicrosoft.com; s=selector1-emutex-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5xdGvBJnyRzO+nJeEPONkJpboWYNKOJa0QD6yuLkMQ=;
 b=V9hc0PAwyUTpRP+UL2oLwohjT4PBUAvvhVfNCRalxRsF4TORq2mS+rpZIy1/JPbAeXz3wTkwIpGWyiXBNIRzE59sRwVc2caNf9sg1Aa7g0/PQK72woWOnWdC9NGyW1zSS7tB/Zsvp87QACY1XZJwqq0EKbG6wk33DZ/nNXQEELs=
Received: from VI1P190MB0013.EURP190.PROD.OUTLOOK.COM (10.172.14.137) by
 VI1P190MB0447.EURP190.PROD.OUTLOOK.COM (10.165.198.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Wed, 31 Oct 2018 19:55:39 +0000
Received: from VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 ([fe80::71b0:31d3:faf9:3584]) by VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 ([fe80::71b0:31d3:faf9:3584%6]) with mapi id 15.20.1294.021; Wed, 31 Oct 2018
 19:55:39 +0000
From:   Dan O'Donovan <dan.odonovan@emutex.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan O'Donovan <dan.odonovan@emutex.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v2 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
Thread-Topic: [PATCH v2 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
Thread-Index: AQHUatOnpHqRH1KyNEOtKkYLNHmfuqU50bkA
Date:   Wed, 31 Oct 2018 19:55:39 +0000
Message-ID: <4ba11985-c71e-e526-8478-8bfe0e208429@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-4-git-send-email-dan@emutex.com>
 <CAHp75Vc8jxK6mcjOxmuOD0CTqYvfSSL=HMPpRVtOyCb6LxVB2w@mail.gmail.com>
In-Reply-To: <CAHp75Vc8jxK6mcjOxmuOD0CTqYvfSSL=HMPpRVtOyCb6LxVB2w@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::24) To VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:a0::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dan.odonovan@emutex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.51.199.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1P190MB0447;6:y15n2tWOQKoSl4QK98G1qRgRcBVZpAq6n+L+L9gAjchS9xhNnHw2OX93FrPiZhVR2o44sZXG0XiZHDQyyl68vcxOkn4BBVBiso1nwjoMnVXkB34Tjl686uD0SP2iLXgHREhBw1OC7gHF2LcF9GV08WX4X13UdrAihTv8/reUIjDofn59j090GMpsrezo3xinAKLkYQveVSgjUxl9or2SV96cxNrrPtE+YpyVxw/YCKS/c/Xy59BrS/kTYBipBz/5yD2Nmtzxbfo9djttB+dWf980CVaJLgvq0ad+d6YnTqBHNwaIERtRzuvBoGcSVLlmWqf6HSrYao4Lg4oGTLXkHnPykorQMORMfAzsKnFV3XcOmHWvcFTyVgbXis36RXE2ZjVDmcDdheesvTlHA27Yr0OSoJ7QsCPFUp2S0bDHd1iQY+kSSHHKHBNDnGZhx1C5pW33n7nLgqYfr6csLFTumA==;5:Sc4puWszEwJixwvBhT5Y2UP0YUQlm8O0JbezIeillLEMfuOVxYD/aimTzZEQrdrYrqNG3pmxvxBi96ookMYT8veUbCbWWujjLCnviZDgQaGjySJ+VhndnHn97A5/36/E3459c+SVZg+KdX0lZOen9Qg8iR9iibHSBUPfcvrQNSU=;7:N60TiZIxzKF2zSHJj0f7SQPH+1kujdEm27WAuvyfJJDEjbi5fbQbo2XRhD6FJfRMqFy/6Qd4k3WYg9uZ1bFgKzmYnnZf4bA7XgAGVRy6KZz0VKOGKQ/nDZRRhDKaRgzeqz6MskQb6y9GjTzvqB+wvw==
x-ms-office365-filtering-correlation-id: fe49eef4-39b3-442d-de22-08d63f6ad4b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1P190MB0447;
x-ms-traffictypediagnostic: VI1P190MB0447:
x-microsoft-antispam-prvs: <VI1P190MB0447FE883681C5DAFA1851D3F8CD0@VI1P190MB0447.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(6059035)(201703131423095)(20161123555045)(201703061421075)(201703061452153)(201703151056150)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1P190MB0447;BCL:0;PCL:0;RULEID:;SRVR:VI1P190MB0447;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(366004)(136003)(396003)(189003)(199004)(386003)(3846002)(6512007)(31696002)(102836004)(486006)(6486002)(36756003)(55236004)(38480400004)(53546011)(575784001)(86362001)(6506007)(6116002)(93886005)(26005)(446003)(38500400001)(229853002)(586005)(38610400001)(38600400001)(99286004)(11346002)(76176011)(476003)(6436002)(52116002)(2616005)(53936002)(107886003)(6246003)(186003)(54906003)(110136005)(256004)(14444005)(97736004)(498600001)(2900100001)(106356001)(14454004)(305945005)(71190400001)(71200400001)(7416002)(5660300001)(81156014)(8676002)(81166006)(5250100002)(39060400002)(8936002)(25786009)(4326008)(31686004)(68736007)(66066001)(2906002)(7736002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1P190MB0447;H:VI1P190MB0013.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: emutex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jb6a6y1kvGB2ZsEobFcupLPgGtXsubCrkTiBCEvOioYJ/ne9Po/9ft8vA0Kg6XipgPeOGsojlii1TrgwighciWuxnkK/tzdTR9rbV06iMmS8DIcTfB5X0vIZNc1MUIbIdUsa+lJ7ewK7Wq3LcyNYGWI7jUd+7FNOwC7Mi7i+TcSQU3mfJ2BGvPp4f+rf7VotsDL7tqpVM8Si4BM9xnAN1XXkTq7Kq/N76gcmoiP0vZlhLKtFn3Q++4X9MAsx8KBtSdzSciSj+NhYKF0lEYcqWdFKBHkUEOQSXnZwIZ0Drta4zcpvCliespVixKiJ2dItHJEQ+E0dSuOR8F9EAaMw7cNU6u4qUjYKfWGXm5QE0Fs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <87C31841509831468D8F76348AFB44BF@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: emutex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe49eef4-39b3-442d-de22-08d63f6ad4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 19:55:39.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cc844b-5c53-4da1-99da-34ef4089ea8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJldmlldyBmZWVkYmFjaywgQW5keSHCoCBJJ2xsIHNlbmQgYSB2MyBz
aG9ydGx5IHdpdGggdGhvc2UgY2hhbmdlcyB5b3Ugc3VnZ2VzdGVkLsKgIEkndmUgYWRkZWQgc29t
ZSBjb21tZW50cyBpbmxpbmUgYmVsb3cuDQoNCk9uIDEwLzIwLzIwMTggMTI6NDAgUE0sIEFuZHkg
U2hldmNoZW5rbyB3cm90ZToNCj4gT24gRnJpLCBPY3QgMTksIDIwMTggYXQgODoyNCBQTSBEYW4g
TydEb25vdmFuIDxkYW5AZW11dGV4LmNvbT4gd3JvdGU6DQo+DQo+PiArc3RhdGljIGludCB1cGJv
YXJkX2dldF9mdW5jdGlvbnNfY291bnQoc3RydWN0IHBpbmN0cmxfZGV2ICpwY3RsZGV2KQ0KPj4g
K3sNCj4+ICsgICAgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgdXBi
b2FyZF9nZXRfZnVuY3Rpb25fZ3JvdXBzKHN0cnVjdCBwaW5jdHJsX2RldiAqcGN0bGRldiwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzZWxl
Y3RvciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNo
YXIgKiBjb25zdCAqKmdyb3VwcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCAqbnVtX2dyb3VwcykNCj4+ICt7DQo+PiArICAgICAgICpncm91
cHMgPSBOVUxMOw0KPj4gKyAgICAgICAqbnVtX2dyb3VwcyA9IDA7DQo+PiArICAgICAgIHJldHVy
biAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgY29uc3QgY2hhciAqdXBib2FyZF9nZXRfZnVu
Y3Rpb25fbmFtZShzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdGxkZXYsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgc2VsZWN0b3IpDQo+
PiArew0KPj4gKyAgICAgICByZXR1cm4gTlVMTDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGlu
dCB1cGJvYXJkX3NldF9tdXgoc3RydWN0IHBpbmN0cmxfZGV2ICpwY3RsZGV2LCB1bnNpZ25lZCBp
bnQgZnVuY3Rpb24sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQg
Z3JvdXApDQo+PiArew0KPj4gKyAgICAgICByZXR1cm4gMDsNCj4+ICt9DQo+IEhtbS4uLiBEbyB5
b3UgbmVlZCB0aG9zZSBzdHVicz8gU2FtZSBRIGZvciBvdGhlciBzdHVicyBpbiB0aGUgZmlsZS4N
Ckl0IGxvb2tzIGxpa2UgdGhleSdyZSByZXF1aXJlZCBieSBwaW5jdHJsIGNvcmUsIHdoaWNoIHJl
dHVybnMgYW4gZXJyb3IgaWYgdGhleSdyZSBub3QgcHJvdmlkZWQuDQoNCj4+ICtzdGF0aWMgaW50
IHVwYm9hcmRfZ3Bpb19yZXF1ZXN0X2VuYWJsZShzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdGxkZXYs
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGluY3Ry
bF9ncGlvX3JhbmdlICpyYW5nZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBwaW4pDQo+PiArew0KPj4gKyAgICAgICBjb25zdCBzdHJ1Y3Qg
cGluX2Rlc2MgKiBjb25zdCBwZCA9IHBpbl9kZXNjX2dldChwY3RsZGV2LCBwaW4pOw0KPj4gKyAg
ICAgICBjb25zdCBzdHJ1Y3QgdXBib2FyZF9waW4gKnA7DQo+PiArICAgICAgIGludCByZXQ7DQo+
PiArDQo+PiArICAgICAgIGlmICghcGQpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+IFdoZW4gaXQgcG9zc2libGUgdG8gaGFwcGVuPw0KPiBTYW1lIFEgZm9yIHRoZSByZXN0
IHNhbWUgZXhjZXJwdHMuDQpBZ3JlZWQsIGl0IHNob3VsZG4ndCBiZSBwb3NzaWJsZS7CoCBJIHdp
bGwgcmVtb3ZlIHRoZXNlIGNoZWNrcy4NCg0KPj4gKw0KPj4gKyAgICAgICBpZiAob2Zmc2V0ICsg
MSA+IHBjdHJsLT5uc29jX2dwaW9zIHx8ICFwY3RybC0+c29jX2dwaW9zW29mZnNldF0pDQo+PiAr
ICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7DQo+IG9mZnNldCA+PSA/DQo+
IElzIGl0IGV2ZW4gcG9zc2libGU/DQpBZ3JlZWQsIGl0IHNob3VsZG4ndCBiZSBwb3NzaWJsZS7C
oCBJIHdpbGwgcmVtb3ZlIHRoZXNlIGNoZWNrcy4NCg0KPj4gK3N0YXRpYyBpbnQgdXBib2FyZF9w
aW5jdHJsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiArew0KPj4gKyAg
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPj4gKyAgICAgICBzdHJ1Y3Qg
cGluY3RybF9kZXNjICpwY3RsZGVzYzsNCj4+ICsgICAgICAgc3RydWN0IHVwYm9hcmRfcGluY3Ry
bCAqcGN0cmw7DQo+PiArICAgICAgIHN0cnVjdCB1cGJvYXJkX3BpbiAqcGluczsNCj4+ICsgICAg
ICAgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2Ow0KPj4gKyAgICAgICBzdHJ1Y3QgcmVnbWFwICpy
ZWdtYXA7DQo+PiArICAgICAgIHVuc2lnbmVkIGludCBpOw0KPj4gKyAgICAgICBpbnQgcmV0Ow0K
Pj4gKyAgICAgICBhZGV2ID0gQUNQSV9DT01QQU5JT04oZGV2KTsNCj4+ICsgICAgICAgaWYgKCFh
ZGV2IHx8IHN0cmNtcChhY3BpX2RldmljZV9oaWQoYWRldiksICJBQU5UMEYwMSIpKQ0KPj4gKyAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiBTYW1lIFEgYXMgcGVyIExFRCBkcml2ZXIu
DQpJIGFncmVlLsKgIEkgd2lsbCByZW1vdmUgdGhpcyBjaGVjaywgYm90aCBoZXJlIGFuZCBpbiB0
aGUgTEVEIGRyaXZlci4NCg0KPj4gKyAgICAgICAgICAgICAgIGlmIChwZC0+ZHJ2X2RhdGEpIHsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCByZWdfZmllbGQgKmZpZWxkID0gcGQt
PmRydl9kYXRhOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcGluLT5mdW5jX2Vu
ID0gZGV2bV9yZWdtYXBfZmllbGRfYWxsb2MoZGV2LCByZWdtYXAsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqZmllbGQp
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKElTX0VSUihwaW4tPmZ1bmNfZW4pKQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihwaW4tPmZ1
bmNfZW4pOw0KPj4gKyAgICAgICAgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgICAgICAgICBw
aW4tPmdwaW9fZW4gPSB1cGJvYXJkX2ZpZWxkX2FsbG9jKGRldiwgcmVnbWFwLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVVBCT0FSRF9SRUdf
R1BJT19FTjAsIGkpOw0KPj4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIocGluLT5ncGlvX2Vu
KSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHBpbi0+Z3Bpb19l
bik7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgcGluLT5ncGlvX2RpciA9IHVwYm9hcmRfZmll
bGRfYWxsb2MoZGV2LCByZWdtYXAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVVBCT0FSRF9SRUdfR1BJT19ESVIwLCBpKTsNCj4+ICsgICAg
ICAgICAgICAgICBpZiAoSVNfRVJSKHBpbi0+Z3Bpb19kaXIpKQ0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIFBUUl9FUlIocGluLT5ncGlvX2Rpcik7DQo+PiArDQo+PiArICAgICAg
ICAgICAgICAgKChzdHJ1Y3QgcGluY3RybF9waW5fZGVzYyAqKXBkKS0+ZHJ2X2RhdGEgPSBwaW47
DQo+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHB1cnBvc2Ugb2YgdGhpcyBjYXN0aW5n
Lg0KV2hlbiB0aGUgcGQgcG9pbnRlciBpcyByZXRyaWV2ZWQgZnJvbSBzdHJ1Y3QgcGluY3RybF9k
ZXNjLCBpdCBoYXMgYSBjb25zdCBjb25zdHJhaW50LsKgIFRoZSBwdXJwb3NlIG9mIHRoZSBjYXN0
IGlzIHRvIGJ5cGFzcyB0aGF0IGNvbnN0cmFpbnQgZm9yIHRoaXMgdXNlIGNhc2UsIGJlY2F1c2Ug
dGhpcyBjb2RlIGlzIGFsbG9jYXRpbmcgYW5kIHNldHRpbmcgZHJ2X2RhdGEgZHluYW1pY2FsbHkg
aGVyZSBhdCBydW4tdGltZSByYXRoZXIgdGhhbiBhdCBjb21waWxlLXRpbWUuDQo=
