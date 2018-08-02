Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE253C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D8E214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZXfxPdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D8E214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeHBSjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:39:04 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40950 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729899AbeHBSjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:39:04 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so3023932qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+1bFVqIigL6grvEE8uzmbx1Pl0c61nyJ7OmWMT7LtzE=;
        b=GZXfxPdd1AwjvbC3MUZTtcSkyfwXWYoMEOYOMcmqlKYW0MSMmRBtynoT5c79bz5bIx
         nHxxT1aH7WFiCnlLqZeDyUsixMscBgG0LSjQDl1QJTVQtauRg0jwY5AJCPfOEhh/IJya
         1VaIRHF8EvRihNY8fh6P0h3ePGoTjwwtZkrJLCpVVhTNLXTK2Lk0OZKgPkm6SckRMBFb
         E1xpGxZIXgIVUweSToc8u/zP7FTwlDYTMT5eAqeynyApms2qEtPu9ukIiJFD1KmarZsF
         SwHsggc3hl39aK29rNCJ8jU1TsV4HgX13sPt1Ej4m7bkrj4FLDLy26/dhtVUNx6ZJKJn
         EX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+1bFVqIigL6grvEE8uzmbx1Pl0c61nyJ7OmWMT7LtzE=;
        b=G/8GNhzMzwsbQOGNS6SnNuGwU8fhj7rJjg2mUvHUcyVA+aQPRoaFuSQClc3yWC+KnY
         oAvzOhYdhN9ligsu4/HSE/3GCgoBBncFL5n234q5FQ34p5G+jXe6QDBZM/HWwATrHOTD
         ryYiQ/tTQTnxZ+BqlrrIfG+DQz5by2khbEu0lG/t+druGM9DCA+Y3cszx6i+tTW1Gx1x
         0rPkOVr1cQBlusdK86S9fGZgJxhL7CZEeAcnc3/RvlxFDRkuNfKdu8C2DHApRyNW7F5P
         yPuBT3ePFTPZFIeAN5lR13ZMDJQguox8htdzPKrZMMFpHKnaURdX8oDiFvoAzGbDlQkA
         0OvA==
X-Gm-Message-State: AOUpUlHxg29giV9RZpEznun44aQpAtAE8QCxVLghdMvcKWtU8u7f10hT
        UCCYrRQ3m/97LAWUCLrm0Gq2GJZn9AE5+4MvDZc=
X-Google-Smtp-Source: AAOMgpcDxhOXjHRnElEgHUTtIKL3KxZ15eQWHAZAntoBwRoiSGEza8ssxir3c7exRPLj5GE3yQtCMSvUu9Hx3zr9uzw=
X-Received: by 2002:aed:2418:: with SMTP id r24-v6mr223848qtc.407.1533228427592;
 Thu, 02 Aug 2018 09:47:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2a83:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 09:47:06 -0700 (PDT)
In-Reply-To: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
References: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 2 Aug 2018 09:47:06 -0700
Message-ID: <CAHbLzkpBnNN4RBMHXzy09x1PZw4m5D99jANmjD=0GT=1tkxniQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to do_shrink_slab()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, mhocko@suse.com,
        aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@i-love.sakura.ne.jp, willy@infradead.org,
        Shakeel Butt <shakeelb@google.com>, jbacik@fb.com,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 4:00 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> In case of shrink_slab_memcg() we do not zero nid, when shrinker
> is not numa-aware. This is not a real problem, since currently
> all memcg-aware shrinkers are numa-aware too (we have two:

Actually, this is not true. huge_zero_page_shrinker is NOT numa-aware.
deferred_split_shrinker is numa-aware.

Thanks,
Yang


> super_block shrinker and workingset shrinker), but something may
> change in the future.
>
> (Andrew, this may be merged to mm-iterate-only-over-charged-shrinkers-during-memcg-shrink_slab)
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/vmscan.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ea0a46166e8e..0d980e801b8a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -455,6 +455,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>                                           : SHRINK_BATCH;
>         long scanned = 0, next_deferred;
>
> +       if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +               nid = 0;
> +
>         freeable = shrinker->count_objects(shrinker, shrinkctl);
>         if (freeable == 0 || freeable == SHRINK_EMPTY)
>                 return freeable;
> @@ -680,9 +683,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>                         .memcg = memcg,
>                 };
>
> -               if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> -                       sc.nid = 0;
> -
>                 ret = do_shrink_slab(&sc, shrinker, priority);
>                 if (ret == SHRINK_EMPTY)
>                         ret = 0;
>
