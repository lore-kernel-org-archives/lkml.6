Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFB22083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="TiXfINIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfBUQGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:06:43 -0500
Received: from mail-eopbgr20101.outbound.protection.outlook.com ([40.107.2.101]:32192
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbfBUQGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fk/XEM2KyADX3LQJ98yqIV+H5CzDiH3wo0muo7bgDok=;
 b=TiXfINIS+plAesmVCt4V6+rkoZ5q/95evpp0AJwyEMvrWPeOcwa0PnYEZD1A65iPpJTGbRHINArL4BElKxbTklzfE9v/vJUjMtPfRVrptwTHrIiBpK2P9LeVe8uei7zPEXtskR6/ym2x7o8YeIrn6/3DfU+mhh+uK5YUUAtERQo=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB5134.eurprd02.prod.outlook.com (20.178.13.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 16:06:36 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 16:06:36 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUyeOzPrJOZ7UkNky2yNQN5dmaTqXqU4QA///5AICAAB6IgA==
Date:   Thu, 21 Feb 2019 16:06:36 +0000
Message-ID: <f48947f4-ec86-6877-9c88-414cb0f4dca9@axentia.se>
References: <20190221181230.4892-1-pankaj.bansal@nxp.com>
 <70f7fa07-9643-a302-2162-362afbe123d6@axentia.se>
 <VI1PR0401MB24962C5D61CB8B4BA08DA491F17E0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24962C5D61CB8B4BA08DA491F17E0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0802CA0016.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::26) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a63dead-e4e4-4f9f-f4b1-08d698168e58
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB5134;
x-ms-traffictypediagnostic: VI1PR02MB5134:
x-microsoft-antispam-prvs: <VI1PR02MB5134A0B4040FD0F39415BB33BC7E0@VI1PR02MB5134.eurprd02.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(39830400003)(376002)(199004)(13464003)(189003)(26005)(64126003)(186003)(66066001)(97736004)(14444005)(71190400001)(256004)(476003)(5660300002)(6436002)(65956001)(6512007)(71200400001)(31686004)(81156014)(508600001)(7736002)(8676002)(25786009)(446003)(11346002)(81166006)(4326008)(6486002)(305945005)(31696002)(3846002)(2906002)(86362001)(6116002)(6246003)(8936002)(110136005)(14454004)(36756003)(316002)(561944003)(76176011)(53936002)(102836004)(6506007)(229853002)(65826007)(99286004)(53546011)(486006)(386003)(68736007)(2616005)(106356001)(105586002)(65806001)(52116002)(58126008)(74482002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5134;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjAyTUI1MTM0OzIzOm9MUzd5Mko5eHRCQTlZUEV2NDFGUGVoeDBT?=
 =?utf-8?B?SDV6VnZhNnFrN2V5RUdMeHZYdjZCY3Y3dkVoaTlBR3QvcUQweC9JOVZoTFRH?=
 =?utf-8?B?NGtjb093bjZpTkJ2YmErWmltRDdYdUNrWUVvZnh5TnZYZ3hmanJjakZNbHMz?=
 =?utf-8?B?R0ZFenpWcHMwYlBHVDBTa3hSVCtnS0JsMG4xRGNRelljYzJCRUwwclcwZ1ln?=
 =?utf-8?B?VzVRNDBzbzN6UlBwb1FvdmxNTVRXOVQ1U0lsYUJudkY1MjJmOC9SVHBWUjFw?=
 =?utf-8?B?T1BwcXRqUHZTWElxaTJYR3ZnY2k2NmdUK1ozRkZ6OXRabXY3YUdDR09OUkVh?=
 =?utf-8?B?L0lCQ3k1ZG5TUjB5b3hYODZjVVI5dFg0NExUeGJUdE82NU9UL2JrQlpOUXI2?=
 =?utf-8?B?SVV5YzdzS0xVcFFyWDY2VXJkcDkydFBVSnlvS1ViV3MxWlF0b2NTcEhDY3dr?=
 =?utf-8?B?RGZTTzZBZER1YmM3Y3F0c1BIME5FYlhzakRVdk9BV1BiRDBzdSt6anJqc3pO?=
 =?utf-8?B?VjE0bll2L2xlVW9ZcncwOGg4ZEdCV2phMkJvY1RFenVNM0V6OE9nVVFOSThO?=
 =?utf-8?B?dTBZNXlFYzhMRmsxRERDNWZuSTh3blNQa0JlajZlRnZsUHFwNElHdWRuVEZy?=
 =?utf-8?B?eGN6czRDbnBIQVBHUGtzWWpZejI5Q1ZYSGp5ZXNuaVhBQWJqUS9HVnRURlEy?=
 =?utf-8?B?eHo1cjNRaW1YTTQwbVlIUGNrZ0c1VXlrVUsycTgyN0NNK2hNbVRXZFUvbXhO?=
 =?utf-8?B?TTBIZDI1OFdycDVGQUZMZXVWd01xTytqdzVSaHJ2Wi9ZaHgvSlFrellhMnYr?=
 =?utf-8?B?c1ozSHQ4dGpVdVRSMS9LOUFLbFp5QzVJbUNTQ2hWYXNxRmV2Sy9RZzhObjdL?=
 =?utf-8?B?a0dCYzN2Qm52SHRJajBwWTVmWFJXVkVFdTBZM0p0dnVhWUhZc1JvZkVmS0N6?=
 =?utf-8?B?djU0NmU1ZjlQd0krTFNQa0QzUHpUZmRpejdKSkN6U3U4RWF5ai9vRS9qc05L?=
 =?utf-8?B?S0tMWUdWcTJxMTZGM09JeVVqWVJUcUtRNVNtRGpFMVcxYzY1Q3J4SEcrbWcr?=
 =?utf-8?B?dm1DZnh5S01sNmhlVnV6Q1NTMmlqRGRBMHdSaW1XdHFYS1BVY0dTWnRHNkZy?=
 =?utf-8?B?WDNaeXNaT2VSajJIckdDMFpNK2NLUmJhaC9rZU1CNzhQN09vT3BkYm9HczZG?=
 =?utf-8?B?MjFUU2x1dWNDVlpzTms0K3Y3a3p6MzRTWFZnNjZCTUc2dStZR3pqblViRll5?=
 =?utf-8?B?ZHlvaTZsOXlHTVRTUnJrMTVEay94VWMyb1FUQ2syYTlkdHlSUGl3NGNhdTlr?=
 =?utf-8?B?SDhJWEx2MFhReDhPVnFUazV3dDV3UVpsRFJhMmxrbml5M3MwYXI2ak9zKzNo?=
 =?utf-8?B?UDU4ayt2SCtFR0Y4STBoQXJRa2VSdS9WZytOajlqczlhbElYKytzU2tlUTYv?=
 =?utf-8?B?T1NaLzN0MlA4M29UdTR4WjBpY0lobDY2RW1XcUQrbVBLQUQxL2ZCQytBZitJ?=
 =?utf-8?B?WkFZL1FEZG1WWWhHb3pvQ1dFdVgyc1luQllDdVpnaU9IdkxveUNRKzBuZUJm?=
 =?utf-8?B?dGtOcnQ5UGRKaGFTSFB0ZXVsN2hqM0x3YStxKzE3UmtIOTkvMk1GS1ZidmtL?=
 =?utf-8?B?YXhzV2hiakp3c0lpSmJRaEYwRGdTb3YwbXFSTmRMWFFZSzRKUXBWMEJyeEhG?=
 =?utf-8?B?WUFBRmJ0VjFZV0JiRWtQL0EyOW1YVlZUM0NtY0dWak9lZkIrZUdxaW5lT0xz?=
 =?utf-8?B?Zit1M3BFQlBWTzVXMUVVeWV3YmF0UW56NHA5Nno5bXJzUDFCanFWcGx4b2NQ?=
 =?utf-8?B?NzNiSDV0R2srTURqNWVXL2lwbmZWSlFtMGhOc1JzYXN4TTRFcVlvTVJjWUM3?=
 =?utf-8?B?WW8xSUJSOE1HU3Y3SndiWDRaVXFCbVpkbS9FYkhUaGt1R09zY3NISjh3cHRF?=
 =?utf-8?B?TWFlVW9mRXdsWEtPYUhlY0pmZ0pvRkI0L3krZXZ5c0JhOWthbEZzZjJsM1B1?=
 =?utf-8?Q?9gjREs?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d9NKJEbH117sMxkSrDiDU8Q72E9rjoeW+qIua9oOXDvmhayLvihi9jzgI2FMoAKibjMVElZnh5nbgtd2JijQ20f1bMNlRW8b7VM1rYzFO/V0DvlCgrvX+dwQAkCMIr4W4c7ibgKCTFqb1Ux/3hM6df8+LuRs3hXDGnXOaLmf7ZwHDNNOeKepgtLMPCi++7xh8jel5/jJkd7XM46sXQTCjPpNleMeDP5SzcAhDeyuWCNBGI/ZXx8NmeTU3rebqi2sqoydDdrzDGY3U3gTVWuqryjRgDmO6AwkmZyoyUS6QI16FSjeWzfmliaWr34+InZbH9MyR7hzIuheenLqFchzLOf4QeoasCp1cVBV/bJ0T9OwnvaIDOcpK+Lk4Alf8XE0GgU6JU9zl+bAUrULZAnwiRDgOf7yLEqie5gUnu9cte0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDDB7805BDBA934B836036A51E487FAD@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a63dead-e4e4-4f9f-f4b1-08d698168e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 16:06:36.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0yMSAxNToxNywgUGFua2FqIEJhbnNhbCB3cm90ZToNCj4gDQo+IA0KPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IFBldGVyIFJvc2luIFttYWlsdG86cGVk
YUBheGVudGlhLnNlXQ0KPj4gU2VudDogVGh1cnNkYXksIDIxIEZlYnJ1YXJ5LCAyMDE5IDA3OjEy
IFBNDQo+PiBUbzogUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPjsgTGVvIExp
IDxsZW95YW5nLmxpQG54cC5jb20+DQo+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJpdmVyczogbXV4OiBBZGQgR2VuZXJpYyBy
ZWdtYXAgYml0ZmllbGQtYmFzZWQNCj4+IG11bHRpcGxleGVyIGluIG1taW8tbXV4DQo+Pg0KPj4g
SGkhDQo+Pg0KPj4gTXVjaCBiZXR0ZXIsIHRoYW5rcyEgT25lIG5pdCBiZWxvdzoNCj4+DQo+PiBP
biAyMDE5LTAyLTIxIDEzOjQ4LCBQYW5rYWogQmFuc2FsIHdyb3RlOg0KPj4+IEdlbmVyaWMgcmVn
aXN0ZXIgYml0ZmllbGQtYmFzZWQgbXVsdGlwbGV4ZXIgdGhhdCBjb250cm9scyB0aGUNCj4+PiBt
dWx0aXBsZXhlciBwcm9kdWNlciBkZWZpbmVkIHVuZGVyIGEgcGFyZW50IG5vZGUuDQo+Pj4gVGhl
IGRyaXZlciBjb3JyZXNwb25kaW5nIHRvIHBhcmVudCBub2RlIHByb3ZpZGVzIHJlZ2lzdGVyIHJl
YWQvd3JpdGUNCj4+PiBjYXBhYmlsaXRpZXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBQYW5r
YWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4+PiBOb3Rl
czoNCj4+PiAgICAgVjI6DQo+Pj4gICAgIC0gcmVtb3ZlZCBzZXBlcmF0ZSBkcml2ZXIgcmVnbWFw
LmMgYW5kIGFkZGVkIHRoZSByZWdtYXAgZnVuY3Rpb24gaW4NCj4+IG1taW8uYw0KPj4+ICAgICAg
IGJhc2VkIG9uIGNvbXBhdGlibGUgZmllbGQsIHRoZSBzeXNjb24gb3IgcmVnbWFwIGZ1bmN0aW9u
IHdvdWxkIGJlIGNhbGxlZA0KPj4+ICAgICAtIE1vZGlmaWVkIHRoZSBLQ29uZmlnIGFzIHBlciBQ
ZXRlcidzIGNvbW1lbnRzDQo+Pj4NCj4+PiAgZHJpdmVycy9tdXgvS2NvbmZpZyB8IDEyICsrKysr
Ky0tLS0tLSAgZHJpdmVycy9tdXgvbW1pby5jICB8ICA2DQo+Pj4gKysrKystDQo+Pj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL211eC9LY29uZmlnIGIvZHJpdmVycy9tdXgvS2NvbmZpZyBpbmRl
eA0KPj4+IDc2NTlkNmM1ZjcxOC4uZTVjNTcxZmQyMzJjIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZl
cnMvbXV4L0tjb25maWcNCj4+PiArKysgYi9kcml2ZXJzL211eC9LY29uZmlnDQo+Pj4gQEAgLTQ2
LDE0ICs0NiwxNCBAQCBjb25maWcgTVVYX0dQSU8NCj4+PiAgCSAgYmUgY2FsbGVkIG11eC1ncGlv
Lg0KPj4+DQo+Pj4gIGNvbmZpZyBNVVhfTU1JTw0KPj4+IC0JdHJpc3RhdGUgIk1NSU8gcmVnaXN0
ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciINCj4+PiAtCWRlcGVuZHMgb24gKE9G
ICYmIE1GRF9TWVNDT04pIHx8IENPTVBJTEVfVEVTVA0KPj4+ICsJdHJpc3RhdGUgIk1NSU8vUmVn
bWFwIHJlZ2lzdGVyIGJpdGZpZWxkLWNvbnRyb2xsZWQgTXVsdGlwbGV4ZXIiDQo+Pj4gKwlkZXBl
bmRzIG9uIE9GIHx8IENPTVBJTEVfVEVTVA0KPj4+ICAJaGVscA0KPj4+IC0JICBNTUlPIHJlZ2lz
dGVyIGJpdGZpZWxkLWNvbnRyb2xsZWQgTXVsdGlwbGV4ZXIgY29udHJvbGxlci4NCj4+PiArCSAg
TU1JTy9SZWdtYXAgcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciBjb250
cm9sbGVyLg0KPj4+DQo+Pj4gLQkgIFRoZSBkcml2ZXIgYnVpbGRzIG11bHRpcGxleGVyIGNvbnRy
b2xsZXJzIGZvciBiaXRmaWVsZHMgaW4gYSBzeXNjb24NCj4+PiAtCSAgcmVnaXN0ZXIuIEZvciBO
IGJpdCB3aWRlIGJpdGZpZWxkcywgdGhlcmUgd2lsbCBiZSAyXk4gcG9zc2libGUNCj4+PiAtCSAg
bXVsdGlwbGV4ZXIgc3RhdGVzLg0KPj4+ICsJICBUaGUgZHJpdmVyIGJ1aWxkcyBtdWx0aXBsZXhl
ciBjb250cm9sbGVycyBmb3IgYml0ZmllbGRzIGluIGVpdGhlcg0KPj4+ICsJICBhIHN5c2NvbiBy
ZWdpc3RlciBvciBhIGRyaXZlciByZWdtYXAgcmVnaXN0ZXIuIEZvciBOIGJpdCB3aWRlDQo+Pj4g
KwkgIGJpdGZpZWxkcywgdGhlcmUgd2lsbCBiZSAyXk4gcG9zc2libGUgbXVsdGlwbGV4ZXIgc3Rh
dGVzLg0KPj4+DQo+Pj4gIAkgIFRvIGNvbXBpbGUgdGhlIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hv
b3NlIE0gaGVyZTogdGhlIG1vZHVsZSB3aWxsDQo+Pj4gIAkgIGJlIGNhbGxlZCBtdXgtbW1pby4N
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdXgvbW1pby5jIGIvZHJpdmVycy9tdXgvbW1pby5j
IGluZGV4DQo+Pj4gOTM1YWM0NGFhMjA5Li4zN2ZiY2RlN2YxZmMgMTAwNjQ0DQo+Pj4gLS0tIGEv
ZHJpdmVycy9tdXgvbW1pby5jDQo+Pj4gKysrIGIvZHJpdmVycy9tdXgvbW1pby5jDQo+Pj4gQEAg
LTI4LDYgKzI4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdXhfY29udHJvbF9vcHMgbXV4X21t
aW9fb3BzID0gew0KPj4+DQo+Pj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG11
eF9tbWlvX2R0X2lkc1tdID0gew0KPj4+ICAJeyAuY29tcGF0aWJsZSA9ICJtbWlvLW11eCIsIH0s
DQo+Pj4gKwl7IC5jb21wYXRpYmxlID0gInJlZy1tdXgiLCB9LA0KPj4+ICAJeyAvKiBzZW50aW5l
bCAqLyB9DQo+Pj4gIH07DQo+Pj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG11eF9tbWlvX2R0
X2lkcyk7IEBAIC00Myw3ICs0NCwxMCBAQA0KPj4gc3RhdGljDQo+Pj4gaW50IG11eF9tbWlvX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4gIAlpbnQgcmV0Ow0KPj4+ICAJ
aW50IGk7DQo+Pj4NCj4+PiAtCXJlZ21hcCA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChucC0+cGFy
ZW50KTsNCj4+PiArCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgIm1taW8tbXV4Iikp
DQo+Pj4gKwkJcmVnbWFwID0gc3lzY29uX25vZGVfdG9fcmVnbWFwKG5wLT5wYXJlbnQpOw0KPj4+
ICsJZWxzZQ0KPj4+ICsJCXJlZ21hcCA9IGRldl9nZXRfcmVnbWFwKGRldi0+cGFyZW50LCBOVUxM
KTsNCj4+DQo+PiBkZXZfZ2V0X3JlZ21hcCgpIHJldHVybnMgTlVMTCBvbiBmYWlsdXJlLCBzbyBJ
IHRoaW5rIHlvdSBuZWVkIHNvbWV0aGluZyBsaWtlOg0KPj4NCj4+IAkJcmVnbWFwID0gZGV2X2dl
dF9yZWdtYXAoZGV2LT5wYXJlbnQsIE5VTEwpID86IEVSUl9QVFIoLQ0KPj4gRUlOVkFMKTsNCj4+
DQo+PiBPciBwZXJoYXBzIC1FTk9ERVYsIC1FTk9UU1VQUCBvciBzb21ldGhpbmcsIG5vdCBzdXJl
Pw0KPiANCj4gSG93IGFib3V0IElTX0VSUl9PUl9OVUxMIGp1c3QgYmVsb3cgdGhpcywgd2hlcmUg
cmlnaHQgbm93IElTX0VSUiBpcyBiZWluZyB1c2VkID8NCg0KSSBkaXNjYXJkZWQgdGhhdCBzaW5j
ZSB5b3UgdGhlbiBoYXZlIHRvIHNwZWNpYWxpemUgdGhlIGVycm9yIGhhbmRsaW5nDQp0byBub3Qg
anVzdCBkbyAicmV0ID0gUFRSX0VSUihyZWdtYXApOyINCg0KQnV0IGlmIHlvdSdkIGxpa2UgdG8g
ZG8gc29tZXRoaW5nIG90aGVyIHRoYW4gbXkgbWluaW1hbCBmaXgsIHRoZW4gZmVlbCBmcmVlDQp0
byBtYWtlIGEgcHJvcG9zYWwuLi4NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiANCj4+DQo+PiBDaGVl
cnMsDQo+PiBQZXRlcg0KPj4NCj4+PiAgCWlmIChJU19FUlIocmVnbWFwKSkgew0KPj4+ICAJCXJl
dCA9IFBUUl9FUlIocmVnbWFwKTsNCj4+PiAgCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBnZXQg
cmVnbWFwOiAlZFxuIiwgcmV0KTsNCj4+Pg0KPiANCg0K
