Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2132DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31C32075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyXqh++T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31C32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeIFP7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:59:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46875 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIFP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:59:24 -0400
Received: by mail-io0-f195.google.com with SMTP id y12-v6so8478502ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mHc1cPtFL78lfojA9PJyr9HDLtVTRheeh6fv+zfPkIs=;
        b=NyXqh++ThDSQBz/skcIrjIEq6Opeb3JAezgxgpZUwJQtYsm365OLJFcLVW7Hriuk5W
         ksOLxhG/HrQjPLClJ3iTeNKkv/jtmCZUABCtGe8i2UbMO1UYpH2v7kMXoQbJTWXCaJgR
         sD8NcqYZbOwwc+rAQTU60QXhjed182F/civb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mHc1cPtFL78lfojA9PJyr9HDLtVTRheeh6fv+zfPkIs=;
        b=V9WHJ7Jh0VIohR6JvNPQ/+J2clGJEN9QFHrWdbWKkF4s5qFw0ON1FjETLbOnQByh8U
         0s5/kTN1IfUMpMtM0wQS1PK1QjUBC4zafNlihI+9ND0/tJe7oEbavnzPb/qrPhECm+0U
         SVZ+3UfN0kkY1pF3+xslE8xEcp8hShH0OzY9c4lk7sIx/IbuchhZXxiPUnvvqjuB+ZcG
         CCEP+Q4T2VPZTDmVl9Wn+IUdFdbIBUiAEPobBkqViBfZPzI1Hj4ErmFv3KRXflceT4I+
         BhkAmtuvrfZlv0beogF3Qa4HeEZVj9Fnqz6+iNdOA3laXYLV26oMd6GNNy6JGlF5dXAo
         7rXA==
X-Gm-Message-State: APzg51AmW8vIqi2/HVEECaZNm8wDe7bxZBDqLEsz4kww4/5hSNyOu4oQ
        2+//tWTd6nUXxcLsGVyW+OUmpyhpZnDW4j7RpZNvsw==
X-Google-Smtp-Source: ANB0VdZoBmwLIk4PnACvGtJEi+ZrxpZeNGtLaBknTy48FK/9f1oAa/xhueWXhKcZJaZzOjWsZZGeAhBHizAVlo2Yk2c=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr1510407ioa.60.1536233063470;
 Thu, 06 Sep 2018 04:24:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 04:24:22 -0700 (PDT)
In-Reply-To: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Sep 2018 13:24:22 +0200
Message-ID: <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
To:     Jia He <hejianet@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jia He <jia.he@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 August 2018 at 05:07, Jia He <hejianet@gmail.com> wrote:
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
>
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>
> More from what Daniel said:
> "On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines."
>
> About the performance consideration:
> As said by James in b92df1de5,
> "I have tested this patch on a virtual model of a Samurai CPU with a
> sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
>
> Besides we can remain memblock_next_valid_pfn, there is still some room
> for improvement. After this set, I can see the time overhead of memmap_init
> is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
> memory, pagesize 64k). I believe arm server will benefit more if memory is
> larger than TBs
>

OK so we can summarize the benefits of this series as follows:
- boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
- boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
*milliseconds*

Google was not very helpful in figuring out what a Samurai CPU is and
why we should care about the boot time of Linux running on a virtual
model of it, and the 15 ms speedup is not that compelling either.

Apologies to Jia that it took 11 revisions to reach this conclusion,
but in /my/ opinion, tweaking the fragile memblock/pfn handling code
for this reason is totally unjustified, and we're better off
disregarding these patches.





> Patch 1 introduces new config to make codes more generic
> Patch 2 remains the memblock_next_valid_pfn on arm and arm64,this patch is
>         originated from b92df1de5
> Patch 3 optimizes the memblock_next_valid_pfn()
>
> Changelog:
> V11:- drop patch#4-6, refine the codes
> V10:- move codes to memblock.c, refine the performance consideration
> V9: - rebase to mmotm master, refine the log description. No major changes
> V8: - introduce new config and move generic code to early_pfn.h
>     - optimize memblock_next_valid_pfn as suggested by Matthew Wilcox
> V7: - fix i386 compilation error. refine the commit description
> V6: - simplify the codes, move arm/arm64 common codes to one file.
>     - refine patches as suggested by Danial Vacek and Ard Biesheuvel
> V5: - further refining as suggested by Danial Vacek. Make codes
>       arm/arm64 more arch specific
> V4: - refine patches as suggested by Danial Vacek and Wei Yang
>     - optimized on arm besides arm64
> V3: - fix 2 issues reported by kbuild test robot
> V2: - rebase to mmotm latest
>     - remain memblock_next_valid_pfn on arm64
>     - refine memblock_search_pfn_regions and pfn_valid_region
>
> Jia He (3):
>   arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
>   mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
>   mm: page_alloc: reduce unnecessary binary search in
>     memblock_next_valid_pfn
>
>  arch/arm/Kconfig       |  1 +
>  arch/arm64/Kconfig     |  1 +
>  include/linux/mmzone.h |  9 +++++++++
>  mm/Kconfig             |  3 +++
>  mm/memblock.c          | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c        |  5 ++++-
>  6 files changed, 69 insertions(+), 1 deletion(-)
>
> --
> 1.8.3.1
>
