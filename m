Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D25C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729EE208B9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzhr6p9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729EE208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeHYBof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:44:35 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37676 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeHYBof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:44:35 -0400
Received: by mail-io0-f194.google.com with SMTP id v14-v6so8335559iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0xM2pNsYZf385S4EkacTgpZYu/nCsjMd3on65ye0rhA=;
        b=tzhr6p9zEr70jmuekB2rzlEJr6aKQM24lX2Y2DWo6xV0O4XAkIh4wXfBfBOKwCTgJT
         LCQLASsTcQ1T1tLXbwDx2KCJXXuSjXWlFpmMmrUf+BMQr3l0UjviXT8VG/Rkso1s87mW
         LZ89oN1+WbzDadx2CCdpmmZMz/0eOM9CYTt9P9UdGPrK2cd9+HHiQOUhfhVUERGRPFNq
         iNEKrNyaHLBDnXGCNjDrkQMn43/NHkRaCnBzZ0Dy2UvIVjq2/EzqCZluqdgRRFGvkt6r
         uY1obbrhf7thl0iRmesRNxgL5MGqFxj0KvVNLmvaZ1Fm4/6Kfu9SOSS0bkIvMymZsF7V
         65sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0xM2pNsYZf385S4EkacTgpZYu/nCsjMd3on65ye0rhA=;
        b=UglkGX86LWYiuYUN4ClJzD67vuQH5S19Oaa3RywM/Y5Maw4lHh0+4a3gauv5iP9tQc
         3szrlWB8AIWlrDfQWEshUTJCifkP70Gj/29xHaeViSiIP03ZJFeqYIdDl2rv/KX2CMna
         ZiyzGmc2mkqp5Hg2ophv12+YT4z2Nb3rWn4wM8BOlsfvjiKImVQTB/Hpi9Qoc3sNZrjh
         qeqlS1JrPG2cUqrlbinMiJbB4Lqc9mASMqdkmtov7dFV0QFSD7lHfWSS1Q8Qh+Bw6TnR
         8fi/xdaLi0zE9sBayjyqZxGVWZjkRyv7TJB+y/6MuYja0OybC1Ks/4q+JYoW7SOQ+SWI
         0oHA==
X-Gm-Message-State: APzg51DpPl/wyYn2fh8ExrXBs9Z3GgNizM3eT3+biYj8US0puSj0pOg8
        DxmvDX4bNl9k7qG6SJjtOhQ5NplVb8RpJFytlN4=
X-Google-Smtp-Source: ANB0Vdbj0eLhH2HBWrunEARGiG+3YsyZG4lV93kB8T/rzwGQV8lPhHGt85sVA0zBvLKKm9zXqrRHkVJAHOe+Mp6Ej2w=
X-Received: by 2002:a5e:890c:: with SMTP id k12-v6mr2667329ioj.136.1535148485155;
 Fri, 24 Aug 2018 15:08:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7112:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 15:08:04
 -0700 (PDT)
In-Reply-To: <e8622920d68c008edf72bcd93a8716fc59c2f55d.camel@intel.com>
References: <e8622920d68c008edf72bcd93a8716fc59c2f55d.camel@intel.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Fri, 24 Aug 2018 15:08:04 -0700
Message-ID: <CAA9_cmcwcjeVGkVNZnrAb2V61t1VibyxX5zsuZLYfB93g-2ynA@mail.gmail.com>
Subject: Re: [GIT PULL]: libnvdimm updates for 4.19-rc1 v2 [2/2]
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        dave.jiang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/18, Jiang, Dave <dave.jiang@intel.com> wrote:
> Hi Linus,
>
> Please pull to receive the libnvdimm dax-memory-failure series for
> v4.19-rc1. I have removed the
> offending ilog2() call and fixed up the patch accordingly.

Hi Linus,

Last business day of the merge window, one last ditch effort to
advocate for the inclusion of this and the other v2 libnvdimm pull
request for 4.19.

I agree with you that something is broken when a readily visible
mistake in core code makes it all the way to you. I take no issue with
your frustration, and I would not have pulled that branch either.

Dave fixed it up, albeit with a rebase, but I'm not aware of any
lingering issues.

Please save me from having to do another apology tour with
stakeholders that were expecting this to land since 4.18, or otherwise
let me know what process changes you would like to see going forward
for these cross sub-system pmem / dax feature series.

