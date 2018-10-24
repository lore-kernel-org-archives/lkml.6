Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF4C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529A120652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wVKjWJwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529A120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeJXMOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:14:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60868 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXMOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QuZpdeB1g30decvzUgODf+XusTXvloL8MltxAnxKZiQ=; b=wVKjWJwJ0ej8v4nmaanMs5BXbv
        A3/1HseTI6OrwN2O9/V+/GPWtcoYrjf6N+7e3v4sf3P6kU6RnmuuGTsU2lSndD97BlA0uczxBn77t
        jLekgr5xm6Q1/n6Ri3TfPn6TB38o5M4kWh87B/9eNVvIX/642ikTSplmnofr7Rj+KEKarIodhMCq4
        OoDLfq9DEDx5/7TERUJRIhr0h5uxiKgoAOr+zvrZa6KE72U64s3x9S2pYx0LU1vhAhaawkqHAbE1t
        hB94VfP2Gnf7L9ogZJgDn67c9hVGz6PEkAKsZF26x+ofeBZ0oL4oODoe1viU2YeGXV3uSdoaD2NNd
        NXe2ut8Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFA9r-0005h7-Hh; Wed, 24 Oct 2018 03:48:35 +0000
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b09b3feb-8e3d-5fab-4e2b-35e8c252b27c@infradead.org>
Date:   Tue, 23 Oct 2018 20:48:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023213504.28905-11-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/23/18 2:34 PM, Igor Stoppa wrote:
> Documentation for protected memory.
> 
> Topics covered:
> * static memory allocation
> * dynamic memory allocation
> * write-rare
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Randy Dunlap <rdunlap@infradead.org>
> CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/core-api/index.rst |   1 +
>  Documentation/core-api/prmem.rst | 172 +++++++++++++++++++++++++++++++
>  MAINTAINERS                      |   1 +
>  3 files changed, 174 insertions(+)
>  create mode 100644 Documentation/core-api/prmem.rst


> diff --git a/Documentation/core-api/prmem.rst b/Documentation/core-api/prmem.rst
> new file mode 100644
> index 000000000000..16d7edfe327a
> --- /dev/null
> +++ b/Documentation/core-api/prmem.rst
> @@ -0,0 +1,172 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _prmem:
> +
> +Memory Protection
> +=================
> +
> +:Date: October 2018
> +:Author: Igor Stoppa <igor.stoppa@huawei.com>
> +
> +Foreword
> +--------
> +- In a typical system using some sort of RAM as execution environment,
> +  **all** memory is initially writable.
> +
> +- It must be initialized with the appropriate content, be it code or data.
> +
> +- Said content typically undergoes modifications, i.e. relocations or
> +  relocation-induced changes.
> +
> +- The present document doesn't address such transient.

                                               transience.

> +
> +- Kernel code is protected at system level and, unlike data, it doesn't
> +  require special attention.
> +
> +Protection mechanism
> +--------------------
> +
> +- When available, the MMU can write protect memory pages that would be
> +  otherwise writable.
> +
> +- The protection has page-level granularity.
> +
> +- An attempt to overwrite a protected page will trigger an exception.
> +- **Write protected data must go exclusively to write protected pages**
> +- **Writable data must go exclusively to writable pages**
> +
> +Available protections for kernel data
> +-------------------------------------
> +
> +- **constant**
> +   Labelled as **const**, the data is never supposed to be altered.
> +   It is statically allocated - if it has any memory footprint at all.
> +   The compiler can even optimize it away, where possible, by replacing
> +   references to a **const** with its actual value.
> +
> +- **read only after init**
> +   By tagging an otherwise ordinary statically allocated variable with
> +   **__ro_after_init**, it is placed in a special segment that will
> +   become write protected, at the end of the kernel init phase.
> +   The compiler has no notion of this restriction and it will treat any
> +   write operation on such variable as legal. However, assignments that
> +   are attempted after the write protection is in place, will cause

no comma.

