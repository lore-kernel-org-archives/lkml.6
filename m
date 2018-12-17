Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A45520874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbeLQMtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:49:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46523 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeLQMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:49:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so13807618qtm.13;
        Mon, 17 Dec 2018 04:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0mNgOOTZlCEFwZrSJTwdxPkTTBF3wOprgww8sMFHjs=;
        b=rLAK1f1u8kRTgz5xqeAGt4jdsHATw347h0UZo/i9aQDiJRtXhr33DZaRyGoA1gkVhL
         rYYwx4ESpMnkT8V3Cm2NhiR55HrmggyGCuieGL+JzVxZyvSnsHvQOIBYDYFPkT4R3rqI
         cP1yZoo1k0S3sW4UeIYjv5te7v5qywlTpF/qIfeLudDVOPI+67tGR+REYwpXO03g6tqn
         eQI787oTpjmGBhr7WMMrsXt/w+/1cOV1MshnF2QujDuaMsUeyJbMd4WtvLp/xD4T5wnd
         zPA9hiedqEdgB09Afw09t2JRMTAmyceoc6f0x/AITKWoOd+GKx91gNSXOcziqx7rHp41
         QSBw==
X-Gm-Message-State: AA+aEWayCoK3duHSpte3ppcBSZ/Z2aIbo4G2OVXAOeSHMJEwsyeQUEFL
        uhWfJdiliQmZgp7aUE9eJQN8xhB9WwTo6JdTzl0=
X-Google-Smtp-Source: AFSGD/UNnxSSdtURIJ4Z8zb/nCbh28vRTbrx68eee50Q6rfSntBiOwU6eG8utPq56zopPFtHgdflzV+lp673ZYrKbPg=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr13098569qvr.115.1545050989901;
 Mon, 17 Dec 2018 04:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20181217201146.170ca9b4@canb.auug.org.au>
In-Reply-To: <20181217201146.170ca9b4@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Dec 2018 13:49:33 +0100
Message-ID: <CAK8P3a3LaRt8Gszbj2QYJhERKS=T3u=fzPTXaELW4a=BJDNnzA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the y2038 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        palcantara@suse.de, Aurelien Aptel <aaptel@suse.com>,
        stfrench@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:11 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I have applied the following merge fix patch (better versions welcome):
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 17 Dec 2018 20:03:28 +1100
> Subject: [PATCH] cifs: update for current_kernel_time64() removal
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

Your patch looks correct, and the conflict should be easy to
resolve by Steve merging this into his tree, as
ktime_get_coarse_real_ts64() is readily available in mainline
kernels.

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  fs/cifs/dfs_cache.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
> index 70f9c9e2175c..d20cc94d7abd 100644
> --- a/fs/cifs/dfs_cache.c
> +++ b/fs/cifs/dfs_cache.c
> @@ -103,7 +103,7 @@ static inline bool cache_entry_expired(const struct dfs_cache_entry *ce)
>  {
>         struct timespec64 ts;
>
> -       ts = current_kernel_time64();
> +       ktime_get_coarse_real_ts64(&ts);
>         return timespec64_compare(&ts, &ce->ce_etime) >= 0;
>  }
>
> @@ -338,8 +338,10 @@ static inline struct timespec64 get_expire_time(int ttl)
>                 .tv_sec = ttl,
>                 .tv_nsec = 0,
>         };
> +       struct timespec64 now;
>
> -       return timespec64_add(current_kernel_time64(), ts);
> +       ktime_get_coarse_real_ts64(&now);
> +       return timespec64_add(now, ts);
>  }

In case efficiency is a concern: using ktime_t with
ktime_get_coarse_real() may be much faster if we decide to
abandon the coarse-grained timespec64 accessors in the future.

Also, I wonder if the expiration here has to use CLOCK_REALTIME,
since that is affected by leap second adjustment and
clock_settime().

In other modules, we usually concluded that it should be either
CLOCK_MONOTONIC or CLOCK_BOOTTIME, depending on whether
you want the expiration timer to keep ticking during suspend.

        Arnd
