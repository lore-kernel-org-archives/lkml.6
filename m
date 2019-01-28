Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82BCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9E821738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfA1N2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:28:45 -0500
Received: from mail-oln040092069094.outbound.protection.outlook.com ([40.92.69.94]:18184
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfA1N2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:28:44 -0500
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (10.152.8.59) by AM5EUR02HT132.eop-EUR02.prod.protection.outlook.com
 (10.152.9.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Mon, 28 Jan
 2019 13:28:40 +0000
Received: from VI1PR07MB4864.eurprd07.prod.outlook.com (10.152.8.52) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 28 Jan 2019 13:28:40 +0000
Received: from VI1PR07MB4864.eurprd07.prod.outlook.com
 ([fe80::ddcc:fc12:2074:191f]) by VI1PR07MB4864.eurprd07.prod.outlook.com
 ([fe80::ddcc:fc12:2074:191f%5]) with mapi id 15.20.1580.014; Mon, 28 Jan 2019
 13:28:40 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Sebor <msebor@gmail.com>
Subject: Re: [RFC][PATCH] Update -Wattribute-alias for gcc9
Thread-Topic: [RFC][PATCH] Update -Wattribute-alias for gcc9
Thread-Index: AQHUtJzuSvpMiiJM/0mOmnepw49bKqW/3AMAgAAMrQCABMjWAA==
Date:   Mon, 28 Jan 2019 13:28:40 +0000
Message-ID: <VI1PR07MB486420A106A8BC85BEE9FB2AE4960@VI1PR07MB4864.eurprd07.prod.outlook.com>
References: <20190125104353.2791-1-labbott@redhat.com>
 <CAK8P3a0xnc7RNbGhG7-hj+ay2keR7dh7MmDiUNKxfewsnatsgA@mail.gmail.com>
 <CANiq72=nMYcohMk29fzs3bMut1PXwfqYLZdbRh_AeTN-Z4FpxQ@mail.gmail.com>
 <AM0PR07MB387404F71D25553702966E27E49B0@AM0PR07MB3874.eurprd07.prod.outlook.com>
In-Reply-To: <AM0PR07MB387404F71D25553702966E27E49B0@AM0PR07MB3874.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0078.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::19) To VI1PR07MB4864.eurprd07.prod.outlook.com
 (2603:10a6:803:8e::30)
x-incomingtopheadermarker: OriginalChecksum:9F5E484F44EF39F669B3F580ED4A1C4B01F1531C5F78E4D18293EC730FFFD8A0;UpperCasedChecksum:3C8DF2A8E1645C5756132DFDFF27E8ED12C2FCF9FABEADF3452A517BCAFF421D;SizeAsReceived:9051;Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qUPZ2jdvowQflERYulxsHhH79GNbq4eN]
x-microsoft-original-message-id: <9d08a39a-12bb-8027-2872-75f3f137e156@hotmail.de>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5EUR02HT132;6:fdDwtloT0L0MiC2YL9XPBHu/1BGfyfL/FRJkL7gDBIWESOrAS4I+WCHsDj0CbzV2Z2rNepQCWK2hQo2vUm+ZghNYhRyUlP1MtLdtxeo4VMYXaugkKPB0mPAl9B9nA/X73gBoD/oiinVke5gKIUFDKo+Gu/fyTeY+gm9ueiJWOQVTOb7HdnEvS26g6MhwJ9Pskuy4MlreEY6bWxFxwUoFjYfxmhiwTz8+IsXwOd8hWHjsNCXbWXsKl8UqeKUnoADAARALGqfermgkSEoT7fjQmtrHaYkaiab5oGZ6yFYlCx+xEH+q7b2lykgz63hWW01rQYchEFwBfTy1b38gybYtgPQL5co2yHp3i1KHUzF0fabZ2pQWP1EhCeyuC4RJghCCdbYaU4grYlUPS0z6j2PXFiNkdYUNd9ZUCHXFiHUXKaRwoN6xlSh8mdUYldvFJGPv7dDWEpYzUO+enlxnKEYX8A==;5:glxKLJbrXAju5IOpnnLMeslpkXbq9iLpDXFEQA9tLkqEb9yEqSaLSQ0BEESCRJBjWumx4pSVmHnhuqoTRvFhccKT7fnkzlObpwBR6ZU8Q1jOan0tKWaNHoRTfGkibjxiHLsuAQmQucgTmlfazt64DsrZM8JdO+sYwCgITURnrpdxWNC/hR5Zd10PzJ/he7pG8OkpFz8awPcD2QAKGDoQOw==;7:Ht4umBSe0EoMbP9wHRcBFW3H0bJtv/3bj3NShtf0r68NYdDchKH2LUcnKN43jIJ2JOcdhKVv/H7I8McVhgELXKrhNpWptboI8aY914+DdMxZGpK5ATnsHv8M9pBYeVNvwt56Ev9pmBHMP6t0l7fmKQ==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT132;
x-ms-traffictypediagnostic: AM5EUR02HT132:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:AM5EUR02HT132;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR02HT132;
x-microsoft-antispam-message-info: gaDBiBFwe8STe9gRX86vU+B3ejEdbOZtWV+fMlWFhbphNCiuzQFkci9QJLxUMMQ/
Content-Type: text/plain; charset="utf-8"
Content-ID: <923AE0C9389BF743B4682C5D43B54FB8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c4b66b-e82c-4f9a-7578-08d68524842f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 13:28:39.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNS8xOSAxOjI0IFBNLCBCZXJuZCBFZGxpbmdlciB3cm90ZToNCj4gT24gMS8yNS8xOSAx
MjozOSBQTSwgTWlndWVsIE9qZWRhIHdyb3RlOg0KPj4gT24gRnJpLCBKYW4gMjUsIDIwMTkgYXQg
MTE6NTggQU0gQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6DQo+Pj4NCj4+PiBP
biBGcmksIEphbiAyNSwgMjAxOSBhdCAxMTo0MyBBTSBMYXVyYSBBYmJvdHQgPGxhYmJvdHRAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IENvbW1pdCBiZWUyMDAzMTc3MmEgKCJkaXNhYmxl
IC1XYXR0cmlidXRlLWFsaWFzIHdhcm5pbmcgZm9yDQo+Pj4+IFNZU0NBTExfREVGSU5FeCgpIikg
ZGlzYWJsZWQgLVdhdHRyaWJ1dGUtYWxpYXMgd2l0aCBnY2M4Lg0KPj4+PiBnY2M5IGNoYW5nZWQg
dGhlIGZvcm1hdCBvZiAtV2F0dHJpYnV0ZS1hbGlhcyB0byB0YWtlIGEgcGFyYW1ldGVyLg0KPj4+
PiBUaGlzIGRvZXNuJ3QgcXVpdGUgbWF0Y2ggd2l0aCB0aGUgZXhpc3RpbmcgZGlzYWJsaW5nIG1l
Y2hhbmlzbQ0KPj4+PiBzbyB1cGRhdGUgZm9yIGdjYzkgdG8gbWF0Y2ggd2l0aCB0aGUgZGVmYXVs
dCAoLVdhdHRyaWJ1dGUtYWxpYXM9MSkuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IExhdXJh
IEFiYm90dCA8bGFiYm90dEByZWRoYXQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gVGhpcyBpcyBSRkMg
YmVjYXVzZSBpdCBmZWVscyB1Z2x5LiBJIHdlbnQgYWhlYWQgYW5kIGRpZCB0aGUgb2J2aW91cyBm
aXh1cA0KPj4+PiBidXQgaXQncyB3b3J0aCBkaXNjdXNzaW5nIGlmIHdlJ3JlIGdvaW5nIHRvIGVu
ZCB1cCB3aXRoIGFuIGV4cGxvc2lvbiBvcg0KPj4+PiBpZiB0aGVyZSdzIGEgYmV0dGVyIHdheSB0
byBoYW5kbGUgdGhpcyBpbiBvbmUgbWFjcm8uDQo+Pj4NCj4+PiBCZXJuZCBFZGxpbmdlciBoYXMg
c2VudCBhIHBhdGNoIHRvIGdjYyBmb3IgdGhpczoNCj4+PiBodHRwczovL2djYy5nbnUub3JnL21s
L2djYy1wYXRjaGVzLzIwMTktMDEvbXNnMDExMjAuaHRtbA0KPj4+DQo+Pj4gYW5kIE1pZ3VlbCBP
amVkYSBzYWlkIGhlIHdhbnRlZCB0byBzZW5kIGEgcGF0Y2ggZm9yIGl0IHRvIHRoZQ0KPj4+IGtl
cm5lbCBhcyB3ZWxsLCBub3Qgc3VyZSBpZiBoZSB3YW50ZWQgdG8gdGFrZSBhIGRpZmZlcmVudA0K
Pj4+IGFwcHJvYWNoIHRoZXJlLCBzbyBhZGRpbmcgYm90aCB0byBDYyBoZXJlLg0KPj4NCj4+IFRo
YW5rcyBBcm5kIChJIHdhcyB3b3JraW5nIHdpdGggTWFydGluIG9uIHRoZSBleHBhbmRlZA0KPj4g
LVdtaXNzaW5nLWF0dHJpYnV0ZSB3YXJuaW5ncywgbm90IG9uIHRoaXMsIGJ1dCB0aGFua3MgbmV2
ZXJ0aGVsZXNzIDopLg0KPj4NCj4+IE1hcnRpbi9CZXJuZDogZnJvbSB0aGUgR0NDIG1haWxpbmcg
bGlzdCBJIGFtIG5vdCBzdXJlIGlmIHdlIHNob3VsZA0KPj4gZXhwZWN0IHRoZSBvbGQgYmVoYXZp
b3IgdG8gYmUgbWFpbnRhaW5lZCBvciBub3QuDQo+Pg0KPiANCj4gSSBiZWxpZXZlIGl0IGlzIG5v
dCBpbnRlbnRpb25hbCB0byBicmVhayB0aGUgb2xkIHN5bnRheCBvZiB0aGUNCj4gcHJhZ21hLiAg
VGhlcmUgd2lsbCBiZSBuZXcgLVdhdHRyaWJ1dGUtYWxpYXM9MSBhbmQgLVdhdHRyaWJ1dGUtYWxp
YXM9Mg0KPiBhbmQgLVdhdHRyaWJ1dGUtYWxpYXMgaXMgZWFzeSB0byByZXRhaW4gYXMgYW4gYWxp
YXMgZm9yIC1XYXR0cmlidXRlLWFsaWFzPTEuDQo+IFRoYXQgaXMgd2hhdCBteSBwYXRjaCB3aWxs
IGRvLg0KPiANCg0KT2theSwgSSBjb21taXR0ZWQgdGhlIC1XYXR0cmlidXRlLWFsaWFzIHBhdGNo
IHRvIGdjYyB0cnVuaywgbm93DQphcyBodHRwczovL2djYy5nbnUub3JnL3ZpZXdjdnMvZ2NjP3Zp
ZXc9cmV2aXNpb24mcmV2aXNpb249MjY4MzM2IC4NClNvIHRoZXJlIHdpbGwgYmUgbm8gbmVlZCBm
b3IgYSB3b3JrYXJvdW5kIG9uIHlvdXIgc2lkZS4NCg0KQWxzbyBmaXhlZCBhIGZldyBmYWxzZSBw
b3NpdGl2ZSAtV2FkZHJlc3Mtb2YtcGFja2VkLW1lbWJlciB3YXJuaW5ncyB3aXRoDQpodHRwczov
L2djYy5nbnUub3JnL3ZpZXdjdnMvZ2NjP3ZpZXc9cmV2aXNpb24mcmV2aXNpb249MjY4MTE4IGFu
ZA0KaHR0cHM6Ly9nY2MuZ251Lm9yZy92aWV3Y3ZzL2djYz92aWV3PXJldmlzaW9uJnJldmlzaW9u
PTI2ODMzNyAuDQoNCkhvd2V2ZXIgdGhlcmUgcmVtYWluIGEgbG90IG9mIHdhcm5pbmdzIGZyb20g
LVdhZGRyZXNzLW9mLXBhY2tlZC1tZW1iZXIsDQp0aGF0IGxvb2sgbW9yZSBvciBsZXNzIHZhbGlk
LCBoYXMgYW55Ym9keSBhbiBpZGVhIGhvdyB0byBoYW5kbGUNCnRoZXNlPw0KDQoNCkJlcm5kLg0K
