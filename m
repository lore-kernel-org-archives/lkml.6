Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E99C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1FB20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1FB20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pku.edu.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI2UHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:07:42 -0400
Received: from mx9.pku.edu.cn ([162.105.129.172]:34414 "EHLO pku.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbeI2UHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:07:41 -0400
X-Greylist: delayed 1249 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Sep 2018 16:07:41 EDT
Received: by ajax-webmail-mailfront03 (Coremail) ; Sat, 29 Sep 2018 21:18:22
 +0800 (GMT+08:00)
X-Originating-IP: [203.187.182.140]
Date:   Sat, 29 Sep 2018 21:18:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Guan Xuetao" <gxt@pku.edu.cn>
To:     "eric w. biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [REVIEW][PATCH 0/3] signal/unicore32: siginfo cleanups
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.7b build 20180509(9e2321e9)
 Copyright (c) 2002-2018 www.mailtech.cn pku
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4d6cc3dd.4ed8.166257ae39a.Coremail.gxt@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 84FpogCHw6yfe69bqs+3AA--.27259W
X-CM-SenderInfo: qqqqliixuslio6sn3hxhgxhubq/1tbiAQEDB1Py8HKG7gACsN
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXJpYywKCkknbGwgcmV2aWV3IGFuZCBjaGVjayB0aGUgcGF0Y2hlcyBhZnRlciBjaGluZXNl
IG5hdGlvbmFsIGRheSB2b2NhdGlvbi4KClRoYW5rcy4KCkd1YW4gWHVldGFvCgo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZXMtLS0tLQo+IEZyb206ICJFcmljIFcuIEJpZWRlcm1hbiIgPGViaWVkZXJt
QHhtaXNzaW9uLmNvbT4KPiBTZW50IFRpbWU6IDIwMTgtMDktMjQgMjM6MjM6MzUgKE1vbmRheSkK
PiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1hcmNoQHZnZXIu
a2VybmVsLm9yZywgIkd1YW4gWHVldGFvIiA8Z3h0QHBrdS5lZHUuY24+Cj4gU3ViamVjdDogW1JF
VklFV11bUEFUQ0ggMC8zXSBzaWduYWwvdW5pY29yZTMyOiBzaWdpbmZvIGNsZWFudXBzCj4gCj4g
Cj4gSSBoYXZlIGJlZW4gc2xvd2x5IGNsZWFuaW5nIHVwIHRoZSBhcmNoaXRlY3R1ZXMgZXZlciBz
aW5jZSBJIGRpc2NvdmVyZWQKPiB0aGF0IHRoZSBwYXR0ZXJuIG9mIHBhc3NpbmcgaW4gc3RydWN0
IHNpZ2luZm8gaXMgZXJyb3IgcHJvbmUsIGFuZAo+IG9jY2Fzc2lvbmFsbHkgcmVzdWx0cyBpbiBi
cm9rZW4gc2lnaW5mbyBiZWluZyBzZW50IHRvIHVzZXJzcGFjZS4KPiAKPiBJIGRvbid0IGhhdmUg
YSBjbHVlIGhvdyB0byBvYnRhaW4gYSB3b3JraW5nIHVuaWNvcmUzMiBjb21waWxlciBzbyB0aGUK
PiBmb2xsb3dpbmcgY2hhbmdlcyBoYXZlIG9ubHkgYmVlbiByZXZpZXdlZCBjYXJlZnVsbHkgYW5k
IG5vdCBjb21waWxlCj4gdGVzdGVkLiAgU3RpbGwgSSBiZWxpZXZlIHRoZXkgYXJlIHNpbXBsZSBh
bmQgb2J2aW91c2x5IGNvcnJlY3QuCj4gCj4gQW55b25lIHdobyBjYW4gcmV2aWV3IG9yIHRlc3Qg
dGhlc2UgY2hhbmdlcyBwbGVhc2UgZG8gYW5kIGxldCBtZSBrbm93Cj4gYWJvdXQgYW55IHByb2Js
ZW1zIHlvdSBmaW5kIHNvIHRoYXQgSSBjYW4gY29ycmVjdCB0aGVtLgo+IAo+IE15IGludGVudGlv
biBpcyB0byBtZXJnZSB0aGlzIHRocm91Z2ggbXkgc2lnaW5mbyB0cmVlLiAgSWYgeW91IGZlZWwg
aXQKPiBzaG91bGQgZ28gdGhyb3VnaCB5b3VyIGFyY2ggdHJlZSBsZXQgbWUga25vdy4gICBBbGwg
b2YgdGhlIHByZXJlcXVpc2l0ZXMKPiBzaG91bGQgaGF2ZSBiZWVuIG1lcmdlZCBzZXZlcmFsIHJl
bGVhc2VzIGFnby4KPiAKPiBFcmljIFcuIEJpZWRlcm1hbiAoMyk6Cj4gICAgICAgc2lnbmFsL3Vu
aWNvcmUzMjogVXNlIHNlbmRfc2lnX2ZhdWx0IHdoZXJlIGFwcHJvcHJpYXRlCj4gICAgICAgc2ln
bmFsL3VuaWNvcmUzMjogR2VuZXJhdGUgc2lnaW5mbyBpbiB1Y3MzMl9ub3RpZnlfZGllCj4gICAg
ICAgc2lnbmFsL3VuaWNvcmUzMjogVXNlIGZvcmNlX3NpZ19mYXVsdCB3aGVyZSBhcHByb3ByaWF0
ZQo+IAo+ICBhcmNoL3VuaWNvcmUzMi9pbmNsdWRlL2FzbS9idWcuaCAgfCAgMyArKy0KPiAgYXJj
aC91bmljb3JlMzIva2VybmVsL2ZwdS11Y2Y2NC5jIHwgMTIgKysrLS0tLS0tLS0tCj4gIGFyY2gv
dW5pY29yZTMyL2tlcm5lbC90cmFwcy5jICAgICB8ICA1ICsrKy0tCj4gIGFyY2gvdW5pY29yZTMy
L21tL2ZhdWx0LmMgICAgICAgICB8IDI3ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQo+IAo+IEVy
aWMK
