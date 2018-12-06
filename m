Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BEFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19F02082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XTtPrMlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19F02082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeLFDzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:55:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39441 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFDzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:55:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so11118787pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/26HEVhE+J+82pWZ7x19Z7icV4rhpe/6yS1XvIqAl/g=;
        b=XTtPrMlvj34TYyeHD4apGaDxS4j8VCaMnYudgMgAOq/Nh4wmWtGtTm43oX4g+mXbuC
         wnjku3bbm8hYKjW3Ui6q1lMEHQwh1CxhhV51nB5PxWyv4qUW9m89k67l6I6qp9X0hiG9
         9t0OIqqrz+ND8W1M/oDUUpb7ne16FhukVW4mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/26HEVhE+J+82pWZ7x19Z7icV4rhpe/6yS1XvIqAl/g=;
        b=B9QUB81YrkOtXnj4KZaMmmvbl9NJk+sHrK/IxLLmEReObp9qWW3qj4DGnsu90z8e6g
         BXr+KyY6gfwb0jerxke/U4hwj4mA/oE7C5XuGfkxyF5NeY15puJJ57E4e3DE0xn3svIY
         9ZQCW9K2rBGFShw+BlmXZ6vPmPoTCUbOIPmRIFt0lrzdhV1GB16gjb37DXEnUjYfgZ/l
         U9lV9pUKTwbszH/TUNUDb4Xy/9ZO9KiIL7gnePMyqNYJBqEjRvkmyxaxOtuJWmIzfQTl
         +mcLT/9Gk26MOVzUK6AEFRpRcckBwR2nw0rV/sbYSAJMzhupoLAsriv1O6zFjQfZZmej
         59ug==
X-Gm-Message-State: AA+aEWaR4CRga4okjHWDz9mIxmwD4EbCbSd5KQN9E9/7QsTCN/DKV4kC
        116YJjkR4WC8Hg7YmhpX/botBK5MfQofwAaqFYlSUTaahZE=
X-Google-Smtp-Source: AFSGD/X6feTi0oBIYKRbmtrlSmZt0x99qbfhXvTSXBWS981v7ywDlI2fwclyKRthJcUxT5iN+BRxNiSl6gaAHsgwQGM=
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr25684109pln.224.1544068513939;
 Wed, 05 Dec 2018 19:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org> <20181205072528.l7blg6y24ggblh4m@master>
 <CANMq1KCi-k_4-66pMfvByzsjpf1H6_bvC82Ow0b_jEH6B3LHwA@mail.gmail.com>
 <20181205121807.evmslrimsv4pdtza@master> <CANMq1KD3vPpd1-=JpcOGRUyt97V+9+zJ9Yf-Qw5CZCPJBqNyHA@mail.gmail.com>
 <20181206033257.mmgh6efejee2i2ae@master>
In-Reply-To: <20181206033257.mmgh6efejee2i2ae@master>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 6 Dec 2018 11:55:02 +0800
Message-ID: <CANMq1KBdV94xGBARLJFke2ke+5aiFtCJe+OMys3+L5NggyxvKA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
To:     richard.weiyang@gmail.com
Cc:     Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@suse.com>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        David Rientjes <rientjes@google.com>,
        yingjoe.chen@mediatek.com, Vlastimil Babka <vbabka@suse.cz>,
        Tomasz Figa <tfiga@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:32 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Thu, Dec 06, 2018 at 08:41:36AM +0800, Nicolas Boichat wrote:
