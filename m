Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE7C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E4C2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfACHzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:55:09 -0500
Received: from mail4.tencent.com ([183.57.53.109]:58309 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfACHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:55:08 -0500
X-Greylist: delayed 695 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 02:55:06 EST
Received: from EXHUB-SZMail03.tencent.com (unknown [10.14.6.33])
        by mail4.tencent.com (Postfix) with ESMTP id AE77651937;
        Thu,  3 Jan 2019 15:43:18 +0800 (CST)
Received: from EXMBX-SZMAIL006.tencent.com ([fe80::79d2:3448:1596:46df]) by
 EXHUB-SZMail03.tencent.com ([::1]) with mapi id 14.03.0415.000; Thu, 3 Jan
 2019 15:43:17 +0800
From:   "xiaoguangrong(Xiao Guangrong)" <xiaoguangrong@tencent.com>
To:     Kees Cook <keescook@chromium.org>,
        "yulei.kernel@gmail.com" <yulei.kernel@gmail.com>,
        Stefani Seibold <stefani@seibold.net>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC:     "mkelly@xevo.com" <mkelly@xevo.com>, Jiri Kosina <jkosina@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        =?gb2312?B?eXVsZWl4emhhbmco1cXT/sDaKQ==?= <yuleixzhang@tencent.com>
Subject: Re: [PATCH] kfifo: add memory barrier in kfifo to prevent data loss
Thread-Topic: [PATCH] kfifo: add memory barrier in kfifo to prevent data loss
Thread-Index: AQHUozf33AH3O8/3KkWVpzcIpc/egQ==
Date:   Thu, 3 Jan 2019 07:43:10 +0000
Message-ID: <019819C6E743904A88B43F7DDEED99BBA7E74E37@EXMBX-SZMAIL006.tencent.com>
References: <20181211034032.32338-1-yuleixzhang@tencent.com>
 <CAGXu5jKkqf-9ksvNTCS5xgB_JtfvCc=Eot2uWYYP8rpoKLw=mg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.36.108]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTIvMTggODo1MCBBTSwgS2VlcyBDb29rIHdyb3RlOgo+IE9uIE1vbiwgRGVjIDEwLCAy
