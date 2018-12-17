Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2559EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF102133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbeLQTsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:48:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:7846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbeLQTsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:48:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 11:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="108094230"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2018 11:48:08 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 17 Dec 2018 11:48:08 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.59]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.206]) with mapi id 14.03.0415.000;
 Mon, 17 Dec 2018 11:48:08 -0800
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
Thread-Index: AQHUiJNT1thRYrJKskifWLlncDcXfqWDUdzAgACK0QD//3p94IAAnSqA//97RiA=
Date:   Mon, 17 Dec 2018 19:48:07 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmQwNzFkNTYtYmUwZi00MGQ3LTk2Y2QtMDU4ZTZiZmE1NjQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRno3V09aeThtUG1PemNTTFg1UFE4cjV1Q29aYkpvM2EyTXoxYXN1RGdiS0wxdWwwaW5OV01yNWk4NlVvTnA2VSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiBIaSBUaG9tYXMgYW5kIEluZ28sDQo+ID4gPiA+DQo+ID4gPiA+IEkgcmVjZW50bHkg
bm90aWNlZCB0aGF0IHRoZSBiZWxvdyBjb21taXRzIFsxXSBhbmQgWzJdIGFyZSBicm9rZW4NCj4g
PiA+ID4gd2hlbiBrZXJuZWwgY29tbWFuZCBsaW5lIGFyZ3VtZW50ICJlZmk9b2xkX21hcCIgaXMg
cGFzc2VkLiBTb3JyeSENCj4gPiA+ID4gSSBtaXNzZWQgdG8gdGVzdCB0aGlzIGNvbmRpdGlvbiBw
cmlvciB0byBzZW5kaW5nIHRoZXNlIHBhdGNoZXMgdG8gbWFpbGluZyBsaXN0Lg0KPiA+ID4gPiBJ
IGFtIHdvcmtpbmcgb24gYSBmaXggYW5kIHdpbGwgc2VuZCBpdCB0byBtYWlsaW5nIGxpc3QgYXMg
c29vbiBhcyBpdCdzIHJlYWR5Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IENvdWxkIHlvdSBlbGFi
b3JhdGUgb24gdGhlIHByb2JsZW0gcGxlYXNlPw0KPiA+DQo+ID4gU3VyZSEgTXkgYmFkLi4NCj4g
Pg0KPiA+IExpdHRsZSBiaXQgb2YgaGlzdG9yeSBoZXJlOg0KPiA+IEJvcmlzIHdpdGggdGhpcyBw
YXRjaCBzZXQgWzFdIGludHJvZHVjZWQgc3RhdGljYWxseSBtYXBwaW5nIEVGSQ0KPiA+IFJ1bnRp
bWUgU2VydmljZXMgYXQgLTRHIGFuZCBhbHNvIGludHJvZHVjZWQgImVmaT1vbGRfbWFwIiB0byBy
ZXR1cm4gdG8NCj4gPiBwcmV2aW91cyBFRkkgZnVuY3Rpb25hbGl0eSB3aGljaCB1c2VkIGlvcmVt
YXAgYW5kIF9fdmEocGEpLg0KPiA+DQo+ID4gWzNdIGFuZCBbNF0gYXJlIGxpbmtzIHRvIG9sZF9t
YXBfcmVnaW9uKCkNCj4gPg0KPiA+IFRoZSBjb21taXQgMDhjZmIzOGYzZWY0ICgieDg2L2VmaTog
VW5tYXAgRUZJIGJvb3Qgc2VydmljZXMgY29kZS9kYXRhDQo+ID4gcmVnaW9ucyBmcm9tIGVmaV9w
Z2QiKSwgdW5tYXBzIEVGSSBib290IHNlcnZpY2VzIGNvZGUvZGF0YSByZWdpb25zDQo+ID4gKm9u
bHkqIGZyb20gZWZpX3BnZCBidXQgZWZpPW9sZF9tYXAgbWFwcyBFRkkgYm9vdCBzZXJ2aWNlcyBj
b2RlL2RhdGENCj4gPiByZWdpb25zIGludG8gc3dhcHBlcl9wZ2QuIEFsc28sIGVmaT1vbGRfbWFw
ICB1c2VzIGVpdGhlcg0KPiA+IGlvcmVtYXAoKSBvciBfX3ZhKG1kLT5waHlzX2FkZHIpIHRvIG1h
cCBFRkkgcnVudGltZS9ib290IHRpbWUgc2VydmljZXMgYW5kDQo+IGRvZXNuJ3QgdXNlIGtlcm5l
bF9tYXBfcGFnZXNfaW5fcGdkKCkuDQo+ID4NCj4gPiBTbywgd2UgbmVlZCBhIGRpZmZlcmVudCB1
bm1hcHBpbmcgcm91dGluZSB0byB1bm1hcCBFRkkgYm9vdCBzZXJ2aWNlcw0KPiA+IGNvZGUvZGF0
YSByZWdpb25zIGZyb20gc3dhcHBlcl9wZ2QgaWYgdGhleSB3ZXJlIG1hcHBlZCB1c2luZyBlZmk9
b2xkX21hcC4NCj4gPg0KPiANCj4gRm9yIHRoZSBzaG9ydCB0ZXJtLCBjb3VsZCB3ZSBzaW1wbHkg
bWFrZSB5b3VyIGNoYW5nZXMgZGVwZW5kZW50IG9uIGVmaSAhPQ0KPiBvbGRfbWFwPyBUaGF0IGdp
dmVzIHVzIHNvbWUgdGltZSB0byBmaXggdGhlIG9sZF9tYXAgY2FzZSBwcm9wZXJseS4NCg0KWWVz
LCBJIHRoaW5rIHdlIGNvdWxkIGFuZCBpdCBzaG91bGQgd29yayBidXQgSSBoZXNpdGF0ZWQgdG8g
cHJvcG9zZSBpdCBiZWNhdXNlIA0KKGFzIHlvdSBhbHJlYWR5IG5vdGVkKSBpdCdzIGEgc2hvcnQg
dGVybSBmaXggYW5kIG5vdCB0aGUgcmlnaHQgZml4Lg0KDQpBbHRlcm5hdGl2ZWx5LCB3ZSBjb3Vs
ZCBhbHNvIGV2YWx1YXRlIGlmIHdlIG5lZWQgdG8gc3VwcG9ydCBlZmk9b2xkX21hcCBjYXNlIGdv
aW5nIGZ1cnRoZXIuDQpJIHRob3VnaHQgZHJvcHBpbmcgaXQgd291bGQgYmUgYSBiYWQgaWRlYSBi
ZWNhdXNlIGl0IGNoYW5nZXMga2VybmVsIHVzZXIgdmlzaWJsZSBpbnRlcmZhY2UgDQooYmVjYXVz
ZSBpdCdzIGEga2VybmVsIGNvbW1hbmQgbGluZSBhcmd1bWVudCkgYW5kIG5ldmVyIGJyb3VnaHQg
aXQgdXAuDQpOb3Qgc3VyZSB3aGF0IFRob21hcywgSW5nbyBvciBMaW51cyBtaWdodCB0aGluayBh
Ym91dCBkcm9wcGluZyBhIGtlcm5lbCBjb21tYW5kIGxpbmUgDQphcmd1bWVudC4NCg0KUmVnYXJk
cywNClNhaQ0K
