Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F9BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C2D213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C2D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeK0LPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:15:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:7638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeK0LPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:15:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 16:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,284,1539673200"; 
   d="scan'208";a="94359788"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2018 16:19:20 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 26 Nov 2018 16:19:20 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.136]) with mapi id 14.03.0415.000;
 Mon, 26 Nov 2018 16:19:19 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jeyu@kernel.org" <jeyu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v9 RESEND 0/4] KASLR feature to randomize each loadable
 module
Thread-Topic: [PATCH v9 RESEND 0/4] KASLR feature to randomize each loadable
 module
Thread-Index: AQHUgSfgmNHk8ka4hkuDmzvB70p4/KViv1EAgACSuAA=
Date:   Tue, 27 Nov 2018 00:19:19 +0000
Message-ID: <54dafdec825859afc85a3bd651f9e850e57a59dc.camel@intel.com>
References: <20181120232312.30037-1-rick.p.edgecombe@intel.com>
         <20181126153611.GA17169@linux-8ccs>
In-Reply-To: <20181126153611.GA17169@linux-8ccs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.128]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD9162A81F3AB248B951FE31C65C3B37@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTI2IGF0IDE2OjM2ICswMTAwLCBKZXNzaWNhIFl1IHdyb3RlOg0KPiAr
KysgUmljayBFZGdlY29tYmUgWzIwLzExLzE4IDE1OjIzIC0wODAwXToNCltzbmlwXQ0KPiBIaSBS
aWNrIQ0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxheS4gSSdkIGxpa2UgdG8gdGFrZSBhIHN0ZXAg
YmFjayBhbmQgYXNrIHNvbWUgYnJvYWRlcg0KPiBxdWVzdGlvbnMgLQ0KPiANCj4gLSBJcyB0aGUg
ZW5kIGdvYWwgb2YgdGhpcyBwYXRjaHNldCB0byByYW5kb21pemUgbG9hZGluZyBrZXJuZWwgbW9k
dWxlcywgb3INCj4gbW9zdC9hbGwNCj4gICAgZXhlY3V0YWJsZSBrZXJuZWwgbWVtb3J5IGFsbG9j
YXRpb25zLCBpbmNsdWRpbmcgYnBmLCBrcHJvYmVzLCBldGM/DQpUaGFua3MgZm9yIHRha2luZyBh
IGxvb2shDQoNCkl0IHN0YXJ0ZWQgd2l0aCB0aGUgZ29hbCBvZiBqdXN0IHJhbmRvbWl6aW5nIG1v
ZHVsZXMgKGhlbmNlIHRoZSBuYW1lKSwgYnV0IEkNCnRoaW5rIHRoZXJlIGlzIG1heWJlIHZhbHVl
IGluIHJhbmRvbWl6aW5nIHRoZSBwbGFjZW1lbnQgb2YgYWxsIHJ1bnRpbWUgYWRkZWQNCmV4ZWN1
dGFibGUgY29kZS4gQmV5b25kIGp1c3QgdHJ5aW5nIHRvIG1ha2UgZXhlY3V0YWJsZSBjb2RlIHBs
YWNlbWVudCBsZXNzDQpkZXRlcm1pbmlzdGljIGluIGdlbmVyYWwsIHRvZGF5IGFsbCBvZiB0aGUg
dXNhZ2VzIGhhdmUgdGhlIHByb3BlcnR5IG9mIHN0YXJ0aW5nDQp3aXRoIFJXIHBlcm1pc3Npb25z
IGFuZCB0aGVuIGJlY29taW5nIFJPIGV4ZWN1dGFibGUsIHNvIHRoZXJlIGlzIHRoZSBiZW5lZml0
IG9mDQpuYXJyb3dpbmcgdGhlIGNoYW5jZXMgYSBidWcgY291bGQgc3VjY2Vzc2Z1bGx5IHdyaXRl
IHRvIGl0IGR1cmluZyB0aGUgUlcgd2luZG93Lg0KDQo+IC0gSXQgc2VlbXMgdGhhdCBhIGxvdCBv
ZiBjb21wbGV4aXR5IGFuZCBoZXVyaXN0aWNzIGFyZSBpbnRyb2R1Y2VkIGp1c3QgdG8NCj4gICAg
YWNjb21tb2RhdGUgdGhlIHBvdGVudGlhbCBmcmFnbWVudGF0aW9uIHRoYXQgY2FuIGhhcHBlbiB3
aGVuIHRoZSBtb2R1bGUNCj4gdm1hbGxvYw0KPiAgICBzcGFjZSBzdGFydHMgdG8gZ2V0IGZyYWdt
ZW50ZWQgd2l0aCBicGYgZmlsdGVycy4gSSdtIHBhcnRpYWwgdG8gdGhlIGlkZWEgb2YNCj4gICAg
c3BsaXR0aW5nIG9yIGhhdmluZyBicGYgb3duIGl0cyBvd24gdm1hbGxvYyBzcGFjZSwgc2ltaWxh
ciB0byB3aGF0IEFyZCBpcw0KPiBhbHJlYWR5DQo+ICAgIGltcGxlbWVudGluZyBmb3IgYXJtNjQu
DQo+IA0KPiAgICBTbyBhIHF1ZXN0aW9uIGZvciB0aGUgYnBmIGFuZCB4ODYgZm9sa3MsIGlzIGhh
dmluZyBhIGRlZGljYXRlZCB2bWFsbG9jDQo+IHJlZ2lvbg0KPiAgICAoYXMgd2VsbCBhcyBhIHNl
cGVyYXRlIGJwZl9hbGxvYyBhcGkpIGZvciBicGYgZmVhc2libGUgb3IgZGVzaXJhYmxlIG9uDQo+
IHg4Nl82ND8NCkkgYWN0dWFsbHkgZGlkIHNvbWUgcHJvdG90eXBpbmcgYW5kIHRlc3Rpbmcgb24g
dGhpcy4gSXQgc2VlbXMgdGhlcmUgd291bGQgYmUNCnNvbWUgc2xvd2Rvd24gZnJvbSB0aGUgcmVx
dWlyZWQgY2hhbmdlcyB0byB0aGUgSklUZWQgY29kZSB0byBzdXBwb3J0IGNhbGxpbmcNCmJhY2sg
ZnJvbSB0aGUgdm1hbGxvYyByZWdpb24gaW50byB0aGUga2VybmVsLCBhbmQgc28gbW9kdWxlIHNw
YWNlIHdvdWxkIHN0aWxsIGJlDQp0aGUgcHJlZmVycmVkIHJlZ2lvbi4NCg0KPiAgICBJZiBicGYg
ZmlsdGVycyBuZWVkIHRvIGJlIHdpdGhpbiAyIEdCIG9mIHRoZSBjb3JlIGtlcm5lbCwgd291bGQg
aXQgbWFrZQ0KPiBzZW5zZQ0KPiAgICB0byBjYXJ2ZSBvdXQgYSBwb3J0aW9uIG9mIHRoZSBjdXJy
ZW50IG1vZHVsZSByZWdpb24gZm9yIGJwZg0KPiBmaWx0ZXJzPyAgQWNjb3JkaW5nDQo+ICAgIHRv
IERvY3VtZW50YXRpb24veDg2L3g4Nl82NC9tbS50eHQsIHRoZSBtb2R1bGUgcmVnaW9uIGlzIH4x
LjUgR0IuIEkgYW0NCj4gZG91YnRmdWwNCj4gICAgdGhhdCBhbnkgcmVhbCBzeXN0ZW0gd2lsbCBh
Y3R1YWxseSBoYXZlIDEuNSBHQiB3b3J0aCBvZiBrZXJuZWwgbW9kdWxlcw0KPiBsb2FkZWQuDQo+
ICAgIElzIHRoZXJlIGEgc3BlY2lmaWMgcmVhc29uIHdoeSB0aGF0IG11Y2ggc3BhY2UgaXMgZGVk
aWNhdGVkIHRvIGtlcm5lbA0KPiBtb2R1bGVzLA0KPiAgICBhbmQgd291bGQgaXQgYmUgZmVhc2li
bGUgdG8gc3BsaXQgdGhhdCByZWdpb24gY2xlYW5seSB3aXRoIGJwZj8NCkhvcGVmdWxseSBzb21l
b25lIGZyb20gQlBGIHNpZGUgb2YgdGhpbmdzIHdpbGwgY2hpbWUgaW4sIGJ1dCBteSB1bmRlcnN0
YW5kaW5nDQp3YXMgdGhhdCB0aGV5IHdvdWxkIGxpa2UgZXZlbiBtb3JlIHNwYWNlIHRoYW4gdG9k
YXkgaWYgcG9zc2libGUgYW5kIHNvIHRoZXkgbWF5DQpub3QgbGlrZSB0aGUgcmVkdWNlZCBzcGFj
ZS4NCg0KQWxzbyB3aXRoIEtBU0xSIG9uIHg4NiBpdHMgYWN0dWFsbHkgb25seSAxR0IsIHNvIGl0
IHdvdWxkIG9ubHkgYmUgNTAwTUIgcGVyDQpzZWN0aW9uIChhc3N1bWluZyBrcHJvYmVzLCBldGMg
d291bGQgc2hhcmUgdGhlIG5vbi1tb2R1bGUgcmVnaW9uLCBzbyBqdXN0IHR3bw0Kc2VjdGlvbnMp
Lg0KDQo+IC0gSWYgYnBmIGdldHMgaXRzIG93biBkZWRpY2F0ZWQgdm1hbGxvYyBzcGFjZSwgYW5k
IHdlIHN0aWNrIHRvIHRoZSBzaW5nbGUgdGFzaw0KPiAgICBvZiByYW5kb21pemluZyAqanVzdCog
a2VybmVsIG1vZHVsZXMsIGNvdWxkIHRoZSB2bWFsbG9jIG9wdGltaXphdGlvbnMgYW5kDQo+IHRo
ZQ0KPiAgICAiYmFja3VwIiBhcmVhIGJlIGRyb3BwZWQ/IFRoZSBiZW5lZml0cyBvZiB0aGUgdm1h
bGxvYyBvcHRpbWl6YXRpb25zIHNlZW0gdG8NCj4gICAgb25seSBiZSBub3RpY2VhYmxlIHdoZW4g
d2UgZ2V0IHRvIHRob3VzYW5kcyBvZiBtb2R1bGVfYWxsb2MgYWxsb2NhdGlvbnMgLQ0KPiAgICBh
Z2FpbiwgYSBjb25jZXJuIGNhdXNlZCBieSBicGYgZmlsdGVycyBzaGFyaW5nIHRoZSBzYW1lIHNw
YWNlIHdpdGgga2VybmVsDQo+ICAgIG1vZHVsZXMuDQpJIHRoaW5rIHRoZSBiYWNrdXAgYXJlYSBt
YXkgc3RpbGwgYmUgbmVlZGVkLCBmb3IgZXhhbXBsZSBpZiB5b3UgaGF2ZSAyMDAgbW9kdWxlcw0K
ZXZlbmx5IHNwYWNlZCBpbnNpZGUgNTAwTUIgdGhlcmUgaXMgb25seSBhdmVyYWdlIH4yLjVNQiBn
YXAgYmV0d2VlbiB0aGVtLiBTbyBhDQpsYXRlIGFkZGVkIGxhcmdlIG1vZHVsZSBjb3VsZCBzdGls
bCBnZXQgYmxvY2tlZC4NCg0KPiAgICBTbyB0bGRyLCBpdCBzZWVtcyB0byBtZSB0aGF0IHRoZSBj
b25jZXJuIG9mIGZyYWdtZW50YXRpb24sIHRoZSB2bWFsbG9jDQo+ICAgIG9wdGltaXphdGlvbnMs
IGFuZCB0aGUgbWFpbiBwdXJwb3NlIG9mIHRoZSBiYWNrdXAgYXJlYSAtIGJhc2ljYWxseSwgdGhl
DQo+IG1vcmUNCj4gICAgY29tcGxleCBwYXJ0cyBvZiB0aGlzIHBhdGNoc2V0IC0gc3RlbXMgc3F1
YXJlbHkgZnJvbSB0aGUgZmFjdCB0aGF0IGJwZg0KPiBmaWx0ZXJzDQo+ICAgIHNoYXJlIHRoZSBz
YW1lIHNwYWNlIGFzIG1vZHVsZXMgb24geDg2LiBJZiB3ZSB3ZXJlIHRvIGZvY3VzIG9uIHJhbmRv
bWl6aW5nDQo+ICAgICpqdXN0KiBrZXJuZWwgbW9kdWxlcywgYW5kIGlmIGJwZiBhbmQgbW9kdWxl
cyBoYWQgdGhlaXIgb3duIGRlZGljYXRlZA0KPiByZWdpb25zLA0KPiAgICB0aGVuIEkgKnRoaW5r
KiB0aGUgY29uY3JldGUgdXNlIGNhc2VzIGZvciB0aGUgYmFja3VwIGFyZWEgYW5kIHRoZSB2bWFs
bG9jDQo+ICAgIG9wdGltaXphdGlvbnMgKGlmIHdlJ3JlIHN0cmljdGx5IGNvbnNpZGVyaW5nIGp1
c3Qga2VybmVsIG1vZHVsZXMpIHdvdWxkDQo+ICAgIG1vc3RseSBkaXNhcHBlYXIgKHBsZWFzZSBj
b3JyZWN0IG1lIGlmIEknbSBpbiB0aGUgd3JvbmcgaGVyZSkuIFRoZW4NCj4gdGFja2xpbmcgdGhl
DQo+ICAgIHJhbmRvbWl6YXRpb24gb2YgYnBmIGFsbG9jYXRpb25zIGNvdWxkIHBvdGVudGlhbGx5
IGJlIGEgc2VwYXJhdGUgdGFzayBvbg0KPiBpdHMgb3duLg0KWWVzIGl0IHNlZW1zIHRoZW4gdGhl
IHZtYWxsb2Mgb3B0aW1pemF0aW9ucyBjb3VsZCBiZSBkcm9wcGVkIHRoZW4sIGJ1dCBJIGRvbid0
DQp0aGluayB0aGUgYmFja3VwIGFyZWEgY291bGQgYmUuIEFsc28gdGhlIGVudHJvcHkgd291bGQg
Z28gZG93biBzaW5jZSB0aGVyZSB3b3VsZA0KYmUgbGVzcyBwb3NzaWJsZSBwb3NpdGlvbnMgYW5k
IHdlIHdvdWxkIHJlZHVjZSB0aGUgc3BhY2UgYXZhaWxhYmxlIHRvIEJQRi4gU28NCnRoZXJlIGFy
ZSBzb21lIGRvd25zaWRlcyBqdXN0IHRvIHJlbW92ZSB0aGUgdm1hbGxvYyBwaWVjZS4NCg0KSXMg
eW91ciBjb25jZXJuIHRoYXQgdm1hbGxvYyBvcHRpbWl6YXRpb25zIG1pZ2h0IHJlZ3Jlc3Mgc29t
ZXRoaW5nIGVsc2U/IFRoZXJlDQppcyBhIG1pZGRsZSBncm91bmQgdm1hbGxvYyBvcHRpbWl6YXRp
b24gd2hlcmUgb25seSB0aGUgdHJ5X3B1cmdlIGZsYWcgaXMgcGx1bWJlZA0KdGhyb3VnaC4gVGhl
IGZsYWcgd2FzIG1vc3Qgb2YgdGhlIHBlcmZvcm1hbmNlIGdhaW5lZCBhbmQgd2l0aCBqdXN0IHRo
YXQgcGllY2UgaXQNCnNob3VsZCBub3QgY2hhbmdlIGFueSBiZWhhdmlvciBmb3IgdGhlIG5vbi1t
b2R1bGVzIGZsb3dzLiBXb3VsZCB0aGF0IGJlIG1vcmUNCmFjY2VwdGFibGU/DQoNCj4gVGhhbmtz
IQ0KPiANCj4gSmVzc2ljYQ0KPiANCltzbmlwXQ0K
