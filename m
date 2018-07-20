Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6659ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE78206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE78206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeGTOvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:51:10 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:52817 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731251AbeGTOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:51:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-66-JFayXUxPN7S2dd8x1JXDmQ-1; Fri, 20 Jul 2018 15:02:40 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 20 Jul 2018 15:04:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Jul 2018 15:04:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tetsuo Handa' <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] sched/debug: Use terse backtrace for idly sleeping
 threads.
Thread-Topic: [RFC PATCH] sched/debug: Use terse backtrace for idly sleeping
 threads.
Thread-Index: AQHUIC2ngU0bg56Z6USLgctTBymlGKSYItEA
Date:   Fri, 20 Jul 2018 14:04:19 +0000
Message-ID: <2802327e499a43cf832d84237436959c@AcuMS.aculab.com>
References: <1532007443-3538-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180719134653.GH2476@hirez.programming.kicks-ass.net>
 <54fc7ab8-2995-e864-7f74-c4434d23622c@i-love.sakura.ne.jp>
In-Reply-To: <54fc7ab8-2995-e864-7f74-c4434d23622c@i-love.sakura.ne.jp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: JFayXUxPN7S2dd8x1JXDmQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGV0c3VvIEhhbmRhDQo+IFNlbnQ6IDIwIEp1bHkgMjAxOCAxNDoyNw0KPiANCj4gT24g
MjAxOC8wNy8xOSAyMjo0NiwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gT24gVGh1LCBKdWwg
MTksIDIwMTggYXQgMTA6Mzc6MjNQTSArMDkwMCwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+PiBU
aGlzIHBhdGNoIGNhbiBiZSBhcHBsaWVkIGJlZm9yZSBwcm9wb3NpbmcgYWJvdmVtZW50aW9uZWQg
Y2hhbmdlcy4NCj4gPj4gU2luY2UgdGhlcmUgYXJlIG1hbnkga2VybmVsIHRocmVhZHMgd2hvc2Ug
YmFja3RyYWNlIGlzIGJvcmluZyBkdWUgdG8gaWRseQ0KPiA+PiB3YWl0aW5nIGZvciBhbiBldmVu
dCBpbnNpZGUgdGhlIG1haW4gbG9vcCwgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEga2VybmVsDQo+
ID4+IGNvbmZpZyBvcHRpb24gKHdoaWNoIGFsbG93cyBTeXNScS10IHRvIHVzZSBvbmUtbGluZXIg
YmFja3RyYWNlIGZvciB0aHJlYWRzDQo+ID4+IGlkbHkgd2FpdGluZyBmb3IgYW4gZXZlbnQpIGFu
ZCBzaW1wbGUgaGVscGVycyAod2hpY2ggYWxsb3cgY3VycmVudCB0aHJlYWQNCj4gPj4gdG8gZGVj
bGFyZSB0aGF0IGN1cnJlbnQgdGhyZWFkIGlzIGFib3V0IHRvIHN0YXJ0L2VuZCBpZGx5IHdhaXRp
bmcpLg0KDQpBIGtlcm5lbCBjb25maWcgb3B0aW9uIGlzbid0IHRoZSByaWdodCBwbGFjZSB0byBz
ZWxlY3QgdGhpcy4NCkRpc3Ryb3Mgd2lsbCBidWlsZCBrZXJuZWxzIHdpdGggdGhlICd3cm9uZycg
dmFsdWUuDQoNCkluIGFueSBjYXNlIGl0IGlzIHVzdWFsbHkgZWFzaWVyIHRvIHJlYWQgL3Byb2Mv
bm5uL3N0YWNrIG9mIHRoZSBwcm9jZXNzDQp5b3UgYXJlIGludGVyZXN0ZWQgaXQgcmF0aGVyIHRo
YW4gd3JpdGUgYWxsIG9mIHRoZW0gdG8gdGhlIGtlcm5lbCBtZXNzYWdlDQpidWZmZXIgYW5kIGZp
bmQgdGhhdCBpdCBpcyBmYXIgdG9vIHNtYWxsLg0KDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Jhc2UvZGV2dG1wZnMuYyBiL2RyaXZlcnMvYmFzZS9kZXZ0bXBmcy5jDQo+ID4+IGluZGV4IGY3
NzY4MDcuLjZiOGM4YmQgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvYmFzZS9kZXZ0bXBmcy5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvYmFzZS9kZXZ0bXBmcy5jDQo+ID4+IEBAIC00MDYsNyArNDA2
LDkgQEAgc3RhdGljIGludCBkZXZ0bXBmc2Qodm9pZCAqcCkNCj4gPj4gIAkJfQ0KPiA+PiAgCQlf
X3NldF9jdXJyZW50X3N0YXRlKFRBU0tfSU5URVJSVVBUSUJMRSk7DQo+ID4+ICAJCXNwaW5fdW5s
b2NrKCZyZXFfbG9jayk7DQo+ID4+ICsJCXN0YXJ0X2lkbGVfc2xlZXBpbmcoKTsNCj4gPj4gIAkJ
c2NoZWR1bGUoKTsNCj4gPj4gKwkJZW5kX2lkbGVfc2xlZXBpbmcoKTsNCj4gPj4gIAl9DQo+ID4+
ICAJcmV0dXJuIDA7DQo+ID4+ICBvdXQ6DQo+ID4NCj4gPiBTbyBJIF9yZWFsbHlfIGhhdGUgdGhl
IGlkZWEgb2Ygc3ByaW5raW5nIHRoYXQgYWxsIGFyb3VuZCB0aGUga2VybmVsIGxpa2UNCj4gPiB0
aGlzLg0KPiA+DQo+IA0KPiBEb2VzIHRoYXQgY29tbWVudCBtZWFuIHRoZSBpZGVhIG9mICJ1c2lu
ZyBvbmUtbGluZXIgYmFja3RyYWNlIGZvciB0aHJlYWRzDQo+IGlkbHkgd2FpdGluZyBmb3IgYW4g
ZXZlbnQiIGl0c2VsZiBpcyBPSz8NCg0KQXJlbid0IHN1Y2ggc3RhY2sgdHJhY2VzIGxpa2VseSB0
byBiZSBzaG9ydCBvbmVzIGFueXdheT8NCkVpdGhlciB0aGF0IG9yIHlvdSBhY3R1YWxseSB3YW50
IHRvIGtub3cgd2hlcmUgaXQgaXMgcmVhbGx5IHdhaXRpbmcuDQoNCj4gU2luY2UgdGhlcmUgYWxy
ZWFkeSBpcyBzY2hlZHVsZV9pZGxlKCkgZnVuY3Rpb24sIGludHJvZHVjaW5nIGlkbHlfc2NoZWR1
bGUoKQ0KPiBldGMuIGlzIHZlcnkgY29uZnVzaW5nLiBXaGF0IEknbSB0cnlpbmcgdG8gZG8gaXMg
dG8gdGVsbCBkZWJ1ZyBmdW5jdGlvbiB0aGF0DQo+ICJJJ20gY3VycmVudGx5IGluIG5ldXRyYWwg
c2l0dWF0aW9uIGFuZCBoZW5jZSBkdW1waW5nIG15IGJhY2t0cmFjZSB3aWxsIG5vdA0KPiBnaXZl
IHlvdSBpbnRlcmVzdGluZyByZXN1bHQiLiBTaW5jZSBzdWNoIHNlY3Rpb24gbmVlZHMgdG8gYmUg
Y2FyZWZ1bGx5DQo+IGFubm90YXRlZCB3aXRoIGNvbW1lbnRzLCBJIHRoaW5rIHRoYXQgbG9ja2Rl
cC1saWtlIGFubm90YXRpb24gZml0cyBiZXR0ZXINCj4gdGhhbiBpbnRyb2R1Y2luZyB3cmFwcGVk
IGZ1bmN0aW9ucy4NCg0KT3IgdXNlIGV4dHJhIGJpdHMgb2YgY3VycmVudC0+c3RhdGUgc2V0IGJ5
IHNldF9jdXJyZW50X3N0YXRlKCkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

