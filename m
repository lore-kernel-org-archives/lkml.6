Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8HnLLDtnGFsjZwAAmS7hNA
	; Wed, 06 Jun 2018 23:00:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9754A6089E; Wed,  6 Jun 2018 23:00:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1A75D607E4;
	Wed,  6 Jun 2018 23:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A75D607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeFFW77 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:59:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:40303 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752142AbeFFW75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:59:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 15:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,485,1520924400";
   d="scan'208";a="235293780"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2018 15:59:57 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 6 Jun 2018 15:59:56 -0700
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 6 Jun 2018 15:59:56 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.79]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.55]) with mapi id 14.03.0319.002;
 Wed, 6 Jun 2018 16:59:54 -0600
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] x86/vdso: Move out the CPU number store
Thread-Topic: [PATCH v2 8/8] x86/vdso: Move out the CPU number store
Thread-Index: AQHT/bLMYx8EjGCUCUKH/sMAu+9L7aRT39mA//+cAACAAEwlAA==
Date: Wed, 6 Jun 2018 22:59:53 +0000
Message-ID: <620DB16F-FED8-4CE6-A93A-FA110A28F4A1@intel.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
 <1528302199-29619-9-git-send-email-chang.seok.bae@intel.com>
 <CALCETrVkFvC4R6dfrUL5B9iN1v3X6hE3QNHBrAHjPBrA9S7FWg@mail.gmail.com>
 <1D572EBD-5B82-4828-AE3E-8CB9E1FA054E@intel.com>
In-Reply-To: <1D572EBD-5B82-4828-AE3E-8CB9E1FA054E@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.1.180523
x-originating-ip: [10.3.139.184]
Content-Type: text/plain; charset="utf-8"
Content-ID: <045C3BC6C1A30D419EDF6AD6C7F9C01D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEp1biA2LCAyMDE4IGF0IDEwOjI1IEFNIEFuZHkgTHV0b21pcnNraSA8bHV0b0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4+IE9uIFdlZCwgSnVuIDYsIDIwMTggYXQgOToyMyBBTSBDaGFu
ZyBTLiBCYWUgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT4gd3JvdGU6DQo+PiArc3RhdGljIGlu
bGluZSB2b2lkIHNldHVwX2NwdV9udW1iZXJfc2VnbWVudChpbnQgY3B1KQ0KPj4gK3sNCj4+ICsj
aWZkZWYgQ09ORklHX05VTUENCj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyBub2RlID0gZWFybHlf
Y3B1X3RvX25vZGUoY3B1KTsNCj4+ICsjZWxzZQ0KPj4gKyAgICAgICB1bnNpZ25lZCBsb25nIG5v
ZGUgPSAwOw0KPj4gKyNlbmRpZg0KPiBUaGlzIGR1cGxpY2F0ZXMgaGFsZiB0aGUgcmR0c2NwX2F1
eCBjb2RlLiAgSG93IGFib3V0IG1ha2luZyB0aGlzIG9uZQ0KPiBmdW5jdGlvbiBzZXR1cF9jcHVf
bnVtYmVyKCkgdGhhdCBkb2VzIGFsbCBvZiBpdD8NCkxvb2tzIGxpa2UgdGhlIHNlZ21lbnQgc2V0
dXAgZG9uZSBkdXJpbmcgZWFybHkgYm9vdCAoc2luZ2xlLXRocmVhZGVkKS4NClNvLCBzZXBhcmF0
aW5nIE1TUiBUU0NfQVVYIHNldHVwIG91dCB0byBlYWNoIENQVSBpbml0aWFsaXphdGlvbiBzZWVt
cw0KdG8gYmUgc3RpbGwgcmVhc29uYWJsZSB0byBtZS4NCg0KVGhhbmtzLA0KQ2hhbmcNCg0KDQo=
