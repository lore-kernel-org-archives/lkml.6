Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53252ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE472075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE472075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJYHfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:35:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbeJYHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:35:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9ON4Dja142156
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 19:05:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nay6dpn9a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 19:05:42 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 25 Oct 2018 00:04:39 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 00:04:34 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9ON4YFv21037056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Oct 2018 23:04:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9A3B4C052;
        Wed, 24 Oct 2018 23:04:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6B954C050;
        Wed, 24 Oct 2018 23:04:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Oct 2018 23:04:29 +0000 (GMT)
Date:   Thu, 25 Oct 2018 00:04:26 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] prmem: documentation
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-11-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18102423-0020-0000-0000-000002D9A15F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102423-0021-0000-0000-00002128CD6D
Message-Id: <20181024230426.GA27484@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810240191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Wed, Oct 24, 2018 at 12:34:57AM +0300, Igor Stoppa wrote:
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

Thanks for having docs a part of the patchset!

>  MAINTAINERS                      |   1 +
>  3 files changed, 174 insertions(+)
>  create mode 100644 Documentation/core-api/prmem.rst
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 26b735cefb93..1a90fa878d8d 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -31,6 +31,7 @@ Core utilities
>     gfp_mask-from-fs-io
>     timekeeping
>     boot-time-mm
> +   prmem
> 
>  Interfaces for kernel debugging
>  ===============================
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
> +
> +- Kernel code is protected at system level and, unlike data, it doesn't
> +  require special attention.
> +

I feel that foreword should include a sentence or two saying why we need
the memory protection and when it can/should be used.

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
> +   exceptions.
> +
> +- **write rare after init**
> +   This can be seen as variant of read only after init, which uses the
> +   tag **__wr_after_init**. It is also limited to statically allocated
> +   memory. It is still possible to alter this type of variables, after

                                                         no comma ^

> +   the kernel init phase is complete, however it can be done exclusively
> +   with special functions, instead of the assignment operator. Using the
> +   assignment operator after conclusion of the init phase will still
> +   trigger an exception. It is not possible to transition a certain
> +   variable from __wr_ater_init to a permanent read-only status, at

                    __wr_aFter_init

> +   runtime.
> +
> +- **dynamically allocated write-rare / read-only**
> +   After defining a pool, memory can be obtained through it, primarily
> +   through the **pmalloc()** allocator. The exact writability state of the
> +   memory obtained from **pmalloc()** and friends can be configured when
> +   creating the pool. At any point it is possible to transition to a less
> +   permissive write status the memory currently associated to the pool.
> +   Once memory has become read-only, it the only valid operation, beside

... become read-only, the only valid operation

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

For me this part is completely blind. Maybe arranging this as a table would
make the states more clearly visible.

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
> +    - The "START_WR" mode is the only one which provides immediate protection, at the cost of speed.
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

   no comma ^

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
> +  action, respect to the way they use the data being altered; for example,
> +  take a lock before making a copy of the value to modify (if it's
> +  relevant), then alter it, issue the call to rare write and finally
> +  release the lock. Some special scenario might be exempt from the need
> +  for locking, but in general rare-write must be treated as an operation
> +  that can incur into races.
> +
> +- pmalloc relies on virtual memory areas and will therefore use more
> +  tlb entries. It still does a better job of it, compared to invoking
> +  vmalloc for each allocation, but it is undeniably less optimized wrt to
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea979a5a9ec9..246b1a1cc8bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9463,6 +9463,7 @@ F:	include/linux/prmemextra.h
>  F:	mm/prmem.c
>  F:	mm/test_write_rare.c
>  F:	mm/test_pmalloc.c
> +F:	Documentation/core-api/prmem.rst

I think the MAINTAINERS update can go in one chunk as the last patch in the
series.
 
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

