Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B201ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD2B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD2B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeJYDm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:42:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:17200 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYDmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:42:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 12:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="85303012"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2018 12:13:36 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 12:13:36 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 12:13:36 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.139]) with mapi id 14.03.0415.000;
 Wed, 24 Oct 2018 13:13:33 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
Thread-Topic: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
Thread-Index: AQHUT6S8E0XwPCm1jkGysv7aiho556UvXU2A//+dxwA=
Date:   Wed, 24 Oct 2018 19:13:32 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66CCBBE3@CRSMSX101.amr.corp.intel.com>
References: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
 <1537312139-5580-3-git-send-email-chang.seok.bae@intel.com>
 <CALCETrUr3DGwW8y6y_cffEKWO_KQs1J2_UvTBZsbdAzES_f-Ag@mail.gmail.com>
In-Reply-To: <CALCETrUr3DGwW8y6y_cffEKWO_KQs1J2_UvTBZsbdAzES_f-Ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGQ2YTY2MmEtOTlkNS00MTc1LWJmYWItODYwNDMzY2MyY2FkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibGRlU2xsUGhtTnNQNm5RMFwvTmsrZEphSVQzNmZ4bUs2aGl6bkswaVVMeG9aSGdkeDU2NVZvdEZ1NjNCVmprSHYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTgsIDIwMTggYXQgMTI6MDIgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+DQo+IE9uIFR1ZSwgU2VwIDE4LCAyMDE4IGF0IDQ6MDkgUE0gQ2hhbmcgUy4gQmFl
IDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gV2l0aCBuZXcg
aGVscGVycywgRlMvR1MgYmFzZSBhY2Nlc3MgaXMgY2VudHJhbGl6ZWQuDQo+ID4gRXZlbnR1YWxs
eSwgd2hlbiBGU0dTQkFTRSBpbnN0cnVjdGlvbiBlbmFibGVkLCBpdCB3aWxsIGJlIGZhc3Rlci4N
Cj4gDQo+IFNvcnJ5IGZvciBub3QgY2F0Y2hpbmcgdGhpcyBkdXJpbmcgcmV2aWV3LCBidXQ6DQo+
IA0KPiA+ICt2b2lkIHg4Nl9mc2Jhc2Vfd3JpdGVfY3B1KHVuc2lnbmVkIGxvbmcgZnNiYXNlKSB7
DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogU2V0IHRoZSBzZWxlY3RvciB0byAwIGFz
IGEgbm90aW9uLCB0aGF0IHRoZSBzZWdtZW50IGJhc2UgaXMNCj4gPiArICAgICAgICAqIG92ZXJ3
cml0dGVuLCB3aGljaCB3aWxsIGJlIGNoZWNrZWQgZm9yIHNraXBwaW5nIHRoZSBzZWdtZW50IGxv
YWQNCj4gPiArICAgICAgICAqIGR1cmluZyBjb250ZXh0IHN3aXRjaC4NCj4gPiArICAgICAgICAq
Lw0KPiA+ICsgICAgICAgbG9hZHNlZyhGUywgMCk7DQo+IA0KPiBeXl4NCj4gDQo+IHdoYXQ/DQo+
IA0KPiA+ICsgICAgICAgd3Jtc3JsKE1TUl9GU19CQVNFLCBmc2Jhc2UpOw0KPiA+ICt9DQo+IA0K
PiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB0aGUgY29tbWVudCBpcyB0cnlpbmcgdG8gc2F5LCBi
dXQgdGhlIHNvbGUgY2FsbGVyIHNvIGZhcg0KPiBvZiB0aGlzIGZ1bmN0aW9uIGlzIHg4Nl9nc2Jh
c2Vfd3JpdGVfdGFzaygpLCBhbmQgdGhlIGNvZGUgbG9va3MgaW5jb3JyZWN0Lg0KPiANCj4gSW5n
bywgSSB0aGluayB3ZSBuZWVkIHRvIGFkZHJlc3MgdGhpcyBkdXJpbmcgdGhpcyBtZXJnZSB3aW5k
b3csIHByb2JhYmx5IGJ5DQo+IHJlbW92aW5nIHRoZSBjb21tZW50IGFuZCB0aGUgbG9hZHNlZygp
IGNhbGwgKGFuZCB0aGUgc2FtZSBmb3INCj4gZ3NiYXNlLi4uaW5hY3RpdmUpLiAgQnV0IGZpcnN0
LCBDaGFuZywgY2FuIHlvdSBleHBsYWluIHdoYXQgZXhhY3RseSB5b3VyIGludGVudCBpcw0KPiBo
ZXJlPw0KDQpJdCdzIGNvbWluZyBmcm9tIGRvX2FyY2hfcHJjdGxfNjQoKS4gSWYgeW91IHRoaW5r
IGl0IHJlYWxseSBtYWtlcyBjb25mdXNpb24gaW4gDQp4ODZfZnNiYXNlX3dyaXRlX2NwdSgpLCBo
b3cgYWJvdXQgbW92aW5nIGl0IHRvIHg4Nl9mc2Jhc2Vfd3JpdGVfdGFzaygpPw0KDQpDaGFuZw0K
