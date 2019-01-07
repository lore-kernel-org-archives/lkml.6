Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076002085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="NWFzo5X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfAGI0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:26:24 -0500
Received: from mail-eopbgr00130.outbound.protection.outlook.com ([40.107.0.130]:39389
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfAGI0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PtSEYC6J68NZuW8nFtNd6whii4mGgXalrz+drQyXnM=;
 b=NWFzo5X+RwU7U8bk3hC34A/sWJ21DLVr5zBm2pSrDeVCm0KDvfDYRSGtEaov5pc1ZBuXjdFIgQkrVIJVFfgx06PazpRZ1nAfd0FjZ7vng7sd+oHSC/LoIP4J0VyFFvrrerd68bOdIubbkjpsVQZw8D09jYZ7Vln4KhlkZGMDsDU=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3640.eurprd02.prod.outlook.com (52.134.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 08:26:18 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 08:26:18 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line,
 option
Thread-Topic: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd
 line, option
Thread-Index: AQHUpmKp1rTfj0qE9kqQItXBl7LZjA==
Date:   Mon, 7 Jan 2019 08:26:18 +0000
Message-ID: <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0037.eurprd07.prod.outlook.com
 (2603:10a6:7:66::23) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3640;6:InZQ5Pff19uk+db07E+5lvgQEuwE4R2w6DQed7sI45+eaXe5mxVgSeGLLPb+rzEBtb9Ti/fYjPXK0Fp4lm0pC2zrs4nvbCpNcFMh6Wqz9bs0ckhdWuhFpFtofE8+wAC+MDiduwdNZGZLJF4BTQQZUUnXzj1Pk7Q123DD/t5j7c6gFMZStMveOvZFnEwQggEEXMmCVBLpeBokaFYkv1I2tAowsLrdhQEAgIb8P14S0SJw1KzsI4E7+lWanNzRXtQcUgbSqMgsE+nmYhrnkqD/Jn85KMuFFb+oW2jaURbvKEm/ylpJ3sA/dIOTomFAo05zCcc1g42B2CzS1r7NVI8P/fRD05MvJsR2rmsbUA7dXtyQVqeORy5RcgU3vLEzpY2szpQjc5RSmgWDnbUfwgM1nArPwDhzhC3BAJaYeIQTqE2clNGvegIDJUG5D/1uFzcN3dW52+I9huLh2wyihHypOg==;5:IJDU9tUj2ceBh4YgfluYXQBzk6dJqTfGL5LXGBusmU+1rRimC+8OfA/bDQvWx0iXhyPwIVJwfE1lBeWmTAp4sQEwJeB0LAZCcrK+SLvMhcYkhI515RJpFyCr+bCppWc2O0PYBFstQC9hRWcuWuK6Cm+HD9L1YXYCpL1U68NmKeJbXXzWq5dI0R07qxMLD5MeNYcNMyI0PneGc3abk2lb+Q==;7:ltczMUuhRoM0VG52bOzmJKsxvfbCgxngpGy+Txtozg93CcZiVxSEjqOffxZAOwtLd7s8DCJjhsGQiCiTgK4umi/MGx0aGiJ5r/ikTNL0RbIfFqrfmziBakm06QDcHmSnn3vwQ5IgYseKLZ6mjzV7oA==
x-ms-office365-filtering-correlation-id: af4825ef-6674-4c3a-15f2-08d67479cbd2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3640;
x-ms-traffictypediagnostic: AM6PR02MB3640:
x-microsoft-antispam-prvs: <AM6PR02MB36401F6B70BB81057611428FBC890@AM6PR02MB3640.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB3640;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB3640;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39830400003)(396003)(366004)(376002)(199004)(189003)(54906003)(6512007)(81156014)(8936002)(64126003)(76176011)(53936002)(8676002)(81166006)(316002)(71190400001)(71200400001)(36756003)(74482002)(6916009)(14454004)(97736004)(25786009)(7736002)(58126008)(5024004)(52116002)(31696002)(86362001)(575784001)(256004)(4326008)(68736007)(65826007)(5660300001)(11346002)(186003)(305945005)(105586002)(486006)(476003)(66066001)(106356001)(6486002)(446003)(2616005)(3846002)(26005)(6436002)(99286004)(2906002)(65806001)(65956001)(6116002)(102836004)(508600001)(31686004)(6506007)(386003)(6346003)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3640;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j0quF84YFgpUPuFJwXjr9EYSa6+GzsCp0Rnz9IZdL2hlz7d323ZOAJ3TkIgk1EdISCCz+4yluBolWTQ5wSJLq0YP3OKUiNaxFAsfb0FTEZLOclxOZxOuawbNlXB38ZxsbKlNK8f9e0FaGnkzYRJUrX3gyf7JfbvpcBGocciob80b37DtO1uaFPzR5S0n1Cd+PDn+VZkXcl9e5nYruKm3OepHJRk5x2FzKymk8aueU+FbpH2qWF7OieRZhUPImRkrC2NJYAoQeEIiBsJkIox0kv0iQsqbNR1OAYC8FsjRWDlbmz8kiW/5UjXduJtsJRys
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <51271FA3BF5BA840893FE6ACFCE39F3E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: af4825ef-6674-4c3a-15f2-08d67479cbd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 08:26:17.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wNiAxMDozMywgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBQZXRl
ciwNCj4gDQo+IE9uIE1vbiwgTm92IDI2LCAyMDE4IGF0IDEwOjU5IFBNIFBldGVyIFJvc2luIDxw
ZWRhQGF4ZW50aWEuc2U+IHdyb3RlOg0KPj4gSWYgdGhlcmUgYXJlIGV4dHJhIGxvZ29zIChDT05G
SUdfRkJfTE9HT19FWFRSQSkgdGhlIGhlaWdodHMgb2YgdGhlc2UNCj4+IGV4dHJhIGxvZ29zIGFy
ZSBub3QgY29uc2lkZXJlZCB3aGVuIGNlbnRlcmluZyB0aGUgZmlyc3QgbG9nbyB2ZXJ0aWNhbGx5
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+
IA0KPj4gLS0tIGEvZHJpdmVycy92aWRlby9sb2dvL0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMv
dmlkZW8vbG9nby9LY29uZmlnDQo+PiBAQCAtMTAsNiArMTAsMTUgQEAgbWVudWNvbmZpZyBMT0dP
DQo+Pg0KPj4gIGlmIExPR08NCj4+DQo+PiArY29uZmlnIEZCX0xPR09fQ0VOVEVSDQo+PiArICAg
ICAgIGJvb2wgIkNlbnRlciB0aGUgbG9nbyINCj4+ICsgICAgICAgZGVwZW5kcyBvbiBGQj15DQo+
PiArICAgICAgIGhlbHANCj4+ICsgICAgICAgICBXaGVuIHRoaXMgb3B0aW9uIGlzIHNlbGVjdGVk
LCB0aGUgYm9vdHVwIGxvZ28gaXMgY2VudGVyZWQgYm90aA0KPj4gKyAgICAgICAgIGhvcml6b250
YWxseSBhbmQgdmVydGljYWxseS4gSWYgbW9yZSB0aGFuIG9uZSBsb2dvIGlzIGRpc3BsYXllZA0K
Pj4gKyAgICAgICAgIGR1ZSB0byBtdWx0aXBsZSBDUFVzLCB0aGUgY29sbGVjdGVkIGxpbmUgb2Yg
bG9nb3MgaXMgY2VudGVyZWQNCj4+ICsgICAgICAgICBhcyBhIHdob2xlLg0KPj4gKw0KPiANCj4g
SXNuJ3QgYSBrZXJuZWwgY29tbWFuZCBsaW5lIG9wdGlvbiBtb3JlIHN1aXRhYmxlIHRvIGNvbmZp
Z3VyZSB0aGUgcG9zaXRpb24NCj4gb2YgdGhlIGxvZ28/DQoNClRoYXQgZGlkbid0IG9jY3VyIHRv
IG1lIHByZXZpb3VzbHksIGJ1dCBpdCBkb2VzIG1ha2Ugc2Vuc2Ugbm93IHRoYXQgeW91DQptZW50
aW9uIGl0LiBUaGlzIGlzIG9uIHRvcCBvZiB2NS4wLXJjMSwgYW5kIGlmIGFwcGxpZWQgYmVmb3Jl
IHY1LjAgd2UNCmNhbiBhdm9pZCBwb3NzaWJsZSByZWdyZXNzaW9ucyBmb3IgZm9sa3Mgd2hvIG1p
Z2h0IHN0YXJ0IHRvIHJlbHkgb24NCkNPTkZJR19GQl9MT0dPX0NFTlRFUiBpZiB2NS4wIGlzIHJl
bGVhc2VkIHcvbyB0aGlzLg0KDQpDaGVlcnMsDQpQZXRlcg0KDQpGcm9tIGRlNzM1M2FiNTE5YmE5
YjVjOWVhM2Y2MmQ2MDdiYjhlOTRiNjg3Y2MgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9t
OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KQ2M6IEJhcnRsb21pZWogWm9sbmllcmtp
ZXdpY3ogPGIuem9sbmllcmtpZUBzYW1zdW5nLmNvbT4NCkNjOiBKb25hdGhhbiBDb3JiZXQgPGNv
cmJldEBsd24ubmV0Pg0KQ2M6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IGxpbnV4LWZiZGV2QHZnZXIua2VybmVs
Lm9yZw0KQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNClRvOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQpEYXRlOiBNb24sIDcgSmFuIDIwMTkgMDg6MzU6MjYgKzAxMDANClN1Ympl
Y3Q6IFtQQVRDSF0gZmJkZXY6IGZibWVtOiBjb252ZXJ0IENPTkZJR19GQl9MT0dPX0NFTlRFUiBp
bnRvIGEgY21kIGxpbmUNCiBvcHRpb24NCg0KQSBjb21tYW5kIGxpbmUgb3B0aW9uIGlzIG11Y2gg
bW9yZSBmbGV4aWJsZSB0aGFuIGEgY29uZmlnIG9wdGlvbiBhbmQNCnRoZSBzdXBwb3J0aW5nIGNv
ZGUgaXMgc21hbGwuIEdldHMgcmlkIG9mICNpZmRlZnMgaW4gdGhlIGNvZGUgdG9vLi4uDQoNClN1
Z2dlc3RlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NClNp
Z25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2ZiL2ZiY29uLnR4dCAgICAgICB8ICA2ICsrKysrKw0KIGRyaXZlcnMvdmlkZW8vZmJk
ZXYvY29yZS9mYmNvbi5jIHwgIDUgKysrKysNCiBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJt
ZW0uYyB8IDE5ICsrKysrKysrKystLS0tLS0tLS0NCiBkcml2ZXJzL3ZpZGVvL2xvZ28vS2NvbmZp
ZyAgICAgICB8ICA5IC0tLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgvZmIuaCAgICAgICAgICAgICAg
IHwgIDEgKw0KIDUgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2ZiL2ZiY29uLnR4dCBiL0RvY3VtZW50
YXRpb24vZmIvZmJjb24udHh0DQppbmRleCA2MmFmMzA1MTFhOTUuLmZiNWZhMGE4ZDU1MyAxMDA2
NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZmIvZmJjb24udHh0DQorKysgYi9Eb2N1bWVudGF0aW9u
L2ZiL2ZiY29uLnR4dA0KQEAgLTE2Myw2ICsxNjMsMTIgQEAgQy4gQm9vdCBvcHRpb25zDQogCWJl
IHByZXNlcnZlZCB1bnRpbCB0aGVyZSBhY3R1YWxseSBpcyBzb21lIHRleHQgaXMgb3V0cHV0IHRv
IHRoZSBjb25zb2xlLg0KIAlUaGlzIG9wdGlvbiBjYXVzZXMgZmJjb24gdG8gYmluZCBpbW1lZGlh
dGVseSB0byB0aGUgZmJkZXYgZGV2aWNlLg0KIA0KKzcuIGZiY29uPWNlbnRlci1sb2dvDQorDQor
CVdoZW4gdGhpcyBvcHRpb24gaXMgc2VsZWN0ZWQsIHRoZSBib290dXAgbG9nbyBpcyBjZW50ZXJl
ZCBib3RoDQorCWhvcml6b250YWxseSBhbmQgdmVydGljYWxseS4gSWYgbW9yZSB0aGFuIG9uZSBs
b2dvIGlzIGRpc3BsYXllZCBkdWUgdG8NCisJbXVsdGlwbGUgQ1BVcywgdGhlIGNvbGxlY3RlZCBs
aW5lIG9mIGxvZ29zIGlzIGNlbnRlcmVkIGFzIGEgd2hvbGUuDQorDQogQy4gQXR0YWNoaW5nLCBE
ZXRhY2hpbmcgYW5kIFVubG9hZGluZw0KIA0KIEJlZm9yZSBnb2luZyBvbiB0byBob3cgdG8gYXR0
YWNoLCBkZXRhY2ggYW5kIHVubG9hZCB0aGUgZnJhbWVidWZmZXIgY29uc29sZSwgYW4NCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYyBiL2RyaXZlcnMvdmlkZW8v
ZmJkZXYvY29yZS9mYmNvbi5jDQppbmRleCA4OTc2MTkwYjZjMWYuLjU1MmNmZWU2M2Q3NiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQorKysgYi9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYw0KQEAgLTUxMCw2ICs1MTAsMTEgQEAgc3RhdGljIGlu
dCBfX2luaXQgZmJfY29uc29sZV9zZXR1cChjaGFyICp0aGlzX29wdCkNCiAJCQljb250aW51ZTsN
CiAJCX0NCiAjZW5kaWYNCisNCisJCWlmICghc3RyY21wKG9wdGlvbnMsICJjZW50ZXItbG9nbyIp
KSB7DQorCQkJZmJfY2VudGVyX2xvZ28gPSB0cnVlOw0KKwkJCWNvbnRpbnVlOw0KKwkJfQ0KIAl9
DQogCXJldHVybiAxOw0KIH0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUv
ZmJtZW0uYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYm1lbS5jDQppbmRleCA1NThlZDJl
ZDMxMjQuLmNiNDNhMjI1OGM1MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29y
ZS9mYm1lbS5jDQorKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KQEAgLTUz
LDYgKzUzLDkgQEAgRVhQT1JUX1NZTUJPTChyZWdpc3RlcmVkX2ZiKTsNCiBpbnQgbnVtX3JlZ2lz
dGVyZWRfZmIgX19yZWFkX21vc3RseTsNCiBFWFBPUlRfU1lNQk9MKG51bV9yZWdpc3RlcmVkX2Zi
KTsNCiANCitib29sIGZiX2NlbnRlcl9sb2dvIF9fcmVhZF9tb3N0bHk7DQorRVhQT1JUX1NZTUJP
TChmYl9jZW50ZXJfbG9nbyk7DQorDQogc3RhdGljIHN0cnVjdCBmYl9pbmZvICpnZXRfZmJfaW5m
byh1bnNpZ25lZCBpbnQgaWR4KQ0KIHsNCiAJc3RydWN0IGZiX2luZm8gKmZiX2luZm87DQpAQCAt
NTA2LDggKzUwOSw3IEBAIHN0YXRpYyBpbnQgZmJfc2hvd19sb2dvX2xpbmUoc3RydWN0IGZiX2lu
Zm8gKmluZm8sIGludCByb3RhdGUsDQogCQlmYl9zZXRfbG9nbyhpbmZvLCBsb2dvLCBsb2dvX25l
dywgZmJfbG9nby5kZXB0aCk7DQogCX0NCiANCi0jaWZkZWYgQ09ORklHX0ZCX0xPR09fQ0VOVEVS
DQotCXsNCisJaWYgKGZiX2NlbnRlcl9sb2dvKSB7DQogCQlpbnQgeHJlcyA9IGluZm8tPnZhci54
cmVzOw0KIAkJaW50IHlyZXMgPSBpbmZvLT52YXIueXJlczsNCiANCkBAIC01MjAsMTEgKzUyMiwx
MSBAQCBzdGF0aWMgaW50IGZiX3Nob3dfbG9nb19saW5lKHN0cnVjdCBmYl9pbmZvICppbmZvLCBp
bnQgcm90YXRlLA0KIAkJCS0tbjsNCiAJCWltYWdlLmR4ID0gKHhyZXMgLSBuICogKGxvZ28tPndp
ZHRoICsgOCkgLSA4KSAvIDI7DQogCQlpbWFnZS5keSA9IHkgPzogKHlyZXMgLSBsb2dvLT5oZWln
aHQpIC8gMjsNCisJfSBlbHNlIHsNCisJCWltYWdlLmR4ID0gMDsNCisJCWltYWdlLmR5ID0geTsN
CiAJfQ0KLSNlbHNlDQotCWltYWdlLmR4ID0gMDsNCi0JaW1hZ2UuZHkgPSB5Ow0KLSNlbmRpZg0K
Kw0KIAlpbWFnZS53aWR0aCA9IGxvZ28tPndpZHRoOw0KIAlpbWFnZS5oZWlnaHQgPSBsb2dvLT5o
ZWlnaHQ7DQogDQpAQCAtNjg0LDkgKzY4Niw4IEBAIGludCBmYl9wcmVwYXJlX2xvZ28oc3RydWN0
IGZiX2luZm8gKmluZm8sIGludCByb3RhdGUpDQogIAl9DQogDQogCWhlaWdodCA9IGZiX2xvZ28u
bG9nby0+aGVpZ2h0Ow0KLSNpZmRlZiBDT05GSUdfRkJfTE9HT19DRU5URVINCi0JaGVpZ2h0ICs9
ICh5cmVzIC0gZmJfbG9nby5sb2dvLT5oZWlnaHQpIC8gMjsNCi0jZW5kaWYNCisJaWYgKGZiX2Nl
bnRlcl9sb2dvKQ0KKwkJaGVpZ2h0ICs9ICh5cmVzIC0gZmJfbG9nby5sb2dvLT5oZWlnaHQpIC8g
MjsNCiANCiAJcmV0dXJuIGZiX3ByZXBhcmVfZXh0cmFfbG9nb3MoaW5mbywgaGVpZ2h0LCB5cmVz
KTsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9sb2dvL0tjb25maWcgYi9kcml2ZXJz
L3ZpZGVvL2xvZ28vS2NvbmZpZw0KaW5kZXggMWU5NzJjNGU4OGIxLi5kMWY2MTk2YzhiOWEgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3ZpZGVvL2xvZ28vS2NvbmZpZw0KKysrIGIvZHJpdmVycy92aWRl
by9sb2dvL0tjb25maWcNCkBAIC0xMCwxNSArMTAsNiBAQCBtZW51Y29uZmlnIExPR08NCiANCiBp
ZiBMT0dPDQogDQotY29uZmlnIEZCX0xPR09fQ0VOVEVSDQotCWJvb2wgIkNlbnRlciB0aGUgbG9n
byINCi0JZGVwZW5kcyBvbiBGQj15DQotCWhlbHANCi0JICBXaGVuIHRoaXMgb3B0aW9uIGlzIHNl
bGVjdGVkLCB0aGUgYm9vdHVwIGxvZ28gaXMgY2VudGVyZWQgYm90aA0KLQkgIGhvcml6b250YWxs
eSBhbmQgdmVydGljYWxseS4gSWYgbW9yZSB0aGFuIG9uZSBsb2dvIGlzIGRpc3BsYXllZA0KLQkg
IGR1ZSB0byBtdWx0aXBsZSBDUFVzLCB0aGUgY29sbGVjdGVkIGxpbmUgb2YgbG9nb3MgaXMgY2Vu
dGVyZWQNCi0JICBhcyBhIHdob2xlLg0KLQ0KIGNvbmZpZyBGQl9MT0dPX0VYVFJBDQogCWJvb2wN
CiAJZGVwZW5kcyBvbiBGQj15DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mYi5oIGIvaW5j
bHVkZS9saW51eC9mYi5oDQppbmRleCA3Y2RkMzFhNjk3MTkuLmY1MmVmMGFkNjc4MSAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvZmIuaA0KKysrIGIvaW5jbHVkZS9saW51eC9mYi5oDQpAQCAt
NjUzLDYgKzY1Myw3IEBAIGV4dGVybiBpbnQgZmJfbmV3X21vZGVsaXN0KHN0cnVjdCBmYl9pbmZv
ICppbmZvKTsNCiANCiBleHRlcm4gc3RydWN0IGZiX2luZm8gKnJlZ2lzdGVyZWRfZmJbRkJfTUFY
XTsNCiBleHRlcm4gaW50IG51bV9yZWdpc3RlcmVkX2ZiOw0KK2V4dGVybiBib29sIGZiX2NlbnRl
cl9sb2dvOw0KIGV4dGVybiBzdHJ1Y3QgY2xhc3MgKmZiX2NsYXNzOw0KIA0KICNkZWZpbmUgZm9y
X2VhY2hfcmVnaXN0ZXJlZF9mYihpKQkJXA0KLS0gDQoyLjExLjANCg0K
