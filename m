Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CFBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D2620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfAQWQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:16:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:35205 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbfAQWQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:16:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 14:16:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="312758669"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2019 14:16:48 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.62]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.32]) with mapi id 14.03.0415.000;
 Thu, 17 Jan 2019 14:16:48 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH 14/17] mm: Make hibernate handle unmapped pages
Thread-Topic: [PATCH 14/17] mm: Make hibernate handle unmapped pages
Thread-Index: AQHUrfxTlKrIPpA6H0a8MvhHJCQ6Z6Wzu1IAgADTb4A=
Date:   Thu, 17 Jan 2019 22:16:47 +0000
Message-ID: <b224d88d91a5c45c44e176ea06dea558a8939ccf.camel@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
         <20190117003259.23141-15-rick.p.edgecombe@intel.com>
         <20190117093950.GA17930@amd>
In-Reply-To: <20190117093950.GA17930@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D73C986B5765A64C9EB296CBE671BE1A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAxLTE3IGF0IDEwOjM5ICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IEhpIQ0KPiANCj4gPiBGb3IgYXJjaGl0ZWN0dXJlcyB3aXRoIENPTkZJR19BUkNIX0hBU19TRVRf
QUxJQVMsIHBhZ2VzIGNhbiBiZSB1bm1hcHBlZA0KPiA+IGJyaWVmbHkgb24gdGhlIGRpcmVjdG1h
cCwgZXZlbiB3aGVuIENPTkZJR19ERUJVR19QQUdFQUxMT0MgaXMgbm90DQo+ID4gY29uZmlndXJl
ZC4NCj4gPiBTbyB0aGlzIGNoYW5nZXMga2VybmVsX21hcF9wYWdlcyBhbmQga2VybmVsX3BhZ2Vf
cHJlc2VudCB0byBiZSBkZWZpbmVkIHdoZW4NCj4gPiBDT05GSUdfQVJDSF9IQVNfU0VUX0FMSUFT
IGlzIGRlZmluZWQgYXMgd2VsbC4gSXQgYWxzbyBjaGFuZ2VzIHBsYWNlcw0KPiA+IChwYWdlX2Fs
bG9jLmMpIHdoZXJlIHRob3NlIGZ1bmN0aW9ucyBhcmUgYXNzdW1lZCB0byBvbmx5IGJlIGltcGxl
bWVudGVkIHdoZW4NCj4gPiBDT05GSUdfREVCVUdfUEFHRUFMTE9DIGlzIGRlZmluZWQuDQo+IA0K
PiBXaGljaCBhcmNoaXRlY3R1cmVzIGFyZSB0aGF0Pw0KPiANCj4gU2hvdWxkIHRoaXMgYmUgbWVy
Z2VkIHRvIHRoZSBwYXRjaCB3aGVyZSBIQVNfU0VUX0FMSUFTIGlzIGludHJvZHVjZWQ/IFdlDQo+
IGRvbid0IHdhbnQgYnJva2VuIGhpYmVybmF0aW9uIGluIGJldHdlZW4uLi4uDQpUaGFua3MgZm9y
IHRha2luZyBhIGxvb2suIEl0IHdhcyBhZGRlZCBmb3IgeDg2IGZvciBwYXRjaCAxMyBpbiB0aGlz
IHBhdGNoc2V0IGFuZA0KdGhlcmUgd2FzIGludGVyZXN0IGV4cHJlc3NlZCBmb3IgYWRkaW5nIGZv
ciBhcm02NC4gSWYgeW91IGRpZG4ndCBnZXQgdGhlIHdob2xlDQpzZXQgYW5kIHdhbnQgdG8gc2Vl
IGxldCBtZSBrbm93IGFuZCBJIGNhbiBzZW5kIGl0Lg0KDQo+IA0KPiA+IC0jaWZkZWYgQ09ORklH
X0RFQlVHX1BBR0VBTExPQw0KPiA+ICBleHRlcm4gYm9vbCBfZGVidWdfcGFnZWFsbG9jX2VuYWJs
ZWQ7DQo+ID4gLWV4dGVybiB2b2lkIF9fa2VybmVsX21hcF9wYWdlcyhzdHJ1Y3QgcGFnZSAqcGFn
ZSwgaW50IG51bXBhZ2VzLCBpbnQNCj4gPiBlbmFibGUpOw0KPiA+ICANCj4gPiAgc3RhdGljIGlu
bGluZSBib29sIGRlYnVnX3BhZ2VhbGxvY19lbmFibGVkKHZvaWQpDQo+ID4gIHsNCj4gPiAtCXJl
dHVybiBfZGVidWdfcGFnZWFsbG9jX2VuYWJsZWQ7DQo+ID4gKwlyZXR1cm4gSVNfRU5BQkxFRChD
T05GSUdfREVCVUdfUEFHRUFMTE9DKSAmJiBfZGVidWdfcGFnZWFsbG9jX2VuYWJsZWQ7DQo+ID4g
IH0NCj4gDQo+IFRoaXMgd2lsbCBicmVhayBidWlsZCBBRkFJQ1QuIF9kZWJ1Z19wYWdlYWxsb2Nf
ZW5hYmxlZCB2YXJpYWJsZSBkb2VzDQo+IG5vdCBleGlzdCBpbiAhQ09ORklHX0RFQlVHX1BBR0VB
TExPQyBjYXNlLg0KPiANCj4gCQkJCQkJCQkJUGF2ZWwNCkFmdGVyIGFkZGluZyBpbiB0aGUgQ09O
RklHX0FSQ0hfSEFTX1NFVF9BTElBUyBjb25kaXRpb24gdG8gdGhlIGlmZGVmcyBpbiB0aGlzDQph
cmVhIGl0IGxvb2tlZCBhIGxpdHRsZSBoYXJkIHRvIHJlYWQgdG8gbWUsIHNvIEkgbW92ZWQgZGVi
dWdfcGFnZWFsbG9jX2VuYWJsZWQNCmFuZCBleHRlcm4gYm9vbCBfZGVidWdfcGFnZWFsbG9jX2Vu
YWJsZWQgb3V0c2lkZSB0byBtYWtlIGl0IGVhc2llci4gSSB0aGluayB5b3UNCmFyZSByaWdodCwg
dGhlIGFjdHVhbCBub24tZXh0ZXJuIHZhcmlhYmxlIGNhbiBub3QgYmUgdGhlcmUsIGJ1dCB0aGUg
cmVmZXJlbmNlDQpoZXJlIGdldHMgb3B0aW1pemVkIG91dCBpbiB0aGF0IGNhc2UuDQoNCkp1c3Qg
ZG91YmxlIGNoZWNrZWQgYW5kIGl0IGJ1aWxkcyBmb3IgYm90aCBDT05GSUdfREVCVUdfUEFHRUFM
TE9DPW4gYW5kDQpDT05GSUdfREVCVUdfUEFHRUFMTE9DPXkgZm9yIG1lLg0KDQpUaGFua3MsDQoN
ClJpY2sNCg==
