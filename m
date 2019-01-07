Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82937C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453A420859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pchZpf5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfAGJDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:03:00 -0500
Received: from mail-eopbgr50126.outbound.protection.outlook.com ([40.107.5.126]:19391
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfAGJC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su1frGONUR8gzV/qOw3MzT18+nzkZWYd09UEbnYzOOc=;
 b=pchZpf5Xv1qmhiIjy1aLnz+MKF3hsh75KRsNfhT1tR6C6PiUcnnjHdGt8sz4enQXSACU0yH6ByaHw0V6WRiXcKTG7TrNlGmpGy+NLIQL4hU+ku7hICRuYcxl1Z1IHtaqQkqcRyifMEjOVdnTcJgrBB/q9/oFvsCi7fC+Zry5YE0=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB5143.eurprd02.prod.outlook.com (20.178.89.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 09:02:53 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 09:02:53 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd
 line, option
Thread-Topic: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd
 line, option
Thread-Index: AQHUpmKp4V4EI6YXU0qJtxpfCA1wmaWjfJgAgAAFVACAAADWAA==
Date:   Mon, 7 Jan 2019 09:02:53 +0000
Message-ID: <662db203-ae18-4a11-7b10-3d7d480f6f37@axentia.se>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
 <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
 <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
 <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
In-Reply-To: <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0202CA0035.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::21) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB5143;6:GcvnqbZNPBYBifKgdHrc//RA7HCs5CgHhIFtwqNLHVMcc93XGEnunPUeFo486x+YUwCwCSyYOFsE9Wyq189BYG2Rw60xhmzqxAjhs+nZJBJ/ta2BBFuy0LBj64+u/orBF5NLoawsg6uDavlwGR74AofKlmnM97KahKjhq4pN1Sdb65Dac6cu6HeswbYrQjjrJW5dBze7XpKrpNgZmuMI387gv9NW+Q75DNlG9jLUxD1X1wh5Vk8dJH5DXNx6n/JY6WP0TBvvlhTcJcYu6dvXFwXTqTY6zJJ3DHAznEG+FCHCJ1R4QKC86prV8VzqY1D1bg1rghI6ovAu7k+v4IbviL8CwHqLztdf2+wFVs15jWGUigQ9Kl9A+w4WJ53ZXL98ZyOP7OAisKUtL0hQJy0Fk7fXPaCwNSpYaX8teOIscppGm9wx4waYbZMuwD+31ALrTl584+nl9uXChMgMvNU5XA==;5:IDh74HJs5ZXQ7igWUYvh2MEx9C7LtohAFXUoeLwqfjK1ice0HyDNq0acOqfzREj18WK6XQoRaSeXSgTPbd3zU6snaOT6wHvRulxZ5nk/HqGQvyysItfLv7Ai9loTvLRVWHb/4PTzEC2amHIwDXBD51JTCcTI1zbelT+2SSLVTG9iHKjt8IG2hp6BVJ+XCvMorhzXgXoduOwtFVEmLlB0tg==;7:q/iLMB1lXPkatU0Da/c3p/kUNk5CCLT37U4/PrB+eGuy/Pv27ZL9vZ1LxPmoIQjmDOWD3IfPN3Ywynml/SxawOQw2uhVVP9dM/eBEaNG8N3tKIroysnyJDpekty9UyL7RrDLlyUMd8Wd8PvdYxhYXw==
x-ms-office365-filtering-correlation-id: be512a2b-3fe2-49a2-6a35-08d6747ee82b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB5143;
x-ms-traffictypediagnostic: AM6PR02MB5143:
x-microsoft-antispam-prvs: <AM6PR02MB51435F1AE84F07346728D541BC890@AM6PR02MB5143.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB5143;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB5143;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39830400003)(136003)(189003)(199004)(36756003)(486006)(31686004)(316002)(54906003)(58126008)(229853002)(93886005)(6916009)(256004)(2616005)(476003)(186003)(68736007)(105586002)(102836004)(26005)(6436002)(6486002)(106356001)(53546011)(6506007)(76176011)(99286004)(52116002)(386003)(66066001)(71200400001)(86362001)(74482002)(25786009)(4326008)(11346002)(446003)(71190400001)(65826007)(5660300001)(65956001)(65806001)(97736004)(305945005)(7736002)(81166006)(81156014)(8676002)(8936002)(31696002)(2906002)(6116002)(64126003)(3846002)(14454004)(508600001)(53936002)(6246003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB5143;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dlm5xbRv0rnEO6J21XrFIUOLvwR8YEeyb1hNcRtCy5/7e4yHFwbi7FRFzctwue+sGPoolCsL5TYbFmoIzhqiv+shcpy75W5pHVJA2lUb5vlULoNt7yHKNnwk0JWD1K8YV/lvNwTdSd663QhpABAHQuR0dBJ9QeNk/uiC/lvTcv+GWgiPmrIuoP5DOOQDl2QWN+2xDSpsipJAAp+zQ5WiE+ufV1wx7veBTjdrWObJaxh2/gXE1EijLt9xwh7+5AOyXOEeDSQAPlvsSJx3R2UTm3KvlC0M2yVxtSYO6FlXCnsSPLW5S4SjsBhgCjNnLiAy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F461B18449524FA9B3725C8CC99FB0@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: be512a2b-3fe2-49a2-6a35-08d6747ee82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 09:02:52.4471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wNyAwOTo1OSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IE9uIDIwMTktMDEtMDcg
MDk6NDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4+IEhpIFBldGVyLA0KPj4NCj4+IE9u
IE1vbiwgSmFuIDcsIDIwMTkgYXQgOToyNiBBTSBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNl
PiB3cm90ZToNCj4+PiBPbiAyMDE5LTAxLTA2IDEwOjMzLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+Pj4+IE9uIE1vbiwgTm92IDI2LCAyMDE4IGF0IDEwOjU5IFBNIFBldGVyIFJvc2luIDxw
ZWRhQGF4ZW50aWEuc2U+IHdyb3RlOg0KPj4+Pj4gSWYgdGhlcmUgYXJlIGV4dHJhIGxvZ29zIChD
T05GSUdfRkJfTE9HT19FWFRSQSkgdGhlIGhlaWdodHMgb2YgdGhlc2UNCj4+Pj4+IGV4dHJhIGxv
Z29zIGFyZSBub3QgY29uc2lkZXJlZCB3aGVuIGNlbnRlcmluZyB0aGUgZmlyc3QgbG9nbyB2ZXJ0
aWNhbGx5Lg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4
ZW50aWEuc2U+DQo+Pj4+DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2xvZ28vS2NvbmZpZw0K
Pj4+Pj4gKysrIGIvZHJpdmVycy92aWRlby9sb2dvL0tjb25maWcNCj4+Pj4+IEBAIC0xMCw2ICsx
MCwxNSBAQCBtZW51Y29uZmlnIExPR08NCj4+Pj4+DQo+Pj4+PiAgaWYgTE9HTw0KPj4+Pj4NCj4+
Pj4+ICtjb25maWcgRkJfTE9HT19DRU5URVINCj4+Pj4+ICsgICAgICAgYm9vbCAiQ2VudGVyIHRo
ZSBsb2dvIg0KPj4+Pj4gKyAgICAgICBkZXBlbmRzIG9uIEZCPXkNCj4+Pj4+ICsgICAgICAgaGVs
cA0KPj4+Pj4gKyAgICAgICAgIFdoZW4gdGhpcyBvcHRpb24gaXMgc2VsZWN0ZWQsIHRoZSBib290
dXAgbG9nbyBpcyBjZW50ZXJlZCBib3RoDQo+Pj4+PiArICAgICAgICAgaG9yaXpvbnRhbGx5IGFu
ZCB2ZXJ0aWNhbGx5LiBJZiBtb3JlIHRoYW4gb25lIGxvZ28gaXMgZGlzcGxheWVkDQo+Pj4+PiAr
ICAgICAgICAgZHVlIHRvIG11bHRpcGxlIENQVXMsIHRoZSBjb2xsZWN0ZWQgbGluZSBvZiBsb2dv
cyBpcyBjZW50ZXJlZA0KPj4+Pj4gKyAgICAgICAgIGFzIGEgd2hvbGUuDQo+Pj4+PiArDQo+Pj4+
DQo+Pj4+IElzbid0IGEga2VybmVsIGNvbW1hbmQgbGluZSBvcHRpb24gbW9yZSBzdWl0YWJsZSB0
byBjb25maWd1cmUgdGhlIHBvc2l0aW9uDQo+Pj4+IG9mIHRoZSBsb2dvPw0KPj4+DQo+Pj4gVGhh
dCBkaWRuJ3Qgb2NjdXIgdG8gbWUgcHJldmlvdXNseSwgYnV0IGl0IGRvZXMgbWFrZSBzZW5zZSBu
b3cgdGhhdCB5b3UNCj4+PiBtZW50aW9uIGl0LiBUaGlzIGlzIG9uIHRvcCBvZiB2NS4wLXJjMSwg
YW5kIGlmIGFwcGxpZWQgYmVmb3JlIHY1LjAgd2UNCj4+PiBjYW4gYXZvaWQgcG9zc2libGUgcmVn
cmVzc2lvbnMgZm9yIGZvbGtzIHdobyBtaWdodCBzdGFydCB0byByZWx5IG9uDQo+Pj4gQ09ORklH
X0ZCX0xPR09fQ0VOVEVSIGlmIHY1LjAgaXMgcmVsZWFzZWQgdy9vIHRoaXMuDQo+Pj4NCj4+PiBD
aGVlcnMsDQo+Pj4gUGV0ZXINCj4+Pg0KPj4+IEZyb20gZGU3MzUzYWI1MTliYTliNWM5ZWEzZjYy
ZDYwN2JiOGU5NGI2ODdjYyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4+PiBGcm9tOiBQZXRl
ciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4+IENjOiBCYXJ0bG9taWVqIFpvbG5pZXJraWV3
aWN6IDxiLnpvbG5pZXJraWVAc2Ftc3VuZy5jb20+DQo+Pj4gQ2M6IEpvbmF0aGFuIENvcmJldCA8
Y29yYmV0QGx3bi5uZXQ+DQo+Pj4gQ2M6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+
Pj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+PiBDYzogbGludXgtZmJk
ZXZAdmdlci5rZXJuZWwub3JnDQo+Pj4gQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4+
PiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4+IERhdGU6IE1vbiwgNyBKYW4g
MjAxOSAwODozNToyNiArMDEwMA0KPj4+IFN1YmplY3Q6IFtQQVRDSF0gZmJkZXY6IGZibWVtOiBj
b252ZXJ0IENPTkZJR19GQl9MT0dPX0NFTlRFUiBpbnRvIGEgY21kIGxpbmUNCj4+PiAgb3B0aW9u
DQo+Pj4NCj4+PiBBIGNvbW1hbmQgbGluZSBvcHRpb24gaXMgbXVjaCBtb3JlIGZsZXhpYmxlIHRo
YW4gYSBjb25maWcgb3B0aW9uIGFuZA0KPj4+IHRoZSBzdXBwb3J0aW5nIGNvZGUgaXMgc21hbGwu
IEdldHMgcmlkIG9mICNpZmRlZnMgaW4gdGhlIGNvZGUgdG9vLi4uDQo+Pj4NCj4+PiBTdWdnZXN0
ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+DQo+PiBUaGFua3Mg
Zm9yIHlvdXIgcGF0Y2ghDQo+Pg0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZmIvZmJjb24udHh0
DQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9mYi9mYmNvbi50eHQNCj4+PiBAQCAtMTYzLDYgKzE2
MywxMiBAQCBDLiBCb290IG9wdGlvbnMNCj4+PiAgICAgICAgIGJlIHByZXNlcnZlZCB1bnRpbCB0
aGVyZSBhY3R1YWxseSBpcyBzb21lIHRleHQgaXMgb3V0cHV0IHRvIHRoZSBjb25zb2xlLg0KPj4+
ICAgICAgICAgVGhpcyBvcHRpb24gY2F1c2VzIGZiY29uIHRvIGJpbmQgaW1tZWRpYXRlbHkgdG8g
dGhlIGZiZGV2IGRldmljZS4NCj4+Pg0KPj4+ICs3LiBmYmNvbj1jZW50ZXItbG9nbw0KPj4+ICsN
Cj4+PiArICAgICAgIFdoZW4gdGhpcyBvcHRpb24gaXMgc2VsZWN0ZWQsIHRoZSBib290dXAgbG9n
byBpcyBjZW50ZXJlZCBib3RoDQo+Pj4gKyAgICAgICBob3Jpem9udGFsbHkgYW5kIHZlcnRpY2Fs
bHkuIElmIG1vcmUgdGhhbiBvbmUgbG9nbyBpcyBkaXNwbGF5ZWQgZHVlIHRvDQo+Pj4gKyAgICAg
ICBtdWx0aXBsZSBDUFVzLCB0aGUgY29sbGVjdGVkIGxpbmUgb2YgbG9nb3MgaXMgY2VudGVyZWQg
YXMgYSB3aG9sZS4NCj4+PiArDQo+Pg0KPj4gV2hhdCBhYm91dCBtYWtpbmcgdGhpcyBtb3JlIGdl
bmVyaWMsIHRoYW4gYW4gb3B0aW9uIHNwZWNpZmljIGZvciBjZW50ZXJpbmc/DQo+PiBFbHNlIHBl
b3BsZSB3YW50IGZiY29uPWxlZnQtbG9nbyBvciBmYmNvbj1yaWdodC1sb2dvIHNvb24/DQo+Pg0K
Pj4gICAgIGZiY29uPWxvZ28tcG9zOjxwb3M+DQo+Pg0KPj4gV2l0aCA8cG9zPiBiZWluZyAiY2Vu
dGVyIiwgImxlZnQiLCAidG9wIiwgInJpZ2h0IiwgImJvdHRvbSIsIGFuZCBjb21iaW5hdGlvbnMN
Cj4+IGxpa2UgInRvcCxjZW50ZXIiPyBPciBpcyB0aGF0IGNvbXBsaWNhdGluZyBzdHVmZiB0b28g
bXVjaD8NCj4gDQo+IEknbSBub3QgdG9vIGtlZW4gb24gaW1wbGVtZW50aW5nIGFsbCB0aGF0IHdo
ZW4gSSBoYXZlIHplcm8gdXNlIGZvciBpdC4gSSBjYW4NCj4gaG93ZXZlciByZW5hbWUgdGhlIHRy
aWdnZXIgZm9yIHRoZSBleGlzdGluZyBmYl9jZW50ZXJfbG9nbyBib29sIHRvDQo+IA0KPiAJZmJj
b249bG9nby1wb3M6Y2VudGVyDQo+IA0KPiBhbmQgYWRkIGEgY2hlY2sgZm9yICJ0b3AsbGVmdCIg
dG8gcmVzZXQgdGhlIGJvb2wgdG8gZmFsc2UuIFRoZW4gdGhlIG90aGVyDQo+IHZhcmlhbnRzIGNh
biBiZSBhZGRlZCBsYXRlciBieSB3aG9tZXZlciBhbmQgd2hlbiBuZWVkZWQuDQo+IA0KPiBJcyB0
aGF0IGdvb2QgZW5vdWdoPw0KDQpPdWNoLCBJIGp1c3QgcmVhbGl6ZWQgdGhhdCB1c2luZyBhIGNv
bW1hIGlzIGEgbm8tZ28sIGFzIHRoYXQgaXMgYWxyZWFkeQ0Kc2VwYXJhdGluZyBmYmNvbiBzdWJv
cHRpb25zLCBzbyBJIHN1Z2dlc3QgdG9wLWxlZnQgaW5zdGVhZC4NCg0KQ2hlZXJzLA0KUGV0ZXIN
Cg==
