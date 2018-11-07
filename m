Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AF4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A0D20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A0D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeKHFfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:35:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:41719 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeKHFfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:35:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 12:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,476,1534834800"; 
   d="scan'208";a="272204321"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2018 12:03:46 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 12:03:46 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.25]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 12:03:46 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v8 1/4] vmalloc: Add __vmalloc_node_try_addr function
Thread-Topic: [PATCH v8 1/4] vmalloc: Add __vmalloc_node_try_addr function
Thread-Index: AQHUcuJ7/y6BvTKcb0y0gvXsmNkLuKVDySaAgAGBvQA=
Date:   Wed, 7 Nov 2018 20:03:45 +0000
Message-ID: <7e7fdb81bd2ed9ca9514a97d44683bfa1267a55d.camel@intel.com>
References: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
         <20181102192520.4522-2-rick.p.edgecombe@intel.com>
         <20181106130511.9ebeb5a09aba15dfee2f7f3d@linux-foundation.org>
In-Reply-To: <20181106130511.9ebeb5a09aba15dfee2f7f3d@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C165EA883338BB4599B26B6BAD25AFBC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTA2IGF0IDEzOjA1IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBGcmksICAyIE5vdiAyMDE4IDEyOjI1OjE3IC0wNzAwIFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IENyZWF0ZSBfX3ZtYWxs
b2Nfbm9kZV90cnlfYWRkciBmdW5jdGlvbiB0aGF0IHRyaWVzIHRvIGFsbG9jYXRlIGF0IGEgc3Bl
Y2lmaWMNCj4gPiBhZGRyZXNzIHdpdGhvdXQgdHJpZ2dlcmluZyBhbnkgbGF6eSBwdXJnaW5nLiBJ
biBvcmRlciB0byBzdXBwb3J0IHRoaXMNCj4gPiBiZWhhdmlvcg0KPiA+IGEgdHJ5X2FkZHIgYXJn
dW1lbnQgd2FzIHBsdWdnZWQgaW50byBzZXZlcmFsIG9mIHRoZSBzdGF0aWMgaGVscGVycy4NCj4g
DQo+IFBsZWFzZSBleHBsYWluIChpbiB0aGUgY2hhbmdlbG9nKSB3aHkgbGF6eSBwdXJnaW5nIGlz
IGNvbnNpZGVyZWQgdG8gYmUNCj4gYSBwcm9ibGVtLiAgUHJlZmVyYWJseSB3aXRoIHNvbWUgZm9y
bSBvZiBtZWFzdXJlbWVudHMsIG9yIGF0IGxlYXN0IGENCj4gaGFuZC13YXZ5IGd1ZXNzdGltYXRl
IG9mIHRoZSBjb3N0Lg0KU3VyZSwgSWxsIHVwZGF0ZSBpdCB0byBiZSBtb3JlIGNsZWFyLiBUaGUg
cHJvYmxlbSBpcyB0aGF0IHdoZW4NCl9fdm1hbGxvY19ub2RlX3JhbmdlIGZhaWxzIHRvIGFsbG9j
YXRlIChpbiB0aGlzIGNhc2UgdHJpZXMgaW4gYSBzaW5nbGUgcmFuZG9tDQpzcG90IHRoYXQgZG9l
c24ndCBmaXQpLCBpdCB0cmlnZ2VycyBhIHB1cmdlX3ZtYXBfYXJlYV9sYXp5IGFuZCB0aGVuIHJl
dHJpZXMgdGhlDQphbGxvY2F0aW9uIGluIHRoZSBzYW1lIHNwb3QuIEl0IGRvZXNuJ3QgbWFrZSBh
cyBtdWNoIHNlbnNlIGluIHRoaXMgY2FzZSB3aGVuIHdlDQphcmUgbm90IHRyeWluZyBvdmVyIGEg
bGFyZ2UgYXJlYS4gV2hpbGUgaXQgd2lsbCB1c3VhbGx5IG5vdCBmbHVzaCB0aGUgVExCLCBpdA0K
ZG9lcyBkbyBleHRyYSB3b3JrIGV2ZXJ5IHRpbWUgZm9yIGFuIHVubGlrZWx5IGNhc2UgaW4gdGhp
cyBzaXR1YXRpb24gb2YgYSBsYXp5DQpmcmVlIGFyZWEgYmxvY2tpbmcgdGhlIGFsbG9jYXRpb24u
DQoNClRoZSBhdmVyYWdlIGFsbG9jYXRpb24gdGltZSBpbiBucyBmb3IgZGlmZmVyZW50IHZlcnNp
b25zIG1lYXN1cmVkIGJ5IHRoZQ0KaW5jbHVkZWQga3NlbGZ0ZXN0Og0KDQpNb2R1bGVzCVZtYWxs
b2Mgb3B0aW1pemF0aW9uCU5vIFZtYWxsb2MgT3B0aW1pemF0aW9uCUV4aXN0aW5nIE1vZHVsZSBL
QVNMUg0KMTAwMAkxNDMzCQkJMTk5MwkJCTM4MjENCjIwMDAJMjI5NQkJCTM2ODEJCQk3ODMwDQoz
MDAwCTQ0MjQJCQk3NDUwCQkJMTMwMTINCjQwMDAJNzc0NgkJCTEzODI0CQkJMTgxMDYNCjUwMDAJ
MTI3MjEJCQkyMTg1MgkJCTIyNTcyDQo2MDAwCTE5NzI0CQkJMzM5MjYJCQkyNjQ0Mw0KNzAwMAky
NzYzOAkJCTQ3NDI3CQkJMzA0NzMNCjgwMDAJMzc3NDUJCQk2NDQ0MwkJCTM0MjAwDQoNClRoZSBv
dGhlciBvcHRpbWl6YXRpb24gaXMgbm90IGttYWxsb2MtaW5nIGluIF9fZ2V0X3ZtX2FyZWFfbm9k
ZSB1bnRpbCBhZnRlciB0aGUNCmFkZHJlc3Mgd2FzIHRyaWVkLCB3aGljaCBJSVJDIGhhZCBhIHNt
YWxsZXIgYnV0IHN0aWxsIG5vdGljZWFibGUgcGVyZm9ybWFuY2UNCmJvb3N0Lg0KDQpUaGVzZSBh
bGxvY2F0aW9ucyBhcmUgbm90IHRha2luZyB2ZXJ5IGxvbmcsIGJ1dCBpdCBtYXkgc2hvdyB1cCBv
biBzeXN0ZW1zIHdpdGgNCnZlcnkgaGlnaCB1c2FnZSBvZiB0aGUgbW9kdWxlIHNwYWNlIChCUEYg
SklUcykuIElmIHRoZSB0cmFkZS1vZmYgb2YgdG91Y2hpbmcNCnZtYWxsb2MgZG9lc24ndCBzZWVt
IHdvcnRoIGl0IHRvIHBlb3BsZSwgSSdtIGhhcHB5IHRvIHJlbW92ZSB0aGUgb3B0aW1pemF0aW9u
cy4NCg0KPiA+IFRoaXMgYWxzbyBjaGFuZ2VzIGxvZ2ljIGluIF9fZ2V0X3ZtX2FyZWFfbm9kZSB0
byBiZSBmYXN0ZXIgaW4gY2FzZXMgd2hlcmUNCj4gPiBhbGxvY2F0aW9ucyBmYWlsIGR1ZSB0byBu
byBzcGFjZSwgd2hpY2ggaXMgYSBsb3QgbW9yZSBjb21tb24gd2hlbiB0cnlpbmcNCj4gPiBzcGVj
aWZpYyBhZGRyZXNzZXMuDQo=
