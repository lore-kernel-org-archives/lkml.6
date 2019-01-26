Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB3DC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94401218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfAZDkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:42 -0500
Received: from mail-oln040092003068.outbound.protection.outlook.com ([40.92.3.68]:38642
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729523AbfAZDkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:42 -0500
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (10.152.76.54) by BL2NAM02HT087.eop-nam02.prod.protection.outlook.com
 (10.152.76.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 26 Jan
 2019 03:40:38 +0000
Received: from BYAPR02MB5495.namprd02.prod.outlook.com (10.152.76.57) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 26 Jan 2019 03:40:38 +0000
Received: from BYAPR02MB5495.namprd02.prod.outlook.com
 ([fe80::b889:1a99:77fa:d4fe]) by BYAPR02MB5495.namprd02.prod.outlook.com
 ([fe80::b889:1a99:77fa:d4fe%2]) with mapi id 15.20.1558.021; Sat, 26 Jan 2019
 03:40:38 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?utf-8?B?UGF3ZcWCIENobWllbA==?= <pawel.mikolaj.chmiel@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] input: misc: bma150: Use managed resources helpers
Thread-Topic: [PATCH 1/3] input: misc: bma150: Use managed resources helpers
Thread-Index: AQHUtN3zmNDeFtm4FkKxjvAgIw+UlqXAw1WAgAAktIA=
Date:   Sat, 26 Jan 2019 03:40:38 +0000
Message-ID: <BYAPR02MB549573B44BDD22147A8375F9A3940@BYAPR02MB5495.namprd02.prod.outlook.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125184400.17669-2-pawel.mikolaj.chmiel@gmail.com>
 <20190126012909.GE212026@dtor-ws>
In-Reply-To: <20190126012909.GE212026@dtor-ws>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0011.namprd19.prod.outlook.com
 (2603:10b6:300:d4::21) To BYAPR02MB5495.namprd02.prod.outlook.com
 (2603:10b6:a03:9a::25)
x-incomingtopheadermarker: OriginalChecksum:FD3E01DFD038B90C786F792435CE20C8FE6AFCF2AD2F6F438F0FF54FC1195746;UpperCasedChecksum:C01947AD17311E66AD01995843CF0791F3B23DCC02FB28B9F407E44BD979DEB9;SizeAsReceived:8987;Count:64
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [3Nj6dU9JmeXPGKzq8PIyOj5p3NCBFEJO4RhBCYRq2Glc171tRQWHDrEEDxWqjEJc]
x-microsoft-original-message-id: <3f470a4a-9bf2-c2da-01e8-d12c0956eb64@live.ca>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2NAM02HT087;6:DeaUSFr+5uiZbkYSL+EoRDslUz5M7B//ngSh2/MI79jPacWcybounoZYysPKGMvIWmnEkEay8wtPdyxmFFFlzNUvuF2x3YyT0PAnL8aGBzSZy8EVAWbI9xiuHqWFwL80aPoniGfGGL743JTiEKpXOnUsMHma7Gp6YKoP0T21D3wVKvwq9wfLleBbaoZjfnntvh2Z7vYfl425EzLzf31YTrEPEf0etqxVBDk1BxTUgNDr+uMoVM3qwlYWhWgG1ehhSVx/6r2daZVEusGaafWg2KW+yvowez4iWJW+CVAkJACgFVBELgj6c9EDQ8ZymTJc2MZ+jaFQhtcPxNpjEIXtpsI2PfzUH6lhuXE3bCxYrI8PSX/o2l7O8+FU6Yc5g4NdUnCfGJ8SVjlbqmIDo3VKnQkQHLZ6EpEMU5//aYfiDpFFEMuh0A+bw9/MdGZ8IbYIh4AO9sC3hotb6u2VFD+gTg==;5:5sk2BQnWzbeHx1JSip0e5GqvvD1X6es0dOv3mZhj5qbMHJ3hYOyROcuNbG8oHIHERME28V7PMciou67EQQ3+AiFVHH1J7zTyNGHT/sJV6LrzAYCI6pecXN11PyGDMm/eYQ6VXAw6srMy0eesjpgQkGXQY89XZZU0wesAtljY1e0H4gk6gyIH2j1DMpi+JfULimYgeR1lfRQYbpr8N1Xztg==;7:n9fm28IjRHvs3l29bI8MH1UTqGfOJ0f9tyC7kbblY5YJJTjbXUNNdYXpsF24i4Qm4hVrN/go99sfoHC1mbVzGBUBl2BkJnztzq9ZiJSUXrEt59dsDYXqqLQ1cSrqVD7OrOyqxlUET4X9lTNktHAkBQ==
x-incomingheadercount: 64
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:BL2NAM02HT087;
x-ms-traffictypediagnostic: BL2NAM02HT087:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BL2NAM02HT087;BCL:0;PCL:0;RULEID:;SRVR:BL2NAM02HT087;
x-microsoft-antispam-message-info: 5QrTaAEIbVhwx1A/zEfQOdBsSAZ9NIubobwmLF3G/9woC6NdgTQbAH8tpsKqMTnU
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9BB699F09736B45A593C4DEFA8930F5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9bd8b953-1c55-4da7-b616-8bcad099ae8b
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d5d64-7ae7-4c21-16e3-08d6834009c3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9bd8b953-1c55-4da7-b616-8bcad099ae8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2019 03:40:38.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTktMDEtMjUgNToyOSBwLm0uLCBEbWl0cnkgVG9yb2tob3Ygd3JvdGU6DQo+IE9u
IEZyaSwgSmFuIDI1LCAyMDE5IGF0IDA3OjQzOjU4UE0gKzAxMDAsIFBhd2XFgiBDaG1pZWwgd3Jv
dGU6DQo+PiBGcm9tOiBKb25hdGhhbiBCYWtrZXIgPHhjLXJhY2VyMkBsaXZlLmNhPg0KPj4NCj4+
IFRoZSBkcml2ZXIgY2FuIGJlIGNsZWFuZWQgdXAgYnkgdXNpbmcgbWFuYWdlZCByZXNvdXJjZSBo
ZWxwZXJzDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJA
bGl2ZS5jYT4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWou
Y2htaWVsQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvaW5wdXQvbWlzYy9ibWExNTAu
YyB8IDQwICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5wdXQvbWlzYy9ibWExNTAuYyBiL2RyaXZlcnMvaW5wdXQvbWlzYy9i
bWExNTAuYw0KPj4gaW5kZXggMWVmY2ZkZjlmOGE4Li5kMTAxYmIwYTMzZDYgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2lucHV0L21pc2MvYm1hMTUwLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5wdXQv
bWlzYy9ibWExNTAuYw0KPj4gQEAgLTQ3MSw3ICs0NzEsNyBAQCBzdGF0aWMgaW50IGJtYTE1MF9y
ZWdpc3Rlcl9pbnB1dF9kZXZpY2Uoc3RydWN0IGJtYTE1MF9kYXRhICpibWExNTApDQo+PiAgCXN0
cnVjdCBpbnB1dF9kZXYgKmlkZXY7DQo+PiAgCWludCBlcnJvcjsNCj4+ICANCj4+IC0JaWRldiA9
IGlucHV0X2FsbG9jYXRlX2RldmljZSgpOw0KPj4gKwlpZGV2ID0gZGV2bV9pbnB1dF9hbGxvY2F0
ZV9kZXZpY2UoJmJtYTE1MC0+Y2xpZW50LT5kZXYpOw0KPj4gIAlpZiAoIWlkZXYpDQo+PiAgCQly
ZXR1cm4gLUVOT01FTTsNCj4+ICANCj4+IEBAIC00ODIsMTAgKzQ4Miw4IEBAIHN0YXRpYyBpbnQg
Ym1hMTUwX3JlZ2lzdGVyX2lucHV0X2RldmljZShzdHJ1Y3QgYm1hMTUwX2RhdGEgKmJtYTE1MCkN
Cj4+ICAJaW5wdXRfc2V0X2RydmRhdGEoaWRldiwgYm1hMTUwKTsNCj4+ICANCj4+ICAJZXJyb3Ig
PSBpbnB1dF9yZWdpc3Rlcl9kZXZpY2UoaWRldik7DQo+PiAtCWlmIChlcnJvcikgew0KPj4gLQkJ
aW5wdXRfZnJlZV9kZXZpY2UoaWRldik7DQo+PiArCWlmIChlcnJvcikNCj4+ICAJCXJldHVybiBl
cnJvcjsNCj4+IC0JfQ0KPj4gIA0KPj4gIAlibWExNTAtPmlucHV0ID0gaWRldjsNCj4+ICAJcmV0
dXJuIDA7DQo+PiBAQCAtNDk2LDcgKzQ5NCw3IEBAIHN0YXRpYyBpbnQgYm1hMTUwX3JlZ2lzdGVy
X3BvbGxlZF9kZXZpY2Uoc3RydWN0IGJtYTE1MF9kYXRhICpibWExNTApDQo+PiAgCXN0cnVjdCBp
bnB1dF9wb2xsZWRfZGV2ICppcG9sbF9kZXY7DQo+PiAgCWludCBlcnJvcjsNCj4+ICANCj4+IC0J
aXBvbGxfZGV2ID0gaW5wdXRfYWxsb2NhdGVfcG9sbGVkX2RldmljZSgpOw0KPj4gKwlpcG9sbF9k
ZXYgPSBkZXZtX2lucHV0X2FsbG9jYXRlX3BvbGxlZF9kZXZpY2UoJmJtYTE1MC0+Y2xpZW50LT5k
ZXYpOw0KPj4gIAlpZiAoIWlwb2xsX2RldikNCj4+ICAJCXJldHVybiAtRU5PTUVNOw0KPj4gIA0K
Pj4gQEAgLTUxMSwxMCArNTA5LDggQEAgc3RhdGljIGludCBibWExNTBfcmVnaXN0ZXJfcG9sbGVk
X2RldmljZShzdHJ1Y3QgYm1hMTUwX2RhdGEgKmJtYTE1MCkNCj4+ICAJYm1hMTUwX2luaXRfaW5w
dXRfZGV2aWNlKGJtYTE1MCwgaXBvbGxfZGV2LT5pbnB1dCk7DQo+PiAgDQo+PiAgCWVycm9yID0g
aW5wdXRfcmVnaXN0ZXJfcG9sbGVkX2RldmljZShpcG9sbF9kZXYpOw0KPj4gLQlpZiAoZXJyb3Ip
IHsNCj4+IC0JCWlucHV0X2ZyZWVfcG9sbGVkX2RldmljZShpcG9sbF9kZXYpOw0KPj4gKwlpZiAo
ZXJyb3IpDQo+PiAgCQlyZXR1cm4gZXJyb3I7DQo+PiAtCX0NCj4+ICANCj4+ICAJYm1hMTUwLT5p
bnB1dF9wb2xsZWQgPSBpcG9sbF9kZXY7DQo+PiAgCWJtYTE1MC0+aW5wdXQgPSBpcG9sbF9kZXYt
PmlucHV0Ow0KPj4gQEAgLTU0Myw3ICs1MzksOCBAQCBzdGF0aWMgaW50IGJtYTE1MF9wcm9iZShz
dHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KPj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgCX0N
Cj4+ICANCj4+IC0JYm1hMTUwID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGJtYTE1MF9kYXRhKSwg
R0ZQX0tFUk5FTCk7DQo+PiArCWJtYTE1MCA9IGRldm1fa3phbGxvYygmY2xpZW50LT5kZXYsIHNp
emVvZihzdHJ1Y3QgYm1hMTUwX2RhdGEpLA0KPj4gKwkJCSAgICAgIEdGUF9LRVJORUwpOw0KPj4g
IAlpZiAoIWJtYTE1MCkNCj4+ICAJCXJldHVybiAtRU5PTUVNOw0KPj4gIA0KPj4gQEAgLTU1Niw3
ICs1NTMsNyBAQCBzdGF0aWMgaW50IGJtYTE1MF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xp
ZW50LA0KPj4gIAkJCQlkZXZfZXJyKCZjbGllbnQtPmRldiwNCj4+ICAJCQkJCSJJUlEgR1BJTyBj
b25mLiBlcnJvciAlZCwgZXJyb3IgJWRcbiIsDQo+PiAgCQkJCQljbGllbnQtPmlycSwgZXJyb3Ip
Ow0KPj4gLQkJCQlnb3RvIGVycl9mcmVlX21lbTsNCj4+ICsJCQkJcmV0dXJuIGVycm9yOw0KPj4g
IAkJCX0NCj4+ICAJCX0NCj4+ICAJCWNmZyA9ICZwZGF0YS0+Y2ZnOw0KPj4gQEAgLTU2NiwxNCAr
NTYzLDE0IEBAIHN0YXRpYyBpbnQgYm1hMTUwX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQsDQo+PiAgDQo+PiAgCWVycm9yID0gYm1hMTUwX2luaXRpYWxpemUoYm1hMTUwLCBjZmcpOw0K
Pj4gIAlpZiAoZXJyb3IpDQo+PiAtCQlnb3RvIGVycl9mcmVlX21lbTsNCj4+ICsJCXJldHVybiBl
cnJvcjsNCj4+ICANCj4+ICAJaWYgKGNsaWVudC0+aXJxID4gMCkgew0KPj4gIAkJZXJyb3IgPSBi
bWExNTBfcmVnaXN0ZXJfaW5wdXRfZGV2aWNlKGJtYTE1MCk7DQo+PiAgCQlpZiAoZXJyb3IpDQo+
PiAtCQkJZ290byBlcnJfZnJlZV9tZW07DQo+PiArCQkJcmV0dXJuIGVycm9yOw0KPj4gIA0KPj4g
LQkJZXJyb3IgPSByZXF1ZXN0X3RocmVhZGVkX2lycShjbGllbnQtPmlycSwNCj4+ICsJCWVycm9y
ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycSgmY2xpZW50LT5kZXYsIGNsaWVudC0+aXJxLA0K
Pj4gIAkJCQkJTlVMTCwgYm1hMTUwX2lycV90aHJlYWQsDQo+PiAgCQkJCQlJUlFGX1RSSUdHRVJf
UklTSU5HIHwgSVJRRl9PTkVTSE9ULA0KPj4gIAkJCQkJQk1BMTUwX0RSSVZFUiwgYm1hMTUwKTsN
Cj4+IEBAIC01ODIsMTIgKzU3OSwxMiBAQCBzdGF0aWMgaW50IGJtYTE1MF9wcm9iZShzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50LA0KPj4gIAkJCQkiaXJxIHJlcXVlc3QgZmFpbGVkICVkLCBlcnJv
ciAlZFxuIiwNCj4+ICAJCQkJY2xpZW50LT5pcnEsIGVycm9yKTsNCj4+ICAJCQlpbnB1dF91bnJl
Z2lzdGVyX2RldmljZShibWExNTAtPmlucHV0KTsNCj4gDQo+IE5vIG5lZWQgdG8gdW5yZWdpc3Rl
ciBtYW51YWxseSBpZiB5b3UgYXJlIHVzaW5nIGRldm0uDQpPaywgZ290IGl0LCB3aWxsIGZpeC4g
IEkgc2VlbWVkIHRvIGRvIHRoaXMgYSBsb3QgOikNCj4gDQo+PiAtCQkJZ290byBlcnJfZnJlZV9t
ZW07DQo+PiArCQkJcmV0dXJuIGVycm9yOw0KPj4gIAkJfQ0KPj4gIAl9IGVsc2Ugew0KPj4gIAkJ
ZXJyb3IgPSBibWExNTBfcmVnaXN0ZXJfcG9sbGVkX2RldmljZShibWExNTApOw0KPj4gIAkJaWYg
KGVycm9yKQ0KPj4gLQkJCWdvdG8gZXJyX2ZyZWVfbWVtOw0KPj4gKwkJCXJldHVybiBlcnJvcjsN
Cj4+ICAJfQ0KPj4gIA0KPj4gIAlpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBibWExNTApOw0K
Pj4gQEAgLTU5NSwxMCArNTkyLDYgQEAgc3RhdGljIGludCBibWExNTBfcHJvYmUoc3RydWN0IGky
Y19jbGllbnQgKmNsaWVudCwNCj4+ICAJcG1fcnVudGltZV9lbmFibGUoJmNsaWVudC0+ZGV2KTsN
Cj4+ICANCj4+ICAJcmV0dXJuIDA7DQo+PiAtDQo+PiAtZXJyX2ZyZWVfbWVtOg0KPj4gLQlrZnJl
ZShibWExNTApOw0KPj4gLQlyZXR1cm4gZXJyb3I7DQo+PiAgfQ0KPj4gIA0KPj4gIHN0YXRpYyBp
bnQgYm1hMTUwX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KPj4gQEAgLTYwNywx
NSArNjAwLDEwIEBAIHN0YXRpYyBpbnQgYm1hMTUwX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50KQ0KPj4gIA0KPj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoJmNsaWVudC0+ZGV2KTsNCj4+
ICANCj4+IC0JaWYgKGNsaWVudC0+aXJxID4gMCkgew0KPj4gLQkJZnJlZV9pcnEoY2xpZW50LT5p
cnEsIGJtYTE1MCk7DQo+PiArCWlmIChjbGllbnQtPmlycSA+IDApDQo+PiAgCQlpbnB1dF91bnJl
Z2lzdGVyX2RldmljZShibWExNTAtPmlucHV0KTsNCj4gDQo+IEhlcmUgYXMgd2VsbC4NCj4gDQo+
PiAtCX0gZWxzZSB7DQo+PiArCWVsc2UNCj4+ICAJCWlucHV0X3VucmVnaXN0ZXJfcG9sbGVkX2Rl
dmljZShibWExNTAtPmlucHV0X3BvbGxlZCk7DQo+IA0KPiBBbmQgaGVyZS4NCj4gDQo+PiAtCQlp
bnB1dF9mcmVlX3BvbGxlZF9kZXZpY2UoYm1hMTUwLT5pbnB1dF9wb2xsZWQpOw0KPj4gLQl9DQo+
PiAtDQo+PiAtCWtmcmVlKGJtYTE1MCk7DQo+PiAgDQo+PiAgCXJldHVybiAwOw0KPj4gIH0NCj4+
IC0tIA0KPj4gMi4xNy4xDQo+Pg0KPiANCj4gVGhhbmtzLg0KPiANClRoYW5rcywNCkpvbmF0aGFu
DQo=
