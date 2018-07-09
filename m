Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B082089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B082089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbeGIETk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:19:40 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:39773 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeGIETi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:19:38 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w694JWcX015374
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Jul 2018 13:19:32 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w694JWlj014816;
        Mon, 9 Jul 2018 13:19:32 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w694JWmG006519;
        Mon, 9 Jul 2018 13:19:32 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1831189; Mon, 9 Jul 2018 13:16:54 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Mon, 9
 Jul 2018 13:16:53 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     =?gb2312?B?9MPPocqvKM+hyq8p?= <xishi.qiuxishi@alibaba-inc.com>
CC:     linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?gb2312?B?s8LS5cir?= <zy.zhengyi@alibaba-inc.com>
Subject: =?gb2312?B?UmU6IFJlo7pbUkZDXSBhIHF1ZXN0aW9uIGFib3V0IHJldXNlIGh3cG9pc29u?=
 =?gb2312?B?IHBhZ2UgaW4gc29mdF9vZmZsaW5lX3BhZ2UoKQ==?=
Thread-Topic: =?gb2312?B?UmWjultSRkNdIGEgcXVlc3Rpb24gYWJvdXQgcmV1c2UgaHdwb2lzb24gcGFn?=
 =?gb2312?B?ZSBpbiBzb2Z0X29mZmxpbmVfcGFnZSgp?=
