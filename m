Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77643C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4365A217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOUhQs6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfABVSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:18:34 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39440 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfABVSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:18:34 -0500
Received: by mail-yw1-f66.google.com with SMTP id k188so1981749ywa.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2stP9UFtPAKH3/LwOn4Ye9NZzNGkHMYFwKnAD6NZC3E=;
        b=kOUhQs6h4jhZE8Kh+U6zRjNcWfD5sr/T49F6y9WimfogeFHtF0GGdh8jjyqX03XLx5
         0vTrglcvnn1h0LPCyiKLUyYCRKxsXdgSNb7Nz5U++evrIA3ZT4DLbCC9HOdkk2EbFAwO
         5iHNtjls7Vt3YIzINaVlmiiqcXkHRKv6c5QaEsEoKGHem8qiq9pxW5Q8F2+g9Jd6pf9X
         nk3KaTMcNhObMJ4VflMSeNfzyv6Fet7szZtgXIN7CoO75YBpe+hQObSPe+rdmc/RKsQn
         D3R6Ch3qXRXtadJRfWAn9PNBsceFvyD1vlPXxwpsDdcyErmfNB5fx2pNc8eA8ExBOJfZ
         6G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2stP9UFtPAKH3/LwOn4Ye9NZzNGkHMYFwKnAD6NZC3E=;
        b=VFUUXdDLLOblma0aM9cWWs3xKuHuFBt8NpHMe3g6x7r46zLZ2ury8Ip+YLGPNtntli
         Dx4AAUbMa6R84Qrx30ck0zO5VQW5EypTsnvNoTKJ+ENb49udibK8iA0F6mBlsepy2oKw
         qC6gbv6vQrAArPoQOdLg/DQytjK46j9RgqnGyI5rQzD+/jf2tvDpyVvb0SGKgGqiBKBF
         aFXU1LBvCcCxLkoSWM+EcxE/q3+NakJA3GiG4Cj6S3FBBnOMH+WGgXHzT26r8YflRHYu
         TTTKoBpC1U6LIZQpyxLvtG9KNhTvBH0HM042aAMz93DxPu9sdhsCZDwZquRlo44e3wDy
         HCtA==
X-Gm-Message-State: AA+aEWYJf9DtOttQfKOMsweczjxAz0m0hU5hNkjmAFh/6JKcBZ6KuQOJ
        3myFFQYr8RLftrQJBy9shGtFfb5+ys+MFwnVpZ4PQQ==
X-Google-Smtp-Source: AFSGD/WeHteSWiTWipjnMVwfeXXIYWceoEsVLF5g0YXiF+BcfqAimEQTjK7InaWTmRnpKaLSJ7ubnMApdjUlVoWHi/A=
X-Received: by 2002:a81:c144:: with SMTP id e4mr46830352ywl.409.1546463912552;
 Wed, 02 Jan 2019 13:18:32 -0800 (PST)
MIME-Version: 1.0
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com> <1546459533-36247-2-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1546459533-36247-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 2 Jan 2019 13:18:21 -0800
Message-ID: <CALvZod4yYJ7SNrEnpUFwMmaUaaaLgGFr199nqra41vidCPsB1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: memcontrol: fix the obsolete content about force empty
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 12:07 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> We don't do page cache reparent anymore when offlining memcg, so update
> force empty related content accordingly.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  Documentation/cgroup-v1/memory.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/cgroup-v1/memory.txt b/Documentation/cgroup-v1/memory.txt
> index 3682e99..8e2cb1d 100644
> --- a/Documentation/cgroup-v1/memory.txt
> +++ b/Documentation/cgroup-v1/memory.txt
> @@ -70,7 +70,7 @@ Brief summary of control files.
>   memory.soft_limit_in_bytes     # set/show soft limit of memory usage
>   memory.stat                    # show various statistics
>   memory.use_hierarchy           # set/show hierarchical account enabled
> - memory.force_empty             # trigger forced move charge to parent
> + memory.force_empty             # trigger forced page reclaim
>   memory.pressure_level          # set memory pressure notifications
>   memory.swappiness              # set/show swappiness parameter of vmscan
>                                  (See sysctl's vm.swappiness)
> @@ -459,8 +459,9 @@ About use_hierarchy, see Section 6.
>    the cgroup will be reclaimed and as many pages reclaimed as possible.
>
>    The typical use case for this interface is before calling rmdir().
> -  Because rmdir() moves all pages to parent, some out-of-use page caches can be
> -  moved to the parent. If you want to avoid that, force_empty will be useful.
> +  Though rmdir() offlines memcg, but the memcg may still stay there due to
> +  charged file caches. Some out-of-use page caches may keep charged until
> +  memory pressure happens. If you want to avoid that, force_empty will be useful.
>
>    Also, note that when memory.kmem.limit_in_bytes is set the charges due to
>    kernel pages will still be seen. This is not considered a failure and the
> --
> 1.8.3.1
>
