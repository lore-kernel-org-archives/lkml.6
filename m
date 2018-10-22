Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A1CC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4239020663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4239020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeJWBzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:55:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:9708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbeJWBzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:55:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 10:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="97526212"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2018 10:35:37 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.194]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.129]) with mapi id 14.03.0319.002;
 Mon, 22 Oct 2018 10:35:36 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH 1/2] x86/efi: Unmap efi boot services code/data regions
 from efi_pgd
Thread-Topic: [PATCH 1/2] x86/efi: Unmap efi boot services code/data regions
 from efi_pgd
Thread-Index: AQHUaae1+/df8a0vpkCawzkqjxdfr6Uq90AAgAAyZQCAAF3A8A==
Date:   Mon, 22 Oct 2018 17:35:36 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485D5D88@ORSMSX114.amr.corp.intel.com>
References: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1540172145-17134-2-git-send-email-sai.praneeth.prakhya@intel.com>
 <20181022015738.GB24095@gmail.com>
 <CALCETrW=M8u=F6USUk3t_sucGnU-8K6sLYOq6BGK1JhPdgjzdw@mail.gmail.com>
In-Reply-To: <CALCETrW=M8u=F6USUk3t_sucGnU-8K6sLYOq6BGK1JhPdgjzdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzk4ZGUyMjEtOGVhZi00NGI3LTlmODgtNzEzNmNlNjc0ZjlhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibzdsdmw5S0F5clp4dWVadUpjOFlvZmZLeHE2RVcwczlVbGRrNnFadlBOeWtOS2hQeDJUeFQ4QzBjSDRvZThtdiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoZSBvbmUgYml0IHRoYXQgaXMgb2RkIGlzIHRoZSBjcGEtPnBmbiBmaWVsZCAtIGZvciB1
bm1hcHBlZCBwYWdlcw0KPiA+IHRoYXQncyB0b3RhbGx5IHVuaW50ZXJlc3RpbmcgYW5kIEknbSB3
b25kZXJpbmcgd2hldGhlciBzZXR0aW5nIGl0IHRvIDANCj4gPiB3b3VsZG4ndCBiZSBiZXR0ZXIu
DQo+ID4NCj4gPiBEb2VzIHRoZSBDUFUgX2V2ZXJfIGxvb2sgbG9vayBhdCB0aGUgUEZOIGlmIHRo
ZSBwYWdlIGlzDQo+ID4gIV9QQUdFX1BSRVNFTlQsIGZvciBleGFtcGxlIHNwZWN1bGF0aXZlbHk/
IElmIHllcyB0aGVuIHdoYXQgaXMgdGhlDQo+ID4gcmVjb21tZW5kZWQgdmFsdWUgZm9yIHRoZSBw
Zm4gLSB6ZXJvIHBlcmhhcHM/DQo+ID4NCj4gDQo+IFRoaXMgaXMgTDFURiwgcmlnaHQ/ICBJc24n
dCBhbGwgb25lcyB0aGUgcmVjb21tZW5kZWQgdmFsdWU/DQo+IA0KPiBJIHdvdWxkIGxvdmUgdG8g
c2VlIEVGSSBzdGFydCB0cmVhdGluZyBpdHMgbW0ganVzdCBsaWtlIGFueSBvdGhlciBtbSBhdCBz
b21lDQo+IHBvaW50LCB0aG91Z2guICBUaGF0IGlzLCBpdCBzaG91bGQgbm90IG1vZGlmeSBhbnkg
bWFwcGluZ3MgaW4gdGhlIGtlcm5lbCByYW5nZSwNCj4gYW5kIGl0IGNvdWxkIHVzZSB0aGUgcmVn
dWxhciBtbSBtb2RpZmljYXRpb24gQVBJcyBmb3IgdGhlIHVzZXIgcmFuZ2UuICBCdXQgbWF5YmUN
Cj4gdGhpcyBpcyBhIHBpcGUgZHJlYW0uDQoNClNvdW5kcyBnb29kIHRvIG1lLiBJIGhhdmUgc29t
ZSBtb3JlIGZpeGVzIGZvciBFRkkgY29kZSBhbmQgYXMgc29vbiBhcyB0aGV5IGFyZSBkb25lLCAN
Ckkgd2lsbCBzdGFydCBsb29raW5nIGludG8gdGhpcy4NCg0KUmVnYXJkcywNClNhaQ0K
