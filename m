Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213422064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213422064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeJYD6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:58:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:40014 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYD6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 12:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="102991679"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2018 12:29:17 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 12:29:16 -0700
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 12:29:16 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.57]) with mapi id 14.03.0415.000;
 Wed, 24 Oct 2018 13:29:14 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
Thread-Topic: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
Thread-Index: AQHUT6S8E0XwPCm1jkGysv7aiho556UvXU2A//+dxwCAAGf+AP//m/Aw
Date:   Wed, 24 Oct 2018 19:29:14 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66CCBC7E@CRSMSX101.amr.corp.intel.com>
References: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
 <1537312139-5580-3-git-send-email-chang.seok.bae@intel.com>
 <CALCETrUr3DGwW8y6y_cffEKWO_KQs1J2_UvTBZsbdAzES_f-Ag@mail.gmail.com>
 <C9BB696F3A938947B10DCAD29FAB8FFA66CCBBE3@CRSMSX101.amr.corp.intel.com>
 <CALCETrWMMQDa4T0m34GfkkYBxqwGUOg96aeWgiANRv9tCvQVRw@mail.gmail.com>
In-Reply-To: <CALCETrWMMQDa4T0m34GfkkYBxqwGUOg96aeWgiANRv9tCvQVRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTA4MTMyMDktMmVjNi00YTE4LWI1MGItZmQ2MGVlNmFlZTAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibnlDaHljVlRKNjlEdjF6ODdQamVyc2wyemlibXMzcmRzdVdSYW1OeFEydEh3NGd4VGFDZldZdkpZVnBlemFPWCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBPY3QgMjQsIDIwMTggYXQgMTI6MjIgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+DQo+IE9uIFdlZCwgT2N0IDI0LCAyMDE4IGF0IDEyOjEzIFBNIEJhZSwgQ2hhbmcg
U2Vvaw0KPiA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1
ZSwgU2VwIDE4LCAyMDE4IGF0IDEyOjAyIFBNIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwu
b3JnPg0KPiA+ID4gT24gVHVlLCBTZXAgMTgsIDIwMTggYXQgNDowOSBQTSBDaGFuZyBTLiBCYWUN
Cj4gPiA+IDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4N
Cj4gPiA+ID4gV2l0aCBuZXcgaGVscGVycywgRlMvR1MgYmFzZSBhY2Nlc3MgaXMgY2VudHJhbGl6
ZWQuDQo+ID4gPiA+IEV2ZW50dWFsbHksIHdoZW4gRlNHU0JBU0UgaW5zdHJ1Y3Rpb24gZW5hYmxl
ZCwgaXQgd2lsbCBiZSBmYXN0ZXIuDQo+ID4gPg0KPiA+ID4gU29ycnkgZm9yIG5vdCBjYXRjaGlu
ZyB0aGlzIGR1cmluZyByZXZpZXcsIGJ1dDoNCj4gPiA+DQo+ID4gPiA+ICt2b2lkIHg4Nl9mc2Jh
c2Vfd3JpdGVfY3B1KHVuc2lnbmVkIGxvbmcgZnNiYXNlKSB7DQo+ID4gPiA+ICsgICAgICAgLyoN
Cj4gPiA+ID4gKyAgICAgICAgKiBTZXQgdGhlIHNlbGVjdG9yIHRvIDAgYXMgYSBub3Rpb24sIHRo
YXQgdGhlIHNlZ21lbnQgYmFzZSBpcw0KPiA+ID4gPiArICAgICAgICAqIG92ZXJ3cml0dGVuLCB3
aGljaCB3aWxsIGJlIGNoZWNrZWQgZm9yIHNraXBwaW5nIHRoZSBzZWdtZW50IGxvYWQNCj4gPiA+
ID4gKyAgICAgICAgKiBkdXJpbmcgY29udGV4dCBzd2l0Y2guDQo+ID4gPiA+ICsgICAgICAgICov
DQo+ID4gPiA+ICsgICAgICAgbG9hZHNlZyhGUywgMCk7DQo+ID4gPg0KPiA+ID4gXl5eDQo+ID4g
Pg0KPiA+ID4gd2hhdD8NCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgd3Jtc3JsKE1TUl9GU19CQVNF
LCBmc2Jhc2UpOyB9DQo+ID4gPg0KPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgdGhlIGNv
bW1lbnQgaXMgdHJ5aW5nIHRvIHNheSwgYnV0IHRoZSBzb2xlDQo+ID4gPiBjYWxsZXIgc28gZmFy
IG9mIHRoaXMgZnVuY3Rpb24gaXMgeDg2X2dzYmFzZV93cml0ZV90YXNrKCksIGFuZCB0aGUgY29k
ZSBsb29rcw0KPiBpbmNvcnJlY3QuDQo+ID4gPg0KPiA+ID4gSW5nbywgSSB0aGluayB3ZSBuZWVk
IHRvIGFkZHJlc3MgdGhpcyBkdXJpbmcgdGhpcyBtZXJnZSB3aW5kb3csDQo+ID4gPiBwcm9iYWJs
eSBieSByZW1vdmluZyB0aGUgY29tbWVudCBhbmQgdGhlIGxvYWRzZWcoKSBjYWxsIChhbmQgdGhl
DQo+ID4gPiBzYW1lIGZvciBnc2Jhc2UuLi5pbmFjdGl2ZSkuICBCdXQgZmlyc3QsIENoYW5nLCBj
YW4geW91IGV4cGxhaW4gd2hhdA0KPiA+ID4gZXhhY3RseSB5b3VyIGludGVudCBpcyBoZXJlPw0K
PiA+DQo+ID4gSXQncyBjb21pbmcgZnJvbSBkb19hcmNoX3ByY3RsXzY0KCkuIElmIHlvdSB0aGlu
ayBpdCByZWFsbHkgbWFrZXMNCj4gPiBjb25mdXNpb24gaW4geDg2X2ZzYmFzZV93cml0ZV9jcHUo
KSwgaG93IGFib3V0IG1vdmluZyBpdCB0bw0KPiB4ODZfZnNiYXNlX3dyaXRlX3Rhc2soKT8NCj4g
DQo+IFdoeSBzaG91bGQgLi53cml0ZV90YXNrKCkgbWFnaWNhbGx5IGNoYW5nZSB0aGUgaW5kZXgg
YnV0IG9ubHkgaWYgaXQncyB3cml0aW5nDQo+IGN1cnJlbnQ/DQo+IA0KPiBJIHRoaW5rIHlvdSBz
aG91bGQgbW92ZSBpdCBhbGwgdGhlIHdheSBvdXQgdG8gdGhlIGNhbGxlcg0KPiAoZG9fYXJjaF9w
cmN0bF82NCgpPykgYW5kIHdlIGNhbiBzZWUgaWYgaXQgbWFrZXMgc2Vuc2UgdGhlcmUuDQo+IA0K
DQpPa2F5LiB4ODZfZnNiYXNlX3dyaXRlX3Rhc2soKSBkb2Vzbid0IG1ha2Ugc2Vuc2UuIA0KVGhl
biwgaXQgc2hvdWxkIHJvbGxiYWNrIHRoYXQgaGVscGVyIGFuZCBjYWxsIHg4Nl9mc2Jhc2Vfd3Jp
dGVfY3B1KCkgb25seQ0KZnJvbSBwdHJhY2UuIFNhbWUgZm9yIGdzYmFzZS4gU291bmRzIG9rYXk/
DQoNCkNoYW5nDQoNCg==
