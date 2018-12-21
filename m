Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A389C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CFB21939
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391119AbeLURwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:52:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:53777 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbeLURwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:52:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 09:52:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="scan'208";a="100566650"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2018 09:52:53 -0800
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 21 Dec 2018 09:52:52 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.59]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.100]) with mapi id 14.03.0415.000;
 Fri, 21 Dec 2018 09:52:52 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "zhuyifei1999@gmail.com" <zhuyifei1999@gmail.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:efi/core] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Topic: [tip:efi/core] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Thread-Index: AQHUiJNT1thRYrJKskifWLlncDcXfqWDUdzAgACK0QD//3p94IAAnSqA//97RiCABqNEgP//hjYw
Date:   Fri, 21 Dec 2018 17:52:52 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48606B36@ORSMSX114.amr.corp.intel.com>
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu99VdPero0yrXiaByURyp1idYE948Qi4j1eqY0ENCrF5A@mail.gmail.com>
In-Reply-To: <CAKv+Gu99VdPero0yrXiaByURyp1idYE948Qi4j1eqY0ENCrF5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWEwMDJlZGMtZTQ2OC00Nzk1LWIwNzItZjU2MzQ0MzBjN2Q0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR3BEQysxNUJST1g2V3ZLblBKcUVPZm9pdFl0SURmVXpYdDF3bFUwZUdRT0liaUJxUFhRTmx0OHFid3A2Q2V0VCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gRm9yIHRoZSBzaG9ydCB0ZXJtLCBjb3VsZCB3ZSBzaW1wbHkgbWFrZSB5b3VyIGNoYW5n
ZXMgZGVwZW5kZW50IG9uDQo+ID4gPiBlZmkgIT0gb2xkX21hcD8gVGhhdCBnaXZlcyB1cyBzb21l
IHRpbWUgdG8gZml4IHRoZSBvbGRfbWFwIGNhc2UgcHJvcGVybHkuDQo+ID4NCj4gPiBZZXMsIEkg
dGhpbmsgd2UgY291bGQgYW5kIGl0IHNob3VsZCB3b3JrIGJ1dCBJIGhlc2l0YXRlZCB0byBwcm9w
b3NlIGl0DQo+ID4gYmVjYXVzZSAoYXMgeW91IGFscmVhZHkgbm90ZWQpIGl0J3MgYSBzaG9ydCB0
ZXJtIGZpeCBhbmQgbm90IHRoZSByaWdodCBmaXguDQo+ID4NCj4gDQo+IFdoYXQgaXMgdGhlIHN0
YXR1cyBoZXJlPw0KDQpNYWtpbmcgdGhlIHVubWFwcGluZyBjb2RlIGNvbmRpdGlvbmFsIG9uICFv
bGRfbWFwIGlzIHJlYWR5IGFuZCBJIHdpbGwgc2VuZCBpdCBvdXQuDQpJIGFtIHdvcmtpbmcgb24g
dW5tYXBwaW5nIGJvb3Qgc2VydmljZXMgY29kZS9kYXRhIHdoZW4gb2xkX21hcCBpcyBlbmFibGVk
IA0KYW5kIHJhbiBpbnRvIGlzc3VlcyB3aXRoIG1lbWJsb2NrIGFuZCBkaXJlY3QgbWFwcGluZyBp
biBrZXJuZWwuIFdpbGwgcG9zdCB0aG9zZSBkZXRhaWxzIA0KaW4gYSBzZXBhcmF0ZSB0aHJlYWQu
DQoNCj4gDQo+ID4gQWx0ZXJuYXRpdmVseSwgd2UgY291bGQgYWxzbyBldmFsdWF0ZSBpZiB3ZSBu
ZWVkIHRvIHN1cHBvcnQgZWZpPW9sZF9tYXAgY2FzZQ0KPiBnb2luZyBmdXJ0aGVyLg0KPiA+IEkg
dGhvdWdodCBkcm9wcGluZyBpdCB3b3VsZCBiZSBhIGJhZCBpZGVhIGJlY2F1c2UgaXQgY2hhbmdl
cyBrZXJuZWwNCj4gPiB1c2VyIHZpc2libGUgaW50ZXJmYWNlIChiZWNhdXNlIGl0J3MgYSBrZXJu
ZWwgY29tbWFuZCBsaW5lIGFyZ3VtZW50KSBhbmQgbmV2ZXINCj4gYnJvdWdodCBpdCB1cC4NCj4g
PiBOb3Qgc3VyZSB3aGF0IFRob21hcywgSW5nbyBvciBMaW51cyBtaWdodCB0aGluayBhYm91dCBk
cm9wcGluZyBhDQo+ID4ga2VybmVsIGNvbW1hbmQgbGluZSBhcmd1bWVudC4NCj4gPg0KPiANCj4g
RHJvcHBpbmcgYSBjb21tYW5kIGxpbmUgYXJndW1lbnQgaXMgbm90IGEgcHJvYmxlbSBpbiBpdHNl
bGYsIHVubGVzcyBhbnlvbmUgaXMNCj4gYWN0aXZlbHkgdXNpbmcgaXQgOi0pDQo+IA0KPiBBcyBm
YXIgYXMgSSBjYW4gdGVsbCwgdGhlIFNHSSB4ODYgVVYgcGxhdGZvcm1zIHN0aWxsIHJlbHkgb24g
dGhpcywgc28gd2UncmUgc3R1Y2sgd2l0aA0KPiBpdCBmb3IgdGhlIGZvcmVzZWVhYmxlIGZ1dHVy
ZS4NCg0KVGhhbmtzIChhbHNvIEJvcmlzKSBmb3IgdGhlIGluZm8uIE1ha2VzIHNlbnNlIHdoeSB3
ZSBuZWVkIGVmaT1vbGRfbWFwLg0KDQo+IA0KPiBUaGlzIG1lYW5zIHdlIG5lZWQgYSBmaXhlcyB0
aGF0IG1ha2VzIHlvdXIgdW5tYXBwaW5nIGNvZGUgY29uZGl0aW9uYWwgb24NCj4gIW9sZF9tZW1t
YXAuIERvIHlvdSBoYXZlIGFuIEVUQSBmb3IgdGhhdD8NCg0KU3VyZSEgSSB3aWxsIGRvIHNvbWUg
bW9yZSB0ZXN0aW5nIGFuZCBpZiBpdCB3b3JrcyBhcyBleHBlY3RlZCwgd2lsbCBzZW5kIGl0IGJl
Zm9yZSB0aGlzIFN1bmRheS4NCg0KUmVnYXJkcywNClNhaQ0K
