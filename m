Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16029C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DDC214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbeLQSm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:42:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:42808 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeLQSm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:42:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 10:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="284238657"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2018 10:42:25 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 17 Dec 2018 10:42:24 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.59]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.208]) with mapi id 14.03.0415.000;
 Mon, 17 Dec 2018 10:42:24 -0800
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
Thread-Index: AQHUiJNT1thRYrJKskifWLlncDcXfqWDUdzAgACK0QD//3p94A==
Date:   Mon, 17 Dec 2018 18:42:23 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjhlNDhhY2ItOTk1OS00YThjLWFhMmYtMDNkZjliYTE4N2RiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRXlySDJwM2hXTTNWXC9mWHVXMEY1a0poK2czQUhLZXd3bFNUMW1oSFBCdXg3T0JxMm9SZE11SFh3Q1ArMmZpZUsifQ==
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

PiA+IEhpIFRob21hcyBhbmQgSW5nbywNCj4gPg0KPiA+IEkgcmVjZW50bHkgbm90aWNlZCB0aGF0
IHRoZSBiZWxvdyBjb21taXRzIFsxXSBhbmQgWzJdIGFyZSBicm9rZW4gd2hlbg0KPiA+IGtlcm5l
bCBjb21tYW5kIGxpbmUgYXJndW1lbnQgImVmaT1vbGRfbWFwIiBpcyBwYXNzZWQuIFNvcnJ5ISBJ
IG1pc3NlZA0KPiA+IHRvIHRlc3QgdGhpcyBjb25kaXRpb24gcHJpb3IgdG8gc2VuZGluZyB0aGVz
ZSBwYXRjaGVzIHRvIG1haWxpbmcgbGlzdC4NCj4gPiBJIGFtIHdvcmtpbmcgb24gYSBmaXggYW5k
IHdpbGwgc2VuZCBpdCB0byBtYWlsaW5nIGxpc3QgYXMgc29vbiBhcyBpdCdzIHJlYWR5Lg0KPiA+
DQo+IA0KPiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHRoZSBwcm9ibGVtIHBsZWFzZT8NCg0KU3Vy
ZSEgTXkgYmFkLi4NCg0KTGl0dGxlIGJpdCBvZiBoaXN0b3J5IGhlcmU6DQpCb3JpcyB3aXRoIHRo
aXMgcGF0Y2ggc2V0IFsxXSBpbnRyb2R1Y2VkIHN0YXRpY2FsbHkgbWFwcGluZyBFRkkgUnVudGlt
ZSBTZXJ2aWNlcyBhdCAtNEcgDQphbmQgYWxzbyBpbnRyb2R1Y2VkICJlZmk9b2xkX21hcCIgdG8g
cmV0dXJuIHRvIHByZXZpb3VzIEVGSSBmdW5jdGlvbmFsaXR5IHdoaWNoIHVzZWQgDQppb3JlbWFw
IGFuZCBfX3ZhKHBhKS4NCg0KWzNdIGFuZCBbNF0gYXJlIGxpbmtzIHRvIG9sZF9tYXBfcmVnaW9u
KCkNCg0KVGhlIGNvbW1pdCAwOGNmYjM4ZjNlZjQgKCJ4ODYvZWZpOiBVbm1hcCBFRkkgYm9vdCBz
ZXJ2aWNlcyBjb2RlL2RhdGEgcmVnaW9ucyBmcm9tIGVmaV9wZ2QiKSwgDQp1bm1hcHMgRUZJIGJv
b3Qgc2VydmljZXMgY29kZS9kYXRhIHJlZ2lvbnMgKm9ubHkqIGZyb20gZWZpX3BnZCBidXQgZWZp
PW9sZF9tYXAgbWFwcyANCkVGSSBib290IHNlcnZpY2VzIGNvZGUvZGF0YSByZWdpb25zIGludG8g
c3dhcHBlcl9wZ2QuIEFsc28sIGVmaT1vbGRfbWFwICB1c2VzIGVpdGhlciANCmlvcmVtYXAoKSBv
ciBfX3ZhKG1kLT5waHlzX2FkZHIpIHRvIG1hcCBFRkkgcnVudGltZS9ib290IHRpbWUgc2Vydmlj
ZXMgYW5kIGRvZXNuJ3QgdXNlIGtlcm5lbF9tYXBfcGFnZXNfaW5fcGdkKCkuDQoNClNvLCB3ZSBu
ZWVkIGEgZGlmZmVyZW50IHVubWFwcGluZyByb3V0aW5lIHRvIHVubWFwIEVGSSBib290IHNlcnZp
Y2VzIGNvZGUvZGF0YSANCnJlZ2lvbnMgZnJvbSBzd2FwcGVyX3BnZCBpZiB0aGV5IHdlcmUgbWFw
cGVkIHVzaW5nIGVmaT1vbGRfbWFwLg0KDQpbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTMv
OS8xOS8yMzUgLSBDb3ZlciBsZXR0ZXIgZm9yIEVGSSBydW50aW1lIHNlcnZpY2VzIHZpcnR1YWwg
bWFwcGluZw0KWzJdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDEzLzEwLzgvNzc3IC0gVGFsa3Mg
YWJvdXQgZWZpPW9sZF9tYXANClszXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
NC4yMC1yYzcvc291cmNlL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9lZmlfNjQuYyNMNDI5DQpbNF0g
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjQuMjAtcmM3L3NvdXJjZS9hcmNoL3g4
Ni9wbGF0Zm9ybS9lZmkvZWZpLmMjTDU4NA0KDQo+IA0KPiA+IE1lYW53aGlsZSwgY291bGQgeW91
IHBsZWFzZSBkcm9wIHRoZXNlIHBhdGNoZXMgYmVmb3JlIHNlbmRpbmcgcHVsbCByZXF1ZXN0DQo+
IHRvIExpbnVzPw0KPiA+DQo+ID4gWzFdIENvbW1pdCAwOGNmYjM4ZjNlZjQgKCJ4ODYvZWZpOiBV
bm1hcCBFRkkgYm9vdCBzZXJ2aWNlcyBjb2RlL2RhdGENCj4gPiByZWdpb25zIGZyb20gZWZpX3Bn
ZCIpIFsyXSBDb21taXQgN2UwZGFiZDMwMTBkICgieDg2L21tL3BhZ2VhdHRyOg0KPiA+IEludHJv
ZHVjZSBoZWxwZXIgZnVuY3Rpb24gdG8gdW5tYXAgRUZJIGJvb3Qgc2VydmljZXMiKQ0KPiA+DQo+
IA0KPiBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIHdoYXQgdGhlIGlzc3VlIGlzIGJlZm9yZSB3ZSBk
cm9wIGFueXRoaW5nLg0KDQpSZWdhcmRzLA0KU2FpDQo=
