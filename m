Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA079C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948C720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emutex.onmicrosoft.com header.i=@emutex.onmicrosoft.com header.b="EGXfptvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948C720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeKATAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:00:44 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:3488
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbeKATAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emutex.onmicrosoft.com; s=selector1-emutex-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmUlviCACkYtsgekAZpYdCTVA0jUCmZHJIITq+JPHt0=;
 b=EGXfptvghsFuoGZj0qZQTBrsyQ9g8n17hfRgmfKj9y1hNCyDjFp/FBW5qi0eCp2WmejmK12R13/I/qGAxJCVvKqoYAxXhM3MQxnhPwRudttoj0Z3Bf7gZqs1ptQiMTRcDpwZVXJVYYmF06v7erSqqY42Fbgc7Pa0zHWHDPiRhpI=
Received: from HE1P190MB0012.EURP190.PROD.OUTLOOK.COM (10.172.129.137) by
 HE1P190MB0185.EURP190.PROD.OUTLOOK.COM (10.172.131.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.24; Thu, 1 Nov 2018 09:58:20 +0000
Received: from HE1P190MB0012.EURP190.PROD.OUTLOOK.COM
 ([fe80::9917:e7da:7675:a8c3]) by HE1P190MB0012.EURP190.PROD.OUTLOOK.COM
 ([fe80::9917:e7da:7675:a8c3%3]) with mapi id 15.20.1294.024; Thu, 1 Nov 2018
 09:58:20 +0000
From:   Dan O'Donovan <dan.odonovan@emutex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v3 1/3] mfd: upboard: Add UP2 platform controller driver
Thread-Topic: [PATCH v3 1/3] mfd: upboard: Add UP2 platform controller driver
Thread-Index: AQHUcbnolilkRBLVUUq2QNE2VfXHAKU6r10A
Date:   Thu, 1 Nov 2018 09:58:19 +0000
Message-ID: <32536c5d-9e88-7b2b-d7ab-acb2247870fa@emutex.com>
References: <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1541018689-20625-1-git-send-email-dan@emutex.com>
 <1541018689-20625-2-git-send-email-dan@emutex.com>
 <20181101080712.GB15973@dell>
In-Reply-To: <20181101080712.GB15973@dell>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To HE1P190MB0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:3:c9::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dan.odonovan@emutex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.51.199.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1P190MB0185;6:pOu8ZIBH/77FHw4NTdOC3K2agJfAb1o/nKrZ6kabCvZJvysxARkhd5Z/Y/Z6KhunPsuZA1tvprYbOt1woRc0ClS2lWAttAU5aNCACEveID4jBK1qoi5c2iB3GL/MjwCq0bSppTdms0ABFkTxutsM+UiwV3OUpAc1Nb++uxejql9gfyJ4wT2wyOtMJTVARRQJP8AOPqD13qL8moFCevetb+oP2IuIUBRnBo5q+Ge6kdAlAbSgDdv/7oBw2yI9RpyLhP5TnLoC0neo2fprWPsS5vxBgxrh6sujUpoS4/CvPbIQkWjtn2K1gtVoN9tNta49iSt1aAiQRL4msU/puJfIqMRTsjjVXNesYNjsfhG7BqS7x9eyhuyv766/DnTyFa/LGJ9Ktry+p38ohp/ZqMrIM+YJJcSoRjWdsCsXu7moELLGTRV5J3oiCzOcHyW0n5nJo+Wlravm3wqDNKflbD7ieg==;5:fmPjf/dtC5YqMd+5ofBz7xzBSuo8WPZ/SqcVARqH/SDkvrpc/3TB7al8GpmJcx/aJaDCKuyB5KFVp7pORUhr+Ybl8sw0p5AQzRZTrM4v8D81UmKPwZrWmMuaGMmnkLrAXGpHUgHdcYvNBgfOPMPvcP7aILuBCeUzaSCWoPQqYjI=;7:VMutMvRoSD6azF7Ui7Lc+leVsh2liwaJrc+OQjsoWYkJwlQKeaWnuQBexRkoXlZnUPzsgzi2+O6Dr63XHHUpjWCTNW0X/WmfA886kDjEAizUwrpbVYvgWzMiOsw0H3Xk66RIcvSjvXqPhGPi+jEavQ==
x-ms-office365-filtering-correlation-id: 53f25cfe-9bec-4ee8-8bcc-08d63fe08d6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1P190MB0185;
x-ms-traffictypediagnostic: HE1P190MB0185:
x-microsoft-antispam-prvs: <HE1P190MB01859EE963B86BC3D0BBF174F8CE0@HE1P190MB0185.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(278428928389397)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1P190MB0185;BCL:0;PCL:0;RULEID:;SRVR:HE1P190MB0185;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39830400003)(136003)(346002)(366004)(189003)(199004)(11346002)(6116002)(256004)(6486002)(53936002)(446003)(66066001)(105586002)(106356001)(2900100001)(76176011)(229853002)(52116002)(3846002)(486006)(6436002)(2616005)(476003)(316002)(2906002)(186003)(71190400001)(71200400001)(110136005)(6246003)(54906003)(6512007)(107886003)(93886005)(14454004)(31696002)(478600001)(36756003)(7736002)(305945005)(68736007)(86362001)(39060400002)(25786009)(99286004)(8936002)(102836004)(31686004)(4326008)(81156014)(81166006)(97736004)(8676002)(55236004)(6506007)(386003)(53546011)(7416002)(5250100002)(5660300001)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1P190MB0185;H:HE1P190MB0012.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: emutex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UKgwefr33c013F4lw+mrGHFShcs9qFeMtkR5aoa+MVj+Z0zskTsNZJtg+gvA6oPjHKwUOMZQOSZ9vIJfmTfxbJyHFT7u+TursWUmQIV9RtxBlo/bflQiSLX/G2orsHZG3u86usFzz2nu2P24C7ckBumIrQ824/ZkGdIp7bxsV+2mJxLlIwXauBNiCXgheHE/mdDJvQH1raUAUIonJcqzbkgyUTguSQO5hRqtTwlmuE8M157uACDW6+2CsGfxS2ZMvOtW1XJ/wzLSbGROnk6Y0tlHTJU+iWqJhhFw5rGFlJ1QlTW84PptL+c9gJkxvn3yVyGe29KjxUJ/uCirqMUUBnLos1bBH9Rf+4XOFoHw3j0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <04A91641CFDDA54D988CCE97E02623D9@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: emutex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f25cfe-9bec-4ee8-8bcc-08d63fe08d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 09:58:20.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cc844b-5c53-4da1-99da-34ef4089ea8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDEvMjAxOCAwODowNyBBTSwgTGVlIEpvbmVzIHdyb3RlOg0KPiBPbiBXZWQsIDMxIE9j
dCAyMDE4LCBEYW4gTydEb25vdmFuIHdyb3RlOg0KPg0KPj4gVVAgU3F1YXJlZCAoVVAyKSBpcyBh
IHg4NiBTQkMgZnJvbSBBQUVPTiBiYXNlZCBvbiBJbnRlbCBBcG9sbG8gTGFrZS4gSXQNCj4+IGZl
YXR1cmVzIGEgTUFYIDEwIEZQR0EgdGhhdCByb3V0ZXMgbGluZXMgZnJvbSBib3RoIFNvQyBhbmQg
b24tYm9hcmQNCj4+IGRldmljZXMgdG8gdHdvIEkvTyBoZWFkZXJzOg0KPj4NCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA0MC1waW4gUlBpLWxpa2UgaGVhZGVyIHwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICArLS0tLS0tfCAgICAgICAgIChIQVQpICAgICAg
ICAgIHwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsNCj4+ICAgICArLS0tLS0tLSsgICAgKy0tLS0tLS0tKw0KPj4gICAgIHwgICAg
ICAgfCAgICB8ICAgICAgICB8ICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4gICAg
IHwgIFNvQyAgfC0tLS18ICBGUEdBICB8LS0tLS18ICBDdXN0b20gVVAyIHBpbiBoZWFkZXIgfA0K
Pj4gICAgIHwgICAgICAgfCAgICB8ICAgICAgICB8ICAgICB8ICAgICAgICAoRVhIQVQpICAgICAg
ICAgfA0KPj4gICAgICstLS0tLS0tKyAgICArLS0tLS0tLS0rICAgICArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICArLS0tLS0tKiBPbi1ib2FyZCBkZXZpY2VzOiBMRUQsIFZMUy4uLg0KPj4N
Cj4+IFRoaXMgaXMgaW50ZW5kZWQgdG8gZW5hYmxlIHZlbmRvci1zcGVjaWZpYyBhcHBsaWNhdGlv
bnMgdG8gY3VzdG9taXplIEkvTw0KPj4gaGVhZGVyIHBpbm91dCwgYXMgd2VsbCBhcyBpbmNsdWRl
IGxvdy1sYXRlbmN5IGZ1bmN0aW9uYWxpdHkuIEl0IGFsc28NCj4+IHBlcmZvcm1zIHZvbHRhZ2Ug
bGV2ZWwgdHJhbnNsYXRpb24gYmV0d2VlbiB0aGUgU29DICgxLjhWKSBhbmQgSEFUIGhlYWRlcg0K
Pj4gKDMuM1YpLg0KPj4NCj4+IE91dCBvZiB0aGUgYm94LCB0aGlzIGJsb2NrIGltcGxlbWVudHMg
YSBwbGF0Zm9ybSBjb250cm9sbGVyIHdpdGggYQ0KPj4gR1BJTy1iaXRiYW5nZWQgY29udHJvbCBp
bnRlcmZhY2UuIEl0J3MgZW51bWVyYXRlZCBieSBBQ1BJIGFuZCBwcm92aWRlcw0KPj4gcmVnaXN0
ZXJzIHRvIGNvbnRyb2w6DQo+Pg0KPj4gLSBDb25maWd1cmF0aW9uIG9mIGFsbCBGUEdBLXJvdXRl
ZCBoZWFkZXIgbGluZXMuIFRoZXNlIGNhbiBiZSBkcml2ZW4NCj4+ICAgU29DLXRvLWhlYWRlciwg
aGVhZGVyLXRvLVNvQyBvciBzZXQgaW4gaGlnaCBpbXBlZGFuY2UuDQo+Pg0KPj4gLSBPbi1ib2Fy
ZCBMRURzIGFuZCBlbmFibGUgbGluZXMgZm9yIG90aGVyIHBsYXRmb3JtIGRldmljZXMuDQo+Pg0K
Pj4gQWRkIGNvcmUgc3VwcG9ydCBmb3IgdGhpcyBwbGF0Zm9ybSBjb250cm9sbGVyIGFzIGEgTUZE
IGRldmljZSwgZXhwb3NpbmcNCj4+IHRoZXNlIHJlZ2lzdGVycyBhcyBhIHJlZ21hcC4NCj4+DQo+
PiBBY2tlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPj4g
U2lnbmVkLW9mZi1ieTogRGFuIE8nRG9ub3ZhbiA8ZGFuQGVtdXRleC5jb20+DQo+PiAtLS0NCj4+
ICBkcml2ZXJzL21mZC9LY29uZmlnICAgICAgICAgfCAgMTcgKysrDQo+PiAgZHJpdmVycy9tZmQv
TWFrZWZpbGUgICAgICAgIHwgICAxICsNCj4+ICBkcml2ZXJzL21mZC91cGJvYXJkLmMgICAgICAg
fCAzMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBp
bmNsdWRlL2xpbnV4L21mZC91cGJvYXJkLmggfCAgNDQgKysrKysrDQo+PiAgNCBmaWxlcyBjaGFu
Z2VkLCAzOTggaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21m
ZC91cGJvYXJkLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvdXBi
b2FyZC5oDQo+IExvb2tzIGxpa2UgeW91J3ZlIGlnbm9yZWQgdGhlIHJldmlldyBjb21tZW50cyBo
ZXJlIHRvby4NCkhpIExlZS7CoCBMb29rcyBsaWtlIEkgZGlkbid0IHJlY2VpdmUgeW91ciBvcmln
aW5hbCBlbWFpbCwgbW9zdCBsaWtlbHkgYmVjYXVzZSBvZiBhIGNyYXBweSBzcGFtIGZpbHRlcmlu
ZyBzZXJ2aWNlIHdlIHdlcmUgdXNpbmcgaGVyZSB1cCB1bnRpbCByZWNlbnRseS7CoCBJJ3ZlIGZv
dW5kIHlvdXIgY29tbWVudHMgaW4gb25saW5lIGFyY2hpdmVzIG5vdyBhbmQgd2lsbCBhZGRyZXNz
IHRoZW0gaW4gdGhlIG5leHQgcmV2aXNpb24gb2YgdGhlIHBhdGNoZXMuwqAgU29ycnkgZm9yIHRo
ZSBpbmNvbnZlbmllbmNlLiA6KA0KDQo=
