Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748DEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D062195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbeLVTFm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:05:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:7081 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbeLVTFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:05:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Dec 2018 11:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,385,1539673200"; 
   d="scan'208";a="132170272"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2018 11:05:41 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.59]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.191]) with mapi id 14.03.0415.000;
 Sat, 22 Dec 2018 11:05:40 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Bhupesh Sharma" <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH] x86/efi: Don't unmap EFI boot services code/data
 regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Thread-Topic: [PATCH] x86/efi: Don't unmap EFI boot services code/data
 regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Thread-Index: AQHUmZ2DcDK9KhIqLEy5y3yuvYSshKWLHDcA///8OwA=
Date:   Sat, 22 Dec 2018 19:05:39 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48607FBC@ORSMSX114.amr.corp.intel.com>
References: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
 <20181222105410.GA130780@gmail.com>
In-Reply-To: <20181222105410.GA130780@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2NlYWM5MjMtNmIxNy00MDgwLWIwOGYtNDEzY2UwMDQyYjc1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYThJaWh0TGx5VnhHUnNvazNuTXlJeElmOVE4UWtjVnpWdGxuWjZhSVR4cXlZenhGYnc5QVVuUEFxcG9mSktEQiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> * Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:
> 
> > Commit d5052a7130a6 ("x86/efi: Unmap EFI boot services code/data
> > regions from efi_pgd") forgets to take two EFI modes into
> > consideration namely EFI_OLD_MEMMAP and EFI_MIXED_MODE.
> 
> So the commit sha1 ended up being this one in tip:efi/core:
> 
>   08cfb38f3ef4: x86/efi: Unmap EFI boot services code/data regions from
> efi_pgd

Ya.. sorry! I took the sha1 from efi tree.

> 
> > EFI_OLD_MEMMAP is a legacy way of mapping EFI regions into
> > swapper_pg_dir using ioremap() and init_memory_mapping(). This feature
> > can be enabled by passing "efi=old_map" as kernel command line
> > argument. But,
> > efi_unmap_pages() unmaps EFI boot services code/data regions *only*
> > from efi_pgd and hence cannot be used for unmapping EFI boot services
> > code/data regions from swapper_pg_dir.


[.........]


> > +	/*
> > +	 * EFI mixed mode has all RAM mapped to access arguments while
> making
> > +	 * EFI runtime calls, hence don't unmap EFI boot services code/data
> > +	 * regions.
> > +	 */
> > +	if (!efi_is_native() && IS_ENABLED(CONFIG_EFI_MIXED))
> > +		return;
> 
> I suppose old_mmap and mixed mode stopped working altogether after the
> unmapping changes?

Yes.. that's true.

> What are the symptoms, instant reboots, crasher, or some
> more benign behavior like non-working runtime EFI functionality?

I noticed a kernel panic due to page fault.

AFAIK, it happens because efi_pgd is not defined for old_map and mixed mode.
Hence efi_unmap_pages() which calls __change_page_attr() unmaps mappings 
from swapper_pg_dir (please note that this my theory but I haven't checked if
this is really true).

> 
> If Ard acks this I'll apply it immediately, as these bugs look like show-stoppers for
> merging the EFI tree into v4.21.
> 
> Thanks,
> 
> 	Ingo
