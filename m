Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71539C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA55205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA55205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeJYQEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:04:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:49030 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbeJYQEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:04:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 00:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="scan'208";a="94869712"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2018 00:32:31 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 25 Oct 2018 00:32:31 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 25 Oct 2018 00:32:31 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.139]) with mapi id 14.03.0415.000;
 Thu, 25 Oct 2018 01:32:28 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in the
 helper functions
Thread-Topic: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in
 the helper functions
Thread-Index: AQHUawBO9chRqp+c5EKJrUo1DG8ZGaUvKsMAgADNk4A=
Date:   Thu, 25 Oct 2018 07:32:27 +0000
Message-ID: <1EE75BE7-12C6-4BD9-9D31-E9C396D2015B@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-5-chang.seok.bae@intel.com>
 <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
In-Reply-To: <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.78.140]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7BDF3AA38B8144BA47A4B78884EAB1E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCAyNCwgMjAxOCwgYXQgMTI6MTYsIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgT2N0IDIzLCAyMDE4IGF0IDExOjQzIEFNIENo
YW5nIFMuIEJhZSA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+IHZvaWQgeDg2
X2ZzYmFzZV93cml0ZV9jcHUodW5zaWduZWQgbG9uZyBmc2Jhc2UpDQo+PiB7DQo+PiAtICAgICAg
IC8qDQo+PiAtICAgICAgICAqIFNldCB0aGUgc2VsZWN0b3IgdG8gMCBhcyBhIG5vdGlvbiwgdGhh
dCB0aGUgc2VnbWVudCBiYXNlIGlzDQo+PiAtICAgICAgICAqIG92ZXJ3cml0dGVuLCB3aGljaCB3
aWxsIGJlIGNoZWNrZWQgZm9yIHNraXBwaW5nIHRoZSBzZWdtZW50IGxvYWQNCj4+IC0gICAgICAg
ICogZHVyaW5nIGNvbnRleHQgc3dpdGNoLg0KPj4gLSAgICAgICAgKi8NCj4+IC0gICAgICAgbG9h
ZHNlZyhGUywgMCk7DQo+PiAtICAgICAgIHdybXNybChNU1JfRlNfQkFTRSwgZnNiYXNlKTsNCj4+
ICsgICAgICAgaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0ZTR1NCQVNFKSkgew0KPj4g
KyAgICAgICAgICAgICAgIHdyZnNiYXNlKGZzYmFzZSk7DQo+PiArICAgICAgIH0gZWxzZSB7DQo+
PiArICAgICAgICAgICAgICAgLyoNCj4+ICsgICAgICAgICAgICAgICAgKiBTZXQgdGhlIHNlbGVj
dG9yIHRvIDAgYXMgYSBub3Rpb24sIHRoYXQgdGhlIHNlZ21lbnQgYmFzZSBpcw0KPj4gKyAgICAg
ICAgICAgICAgICAqIG92ZXJ3cml0dGVuLCB3aGljaCB3aWxsIGJlIGNoZWNrZWQgZm9yIHNraXBw
aW5nIHRoZSBzZWdtZW50IGxvYWQNCj4+ICsgICAgICAgICAgICAgICAgKiBkdXJpbmcgY29udGV4
dCBzd2l0Y2guDQo+PiArICAgICAgICAgICAgICAgICovDQo+PiArICAgICAgICAgICAgICAgbG9h
ZHNlZyhGUywgMCk7DQo+PiArICAgICAgICAgICAgICAgd3Jtc3JsKE1TUl9GU19CQVNFLCBmc2Jh
c2UpOw0KPj4gKyAgICAgICB9DQo+PiB9DQo+PiANCj4+IHZvaWQgeDg2X2dzYmFzZV93cml0ZV9j
cHVfaW5hY3RpdmUodW5zaWduZWQgbG9uZyBnc2Jhc2UpDQo+PiB7DQo+PiAtICAgICAgIC8qIFNl
dCB0aGUgc2VsZWN0b3IgdG8gMCBmb3IgdGhlIHNhbWUgcmVhc29uIGFzICVmcyBhYm92ZS4gKi8N
Cj4+IC0gICAgICAgbG9hZHNlZyhHUywgMCk7DQo+PiAtICAgICAgIHdybXNybChNU1JfS0VSTkVM
X0dTX0JBU0UsIGdzYmFzZSk7DQo+PiArICAgICAgIGlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVB
VFVSRV9GU0dTQkFTRSkpIHsNCj4+ICsgICAgICAgICAgICAgICB3cl9pbmFjdGl2ZV9nc2Jhc2Uo
Z3NiYXNlKTsNCj4+ICsgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICAgICAvKiBTZXQg
dGhlIHNlbGVjdG9yIHRvIDAgZm9yIHRoZSBzYW1lIHJlYXNvbiBhcyAlZnMgYWJvdmUuICovDQo+
PiArICAgICAgICAgICAgICAgbG9hZHNlZyhHUywgMCk7DQo+PiArICAgICAgICAgICAgICAgd3Jt
c3JsKE1TUl9LRVJORUxfR1NfQkFTRSwgZ3NiYXNlKTsNCj4gDQo+IEkgc3RpbGwgZG9uJ3QgZ2V0
IHdoYXQgdGhpcyBjb2RlIGlzIHRyeWluZyB0byBkby4gIFNlZSBvdGhlciBlbWFpbC4gIEkNCj4g
dGhpbmsgaXQgd2lsbCBzdHJhaWdodCB1cCBjcmFzaCB0aGUga2VybmVsIG9uIHNvbWUgQ1BVcywg
c2luY2Ugd3JpdGluZw0KPiAwIHRvICUlZ3Mgd2lsbCB6ZXJvIG91dCB0aGUgKmFjdGl2ZSogYmFz
ZSBvbiBzb21lIENQVXMuDQo+IA0KDQpPbiB0aG9zZSBDUFVzLCBob3cgdGhlIG9sZCBkb19hcmNo
X3ByY3RsXzY0KCkgd29ya2VkPw0KbG9hZHNlZyhHUywgMCkgZXZlbnR1YWxseSBoaXRzIHRoZSBu
YXRpdmVfbG9hZF9nc19pbmRleCBlbnRyeSwgd2hlcmUgYWN0dWFsDQptb3Yg4oCmLCAlZ3MgaXMg
d3JhcHBlZCBieSB0d28gU1dBUEdTZXMuIFNvLCBpdCB3b27igJl0IGNhdXNlIHRoZSBzaWRlIGVm
ZmVjdA0Kb2Ygb3ZlcndyaXRpbmcgdGhlICphY3RpdmUqIGJhc2UsIEkgdGhpbmsuDQoNCj4gSSB0
aGluayB0aGF0LCBpZiB5b3UgcmVhbGx5IHdhbnQgc29tZSBmYW5jeSBvcHRpbWl6YXRpb24gZm9y
IHRoZQ0KPiBub24tRlNHU0JBU0UgY2FzZSwgeW91IG5lZWQgdG8gcHVsbCB0aGF0IG91dCBpbnRv
IHRoZSBjYWxsZXJzIG9mIHRoZXNlDQo+IGhlbHBlcnMuDQoNCg==
