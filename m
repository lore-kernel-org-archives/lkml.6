Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE80AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6B520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbfAaKEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:04:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:42314 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfAaKD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:03:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 02:03:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="112582972"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2019 02:03:56 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.47]) with mapi id 14.03.0415.000;
 Thu, 31 Jan 2019 10:03:56 +0000
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
Thread-Index: AQHUrYYWOOwEuMXWwEOBiuSRPC5USKW5sWmAgAABJYCAD4jdQA==
Date:   Thu, 31 Jan 2019 10:03:55 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B9BBF9@IRSMSX102.ger.corp.intel.com>
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
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzdhNjIyMGEtNGEwNC00ZTM0LThjMTQtZGI5OWQ1OWMyNDkyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmF3MURDcW55OXZJaE4yeDhCcTBqY2NuOHhMeFA3MHM3c2NCeDM2b0NXM0o0K09jQ3BmSGgzZHJ3UTBsVmwzbyJ9
x-originating-ip: [163.33.239.182]
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
cmFjZS5jDQo+IA0KDQpPaywgc28gSSBmaW5hbGx5IGdvdCB0byBjb21waWxlIGtjb3YgaW4gYW5k
IHRyeSB0aGUgZmlyc3QgdGVzdCBwcm9ncmFtIA0KYW5kIGl0IHdvcmtzIGZpbmUgYXMgZmFyIGFz
IEkgY2FuIHNlZTogcnVucywgcHJpbnRzIHJlc3VsdHMsIGFuZCBubyBXQVJOcyBhbnl3aGVyZQ0K
dmlzaWJsZSB3aXRoIHJlZ2FyZHMgdG8gcmVmY291bnRfdC4gDQoNCkkgZGlkIG15IHRlc3Qgb24g
NC4yMCB3aXRoIENPTkZJR19SRUZDT1VOVF9GVUxMPXkgDQpzaW5jZSBJIGhhdmUgc2VyaW91cyBp
c3N1ZXMgZ2V0dGluZyA1LjAgcnVubmluZyBhcyBpdCBpcyBldmVuIGZyb20NCnRoZSBzdGFibGUg
YnJhbmNoLCBidXQgdW5sZXNzIGtjb3YgdW5kZXJ3ZW50IHNvbWUgc2VyaW91cyBjaGFuZ2VzIHNp
bmNlIERlY2VtYmVyLA0KaXQgc2hvdWxkIG5vdCBhZmZlY3QuIA0KDQpJcyBpdCBvayBub3cgZm9y
IG1lcmdpbmcgdGhpcyBjaGFuZ2U/IFRoZSBzdHJpY3RlciBtZW0gb3JkZXJpbmcgb24gZGVjX2Fu
ZF90ZXN0DQpob3BlZnVsbHkgd2lsbCBhbHNvIGxhbmRzIHNvb24uIA0KDQpCZXN0IFJlZ2FyZHMs
DQpFbGVuYS4NCg0K
