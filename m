Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC18020892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC18020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeKHFfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:35:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:3215 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeKHFfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:35:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 12:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,476,1534834800"; 
   d="scan'208";a="106311544"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2018 12:03:58 -0800
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 12:03:56 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.114]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 12:03:55 -0800
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
Subject: Re: [PATCH v8 2/4] x86/modules: Increase randomization for modules
Thread-Topic: [PATCH v8 2/4] x86/modules: Increase randomization for modules
Thread-Index: AQHUcuJ7dRNa9BxcYEKh1HD163He3aVDyT8AgAGBqQA=
Date:   Wed, 7 Nov 2018 20:03:49 +0000
Message-ID: <68d41324607f1169fcdfee95d95a25b4f4e772a3.camel@intel.com>
References: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
         <20181102192520.4522-3-rick.p.edgecombe@intel.com>
         <20181106130532.1ef8e080baeedfa0960eebd4@linux-foundation.org>
In-Reply-To: <20181106130532.1ef8e080baeedfa0960eebd4@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA46A8C359EDEA489B36D199FF38D22D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTA2IGF0IDEzOjA1IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBGcmksICAyIE5vdiAyMDE4IDEyOjI1OjE4IC0wNzAwIFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IFRoaXMgY2hhbmdlcyB0
aGUgYmVoYXZpb3Igb2YgdGhlIEtBU0xSIGxvZ2ljIGZvciBhbGxvY2F0aW5nIG1lbW9yeSBmb3Ig
dGhlDQo+ID4gdGV4dA0KPiA+IHNlY3Rpb25zIG9mIGxvYWRhYmxlIG1vZHVsZXMuIEl0IHJhbmRv
bWl6ZXMgdGhlIGxvY2F0aW9uIG9mIGVhY2ggbW9kdWxlIHRleHQNCj4gPiBzZWN0aW9uIHdpdGgg
YWJvdXQgMTcgYml0cyBvZiBlbnRyb3B5IGluIHR5cGljYWwgdXNlLiBUaGlzIGlzIGVuYWJsZWQg
b24NCj4gPiBYODZfNjQNCj4gPiBvbmx5LiBGb3IgMzIgYml0LCB0aGUgYmVoYXZpb3IgaXMgdW5j
aGFuZ2VkLg0KPiA+IA0KPiA+IEl0IHJlZmFjdG9ycyBleGlzdGluZyBjb2RlIGFyb3VuZCBtb2R1
bGUgcmFuZG9taXphdGlvbiBzb21ld2hhdC4gVGhlcmUgYXJlDQo+ID4gbm93DQo+ID4gdGhyZWUg
ZGlmZmVyZW50IGJlaGF2aW9ycyBmb3IgeDg2IG1vZHVsZV9hbGxvYyBkZXBlbmRpbmcgb24gY29u
ZmlnLg0KPiA+IFJBTkRPTUlaRV9CQVNFPW4sIGFuZCBSQU5ET01JWkVfQkFTRT15IEFSQ0g9eDg2
XzY0LCBhbmQgUkFORE9NSVpFX0JBU0U9eQ0KPiA+IEFSQ0g9aTM4Ni4NCj4gPiANCj4gPiBUaGUg
cmVmYWN0b3Igb2YgdGhlIGV4aXN0aW5nIGNvZGUgaXMgdG8gdHJ5IHRvIGNsZWFybHkgc2hvdyB3
aGF0DQo+ID4gdGhvc2UgYmVoYXZpb3JzIGFyZSB3aXRob3V0IGhhdmluZyB0aHJlZSBzZXBhcmF0
ZSB2ZXJzaW9ucyBvciB0aHJlYWRpbmcgdGhlDQo+ID4gYmVoYXZpb3JzIGluIGEgYnVuY2ggb2Yg
bGl0dGxlIHNwb3RzLiBUaGUgcmVhc29uIGl0IGlzIG5vdCBlbmFibGVkIG9uIDMyIGJpdA0KPiA+
IHlldCBpcyBiZWNhdXNlIHRoZSBtb2R1bGUgc3BhY2UgaXMgbXVjaCBzbWFsbGVyIGFuZCBzaW11
bGF0aW9ucyBoYXZlbid0IGJlZW4NCj4gPiBydW4gdG8gc2VlIGhvdyBpdCBwZXJmb3Jtcy4NCj4g
PiANCj4gPiBUaGUgbmV3IGFsZ29yaXRobSBicmVha3MgdGhlIG1vZHVsZSBzcGFjZSBpbiB0d28s
IGEgcmFuZG9tIGFyZWEgYW5kIGEgYmFja3VwDQo+ID4gYXJlYS4gSXQgZmlyc3QgdHJpZXMgdG8g
YWxsb2NhdGUgYXQgYSBudW1iZXIgb2YgcmFuZG9tbHkgbG9jYXRlZCBzdGFydGluZw0KPiA+IHBh
Z2VzDQo+ID4gaW5zaWRlIHRoZSByYW5kb20gc2VjdGlvbiB3aXRob3V0IHB1cmdpbmcgYW55IGxh
enkgZnJlZSB2bWFwIGFyZWFzIGFuZA0KPiA+IHRyaWdnZXJpbmcgdGhlIGFzc29jaWF0ZWQgVExC
IGZsdXNoLg0KPiBTdXJwcmlzZWQuICBJcyBvbmUgVExCIGZsdXNoIHBlciBtb2R1bGUgbG9hZGlu
ZyBzdWZmaWNpZW50bHkgZXhwZW5zaXZlDQo+IHRvIGp1c3RpZnkgYW55IGVmZm9ydCB0byBhdm9p
ZCBpdD8gIElPVywgcGxlYXNlIHByb3ZpZGUgc29tZQ0KPiBqdXN0aWZpY2F0aW9uIGFuZCBleHBs
YW5hdGlvbiBpbiB0aGUgY2hhbmdlbG9nLg0KSSdsbCBmaXggdGhpcy4gVGhlIHRleHQgaXMgYWNj
dXJhdGUsIGJ1dCBtaXNsZWFkaW5nIGluIGNvbW11bmljYXRpbmcgdGhlDQppbnRlbnRpb25zIGJl
Y2F1c2UgaXQgd2FzIGxlZnQgb3ZlciBmcm9tIGFuIGVhcmxpZXIgdmVyc2lvbi4gU29ycnkgYWJv
dXQgdGhhdC4NCg0KSSB0aGluayB0aGUgcGVyZm9ybWFuY2UgYmVuZWZpdCBtaWdodCBjb21lIG1v
cmUgZnJvbSBhdm9pZGluZyB0aGUgcmV0cnkgaW4NCnZtYWxsb2MsIHRoYW4gdGhlIFRMQiBmbHVz
aC4gSW4gdGhlIG90aGVyIG1haWwgSSBwb3N0ZWQgc29tZSBiZW5jaG1hcmtzLg0KDQo+ID4gSWYg
dGhpcyBmYWlscywgdGhlbiBpdCB3aWxsIGFsbG9jYXRlIGluDQo+ID4gdGhlIGJhY2t1cCBhcmVh
LiBUaGUgYmFja3VwIGFyZWEgYmFzZSB3aWxsIGJlIG9mZnNldCBpbiB0aGUgc2FtZSB3YXkgYXMg
dGhlDQo+ID4gY3VycmVudCBhbGdvcml0aG0gZG9lcyBmb3IgdGhlIGJhc2UgYXJlYSwgMTAyNCBw
b3NzaWJsZSBsb2NhdGlvbnMuDQo+IA0KPiBTbyBwcmVzdW1hYmx5IHRoZSBhbGxvY2F0aW9uIGVm
Zm9ydCBpbiB0aGUgcmFuZG9taXplZCBzZWN0aW9uIGlzDQo+IHNvbWV3aGF0IGxpa2VseSB0byBm
YWlsLiAgVGhhdCdzIHVuZm9ydHVuYXRlLiAgU29tZSBkaXNjdXNzaW9uIGFib3V0DQo+IHdoeSB0
aGVzZSBmYWlsdXJlcyBvY2N1ciB3b3VsZCBiZSBoZWxwZnVsLg0KPiANCj4gQmVjYXVzZSBpdCB3
b3VsZCBiZSBuaWNlIHRvIGRvIGF3YXkgd2l0aCB0aGUgYmFja3VwIGFyZWEgYWx0b2dldGhlci4g
DQo+IEJ1dCB0aGlzIHJlYWRlciBkb2Vzbid0IHJlYWxseSB1bmRlcnN0YW5kIHdoeSB0aGUgYmFj
a3VwIGFyZWEgaXMNCj4gbmVlZGVkLg0KV2l0aCB0aGUgaGlnaCAxMDAwMCBudW1iZXIgdHJpZXMs
IGl0IHVzdWFsbHkgb25seSBmYWlscyBmb3IgbGFyZ2VyIG1vZHVsZXMgdW50aWwNCnRoZSBtb2R1
bGUgc3BhY2Ugc3RhcnRzIHRvIGdldCBmdWxsZXIuIEEgY29uY3JldGUgdXNlIGNhc2UgZm9yIHRo
ZSBiYWNrdXAgYXJlYQ0KaXMgd2hlbiB0aGUgcmFuZG9tIGFyZWEgaXMgZnJhZ21lbnRlZCB3aXRo
IEJQRiBmaWx0ZXJzLCBhbmQgdGhlbiB0aGUgdXNlciB0cmllcw0KdG8gbG9hZCBhIGxhcmdlIG1v
ZHVsZS4NCg0KRm9yIGV4YW1wbGUgaW1hZ2luZSBpZiB5b3UgaGFkIHRoZSBmdWxsIDFHQiBvZiBt
b2R1bGUgc3BhY2UgYXMgdGhlIHJhbmRvbSBhcmVhLg0KSWYgeW91IGhhdmUgMTAwMCBCUEYgZmls
dGVycyBpbnNlcnRlZCwgYW5kIHRoZXkgZW5kZWQgdXAgYmVpbmcgZXZlbmx5DQpkaXN0cmlidXRl
ZCwgMUdCLzEwMDA9MU1CLCBhbmQgc28geW91IGNvdWxkbid0IGxvYWQgYW55IG1vZHVsZXMgb3Zl
ciAxTUIuIFdpdGgNCjIwMDAsIDAuNSBNQiwgZXRjLg0KDQpUaGUgMi8zOjEvMyBicmVha2Rvd24g
d2FzIGNob3NlbiBhcyBteSBiZXN0IGd1ZXNzIGF0IHRoZSBiZXN0IHRyYWRlb2ZmIG9mDQpmcmFn
bWVudGF0aW9uIHNhZmV0eSBhbmQgZW50cm9weS4NCg0KPiA+IER1ZSB0byBib290X3BhcmFtcyBi
ZWluZyBkZWZpbmVkIHdpdGggZGlmZmVyZW50IHR5cGVzIGluIGRpZmZlcmVudCBwbGFjZXMsDQo+
ID4gcGxhY2luZyB0aGUgY29uZmlnIGhlbHBlcnMgbW9kdWxlcy5oIG9yIGthc2xyLmggY2F1c2Vk
IGNvbmZsaWN0cyBlbHNld2hlcmUsDQo+ID4gYW5kDQo+ID4gc28gdGhleSBhcmUgcGxhY2VkIGlu
IGEgbmV3IGZpbGUsIGthc2xyX21vZHVsZXMuaCwgaW5zdGVhZC4NCj4gPiANCj4gDQo+IA0K
