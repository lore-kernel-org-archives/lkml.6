Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1A12081B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfBTQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:44:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:38036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTQoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:44:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 08:44:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="117707467"
Received: from kmsmsx156.gar.corp.intel.com ([172.21.138.133])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2019 08:44:03 -0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.107]) by
 KMSMSX156.gar.corp.intel.com ([169.254.1.240]) with mapi id 14.03.0415.000;
 Thu, 21 Feb 2019 00:44:02 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Thread-Topic: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Thread-Index: AQHUxN2S4q+yUIjeC0iMAHeR7ONaRaXmasgAgAH8UQA=
Date:   Wed, 20 Feb 2019 16:44:02 +0000
Message-ID: <cf6926800899354808143bd48b4f943629c8cbe7.camel@intel.com>
References: <20190206154214.576-1-harry.pan@intel.com>
         <20190214111543.22137-1-harry.pan@intel.com>
         <2819109.DzhZvocLkm@aspire.rjw.lan>
In-Reply-To: <2819109.DzhZvocLkm@aspire.rjw.lan>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.174.137]
Content-Type: text/plain; charset="utf-8"
Content-ID: <049D91B807C2F34CBA69D2B978011800@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBjb21tZW50cy4NCg0KPiA+ICsJaWYgKCFJU19FTkFCTEVEKENPTkZJR19TVVNQ
RU5EX1NLSVBfU1lOQykpIHsNCj4gPiArCQlrdGltZV90IHN0YXJ0Ow0KPiA+ICsJCXVuc2lnbmVk
IGludCBlbGFwc2VkX21zZWNzOw0KPiA+ICsNCj4gPiArCQl0cmFjZV9zdXNwZW5kX3Jlc3VtZShU
UFMoInN5bmNfZmlsZXN5c3RlbXMiKSwgMCwgdHJ1ZSk7DQo+ID4gKwkJcHJfaW5mbygiU3luY2lu
ZyBmaWxlc3lzdGVtcyAuLi4gIik7DQo+ID4gKwkJc3RhcnQgPSBrdGltZV9nZXQoKTsNCj4gPiAr
CQlrc3lzX3N5bmMoKTsNCj4gPiArCQllbGFwc2VkX21zZWNzID0ga3RpbWVfdG9fbXMoa3RpbWVf
c3ViKGt0aW1lX2dldCgpLA0KPiA+IHN0YXJ0KSk7DQo+ID4gKwkJcHJfY29udCgiKGVsYXBzZWQg
JWQuJTAzZCBzZWNvbmRzKSBkb25lLlxuIiwNCj4gPiArCQkJZWxhcHNlZF9tc2VjcyAvIE1TRUNf
UEVSX1NFQywNCj4gPiArCQkJZWxhcHNlZF9tc2VjcyAlIE1TRUNfUEVSX1NFQyk7DQo+IA0KPiBP
bmUgbW9yZSBuaXQuDQo+IA0KPiBTaW5jZSB5b3UgYXJlIHByaW50aW5nIHRoZSBzeW5jIHRpbWUg
YW55d2F5LCB0aGVyZSBpcyBhIGxpdHRsZSBzZW5zZQ0KPiB0bw0KPiBzcGxpdCB0aGUgbWVzc2Fn
ZSB1c2luZyBwcl9jb250KCkgdGhhdCBtYXkgYmUgbWVzc2VkIHVwIHdpdGggYnkgYW55DQo+IGlu
dGVydmVuaW5nIG1lc3NhZ2VzLCBzbyB3aHkgZG9uJ3QgeW91IGp1c3QgcHJpbnQgYSBvbmUtbGlu
ZQ0KPiBwcl9pbmZvKCJGaWxlc3lzdGVtcyBzeW5jOiAlZC4lMDNkIHNlY29uZHNcbiIsIC4uLikg
bWVzc2FnZT8NCj4gDQpZZXMsIEkgYWdyZWUuDQpJbiBwcmFjdGljYWwsIEkgZGlkIHNlZSBpbnRl
cnZlbmluZyBtZXNzYWdlcyAoYmV0d2VlbiBwcl9pbmZvIGFuZA0KcHJfY29udCkgd2hlbiBpdCBj
YW1lIHRvIGxvbmcgc3luYyBpbiBrZXJuZWwuDQpJIHdhcyBoZXNpdGF0ZWQgaW4gdGhpcyBjb25z
aWRlcmluZyBub3QgZnVsbHkgdW5kZXJzdGFuZGluZyB0aGUNCmJhY2tkcm9wIG9mIHNwbGl0IG1l
c3NhZ2VzIHVzaW5nIHByX2luZm8oKSB0aGVuIHByX2NvbnQoKS4NCg0KPiBBbHNvLCBpZiB5b3Ug
Y2hhbmdlIGl0IGhlcmUsIEkgZ3Vlc3MgaXQgd291bGQgYmUgY29uc2lzdGVudCB0byBtYWtlDQo+
IGFuIGFuYWxvZ291cyBjaGFuZ2UgZm9yIGhpYmVybmF0aW9uLg0KDQpPbmUgcG90ZW50aWFsIGxh
c3QtbWlsZSBuZWVkIHlvdXIgd2lzZG9tLCB3aGljaCBpcyBhYm91dCB0aGUgc3dpdGNoDQpjYXNl
IG9mIFNOQVBTSE9UX0ZSRUVaRSBvZiB0aGUgdXNlcnNwYWNlIGludGVyZmFjZSB5b3Ugd3JvdGUu
DQpJIGFtIHlldCB0byB0b3VjaCBpdCwgbm9yIHVuZGVyc3RhbmQgaG93IHRvIHZhbGlkYXRlIGl0
Lg0KDQpUaGF0IHNhaWQsIEkgYW0gZGlnZXN0aW5nIHlvdXIgZG9jdW1lbnRzIGFuZCBzb3VyY2U7
IEkgdXNlZCB0aGUgcG1fdGVzdA0KZnJvbSB0aGUgZG9jIHRvIHZhbGlkYXRlIHRoZSBwYXRjaCBv
biBoaWJlcm5hdGlvbiBwYXJ0aWFsbHkgZXZlbiBub24gb2YNCm15IGhhbmR5IGxhcHRvbnMgZnVs
bHkgd29yayB3ZWxsIG9uIGl0Lg0KDQoNClNpbmNlcmVseSwNCkhhcnJ5DQo=
