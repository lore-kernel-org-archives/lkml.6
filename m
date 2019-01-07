Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DE7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752F020859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="C9+Grlta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfAGJAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:00:00 -0500
Received: from mail-eopbgr20139.outbound.protection.outlook.com ([40.107.2.139]:18303
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbfAGJAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvVZNC0g/v58ZYkB0/1ESMYX4bJ3KVczDEbdp9Qi494=;
 b=C9+GrltaX8wMz8Qnw3q3EhkN9u0UZOudkLqjgbRXS5+DpnD4pfhB0pSHO1t1O0UO97Rfa+LBq9LGEJ2iQH4I2Wtv7TekcnFLd8I7xPbT7e+WrqMn5t7nXhALkUTUYOiQkbACtuGZdyRYo+CBWZu3vWriv53lBNrI0NveNnJzKOc=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB5237.eurprd02.prod.outlook.com (20.178.90.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 08:59:53 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 08:59:53 +0000
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
Thread-Index: AQHUpmKp4V4EI6YXU0qJtxpfCA1wmaWjfJgAgAAFVAA=
Date:   Mon, 7 Jan 2019 08:59:53 +0000
Message-ID: <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
 <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
 <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB5237;6:N9t/7rr2jbJUfjI4ixZ0DXQGu4RNjC5va3qGkGtpojEEuLuo19UGK8qMlrT+vTlfVqN92YpcmG1xhKKgbzY8GcARnB7mnOd/WoGieIfpyxxFzM3oAUlMN2K/cRyTT5Aox4+dbWbL3VvDQM7HifayqGNRYA3ae7UAGhUEaYwljE0wkeVODRA9M+mRTjU//TXbTC7DUgvDWt/+cFpRcX15Goacgj5Ciq3kTke7MG2bzVu7m2RbEmD698uiWha6rkMyZxiuYFiZpWWLvdhQgUT0wuCIu1ggQkPCC2XKGd2AlM6RnWcDIfPhdU9u34MJrS1QGgRnxXZ8DHGqhdMF5+jjcXD1trkx3Gagtjv2ab/9V598U8oR9QH/f3QHARdoj4+ZS5oxrVh+WgqBjwFKgme4XR3PitWzt2Ejzcr2lOg1uX0Q+bKQlEmdg+U43IzVYrAas0+J02wZWUv+3+HAvDsrCg==;5:83By/JrRWzi4rsh4v3p/BTrWFkD/VCtBOCn9i4rBqbfn8O9p7h6Ils0QT23fS2SAQEl/9vcbeLEdzLUy0AxlPKiUDRUshXIFcuaIuf3vU82c56oiIh9ze+m76gEKAI1AHYSTt/HxzdkB2DFUl4jKUD2xxdnQgU4iRXKyVa/abERzhpDekn2kvvVeXkslEMb1voJT/vAZ4Ac4O0bvBBDHyA==;7:+tqCY45gSlzd/UC9nsUBN0+G0VOuLSO2ar/3k3tlRVJFBNBhsB/Fo4Uk1UMgJuidoo0V9uMz2qgn6MXPdwMg8cCfKWVPRxzSwIHSF2cg0GMQCiiZOk9BC2QeAR/nmXHxaxT0Dz+OrMW0OJcYwSB+Ow==
x-ms-office365-filtering-correlation-id: d61e1c7a-fdd0-4ca5-e8a5-08d6747e7cd0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB5237;
x-ms-traffictypediagnostic: AM6PR02MB5237:
x-microsoft-antispam-prvs: <AM6PR02MB5237549635176E808E88D321BC890@AM6PR02MB5237.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB5237;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB5237;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39830400003)(396003)(366004)(346002)(199004)(189003)(186003)(26005)(2906002)(305945005)(97736004)(476003)(7736002)(6512007)(52116002)(6246003)(99286004)(11346002)(2616005)(86362001)(102836004)(31696002)(3846002)(36756003)(446003)(53936002)(6116002)(229853002)(6436002)(6486002)(8676002)(81166006)(81156014)(486006)(8936002)(4326008)(25786009)(68736007)(14454004)(256004)(71190400001)(6916009)(105586002)(5660300001)(65826007)(106356001)(71200400001)(64126003)(508600001)(316002)(53546011)(54906003)(6506007)(31686004)(65956001)(74482002)(66066001)(58126008)(386003)(93886005)(65806001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB5237;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2YjQW9yl9/lttdAS5q3ax7YSvu3pmpNV3/OwawNk0tbBPrqcnFHxQA1DLoZwMX+whTL9pYLCjX9DlroQHMNaV16iSxqOXQyOpBNqEtUYZmlMHmxkSRbjyDryWmjo7FhJoepSGFI2sGzd2kS+3XaukmNS+/wdgvBQjD2DwxDRbcQaN/WjMMBLKtUwCxJBfquivmWjI4mMjRGG3FvJvKJbI1fXZ/eWw8Lb6HspA+F695KpI0j8sYZRyHiTfdPVcK4EiGKUGzkLVqgOUaxn+3/LDzIJIgneiTES6puQ7AwjMkscK6mZ+MGnG417YsCtJS0j
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CD5860E906BA24EA7A27AF906A20533@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d61e1c7a-fdd0-4ca5-e8a5-08d6747e7cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 08:59:52.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wNyAwOTo0MCwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBQZXRl
ciwNCj4gDQo+IE9uIE1vbiwgSmFuIDcsIDIwMTkgYXQgOToyNiBBTSBQZXRlciBSb3NpbiA8cGVk
YUBheGVudGlhLnNlPiB3cm90ZToNCj4+IE9uIDIwMTktMDEtMDYgMTA6MzMsIEdlZXJ0IFV5dHRl
cmhvZXZlbiB3cm90ZToNCj4+PiBPbiBNb24sIE5vdiAyNiwgMjAxOCBhdCAxMDo1OSBQTSBQZXRl
ciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPiB3cm90ZToNCj4+Pj4gSWYgdGhlcmUgYXJlIGV4dHJh
IGxvZ29zIChDT05GSUdfRkJfTE9HT19FWFRSQSkgdGhlIGhlaWdodHMgb2YgdGhlc2UNCj4+Pj4g
ZXh0cmEgbG9nb3MgYXJlIG5vdCBjb25zaWRlcmVkIHdoZW4gY2VudGVyaW5nIHRoZSBmaXJzdCBs
b2dvIHZlcnRpY2FsbHkuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxw
ZWRhQGF4ZW50aWEuc2U+DQo+Pj4NCj4+Pj4gLS0tIGEvZHJpdmVycy92aWRlby9sb2dvL0tjb25m
aWcNCj4+Pj4gKysrIGIvZHJpdmVycy92aWRlby9sb2dvL0tjb25maWcNCj4+Pj4gQEAgLTEwLDYg
KzEwLDE1IEBAIG1lbnVjb25maWcgTE9HTw0KPj4+Pg0KPj4+PiAgaWYgTE9HTw0KPj4+Pg0KPj4+
PiArY29uZmlnIEZCX0xPR09fQ0VOVEVSDQo+Pj4+ICsgICAgICAgYm9vbCAiQ2VudGVyIHRoZSBs
b2dvIg0KPj4+PiArICAgICAgIGRlcGVuZHMgb24gRkI9eQ0KPj4+PiArICAgICAgIGhlbHANCj4+
Pj4gKyAgICAgICAgIFdoZW4gdGhpcyBvcHRpb24gaXMgc2VsZWN0ZWQsIHRoZSBib290dXAgbG9n
byBpcyBjZW50ZXJlZCBib3RoDQo+Pj4+ICsgICAgICAgICBob3Jpem9udGFsbHkgYW5kIHZlcnRp
Y2FsbHkuIElmIG1vcmUgdGhhbiBvbmUgbG9nbyBpcyBkaXNwbGF5ZWQNCj4+Pj4gKyAgICAgICAg
IGR1ZSB0byBtdWx0aXBsZSBDUFVzLCB0aGUgY29sbGVjdGVkIGxpbmUgb2YgbG9nb3MgaXMgY2Vu
dGVyZWQNCj4+Pj4gKyAgICAgICAgIGFzIGEgd2hvbGUuDQo+Pj4+ICsNCj4+Pg0KPj4+IElzbid0
IGEga2VybmVsIGNvbW1hbmQgbGluZSBvcHRpb24gbW9yZSBzdWl0YWJsZSB0byBjb25maWd1cmUg
dGhlIHBvc2l0aW9uDQo+Pj4gb2YgdGhlIGxvZ28/DQo+Pg0KPj4gVGhhdCBkaWRuJ3Qgb2NjdXIg
dG8gbWUgcHJldmlvdXNseSwgYnV0IGl0IGRvZXMgbWFrZSBzZW5zZSBub3cgdGhhdCB5b3UNCj4+
IG1lbnRpb24gaXQuIFRoaXMgaXMgb24gdG9wIG9mIHY1LjAtcmMxLCBhbmQgaWYgYXBwbGllZCBi
ZWZvcmUgdjUuMCB3ZQ0KPj4gY2FuIGF2b2lkIHBvc3NpYmxlIHJlZ3Jlc3Npb25zIGZvciBmb2xr
cyB3aG8gbWlnaHQgc3RhcnQgdG8gcmVseSBvbg0KPj4gQ09ORklHX0ZCX0xPR09fQ0VOVEVSIGlm
IHY1LjAgaXMgcmVsZWFzZWQgdy9vIHRoaXMuDQo+Pg0KPj4gQ2hlZXJzLA0KPj4gUGV0ZXINCj4+
DQo+PiBGcm9tIGRlNzM1M2FiNTE5YmE5YjVjOWVhM2Y2MmQ2MDdiYjhlOTRiNjg3Y2MgTW9uIFNl
cCAxNyAwMDowMDowMCAyMDAxDQo+PiBGcm9tOiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNl
Pg0KPj4gQ2M6IEJhcnRsb21pZWogWm9sbmllcmtpZXdpY3ogPGIuem9sbmllcmtpZUBzYW1zdW5n
LmNvbT4NCj4+IENjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pg0KPj4gQ2M6IFBl
dGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPj4gQ2M6IGxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZw0KPj4gQ2M6IGxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+PiBEYXRlOiBNb24sIDcgSmFuIDIwMTkgMDg6MzU6MjYgKzAxMDANCj4+IFN1YmplY3Q6
IFtQQVRDSF0gZmJkZXY6IGZibWVtOiBjb252ZXJ0IENPTkZJR19GQl9MT0dPX0NFTlRFUiBpbnRv
IGEgY21kIGxpbmUNCj4+ICBvcHRpb24NCj4+DQo+PiBBIGNvbW1hbmQgbGluZSBvcHRpb24gaXMg
bXVjaCBtb3JlIGZsZXhpYmxlIHRoYW4gYSBjb25maWcgb3B0aW9uIGFuZA0KPj4gdGhlIHN1cHBv
cnRpbmcgY29kZSBpcyBzbWFsbC4gR2V0cyByaWQgb2YgI2lmZGVmcyBpbiB0aGUgY29kZSB0b28u
Li4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgt
bTY4ay5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNl
Pg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vZmIvZmJjb24udHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2ZiL2ZiY29uLnR4dA0KPj4g
QEAgLTE2Myw2ICsxNjMsMTIgQEAgQy4gQm9vdCBvcHRpb25zDQo+PiAgICAgICAgIGJlIHByZXNl
cnZlZCB1bnRpbCB0aGVyZSBhY3R1YWxseSBpcyBzb21lIHRleHQgaXMgb3V0cHV0IHRvIHRoZSBj
b25zb2xlLg0KPj4gICAgICAgICBUaGlzIG9wdGlvbiBjYXVzZXMgZmJjb24gdG8gYmluZCBpbW1l
ZGlhdGVseSB0byB0aGUgZmJkZXYgZGV2aWNlLg0KPj4NCj4+ICs3LiBmYmNvbj1jZW50ZXItbG9n
bw0KPj4gKw0KPj4gKyAgICAgICBXaGVuIHRoaXMgb3B0aW9uIGlzIHNlbGVjdGVkLCB0aGUgYm9v
dHVwIGxvZ28gaXMgY2VudGVyZWQgYm90aA0KPj4gKyAgICAgICBob3Jpem9udGFsbHkgYW5kIHZl
cnRpY2FsbHkuIElmIG1vcmUgdGhhbiBvbmUgbG9nbyBpcyBkaXNwbGF5ZWQgZHVlIHRvDQo+PiAr
ICAgICAgIG11bHRpcGxlIENQVXMsIHRoZSBjb2xsZWN0ZWQgbGluZSBvZiBsb2dvcyBpcyBjZW50
ZXJlZCBhcyBhIHdob2xlLg0KPj4gKw0KPiANCj4gV2hhdCBhYm91dCBtYWtpbmcgdGhpcyBtb3Jl
IGdlbmVyaWMsIHRoYW4gYW4gb3B0aW9uIHNwZWNpZmljIGZvciBjZW50ZXJpbmc/DQo+IEVsc2Ug
cGVvcGxlIHdhbnQgZmJjb249bGVmdC1sb2dvIG9yIGZiY29uPXJpZ2h0LWxvZ28gc29vbj8NCj4g
DQo+ICAgICBmYmNvbj1sb2dvLXBvczo8cG9zPg0KPiANCj4gV2l0aCA8cG9zPiBiZWluZyAiY2Vu
dGVyIiwgImxlZnQiLCAidG9wIiwgInJpZ2h0IiwgImJvdHRvbSIsIGFuZCBjb21iaW5hdGlvbnMN
Cj4gbGlrZSAidG9wLGNlbnRlciI/IE9yIGlzIHRoYXQgY29tcGxpY2F0aW5nIHN0dWZmIHRvbyBt
dWNoPw0KDQpJJ20gbm90IHRvbyBrZWVuIG9uIGltcGxlbWVudGluZyBhbGwgdGhhdCB3aGVuIEkg
aGF2ZSB6ZXJvIHVzZSBmb3IgaXQuIEkgY2FuDQpob3dldmVyIHJlbmFtZSB0aGUgdHJpZ2dlciBm
b3IgdGhlIGV4aXN0aW5nIGZiX2NlbnRlcl9sb2dvIGJvb2wgdG8NCg0KCWZiY29uPWxvZ28tcG9z
OmNlbnRlcg0KDQphbmQgYWRkIGEgY2hlY2sgZm9yICJ0b3AsbGVmdCIgdG8gcmVzZXQgdGhlIGJv
b2wgdG8gZmFsc2UuIFRoZW4gdGhlIG90aGVyDQp2YXJpYW50cyBjYW4gYmUgYWRkZWQgbGF0ZXIg
Ynkgd2hvbWV2ZXIgYW5kIHdoZW4gbmVlZGVkLg0KDQpJcyB0aGF0IGdvb2QgZW5vdWdoPw0KDQpD
aGVlcnMsDQpQZXRlcg0K
