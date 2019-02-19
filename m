Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93222C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EDC2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfBSV3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:29:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:61634 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfBSV27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:28:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 13:28:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="321696263"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga005.fm.intel.com with ESMTP; 19 Feb 2019 13:28:57 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.70]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.157]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 13:28:56 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
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
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 14/20] mm: Make hibernate handle unmapped pages
Thread-Topic: [PATCH v2 14/20] mm: Make hibernate handle unmapped pages
Thread-Index: AQHUt2sViQgi+Bs0HkOgKSmVUNQOKqXnnOgAgACunoA=
Date:   Tue, 19 Feb 2019 21:28:55 +0000
Message-ID: <07ea2a4a9f1771f7bad82ad8fe5ee9483b79d115.camel@intel.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
         <20190129003422.9328-15-rick.p.edgecombe@intel.com>
         <20190219110400.GA19514@zn.tnic>
In-Reply-To: <20190219110400.GA19514@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2C7ED715E2C204FA4910F9B0DA68816@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTE5IGF0IDEyOjA0ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgSmFuIDI4LCAyMDE5IGF0IDA0OjM0OjE2UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZvciBhcmNoaXRlY3R1cmVzIHdpdGggQ09ORklHX0FSQ0hfSEFTX1NF
VF9BTElBUywgcGFnZXMgY2FuIGJlIHVubWFwcGVkDQo+ID4gYnJpZWZseSBvbiB0aGUgZGlyZWN0
bWFwLCBldmVuIHdoZW4gQ09ORklHX0RFQlVHX1BBR0VBTExPQyBpcyBub3QNCj4gPiBjb25maWd1
cmVkLiBTbyB0aGlzIGNoYW5nZXMga2VybmVsX21hcF9wYWdlcyBhbmQga2VybmVsX3BhZ2VfcHJl
c2VudCB0byBiZQ0KPiANCj4gcy90aGlzIGNoYW5nZXMvY2hhbmdlLw0KPiANCj4gRnJvbSBEb2N1
bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdDoNCj4gDQo+ICAiRGVzY3Jp
YmUgeW91ciBjaGFuZ2VzIGluIGltcGVyYXRpdmUgbW9vZCwgZS5nLiAibWFrZSB4eXp6eSBkbyBm
cm90eiINCj4gICBpbnN0ZWFkIG9mICJbVGhpcyBwYXRjaF0gbWFrZXMgeHl6enkgZG8gZnJvdHoi
IG9yICJbSV0gY2hhbmdlZCB4eXp6eQ0KPiAgIHRvIGRvIGZyb3R6IiwgYXMgaWYgeW91IGFyZSBn
aXZpbmcgb3JkZXJzIHRvIHRoZSBjb2RlYmFzZSB0byBjaGFuZ2UNCj4gICBpdHMgYmVoYXZpb3Vy
LiINCj4gDQo+IEFsc28sIHBsZWFzZSBlbmQgZnVuY3Rpb24gbmFtZXMgd2l0aCBwYXJlbnRoZXNl
cy4NClllcywgZ290Y2hhLg0KDQo+ID4gZGVmaW5lZCB3aGVuIENPTkZJR19BUkNIX0hBU19TRVRf
QUxJQVMgaXMgZGVmaW5lZCBhcyB3ZWxsLiBJdCBhbHNvIGNoYW5nZXMNCj4gPiBwbGFjZXMgKHBh
Z2VfYWxsb2MuYykgd2hlcmUgdGhvc2UgZnVuY3Rpb25zIGFyZSBhc3N1bWVkIHRvIG9ubHkgYmUN
Cj4gPiBpbXBsZW1lbnRlZCB3aGVuIENPTkZJR19ERUJVR19QQUdFQUxMT0MgaXMgZGVmaW5lZC4N
Cj4gDQo+IFRoZSBjb21taXQgbWVzc2FnZSBkb2Vzbid0IG5lZWQgdG8gc2F5ICJ3aGF0IiB5b3Un
cmUgZG9pbmcgLSB0aGF0IHNob3VsZA0KPiBiZSBvYnZpb3VzIGZyb20gdGhlIGRpZmYgYmVsb3cu
IEl0IHNob3VsZCByYXRoZXIgc2F5ICJ3aHkiIHlvdSdyZSBkb2luZw0KPiBpdC4NCk9rLCBzb3Jy
eS4gSSdsbCBjaGFuZ2UgdGhpcyB0byBiZSBtb3JlIGNvbmNpc2UuDQoNCj4gPiBTbyBub3cgd2hl
biBDT05GSUdfQVJDSF9IQVNfU0VUX0FMSUFTPXksIGhpYmVybmF0ZSB3aWxsIGhhbmRsZSBub3Qg
cHJlc2VudA0KPiA+IHBhZ2Ugd2hlbiBzYXZpbmcuIFByZXZpb3VzbHkgdGhpcyB3YXMgYWxyZWFk
eSBkb25lIHdoZW4NCj4gDQo+IHBhZ2VzDQo+IA0KPiA+IENPTkZJR19ERUJVR19QQUdFQUxMT0Mg
d2FzIGNvbmZpZ3VyZWQuIEl0IGRvZXMgbm90IGFwcGVhciB0byBoYXZlIGEgYmlnDQo+ID4gaGli
ZXJuYXRpbmcgcGVyZm9ybWFuY2UgaW1wYWN0Lg0KPiANCj4gQ29tbWVudCBvdmVyIHNhZmVfY29w
eV9wYWdlDQpPaCwgeWVzIHlvdSBhcmUgcmlnaHQuDQoNCj4gPiBCZWZvcmU6DQo+ID4gWyAgICA0
LjY3MDkzOF0gUE06IFdyb3RlIDE3MTk5NiBrYnl0ZXMgaW4gMC4yMSBzZWNvbmRzICg4MTkuMDIg
TUIvcykNCj4gPiANCj4gPiBBZnRlcjoNCj4gPiBbICAgIDQuNTA0NzE0XSBQTTogV3JvdGUgMTc4
OTMyIGtieXRlcyBpbiAwLjIyIHNlY29uZHMgKDgxMy4zMiBNQi9zKQ0KPiANCj4gSUlOTSwgdGhh
dCdzIGxpa2UgMTczNCBwYWdlcyBtb3JlLiBIb3cgYW0gSSB0byB1bmRlcnN0YW5kIHRoaXMgbnVt
YmVyPw0KPiANCj4gQ29kZSBoYXMgY2FsbGVkIHNldF9hbGlhc19udl9ub2ZsdXNoKCkgb24gdGhl
bSBhbmQgc2FmZV9jb3B5X3BhZ2UoKSBub3cNCj4gbWFwcyB0aGVtIG9uZSBieSBvbmUgdG8gY29w
eSB0aGVtIHRvIHRoZSBoaWJlcm5hdGlvbiBpbWFnZT8NCj4gDQo+IFRoeC4NCj4gDQpUaGVzZSBh
cmUgZnJvbSBsb2dzIGhpYmVybmF0ZSBnZW5lcmF0ZXMuIFRoZSBjb25jZXJuIHdhcyB0aGF0IGhp
YmVybmF0ZSBjb3VsZCBiZQ0Kc2xpZ2h0bHkgc2xvd2VyIGJlY2F1c2Ugb2YgdGhlIGNoZWNraW5n
IG9mIHdoZXRoZXIgdGhlIHBhZ2VzIGFyZSBtYXBwZWQuIFRoZQ0KYmFuZHdpZHRoIG51bWJlciBj
YW4gYmUgdXNlZCB0byBjb21wYXJlLCA4MTkuMDItPjgxMy4zMiBNQi9zLiBTb21lIHJhbmRvbW5l
c3MNCm11c3QgaGF2ZSByZXN1bHRlZCBpbiBkaWZmZXJlbnQgYW1vdW50cyBvZiBtZW1vcnkgdXNl
ZCBiZXR3ZWVuIHRlc3RzLiBJIGNhbiBqdXN0DQpyZW1vdmUgdGhlIGxvZyBsaW5lcyBhbmQgaW5j
bHVkZSB0aGUgYmFuZHdpZHRoIG51bWJlcnMuDQoNClRoYW5rcywNCg0KUmljaw0K
