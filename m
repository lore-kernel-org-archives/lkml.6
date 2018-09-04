Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF69C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DE92082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DE92082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=med.uni-goettingen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIDWsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:48:41 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:29242 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726507AbeIDWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:48:41 -0400
Received: from umg-exc-2.ads.local.med.uni-goettingen.de ([10.76.100.69]:24086)
        by mail1.med.uni-goettingen.de with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Uecker@med.uni-goettingen.de>)
        id 1fxFy0-0001tU-13; Tue, 04 Sep 2018 20:22:20 +0200
Received: from UMG-EXC-1.ads.local.med.uni-goettingen.de
 ([fe80::c97f:60fd:6a2d:e4b9]) by umg-exc-2.ads.local.med.uni-goettingen.de
 ([fe80::40b1:448:7be6:e2cf%13]) with mapi id 14.03.0361.001; Tue, 4 Sep 2018
 20:22:19 +0200
From:   "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To:     "dvyukov@google.com" <dvyukov@google.com>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VLAs and security
Thread-Topic: VLAs and security
Thread-Index: AQHUQpQcK6e7hvTWREaSPdTt5naSaqTdIVGAgADqgQCAAOe/gIAAlpIAgAAZzwCAAK3LAA==
Date:   Tue, 4 Sep 2018 18:22:18 +0000
Message-ID: <1536085338.17991.1.camel@med.uni-goettingen.de>
References: <1535875700.17858.3.camel@med.uni-goettingen.de>
         <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
         <1535960372.32005.1.camel@med.uni-goettingen.de>
         <CA+55aFy=T6TmG_VcLvSTb02RyKTacxVCxwUALRn8_7cdoic0pA@mail.gmail.com>
         <1536042474.25086.1.camel@med.uni-goettingen.de>
         <CACT4Y+bBPRfjpWFXoZmruuot37_KTemZ0PHUNrFfOPW5+6JD7w@mail.gmail.com>
In-Reply-To: <CACT4Y+bBPRfjpWFXoZmruuot37_KTemZ0PHUNrFfOPW5+6JD7w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <57A9123C00FF5B49B8913B7DDBC6F2E1@ads.local.med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gRGllbnN0YWcsIGRlbiAwNC4wOS4yMDE4LCAxMDowMCArMDIwMCBzY2hyaWViIERtaXRyeSBW
eXVrb3Y6DQo+IE9uIFR1ZSwgU2VwIDQsIDIwMTggYXQgODoyNyBBTSwgVWVja2VyLCBNYXJ0aW4N
Cj4gPE1hcnRpbi5VZWNrZXJAbWVkLnVuaS1nb2V0dGluZ2VuLmRlPiB3cm90ZToNCj4gPiBBbSBN
b250YWcsIGRlbiAwMy4wOS4yMDE4LCAxNDoyOCAtMDcwMCBzY2hyaWViIExpbnVzIFRvcnZhbGRz
Og0KDQoNCkhpIERtaXRyeSwNCg0KPiBDb21waWxlciBhbmQgS0FTQU4gc2hvdWxkIHN0aWxsIGJl
IGFibGUgdG8gZG8gY2hlY2tpbmcgYWdhaW5zdCB0aGUNCj4gc3RhdGljIGFycmF5IHNpemUuDQoN
Ci4uLmFuZCBpdCBpcyBwcm9iYWJseSB0cnVlIHRoYXQgdGhpcyBpcyBjdXJyZW50bHkgbW9yZSB1
c2VmdWwNCnRoYW4gdGhlIGxpbWl0ZWQgYW1vdW50IG9mIGNoZWNraW5nIGNvbXBpbGVycyBjYW4g
ZG8gZm9yIFZMQXMuDQoNCj4gSWYgeW91IG1lYW4gdGhhdCB0aGVyZSBpcyBzb21lIHNtYWxsZXIg
ZHluYW1pYyBsb2dpY2FsIGJvdW5kIG4gKDxOKQ0KPiBhbmQgd2UgYXJlIG5vdCBzdXBwb3NlZCB0
byB1c2UgbWVtb3J5IGJleW9uZCB0aGF0LCANCg0KWWVzLCB0aGlzIGlzIHdoYXQgSSBtZWFuLsKg
DQoNCk15IGNvbmNlcm4gaXMgdGhhdCB0aGlzIGR5bmFtaWMgYm91bmQgaXMgdmFsdWFibGUgaW5m
b3JtYXRpb24NCndoaWNoIHdhcyBwdXQgdGhlcmUgYnkgcHJvZ3JhbW1lcnMgYnkgaGFuZCBhbmQg
SSBiZWxpZXZlIHRoYXQNCnRoaXMgaW5mb3JtYXRpb24gY2FuIG5vdCBhbHdheXMgYmUgcmVjb3Zl
cmVkIGF1dG9tYXRpY2FsbHkNCmJ5IHN0YXRpYyBhbmFseXNpcy4gU28gYnkgcmVtb3ZpbmcgVkxB
cyBmcm9tIHRoZSBzb3VyY2UgdHJlZSwNCnRoaXMgaW5mb3JtYXRpb24gaXN0IGxvc3QuDQoNCj4g
dGhlbiBLTVNBTiBbMV0gY2FuDQo+IGRldGVjdCB1c2VzIG9mIHRoZSB1bmluaXRpYWxpemVkIHBh
cnQgb2YgdGhlIGFycmF5LiBTbyB3ZSBoYXZlIHNvbWUNCj4gY292ZXJhZ2Ugb24gdGhlIGNoZWNr
aW5nIHNpZGUgdG9vLg0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUva21zYW4j
a21zYW4ta2VybmVsbWVtb3J5c2FuaXRpemVyDQoNCkJ1dCBkZXRlY3RpbmcgcmVhZHMgb2YgdW5p
bml0aWFsaXplZCBwYXJ0cyBjYW4gZGV0ZWN0IG9ubHkgc29tZQ0Kb2YgdGhlIGVycm9ycyB3aGlj
aCBjb3VsZCBiZSBkZXRlY3RlZCB3aXRoIHByZWNpc2UgYm91bmRzLg0KSXQgY2FuIG5vdCBkZXRl
Y3Qgb3V0LW9mLWJvdW5kcyB3cml0ZXMgKHdoaWNoIHN0aWxsIGZhbGwgaW50bw0KdGhlIGxhcmdl
ciBmaXhlZC1zaXplIGFycmF5KSBhbmQgaXQgZG9lcyBub3QgZGV0ZWN0IG91dC1vZi1ib3VuZHMN
CnJlYWRzICh3aGljaCBzdGlsbCBmYWxsIGludG8gdGhlIGxhcmdlciBmaXhlZC1zaXplIGFycmF5
KSBpZg0KdGhlIGxhcmdlciBmaXhlZC1zaXplIGFycmF5wqB3YXMgY29tcGxldGVseSBpbml0aWFs
aXplZA0KYmVmb3JlIGZvciBzb21lIHJlYXNvbi4NCg0KTWFydGluDQoNCg==
