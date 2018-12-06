Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B1CC65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E0120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E0120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLFUV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:21:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:18664 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFUV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:21:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 12:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="116275220"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2018 12:21:57 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.228]) with mapi id 14.03.0415.000;
 Thu, 6 Dec 2018 12:21:57 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Topic: [PATCH v7 13/14] module: Do not set nx for module memory
 before freeing
Thread-Index: AQHUjHfdlDHY/m4L4UaauCLlR8W7nKVylssAgAAZkoA=
Date:   Thu, 6 Dec 2018 20:21:57 +0000
Message-ID: <55a4fb61164d7ecf5950e29d1fa2aea52a1b958f.camel@intel.com>
References: <20181205013408.47725-1-namit@vmware.com>
         <20181205013408.47725-14-namit@vmware.com>
         <CALCETrWZf5sNmXU=yP1ZHxiBi=Z9d3G5FnWH08PasniG1hs26g@mail.gmail.com>
In-Reply-To: <CALCETrWZf5sNmXU=yP1ZHxiBi=Z9d3G5FnWH08PasniG1hs26g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B090495D7E53534584397EBEDCE5DC4B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEyLTA2IGF0IDEwOjUyIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIFdlZCwgRGVjIDUsIDIwMTggYXQgMTI6NTIgQU0gTmFkYXYgQW1pdCA8bmFtaXRAdm13
YXJlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gV2hlbiBtb2R1bGUgbWVtb3J5IGlzIGFib3V0IHRv
IGJlIGZyZWVkLCB0aGVyZSBpcyBubyBhcHBhcmVudCByZWFzb24gdG8NCj4gPiBtYWtlIGl0IChh
bmQgaXRzIGRhdGEpIGV4ZWN1dGFibGUsIGJ1dCB0aGF0J3MgZXhhY3RseSB3aGF0IGlzIGRvbmUN
Cj4gPiB0b2RheS4gVGhpcyBpcyBub3QgZWZmaWNpZW50IGFuZCBub3Qgc2VjdXJlLg0KPiA+IA0K
PiA+IFRoZXJlIGFyZSB2YXJpb3VzIHRoZW9yaWVzIHdoeSBpdCB3YXMgZG9uZSwgYnV0IG5vbmUg
b2YgdGhlbSBzZWVtIGFzDQo+ID4gc29tZXRoaW5nIHRoYXQgcmVhbGx5IHJlcXVpcmUgaXQgdG9k
YXkuIG5pb3MyIHVzZXMga21hbGxvYyBmb3IgbW9kdWxlDQo+ID4gbWVtb3J5LCBidXQgYW55aG93
IGl0IGRvZXMgbm90IGNoYW5nZSB0aGUgUFRFcyBvZiB0aGUgbW9kdWxlIG1lbW9yeS4gIEluDQo+
ID4geDg2LCBjaGFuZ2luZyB2bWFsbG9jJ2QgbWVtb3J5IG1hcHBpbmdzIGFsc28gbW9kaWZpZXMg
dGhlIGRpcmVjdCBtYXBwaW5nDQo+ID4gYWxpYXMsIGJ1dCB0aGUgTlgtYml0IGlzIG5vdCBtb2Rp
ZmllZCBpbiBzdWNoIHdheS4NCj4gPiANCj4gPiBTbyBsZXQncyByZW1vdmUgaXQuIEFuZHkgc3Vn
Z2VzdGVkIHRoYXQgdGhlIGNoYW5nZXMgb2YgdGhlIFBURXMgY2FuIGJlDQo+ID4gYXZvaWRlZCAo
ZXhjbHVkaW5nIHRoZSBkaXJlY3QtbWFwcGluZyBhbGlhcyksIHdoaWNoIGlzIHRydWUuIEhvd2V2
ZXIsDQo+ID4gaW4geDg2IGl0IHJlcXVpcmVzIHNvbWUgY2xlYW51cCBvZiB0aGUgY29udGlndW91
cyBwYWdlIGFsbG9jYXRvciwgd2hpY2gNCj4gPiBpcyBvdXRzaWRlIG9mIHRoZSBzY29wZSBvZiB0
aGlzIHBhdGNoLXNldC4NCj4gPiANCj4gDQo+IA0KPiBJJ20gb2theSB3aXRoIHRoaXMsIGJ1dCBJ
J2QgbGlrZSB0byBzZWUgUmljaydzIHN0dWZmIGdldCByZWJhc2VkIG9uDQo+IHRvcCBvZiBpdCBh
bmQgY2xlYW4gaXQgdXAgZm9yIHJlYWwuDQoNCk5hZGF2LA0KDQpIbW0sIHNpbmNlIHlvdSBhcmUg
dHJ5aW5nIHRvIG1vdmUgdGhpbmdzIGZvcndhcmQgYW5kIG5vdCBjbG9zZSBhbGwgY2FzZXMgaW4g
b25lDQpzd29vcCwgd291bGQgaXQgbWFrZSBzZW5zZSB0byBzcGxpdCB0aGUgbW9kdWxlcyBXXlgg
bWlzc2lvbiBmcm9tIHRoaXMgcGF0Y2hzZXQ/DQoNClRoYW5rcywNCg0KUmljaw0K
