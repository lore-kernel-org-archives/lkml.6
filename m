Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BF8218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeL2EP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:15:58 -0500
Received: from app1.whu.edu.cn ([202.114.64.88]:59308 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbeL2EP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 23:15:58 -0500
Received: by ajax-webmail-email1 (Coremail) ; Sat, 29 Dec 2018 11:11:46
 +0800 (GMT+08:00)
X-Originating-IP: [114.255.3.133]
Date:   Sat, 29 Dec 2018 11:11:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?546L6bmP?= <rocking@whu.edu.cn>
To:     "andrew morton" <akpm@linux-foundation.org>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        ynorov@caviumnetworks.com, arnd@arndb.de, courbet@google.com,
        osandov@fb.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] bitmap: Add bitmap_valloc(), bitmap_vzalloc() and
 bitmap_vfree()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.7 dev build
 20170822(baf61abd) Copyright (c) 2002-2018 www.mailtech.cn whu
In-Reply-To: <20181228154137.c161e699e2293a07458580d3@linux-foundation.org>
References: <20181227161829.32177-1-rocking@whu.edu.cn>
 <20181228154137.c161e699e2293a07458580d3@linux-foundation.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4d8c67f0.108f13.167f7f23a8a.Coremail.rocking@whu.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQBjCgC3vGDz5SZcvaCaCQ--.62072W
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/1tbiAQMOCFmj35VwigAAsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRGF0ZTogRnJpLCAyOCBEZWMgMjAxOCAxNTo0MTozNyAtMDgwMCBBbmRyZXcgTW9ydG9uIDxh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToKCj4gRnJvbTogIkFuZHJldyBNb3J0b24i
IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgo+IFNlbnQgVGltZTogMjAxOC0xMi0yOSAwNzo0
MTozNyAoU2F0dXJkYXkpCj4gVG86ICJQZW5nIFdhbmciIDxyb2NraW5nQHdodS5lZHUuY24+Cj4g
Q2M6IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbSwgbGludXhAcmFzbXVzdmlsbGVt
b2VzLmRrLCB5bm9yb3ZAY2F2aXVtbmV0d29ya3MuY29tLCBhcm5kQGFybmRiLmRlLCBjb3VyYmV0
QGdvb2dsZS5jb20sIG9zYW5kb3ZAZmIuY29tLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYml0bWFwOiBBZGQgYml0bWFwX3ZhbGxvYygpLCBiaXRt
YXBfdnphbGxvYygpIGFuZCBiaXRtYXBfdmZyZWUoKQo+IAo+IE9uIEZyaSwgMjggRGVjIDIwMTgg
MDA6MTg6MjkgKzA4MDAgUGVuZyBXYW5nIDxyb2NraW5nQHdodS5lZHUuY24+IHdyb3RlOgo+IAo+
ID4gSW50cm9kdWNlIGJpdG1hcCBhbGxvYy9mcmVlIGhlbHBlcnMgd2hlbiBjb250aWd1b3VzCj4g
PiBtZW1vcnkgaXMgbm90IG5lY2Vzc2FyeS4KPiAKPiBUaGF0J3MgYSBsYXJnZSBiaXRtYXAgeW91
IGhhdmUgdGhlcmUuICBXaGF0IGNvZGUgbmVlZHMgdGhpcz8KCkhpIEFuZHJldywKTm90IG9ubHkg
Zm9yIGxhcmdlIGJpdG1hcC4gVGhpcyBjYW4gYWxzbyBiZW5lZml0IGZyb20gaGlnaCBtZW1vcnkg
cHJlc3N1cmUgd2l0aCBubyByZXF1aXJlbWVudCBmb3IgcGh5c2ljYWwgY29udGludW91c25lc3Mu
CgpXaGlsZSB0aGVzZSB0d28gY2FzZWVzIGFyZSByYXRoZXIgcmFyZS4gQW5kIEkgb25seSBmaW5k
IG9uZSBwbGFjZSBpbiBtbS9zd2FwZmlsZS5jLgoKMzIyNCAgICAgICAgIC8qIGZyb250c3dhcCBl
bmFibGVkPyBzZXQgdXAgYml0LXBlci1wYWdlIG1hcCBmb3IgZnJvbnRzd2FwICovCjMyMjUgICAg
ICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfRlJPTlRTV0FQKSkKMzIyNiAgICAgICAgICAgICAg
ICAgZnJvbnRzd2FwX21hcCA9IGt2Y2FsbG9jKEJJVFNfVE9fTE9OR1MobWF4cGFnZXMpLAozMjI3
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKGxvbmcpLAoz
MjI4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7
CgpJIGFtIG5vdCBzdXJlIHdoZXRoZXIgdGhlc2UgaGVscGVyIGZ1bmN0aW9ucyBjYW4gZ2FpbiBh
cyBtdWNoIGJlbmVmaXRzIGFzIHRoZSBlZmZvcnRzIHRvIGludHJvZHVjZSB0aGVtLgoKQ2hlZXJz
LApQZW5n