MDE4IGF0IDc6NDEgUE0gPHl1bGVpLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBGcm9t
OiBZdWxlaSBaaGFuZyA8eXVsZWl4emhhbmdAdGVuY2VudC5jb20+Cj4+Cj4+IEVhcmx5IHRoaXMg
eWVhciB3ZSBzcG90IHRoZXJlIG1heSBiZSB0d28gaXNzdWVzIGluIGtlcm5lbAo+PiBrZmlmby4K
Pj4KPj4gT25lIGlzIHJlcG9ydGVkIGJ5IFhpYW8gR3Vhbmdyb25nIHRvIGxpbnV4IGtlcm5lbC4K
Pj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvNS8xMS81OAo+PiBJbiBjdXJyZW50IGtmaWZv
IGltcGxlbWVudGF0aW9uIHRoZXJlIGFyZSBtaXNzaW5nIG1lbW9yeQo+PiBiYXJyaWVyIGluIHRo
ZSByZWFkIHNpZGUsIHNvIHRoYXQgd2l0aG91dCBwcm9wZXIgYmFycmllcgo+PiBiZXR3ZWVuIHJl
YWRpbmcgdGhlIGtmaWZvLT5pbiBhbmQgZmV0Y2hpbmcgdGhlIGRhdGEgdGhlcmUKPj4gaXMgcG90
ZW50aWFsIG9yZGVyaW5nIGlzc3VlLgo+Pgo+PiBCZXNpZGUgdGhhdCwgdGhlcmUgaXMgYW5vdGhl
ciBwb3RlbnRpYWwgaXNzdWUgaW4ga2ZpZm8sCj4+IHBsZWFzZSBjb25zaWRlciB0aGUgZm9sbG93
aW5nIGNhc2U6Cj4+IGF0IHRoZSBiZWdpbm5pbmcKPj4gcmluZy0+c2l6ZSA9IDQKPj4gcmluZy0+
b3V0ID0gMAo+PiByaW5nLT5pbiA9IDQKPj4KPj4gICAgICBDb25zdW1lciAgICAgICAgICAgICAg
ICAgICAgICAgIFByb2R1Y2VyCj4+IC0tLS0tLS0tLS0tLS0tLSAgICAgICAgICAgICAgICAgIC0t
LS0tLS0tLS0tLS0tCj4+IGluZGV4ID0gcmluZy0+b3V0OyAvKiBpbmRleCA9PSAwICovCj4+IHJp
bmctPm91dCsrOyAvKiByaW5nLT5vdXQgPT0gMSAqLwo+PiA8IFJlLU9yZGVyID4KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG91dCA9IHJpbmctPm91dDsKPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyaW5nLT5pbiAtIG91dCA+PSByaW5nLT5tYXNr
KQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZVTEw7
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBzZWUgdGhlIHJpbmcgaXMg
bm90IGZ1bGwgKi8KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZGV4ID0g
cmluZy0+aW4gJiByaW5nLT5tYXNrOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyogaW5kZXggPT0gMCAqLwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmluZy0+ZGF0YVtpbmRleF0gPSBuZXdfZGF0YTsKPj4goaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGh
oaGhoaGhoaEgcmluZy0+aW4rKzsKPj4KPj4gZGF0YSA9IHJpbmctPmRhdGFbaW5kZXhdOwo+PiAv
KiB5b3Ugd2lsbCBmaW5kIHRoZSBvbGQgZGF0YSBpcyBvdmVyd3JpdHRlbiBieSB0aGUgbmV3X2Rh
dGEgKi8KPj4KPj4gSW4gb3JkZXIgdG8gYXZvaWQgdGhlIGlzc3VlOgo+PiAxKSBmb3IgdGhlIGNv
bnN1bWVyLCB3ZSBzaG91bGQgcmVhZCB0aGUgcmluZy0+ZGF0YVtdIG91dCBiZWZvcmUKPj4gdXBk
YXRpbmcgcmluZy0+b3V0Cj4+IDIpIGZvciB0aGUgcHJvZHVjZXIsIHdlIHNob3VsZCByZWFkIHJp
bmctPm91dCBiZWZvcmUgdXBkYXRpbmcKPj4gcmluZy0+ZGF0YVtdCj4+Cj4+IFNvIGluIHRoaXMg
cGF0Y2ggd2UgaW50cm9kdWNlIHRoZSBmb2xsb3dpbmcgZm91ciBmdW5jdGlvbnMgd2hpY2gKPj4g
YXJlIHdyYXBwZWQgd2l0aCBwcm9wZXIgbWVtb3J5IGJhcnJpZXIgYW5kIGtlZXAgaW4gcGFpcnMg
dG8gbWFrZQo+PiBzdXJlIHRoZSBpbiBhbmQgb3V0IGluZGV4IGFyZSBmZXRjaGVkIGFuZCB1cGRh
dGVkIGluIG9yZGVyIHRvIGF2b2lkCj4+IGRhdGEgbG9zcy4KPj4KPj4ga2ZpZm9fcmVhZF9pbmRl
eF9pbigpCj4+IGtmaWZvX3dyaXRlX2luZGV4X2luKCkKPj4ga2ZpZm9fcmVhZF9pbmRleF9vdXQo
KQo+PiBrZmlmb193cml0ZV9pbmRleF9vdXQoKQo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBZdWxlaSBa
aGFuZyA8eXVsZWl4emhhbmdAdGVuY2VudC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEd1YW5ncm9u
ZyBYaWFvIDx4aWFvZ3Vhbmdyb25nQHRlbmNlbnQuY29tPgo+IAo+IEkndmUgYWRkZWQgc29tZSBt
b3JlIHBlb3BsZSB0byBDQyB0aGF0IG1pZ2h0IHdhbnQgdG8gc2VlIHRoaXMuIFRoYW5rcwo+IGZv
ciBzZW5kaW5nIHRoaXMhCgpIaSwKClBpbmcuLi4gY291bGQgYW55b25lIGhhdmUgYSBsb29rPyA7
KQoKVGhhbmtzIQoK
