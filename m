Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F93C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B795206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B795206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeJFATa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:19:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:54979 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbeJFAT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:19:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 10:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,345,1534834800"; 
   d="scan'208";a="86048877"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2018 10:19:40 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 5 Oct 2018 10:19:39 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.185]) with mapi id 14.03.0319.002;
 Fri, 5 Oct 2018 10:19:39 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v7 3/4] vmalloc: Add debugfs modfraginfo
Thread-Topic: [PATCH v7 3/4] vmalloc: Add debugfs modfraginfo
Thread-Index: AQHUWc8eQ9enqMql8ESVQm18tY+emKURYXGA
Date:   Fri, 5 Oct 2018 17:19:38 +0000
Message-ID: <1538760091.3560.137.camel@intel.com>
References: <1538429927-17834-1-git-send-email-rick.p.edgecombe@intel.com>
         <1538429927-17834-4-git-send-email-rick.p.edgecombe@intel.com>
In-Reply-To: <1538429927-17834-4-git-send-email-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2276DF74EE4D434A8529207459C400CB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGEgcHJldmlvdXMgdmVyc2lvbiBiZWZvcmUgbWFraW5nIGFza2VkIGZvciBjb3JyZWN0aW9u
cywgdGhpcyB3YXM6DQoNClJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVt
Lm9yZz4NCg0KT24gTW9uLCAyMDE4LTEwLTAxIGF0IDE0OjM4IC0wNzAwLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gQWRkIGRlYnVnZnMgZmlsZSAibW9kZnJhZ2luZm8iIGZvciBwcm92aWRpbmcg
aW5mbyBvbiBtb2R1bGUgc3BhY2UNCj4gZnJhZ21lbnRhdGlvbi4NCj4gVGhpcyBjYW4gYmUgdXNl
ZCBmb3IgZGV0ZXJtaW5pbmcgaWYgbG9hZGFibGUgbW9kdWxlIHJhbmRvbWl6YXRpb24gaXMgY2F1
c2luZw0KPiBhbnkNCj4gcHJvYmxlbXMgZm9yIGV4dHJlbWUgbW9kdWxlIGxvYWRpbmcgc2l0dWF0
aW9ucywgbGlrZSBodWdlIG51bWJlcnMgb2YgbW9kdWxlcw0KPiBvcg0KPiBleHRyZW1lbHkgbGFy
Z2UgbW9kdWxlcy4NCj4gDQo+IFNhbXBsZSBvdXRwdXQgd2hlbiBLQVNMUiBpcyBlbmFibGVkIGFu
ZCBYODZfNjQgaXMgY29uZmlndXJlZDoNCj4gCUxhcmdlc3QgZnJlZSBzcGFjZToJODk3OTEyIGtC
DQo+IAnCoMKgVG90YWwgZnJlZSBzcGFjZToJMTAyNTQyNCBrQg0KPiBBbGxvY2F0aW9ucyBpbiBi
YWNrdXAgYXJlYToJMA0KPiANCj4gU2FtcGxlIG91dHB1dCB3aGVuIGp1c3QgWDg2XzY0Og0KPiAJ
TGFyZ2VzdCBmcmVlIHNwYWNlOgk4OTc5MTIga0INCj4gCcKgwqBUb3RhbCBmcmVlIHNwYWNlOgkx
MDI1NDI0IGtCDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVk
Z2Vjb21iZUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoG1tL3ZtYWxsb2MuYyB8IDk4DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvbW0vdm1hbGxvYy5jIGIvbW0vdm1hbGxvYy5jDQo+IGluZGV4IDE5NTQ0
NTguLjFiM2MzZGEgMTAwNjQ0DQo+IC0tLSBhL21tL3ZtYWxsb2MuYw0KPiArKysgYi9tbS92bWFs
bG9jLmMNCj4gQEAgLTE4LDYgKzE4LDcgQEANCj4gwqAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0
Lmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L3Byb2NfZnMuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgv
c2VxX2ZpbGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+IMKgI2luY2x1ZGUg
PGxpbnV4L2RlYnVnb2JqZWN0cy5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9rYWxsc3ltcy5oPg0K
PiDCoCNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQo+IEBAIC0zNiw2ICszNywxMiBAQA0KPiDCoCNp
bmNsdWRlIDxhc20vdGxiZmx1c2guaD4NCj4gwqAjaW5jbHVkZSA8YXNtL3NobXBhcmFtLmg+DQo+
IMKgDQo+ICsjaWZkZWYgQ09ORklHX1g4Ng0KPiArI2luY2x1ZGUgPGFzbS9wYWdlX3R5cGVzLmg+
DQo+ICsjaW5jbHVkZSA8YXNtL3NldHVwLmg+DQo+ICsjaW5jbHVkZSA8YXNtL2thc2xyX21vZHVs
ZXMuaD4NCj4gKyNlbmRpZg0KPiArDQo+IMKgI2luY2x1ZGUgImludGVybmFsLmgiDQo+IMKgDQo+
IMKgc3RydWN0IHZmcmVlX2RlZmVycmVkIHsNCj4gQEAgLTI5MTksNyArMjkyNiw5NiBAQCBzdGF0
aWMgaW50IF9faW5pdCBwcm9jX3ZtYWxsb2NfaW5pdCh2b2lkKQ0KPiDCoAkJcHJvY19jcmVhdGVf
c2VxKCJ2bWFsbG9jaW5mbyIsIDA0MDAsIE5VTEwsICZ2bWFsbG9jX29wKTsNCj4gwqAJcmV0dXJu
IDA7DQo+IMKgfQ0KPiAtbW9kdWxlX2luaXQocHJvY192bWFsbG9jX2luaXQpOw0KPiArI2VsaWYg
ZGVmaW5lZChDT05GSUdfREVCVUdfRlMpDQo+ICtzdGF0aWMgaW50IF9faW5pdCBwcm9jX3ZtYWxs
b2NfaW5pdCh2b2lkKQ0KPiArew0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArI2VuZGlmDQo+IMKg
DQo+ICsjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpICYmIGRlZmluZWQoQ09ORklHX1JBTkRP
TUlaRV9GSU5FX01PRFVMRSkNCj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBpc19pbl9i
YWNrdXAodW5zaWduZWQgbG9uZyBhZGRyKQ0KPiArew0KPiArCXJldHVybiBhZGRyID49IE1PRFVM
RVNfVkFERFIgKyBnZXRfbW9kdWxlc19yYW5kX2xlbigpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
aW50IG1vZHVsZWZyYWdpbmZvX2RlYnVnX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2
KQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcgbGFzdF9lbmQgPSBNT0RVTEVTX1ZBRERSOw0KPiAr
CXVuc2lnbmVkIGxvbmcgdG90YWxfZnJlZSA9IDA7DQo+ICsJdW5zaWduZWQgbG9uZyBsYXJnZXN0
X2ZyZWUgPSAwOw0KPiArCXVuc2lnbmVkIGxvbmcgYmFja3VwX2NudCA9IDA7DQo+ICsJdW5zaWdu
ZWQgbG9uZyBnYXA7DQo+ICsJc3RydWN0IHZtYXBfYXJlYSAqcHJldiwgKmN1ciA9IE5VTEw7DQo+
ICsNCj4gKwlzcGluX2xvY2soJnZtYXBfYXJlYV9sb2NrKTsNCj4gKw0KPiArCWlmICghcHZtX2Zp
bmRfbmV4dF9wcmV2KE1PRFVMRVNfVkFERFIsICZjdXIsICZwcmV2KSB8fCAhY3VyKQ0KPiArCQln
b3RvIGRvbmU7DQo+ICsNCj4gKwlmb3IgKDsgY3VyLT52YV9lbmQgPD0gTU9EVUxFU19FTkQ7IGN1
ciA9IGxpc3RfbmV4dF9lbnRyeShjdXIsIGxpc3QpKQ0KPiB7DQo+ICsJCS8qIERvbid0IGNvdW50
IGFyZWFzIHRoYXQgYXJlIG1hcmtlZCB0byBiZSBsYXppbHkgZnJlZWQgKi8NCj4gKwkJaWYgKCEo
Y3VyLT5mbGFncyAmIFZNX0xBWllfRlJFRSkpIHsNCj4gKwkJCWlmIChrYXNscl9tb2RfcmFuZG9t
aXplX2VhY2hfbW9kdWxlKCkpDQo+ICsJCQkJYmFja3VwX2NudCArPSBpc19pbl9iYWNrdXAoY3Vy
LT52YV9zdGFydCk7DQo+ICsJCQlnYXAgPSBjdXItPnZhX3N0YXJ0IC0gbGFzdF9lbmQ7DQo+ICsJ
CQlpZiAoZ2FwID4gbGFyZ2VzdF9mcmVlKQ0KPiArCQkJCWxhcmdlc3RfZnJlZSA9IGdhcDsNCj4g
KwkJCXRvdGFsX2ZyZWUgKz0gZ2FwOw0KPiArCQkJbGFzdF9lbmQgPSBjdXItPnZhX2VuZDsNCj4g
KwkJfQ0KPiArDQo+ICsJCWlmIChsaXN0X2lzX2xhc3QoJmN1ci0+bGlzdCwgJnZtYXBfYXJlYV9s
aXN0KSkNCj4gKwkJCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArZG9uZToNCj4gKwlnYXAgPSAoTU9E
VUxFU19FTkQgLSBsYXN0X2VuZCk7DQo+ICsJaWYgKGdhcCA+IGxhcmdlc3RfZnJlZSkNCj4gKwkJ
bGFyZ2VzdF9mcmVlID0gZ2FwOw0KPiArCXRvdGFsX2ZyZWUgKz0gZ2FwOw0KPiArDQo+ICsJc3Bp
bl91bmxvY2soJnZtYXBfYXJlYV9sb2NrKTsNCj4gKw0KPiArCXNlcV9wcmludGYobSwgIlx0TGFy
Z2VzdCBmcmVlIHNwYWNlOlx0JWx1IGtCXG4iLCBsYXJnZXN0X2ZyZWUgLw0KPiAxMDI0KTsNCj4g
KwlzZXFfcHJpbnRmKG0sICJcdMKgwqBUb3RhbCBmcmVlIHNwYWNlOlx0JWx1IGtCXG4iLCB0b3Rh
bF9mcmVlIC8gMTAyNCk7DQo+ICsNCj4gKwlpZiAoa2FzbHJfbW9kX3JhbmRvbWl6ZV9lYWNoX21v
ZHVsZSgpKQ0KPiArCQlzZXFfcHJpbnRmKG0sICJBbGxvY2F0aW9ucyBpbiBiYWNrdXAgYXJlYTpc
dCVsdVxuIiwNCj4gYmFja3VwX2NudCk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K
PiArc3RhdGljIGludCBwcm9jX21vZHVsZV9mcmFnX2RlYnVnX29wZW4oc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IGZpbGUNCj4gKmZpbGUpDQo+ICt7DQo+ICsJcmV0dXJuIHNpbmdsZV9vcGVu
KGZpbGUsIG1vZHVsZWZyYWdpbmZvX2RlYnVnX3Nob3csIE5VTEwpOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBkZWJ1Z19tb2R1bGVfZnJhZ19vcGVy
YXRpb25zID0gew0KPiArCS5vcGVuwqDCoMKgwqDCoMKgwqA9IHByb2NfbW9kdWxlX2ZyYWdfZGVi
dWdfb3BlbiwNCj4gKwkucmVhZMKgwqDCoMKgwqDCoMKgPSBzZXFfcmVhZCwNCj4gKwkubGxzZWVr
wqDCoMKgwqDCoD0gc2VxX2xzZWVrLA0KPiArCS5yZWxlYXNlwqDCoMKgwqA9IHNpbmdsZV9yZWxl
YXNlLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIHZvaWQgX19pbml0IGRlYnVnX21vZGZyYWdfaW5p
dCh2b2lkKQ0KPiArew0KPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGUoIm1vZGZyYWdpbmZvIiwgMDQw
MCwgTlVMTCwgTlVMTCwNCj4gKwkJCSZkZWJ1Z19tb2R1bGVfZnJhZ19vcGVyYXRpb25zKTsNCj4g
K30NCj4gKyNlbGlmIGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKSB8fCBkZWZpbmVkKENPTkZJR19Q
Uk9DX0ZTKQ0KPiArc3RhdGljIHZvaWQgX19pbml0IGRlYnVnX21vZGZyYWdfaW5pdCh2b2lkKQ0K
PiArew0KPiArfQ0KPiDCoCNlbmRpZg0KPiDCoA0KPiArI2lmIGRlZmluZWQoQ09ORklHX0RFQlVH
X0ZTKSB8fCBkZWZpbmVkKENPTkZJR19QUk9DX0ZTKQ0KPiArc3RhdGljIGludCBfX2luaXQgaW5m
b192bWFsbG9jX2luaXQodm9pZCkNCj4gK3sNCj4gKwlwcm9jX3ZtYWxsb2NfaW5pdCgpOw0KPiAr
CWRlYnVnX21vZGZyYWdfaW5pdCgpOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICttb2R1
bGVfaW5pdChpbmZvX3ZtYWxsb2NfaW5pdCk7DQo+ICsjZW5kaWY=
