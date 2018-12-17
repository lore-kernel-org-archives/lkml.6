Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8045C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849BD20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbeLQSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:06:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:34415 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeLQSG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:06:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 10:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="108075544"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2018 10:06:55 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.59]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.175]) with mapi id 14.03.0415.000;
 Mon, 17 Dec 2018 10:06:55 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
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
Thread-Index: AQHUiJNT1thRYrJKskifWLlncDcXfqWDUdzA
Date:   Mon, 17 Dec 2018 18:06:54 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
In-Reply-To: <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjBkNTUwMDktNjIyNS00ZmNkLWFhMWQtNzllZmU2ZWZkYjVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaVV0bTllVGFNUmszN2xiY3ZXVnd5dWtFckFxK1ZFS0p1Qm9zOWtkWEFpdGVIVEE2N1ZqVWRcL3JyT1Zsa1VLWWkifQ==
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

PiBDb21taXQtSUQ6ICAwOGNmYjM4ZjNlZjQ5Y2ZkMWJiYTExYTAwNDAxNDUxNjA2NDc3ZDgwDQo+
IEdpdHdlYjoNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy90aXAvMDhjZmIzOGYzZWY0OWNmZDFi
YmExMWEwMDQwMTQ1MTYwNjQ3N2Q4MA0KPiBBdXRob3I6ICAgICBTYWkgUHJhbmVldGggUHJha2h5
YSA8c2FpLnByYW5lZXRoLnByYWtoeWFAaW50ZWwuY29tPg0KPiBBdXRob3JEYXRlOiBUaHUsIDI5
IE5vdiAyMDE4IDE4OjEyOjI0ICswMTAwDQo+IENvbW1pdHRlcjogIEluZ28gTW9sbmFyIDxtaW5n
b0BrZXJuZWwub3JnPg0KPiBDb21taXREYXRlOiBGcmksIDMwIE5vdiAyMDE4IDA5OjEwOjMwICsw
MTAwDQo+IA0KPiB4ODYvZWZpOiBVbm1hcCBFRkkgYm9vdCBzZXJ2aWNlcyBjb2RlL2RhdGEgcmVn
aW9ucyBmcm9tIGVmaV9wZ2QNCj4gDQo+IGVmaV9mcmVlX2Jvb3Rfc2VydmljZXMoKSwgYXMgdGhl
IG5hbWUgc3VnZ2VzdHMsIGZyZWVzIEVGSSBib290IHNlcnZpY2VzDQo+IGNvZGUvZGF0YSByZWdp
b25zIGJ1dCBmb3JnZXRzIHRvIHVubWFwIHRoZXNlIHJlZ2lvbnMgZnJvbSBlZmlfcGdkLiBUaGlz
IG1lYW5zDQo+IHRoYXQgYW55IGNvZGUgdGhhdCdzIHJ1bm5pbmcgaW4gZWZpX3BnZCBhZGRyZXNz
IHNwYWNlIChlLmc6DQo+IGFueSBFRkkgcnVudGltZSBzZXJ2aWNlKSB3b3VsZCBzdGlsbCBiZSBh
YmxlIHRvIGFjY2VzcyB0aGVzZSByZWdpb25zIGJ1dCB0aGUNCj4gY29udGVudHMgb2YgdGhlc2Ug
cmVnaW9ucyB3b3VsZCBoYXZlIGxvbmcgYmVlbiBvdmVyIHdyaXR0ZW4gYnkgc29tZW9uZSBlbHNl
Lg0KPiBTbywgaXQncyBpbXBvcnRhbnQgdG8gdW5tYXAgdGhlc2UgcmVnaW9ucy4gSGVuY2UsIGlu
dHJvZHVjZSBlZmlfdW5tYXBfcGFnZXMoKQ0KPiB0byB1bm1hcCB0aGVzZSByZWdpb25zIGZyb20g
ZWZpX3BnZC4NCj4gDQo+IEFmdGVyIHVubWFwcGluZyBFRkkgYm9vdCBzZXJ2aWNlcyBjb2RlL2Rh
dGEgcmVnaW9ucywgYW55IGlsbGVnYWwgYWNjZXNzIGJ5DQo+IGJ1Z2d5IGZpcm13YXJlIHRvIHRo
ZXNlIHJlZ2lvbnMgd291bGQgcmVzdWx0IGluIHBhZ2UgZmF1bHQgd2hpY2ggd2lsbCBiZSBoYW5k
bGVkDQo+IGJ5IEVGSSBzcGVjaWZpYyBmYXVsdCBoYW5kbGVyLg0KDQpIaSBUaG9tYXMgYW5kIElu
Z28sDQoNCkkgcmVjZW50bHkgbm90aWNlZCB0aGF0IHRoZSBiZWxvdyBjb21taXRzIFsxXSBhbmQg
WzJdIGFyZSBicm9rZW4gd2hlbiBrZXJuZWwgY29tbWFuZCBsaW5lIA0KYXJndW1lbnQgImVmaT1v
bGRfbWFwIiBpcyBwYXNzZWQuIFNvcnJ5ISBJIG1pc3NlZCB0byB0ZXN0IHRoaXMgY29uZGl0aW9u
IHByaW9yIHRvIHNlbmRpbmcgDQp0aGVzZSBwYXRjaGVzIHRvIG1haWxpbmcgbGlzdC4gSSBhbSB3
b3JraW5nIG9uIGEgZml4IGFuZCB3aWxsIHNlbmQgaXQgdG8gbWFpbGluZyBsaXN0IGFzIA0Kc29v
biBhcyBpdCdzIHJlYWR5Lg0KDQpNZWFud2hpbGUsIGNvdWxkIHlvdSBwbGVhc2UgZHJvcCB0aGVz
ZSBwYXRjaGVzIGJlZm9yZSBzZW5kaW5nIHB1bGwgcmVxdWVzdCB0byBMaW51cz8NCg0KWzFdIENv
bW1pdCAwOGNmYjM4ZjNlZjQgKCJ4ODYvZWZpOiBVbm1hcCBFRkkgYm9vdCBzZXJ2aWNlcyBjb2Rl
L2RhdGEgcmVnaW9ucyBmcm9tIGVmaV9wZ2QiKQ0KWzJdIENvbW1pdCA3ZTBkYWJkMzAxMGQgKCJ4
ODYvbW0vcGFnZWF0dHI6IEludHJvZHVjZSBoZWxwZXIgZnVuY3Rpb24gdG8gdW5tYXAgRUZJIGJv
b3Qgc2VydmljZXMiKQ0KDQpSZWdhcmRzLA0KU2FpDQo=
