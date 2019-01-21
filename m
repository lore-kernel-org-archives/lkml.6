Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A8DC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA1021019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfAUOHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:07:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:50286 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbfAUOHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:07:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 06:07:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="136453147"
Received: from irsmsx153.ger.corp.intel.com ([163.33.192.75])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2019 06:07:08 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX153.ger.corp.intel.com ([169.254.9.115]) with mapi id 14.03.0415.000;
 Mon, 21 Jan 2019 14:07:05 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: RE: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Topic: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Index: AQHUrYYWOOwEuMXWwEOBiuSRPC5USKW5sWmAgAABJYCAABaWoA==
Date:   Mon, 21 Jan 2019 14:07:05 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B89908@IRSMSX102.ger.corp.intel.com>
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <20190121123836.GC47506@lakrids.cambridge.arm.com>
 <CACT4Y+Y6JNyQ+SSZXDSYVcBXZ_e1Hf3OMpoz=1eqGNhNKqYikg@mail.gmail.com>
In-Reply-To: <CACT4Y+Y6JNyQ+SSZXDSYVcBXZ_e1Hf3OMpoz=1eqGNhNKqYikg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ID4gSnVzdCB0byBjaGVjaywgaGFzIHRoaXMgYmVlbiB0ZXN0ZWQgd2l0aCBDT05GSUdfUkVGQ09V
TlRfRlVMTCBhbmQNCj4gPiBzb21ldGhpbmcgcG9raW5nIGtjb3Y/DQo+ID4NCj4gPiBHaXZlbiBs
aWIvcmVmY291bnQuYyBpcyBpbnN0cnVtZW50ZWQsIHRoZSByZWZjb3VudF8qKCkgY2FsbHMgd2ls
bA0KPiA+IHJlY3Vyc2UgYmFjayBpbnRvIHRoZSBrY292IGNvZGUuIEl0IGxvb2tzIGxpa2UgdGhh
dCdzIGZpbmUsIGdpdmVuIHRoZXNlDQo+ID4gYXJlIG9ubHkgbWFuaXB1bGF0ZWQgaW4gc2V0dXAv
dGVhcmRvd24gcGF0aHMsIGJ1dCBpdCB3b3VsZCBiZSBuaWNlIHRvIGJlDQo+ID4gc3VyZS4NCj4g
DQo+IEEgc2ltcGxlIHByb2dyYW0gdXNpbmcgS0NPViBpcyBhdmFpbGFibGUgaGVyZToNCj4gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMC1yYzMvc291cmNlL0RvY3VtZW50YXRp
b24vZGV2LQ0KPiB0b29scy9rY292LnJzdCNMNDINCj4gb3IgaGVyZSAoaXQncyBsaWtlIHN0cmFj
ZSBidXQgY29sbGVjdHMgYW5kIHByaW50cyBLQ09WIGNvdmVyYWdlKToNCj4gaHR0cHM6Ly9naXRo
dWIuY29tL2dvb2dsZS9zeXprYWxsZXIvYmxvYi9tYXN0ZXIvdG9vbHMva2NvdnRyYWNlL2tjb3Z0
cmFjZS5jDQo+IA0KDQpObywgdGhpcyBvbmUgaGFzbid0IGdvbmUgdmlhIGFueSBwYXJ0aWN1bGFy
IHRlc3RpbmcgYXBhcnQNCnRoZSB0ZXN0cyB0aGF0IHplcm8gZGF5IHJ1bnMgYXV0b21hdGljYWxs
eSAobGlrZSBib290IHRlc3RzLCBldGMuKSBzaW5jZSBub3JtYWxseQ0KaXQgaXMgaGFyZCBmb3Ig
bWUgdG8ga25vdyBob3cgZXhhY3RseSB0byB0ZXN0IGEgcGFydGljdWxhciBjb21wb25lbnQgaW4g
YSBtZWFuaW5nZnVsDQp3YXkuIA0KDQpCdXQgSSBjYW4gdHJ5IHRvIHRlc3Qgd2l0aCB0aGUgYWJv
dmUgZXhhbXBsZSBub3csIGlmIGl0IGhlbHBzIQ0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==
