Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BB1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E75220854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E75220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeILWi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:38:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:11658 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeILWi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:38:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 10:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,365,1531810800"; 
   d="scan'208";a="72429484"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga007.jf.intel.com with ESMTP; 12 Sep 2018 10:32:44 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.117]) with mapi id 14.03.0319.002;
 Wed, 12 Sep 2018 10:32:44 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Al Stone" <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH V6 0/2] Add efi page fault handler to recover from page
Thread-Topic: [PATCH V6 0/2] Add efi page fault handler to recover from page
Thread-Index: AQHUSgPvEzpiqTGq+0Wil0e+O2nOnaTtLa0A//+093A=
Date:   Wed, 12 Sep 2018 17:32:43 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485BB5A3@ORSMSX114.amr.corp.intel.com>
References: <1536693322-8335-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu8zfM_iZ7T7P=5+1aXEHPaL3E2yQ_eWEsXCJA3zaAA6Yw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8zfM_iZ7T7P=5+1aXEHPaL3E2yQ_eWEsXCJA3zaAA6Yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzk0MTczY2MtZWQ3MC00MDNjLTllNjItOTcwODdiY2E1YWJiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRTZRTVh1U0k5MUI2R1B5SWVwdnpER3VLdDRQQnRoWjdUd251NStzRGRhd2JIQ1BwN1pEQUU3XC8xMDlUaGt2XC9jIn0=
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

PiA+IFRoaXMgaXNzdWUgd2FzIHJlcG9ydGVkIGJ5IEFsIFN0b25lIHdoZW4gaGUgc2F3IHRoYXQg
cmVib290IHZpYSBFRkkNCj4gPiBoYW5ncyB0aGUgbWFjaGluZS4gVXBvbiBkZWJ1Z2dpbmcsIEkg
Zm91bmQgdGhhdCBpdCdzDQo+ID4gZWZpX3Jlc2V0X3N5c3RlbSgpIHRoYXQncyB0b3VjaGluZyBt
ZW1vcnkgcmVnaW9ucyB3aGljaCBpdCBzaG91bGRuJ3QuDQo+ID4gVG8gcmVwcm9kdWNlIHRoZSBz
YW1lIGJlaGF2aW9yLCBJIGhhdmUgaGFja2VkIE9WTUYgYW5kIG1hZGUNCj4gPiBlZmlfcmVzZXRf
c3lzdGVtKCkgYnVnZ3kuIEFsb25nIHdpdGggZWZpX3Jlc2V0X3N5c3RlbSgpLCBJIGhhdmUgYWxz
bw0KPiA+IG1vZGlmaWVkIGdldF9uZXh0X2hpZ2hfbW9ub19jb3VudCgpIGFuZCBzZXRfdmlydHVh
bF9hZGRyZXNzX21hcCgpLg0KPiA+IFRoZXkgaWxsZWdhbGx5IGFjY2VzcyBib3RoIGJvb3QgdGlt
ZSBhbmQgb3RoZXIgZWZpIHJlZ2lvbnMuDQo+ID4NCj4gPiBUZXN0aW5nIHRoZSBwYXRjaCBzZXQ6
DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IDEuIERvd25sb2FkIGJ1Z2d5IGZpcm13
YXJlIGZyb20gaGVyZSBbMV0uDQo+ID4gMi4gUnVuIGEgcWVtdSBpbnN0YW5jZSB3aXRoIHRoaXMg
YnVnZ3kgQklPUyBhbmQgYm9vdCBtYWlubGluZSBrZXJuZWwuDQo+ID4gQWRkIHJlYm9vdD1lZmkg
dG8gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgYXJndW1lbnRzIGFuZCBhZnRlciB0aGUNCj4gPiBr
ZXJuZWwgaXMgdXAgYW5kIHJ1bm5pbmcsIHR5cGUgInJlYm9vdCIuIFRoZSBrZXJuZWwgc2hvdWxk
IGhhbmcgd2hpbGUNCj4gcmVib290aW5nLg0KPiA+IDMuIFdpdGggdGhlIHNhbWUgc2V0dXAsIGJv
b3Qga2VybmVsIGFmdGVyIGFwcGx5aW5nIHBhdGNoZXMgYW5kIHRoZQ0KPiA+IHJlYm9vdCBzaG91
bGQgd29yayBmaW5lLiBBbHNvIHBsZWFzZSBub3RpY2Ugd2FybmluZy9lcnJvciBtZXNzYWdlcw0K
PiA+IHByaW50ZWQgYnkga2VybmVsLg0KPiA+DQo+IA0KPiBEaWQgeW91IHRlc3QgdGhlc2UgcGF0
Y2hlcyB3aXRoIG90aGVyIGJ1Z2d5IHJ1bnRpbWUgc2VydmljZXM/DQoNClllcywgSSBkaWQuIEkg
aGF2ZSBtb2RpZmllZCBlZmkgcnVudGltZSBzZXJ2aWNlIEdldE5leHRIaWdoTW9ub3RvbmljQ291
bnQgDQphbmQgbWFkZSBpdCBidWdneSwgd2hlbiBpbnZva2VkIGZyb20gRldUUyB0ZXN0IHN1aXRl
cyB0aGUgZWZpIHBhZ2UgZmF1bHQgDQpoYW5kbGVyIHdvcmtzIGFzIGV4cGVjdGVkIChpLmUuIGZy
ZWV6aW5nIGVmaV9ydHNfd3EgYW5kIGRpc2FibGluZyBlZmkgcnVudGltZSANCnNlcnZpY2VzIGZv
cmV2ZXIpLg0KDQpSZWdhcmRzLA0KU2FpDQo=
