Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B3BC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD540218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfAYMYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:24:54 -0500
Received: from mail-oln040092064037.outbound.protection.outlook.com ([40.92.64.37]:44960
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfAYMYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:24:53 -0500
Received: from VE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
 (10.152.2.52) by VE1EUR01HT103.eop-EUR01.prod.protection.outlook.com
 (10.152.3.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.11; Fri, 25 Jan
 2019 12:24:49 +0000
Received: from AM0PR07MB3874.eurprd07.prod.outlook.com (10.152.2.59) by
 VE1EUR01FT014.mail.protection.outlook.com (10.152.2.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.11 via Frontend Transport; Fri, 25 Jan 2019 12:24:49 +0000
Received: from AM0PR07MB3874.eurprd07.prod.outlook.com
 ([fe80::890e:c9ab:41b6:5f70]) by AM0PR07MB3874.eurprd07.prod.outlook.com
 ([fe80::890e:c9ab:41b6:5f70%2]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 12:24:49 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Sebor <msebor@gmail.com>
Subject: Re: [RFC][PATCH] Update -Wattribute-alias for gcc9
Thread-Topic: [RFC][PATCH] Update -Wattribute-alias for gcc9
Thread-Index: AQHUtJzuSvpMiiJM/0mOmnepw49bKqW/3AMAgAAMrQA=
Date:   Fri, 25 Jan 2019 12:24:49 +0000
Message-ID: <AM0PR07MB387404F71D25553702966E27E49B0@AM0PR07MB3874.eurprd07.prod.outlook.com>
References: <20190125104353.2791-1-labbott@redhat.com>
 <CAK8P3a0xnc7RNbGhG7-hj+ay2keR7dh7MmDiUNKxfewsnatsgA@mail.gmail.com>
 <CANiq72=nMYcohMk29fzs3bMut1PXwfqYLZdbRh_AeTN-Z4FpxQ@mail.gmail.com>
In-Reply-To: <CANiq72=nMYcohMk29fzs3bMut1PXwfqYLZdbRh_AeTN-Z4FpxQ@mail.gmail.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0054.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::31) To AM0PR07MB3874.eurprd07.prod.outlook.com
 (2603:10a6:208:45::26)
x-incomingtopheadermarker: OriginalChecksum:3E711B46D0BA52C7403C3534509D066BDCDB7912F05FC08DA38B5CA6FB81A384;UpperCasedChecksum:607F9E8C40085E2D57E3B6819E21FFCBEC99A67BE52AED2B795BAA337E657627;SizeAsReceived:8957;Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [cAV3LXf4D/XiZ3q05KQbwcFqMTh3TFip]
x-microsoft-original-message-id: <f81fc121-3e30-1ba8-da47-c9cc68542b82@hotmail.de>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR01HT103;6:6MWz5CjrJAEH1doUYCj1ZvoF2ZV3OkaYU/SdF5pxWwN6W7tfDyPG4Sa2+vE05k6Tvc018l42MlBuQwhrWctqYx7RJl9FOmroCLOI9agojKQGtnLRLKLi+IP/DpRp9iZpc3i9wDj6oTv38vOrN9pGJKePA6ivvl9TzfyDPqF6QK3dFpygK9AerjM8ArZwllGx6Cf4JzsVmDqqNNyuHwPmAuA0EcPcnxslas1huekk9J+515062QqONCJ+7PMIpp9zmxa22gpvRbfg197cHXA0KjqFzb7UF6BFWPCuKNw40X1q0LRnAfnWZ1ChS5pP6WQkaZZG3HjR9/molKXRgCAOPI6YkOrV4f3NO7wfDGvxudCjgMid7g00clPT8rLpeVtFZk+0eQFH0/E8g7GjrFNMrxnIFGAhHjJMBiqcU4RNYH58/R+kExNWDvUsysnax3Vnx/Jfz235mpGYqb8qk+wMgw==;5:iq9D1Y7U2NxAyvdTNeJaczIc7FN58d+1iAOfLGCSeafqISne1UqGF720AQhxPAb1H6qbn5/AbvSOqKslm0Iiz09eObAm1LbeNinTpannyebOn5nf7RKsKIeCej50ZF6XaZBge3QNuP11QMQprrqOHgj8QV2mk7IPTjogwq56h9zAC9E/BQzxP2Z7KmD57ESg+TdW1y+nVjuMKxwhblBEEg==;7:z/uMzPZjzYgY+SqCgIfTFbFOh/pLtA5F3jqiHZ727/zMt1jc0Ez3SJn4sj9IhysSY0i8iBzBPP5Xc+JISutwx6dUyEGWzBbOEN8S4XVwcjC2RSoitHvXSZi3mwT48zGo2UpT6BJnHdDqa4jWIULU1w==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR01HT103;
x-ms-traffictypediagnostic: VE1EUR01HT103:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR01HT103;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR01HT103;
x-microsoft-antispam-message-info: tMzvRW9xthIUUxQMwAwe9qC8kor/2yqfl8tgcmzgTYrHa8ZmyOEnM2cxllg0o00S
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2C16C5DCDE4CA40AE6B590EC54DF3B8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 6060316a-5b0f-425c-21e4-08d682c018c4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 12:24:47.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNS8xOSAxMjozOSBQTSwgTWlndWVsIE9qZWRhIHdyb3RlOg0KPiBPbiBGcmksIEphbiAy
NSwgMjAxOSBhdCAxMTo1OCBBTSBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiB3cm90ZToN
Cj4+DQo+PiBPbiBGcmksIEphbiAyNSwgMjAxOSBhdCAxMTo0MyBBTSBMYXVyYSBBYmJvdHQgPGxh
YmJvdHRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBDb21taXQgYmVlMjAwMzE3NzJhICgi
ZGlzYWJsZSAtV2F0dHJpYnV0ZS1hbGlhcyB3YXJuaW5nIGZvcg0KPj4+IFNZU0NBTExfREVGSU5F
eCgpIikgZGlzYWJsZWQgLVdhdHRyaWJ1dGUtYWxpYXMgd2l0aCBnY2M4Lg0KPj4+IGdjYzkgY2hh
bmdlZCB0aGUgZm9ybWF0IG9mIC1XYXR0cmlidXRlLWFsaWFzIHRvIHRha2UgYSBwYXJhbWV0ZXIu
DQo+Pj4gVGhpcyBkb2Vzbid0IHF1aXRlIG1hdGNoIHdpdGggdGhlIGV4aXN0aW5nIGRpc2FibGlu
ZyBtZWNoYW5pc20NCj4+PiBzbyB1cGRhdGUgZm9yIGdjYzkgdG8gbWF0Y2ggd2l0aCB0aGUgZGVm
YXVsdCAoLVdhdHRyaWJ1dGUtYWxpYXM9MSkuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBMYXVy
YSBBYmJvdHQgPGxhYmJvdHRAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+PiBUaGlzIGlzIFJGQyBi
ZWNhdXNlIGl0IGZlZWxzIHVnbHkuIEkgd2VudCBhaGVhZCBhbmQgZGlkIHRoZSBvYnZpb3VzIGZp
eHVwDQo+Pj4gYnV0IGl0J3Mgd29ydGggZGlzY3Vzc2luZyBpZiB3ZSdyZSBnb2luZyB0byBlbmQg
dXAgd2l0aCBhbiBleHBsb3Npb24gb3INCj4+PiBpZiB0aGVyZSdzIGEgYmV0dGVyIHdheSB0byBo
YW5kbGUgdGhpcyBpbiBvbmUgbWFjcm8uDQo+Pg0KPj4gQmVybmQgRWRsaW5nZXIgaGFzIHNlbnQg
YSBwYXRjaCB0byBnY2MgZm9yIHRoaXM6DQo+PiBodHRwczovL2djYy5nbnUub3JnL21sL2djYy1w
YXRjaGVzLzIwMTktMDEvbXNnMDExMjAuaHRtbA0KPj4NCj4+IGFuZCBNaWd1ZWwgT2plZGEgc2Fp
ZCBoZSB3YW50ZWQgdG8gc2VuZCBhIHBhdGNoIGZvciBpdCB0byB0aGUNCj4+IGtlcm5lbCBhcyB3
ZWxsLCBub3Qgc3VyZSBpZiBoZSB3YW50ZWQgdG8gdGFrZSBhIGRpZmZlcmVudA0KPj4gYXBwcm9h
Y2ggdGhlcmUsIHNvIGFkZGluZyBib3RoIHRvIENjIGhlcmUuDQo+IA0KPiBUaGFua3MgQXJuZCAo
SSB3YXMgd29ya2luZyB3aXRoIE1hcnRpbiBvbiB0aGUgZXhwYW5kZWQNCj4gLVdtaXNzaW5nLWF0
dHJpYnV0ZSB3YXJuaW5ncywgbm90IG9uIHRoaXMsIGJ1dCB0aGFua3MgbmV2ZXJ0aGVsZXNzIDop
Lg0KPiANCj4gTWFydGluL0Jlcm5kOiBmcm9tIHRoZSBHQ0MgbWFpbGluZyBsaXN0IEkgYW0gbm90
IHN1cmUgaWYgd2Ugc2hvdWxkDQo+IGV4cGVjdCB0aGUgb2xkIGJlaGF2aW9yIHRvIGJlIG1haW50
YWluZWQgb3Igbm90Lg0KPiANCg0KSSBiZWxpZXZlIGl0IGlzIG5vdCBpbnRlbnRpb25hbCB0byBi
cmVhayB0aGUgb2xkIHN5bnRheCBvZiB0aGUNCnByYWdtYS4gIFRoZXJlIHdpbGwgYmUgbmV3IC1X
YXR0cmlidXRlLWFsaWFzPTEgYW5kIC1XYXR0cmlidXRlLWFsaWFzPTINCmFuZCAtV2F0dHJpYnV0
ZS1hbGlhcyBpcyBlYXN5IHRvIHJldGFpbiBhcyBhbiBhbGlhcyBmb3IgLVdhdHRyaWJ1dGUtYWxp
YXM9MS4NClRoYXQgaXMgd2hhdCBteSBwYXRjaCB3aWxsIGRvLg0KDQoNCkJlcm5kLg0K
