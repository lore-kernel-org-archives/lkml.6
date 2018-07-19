Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80039C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5D220684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5D220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbeGSSlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:41:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:34179 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbeGSSlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:41:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 10:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,375,1526367600"; 
   d="scan'208";a="68449817"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2018 10:57:08 -0700
Subject: Re: [PATCH v6 00/13] mm: Teach memory_failure() about ZONE_DEVICE
 pages
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Tony Luck <tony.luck@intel.com>, Jan Kara <jack@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Matthew Wilcox <willy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-edac@vger.kernel.org
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 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
 o6nmKbYpUAltQObU2w==
Message-ID: <b9602b1b-97d3-b9c1-cc85-5b73b67e2e03@intel.com>
Date:   Thu, 19 Jul 2018 10:57:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
Is it possible to ack the x86 bits in this patch series? I'm hoping to
get this pulled through the libnvdimm tree for 4.19. Thanks!

On 07/13/2018 09:49 PM, Dan Williams wrote:
> Changes since v5 [1]:
> * Move put_page() before memory_failure() in madvise_inject_error()
>   (Naoya)
> * The previous change uncovered a latent bug / broken assumption in
>   __put_devmap_managed_page(). We need to preserve page->mapping for
>   dax pages when they go idle.
> * Rename mapping_size() to dev_pagemap_mapping_size() (Naoya)
> * Catch and fail attempts to soft-offline dax pages (Naoya)
> * Collect Naoya's ack on "mm, memory_failure: Collect mapping size in
>   collect_procs()"
> 
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2018-July/016682.html
> 
> ---
> 
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
>     {1}[Hardware Error]: It has been corrected by h/w and requires no further action
>     mce: [Hardware Error]: Machine check events logged
>     {1}[Hardware Error]: event severity: corrected
>     Memory failure: 0xaf34214: reserved kernel page still referenced by 1 users
>     [..]
>     Memory failure: 0xaf34214: recovery action for reserved kernel page: Failed
>     mce: Memory error not recovered
>     <reboot>
> 
> ...and with these changes:
> 
>     Injecting memory failure for pfn 0x20cb00 at process virtual address 0x7f763dd00000
>     Memory failure: 0x20cb00: Killing dax-pmd:5421 due to hardware memory corruption
>     Memory failure: 0x20cb00: recovery action for dax page: Recovered
> 
> Given all the cross dependencies I propose taking this through
> nvdimm.git with acks from Naoya, x86/core, x86/RAS, and of course dax
> folks.
> 
> ---
> 
> Dan Williams (13):
>       device-dax: Convert to vmf_insert_mixed and vm_fault_t
>       device-dax: Enable page_mapping()
>       device-dax: Set page->index
>       filesystem-dax: Set page->index
>       mm, madvise_inject_error: Disable MADV_SOFT_OFFLINE for ZONE_DEVICE pages
>       mm, dev_pagemap: Do not clear ->mapping on final put
>       mm, madvise_inject_error: Let memory_failure() optionally take a page reference
>       mm, memory_failure: Collect mapping size in collect_procs()
>       filesystem-dax: Introduce dax_lock_mapping_entry()
>       mm, memory_failure: Teach memory_failure() about dev_pagemap pages
>       x86/mm/pat: Prepare {reserve,free}_memtype() for "decoy" addresses
>       x86/memory_failure: Introduce {set,clear}_mce_nospec()
>       libnvdimm, pmem: Restore page attributes when clearing errors
> 
> 
>  arch/x86/include/asm/set_memory.h         |   42 ++++++
>  arch/x86/kernel/cpu/mcheck/mce-internal.h |   15 --
>  arch/x86/kernel/cpu/mcheck/mce.c          |   38 -----
>  arch/x86/mm/pat.c                         |   16 ++
>  drivers/dax/device.c                      |   75 +++++++---
>  drivers/nvdimm/pmem.c                     |   26 ++++
>  drivers/nvdimm/pmem.h                     |   13 ++
>  fs/dax.c                                  |  125 ++++++++++++++++-
>  include/linux/dax.h                       |   13 ++
>  include/linux/huge_mm.h                   |    5 -
>  include/linux/mm.h                        |    1 
>  include/linux/set_memory.h                |   14 ++
>  kernel/memremap.c                         |    1 
>  mm/hmm.c                                  |    2 
>  mm/huge_memory.c                          |    4 -
>  mm/madvise.c                              |   16 ++
>  mm/memory-failure.c                       |  210 +++++++++++++++++++++++------
>  17 files changed, 481 insertions(+), 135 deletions(-)
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
