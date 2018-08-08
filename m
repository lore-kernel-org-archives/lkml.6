Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF467C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778C921771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778C921771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeHHUDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:03:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:54177 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbeHHUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:03:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 10:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,458,1531810800"; 
   d="scan'208";a="63590611"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2018 10:42:51 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 8 Aug 2018 10:42:50 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 FMSMSX114.amr.corp.intel.com ([10.18.116.8]) with mapi id 14.03.0319.002;
 Wed, 8 Aug 2018 10:42:50 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "hehy1@lenovo.com" <hehy1@lenovo.com>
Subject: Re: [PATCH] ACPI: nfit: check dcr immediately following its
 assignment codes
Thread-Topic: [PATCH] ACPI: nfit: check dcr immediately following its
 assignment codes
Thread-Index: AQHULycrSkoarrE0Q0WKxtnVrTq38KS2lXqA
Date:   Wed, 8 Aug 2018 17:42:49 +0000
Message-ID: <1533750167.7673.0.camel@intel.com>
References: <1533739821-9864-1-git-send-email-oceanhehy@gmail.com>
In-Reply-To: <1533739821-9864-1-git-send-email-oceanhehy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <056CCCA00A86E94385781170EC549486@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMTgtMDgtMDggYXQgMTA6NTAgLTA0MDAsIE9jZWFuIEhlIHdyb3RlOg0KPiBG
cm9tOiBPY2VhbiBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gDQo+IEluIGNvbW1pdCA2Njk3YjJj
ZjY5ZDQzNjMyICgibmZpdDogZml4IG11bHRpLWludGVyZmFjZSBkaW1tIGhhbmRsaW5nLA0KPiBh
Y3BpNi4xIGNvbXBhdGliaWxpdHkiKSwgdGhlIGNoZWNrIGNvZGVzIG9mIGRjciB3ZXJlIGp1c3Qg
Zm9sbG93aW5nIGl0cw0KPiBhc3NpZ25tZW50IGNvZGVzLiBCdXQgdGhleSB3ZXJlIHNlcGFyYXRl
ZCBieSBjb21taXQgYWQ5YWM1ZTE5NTc1MzFhOA0KPiAoIm5maXQ6IGFsd2F5cyBhc3NvY2lhdGUg
Zmx1c2ggaGludHMiKS4NCj4gDQo+IEp1c3QgY2hhbmdlIHRoZSBjaGVjayBjb2RlcyBiYWNrIHRv
IG9yaWdpbmFsIHBvc2l0aW9uLCB3aXRob3V0IGZ1bmN0aW9uDQo+IGNoYW5nZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE9jZWFuIEhlIDxoZWh5MUBsZW5vdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvYWNwaS9uZml0L2NvcmUuYyB8IDEyICsrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KVGhpcyBzZWVtcyBsaWtlIHVubmVj
ZXNzYXJ5IGNodXJuLiBEb2VzIGl0IGNhdXNlIGFueSBwcm9ibGVtcyBpbg0KcHJhY3RpY2U/DQoN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgYi9kcml2ZXJzL2Fj
cGkvbmZpdC9jb3JlLmMNCj4gaW5kZXggN2M0NzkwMC4uYzllNGM5YSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUu
Yw0KPiBAQCAtMTA3OCw2ICsxMDc4LDEyIEBAIHN0YXRpYyBpbnQgX19uZml0X21lbV9pbml0KHN0
cnVjdCBhY3BpX25maXRfZGVzYyAqYWNwaV9kZXNjLA0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4g
IA0KPiArCQlpZiAoZGNyICYmICFuZml0X21lbS0+ZGNyKSB7DQo+ICsJCQlkZXZfZXJyKGFjcGlf
ZGVzYy0+ZGV2LCAiU1BBICVkIG1pc3NpbmcgRENSICVkXG4iLA0KPiArCQkJCQlzcGEtPnJhbmdl
X2luZGV4LCBkY3IpOw0KPiArCQkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJCX0NCj4gKw0KPiAgCQls
aXN0X2Zvcl9lYWNoX2VudHJ5KG5maXRfZmx1c2gsICZhY3BpX2Rlc2MtPmZsdXNoZXMsIGxpc3Qp
IHsNCj4gIAkJCXN0cnVjdCBhY3BpX25maXRfZmx1c2hfYWRkcmVzcyAqZmx1c2g7DQo+ICAJCQl1
MTYgaTsNCj4gQEAgLTExMDEsMTIgKzExMDcsNiBAQCBzdGF0aWMgaW50IF9fbmZpdF9tZW1faW5p
dChzdHJ1Y3QgYWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYywNCj4gIAkJCWJyZWFrOw0KPiAgCQl9
DQo+ICANCj4gLQkJaWYgKGRjciAmJiAhbmZpdF9tZW0tPmRjcikgew0KPiAtCQkJZGV2X2Vycihh
Y3BpX2Rlc2MtPmRldiwgIlNQQSAlZCBtaXNzaW5nIERDUiAlZFxuIiwNCj4gLQkJCQkJc3BhLT5y
YW5nZV9pbmRleCwgZGNyKTsNCj4gLQkJCXJldHVybiAtRU5PREVWOw0KPiAtCQl9DQo+IC0NCj4g
IAkJaWYgKHR5cGUgPT0gTkZJVF9TUEFfRENSKSB7DQo+ICAJCQlzdHJ1Y3QgbmZpdF9pZHQgKm5m
aXRfaWR0Ow0KPiAgCQkJdTE2IGlkdF9pZHg7DQo=
