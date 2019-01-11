Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B6B20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Kfsa3NbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfAKN3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:29:30 -0500
Received: from mail-eopbgr20115.outbound.protection.outlook.com ([40.107.2.115]:7099
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730064AbfAKN3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MhBJ+Zjq/sFTfW4lcm3Bqh9Y7u+XGywWwPWEs5gV8U=;
 b=Kfsa3NbUDC3VqQCXwHPzq+FWvQi/Na245LOeOa+aXjrc+4qwSrtSwzb15rMxZyMkEbTSbj3fvAmtL/atNKvZQc4grvDJhl1WpvwOBACOeRft2Xv7WdU0ucFzUYsgq6oKUoQ8uMmnQuA6OASDn+7Vx+NQB4tlJnUIjh8Y8kHmZZI=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB5269.eurprd02.prod.outlook.com (20.178.89.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 13:29:24 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 13:29:24 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Topic: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Index: AQHUqPal2z9iTYzgb0+a4YlOuMR4jaWox3GAgAFJ8YA=
Date:   Fri, 11 Jan 2019 13:29:24 +0000
Message-ID: <23d60fbc-42c4-a2b2-5616-d21eabfd0a3f@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-3-peda@axentia.se> <20190110184816.63350396@bbrezillon>
In-Reply-To: <20190110184816.63350396@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::26) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB5269;6:ZziP3gtq6GpEmDlkAe52fhjBowZwH3pd0Ilb351VkdgxKWv08JvNoESRAKnjfTnEqi6TAqyrlG6WU3MJKEGN5wIFr6sDCWA9JSnXQfyO+j0teMItSkmKxaQEj4NXpmlvRl5UxftU7LaURYoPaL9VUPcHSNb0B6ugaPoZ//cgwRN6GNzIKhQ/yB9Bd8nh+10kSGSZ33qpZpnT2iOUbiwi0H21ydBbDUMcHsBjhuCvdZMPjc4cOxUDeuIwsxk9XLiSZ7oiXCsUNa+mXTkRLTCISiWttWtJ2xSYEXx9HRwW6ifqMlWr18mW753WunoLOVW06PR1Jos8DybYjkDGdRnmnRsf8xxJj/4fKcS5luV5ZvkO75EeYnCd3otjNEJpPoIuwd4jrAFX57q8pWLxwqwtGp0qbMGmkpiwqYwxEE0UKVWH23ZsMX7X17Excx29J1zb5m24R4z13ileW/OQW0Q6+g==;5:APXzV+xbooikA/UYUnFLhhTU/Hrrkxq6DPSHlzixrkinpebCl/rBMw7qzpBM4Y9xmtKJd43ZS0NSWoAmwVqJPSpOEopN0uNmRx9TzwHwacqvjE88aByY8lSvE7qZ9ngKus3A5STSXq+m90RjaQXWJbGO1/qLpy6u1JPYQKUEMZBtLIfYKfI2wK7LXAV309RN84wHgI51is1agIhzaQHz4g==;7:LbnHiX1mmMhZhdeJZZ25KCClmZ5RYP5pn9b5CCA2XMJaxrIySWBVVG73mHU77TbGdbVRVciWAD7kuyTlVOtiymJUGu7cCjQAJ30oezbOUKsuqhZeqaMSGEU2KqEL3m8AuaT7IbdB79bOJDzJJStFSA==
x-ms-office365-filtering-correlation-id: 709c964c-05df-43a4-aa5a-08d677c8cd46
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB5269;
x-ms-traffictypediagnostic: AM6PR02MB5269:
x-microsoft-antispam-prvs: <AM6PR02MB5269BCE62C6F61FD31C2DAAABC850@AM6PR02MB5269.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(376002)(366004)(396003)(346002)(199004)(189003)(31686004)(8936002)(14454004)(99286004)(4326008)(386003)(5660300001)(65826007)(7736002)(6506007)(305945005)(6246003)(2616005)(97736004)(54906003)(508600001)(106356001)(316002)(58126008)(105586002)(3846002)(71200400001)(6916009)(6116002)(6486002)(68736007)(52116002)(256004)(486006)(74482002)(71190400001)(53936002)(65956001)(65806001)(76176011)(229853002)(6512007)(575784001)(14444005)(8676002)(81156014)(186003)(81166006)(26005)(446003)(86362001)(66066001)(11346002)(6436002)(31696002)(36756003)(102836004)(476003)(25786009)(2906002)(53546011)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB5269;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3EbIQaFW/dZXB60KiNKR5Rie+qYPuiAAM0WSm/nnNSBaobu7zYWKDXhf+STjr9+yDcpPDg185Z07HIRNnc4/O9qaaUJnzVlsxM5w19MwbYnBiDiYEKbM3DS4BlK+EhnLtgMSYl9Sws8Qo2XiDPvfQjwEU7rK7e0n045nSswRHc6I6Fpm9Ki6sbxJDXbJfm8/RMNULejqI14fASc2eHZ4zmDdw3pBBExUgoUB4BVVjRML2qRODOiy/9jkvQHRZiKw3rmikRVFI50AIfhEABj0JwS8spi7PWea04sTNoBWpplCCGbAs32Df6hp7cJWGQNJyf2JhExETyoZadKax1imuNfgrLXVXi8HqpOyhTFb0UGEefsRa+8ZI84AVqSaqYVrSwrSVFAOaRrt0K98sRbOwPfjKOlFgqrufxz94XPhzOI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E9D57C3371C3A44882D045EAE859C83@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c964c-05df-43a4-aa5a-08d677c8cd46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 13:29:23.5515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0xMCAxODo0OCwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPiBPbiBUaHUsIDEw
IEphbiAyMDE5IDE1OjEwOjM5ICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+
IHdyb3RlOg0KPiANCj4+IFRoZSBkZXN0aW5hdGlvbiBjcnRjIHJlY3RhbmdsZSBpcyBpbmRlcGVu
ZGVudCBvZiBzb3VyY2UgcGxhbmUgcm90YXRpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0
ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9h
dG1lbC1obGNkYy9hdG1lbF9obGNkY19wbGFuZS5jIHwgMyAtLS0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2F0
bWVsLWhsY2RjL2F0bWVsX2hsY2RjX3BsYW5lLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxj
ZGMvYXRtZWxfaGxjZGNfcGxhbmUuYw0KPj4gaW5kZXggZWE4ZmMwZGViODE0Li5kNmY5M2YwMjkw
MjAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxj
ZGNfcGxhbmUuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hs
Y2RjX3BsYW5lLmMNCj4+IEBAIC02NDIsOSArNjQyLDYgQEAgc3RhdGljIGludCBhdG1lbF9obGNk
Y19wbGFuZV9hdG9taWNfY2hlY2soc3RydWN0IGRybV9wbGFuZSAqcCwNCj4+ICAJICogU3dhcCB3
aWR0aCBhbmQgc2l6ZSBpbiBjYXNlIG9mIDkwIG9yIDI3MCBkZWdyZWVzIHJvdGF0aW9uDQo+PiAg
CSAqLw0KPj4gIAlpZiAoZHJtX3JvdGF0aW9uXzkwX29yXzI3MChzdGF0ZS0+YmFzZS5yb3RhdGlv
bikpIHsNCj4+IC0JCXRtcCA9IHN0YXRlLT5jcnRjX3c7DQo+PiAtCQlzdGF0ZS0+Y3J0Y193ID0g
c3RhdGUtPmNydGNfaDsNCj4+IC0JCXN0YXRlLT5jcnRjX2ggPSB0bXA7DQo+IA0KPiBBZ2Fpbiwg
SSBndWVzcyBJIGFzc3VtZWQgLT5jcnRjX2gvdyB3ZXJlIHRoZSB3aWR0aCBhbmQgaGVpZ2h0IGJl
Zm9yZQ0KPiByb3RhdGlvbiB3aGVuIEkgaW5pdGlhbGx5IGFkZGVkIHJvdGF0aW9uIHN1cHBvcnQu
DQoNCkFuZCBJIHRob3VnaHQgc28gdG9vLCBwb3NzaWJseSBzaW5jZSBJIGhhdmUgb25seSBiZWVu
IGRvaW5nIGRybS1zdHVmZg0Kd2l0aCB0aGlzIGRyaXZlciwgYnV0IEkgYWxzbyBzdXNwZWN0IHRo
YXQgdGhlIGluY29tcGxldGVuZXNzIG9mIHRoZQ0KbGliZHJtIG1vZGV0ZXN0IHByb2dyYW0gaXMg
dG8gYmxhbWUuIEkgZG9uJ3QgdGhpbmsgaXQncyBwb3NzaWJsZSB0bw0Kc3BlY2lmeSBpbmRpdmlk
dWFsIHNyYyBhbmQgZHN0IHJlY3RhbmdsZXMgd2l0aCBpdCwgYW5kIHRoYXQgc2VlbXMNCnJhdGhl
ciBsaW1pdGluZyB3aGVuIGRlYWxpbmcgd2l0aCByb3RhdGVkIHBsYW5lcy4gSSBjYW4gZWFzaWx5
IHNlZQ0Kd2h5IHNvbWVvbmUgdXNpbmcgbW9kZXRlc3QgdGhpbmtzIHRoZSBjcnRjIHJlY3Qgc2hv
dWxkIGJlIHJvdGF0ZWQgYnkNCnRoZSBkcml2ZXIuLi4NCg0KPiBUaGlzIGNoYW5nZSBtaWdodCBi
cmVhayB1c2VycyB0b28uDQoNClJpZ2h0IHlvdSBhcmUsIGFuZCB0aGUgc2FtZSBpbXBvc3NpYmxl
IHNjZW5hcmlvLiBGaXggdGhpbmdzIHRvIGRvIHRoZQ0KcmlnaHQgdGhpbmcgYW5kIHJpc2sgYnJl
YWtpbmcgdXNlcnMsIG9yIGRvbid0IGFuZCBwcmVzZXJ2ZSB0aGUgYnVnZ3kNCm5vbi1wb3J0YWJs
ZSBpc3N1ZXMgb2YgdGhlIGRyaXZlciBtYWtpbmcgaXQgdW51c2FibGUgZm9yIG90aGVycy4NCg0K
SSBkb24ndCBjYXJlIGVpdGhlciB3YXksIGJlY2F1c2Ugcm90YXRpbmcgcGxhbmVzIHdpdGggdGhp
cyBzdHJpZGUtDQptZXRob2QgaXMgcHJhY3RpY2FsbHkgdXNlbGVzcyBoZXJlLiBJdCBzaW1wbHkg
cmVxdWlyZXMgdG8gbXVjaA0KbWVtb3J5IGJhbmR3aWR0aC4gSSBtaWdodCB3b3JrIG9rIGZvciBz
bWFsbGVyIHBhbmVscyB3aXRoIGxvd2VyDQpwaXhlbCBjbG9jayBmcmVxdWVuY2llcyB0aG91Z2g/
IEkgdGhpbmsgdGhlIExDREMgbWlnaHQgcmVhZCB0aGUgc2FtZQ0KZGF0YSBtb3JlIHRoYW4gb25j
ZSB3aGVuIGRhdGEgaXMgbm90IGluIHRoZSAibmF0dXJhbCIgb3JkZXI/IChubywNCkkgZG8gbm90
IG5lZWQgYW4gYW5zd2VyIHRvIHRoaXMgcXVlc3Rpb24sIGFuZCBJIGRvIG5vdCBoYXZlIHRpbWUg
dG8NCmRpZyBpbiB0aGlzIGFyZWEgYXQgdGhlIG1vbWVudC4uLikNCg0KSG93ZXZlciwgaWYgeW91
IGNhbid0IGRvIGJvdGggcGF0Y2ggMSBhbmQgMiAoYmVjYXVzZSB1c2VycyByZWdyZXNzKSwNCnRo
ZW4gcGF0Y2ggMyBpcyBubyBnb29kIGVpdGhlci4gVGhlIHJlYXNvbiBpcyB0aGF0DQpkcm1fYXRv
bWljX2hlbHBlcl9jaGVja19wbGFuZV9zdGF0ZSBhc3N1bWVzIHRoZSByb3RhdGlvbmFsDQpwcm9w
ZXJ0aWVzIGZpeGVkIGJ5IHBhdGNoIDEgYW5kIDIsIGFuZCB0aGUgYmVoYXZpb3IgaXMgIm9kZCIg
aWYgeW91DQpoYXZlIHRoYXQgd3JvbmcuDQoNCkNoZWVycywNClBldGVyDQoNCj4+ICAJCXRtcCA9
IHN0YXRlLT5zcmNfdzsNCj4+ICAJCXN0YXRlLT5zcmNfdyA9IHN0YXRlLT5zcmNfaDsNCj4+ICAJ
CXN0YXRlLT5zcmNfaCA9IHRtcDsNCj4gDQoNCg==
