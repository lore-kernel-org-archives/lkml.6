Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57851C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02F120836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kSwqLodM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02F120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935427AbeFRRc6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:32:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755035AbeFRRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ho0gJWy2VGgxHH6mYV3NUrZdpqN7Q6wqf6v0EGTdqQs=; b=kSwqLodMxyZdgT1fqTsNlabo2
        ZuFDS79ShSgqFOHojU//AJjPOFFibu2vjnQvXxOp2xW5Un5/0e+tlDpD/eFr/X5XU+mKGCo0PL4OR
        croTvhtLtVdteBVqkPSbEOkgAp2FupkMoGLyMblC9a4pEZs6B7zaBiOmyrodeoFOpVRD6zFbtIJQr
        0JUTuFCE9D98yh5mQfSVj65gak+MGPZ1x5nAkoTyxyDagZADGoER57wv5q430T4azS+4XJ21sKcJw
        MGkOWPOULLGIqxGBKPDHKUg8fId8IV+2Mzqi1VqABSlANYqVVt6PbtXwFZA+jWT33m+UlMwZh8O3u
        6UIH9nalQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUy1O-00065M-Ur; Mon, 18 Jun 2018 17:32:56 +0000
Subject: Re: [PATCH 11/11] docs/mm: add description of boot time memory
 management
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1529341199-17682-12-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3d0f5f7f-7444-4559-c993-f85e7198eb38@infradead.org>
Date:   Mon, 18 Jun 2018 10:32:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529341199-17682-12-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 09:59 AM, Mike Rapoport wrote:
> Both bootmem and memblock are have pretty good internal documentation
> coverage. With addition of some overview we get a nice description of the
> early memory management.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  Documentation/core-api/boot-time-mm.rst | 92 +++++++++++++++++++++++++++++++++
>  Documentation/core-api/index.rst        |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/core-api/boot-time-mm.rst
> 
> diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
> new file mode 100644
> index 0000000..379e5a3
> --- /dev/null
> +++ b/Documentation/core-api/boot-time-mm.rst
> @@ -0,0 +1,92 @@
> +===========================
> +Boot time memory management
> +===========================
> +
> +Early system initialization cannot use "normal" memory management
> +simply because it is not set up yet. But there is still need to
> +allocate memory for various data structures, for instance for the
> +physical page allocator. To address this, a specialized allocator
> +called the :ref:`Boot Memory Allocator <bootmem>`, or bootmem, was
> +introduced. Several years later PowerPC developers added a "Logical
> +Memory Blocks" which was later adopted by other architectures and

   Memory Blocks" allocator, which was later ...

> +renamed to :ref:`memblock <memblock>`. There is also a compatibility
> +layer called `nobootmem` that translates bootmem allocation interfaces
> +to memblock calls.
> +
> +The selection of the early alocator is done using

                              allocator

> +``CONFIG_NO_BOOTMEM`` and ``CONFIG_HAVE_MEMBLOCK`` kernel
> +configuration options. These options are enabled or disabled
> +statically by the architectures' Kconfig files.
> +
> +* Architectures that rely only on bootmem select ``CONFIG_NO_BOOTMEM=n
> +  && CONFIG_HAVE_MEMBLOCK=n``.
> +* The users of memblock with the nobootmem compatibility layer set
> +  ``CONFIG_NO_BOOTMEM=y && CONFIG_HAVE_MEMBLOCK=y``.
> +* And for those that use both memblock and bootmem the configuration
> +  includes ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=y

             fix ending:                                   =y``.

> +
> +Whichever allocator is used, it is the responsibility of the
> +architecture specific initialization to set it up in
> +:c:func:`setup_arch` and tear it down in :c:func:`mem_init` functions.
> +
> +Once the early memory manegement is available it offers variety of

                         management                 offers a variety of

> +functions and macros for memory allocations. The allocation request
> +may be directed to the first (and probably the only) node or to a
> +particular node in a NUMA system. There are API variants that panic
> +when an allocation fails and those that don't. And more recent and
> +advanced memblock even allows controlling its own behaviour.
> +
> +.. _bootmem:
> +
> +Bootmem
> +=======
> +
> +(mostly stolen from Mel Gorman's "Understanding the Linux Virtual
> +Memory Manager" `book`_)
> +
> +.. _book: https://www.kernel.org/doc/gorman/
> +
> +.. kernel-doc:: mm/bootmem.c
> +   :doc: bootmem overview
> +
> +.. _memblock:
> +
> +Memblock
> +========
> +
> +.. kernel-doc:: mm/memblock.c
> +   :doc: memblock overview
> +
> +
> +Functions and structures
> +========================
> +
> +Common API
> +----------
> +
> +The functions that are described in this section are available
> +regardless of what early memory manager is enabled.
> +
> +.. kernel-doc:: mm/nobootmem.c
> +
> +Bootmem specific API
> +--------------------
> +
> +The interfaces available only with bootmem, i.e when ``CONFIG_NO_BOOTMEM=n``

                                               i.e.
How about:

  These interfaces are available only with bootmem, i.e. when ``CONFIG_NO_BOOTMEM=n``.

> +
> +.. kernel-doc:: include/linux/bootmem.h
> +.. kernel-doc:: mm/bootmem.c
> +   :nodocs:
> +
> +Memblock specific API
> +---------------------
> +
> +Here is the description of memblock data structures, functions and
> +macros. Some of them are actually internal, but since they are
> +documented it would be silly to omit them. Besides, reading the
> +descriptions for the internal functions can help to understand what
> +really happens under the hood.
> +
> +.. kernel-doc:: include/linux/memblock.h
> +.. kernel-doc:: mm/memblock.c
> +   :nodocs:
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index f5a66b7..93d5a46 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -28,6 +28,7 @@ Core utilities
>     printk-formats
>     circular-buffers
>     gfp_mask-from-fs-io
> +   boot-time-mm
>  
>  Interfaces for kernel debugging
>  ===============================
> 


-- 
~Randy