>
> As Dan mentioned, the justification for pushing this sooner rather than
> later is to
> start the pipeline to the distros since enterprise in-memory-database
> developers reported this gap in the kernel memory error handling
> compared to the DRAM / page cache case.
>
> I'm including Dan's original cover for the series for context:
> "
> As it stands, memory_failure() gets thoroughly confused by dev_pagemap
> backed mappings. The recovery code has specific enabling for several
> possible page states and needs new enabling to handle poison in dax
> mappings.
>
> In order to support reliable reverse mapping of user space addresses:
>
> 1/ Add new locking in the memory_failure() rmap path to prevent races
> that would typically be handled by the page lock.
>
> 2/ Since dev_pagemap pages are hidden from the page allocator and the
> "compound page" accounting machinery, add a mechanism to determine the
> size of the mapping that encompasses a given poisoned pfn.
>
> 3/ Given pmem errors can be repaired, change the speculatively accessed
> poison protection, mce_unmap_kpfn(), to be reversible and otherwise
> allow ongoing access from the kernel.
>
> A side effect of this enabling is that MADV_HWPOISON becomes usable for
> dax mappings, however the primary motivation is to allow the system to
> survive userspace consumption of hardware-poison via dax. Specifically
> the current behavior is:
>
>     mce: Uncorrected hardware memory error in user-access at af34214200
>     {1}[Hardware Error]: It has been corrected by h/w and requires no
> further action
>     mce: [Hardware Error]: Machine check events logged
>     {1}[Hardware Error]: event severity: corrected
>     Memory failure: 0xaf34214: reserved kernel page still referenced by 1
> users
>     [..]
>     Memory failure: 0xaf34214: recovery action for reserved kernel page:
> Failed
>     mce: Memory error not recovered
>     <reboot>
>
> ...and with these changes:
>
>     Injecting memory failure for pfn 0x20cb00 at process virtual address
> 0x7f763dd00000
>     Memory failure: 0x20cb00: Killing dax-pmd:5421 due to hardware memory
> corruption
>     Memory failure: 0x20cb00: recovery action for dax page: Recovered
>
> Given all the cross dependencies I propose taking this through
> nvdimm.git with acks from Naoya, x86/core, x86/RAS, and of course dax
> folks.
> "
>
> I hope you will consider pulling the patch series. Thank you!
>
> The following changes since commit
> 021c91791a5e7e85c567452f1be3e4c2c6cb6063:
>
>   Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)
>
> are available in the Git repository at:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/nvdimm/nvdimm.git
> tags/libnvdimm-for-4.19_dax-memory-failure
>
> for you to fetch changes up to c953cc987ab87d180e1d5de2f1c217abe33aac77:
>
>   libnvdimm, pmem: Restore page attributes when clearing errors (2018-08-20
> 09:22:45 -0700)
>
> ----------------------------------------------------------------
> libnvdimm-for-4.19_dax-memory-failure
>
> * memory_failure() gets confused by dev_pagemap backed mappings. The
>   recovery code has specific enabling for several possible page states
>   that needs new enabling to handle poison in dax mappings. Teach
>   memory_failure() about ZONE_DEVICE pages.
>
> ----------------------------------------------------------------
> Dan Williams (13):
>       device-dax: Convert to vmf_insert_mixed and vm_fault_t
>       device-dax: Enable page_mapping()
>       device-dax: Set page->index
>       filesystem-dax: Set page->index
>       mm, madvise_inject_error: Disable MADV_SOFT_OFFLINE for ZONE_DEVICE
> pages
>       mm, dev_pagemap: Do not clear ->mapping on final put
>       mm, madvise_inject_error: Let memory_failure() optionally take a page
> reference
>       mm, memory_failure: Collect mapping size in collect_procs()
>       filesystem-dax: Introduce dax_lock_mapping_entry()
>       mm, memory_failure: Teach memory_failure() about dev_pagemap pages
>       x86/mm/pat: Prepare {reserve, free}_memtype() for "decoy" addresses
>       x86/memory_failure: Introduce {set, clear}_mce_nospec()
>       libnvdimm, pmem: Restore page attributes when clearing errors
>
>  arch/x86/include/asm/set_memory.h         |  42 ++++++
>  arch/x86/kernel/cpu/mcheck/mce-internal.h |  15 ---
>  arch/x86/kernel/cpu/mcheck/mce.c          |  38 +-----
>  arch/x86/mm/pat.c                         |  16 +++
>  drivers/dax/device.c                      |  75 +++++++----
>  drivers/nvdimm/pmem.c                     |  26 ++++
>  drivers/nvdimm/pmem.h                     |  13 ++
>  fs/dax.c                                  | 125 ++++++++++++++++--
>  include/linux/dax.h                       |  13 ++
>  include/linux/huge_mm.h                   |   5 +-
>  include/linux/mm.h                        |   1 +
>  include/linux/set_memory.h                |  14 ++
>  kernel/memremap.c                         |   1 -
>  mm/hmm.c                                  |   2 +
>  mm/huge_memory.c                          |   4 +-
>  mm/madvise.c                              |  16 ++-
>  mm/memory-failure.c                       | 210
> ++++++++++++++++++++++++------
>  17 files changed, 481 insertions(+), 135 deletions(-)
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
>
