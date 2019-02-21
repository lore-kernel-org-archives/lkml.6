Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5102BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1628F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="si3ZOYpx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtlucQrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfBULqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:46:10 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34717 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbfBULqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:46:09 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 474E631B9;
        Thu, 21 Feb 2019 06:46:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Feb 2019 06:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=e88mvsuJNRgqHBNnXywhB+0YLy7
        spBkA9JDbVpRqGZE=; b=si3ZOYpxLMDEStSLq9gGCC9PMjDZB359n2CGOG2Q8YV
        RhJPiMZ+GLNWbZn40ysWN8sccdQ8OxMoIZiIZ25KCSxy9EZwOS7pgvNdLlP0kTnD
        DcqIORu/MuX+b9vtpSmyB1kw8Z9rexsrYsCl6nHIrZAnwKhzwEyIUT/j16WIiiPK
        1Y7zLI6phAw7RDg+1yuLHK53YB+M6YUol5zFo6gmIprxi4CtbKw9nUDu5I2UbXRv
        ybMY0SDcf9T8Lw/c1TYln/He1wxXl/k5SXyZbeKZkv6Lg4fRZG6utvMRBmS4Y77/
        hAoiVpB3fCcx3igglJiCsFHNRnPUeeKTxFHuHAYW56A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=e88mvs
        uJNRgqHBNnXywhB+0YLy7spBkA9JDbVpRqGZE=; b=AtlucQrG4ZX8cWWxj6KJhX
        XGx7jlbPZDyT61QdUHFewOk/NEBvOFKEGW4dVS0IQFU0bZpxixbSPDgyrIOtlyWF
        iCywF+ENJdyf4aPEFBS+rMUqFVSBxaRCL8XdlCWCd1Rv1yG+uIc9qZwo8K1r7z6S
        tVwIi1ivsvuPGpOy8RIgSSYsk+JFmAdsMq6LVCiPJnnjsK1becJBJCkyq11Pfjyb
        49jSdx/CvfagOdKv84l8sarZ0JVHo+1HafX4EGktyoeVZzLyXJP4CUyuW9+B1Nqe
        kbELJd7AllcnSoT+CI8pve2MpDoq5/hb5o6FRsTtuLYq00suw9DRvHMDmLJ/LQvg
        ==
X-ME-Sender: <xms:fo9uXEpFecxFbyHuAfma8UtuhWJVpnXvDu7ELDKPsdQi7ZhDPGzfGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgdeffeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpghhnuh
    drohhrghenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:fo9uXE6v2hyiNTk9l8OcRmPyhCsA5H2xOnaDibSIjMn_2l9T8QEPaQ>
    <xmx:fo9uXOpTrZ90H5vGkxStQ5D4Igq1hlkDWHlFHkx_-o9sL_9su4hSXg>
    <xmx:fo9uXCIWiEgMHb_TZ1gjndLt_XlnkyYZiz7B3wFbhaPLTTh3Su2qxw>
    <xmx:fo9uXMWZHnGycemH2090jccAMlW4p2FGWXsMnayZ6VNhRhmQ37nYHg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 21C56E454E;
        Thu, 21 Feb 2019 06:46:06 -0500 (EST)
Date:   Thu, 21 Feb 2019 12:46:04 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     cai@lca.pw, stable-commits@vger.kernel.org
Subject: Re: Patch "x86_64: increase stack size for KASAN_EXTRA" has been
 added to the 4.20-stable tree
Message-ID: <20190221114604.GE10737@kroah.com>
References: <20190221054324.DDCE9214AF@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221054324.DDCE9214AF@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:43:23AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     x86_64: increase stack size for KASAN_EXTRA
> 
> to the 4.20-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86_64-increase-stack-size-for-kasan_extra.patch
> and it can be found in the queue-4.20 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 67fd2fd35761d6bb8dcebe5070960c2f0baaef69
> Author: Qian Cai <cai@lca.pw>
> Date:   Fri Feb 1 14:20:20 2019 -0800
> 
>     x86_64: increase stack size for KASAN_EXTRA
>     
>     [ Upstream commit a8e911d13540487942d53137c156bd7707f66e5d ]
>     
>     If the kernel is configured with KASAN_EXTRA, the stack size is
>     increasted significantly because this option sets "-fstack-reuse" to
>     "none" in GCC [1].  As a result, it triggers stack overrun quite often
>     with 32k stack size compiled using GCC 8.  For example, this reproducer
>     
>       https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise06.c
>     
>     triggers a "corrupted stack end detected inside scheduler" very reliably
>     with CONFIG_SCHED_STACK_END_CHECK enabled.
>     
>     There are just too many functions that could have a large stack with
>     KASAN_EXTRA due to large local variables that have been called over and
>     over again without being able to reuse the stacks.  Some noticiable ones
>     are
>     
>       size
>       7648 shrink_page_list
>       3584 xfs_rmap_convert
>       3312 migrate_page_move_mapping
>       3312 dev_ethtool
>       3200 migrate_misplaced_transhuge_page
>       3168 copy_process
>     
>     There are other 49 functions are over 2k in size while compiling kernel
>     with "-Wframe-larger-than=" even with a related minimal config on this
>     machine.  Hence, it is too much work to change Makefiles for each object
>     to compile without "-fsanitize-address-use-after-scope" individually.
>     
>     [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23
>     
>     Although there is a patch in GCC 9 to help the situation, GCC 9 probably
>     won't be released in a few months and then it probably take another
>     6-month to 1-year for all major distros to include it as a default.
>     Hence, the stack usage with KASAN_EXTRA can be revisited again in 2020
>     when GCC 9 is everywhere.  Until then, this patch will help users avoid
>     stack overrun.
>     
>     This has already been fixed for arm64 for the same reason via
>     6e8830674ea ("arm64: kasan: Increase stack size for KASAN_EXTRA").
>     
>     Link: http://lkml.kernel.org/r/20190109215209.2903-1-cai@lca.pw
>     Signed-off-by: Qian Cai <cai@lca.pw>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Borislav Petkov <bp@alien8.de>
>     Cc: "H. Peter Anvin" <hpa@zytor.com>
>     Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>     Cc: Alexander Potapenko <glider@google.com>
>     Cc: Dmitry Vyukov <dvyukov@google.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index 8f657286d599a..0ce558a8150d3 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -7,7 +7,11 @@
>  #endif
>  
>  #ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_EXTRA
> +#define KASAN_STACK_ORDER 2
> +#else
>  #define KASAN_STACK_ORDER 1
> +#endif
>  #else
>  #define KASAN_STACK_ORDER 0
>  #endif

This looks like it is also relevant for 4.19.y so I have queued it up
there too.

greg k-h