> >On Wed, Dec 5, 2018 at 8:18 PM Wei Yang <richard.weiyang@gmail.com> wrote:
> >>
> >> On Wed, Dec 05, 2018 at 03:39:51PM +0800, Nicolas Boichat wrote:
> >> >On Wed, Dec 5, 2018 at 3:25 PM Wei Yang <richard.weiyang@gmail.com> wrote:
> >> >>
> >> >> On Wed, Dec 05, 2018 at 01:48:27PM +0800, Nicolas Boichat wrote:
> >> >> >In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
> >> >> >data structures smaller than a page with GFP_DMA32 flag.
> >> >> >
> >> >> >This change makes it possible to create a custom cache in DMA32 zone
> >> >> >using kmem_cache_create, then allocate memory using kmem_cache_alloc.
> >> >> >
> >> >> >We do not create a DMA32 kmalloc cache array, as there are currently
> >> >> >no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
> >> >> >ensures that such calls still fail (as they do before this change).
> >> >> >
> >> >> >Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> >> >> >Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >> >> >---
> >> >> >
> >> >> >Changes since v2:
> >> >> > - Clarified commit message
> >> >> > - Add entry in sysfs-kernel-slab to document the new sysfs file
> >> >> >
> >> >> >(v3 used the page_frag approach)
> >> >> >
> >> >> >Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
> >> >> > include/linux/slab.h                        |  2 ++
> >> >> > mm/internal.h                               |  8 ++++++--
> >> >> > mm/slab.c                                   |  4 +++-
> >> >> > mm/slab.h                                   |  3 ++-
> >> >> > mm/slab_common.c                            |  2 +-
> >> >> > mm/slub.c                                   | 18 +++++++++++++++++-
> >> >> > 7 files changed, 40 insertions(+), 6 deletions(-)
> >> >> >
> >> >> >diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
> >> >> >index 29601d93a1c2ea..d742c6cfdffbe9 100644
> >> >> >--- a/Documentation/ABI/testing/sysfs-kernel-slab
> >> >> >+++ b/Documentation/ABI/testing/sysfs-kernel-slab
> >> >> >@@ -106,6 +106,15 @@ Description:
> >> >> >               are from ZONE_DMA.
> >> >> >               Available when CONFIG_ZONE_DMA is enabled.
> >> >> >
> >> >> >+What:         /sys/kernel/slab/cache/cache_dma32
> >> >> >+Date:         December 2018
> >> >> >+KernelVersion:        4.21
> >> >> >+Contact:      Nicolas Boichat <drinkcat@chromium.org>
> >> >> >+Description:
> >> >> >+              The cache_dma32 file is read-only and specifies whether objects
> >> >> >+              are from ZONE_DMA32.
> >> >> >+              Available when CONFIG_ZONE_DMA32 is enabled.
> >> >> >+
> >> >> > What:         /sys/kernel/slab/cache/cpu_slabs
> >> >> > Date:         May 2007
> >> >> > KernelVersion:        2.6.22
> >> >> >diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> >> >index 11b45f7ae4057c..9449b19c5f107a 100644
> >> >> >--- a/include/linux/slab.h
> >> >> >+++ b/include/linux/slab.h
> >> >> >@@ -32,6 +32,8 @@
> >> >> > #define SLAB_HWCACHE_ALIGN    ((slab_flags_t __force)0x00002000U)
> >> >> > /* Use GFP_DMA memory */
> >> >> > #define SLAB_CACHE_DMA                ((slab_flags_t __force)0x00004000U)
> >> >> >+/* Use GFP_DMA32 memory */
> >> >> >+#define SLAB_CACHE_DMA32      ((slab_flags_t __force)0x00008000U)
> >> >> > /* DEBUG: Store the last owner for bug hunting */
> >> >> > #define SLAB_STORE_USER               ((slab_flags_t __force)0x00010000U)
> >> >> > /* Panic if kmem_cache_create() fails */
> >> >> >diff --git a/mm/internal.h b/mm/internal.h
> >> >> >index a2ee82a0cd44ae..fd244ad716eaf8 100644
> >> >> >--- a/mm/internal.h
> >> >> >+++ b/mm/internal.h
> >> >> >@@ -14,6 +14,7 @@
> >> >> > #include <linux/fs.h>
> >> >> > #include <linux/mm.h>
> >> >> > #include <linux/pagemap.h>
> >> >> >+#include <linux/slab.h>
> >> >> > #include <linux/tracepoint-defs.h>
> >> >> >
> >> >> > /*
> >> >> >@@ -34,9 +35,12 @@
> >> >> > #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
> >> >> >
> >> >> > /* Check for flags that must not be used with a slab allocator */
> >> >> >-static inline gfp_t check_slab_flags(gfp_t flags)
> >> >> >+static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
> >> >> > {
> >> >> >-      gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
> >> >> >+      gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
> >> >> >+
> >> >> >+      if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
> >> >> >+              bug_mask |= __GFP_DMA32;
> >> >>
> >> >> The original version doesn't check CONFIG_ZONE_DMA32.
> >> >>
> >> >> Do we need to add this condition here?
> >> >> Could we just decide the bug_mask based on slab_flags?
> >> >
> >> >We can. The reason I did it this way is that when we don't have
> >> >CONFIG_ZONE_DMA32, the compiler should be able to simplify to:
> >> >
> >> >bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
> >> >if (true || ..) => if (true)
> >> >   bug_mask |= __GFP_DMA32;
> >> >
> >> >Then just
> >> >bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK | __GFP_DMA32;
> >> >
> >> >And since the function is inline, slab_flags would not even need to be
> >> >accessed at all.
> >> >
> >>
> >> Hmm, I get one confusion.
> >>
> >> This means if CONFIG_ZONE_DMA32 is not enabled, bug_mask will always
> >> contains __GFP_DMA32. This will check with cachep->flags.
> >>
> >> If cachep->flags has GFP_DMA32, this always fail?
> >>
> >> Is this possible?
> >
> >Not fully sure to understand the question, but the code is:
> >if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
> >       bug_mask |= __GFP_DMA32;
> >
> >IS_ENABLED(CONFIG_ZONE_DMA32) == true:
> > - (slab_flags & SLAB_CACHE_DMA32) => bug_mask untouched, __GFP_DMA32
> >is allowed.
> > - !(slab_flags & SLAB_CACHE_DMA32) => bug_mask |= __GFP_DMA32;,
> >__GFP_DMA32 triggers warning
> >IS_ENABLED(CONFIG_ZONE_DMA32) == false:
> >  => bug_mask |= __GFP_DMA32;, __GFP_DMA32 triggers warning (as
> >expected, GFP_DMA32 does not make sense if there is no DMA32 zone).
>
> This is the case I am thinking.
>
> The warning is reasonable since there is no DMA32. While the
> kmem_cache_create() user is not easy to change their code.
>
> For example, one writes code and wants to have a kmem_cache with DMA32
> capability, so he writes kmem_cache_create(__GFP_DMA32). The code is
> there and not easy to change. But one distro builder decides to disable
> DMA32. This will leads to all the kmem_cache_create() through warning?

I don't think CONFIG_ZONE_DMA32 can be enabled/disabled by
distro/user? IIUC this is a property of the architecture, some have it
enabled, some don't.

> This behavior is what we expect?
>
> >
> >Does that clarify?
> >
> >>
> >> --
> >> Wei Yang
> >> Help you, Help me
>
> --
> Wei Yang
> Help you, Help me
