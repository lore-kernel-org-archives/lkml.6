Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE6D2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBKELt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:11:49 -0500
Received: from mx22.baidu.com ([220.181.50.185]:45091 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfBKELt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:11:49 -0500
X-Greylist: delayed 950 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2019 23:11:47 EST
Received: from M1-MAIL-EX15.internal.baidu.com (unknown [10.44.89.55])
        by Forcepoint Email with ESMTPS id 513E0BE7A2C55;
        Mon, 11 Feb 2019 11:55:53 +0800 (CST)
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 M1-MAIL-EX15.internal.baidu.com (10.44.89.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Mon, 11 Feb 2019 11:55:53 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Mon, 11 Feb 2019 11:55:53 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBYQXJyYXkgdGVzdHM6IGFsbG9jYXRpb24gaGFzIHRv?=
 =?gb2312?B?IGJlIEdGUF9BVE9NSUMgdW5kZXIgcmN1X3JlYWRfbG9jaw==?=
Thread-Topic: [PATCH] XArray tests: allocation has to be GFP_ATOMIC under
 rcu_read_lock
Thread-Index: AQHUu03La+ynpw9zA0OEKWhqTSnm6aXaA/Vw
Date:   Mon, 11 Feb 2019 03:55:53 +0000
Message-ID: <0626e4dd96a345b6bf5b12c7e7b1319d@baidu.com>
References: <1548760122-13000-1-git-send-email-lirongqing@baidu.com>
 <20190202231944.GB13285@bombadil.infradead.org>
In-Reply-To: <20190202231944.GB13285@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.150.71]
x-baidu-bdmsfe-datecheck: 1_M1-MAIL-EX15_2019-02-11 11:55:54:106
x-baidu-bdmsfe-viruscheck: M1-MAIL-EX15_GRAY_Inside_WithoutAtta_2019-02-11
 11:55:54:091
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogTWF0dGhldyBXaWxjb3ggW21haWx0
bzp3aWxseUBpbmZyYWRlYWQub3JnXQ0KPiC3osvNyrG85DogMjAxOcTqMtTCM8jVIDc6MjANCj4g
ytW8/sjLOiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ILOty806IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g1vfM4jogUmU6IFtQQVRDSF0gWEFycmF5IHRlc3Rz
OiBhbGxvY2F0aW9uIGhhcyB0byBiZSBHRlBfQVRPTUlDIHVuZGVyDQo+IHJjdV9yZWFkX2xvY2sN
Cj4gDQo+IE9uIFR1ZSwgSmFuIDI5LCAyMDE5IGF0IDA3OjA4OjQyUE0gKzA4MDAsIExpIFJvbmdR
aW5nIHdyb3RlOg0KPiA+IC0JWEFfQlVHX09OKHhhLCB4YV9zdG9yZV9pbmRleCh4YSwgMSwgR0ZQ
X0tFUk5FTCkgIT0gTlVMTCk7DQo+ID4gKwlYQV9CVUdfT04oeGEsIHhhX3N0b3JlX2luZGV4KHhh
LCAxLCBHRlBfQVRPTUlDKSAhPSBOVUxMKTsNCj4gDQo+IERpZCB5b3UgdHJ5IHJ1bm5pbmcgdGhp
cyBjaGFuZ2UgaW4gdXNlcnNwYWNlIHRvbz8gIEkgZG9uJ3QgdGhpbmsgaXQnbGwgd29yay4NCj4g
DQo+IEkgdGhpbmsgdGhlIHJpZ2h0IGNoYW5nZSB3b3VsZCBiZToNCj4gDQoNCkNvdWxkIHlvdSBz
ZW5kIHRoaXMgcGF0Y2g/DQoNClRoYW5rcw0KDQotTGkgUm9uZ1FpbmcgDQoNCg0KPiArKysgYi9s
aWIvdGVzdF94YXJyYXkuYw0KPiBAQCAtMTA3LDggKzEwNywxMSBAQCBzdGF0aWMgbm9pbmxpbmUg
dm9pZCBjaGVja194YXNfcmV0cnkoc3RydWN0IHhhcnJheQ0KPiAqeGEpDQo+ICAgICAgICAgWEFf
QlVHX09OKHhhLCB4YXMueGFfbm9kZSAhPSBYQVNfUkVTVEFSVCk7DQo+ICAgICAgICAgWEFfQlVH
X09OKHhhLCB4YXNfbmV4dF9lbnRyeSgmeGFzLCBVTE9OR19NQVgpICE9DQo+IHhhX21rX3ZhbHVl
KDApKTsNCj4gICAgICAgICBYQV9CVUdfT04oeGEsIHhhcy54YV9ub2RlICE9IE5VTEwpOw0KPiAr
ICAgICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPiANCj4gICAgICAgICBYQV9CVUdfT04oeGEsIHhh
X3N0b3JlX2luZGV4KHhhLCAxLCBHRlBfS0VSTkVMKSAhPSBOVUxMKTsNCj4gKw0KPiArICAgICAg
IHJjdV9yZWFkX2xvY2soKTsNCj4gICAgICAgICBYQV9CVUdfT04oeGEsICF4YV9pc19pbnRlcm5h
bCh4YXNfcmVsb2FkKCZ4YXMpKSk7DQo+ICAgICAgICAgeGFzLnhhX25vZGUgPSBYQVNfUkVTVEFS
VDsNCj4gICAgICAgICBYQV9CVUdfT04oeGEsIHhhc19uZXh0X2VudHJ5KCZ4YXMsIFVMT05HX01B
WCkgIT0NCj4geGFfbWtfdmFsdWUoMCkpOw0KDQo=
