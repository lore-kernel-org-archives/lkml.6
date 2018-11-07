Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16014C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5A321104
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5A321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeKHFff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:35:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:41719 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKHFff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:35:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 12:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,476,1534834800"; 
   d="scan'208";a="90250945"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2018 12:03:41 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 12:03:41 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.128]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 12:03:41 -0800
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
Subject: Re: [PATCH v8 0/4] KASLR feature to randomize each loadable module
Thread-Topic: [PATCH v8 0/4] KASLR feature to randomize each loadable module
Thread-Index: AQHUcuJ6EQcoej8JQkCUFoYuD+myx6VDyRiAgAGBxYA=
Date:   Wed, 7 Nov 2018 20:03:40 +0000
Message-ID: <84597c620c39ed17be11de759646f3ace3e236fa.camel@intel.com>
References: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
         <20181106130459.7a2669604a2c274edbe25971@linux-foundation.org>
In-Reply-To: <20181106130459.7a2669604a2c274edbe25971@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EA5D5F7B5010143BB315E15C2C67207@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTA2IGF0IDEzOjA0IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBGcmksICAyIE5vdiAyMDE4IDEyOjI1OjE2IC0wNzAwIFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IFRoaXMgaXMgVjggb2Yg
dGhlICJLQVNMUiBmZWF0dXJlIHRvIHJhbmRvbWl6ZSBlYWNoIGxvYWRhYmxlIG1vZHVsZSINCj4g
PiBwYXRjaHNldC4NCj4gPiBUaGUgcHVycG9zZSBpcyB0byBpbmNyZWFzZSB0aGUgcmFuZG9taXph
dGlvbiBhbmQgYWxzbyB0byBtYWtlIHRoZSBtb2R1bGVzDQo+ID4gcmFuZG9taXplZCBpbiByZWxh
dGlvbiB0byBlYWNoIG90aGVyIGluc3RlYWQgb2YganVzdCB0aGUgYmFzZSwgc28gdGhhdCBpZg0K
PiA+IG9uZQ0KPiA+IG1vZHVsZSBsZWFrcyB0aGUgbG9jYXRpb24gb2YgdGhlIG90aGVycyBjYW4n
dCBiZSBpbmZlcnJlZC4NCj4gDQo+IEknbSBub3Qgc2VlaW5nIGFueSBpbmZvIGhlcmUgd2hpY2gg
ZXhwbGFpbnMgd2h5IHdlIHNob3VsZCBhZGQgdGhpcyB0bw0KPiBMaW51eC4NCj4gDQo+IFdoYXQg
aXMgdGhlIGVuZC11c2VyIHZhbHVlPyAgV2hhdCBwcm9ibGVtcyBkb2VzIGl0IHNvbHZlPyAgQXJl
IHRob3NlDQo+IHByb2JsZW1zIHJlYWwgb3IgdGhlb3JldGljYWw/ICBXaGF0IGFyZSB0aGUgZXhw
bG9pdCBzY2VuYXJpb3MgYW5kIGhvdw0KPiByZWFsaXN0aWMgYXJlIHRoZXk/ICBldGNldGVyYSwg
ZXRjZXRlcmEuICBIb3cgYXJlIHdlIHRvIGRlY2lkZSB0byBidXkNCj4gdGhpcyB0aGluZyBpZiB3
ZSBhcmVuJ3QgZ2l2ZW4gYSBnbG9zc3kgYnJvY2h1cmU/DQpIaSBBbmRyZXcsDQoNClRoYW5rcyBm
b3IgdGFraW5nIGEgbG9vayEgVGhlIGZpcnN0IHZlcnNpb24gaGFkIGEgcHJvcGVyIHdyaXRlIHVw
LCBidXQgbm93IHRoZQ0KZGV0YWlscyBhcmUgc3ByZWFkIG91dCBvdmVyIDggdmVyc2lvbnMuIEkn
bGwgc2VuZCBvdXQgYW5vdGhlciB2ZXJzaW9uIHdpdGggaXQNCmFsbCBpbiBvbmUgcGxhY2UuDQoN
ClRoZSBzaG9ydCB2ZXJzaW9uIGlzIHRoYXQgdG9kYXkgdGhlIFJBTkRPTUlaRV9CQVNFIGZlYXR1
cmUgcmFuZG9taXplcyB0aGUgYmFzZQ0KYWRkcmVzcyB3aGVyZSB0aGUgbW9kdWxlIGFsbG9jYXRp
b25zIGJlZ2luIHdpdGggMTAgYml0cyBvZiBlbnRyb3B5LiBGcm9tIGhlcmUsDQphIGhpZ2hseSBk
ZXRlcm1pbmlzdGljIGFsZ29yaXRobSBhbGxvY2F0ZXMgc3BhY2UgZm9yIHRoZSBtb2R1bGVzIGFz
IHRoZXkgYXJlIA0KbG9hZGVkIGFuZCB1bi1sb2FkZWQuIElmIGFuIGF0dGFja2VyIGNhbiBwcmVk
aWN0IHRoZSBvcmRlciBhbmQgaWRlbnRpdGllcyBmb3INCm1vZHVsZXMgdGhhdCB3aWxsIGJlIGxv
YWRlZCwgdGhlbiBhIHNpbmdsZSB0ZXh0IGFkZHJlc3MgbGVhayBjYW4gZ2l2ZSB0aGUNCmF0dGFj
a2VyIGFjY2VzcyB0byB0aGUgbG9jYXRpb25zIG9mIGFsbCB0aGUgbW9kdWxlcy4gDQoNClNvIHRo
aXMgaXMgdHJ5aW5nIHRvIHByZXZlbnQgdGhlIHNhbWUgY2xhc3Mgb2YgYXR0YWNrcyBhcyB0aGUg
ZXhpc3RpbmcgS0FTTFIsDQpsaWtlIGNvbnRyb2wgZmxvdyBtYW5pcHVsYXRpb24gYW5kIG5vdyBh
bHNvIG1ha2luZyBpdCBoYXJkZXIvbG9uZ2VyIHRvIGZpbmQNCnNwZWN1bGF0aXZlIGV4ZWN1dGlv
biBnYWRnZXRzLiBJdCBpbmNyZWFzZXMgdGhlIG51bWJlciBvZiBwb3NzaWJsZQ0KcG9zaXRpb25z
IDEyOFgsIGFuZCB3aXRoIHRoYXQgYW1vdW50IG9mIHJhbmRvbW5lc3MgcGVyIG1vZHVsZSBpbnN0
ZWFkIG9mIGZvciBhbGwNCm1vZHVsZXMuDQoNCj4gPiBUaGVyZSBpcyBhIHNtYWxsIGFsbG9jYXRp
b24gcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gdmVyc3VzIHY3IGFzIGENCj4gPiB0cmFkZSBvZmYs
IGJ1dCBpdCBpcyBzdGlsbCBmYXN0ZXIgb24gYXZlcmFnZSB0aGFuIHRoZSBleGlzdGluZw0KPiA+
IGFsZ29yaXRobSB1bnRpbCA+NzAwMCBtb2R1bGVzLg0KPiANCj4gbG9sLiAgSG93IGRpZCB5b3Ug
dGVzdCA3MDAwIG1vZHVsZXM/ICBVc2luZyB0aGUgc2VsZnRlc3QgY29kZT8NCg0KWWVzLCB0aGlz
IGlzIHdpdGggc2ltdWxhdGlvbnMgdXNpbmcgdGhlIGluY2x1ZGVkIGtzZWxmdGVzdCBjb2RlIHdp
dGggc2l6ZXMNCmV4dHJhY3RlZCBmcm9tIHRoZSB4ODZfNjQgaW4tdHJlZSBtb2R1bGVzLiBTdXBw
b3J0aW5nIDcwMDAga2VybmVsIG1vZHVsZXMgaXMgbm90DQp0aGUgaW50ZW50aW9uIHRob3VnaCwg
aW5zdGVhZCBpdCdzIHRyeWluZyB0byBhY2NvbW1vZGF0ZSA3MDAwIGFsbG9jYXRpb25zIGluIHRo
ZQ0KbW9kdWxlIHNwYWNlLiBTbyBhbHNvIGVCUEYgSklULCBjbGFzc2ljIEJQRiBzb2NrZXQgZmls
dGVyIEpJVCwga3Byb2JlcywgZXRjLg0KDQo=
