Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF30C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A456A2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A456A2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=med.uni-goettingen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeIBM24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 08:28:56 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:32141 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbeIBM24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 08:28:56 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Sep 2018 08:28:55 EDT
Received: from umg-exc-2.ads.local.med.uni-goettingen.de ([10.76.100.69]:54915)
        by mail1.med.uni-goettingen.de with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Uecker@med.uni-goettingen.de>)
        id 1fwNQj-0000WD-37; Sun, 02 Sep 2018 10:08:21 +0200
Received: from UMG-EXC-1.ads.local.med.uni-goettingen.de
 ([fe80::c97f:60fd:6a2d:e4b9]) by umg-exc-2.ads.local.med.uni-goettingen.de
 ([fe80::40b1:448:7be6:e2cf%13]) with mapi id 14.03.0361.001; Sun, 2 Sep 2018
 10:08:21 +0200
From:   "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: VLAs and security
Thread-Topic: VLAs and security
Thread-Index: AQHUQpQcK6e7hvTWREaSPdTt5naSag==
Date:   Sun, 2 Sep 2018 08:08:20 +0000
Message-ID: <1535875700.17858.3.camel@med.uni-goettingen.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B66DC01D551F924FB89102F3B0457007@ads.local.med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpJIGRvIG5vdCBhZ3JlZSB0aGF0IFZMQXMgYXJlIGdlbmVyYWxseSBiYWQgZm9yIHNlY3VyaXR5
Lg0KSSB0aGluayB0aGUgb3Bwb3NpdGUgaXMgdHJ1ZS4gQSBWTEEgd2l0aCB0aGUgcmlnaHQgc2l6
ZQ0KYWxsb3dzIHRoZSBjb21waWxlciB0byBhdXRvbWF0aWNhbGx5IHBlcmZvcm0gb3IgaW5zZXJ0
DQptZWFuaW5nZnVsIGJvdW5kcyBjaGVja3MsIHdoaWxlIGEgZml4ZWQgdXBwZXIgYm91bmQgZG9l
cyBub3QuDQoNCg0KRm9yIGV4YW1wbGU6DQoNCmNoYXIgYnVmW05dOw0KYnVmW25dID0gMTsNCg0K
SGVyZSwgYSBjb21waWxlciAvIGFuYWx5c2lzIHRvb2wgY2FuIGZvciAgbiA8IE4gIHVzaW5nDQpz
dGF0aWMgYW5hbHlzaXMgb3IgaW5zZXJ0IGEgcnVuLXRpbWUgY2hlY2suDQoNClJlcGxhY2luZyB0
aGlzIHdpdGgNCg0KY2hhciBidWZbTUFYX1NJWkVdDQoNCmhpZGVzIHRoZSBpbmZvcm1hdGlvbiBh
Ym91dCB0aGUgdHJ1ZSB1cHBlciBib3VuZA0KZnJvbSBhdXRvbWF0aWMgdG9vbHMuDQoNCkxpbWl0
aW5nIHRoZSBzdGFjayB1c2FnZSBjYW4gYWxzbyBiZSBhY2hpZXZlZCBpbg0KdGhlIGZvbGxvd2lu
ZyB3YXk6DQoNCmFzc2VydChOIDw9IE1BWF9TSVpFKQ0KY2hhciBidWZbTl07DQoNCg0KT2YgY291
cnNlLCBoYXZpbmcgcHJlZGljdGFibGUgc3RhY2sgdXNhZ2UgbWlnaHQgYmUgbW9yZcKgDQppbXBv
cnRhbnQgaW4gdGhlIGtlcm5lbCBhbmQgbWlnaHQgYmUgYSBnb29kIGFyZ3VtZW50DQp0byBzdGls
bCBwcmVmZXIgdGhlIGNvbnN0YW50IGJvdW5kLg0KDQpCdXQgbG9vc2luZyB0aGUgdGlnaHRlciBi
b3VuZHMgaXMgY2xlYXJseSBhIGRpc2FkdmFudGFnZQ0Kd2l0aCByZXNwZWN0IHRvIHNlY3VyaXR5
IHRoYXQgb25lIHNob3VsZCBrZWVwIGl0IG1pbmQuDQoNCg0KQmVzdCwNCk1hcnRpbg0KDQoNCg0K
