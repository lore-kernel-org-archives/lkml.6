Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EE3C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11FC2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdOTKJhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11FC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933421AbeFTUwX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:52:23 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32784 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933148AbeFTUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:52:21 -0400
Received: by mail-vk0-f65.google.com with SMTP id 200-v6so579850vkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlXge46430iukgqKS4pPaVn3DWGtgUBIHdkMGNpVwTk=;
        b=SdOTKJhWfgjc3YWAPbuVg8CETQFOWoEQiwgHj07wEFxWG6uMxkdHbsTzVtiTnn+3yf
         RUSb+o8xgDzJ5WoleiZJw4UtomK+bDBK/WZaxGaWH8FI5BlCgtxQPdR+7UFuR55JR8cW
         SY24s/XWLV/CYhGCl+GqDr09wUWXsI7BJXXA/cuFQL1MmqYulSiKAzPMpSH9BZtFGlho
         McIBTtrae8RsF2EHf+XXLQ6YcL232fQnovX9srzIgd+hiBEJPCwXIKjaFd5teMgulQmJ
         awcsEUSCNFm5M1HG9NkUiiNnscJYxV56IBg8x0FsJxdaJhBIKz2xQ+bPCgsU9H/lYoH5
         UVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlXge46430iukgqKS4pPaVn3DWGtgUBIHdkMGNpVwTk=;
        b=TCxhKReCkwsLaGgKlXERHa/FXDp98/mmacBYxWFnXE2zMOIuvdHGVmPdyVfVjh7Qe4
         MLNRJQYa3kAGfEsvDVYfY0eL7GG6Mo4DKgVGHMI6yPZ4VzUXnfKBUNJ4jN0gIqu08c6h
         pzUKKbUwVdNmQt1T5ViZNAC9T9Jat0nqnua9HNzPS0NYD3uxRSmSwror696UDXStABPo
         tsr7wGvQdEhOs3MO83bfBPKdRNaNw0rSfcvXhWETV56YBJU118JYkLDquMuiEohZw+hj
         QkgEpOcz8xQx+TsxmSz9mGB6XYvDuv8LziDIWQ0F5jLeQjcdEWVh44ncftrdSVZme/VX
         P+Vg==
X-Gm-Message-State: APt69E1i6bxiaR3A96CFxw5zzKtNTumu2KY4UwhQqPx0O0WOiy8mJezO
        EVQcy+xvfleWvqap8W/4tbaOHEGeJMclBrfxwBMOSMMs
X-Google-Smtp-Source: ADUXVKIxu1vsJA0aAvnoFdM/if5CTK8AmRcgFQz07gMnwz3qMKg/NJlSV534A/fhncJTOVb/vTLUwZEvA9xyt+CQGOk=
X-Received: by 2002:a1f:7c4:: with SMTP id 187-v6mr13183660vkh.60.1529527940555;
 Wed, 20 Jun 2018 13:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180529025722.GA25784@bombadil.infradead.org> <20180530061212.84915-1-gthelen@google.com>
In-Reply-To: <20180530061212.84915-1-gthelen@google.com>
From:   Greg Thelen <gthelen@google.com>
Date:   Wed, 20 Jun 2018 13:52:08 -0700
Message-ID: <CAHH2K0Z-rgqZU3wqZ2kuHKyZ4tmZK8RgTK-Keg0E-U+i4gDeqA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: condense scan_control
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, willy@infradead.org
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:12 PM Greg Thelen <gthelen@google.com> wrote:
>
> Use smaller scan_control fields for order, priority, and reclaim_idx.
> Convert fields from int => s8.  All easily fit within a byte:
> * allocation order range: 0..MAX_ORDER(64?)
> * priority range:         0..12(DEF_PRIORITY)
> * reclaim_idx range:      0..6(__MAX_NR_ZONES)
>
> Since commit 6538b8ea886e ("x86_64: expand kernel stack to 16K") x86_64
> stack overflows are not an issue.  But it's inefficient to use ints.
>
> Use s8 (signed byte) rather than u8 to allow for loops like:
>         do {
>                 ...
>         } while (--sc.priority >= 0);
>
> Add BUILD_BUG_ON to verify that s8 is capable of storing max values.
>
> This reduces sizeof(struct scan_control):
> * 96 => 80 bytes (x86_64)
> * 68 => 56 bytes (i386)
>
> scan_control structure field order is changed to utilize padding.
> After this patch there is 1 bit of scan_control padding.
>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>

Is there any interest in this?  Less stack usage could mean less
dcache and dtlb pressure.  But I understand if the complexity is
distasteful.

> ---
>  mm/vmscan.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9b697323a88c..42731faea306 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -65,12 +65,6 @@ struct scan_control {
>         /* How many pages shrink_list() should reclaim */
>         unsigned long nr_to_reclaim;
>
> -       /* This context's GFP mask */
> -       gfp_t gfp_mask;
> -
> -       /* Allocation order */
> -       int order;
> -
>         /*
>          * Nodemask of nodes allowed by the caller. If NULL, all nodes
>          * are scanned.
> @@ -83,12 +77,6 @@ struct scan_control {
>          */
>         struct mem_cgroup *target_mem_cgroup;
>
> -       /* Scan (total_size >> priority) pages at once */
> -       int priority;
> -
> -       /* The highest zone to isolate pages for reclaim from */
> -       enum zone_type reclaim_idx;
> -
>         /* Writepage batching in laptop mode; RECLAIM_WRITE */
>         unsigned int may_writepage:1;
>
> @@ -111,6 +99,18 @@ struct scan_control {
>         /* One of the zones is ready for compaction */
>         unsigned int compaction_ready:1;
>
> +       /* Allocation order */
> +       s8 order;
> +
> +       /* Scan (total_size >> priority) pages at once */
> +       s8 priority;
> +
> +       /* The highest zone to isolate pages for reclaim from */
> +       s8 reclaim_idx;
> +
> +       /* This context's GFP mask */
> +       gfp_t gfp_mask;
> +
>         /* Incremented by the number of inactive pages that were scanned */
>         unsigned long nr_scanned;
>
> @@ -3047,6 +3047,14 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>                 .may_swap = 1,
>         };
>
> +       /*
> +        * scan_control uses s8 fields for order, priority, and reclaim_idx.
> +        * Confirm they are large enough for max values.
> +        */
> +       BUILD_BUG_ON(MAX_ORDER > S8_MAX);
> +       BUILD_BUG_ON(DEF_PRIORITY > S8_MAX);
> +       BUILD_BUG_ON(MAX_NR_ZONES > S8_MAX);
> +
>         /*
>          * Do not enter reclaim if fatal signal was delivered while throttled.
>          * 1 is returned so that the page allocator does not OOM kill at this
> --
> 2.17.0.921.gf22659ad46-goog
>
