Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B247BC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B6E2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B6E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeKEFdf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:33:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:47920 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeKEFdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:33:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 12:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,465,1534834800"; 
   d="scan'208";a="103352696"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2018 12:17:21 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.228]) with mapi id 14.03.0415.000;
 Sun, 4 Nov 2018 12:17:21 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V3 1/3] x86/mm/pageattr: Introduce helper function to
 unmap EFI boot services
Thread-Topic: [PATCH V3 1/3] x86/mm/pageattr: Introduce helper function to
 unmap EFI boot services
Thread-Index: AQHUdHqmJGODujf5AUG7HCAp0C5/p6VADJdQ
Date:   Sun, 4 Nov 2018 20:17:20 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485EAD5A@ORSMSX114.amr.corp.intel.com>
References: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
 <20181104201019.26142-2-sai.praneeth.prakhya@intel.com>
In-Reply-To: <20181104201019.26142-2-sai.praneeth.prakhya@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWNhMDIxN2YtZjhmOS00MmJjLTkzNjYtY2YwNGExYWYxMDdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiclFHYlRzY1NoSFhwbkZ0UHQ4SlwvNDBoOVhlSGg0WTZWN3Y4a0VcLzRSSTUxMnZJOVZvM1FOaHhTbnNLQmxRaGlCIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ideally, after kernel assumes control of the platform, firmware shouldn't access
> EFI boot services code/data regions. But, it's noticed that this is not so true in
> many x86 platforms. Hence, during boot, kernel reserves EFI boot services
> code/data regions [1] and maps [2] them to efi_pgd so that call to
> set_virtual_address_map() doesn't fail.
> After returning from set_virtual_address_map(), kernel frees the reserved
> regions [3] but they still remain mapped. Hence, introduce
> kernel_unmap_pages_in_pgd() which will later be used to unmap EFI boot
> services code/data regions.
> 
> While at it modify kernel_map_pages_in_pgd() by 1. Adding __init modifier
> because it's always used *only* during boot.
> 2. Add a warning if it's used after SMP is initialized because it uses
>    __flush_tlb_all() which flushes mappings only on current CPU.
> 
> Unmapping EFI boot services code/data regions will result in clearing
> PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already
> handled by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.
> 
> [1] efi_reserve_boot_services()
> [2] efi_map_region() -> __map_region() -> kernel_map_pages_in_pgd() [3]
> efi_free_boot_services()
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Wasn't sure (and hence didn't) if I should add Acked-by Ingo because this patch changed from V2.

Regards,
Sai
