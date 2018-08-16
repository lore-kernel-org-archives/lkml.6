Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C26C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C182147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PusUAqJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C182147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeHPVWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:22:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeHPVWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nIYMumSHLhGP3EsWLYgh2h1R3JW6HOgodsM2hjm3ZFU=; b=PusUAqJrSLj3yPR3a9cR4xAX2
        ajBCYBasBugAl8AnHfobX2bIW1qe0Vdp4LInMA7r+52R2uHYrzJ1VAM0bYZ7zTHUcYwvG9kCAy9en
        Nfq+eAq9jXJFOhDb7UmXDzz90nPogHJ4csmAdR9a7hqdqXDDUl4PvpXpN0533/JggfcsKwKny1mDw
        PpVgPHjPF5Dar35psAF76PnHmCsed6HFckDn3yLfR4SRNfEMKfXs55+k71KTXealpPEe+sXCMlBpt
        yRKwOymq9rHO5jeR9eh/EWqrAFwRJYmvC5g0MSWrJiGIBbweP4WOFt/s1GASUtf05jU9uBpM9rx2v
        3222iLSVg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fqMuE-0004OS-Ve; Thu, 16 Aug 2018 18:21:59 +0000
Subject: Re: [PATCH v2 3/3] docs: core-api: add memory allocation guide
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534424618-24713-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1534424618-24713-4-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c671cfd1-1057-7cd6-200b-f49874a9771b@infradead.org>
Date:   Thu, 16 Aug 2018 11:21:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534424618-24713-4-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 06:03 AM, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  Documentation/core-api/index.rst             |   1 +
>  Documentation/core-api/memory-allocation.rst | 124 +++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 Documentation/core-api/memory-allocation.rst


> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> new file mode 100644
> index 0000000..b9b0823
> --- /dev/null
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -0,0 +1,124 @@
> +=======================
> +Memory Allocation Guide
> +=======================
> +

[snip]

> +
> +Get Free Page flags
> +===================
> +
> +The GFP flags control the allocators behavior. They tell what memory
> +zones can be used, how hard the allocator should try to find free
> +memory, whether the memory can be accessed by the userspace etc. The
> +:ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>` provides
> +reference documentation for the GFP flags and their combinations and
> +here we briefly outline their recommended usage:
> +
> +  * Most of the time ``GFP_KERNEL`` is what you need. Memory for the
> +    kernel data structures, DMAable memory, inode cache, all these and
> +    many other allocations types can use ``GFP_KERNEL``. Note, that
> +    using ``GFP_KERNEL`` implies ``GFP_RECLAIM``, which means that
> +    direct reclaim may be triggered under memory pressure; the calling
> +    context must be allowed to sleep.
> +  * If the allocation is performed from an atomic context, e.g interrupt
> +    handler, use ``GFP_NOWAIT``. This flag prevents direct reclaim and
> +    IO or filesystem operations. Consequently, under memory pressure
> +    ``GFP_NOWAIT`` allocation is likely to fail. Allocations which
> +    have a reasonable fallback should be using ``GFP_NOWARN``.
> +  * If you think that accessing memory reserves is justified and the kernel
> +    will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.
> +  * Untrusted allocations triggered from userspace should be a subject
> +    of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
> +    is the handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``
> +    allocations that should be accounted.
> +  * Userspace allocations should use either of the ``GFP_USER``,
> +    ``GFP_HIGHUSER`` or ``GFP_HIGHUSER_MOVABLE`` flags. The longer
> +    the flag name the less restrictive it is.
> +
> +    ``GFP_HIGHUSER_MOVABLE`` does not require that allocated memory
> +    will be directly accessible by the kernel or the hardware and
> +    implies that the data is movable.
> +
> +    ``GFP_HIGHUSER`` means that the allocated memory is not movable,
> +    but it is not required to be directly accessible by the kernel or
> +    the hardware. An example may be a hardware allocation that maps
> +    data directly into userspace but has no addressing limitations.
> +
> +    ``GFP_USER`` means that the allocated memory is not movable and it
> +    must be directly accessible by the kernel or the hardware. It is
> +    typically used by hardware for buffers that are mapped to
> +    userspace (e.g. graphics) that hardware still must DMA to.
> +
> +You may notice that quite a few allocations in the existing code
> +specify ``GFP_NOIO`` or ``GFP_NOFS``. Historically, they were used to
> +prevent recursion deadlocks caused by direct memory reclaim calling
> +back into the FS or IO paths and blocking on already held
> +resources. Since 4.12 the preferred way to address this issue is to
> +use new scope APIs described in
> +:ref:`Documentation/core-api/gfp_mask-from-fs-io.rst <gfp_mask_from_fs_io>`.
> +
> +Other legacy GFP flags are ``GFP_DMA`` and ``GFP_DMA32``. They are
> +used to ensure that the allocated memory is accessible by hardware
> +with limited addressing capabilities. So unless you are writing a
> +driver for a device with such restrictions, avoid using these
> +flags. And even with HW with restrictions it is preferable to use

please s/HW/hardware/

> +`dma_alloc*` APIs.
> +
> +Selecting memory allocator
> +==========================

and then you can add
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
