Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ABF21A59
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ABF21A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbeFUS4Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:56:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:23944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932795AbeFUS4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:56:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 11:56:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="50861210"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 21 Jun 2018 11:56:14 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.228]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.125]) with mapi id 14.03.0319.002;
 Thu, 21 Jun 2018 11:56:14 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 0/3] KASLR feature to randomize each loadable module
Thread-Topic: [PATCH 0/3] KASLR feature to randomize each loadable module
Thread-Index: AQHUCONeyLbHxTjLAESY6iRZ+j5QhqRqMQ8AgAFVooA=
Date:   Thu, 21 Jun 2018 18:56:13 +0000
Message-ID: <1529607389.29548.198.camel@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
         <CAGXu5jLt8Zv-p=9J590WFppc3O6LWrAVdi-xtU7r_8f4j0XeRg@mail.gmail.com>
In-Reply-To: <CAGXu5jLt8Zv-p=9J590WFppc3O6LWrAVdi-xtU7r_8f4j0XeRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.197.56]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D28BD85D7D013B418334AAC8068AE927@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTIwIGF0IDE1OjMzIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
VGhlIG5ldyBfX3ZtYWxsb2Nfbm9kZV90cnlfYWRkciBmdW5jdGlvbiB1c2VzIHRoZSBleGlzdGlu
ZyBmdW5jdGlvbg0KPiA+IF9fdm1hbGxvY19ub2RlX3JhbmdlLCBpbiBvcmRlciB0byBpbnRyb2R1
Y2UgdGhpcyBhbGdvcml0aG0gd2l0aCB0aGUNCj4gPiBsZWFzdA0KPiA+IGludmFzaXZlIGNoYW5n
ZS4gVGhlIHNpZGUgZWZmZWN0IGlzIHRoYXQgZWFjaCB0aW1lIHRoZXJlIGlzIGENCj4gPiBjb2xs
aXNpb24gd2hlbg0KPiA+IHRyeWluZyB0byBhbGxvY2F0ZSBpbiB0aGUgcmFuZG9tIGFyZWEgYSBU
TEIgZmx1c2ggd2lsbCBiZQ0KPiA+IHRyaWdnZXJlZC4gVGhlcmUgaXMNCj4gPiBhIG1vcmUgY29t
cGxleCwgbW9yZSBlZmZpY2llbnQgaW1wbGVtZW50YXRpb24gdGhhdCBjYW4gYmUgdXNlZA0KPiA+
IGluc3RlYWQgaWYNCj4gPiB0aGVyZSBpcyBpbnRlcmVzdCBpbiBpbXByb3ZpbmcgcGVyZm9ybWFu
Y2UuDQo+IFRoZSBvbmx5IHRpbWUgd2hlbiBtb2R1bGUgbG9hZGluZyBzcGVlZCBpcyBub3RpY2Vh
YmxlLCBJIHdvdWxkIHRoaW5rLA0KPiB3b3VsZCBiZSBib290IHRpbWUuIEhhdmUgeW91IGRvbmUg
YW55IGJvb3QgdGltZSBkZWx0YSBhbmFseXNpcz8gSQ0KPiB3b3VsZG4ndCBleHBlY3QgaXQgdG8g
Y2hhbmdlIGhhcmRseSBhdCBhbGwsIGJ1dCBpdCdzIHByb2JhYmx5IGEgZ29vZA0KPiBpZGVhIHRv
IGFjdHVhbGx5IHRlc3QgaXQuIDopDQoNClRoYW5rcywgSSdsbCBkbyBzb21lIHRlc3RzLg0KDQo+
IEFsc286IGNhbiB0aGlzIGJlIGdlbmVyYWxpemVkIGZvciB1c2Ugb24gb3RoZXIgS0FTTFJlZCBh
cmNoaXRlY3R1cmVzPw0KPiBGb3IgZXhhbXBsZSwgSSBrbm93IHRoZSBhcm02NCBtb2R1bGUgcmFu
ZG9taXphdGlvbiBpcyBwcmV0dHkgc2ltaWxhcg0KPiB0byB4ODYuDQoNCkkgc3RhcnRlZCBpbiB0
aGUgeDg2L2tlcm5lbC9tb2R1bGUuYyBiZWNhdXNlIHRoYXQgd2FzIHdoZXJlIHRoZQ0KZXhpc3Rp
bmcgaW1wbGVtZW50YXRpb24gd2FzLCBidXQgSSBkb24ndCBrbm93IG9mIGFueSByZWFzb24gd2h5
DQppdMKgY291bGQgbm90IGFwcGx5IHRvIG90aGVyIGFyY2hpdGVjdHVyZXMgaW4gZ2VuZXJhbC4N
Cg0KVGhlIHJhbmRvbW5lc3MgZXN0aW1hdGVzIHdvdWxkIGJlIGRpZmZlcmVudCBpZiBtb2R1bGUg
c2l6ZSBwcm9iYWJpbGl0eQ0KZGlzdHJpYnV0aW9uLCBtb2R1bGUgc3BhY2Ugc2l6ZSBvciBtb2R1
bGUgYWxpZ25tZW50IGFyZSBkaWZmZXJlbnQuDQoNCg==