Thread-Index: AQHUFyzyen5req9zq0m4Y5pdL5T/YqSFshiA
Date:   Mon, 9 Jul 2018 04:16:52 +0000
Message-ID: <20180709041651.GA19949@hori1.linux.bs1.fc.nec.co.jp>
References: <95e5634d-f78f-45bb-9847-1eb5bbdac3cf.xishi.qiuxishi@alibaba-inc.com>
In-Reply-To: <95e5634d-f78f-45bb-9847-1eb5bbdac3cf.xishi.qiuxishi@alibaba-inc.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.81]
Content-Type: text/plain; charset="gb2312"
Content-ID: <296F04ED85E0D64FA875F495F431D34B@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMDksIDIwMTggYXQgMTA6MzE6MjVBTSArMDgwMCwg9MPPocqvKM+hyq8pIHdy
b3RlOg0KPiBIaSBOYW95YSwNCj4gDQo+IEkgdGhpbmsgdGhlIGRvdWJsZSBjaGVjayBjYW4gbm90
IGZpeCB0aGUgcHJvYmxlbSBhcyBJIHNhaWQgaW4gYW5vdGhlciBlbWFpbC4NCj4gSWYgc29tZW9u
ZSBtbWFwIGJlZm9yZSBzb2Z0IG9mZmxpbmUsIHNvIHRoZSBwYWdlX2NvdW50KGhlYWQpIGlzIHN0
aWxsIHplcm8NCj4gaW4gc29mdCBvZmZsaW5lLCB0aGVuIGh3cG9pc29uIGZsYWcgc2V0IGFuZCBp
dCBjYW4gbm90IGJlIGFsbG9jZWQgYWdhaW4gaW4NCj4gZGVxdWV1ZV9odWdlX3BhZ2Vfbm9kZV9l
eGFjdCgpIGR1cmluZyBwYWdlIGZhdWx0LCBzbyBwYWdlIGZhdWx0IHJldHVybg0KPiBuby1tZW0s
IGFuZCBzb21lb25lIHdpbGwgYmUga2lsbGVkIChub3QgbWNlIGtpbGwpLg0KPiANCj4gSG93IGFi
b3V0IGp1c3Qgc2V0IGh3cG9pc29uIGZsYWcgYWZ0ZXIgc29mdF9vZmZsaW5lX2ZyZWVfcGFnZSAt
IA0KPiBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZQ0KPiBzdWNjZXNzZnVsbHk/IEl0IHdpbGwgZml4
IHRoZSBib3RoIHR3byBwcm9ibGVtcyAobWNlIGtpbGwgYW5kIG5vLW1lbSBraWxsKS4NCg0KVGhh
bmsgeW91IGZvciBlbGFib3JhdGluZywgeW91J3JlIHJpZ2h0Lg0KU28gZG8geW91IGxpa2UgYSBm
aXggbGlrZSB0aGlzPw0KDQotLS0NCmRpZmYgLS1naXQgYS9tbS9odWdldGxiLmMgYi9tbS9odWdl
dGxiLmMNCmluZGV4IGQzNDIyNWMxY2I1Yi4uM2M5Y2U0YzA1ZjFiIDEwMDY0NA0KLS0tIGEvbW0v
aHVnZXRsYi5jDQorKysgYi9tbS9odWdldGxiLmMNCkBAIC0xNDc5LDIyICsxNDc5LDIwIEBAIHN0
YXRpYyBpbnQgZnJlZV9wb29sX2h1Z2VfcGFnZShzdHJ1Y3QgaHN0YXRlICpoLCBub2RlbWFza190
ICpub2Rlc19hbGxvd2VkLA0KIC8qDQogICogRGlzc29sdmUgYSBnaXZlbiBmcmVlIGh1Z2VwYWdl
IGludG8gZnJlZSBidWRkeSBwYWdlcy4gVGhpcyBmdW5jdGlvbiBkb2VzDQogICogbm90aGluZyBm
b3IgaW4tdXNlIChpbmNsdWRpbmcgc3VycGx1cykgaHVnZXBhZ2VzLiBSZXR1cm5zIC1FQlVTWSBp
ZiB0aGUNCi0gKiBudW1iZXIgb2YgZnJlZSBodWdlcGFnZXMgd291bGQgYmUgcmVkdWNlZCBiZWxv
dyB0aGUgbnVtYmVyIG9mIHJlc2VydmVkDQotICogaHVnZXBhZ2VzLg0KKyAqIGRpc3NvbHV0aW9u
IGZhaWxzIGJlY2F1c2UgYSBnaXZlIHBhZ2UgaXMgbm90IGEgZnJlZSBodWdlcGFnZSwgb3IgYmVj
YXVzZQ0KKyAqIGZyZWUgaHVnZXBhZ2VzIGFyZSBmdWxseSByZXNlcnZlZC4NCiAgKi8NCiBpbnQg
ZGlzc29sdmVfZnJlZV9odWdlX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQogew0KLQlpbnQgcmMg
PSAwOw0KKwlpbnQgcmMgPSAtRUJVU1k7DQogDQogCXNwaW5fbG9jaygmaHVnZXRsYl9sb2NrKTsN
CiAJaWYgKFBhZ2VIdWdlKHBhZ2UpICYmICFwYWdlX2NvdW50KHBhZ2UpKSB7DQogCQlzdHJ1Y3Qg
cGFnZSAqaGVhZCA9IGNvbXBvdW5kX2hlYWQocGFnZSk7DQogCQlzdHJ1Y3QgaHN0YXRlICpoID0g
cGFnZV9oc3RhdGUoaGVhZCk7DQogCQlpbnQgbmlkID0gcGFnZV90b19uaWQoaGVhZCk7DQotCQlp
ZiAoaC0+ZnJlZV9odWdlX3BhZ2VzIC0gaC0+cmVzdl9odWdlX3BhZ2VzID09IDApIHsNCi0JCQly
YyA9IC1FQlVTWTsNCisJCWlmIChoLT5mcmVlX2h1Z2VfcGFnZXMgLSBoLT5yZXN2X2h1Z2VfcGFn
ZXMgPT0gMCkNCiAJCQlnb3RvIG91dDsNCi0JCX0NCiAJCS8qDQogCQkgKiBNb3ZlIFBhZ2VIV1Bv
aXNvbiBmbGFnIGZyb20gaGVhZCBwYWdlIHRvIHRoZSByYXcgZXJyb3IgcGFnZSwNCiAJCSAqIHdo
aWNoIG1ha2VzIGFueSBzdWJwYWdlcyByYXRoZXIgdGhhbiB0aGUgZXJyb3IgcGFnZSByZXVzYWJs
ZS4NCkBAIC0xNTA4LDYgKzE1MDYsNyBAQCBpbnQgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2Uoc3Ry
dWN0IHBhZ2UgKnBhZ2UpDQogCQloLT5mcmVlX2h1Z2VfcGFnZXNfbm9kZVtuaWRdLS07DQogCQlo
LT5tYXhfaHVnZV9wYWdlcy0tOw0KIAkJdXBkYXRlX2FuZF9mcmVlX3BhZ2UoaCwgaGVhZCk7DQor
CQlyYyA9IDA7DQogCX0NCiBvdXQ6DQogCXNwaW5fdW5sb2NrKCZodWdldGxiX2xvY2spOw0KZGlm
ZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQppbmRl
eCA5ZDE0MmI5Yjg2ZGMuLmU0YzdlM2VjN2IxMCAxMDA2NDQNCi0tLSBhL21tL21lbW9yeS1mYWls
dXJlLmMNCisrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCkBAIC0xNzE1LDEzICsxNzE1LDEzIEBA
IHN0YXRpYyBpbnQgc29mdF9vZmZsaW5lX2luX3VzZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBp
bnQgZmxhZ3MpDQogDQogc3RhdGljIHZvaWQgc29mdF9vZmZsaW5lX2ZyZWVfcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSkNCiB7DQorCWludCByYyA9IDA7DQogCXN0cnVjdCBwYWdlICpoZWFkID0gY29t
cG91bmRfaGVhZChwYWdlKTsNCiANCi0JaWYgKCFUZXN0U2V0UGFnZUhXUG9pc29uKGhlYWQpKSB7
DQorCWlmIChQYWdlSHVnZShoZWFkKSkNCisJCXJjID0gZGlzc29sdmVfZnJlZV9odWdlX3BhZ2Uo
cGFnZSk7DQorCWlmICghcmMgJiYgIVRlc3RTZXRQYWdlSFdQb2lzb24oaGVhZCkpDQogCQludW1f
cG9pc29uZWRfcGFnZXNfaW5jKCk7DQotCQlpZiAoUGFnZUh1Z2UoaGVhZCkpDQotCQkJZGlzc29s
dmVfZnJlZV9odWdlX3BhZ2UocGFnZSk7DQotCX0NCiB9DQogDQogLyoqDQo=

