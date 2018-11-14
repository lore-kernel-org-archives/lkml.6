Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BE1223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BE1223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeKOHzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:55:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:47255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOHzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:55:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 13:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="108612006"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2018 13:50:45 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 14 Nov 2018 13:50:44 -0800
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 14 Nov 2018 13:50:44 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.49]) with mapi id 14.03.0415.000;
 Wed, 14 Nov 2018 15:50:43 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/fsgsbase/64: Fix the base write helper functions
Thread-Topic: [PATCH v3] x86/fsgsbase/64: Fix the base write helper functions
Thread-Index: AQHUciIAXxItQExzbEO30SdbbWfIO6VD8UcAgAxWE4CAAAEjgA==
Date:   Wed, 14 Nov 2018 21:50:41 +0000
Message-ID: <6FC83E55-44EC-4FBF-9262-B17901A37227@intel.com>
References: <20181101203129.27494-1-chang.seok.bae@intel.com>
 <CALCETrXCOgBk7oKrE_CAspA6eqC19CfXckgeCcWUjREVHRHRPg@mail.gmail.com>
 <94770318-72C4-442C-B2A3-7C4555884AA9@intel.com>
In-Reply-To: <94770318-72C4-442C-B2A3-7C4555884AA9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.156.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <50B8DB69C9CB664F9F96C572D95077D9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTm92IDYsIDIwMTgsIGF0IDE3OjIzLCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9y
Zz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE5vdiAxLCAyMDE4IGF0IDE6MzIgUE0gQ2hhbmcgUy4g
QmFlIDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+IHdyb3RlOg0KPj4gDQo+PiBAQCAtMzkyLDEy
ICszODQsNyBAQCBpbnQgeDg2X2ZzYmFzZV93cml0ZV90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAq
dGFzaywgdW5zaWduZWQgbG9uZyBmc2Jhc2UpDQo+PiAgICAgICAgaWYgKHVubGlrZWx5KGZzYmFz
ZSA+PSBUQVNLX1NJWkVfTUFYKSkNCj4+ICAgICAgICAgICAgICAgIHJldHVybiAtRVBFUk07DQo+
PiANCj4+IC0gICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQo+PiAgICAgICAgdGFzay0+dGhyZWFk
LmZzYmFzZSA9IGZzYmFzZTsNCj4+IC0gICAgICAgaWYgKHRhc2sgPT0gY3VycmVudCkNCj4+IC0g
ICAgICAgICAgICAgICB4ODZfZnNiYXNlX3dyaXRlX2NwdShmc2Jhc2UpOw0KPj4gLSAgICAgICB0
YXNrLT50aHJlYWQuZnNpbmRleCA9IDA7DQo+PiAtICAgICAgIHByZWVtcHRfZW5hYmxlKCk7DQo+
PiANCj4+ICAgICAgICByZXR1cm4gMDsNCj4+IH0NCj4gDQo+IFNpbWlsYXIgb2JqZWN0aW9uIHRv
IGxhc3QgdGltZS4gIElmIHlvdSBnZXQgcmlkIG9mIHRoZSB0YXNrID09IGN1cnJlbnQNCj4gY2hl
Y2ssIHlvdSBzaG91bGQgV0FSTl9PTl9PTkNFKHRhc2sgIT0gY3VycmVudCkuDQo+IA0KDQpGcm9t
IHlvdXIgcHJldmlvdXMgY29tbWVudHMsIEkgd2FzIGEgYml0IGNvbmZ1c2VkIGJ5IGEgbWl4dHVy
ZSBvZiBvcHRpb25zLiANCkl0IGxvb2tzIGxpa2UgeW914oCZZCBpbnRlbmRlZCB0byBzdWdnZXN0
IHR3byBkaWZmZXJlbnQgd2F5cyAoYnkgb3VyIG93biB3b3Jkcyk6DQoNCjEuIFRoZSBfd3JpdGVf
dGFzaygpIGZ1bmN0aW9ucyBtdXN0IG5vdCBiZSBjYWxsZWQgb24gY3VycmVudC4gIFRoZW4NCnRo
ZXJlIHNob3VsZCBiZSBhIHdhcm5pbmcsIGFuZCB5b3Ugc2hvdWxkbid0IGNhbGwgdGhlbSBvbiBj
dXJyZW50Lg0KDQoyLiBUaGUgX3dyaXRlX3Rhc2soKSBmdW5jdGlvbnMgc2hvdWxkIHdvcmsgY29y
cmVjdGx5IG9uIGN1cnJlbnQuICBJbg0KdGhpcyBjYXNlLCB5b3Ugc2hvdWxkbid0IG5lZWQgdG8g
KmFsc28qIGNhbGxlZCBfd3JpdGVfY3B1IC8NCl93cml0ZV9jcHVfaW5hY3RpdmUuICBZb3UnbGwg
c3RpbGwgbmVlZCB0aGUgc3BlY2lhbCBsb2Fkc2VnIGhhbmRsaW5nDQppbiBkb19hcmNoX3ByY3Rs
XzY0KCkuDQoNClRoZSBvcHRpb24gMSBsb29rcyB0byBiZSBzaW1wbGUgYW5kIHN0cmFpZ2h0IGZv
cndhcmQuIFNvLCBsZXQgbWUgZ28gd2l0aCB0aGF0Lg0KDQpOaXQuIEkgdGhpbmsgaXQgc2hvdWxk
IGJlIFdBUk5fT05fT05DRSh0YXNrID09IGN1cnJlbnQpLg0KDQo+PiBAQCAtNzU4LDExICs3NDAs
NDEgQEAgbG9uZyBkb19hcmNoX3ByY3RsXzY0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgaW50
IG9wdGlvbiwgdW5zaWduZWQgbG9uZyBhcmcyKQ0KPj4gDQo+PiAgICAgICAgc3dpdGNoIChvcHRp
b24pIHsNCj4+ICAgICAgICBjYXNlIEFSQ0hfU0VUX0dTOiB7DQo+PiArICAgICAgICAgICAgICAg
cHJlZW1wdF9kaXNhYmxlKCk7DQo+PiAgICAgICAgICAgICAgICByZXQgPSB4ODZfZ3NiYXNlX3dy
aXRlX3Rhc2sodGFzaywgYXJnMik7DQo+PiArICAgICAgICAgICAgICAgaWYgKHJldCA9PSAwKSB7
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICogQVJDSF9TRVRfR1MgaGFzIGFsd2F5cyBvdmVyd3JpdHRlbiB0aGUgaW5kZXgNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAqIGFuZCB0aGUgYmFzZS4gWmVybyBpcyB0aGUgbW9zdCBz
ZW5zaWJsZSB2YWx1ZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogdG8gcHV0IGluIHRo
ZSBpbmRleCwgYW5kIGlzIHRoZSBvbmx5IHZhbHVlIHRoYXQNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAqIG1ha2VzIGFueSBzZW5zZSBpZiBGU0dTQkFTRSBpcyB1bmF2YWlsYWJsZS4NCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHRhc2sgPT0gY3VycmVudCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBsb2Fkc2VnKEdTLCAwKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeDg2
X2dzYmFzZV93cml0ZV9jcHVfaW5hY3RpdmUoYXJnMik7DQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YXNrLT50
aHJlYWQuZ3NpbmRleCA9IDA7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+PiArICAg
ICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgIHByZWVtcHRfZW5hYmxlKCk7DQo+IA0K
PiBBbmQgeW91IHNob3VsZCBkcm9wIHRoZSByZWR1bmRhbnQgLi4ud3JpdGVfdGFzayBpZiB0YXNr
ID09IGN1cnJlbnQuDQoNClRvIGF2b2lkIHRoZSByZWR1bmRhbmN5LCB0aGUgc2FuaXR5IGNoZWNr
IGZvciBhIGJhc2UgdmFsdWUgY2FuIGJlIG1vdmVkIG91dCBoZXJlLg0KDQo+PiANCj4+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvcHRyYWNlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHRyYWNl
LmMNCj4+IGluZGV4IGZmYWU5Yjk3NDBmZC4uZTRhYjFhYmNhNWI1IDEwMDY0NA0KPj4gLS0tIGEv
YXJjaC94ODYva2VybmVsL3B0cmFjZS5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHRyYWNl
LmMNCj4+IEBAIC0zOTcsMTEgKzM5NywxMSBAQCBzdGF0aWMgaW50IHB1dHJlZyhzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKmNoaWxkLA0KPj4gICAgICAgICAgICAgICAgaWYgKHZhbHVlID49IFRBU0tfU0la
RV9NQVgpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPj4gICAgICAg
ICAgICAgICAgLyoNCj4+IC0gICAgICAgICAgICAgICAgKiBXaGVuIGNoYW5naW5nIHRoZSBGUyBi
YXNlLCB1c2UgdGhlIHNhbWUNCj4+IC0gICAgICAgICAgICAgICAgKiBtZWNoYW5pc20gYXMgZm9y
IGRvX2FyY2hfcHJjdGxfNjQoKS4NCj4+ICsgICAgICAgICAgICAgICAgKiBXaGVuIGNoYW5naW5n
IHRoZSBGUyBiYXNlLCB1c2UgZG9fYXJjaF9wcmN0bF82NCgpDQo+PiArICAgICAgICAgICAgICAg
ICogdG8gc2V0IHRoZSBpbmRleCBhbmQgdGhlIGJhc2UuDQo+IA0KPiB0byBzZXQgdGhlIGluZGV4
IHRvIHplcm8gYW5kIHRvIHNldCB0aGUgYmFzZSBhcyByZXF1ZXN0ZWQuDQoNClRoYW5rcyBmb3Ig
dGhlIGVkaXQuDQpDaGFuZw0KDQo=