> +   exceptions.
> +
> +- **write rare after init**
> +   This can be seen as variant of read only after init, which uses the
> +   tag **__wr_after_init**. It is also limited to statically allocated
> +   memory. It is still possible to alter this type of variables, after
> +   the kernel init phase is complete, however it can be done exclusively
> +   with special functions, instead of the assignment operator. Using the
> +   assignment operator after conclusion of the init phase will still
> +   trigger an exception. It is not possible to transition a certain
> +   variable from __wr_ater_init to a permanent read-only status, at
> +   runtime.
> +
> +- **dynamically allocated write-rare / read-only**
> +   After defining a pool, memory can be obtained through it, primarily
> +   through the **pmalloc()** allocator. The exact writability state of the
> +   memory obtained from **pmalloc()** and friends can be configured when
> +   creating the pool. At any point it is possible to transition to a less
> +   permissive write status the memory currently associated to the pool.
> +   Once memory has become read-only, it the only valid operation, beside
> +   reading, is to released it, by destroying the pool it belongs to.
> +
> +
> +Protecting dynamically allocated memory
> +---------------------------------------
> +
> +When dealing with dynamically allocated memory, three options are
> + available for configuring its writability state:
> +
> +- **Options selected when creating a pool**
> +   When creating the pool, it is possible to choose one of the following:
> +    - **PMALLOC_MODE_RO**
> +       - Writability at allocation time: *WRITABLE*
> +       - Writability at protection time: *NONE*
> +    - **PMALLOC_MODE_WR**
> +       - Writability at allocation time: *WRITABLE*
> +       - Writability at protection time: *WRITE-RARE*
> +    - **PMALLOC_MODE_AUTO_RO**
> +       - Writability at allocation time:
> +           - the latest allocation: *WRITABLE*
> +           - every other allocation: *NONE*
> +       - Writability at protection time: *NONE*
> +    - **PMALLOC_MODE_AUTO_WR**
> +       - Writability at allocation time:
> +           - the latest allocation: *WRITABLE*
> +           - every other allocation: *WRITE-RARE*
> +       - Writability at protection time: *WRITE-RARE*
> +    - **PMALLOC_MODE_START_WR**
> +       - Writability at allocation time: *WRITE-RARE*
> +       - Writability at protection time: *WRITE-RARE*
> +
> +   **Remarks:**
> +    - The "AUTO" modes perform automatic protection of the content, whenever
> +       the current vmap_area is used up and a new one is allocated.
> +        - At that point, the vmap_area being phased out is protected.
> +        - The size of the vmap_area depends on various parameters.
> +        - It might not be possible to know for sure *when* certain data will
> +          be protected.
> +        - The functionality is provided as tradeoff between hardening and speed.
> +        - Its usefulness depends on the specific use case at hand

end above sentence with a period, please, like all of the others above it.

> +    - The "START_WR" mode is the only one which provides immediate protection, at the cost of speed.

Please try to keep the line above and a few below to < 80 characters in length.
(because some of us read rst files as text files, with a text editor, and line
wrap is ugly)

> +
> +- **Protecting the pool**
> +   This is achieved with **pmalloc_protect_pool()**
> +    - Any vmap_area currently in the pool is write-protected according to its initial configuration.
> +    - Any residual space still available from the current vmap_area is lost, as the area is protected.
> +    - **protecting a pool after every allocation will likely be very wasteful**
> +    - Using PMALLOC_MODE_START_WR is likely a better choice.
> +
> +- **Upgrading the protection level**
> +   This is achieved with **pmalloc_make_pool_ro()**
> +    - it turns the present content of a write-rare pool into read-only
> +    - can be useful when the content of the memory has settled
> +
> +
> +Caveats
> +-------
> +- Freeing of memory is not supported. Pages will be returned to the
> +  system upon destruction of their memory pool.
> +
> +- The address range available for vmalloc (and thus for pmalloc too) is
> +  limited, on 32-bit systems. However it shouldn't be an issue, since not
> +  much data is expected to be dynamically allocated and turned into
> +  write-protected.
> +
> +- Regarding SMP systems, changing state of pages and altering mappings
> +  requires performing cross-processor synchronizations of page tables.
> +  This is an additional reason for limiting the use of write rare.
> +
> +- Not only the pmalloc memory must be protected, but also any reference to
> +  it that might become the target for an attack. The attack would replace
> +  a reference to the protected memory with a reference to some other,
> +  unprotected, memory.
> +
> +- The users of rare write must take care of ensuring the atomicity of the

s/rare write/write rare/ ?

> +  action, respect to the way they use the data being altered; for example,

  This ..   "respect to the way" is awkward, but I don't know what to
change it to.

> +  take a lock before making a copy of the value to modify (if it's
> +  relevant), then alter it, issue the call to rare write and finally
> +  release the lock. Some special scenario might be exempt from the need
> +  for locking, but in general rare-write must be treated as an operation

It seemed to me that "write-rare" (or write rare) was the going name, but now
it's being called "rare write" (or rare-write).  Just be consistent, please.


> +  that can incur into races.
> +
> +- pmalloc relies on virtual memory areas and will therefore use more
> +  tlb entries. It still does a better job of it, compared to invoking

     TLB

> +  vmalloc for each allocation, but it is undeniably less optimized wrt to

s/wrt/with respect to/

> +  TLB use than using the physmap directly, through kmalloc or similar.
> +
> +
> +Utilization
> +-----------
> +
> +**add examples here**
> +
> +API
> +---
> +
> +.. kernel-doc:: include/linux/prmem.h
> +.. kernel-doc:: mm/prmem.c
> +.. kernel-doc:: include/linux/prmemextra.h


Thanks for the documentation.

-- 
~Randy
