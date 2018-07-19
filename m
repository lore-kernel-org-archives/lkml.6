Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E1DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306A220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apdEpXc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306A220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeGSQz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:55:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55729 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbeGSQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:55:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so6784805wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxcq7V7YY1KojCBc91j6YRIDuQ5vl3QYk8lS9naGGfA=;
        b=apdEpXc1HWd2acc3UwzM+Y1Us90wD1b8rZMy71pw/Eee4thsMI4o1UC7plZ1y1zFjj
         0PVJBYXCz3npFvURrGVla+fMaobC/whB9So7VC7C4otp4GuOia+/YgmQ7ayH1lILWToy
         MVIfqE3anJvHSnJx/hDX+gAptzZwS0C4E6wu5kohmsrXlW4gq+ZjI4w9f/pfOxZ/kFlp
         hyUU9cvr04qrGslb26MuE9dBnNCU6igGuYS4VMrdlfUwGXwn++ND8v+2+A6IU6HA/nZa
         J3IadiuZhxd0md3LteyjX9bX2B0tcjHLQ19gLjfFDHs5D/7FO5/Gl3HYXHLHKnYQ673R
         zNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxcq7V7YY1KojCBc91j6YRIDuQ5vl3QYk8lS9naGGfA=;
        b=ISYdlKHFntbgBPMh+znLc+V+Z/bzGZJ4PcfDTuVBWThpX0cxiBa0Qv7AZSY7x/xQk4
         CjFZ7uayRxAhCu1jN70IC87G+9EBSyK+TF899HXcSfY5ZI95x1DpjSlrP8CXroJ/m+lv
         aEf4AF1OsNlRsAfE5iVYcz7ysvTycUBGbMr3dvnHZtsGu+JW1gyzB8y++vzXtecHiJW9
         dP5eMwWzuw/qoUtdZCwTsA96XG1g44JEh3FaUR+ZyFdmas1AhAU08khVmKbDe4YZSBqN
         IDTc0tgdtgJMnaz4ICO1T7Rf5iwO0kNWtWtaq2siR+c2bMkTRU58Y1AgQZrb6z7LvLHh
         wAZw==
X-Gm-Message-State: AOUpUlFs9v+WP6rLYjbUkgd0jBY9uZVqdRvF5gWVthhBCHPCxk4wO3hR
        oFY4UONiVoKwE+4QJOKT/j0TQtU1yKxUb5l76X2cxA==
X-Google-Smtp-Source: AAOMgpcnYqAJe5ky7yiRNqzCneLvhDWXOThTEPorzU68Eo3IFg+b4eoeuBCw/JsZ/EVaeFUsqI4qH2wYkj0ms0yXF0E=
X-Received: by 2002:a1c:91c7:: with SMTP id t190-v6mr4855133wmd.2.1532016694624;
 Thu, 19 Jul 2018 09:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <153201627722.12295.11034132843390627757.stgit@localhost.localdomain>
In-Reply-To: <153201627722.12295.11034132843390627757.stgit@localhost.localdomain>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Jul 2018 09:11:22 -0700
Message-ID: <CALvZod6iCE8W51m2N704GQ_ML==J76SU6e9w7RCFE2+Vd+Vjaw@mail.gmail.com>
Subject: Re: [PATCH] mm: Cleanup in do_shrink_slab()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 9:04 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Group long variables together to minimize number of occupied lines
> and place all definitions in back Christmas tree order. Also,
> simplify expression around batch_size: use all power of C language!
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/vmscan.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9918bfc1d2f9..636657213b9b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -445,16 +445,11 @@ EXPORT_SYMBOL(unregister_shrinker);
>  static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>                                     struct shrinker *shrinker, int priority)
>  {
> -       unsigned long freed = 0;
> +       long total_scan, freeable, nr, new_nr, next_deferred, scanned = 0;
> +       long batch_size = shrinker->batch ? : SHRINK_BATCH;
>         unsigned long long delta;
> -       long total_scan;
> -       long freeable;
> -       long nr;
> -       long new_nr;
>         int nid = shrinkctl->nid;
> -       long batch_size = shrinker->batch ? shrinker->batch
> -                                         : SHRINK_BATCH;
> -       long scanned = 0, next_deferred;
> +       unsigned long freed = 0;
>
>         freeable = shrinker->count_objects(shrinker, shrinkctl);
>         if (freeable == 0 || freeable == SHRINK_EMPTY)
>
