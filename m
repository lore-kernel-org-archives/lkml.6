Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67C3C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F792159E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQQLURoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F792159E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933729AbeFUWEe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:04:34 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44290 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeFUWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:04:33 -0400
Received: by mail-io0-f196.google.com with SMTP id g7-v6so4371838ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qS+L+Pmrk7E8nM0PoXBjuMzhDF9IDdHSiGNEcjugLeM=;
        b=ZQQLURocXq7ZcoAnzOJr4h+EomAZiWIGMGMRGvg8bqVAW00AphSZux4HByNhoO/Wtv
         f7irY0Yd2QZvcQ0LHnsFp6Qu1hdH6lujohI43rcd0CncPbSRS6OBHDf992DulZFe5VXE
         /qxa0kwfB/N4IZhGAHqjZMjQ9oj15uFAp51243NJk7Mr/3MYl+h4XcFqCNXIsIDVxfn0
         pnGGmRldY/ebF5jlzSMDzjAHNmT8GJnLSPsqcZS9+cA/xqBNVH6L/RLuIM5+aZFG9k1E
         e2Ye7azGFaGfSwNMjxajtEWJ3/aU5NwWKSLydGPA6zgC6FH9/l+b6LSIh+uRlYgljJ42
         OCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qS+L+Pmrk7E8nM0PoXBjuMzhDF9IDdHSiGNEcjugLeM=;
        b=eoA/bn6RDp0AqRZ2oEnQHS3WOHjX5Tx+S01beh+4k2agLHXxmoNYv+HUXfZ2NSVXWu
         yrlG1KhVQAoTl+ly0G99hu6nwuPOEPRd86wqnhaNlPMHZiH5pg+RhHHYfMvOw636IcXF
         pE80p03vTsTOng/Vyjqz/8fCxXhphsdA75f3Uqa2q9r5Etxk476GZ0OBsww1vuSCgng8
         SOQk8QlgmjmwRyAgze14J8mW8wOO2lN3JTWAiozSQY8TIp1KNi4Wu/qX746E7XZYQSA/
         jJtw3hKupRs0frOOmqQVyNd8Zlh3Jx08O3iFQOjNqd7EhHc4mLs19u63HcGh89YKNgXr
         o8uA==
X-Gm-Message-State: APt69E0UsGM65obLtMzg1mnFPazYvJuOFHnxMZwZ32/prijl5FOSN6dy
        6hmt/N8/z1HyPxGUjntTJ+sucseOXotDpThRUowlFw==
X-Google-Smtp-Source: ADUXVKKmE0rRa3QlJ9gkqOSRrI7ezp1w8jN/gJRL2jx+LlTI+v19IZUXa9h4syor3SUUw/vUZPB2SgC/20/zevemXdc=
X-Received: by 2002:a6b:a7cc:: with SMTP id q195-v6mr21726652ioe.130.1529618672253;
 Thu, 21 Jun 2018 15:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180618150933.1130612-1-arnd@arndb.de>
In-Reply-To: <20180618150933.1130612-1-arnd@arndb.de>
From:   Alistair Strachan <astrachan@google.com>
Date:   Thu, 21 Jun 2018 15:04:21 -0700
Message-ID: <CANDihLEgjnHX1F=JeuWjXvBDdQjw-JTr5+QoyPOJ5Jf1Q_zHTQ@mail.gmail.com>
Subject: Re: [PATCH] staging: android/vsoc: stop using 'timespec'
To:     arnd@arndb.de
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, y2038@lists.linaro.org,
        riandrews@android.com, natechancellor@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 8:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The timespec structure suffers from the y2038 overflow and should not
> be used. This changes handle_vsoc_cond_wait() to use ktime_t directly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Alistair Strachan <astrachan@google.com>

> ---
>  drivers/staging/android/vsoc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
> index 806beda1040b..22571abcaa4e 100644
> --- a/drivers/staging/android/vsoc.c
> +++ b/drivers/staging/android/vsoc.c
> @@ -405,7 +405,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
>         int ret = 0;
>         struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
>         atomic_t *address = NULL;
> -       struct timespec ts;
> +       ktime_t wake_time;
>
>         /* Ensure that the offset is aligned */
>         if (arg->offset & (sizeof(uint32_t) - 1))
> @@ -433,14 +433,13 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
>                  * We do things this way to flatten differences between 32 bit
>                  * and 64 bit timespecs.
>                  */
> -               ts.tv_sec = arg->wake_time_sec;
> -               ts.tv_nsec = arg->wake_time_nsec;
> -
> -               if (!timespec_valid(&ts))
> +               if (arg->wake_time_nsec >= NSEC_PER_SEC)
>                         return -EINVAL;
> +               wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
> +
>                 hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
>                                       HRTIMER_MODE_ABS);
> -               hrtimer_set_expires_range_ns(&to->timer, timespec_to_ktime(ts),
> +               hrtimer_set_expires_range_ns(&to->timer, wake_time,
>                                              current->timer_slack_ns);
>
>                 hrtimer_init_sleeper(to, current);
> --
> 2.9.0
>
