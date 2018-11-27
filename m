Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F2DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E462120817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQc3jIBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E462120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeK1BkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:40:03 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35697 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeK1BkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:40:03 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so8689432itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCHEkNC4dGIlSYb1h4I+F3i1uCKg+uB889KyiF59RLE=;
        b=WQc3jIBBdoMaWkwihJNqnVO1yD/XUST5VaJDK5lU5eW6l+2qcSXSn3xnK1utkD997F
         LVeHgIEXFZ6pF5OD7lp4pZMxnTQFx4GQ9zVjTULM5mz1adXbNBLFYw0TzeX0tHL7T/B+
         x4274+ytl7O3LrkwiEndpJC/3XR0X+TYC6ijk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCHEkNC4dGIlSYb1h4I+F3i1uCKg+uB889KyiF59RLE=;
        b=gExJMCTbr5gcGNF0pbyzv3mkyf2Ll0kh44kv9sN8jeiNzlce2srKLu00yNnROVSVxn
         bi1pqmZ3YOFINJGdzdPbFcizF3nCtc7H0bRdOrS7qr9ynVVUdh3H4klnJoQzG4z4Age5
         ysAEAKPC+c44lqasbsFmOZNSvRq6k98ZcVDK4huQidXG0andORXVw1mlQIGPxFh6vHnk
         RH00GGzCpPpMT0sx2E3DpGuscir4eLEopntMy4EEj/OWlUVbNgD5ZuJAroMZG0UpJ1SL
         yWFvjnAxURgXZ28dPZ5yGUc0mg4EnX9EpDKOZ2VPWgRQ9ulDAUXIY3mbE2LT4MiNqRXD
         QN/A==
X-Gm-Message-State: AGRZ1gKz16m8jGisFe3BMqCYQUxJx8n09Gh3GrjVUtIdHYjBAYLyt5yf
        MFOCyASTYxGrrEu6GzI15ztCLPnAEw29B7hvQSdcZg==
X-Google-Smtp-Source: AFSGD/VXPwDq17l2ybd7YJUGgQea48fhOFavzLb/VmKZVM42eif9d1E2DWSt909AqL4P8Dv5HOgzPdFYEF6r6yAsTI0=
X-Received: by 2002:a02:a1dc:: with SMTP id o28mr29618940jah.20.1543329713967;
 Tue, 27 Nov 2018 06:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20181127110110.5533-1-andrea.parri@amarulasolutions.com>
In-Reply-To: <20181127110110.5533-1-andrea.parri@amarulasolutions.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Nov 2018 15:41:42 +0100
Message-ID: <CAKfTPtBQx64Ovc9_khCi33YFTuXG=ekzU=XOB5Fz2oXHt_cCHA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Clean up comment in nohz_idle_balance()
To:     andrea.parri@amarulasolutions.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 at 12:01, Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> Concerning the comment associated to the atomic_fetch_andnot() in
> nohz_idle_balance(), Vincent explains [1]:
>
>   "[...] the comment is useless and can be removed [...]  it was
>    referring to a line code above the comment that was present in
>    a previous iteration of the patchset. This line disappeared in
>    final version but the comment has stayed."
>
> So remove the comment.
>
> Vincent also points out that the full ordering associated to the
> atomic_fetch_andnot() primitive could be relaxed, but this patch
> insists on the current more conservative/fully ordered solution:
>
> "Performance" isn't a concern, stay away from "correctness"/subtle
> relaxed (re)ordering if possible..., just make sure not to confuse
> the next reader with misleading/out-of-date comments.
>
> [1] http://lkml.kernel.org/r/CAKfTPtBjA-oCBRkO6__npQwL3+HLjzk7riCcPU1R7YdO-EpuZg@mail.gmail.com
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Looks good to me

> ---
>  kernel/sched/fair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ac855b2f47746..db514993565b2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9533,9 +9533,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>                 return false;
>         }
>
> -       /*
> -        * barrier, pairs with nohz_balance_enter_idle(), ensures ...
> -        */
> +       /* could be _relaxed() */
>         flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
>         if (!(flags & NOHZ_KICK_MASK))
>                 return false;
> --
> 2.17.1
>
