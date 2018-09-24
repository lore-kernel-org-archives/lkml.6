Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07EE214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07EE214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeIYDcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:32:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:1704 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeIYDcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:32:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 14:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,299,1534834800"; 
   d="scan'208";a="72544072"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga007.fm.intel.com with ESMTP; 24 Sep 2018 14:28:00 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 24 Sep 2018 14:28:00 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.89]) with mapi id 14.03.0319.002;
 Mon, 24 Sep 2018 14:28:00 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v6 2/4] x86/modules: Increase randomization for modules
Thread-Topic: [PATCH v6 2/4] x86/modules: Increase randomization for modules
Thread-Index: AQHUS6nwBsySFaAeZU6Tsy01ge2+q6T7mgWAgAS1CwCAABD7gIAAGQyA
Date:   Mon, 24 Sep 2018 21:27:59 +0000
Message-ID: <1537824509.19013.63.camel@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
         <1536874298-23492-3-git-send-email-rick.p.edgecombe@intel.com>
         <CAGXu5jJ9nZYbVn5xdi7nsMJRD6ScLeWP2DWjrD8yEfwi-XXcRw@mail.gmail.com>
         <1537815484.19013.48.camel@intel.com>
         <CAGXu5jKho6Ui0sP6-4FN=i6zZ1+gXcd9Zyctqhvg+4r1cz-Mqw@mail.gmail.com>
In-Reply-To: <CAGXu5jKho6Ui0sP6-4FN=i6zZ1+gXcd9Zyctqhvg+4r1cz-Mqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD2C558B1FC37546962D0EAC9E8E4E4F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTI0IGF0IDEyOjU4IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IE1vbiwgU2VwIDI0LCAyMDE4IGF0IDExOjU3IEFNLCBFZGdlY29tYmUsIFJpY2sgUA0KPiA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gSW5zdGVhZCBvZiBoYXZpbmcg
dHdvIG9wZW4tY29kZWQgX192bWFsbG9jX25vZGVfcmFuZ2UoKSBjYWxscyBsZWZ0IGluDQo+ID4g
PiB0aGlzIGFmdGVyIHRoZSBjaGFuZ2UsIGNhbiB0aGlzIGJlIGRvbmUgaW4gdGVybXMgb2YgYSBj
YWxsIHRvDQo+ID4gPiB0cnlfbW9kdWxlX2FsbG9jKCkgaW5zdGVhZD8gSSBzZWUgdGhleSdyZSBz
bGlnaHRseSBkaWZmZXJlbnQsIGJ1dCBpdA0KPiA+ID4gbWlnaHQgYmUgbmljZSBmb3IgbWFraW5n
IHRoZSB0d28gcGF0aHMgc2hhcmUgbW9yZSBjb2RlLg0KPiA+IE5vdCBzdXJlIHdoYXQgeW91IG1l
YW4uIEFjcm9zcyB0aGUgd2hvbGUgY2hhbmdlLCB0aGVyZSBpcyBvbmUgY2FsbA0KPiA+IHRvIF9f
dm1hbGxvY19ub2RlX3JhbmdlLCBhbmQgb25lIHRvIF9fdm1hbGxvY19ub2RlX3RyeV9hZGRyLg0K
PiBJIGd1ZXNzIEkgbWVhbnQgdGhlIHZtYWxsb2MgY2FsbHMgLS0gb25lIGZvciBub2RlX3Jhbmdl
IGFuZCBvbmUgZm9yDQo+IG5vZGVfdHJ5X2FkZHIuIEkgd2FzIHdvbmRlcmluZyBpZiB0aGUgbG9n
aWMgY291bGQgYmUgY29tYmluZWQgaW4gc29tZQ0KPiB3YXkgc28gdGhhdCB0aGUgX192bWFsbG9j
X25vZGVfcmFuZ2UoKSBjb3VsZCBiZSBtYWRlIGluIHRlcm1zIG9mIHRoZQ0KPiB0aGUgaGVscGVy
IHRoYXQgdHJ5X21vZHVsZV9yYW5kb21pemVfZWFjaCgpIHVzZXMuIEJ1dCB0aGlzIGNvdWxkIGp1
c3QNCj4gYmUgbWUgaG9waW5nIGZvciBuaWNlLXRvLXJlYWQgY2hhbmdlcy4gOykNCj4gDQo+IC1L
ZWVzDQpPbmUgdGhpbmcgSSBoYWQgYmVlbiBjb25zaWRlcmluZyB3YXMgdG8gbW92ZSB0aGUgd2hv
bGUgInRyeSByYW5kb20gbG9jYXRpb25zLA0KdGhlbiB1c2UgYmFja3VwIiBsb2dpYyB0byB2bWFs
bG9jLmMsIGFuZCBqdXN0IGhhdmUgcGFyYW1ldGVycyBmb3IgcmFuZG9tIGFyZWENCnNpemUsIG51
bWJlciBvZiB0cmllcywgZXRjLiBUaGlzIHdheSBpdCBjb3VsZCBiZSBwb3NzaWJseSBiZSByZS11
c2VkIGZvciBvdGhlcg0KYXJjaGl0ZWN0dXJlcyBmb3IgbW9kdWxlcy4gQWxzbyBvbiBvdXIgbGlz
dCBpcyB0byBsb29rIGF0IHJhbmRvbWl6aW5nIHZtYWxsb2MNCnNwYWNlIChlc3BlY2lhbGx5IHN0
YWNrcyksIHdoaWNoIG1heSBvciBtYXkgbm90IGludm9sdmUgdXNpbmcgYSBzaW1pbGFyIG1ldGhv
ZC4NCg0KU28gbWF5YmUgYml0IHByZS1tYXR1cmUgcmVmYWN0b3JpbmcsIGJ1dCB3b3VsZCBhbHNv
IGNsZWFuIHVwIHRoZSBjb2RlIGluDQptb2R1bGUuYy4gRG8geW91IHRoaW5rIGl0IHdvdWxkIGJl
IHdvcnRoIGl0Pw0KDQpUaGFua3MsDQoNClJpY2s=
