Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5CB2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdsIfMHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGQ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:28:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44872 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:28:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so306869lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 08:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqcbSbVgDZtdgzYO2knt/tKwP8VpBZkOZlHZOIDOo1c=;
        b=sdsIfMHX6Hcka/qDE5Of4d5cYBnxOvraEFktqyRV/YqTIWmQsIImsZno3PQ3QXvChB
         Ih/lmi/xTQFFrMYlVw+S5XdPaTbtcdmJaI8T0TFfT7FjDEziF0CZBWusxURwBejpR0jo
         m17dh++ITWi1D5YnoDzkhxCwirtKtc6fisRf2hCqOBX+sgVz9neLdgyiHyHI4CQTE13q
         PuM67m2S0tSrsluLr/a5PN8VAlpJogm75t4FDAnhA8rZWD74jixsMvIjJLbLh3g6E3h8
         K6Eit5WubNjI0TfJ2ZFvGFVh5O2GekVAEB39bM78hq6gAe2q7LM58untWC3Km79KRHm5
         2PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqcbSbVgDZtdgzYO2knt/tKwP8VpBZkOZlHZOIDOo1c=;
        b=jDgjy7pb9MNBPerAScwhoBdEaoP0cyn98POHMVaSeQjhxVNelPiWqwxc/G5idp6qb7
         CCeRGhyTPdl/5PwPQ4YAmO2Z2zwY8jwXrSSPD8NKSU6y1nNetfBDS4QvrU1H53FtplU/
         DIjRHwv3WsSp1UAaH+gCB5yeVNwFOZxlyCBmjbSr+FTT/ml9+7M18G2NjM99ypT2bvZT
         NNynda7s+S3A2v61RxQwr1hTntX2Kns0I1vNy3vvrViv+EJsVDuqjJXODjWTzKYdjURx
         48Tzi8QnNBnVw6CDVNeWTT8ekylUUiBmYei+W65XrMcMo9HLiQY/KPQqT777mJdvfbm3
         4GsA==
X-Gm-Message-State: AHQUAuZH+qzsd+NwMyrYZWi7s82L1ThaAYAMV82VIneKTLG6fnHD+xAB
        lXLxiEhebwNW9+e8alSIiepr2Qs8OcsNoAtJBXc=
X-Google-Smtp-Source: AHgI3IacQaPz5X8pueH3UK+eZmUBIcx0wh/8ncR+XUULfqXQ5hVdvW3OYiNZZDwhd/JYuf3FmyVwgiVBSknCrkSOsQE=
X-Received: by 2002:a19:6514:: with SMTP id z20mr10885979lfb.31.1549556896462;
 Thu, 07 Feb 2019 08:28:16 -0800 (PST)
MIME-Version: 1.0
References: <1549455025-17706-1-git-send-email-rppt@linux.ibm.com> <1549455025-17706-2-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1549455025-17706-2-git-send-email-rppt@linux.ibm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 7 Feb 2019 22:02:24 +0530
Message-ID: <CAFqt6zbvYKQS0NO3x9d45ubwf_MdEf67x1=xUHLb+ippCFmeQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] memblock: remove memblock_{set,clear}_region_flags
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 6:01 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> The memblock API provides dedicated helpers to set or clear a flag on a
> memory region, e.g. memblock_{mark,clear}_hotplug().
>
> The memblock_{set,clear}_region_flags() functions are used only by the
> memblock internal function that adjusts the region flags.
> Drop these functions and use open-coded implementation instead.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  include/linux/memblock.h | 12 ------------
>  mm/memblock.c            |  9 ++++++---
>  2 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 71c9e32..32a9a6b 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -317,18 +317,6 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>         for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved, \
>                                nid, flags, p_start, p_end, p_nid)
>
> -static inline void memblock_set_region_flags(struct memblock_region *r,
> -                                            enum memblock_flags flags)
> -{
> -       r->flags |= flags;
> -}
> -
> -static inline void memblock_clear_region_flags(struct memblock_region *r,
> -                                              enum memblock_flags flags)
> -{
> -       r->flags &= ~flags;
> -}
> -
>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>  int memblock_set_node(phys_addr_t base, phys_addr_t size,
>                       struct memblock_type *type, int nid);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 0151a5b..af5fe8e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -851,11 +851,14 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
>         if (ret)
>                 return ret;
>
> -       for (i = start_rgn; i < end_rgn; i++)
> +       for (i = start_rgn; i < end_rgn; i++) {
> +               struct memblock_region *r = &type->regions[i];

Is it fine if we drop this memblock_region *r altogether ?

> +
>                 if (set)
> -                       memblock_set_region_flags(&type->regions[i], flag);
> +                       r->flags |= flag;
>                 else
> -                       memblock_clear_region_flags(&type->regions[i], flag);
> +                       r->flags &= ~flag;
> +       }
>
>         memblock_merge_regions(type);
>         return 0;
> --
> 2.7.4
>
