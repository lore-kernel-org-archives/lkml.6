Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AE7213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Cuw6bt6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBZIUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:20:17 -0500
Received: from mail-eopbgr130093.outbound.protection.outlook.com ([40.107.13.93]:52384
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfBZIUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grcki9LT7nDUyHycYgVB46EaPy0JiVWD8aRvoD81Bt0=;
 b=Cuw6bt6XXZSXQ/4BGPLbTZ3V6ICGSdYBhOhlnuAsjlT8JpTeQBD/M1+Xrbw3IkEmzFYxM2vj1I93/rJLT41SixNtFEUfHgwq93jriTBDooHjH+8JUC0hfCCf0SPvUcC/+5rImnJLzRXkgqhQabeybU15e0oAVU/MF0qqVZK02jE=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB0637.eurprd02.prod.outlook.com (10.162.10.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 08:20:11 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:20:11 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUzBrIcvg0ZIo5aUyXr9NSc4+4PqXwqZoAgADxogCAACS5AA==
Date:   Tue, 26 Feb 2019 08:20:11 +0000
Message-ID: <034d8b58-ce4a-87a1-12cf-a652b344e9eb@axentia.se>
References: <20190224135143.24770-1-pankaj.bansal@nxp.com>
 <20190224135143.24770-2-pankaj.bansal@nxp.com>
 <ea09336d-465f-aef1-ba7a-c80364a39f90@axentia.se>
 <VI1PR0401MB24963EE1460E0FF47CDF066CF17B0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24963EE1460E0FF47CDF066CF17B0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46dc1ffb-430d-4b9d-79a7-08d69bc339ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB0637;
x-ms-traffictypediagnostic: VI1PR02MB0637:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR02MB06377847BD44759151C17F9ABC7B0@VI1PR02MB0637.eurprd02.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39830400003)(376002)(346002)(199004)(189003)(76176011)(52116002)(93886005)(446003)(486006)(8676002)(6246003)(99286004)(81156014)(81166006)(11346002)(476003)(2616005)(71200400001)(71190400001)(4326008)(64126003)(25786009)(966005)(36756003)(2906002)(97736004)(229853002)(102836004)(316002)(106356001)(105586002)(58126008)(53546011)(31686004)(186003)(65826007)(386003)(26005)(508600001)(8936002)(5660300002)(256004)(65956001)(66066001)(65806001)(3846002)(6116002)(110136005)(68736007)(305945005)(7736002)(6512007)(31696002)(86362001)(14454004)(74482002)(6306002)(6486002)(6506007)(6436002)(53936002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB0637;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjAyTUIwNjM3OzIzOmN5aWdEaDBQWkpKRXRNSDYwTHVQcHMvTWxY?=
 =?utf-8?B?ajBEYi9INFZ2aFpHQWFUR2dtbDVCNkhPS01LeGtFT0pqTXNsWUlaVEplZEg5?=
 =?utf-8?B?aU51ZHBMM3ZFUjNrK2o1MEN2Z01MSm5sWjI2eHlqRUVkRndSVjUzY3dlSEsr?=
 =?utf-8?B?NjhISVlVbmZQeHZyYXNTcVdtVmVmUlM3R1J4aWxYV1NyVWcxV2g2WEhpcHcy?=
 =?utf-8?B?SGhoWVZCQlVFV01wb05za1pkNEE0ckFPQlRUcEwvbG8zQmdGWnNQNU9mM0Ez?=
 =?utf-8?B?YzE1WjFvT05TTll2V05uS0JtblAzNnIxQitaWGVnS1pDNUlHOXZIMXM1aW93?=
 =?utf-8?B?RStqamROMllnYXpRR3NNamhHdnU2S1ZyQjl2OCtzV2tSWC95Z1JuVUl4WHo2?=
 =?utf-8?B?QVhuSHA1YytsTjh3Tll4dFREdVRJb1hEb29tcDRGd0c2S0NCczdxRUpSS1ZX?=
 =?utf-8?B?RUMydU5WaStid29DSFJTZ1UzUXIzVytWcVRoNFo5djU1WjBsNEplL2s2ZEpG?=
 =?utf-8?B?c3gxY25ZR213Z1RvalNJUXUxWTBNU3FsN3o1WXlKWGJFL2cxY3MwdHg2NHZT?=
 =?utf-8?B?WHcxS3VXYXZVYVA2enNaVzFsOUxrTEwrQ0VMQitYbjQ0amlIZThtcEYvM0hV?=
 =?utf-8?B?d3pDK29Fb1dyY0p6OVNLei9xQWJuL3pPTEpVS1V5VEtDSnAzd2M0eTlYaTNM?=
 =?utf-8?B?Tjd6cUh6cmZlUFVPbGY5WHlDQjc1eEIwM3U3ZEN0cktwUitTVFl1MzY5QXdO?=
 =?utf-8?B?RmRBb0RyYzdrRDdPbWRYS05DTEh2VW0yVGU2VHU3bVZESUJhMVl5cDd0a2tu?=
 =?utf-8?B?WjN6YXVvS2M2cFNXZXpNMFJHOW5WeUFaZXpoM20xSUNqbEc5eS9JeTg5N2s3?=
 =?utf-8?B?Mm9jMFpkNnNiazE3aXg4WVZJVXZXZ2M3RGU5Y2ZGVjQ3a1l1VzI5cEowRW5I?=
 =?utf-8?B?ZkZEL1l3UzNlblBzdEE3a1lSQVdtdDVla2doaGQzS2VlUDNZcFIvZk5zM3U1?=
 =?utf-8?B?bzhjN2diZE1pcDhobjlESDRYSDQyZStlc0NYWlY0WGl1bnJRbnpJUHZRWnVD?=
 =?utf-8?B?enUzdkpCRnFGcnV4QWxzRG12VUNvOUg5NUVCMnZOR09qcnpBZ0tsNHZQenRo?=
 =?utf-8?B?bEZabmRsT3ZqUG56N2ZLZkpBMU5YN0tvdHZnOXpDOWJFZ2NNZjZNSFg1WEhw?=
 =?utf-8?B?WEhyWXh4RGhybUJ3MFFiUW5iY1JZQ293ODV6ZHB3NGg4cE9vektIZ1k4T09r?=
 =?utf-8?B?R1dVR2FvL0g5Q0N5ekVpNGN4SEJDRlhHckREOXB3RFhJc1pmM1JlSW9MemFY?=
 =?utf-8?B?eUptZktOcDVPYW1OOC8wY05lNkx0R01WVEI0L2kzd2I1S2VlKzRXTVJCSUtp?=
 =?utf-8?B?Ukowa29HdElLK2lLVUtiWmdaN3BSR1loSU0wRlJtZ3owV0NJOStNbUI3M01Q?=
 =?utf-8?B?VzBCZzRhR1cxeTFOQnZhZnNuRWRCS2MwaXd3VkR4azJvY2hkemI5M0YydjM2?=
 =?utf-8?B?V25uTURDYWREU0tnT0tXVEYxRGk3MUxwN0pDb3RzR0N2OTlwMXRjUHAvZmRW?=
 =?utf-8?B?NThjb2xqbHFib2FheVp0K0kyVEF2QmlBR1UzemJzcG5ydno3cTRvY1h0VnpE?=
 =?utf-8?B?ZGQ1NmtsWnYvVnFVS3B1S3Qwbm9SZVpTVWVPU2xRV3FaeUlZY1NsVkVtN2Zm?=
 =?utf-8?B?cWlTMFltVUI4VmNEdlJsWVZBd1lSenZ0TkNUaG1oeVJJRG8vRTR5em55SVM2?=
 =?utf-8?B?eW0zMzFPVU1qOTNCdDdrYnNFbXk4VXBxdDRWd1VDOXg5VlZYc2t3MjI4em5N?=
 =?utf-8?B?aFR3ZlREcStPUjNrSURxUVFGN2Z2MHU5N05UZHEwMXRId3pESUkzWWlsb1Zn?=
 =?utf-8?B?VHFPKzJveHJncGpXdFY5Uk5lNDBkQjFCV1JqT1JtUDRqZUxhdUg3UEQ1S2dG?=
 =?utf-8?B?by96bEVMQUZvK3JDeXJlbnpFN1ZCcUFEUElYUjlGZlpUVmhWM1p2cy9Nakt1?=
 =?utf-8?Q?iLOw83?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rCpUF2zEjXgYpDWfzAPGDEbJJIpdJamFTfJOXIExA935YE0VgZZO2t22uiJgFPOhJ6x/BlMGR6Rt+l9ZJ6Eu3/WblZPHeFfgoMx+TgPY1j+/YpeHWL0rE0Y8O7JJurqfwbJyZQbS+yH1jvk19o7WBe0BavlPrq0++iCIPXvKG8JedA4ubdIEMUCxhEOYMd5vCA29ae0yQ53abo2CcvHag4Op5CuDoO2nWUdQPnIzSgQM+QYjGhWees4p9Nil9+QJ3T38Vk2TspKUvM/rngF2RNZZSVjvxI8ZeIp3BAaAmYz+NgYUsXLN/VhGEe9AwDVdDRORSm3KEynMufWEP208hy7r1OVKdDl5JjlrfBR5BmnQuoIvdhrw9Yt7doMIbe2RhtUBywPfQwKnL3TQV9FDnz7a1l8MY5TMQQySE4HsLUo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F51266B689EB814688D38071A3F9F744@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dc1ffb-430d-4b9d-79a7-08d69bc339ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:20:10.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB0637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0yNiAwNzowOCwgUGFua2FqIEJhbnNhbCB3cm90ZToNCj4+PiArCWlmIChJU19F
UlJfT1JfTlVMTChyZWdtYXApKSB7DQo+Pj4gKwkJcmV0ID0gUFRSX0VSUl9PUl9aRVJPKHJlZ21h
cCkgPyBQVFJfRVJSKHJlZ21hcCkgOiAtDQo+PiBFTk9ERVY7DQo+Pg0KPj4gVGhlIGFib3ZlIGlz
IG5vdCBjb3JyZWN0LCB0aGlzIHNob3VsZCBiZSBiZXR0ZXIgKHVudGVzdGVkKToNCj4+DQo+PiAJ
CXJldCA9IFBUUl9FUlIocmVnbWFwKSA/OiAtRU5PREVWOw0KPiANCj4gT21pdHRpbmcgdGhlIHNl
Y29uZCBvcGVyYW5kIGluIHRlcm5hcnkgb3BlcmF0b3IgaXMgbm90IHN0YW5kYXJkLiBodHRwczov
L3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy8zNDU1OTcwNS90ZXJuYXJ5LW9wZXJhdG9yLXdp
dGhvdXQtdGhlLW1pZGRsZS1leHByZXNzaW9uDQoNCklycmVsZXZhbnQsIGEgZ3JlYXQgbWFueSBu
b24tc3RhbmRhcmQgZmVhdHVyZXMgYXJlIHVzZWQgaW4gdGhlIGtlcm5lbC4NCg0KPiBBbHRob3Vn
aCwgaXQgKmhhcyBiZWVuKiB1c2VkIGluIGtlcm5lbCBpbiBtYW55IHBsYWNlcw0KPiBodHRwczov
L2xpdmVncmVwLmNvbS9zZWFyY2gvbGludXg/cT1maWxlJTNBJTVDLmMlMjQlMjAlNUMlM0YlNUMl
M0EmZm9sZF9jYXNlPWF1dG8mcmVnZXg9dHJ1ZSZjb250ZXh0PXRydWUNCg0KWWVzLCBhIGxvY2Fs
IGdyZXAgc3VnZ2VzdHMgdGhhdCB0aGVyZSBhcmUgcGxlbnR5IG9mIGluc3RhbmNlcyBpbiB0aGUN
Cmtlcm5lbC4gSW4gZmFjdCwgdGhlcmUgYXJlIG11bHRpcGxlIGluc3RhbmNlcyBldmVuIGluIHRo
ZSBrZXJuZWwvDQpkaXJlY3Rvcnkgc28gaXQncyBub3Qgc29tZSBmcmluZ2UgdGhpbmcuIE15IGNv
bmNsdXNpb24gaXMgdGhhdCBpdA0KbWFrZXMgZm9yIHJlYWRhYmxlIGNvZGUgYW5kIGlzIHBlcmZl
Y3RseSBzYWZlIHRvIHVzZSBpbiB0aGUga2VybmVsLA0Kd2hpY2ggYXBwYXJlbnRseSBkb2VzIG5v
dCBjYXJlIGFib3V0IGNvbXBpbGVycyB0aGF0IGRvIG5vdCB1bmRlcnN0YW5kDQp0aGUgY29uc3Ry
dWN0Lg0KDQokIGdpdCBncmVwICc/OicgKi5bY2hdIHwgd2MNCiAgICA3NzMgICAgNDgzMCAgIDU0
OTc1DQoNCkkgeW91IHN0aWxsIGRvbid0IGJ1eSB0aGF0IGFuZCBkb24ndCB3YW50IHRvIHNpZ24t
b2ZmIG9uIGl0LCB0aGVuDQp3cml0ZQ0KDQoJCXJldCA9IElTX0VSUihyZWdtYXApID8gUFRSX0VS
UihyZWdtYXApIDogLUVOT0RFVjsNCg0KQnV0IHRoYXQncyBqdXN0IHdvcmR5IGFuZCBsZXNzIHJl
YWRhYmxlLCBtZXRoaW5rcy4NCg0KSG93ZXZlciwgdGhlIGJlc3QgdGhpbmcgdG8gZG8sIGFjY29y
ZGluZyB0byB5b3VyIG1haW50YWluZXIsIGlzIHN0aWxsDQp0aGUgb3JpZ2luYWwgc3VnZ2VzdGlv
biB0byBmaXh1cCB0aGUgTlVMTCBhcyBlYXJseSBhcyBwb3NzaWJsZSB3aXRoDQoNCgkJcmVnbWFw
ID0gZGV2X2dldF9yZWdtYXAoZGV2LT5wYXJlbnQsIE5VTEwpID86IEVSUl9QVFIoLUVOT0RFVik7
DQoNCkFuZCBsZWF2ZSB0aGUgZXJyb3IgaGFuZGxpbmcgYmxvY2sgYWxvbmUuIENhbiB5b3UgcGxl
YXNlIGp1c3QgZG8gdGhhdA0KYW5kIGJlIGRvbmUgd2l0aCBpdD8NCg0KQ2hlZXJzLA0KUGV0ZXIN
Cg==
