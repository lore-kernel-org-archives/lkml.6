Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A65C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854B7207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBVScZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:32:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:8835 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVScZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:32:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 10:32:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,400,1544515200"; 
   d="scan'208";a="117054389"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2019 10:32:24 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 22 Feb 2019 10:32:23 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.70]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.140]) with mapi id 14.03.0415.000;
 Fri, 22 Feb 2019 10:32:23 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3 00/20] Merge text_poke fixes and executable lockdowns
Thread-Topic: [PATCH v3 00/20] Merge text_poke fixes and executable lockdowns
Thread-Index: AQHUykBH6Cl4tgVNiUeaovpifCvY+6XshO+AgAAmmIA=
Date:   Fri, 22 Feb 2019 18:32:22 +0000
Message-ID: <33968a3c7cc750f3d1cabf062f5fb25fd176e816.camel@intel.com>
References: <20190221234451.17632-1-rick.p.edgecombe@intel.com>
         <20190222161419.GB30766@zn.tnic>
In-Reply-To: <20190222161419.GB30766@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AFE1C37A3162E43A5884A3972E03B3D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTAyLTIyIGF0IDE3OjE0ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgRmViIDIxLCAyMDE5IGF0IDAzOjQ0OjMxUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IENoYW5nZXMgdjIgdG8gdjM6DQo+ID4gIC0gRml4IGNvbW1pdCBtZXNz
YWdlcyBhbmQgY29tbWVudHMgW0JvcmlzXQ0KPiA+ICAtIFJlbmFtZSBWTV9IQVNfU1BFQ0lBTF9Q
RVJNUyBbQm9yaXNdDQo+ID4gIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IGxvY2FsIHZhcmlhYmxlcyBb
Qm9yaXNdDQo+ID4gIC0gUmVuYW1lIHNldF9hbGlhc18qKCkgZnVuY3Rpb25zIFtCb3JpcywgQW5k
eV0NCj4gPiAgLSBTYXZlL3Jlc3RvcmUgRFIgcmVnaXN0ZXJzIHdoZW4gdXNpbmcgdGVtcG9yYXJ5
IG1tDQo+ID4gIC0gTW92ZSBsaW5lIGRlbGV0aW9uIGZyb20gcGF0Y2ggMTAgdG8gcGF0Y2ggMTcN
Cj4gDQo+IEluIHlvdXIgcHJldmlvdXMgc3VibWlzc2lvbiB0aGVyZSB3YXMgYSBwYXRjaCBjYWxs
ZWQNCj4gDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwMS8yMF0gRml4ICJ4ODYvYWx0ZXJuYXRpdmVz
OiBMb2NrZGVwLWVuZm9yY2UgdGV4dF9tdXRleCBpbg0KPiB0ZXh0X3Bva2UqKCkiDQo+IA0KPiBX
aGF0IGhhcHBlbmVkIHRvIGl0Pw0KPiANCj4gSXQgZGlkIGludHJvZHVjZSBhIGZ1bmN0aW9uIHRl
eHRfcG9rZV9rZ2RiKCksIGEuby4sIGFuZCBJIHNlZSB0aGlzDQo+IGZ1bmN0aW9uIGluIHRoZSBk
aWZmIGNvbnRleHRzIGluIHNvbWUgb2YgdGhlIHBhdGNoZXMgaW4gdGhpcyBzdWJtaXNzaW9uDQo+
IHNvIGl0IGxvb2tzIHRvIG1lIGxpa2UgeW91IG1pc3NlZCB0aGF0IGZpcnN0IHBhdGNoIHdoZW4g
c3VibWl0dGluZyB2Mz8NCj4gDQo+IE9yIGFtICpJKiBtaXNzaW5nIHNvbWV0aGluZz8NCj4gDQo+
IFRoeC4NCj4gDQpPaCwgeW91IGFyZSByaWdodCEgU29ycnkgYWJvdXQgdGhhdC4gSSdsbCBqdXN0
IHNlbmQgYSBuZXcgdmVyc2lvbiB3aXRoIGZpeGVzIGZvcg0Kb3RoZXIgY29tbWVudHMgaW5zdGVh
ZCBvZiBhIHJlc2VuZCBvZiB0aGlzIG9uZS4NCg0KVGhhbmtzLA0KDQpSaWNrDQo=
