Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46030C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EA42087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EA42087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeJMG2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:28:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:50790 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbeJMG2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:28:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 15:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,374,1534834800"; 
   d="scan'208";a="98768931"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2018 15:54:01 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 12 Oct 2018 15:54:01 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.31]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 15:54:01 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jeyu@kernel.org" <jeyu@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64
 modules
Thread-Topic: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64
 modules
Thread-Index: AQHUYbvB6q6oauzHf0WzWgkDdoMmRKUbK2uAgAD3YgCAAH3vAIAADpoA
Date:   Fri, 12 Oct 2018 22:54:00 +0000
Message-ID: <3b72b2c535aabb7e0bd13bbfd8f182a7dd8f321b.camel@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
         <20181011233117.7883-5-rick.p.edgecombe@intel.com>
         <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
         <20181012143254.idy65qbvaaw5k3ge@linux-8ccs>
         <a89e6d7bbcfba2ebaad927fac0da131ded59aa28.camel@intel.com>
In-Reply-To: <a89e6d7bbcfba2ebaad927fac0da131ded59aa28.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC3C4D5B668ACB4B81ECC9A3BA5D63D6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDIyOjAxICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gRnJpLCAyMDE4LTEwLTEyIGF0IDE2OjMyICswMjAwLCBKZXNzaWNhIFl1IHdyb3Rl
Og0KPiA+ICsrKyBEYXZlIEhhbnNlbiBbMTEvMTAvMTggMTY6NDcgLTA3MDBdOg0KPiA+ID4gT24g
MTAvMTEvMjAxOCAwNDozMSBQTSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gPiA+ICsJaWYg
KGNoZWNrX2luY19tb2RfcmxpbWl0KHNpemUpKQ0KPiA+ID4gPiArCQlyZXR1cm4gTlVMTDsNCj4g
PiA+ID4gKw0KPiA+ID4gPiAgCXAgPSBfX3ZtYWxsb2Nfbm9kZV9yYW5nZShzaXplLCBNT0RVTEVf
QUxJR04sIG1vZHVsZV9hbGxvY19iYXNlLA0KPiA+ID4gPiAgCQkJCW1vZHVsZV9hbGxvY19iYXNl
ICsgTU9EVUxFU19WU0laRSwNCj4gPiA+ID4gIAkJCQlnZnBfbWFzaywgUEFHRV9LRVJORUxfRVhF
QywgMCwNCj4gPiA+ID4gQEAgLTY1LDYgKzY4LDggQEAgdm9pZCAqbW9kdWxlX2FsbG9jKHVuc2ln
bmVkIGxvbmcgc2l6ZSkNCj4gPiA+ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4gPiA+ICAJfQ0KPiA+
ID4gPiANCj4gPiA+ID4gKwl1cGRhdGVfbW9kX3JsaW1pdChwLCBzaXplKTsNCj4gPiA+IA0KPiA+
ID4gSXMgdGhlcmUgYSByZWFzb24gd2UgY291bGRuJ3QganVzdCByZW5hbWUgYWxsIG9mIHRoZSBl
eGlzdGluZyBwZXItYXJjaA0KPiA+ID4gbW9kdWxlX2FsbG9jKCkgY2FsbHMgdG8gYmUgY2FsbGVk
LCBzYXksICJhcmNoX21vZHVsZV9hbGxvYygpIiwgdGhlbiBwdXQNCj4gPiA+IHRoaXMgbmV3IHJs
aW1pdCBjb2RlIGluIGEgZ2VuZXJpYyBoZWxwZXIgdGhhdCBkb2VzOg0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IAlpZiAoY2hlY2tfaW5jX21vZF9ybGltaXQoc2l6ZSkpDQo+ID4gPiAJCXJldHVybiBO
VUxMOw0KPiA+ID4gDQo+ID4gPiAJcCA9IGFyY2hfbW9kdWxlX2FsbG9jKC4uLik7DQo+ID4gPiAN
Cj4gPiA+IAkuLi4NCj4gPiA+IA0KPiA+ID4gCXVwZGF0ZV9tb2RfcmxpbWl0KHAsIHNpemUpOw0K
PiA+ID4gDQo+ID4gDQo+ID4gSSBzZWNvbmQgdGhpcyBzdWdnZXN0aW9uLiBKdXN0IG1ha2UgbW9k
dWxlX3thbGxvYyxtZW1mcmVlfSBnZW5lcmljLA0KPiA+IG5vbi13ZWFrIGZ1bmN0aW9ucyB0aGF0
IGNhbGwgdGhlIHJsaW1pdCBoZWxwZXJzIGluIGFkZGl0aW9uIHRvIHRoZQ0KPiA+IGFyY2gtc3Bl
Y2lmaWMgYXJjaF9tb2R1bGVfe2FsbG9jLG1lbWZyZWV9IGZ1bmN0aW9ucy4NCj4gPiANCj4gPiBK
ZXNzaWNhDQo+IA0KPiBPaywgdGhhbmtzLiBJIGFtIGdvaW5nIHRvIHRyeSBhbm90aGVyIHZlcnNp
b24gb2YgdGhpcyB3aXRoIGp1c3QgYSBzeXN0ZW0gd2lkZQ0KPiBCUEYgSklUIGxpbWl0IGJhc2Vk
IG9uIHRoZSBwcm9ibGVtcyBKYW5uIGJyb3VnaHQgdXAuIEkgdGhpbmsgaXQgd291bGQgYmUgbmlj
ZQ0KPiB0bw0KPiBoYXZlIGEgbW9kdWxlIHNwYWNlIGxpbWl0LCBidXQgYXMgZmFyIGFzIEkga25v
dyB0aGUgb25seSB3YXkgdG9kYXkgdW4tDQo+IHByaXZsaWRnZWQgDQo+IHVzZXJzIGNvdWxkIGZp
bGwgdGhlIHNwYWNlIGlzIGZyb20gQlBGIEpJVC4gVW5sZXNzIHlvdSBzZWUgYW5vdGhlciBwdXJw
b3NlDQo+IGxvbmcNCj4gdGVybT8NCg0KRXJyLCBuZXZlcm1pbmQuIEdvaW5nIHRvIHRyeSB0byBp
bmNsdWRlIGJvdGggbGltaXRzLiBJJ2xsIGluY29ycG9yYXRlIHRoaXMNCnJlZmFjdG9yIGludG8g
dGhlIG5leHQgdmVyc2lvbi4NCg==
