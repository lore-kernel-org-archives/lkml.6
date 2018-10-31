Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A3CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D660A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emutex.onmicrosoft.com header.i=@emutex.onmicrosoft.com header.b="clZkdKmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D660A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeKAGkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:40:11 -0400
Received: from mail-eopbgr10098.outbound.protection.outlook.com ([40.107.1.98]:12376
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbeKAGkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emutex.onmicrosoft.com; s=selector1-emutex-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7dxnLZ5wycV3UyMDbbIeur6pqzHmFFzEMlIhlG6s+Y=;
 b=clZkdKmm+TeWy2uJyd1e/JsE9WskAu7lcAHcxsz5SPukJUVV3ozXH4c4WlyG1e+UJ3jxtqSsATeOtmg/QA8yw+02og6fCBmg5KGSM3SdEV9EC4aFSr/Tq93I/2ofELWcOABplNmGxS27mq4bpd6V0L6iA2363Y7/yl+oCV0ByC8=
Received: from VI1P190MB0013.EURP190.PROD.OUTLOOK.COM (10.172.14.137) by
 VI1P190MB0477.EURP190.PROD.OUTLOOK.COM (10.165.198.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 31 Oct 2018 21:39:33 +0000
Received: from VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 ([fe80::71b0:31d3:faf9:3584]) by VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 ([fe80::71b0:31d3:faf9:3584%6]) with mapi id 15.20.1294.021; Wed, 31 Oct 2018
 21:39:33 +0000
From:   Dan O'Donovan <dan.odonovan@emutex.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v3 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
Thread-Topic: [PATCH v3 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
Thread-Index: AQHUcWD16xPM1jTrfEOJHNhDo6R6t6U54aWA
Date:   Wed, 31 Oct 2018 21:39:32 +0000
Message-ID: <ee46cc57-28c0-dc3e-ead1-f979c0eb516e@emutex.com>
References: <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1541018689-20625-1-git-send-email-dan@emutex.com>
 <1541018689-20625-4-git-send-email-dan@emutex.com>
 <CACRpkdajUt7Brrf9jCOhEvrzvx24A8tp1NpGKuDPi_0uh5++eg@mail.gmail.com>
In-Reply-To: <CACRpkdajUt7Brrf9jCOhEvrzvx24A8tp1NpGKuDPi_0uh5++eg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR07CA0120.eurprd07.prod.outlook.com
 (2603:10a6:6:2c::34) To VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:a0::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [84.203.20.151]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1P190MB0477;6:CWQ/sggo39JdIk0n7QunlKaI4cu9l8ueAIXnS3qHZUZm/MIwKWR6bjE6OWc4IzJF9+36b2OkUqJ3IYNW/3Tjc5rkRN/tUEcp7Az/OJInxQkDazLRSTKrsaLm7/AdYzsTKQ1ZdCDmOnQsRrBE+IuQ48eBoIwOXbVhrmLxlsxnbEBrsEjywaQIyBiZ5rHIvB0XA2O070dMTrKWZrlWVytm7whXTy/T1XcEGEIhnakEAu+cdxPzFJKLZKY7X5EPaDKZV5TKW1DeGrdlWakHS0/5m+ZUVro6ZQB5zbhw3E1lUezW99StUgxKAALUPc8fvZCySiFr5mO2+LsfsQhjadlrxeHsbeg9Y2NHXpcZ61pihXu3jxb3jw0pX4wiosxwphww68Igtt/njUpgj/ZqaI3vNlmn/qhgSKt+rPtW5npJEQl4OBMzP8CWT7A5FGlHeLAP+xB6v9htmbnf1AaWr0a87A==;5:5ZnS1j8GKG1NxKXmJjSI32DoRJ2KP0BZl2z316is4/GJxfGPuXRHuO/i0xQE8vY5Sd2TJplu00QUUUsLN3S/QFBWUh6gbe4tEBrfuyYVexhxDgaOsBvlNcGXmn28KTdXlqlPOVGekhv2GWBWmpTOeAv6aWdU8IGUe0Lxf2Ra1OI=;7:LpDnPjAqh3+8xVCZybWJJ4pfpRkMa2JrhwFoQeHse115zdA6Q3zZsDmVFxj/E6rDgCa9qYp2VDAeTOj0cXp7ppxN3HdEWXSLbXMJTaxAbnTzdMF/nbfu4091W9OoUU4E6u6MphmxPBTJU42j5X8lYw==
x-ms-office365-filtering-correlation-id: a7defc7c-c36a-48f2-719f-08d63f795862
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1P190MB0477;
x-ms-traffictypediagnostic: VI1P190MB0477:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dan.odonovan@emutex.com; 
x-microsoft-antispam-prvs: <VI1P190MB0477A20C3D816DDAB2FCF5E6F8CD0@VI1P190MB0477.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(20161123555045)(201703061421075)(201703151056150)(6059035)(201708071742011)(7699051)(76991095);SRVR:VI1P190MB0477;BCL:0;PCL:0;RULEID:;SRVR:VI1P190MB0477;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39830400003)(136003)(396003)(366004)(189003)(199004)(93886005)(99286004)(14454004)(498600001)(7416002)(25786009)(26005)(305945005)(76176011)(52116002)(53546011)(6506007)(386003)(102836004)(66066001)(36756003)(7736002)(31686004)(14444005)(5250100002)(105586002)(97736004)(2900100001)(106356001)(54906003)(256004)(110136005)(81156014)(4326008)(86362001)(8676002)(81166006)(8936002)(6512007)(6486002)(38480400004)(6436002)(446003)(11346002)(39060400002)(68736007)(2906002)(2616005)(476003)(53936002)(229853002)(486006)(6246003)(38600400001)(586005)(38610400001)(31696002)(71190400001)(71200400001)(186003)(3846002)(5660300001)(6116002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1P190MB0477;H:VI1P190MB0013.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: emutex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p3CwnBooVsZabKzQpVf/JqtzWrk0+XU/S93+dFnYxj5VYJEXHjFxKzG3ZloDmYcIDmSJd2Qr6jaktLnEbMRhKf5o+NdQQnAyQAfGA+NYWIWqOBiqXYqWwkEbgkg62EHRl92WgeXq5C9DU8LXCHJiEnWxrvAh64rtaln1+SIV+78a6USzZQx4IYCqJEvqLoLmlusx0y9LnuClDjRE6j8BcdbvzFxAr6DFWYpAzxBgP44zx4UouXER4WGm8RaQzTxHLxb24dZmxLkz0gngGABpAXkcOnu4LxAdTheOr2ugWqWoJRcj/XtqSo8JFJ6/ipvzYmRAVDTm1auXZPXz4CG0w7YznKhTWlnk0zRUYFmk1O0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAB8E5971349104080D19B6121C90987@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: emutex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7defc7c-c36a-48f2-719f-08d63f795862
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 21:39:32.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cc844b-5c53-4da1-99da-34ef4089ea8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8zMS8yMDE4IDA5OjMwIFBNLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBIaSBEYW4s
DQo+DQo+IE9uIFdlZCwgT2N0IDMxLCAyMDE4IGF0IDk6NDUgUE0gRGFuIE8nRG9ub3ZhbiA8ZGFu
QGVtdXRleC5jb20+IHdyb3RlOg0KPg0KPj4gVGhlIFVQMiBib2FyZCBmZWF0dXJlcyBhIFJhc3Bi
ZXJyeSBQaSBjb21wYXRpYmxlIHBpbiBoZWFkZXIgKEhBVCkgYW5kIGENCj4+IGJvYXJkLXNwZWNp
ZmljIGV4cGFuc2lvbiBjb25uZWN0b3IgKEVYSEFUKS4gQm90aCBleHBvc2UgYXNzb3J0ZWQNCj4+
IGZ1bmN0aW9ucyBmcm9tIGVpdGhlciB0aGUgU29DIChzdWNoIGFzIEdQSU8sIEkyQywgU1BJLCBV
QVJULi4uKSBvciBvdGhlcg0KPj4gb24tYm9hcmQgZGV2aWNlcyAoQURDLCBGUEdBIElQIGJsb2Nr
cy4uLikuDQo+Pg0KPj4gVGhlc2UgbGluZXMgYXJlIHJvdXRlZCB0aHJvdWdoIGFuIG9uLWJvYXJk
IEZQR0EuIFRoZSBwbGF0Zm9ybSBjb250cm9sbGVyDQo+PiBpbiBpdHMgc3RvY2sgZmlybXdhcmUg
cHJvdmlkZXMgcmVnaXN0ZXIgZmllbGRzIHRvIGNoYW5nZToNCj4+DQo+PiAtIExpbmUgZW5hYmxl
IChGUEdBIHBpbnMgZW5hYmxlZCAvIGhpZ2ggaW1wZWRhbmNlKQ0KPj4gLSBMaW5lIGRpcmVjdGlv
biAoU29DIGRyaXZlbiAvIEZQR0EgZHJpdmVuKQ0KPj4NCj4+IFRvIGVuYWJsZSB1c2luZyBTb0Mg
R1BJT3Mgb24gdGhlIHBpbiBoZWFkZXIsIHRoaXMgYXJyYW5nZW1lbnQgcmVxdWlyZXMNCj4+IGJv
dGggY29uZmlndXJpbmcgdGhlIHBsYXRmb3JtIGNvbnRyb2xsZXIsIGFuZCB1cGRhdGluZyB0aGUg
U29DIHBhZA0KPj4gcmVnaXN0ZXJzIGluIHN5bmMuDQo+Pg0KPj4gQWRkIGEgZnJvbnRlbmQgcGlu
Y3RybC9HUElPIGRyaXZlciB0aGF0IHJlZ2lzdGVycyBhIG5ldyBzZXQgb2YgR1BJTw0KPj4gbGlu
ZXMgZm9yIHRoZSBoZWFkZXIgcGlucy4gV2hlbiB0aGVzZSBhcmUgcmVxdWVzdGVkLCB0aGUgZHJp
dmVyDQo+PiBwcm9wYWdhdGVzIHRoaXMgcmVxdWVzdCB0byB0aGUgYmFja2VuZCBTb0MgcGluY3Ry
bC9HUElPIGRyaXZlciBieQ0KPj4gZ3JhYmJpbmcgYSBHUElPIGRlc2NyaXB0b3IgZm9yIHRoZSBt
YXRjaGluZyBTb0MgR1BJTyBsaW5lLiBUaGUgbmVlZGVkDQo+PiBtYXBwaW5nIGZvciB0aGlzIGlz
IHJldHJpZXZlZCB2aWEgQUNQSSBwcm9wZXJ0aWVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERh
biBPJ0Rvbm92YW4gPGRhbkBlbXV0ZXguY29tPg0KPiBJdCBhcHBlYXJzIHlvdSBtaXNzZWQgbXkg
cmV2aWV3IGNvbW1lbnRzIHNvIHBsZWFzZSByZWFkIHRoZW0NCj4gYW5kIHJlcGx5IG9yIHJlc3Bp
biB0aGUgcGF0Y2ggYWNjb3JkaW5nbHkuDQpIaSBMaW51cy7CoCBVbmZvcnR1bmF0ZWx5IEkgZGlk
IG1pc3MgeW91ciBjb21tZW50cyBjb21wbGV0ZWx5LsKgIFNvbWVob3csIHRoZXkgd2VyZW4ndCBp
biBteSBJbmJveCwgYnV0IEkgZm91bmQgdGhlbSBpbiB0aGUgb25saW5lIGFyY2hpdmVzIG5vdy7C
oCBUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdy4NCkknbGwgcmVwbHkgdG8gdGhvc2Ugc29vbi4N
Cj4NCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg0K
