Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EEEC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219D923F2F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="F7j6EVq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219D923F2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932752AbeFVIvJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:51:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44268 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeFVIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:51:06 -0400
Received: by mail-io0-f193.google.com with SMTP id g7-v6so5457463ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8IKUr79Zq7Lukafthk176rIiBVVAEkc05QCl8a209js=;
        b=F7j6EVq7cIxtDElWOYB/XvZyjrMIsXcCJbpGdiVYmfPPH/U8xE5gEiYH42GGMknYD5
         py3eM/53fQ+/oO79k8Rk1fcLdE0Wl8DEw0Dk++ruDJm28aXHTOZdcKXU52hG73kg9G/X
         3q12XaCJ4EZ6WUMIxFe+OmDCudWNJn8YZmoZNc4t/mFQQjV4sOM4+lVmALCei6JRwXoS
         pclxzPYmu/HFplfawamRCdsn2uDAMpxXZCRySzQ4HgqDDpxmjGEhBJUXLc5WFMlCzZtZ
         zm8hKO5MUkfIWpvB5j9AFki44Wt68Z2UhcF7gKAamIlPpKwpgXoJMmTWX4OA+5LaXn8y
         DMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8IKUr79Zq7Lukafthk176rIiBVVAEkc05QCl8a209js=;
        b=TzcMCwCISAwKtmyKQz1NIXdUMRFknqZFR/GhRVpAh/Sw7Lrphm9G2OJO6gBsswH5Gk
         nWjVYZ/8u1wYd+r9VvjyKSYFzUexQ6OClRUfaXh0WawkEIx8Em9U8a+eDfmVJcga8OgN
         0EQ6/4LX3L+6x/+1BHOBzelT8ML8MaEBIuXuILniVHTMZILvcAYhyohE4dZEF4AO/f8h
         iG3iH7kF5yJ7J+y84h1WWYznxA8jQJOLtYiX56zx3PdAgVV+ROIRrYb2ncanxk6jfRvr
         I1pZQp7YkqrWk7JkYex/RMzKAIjj2qQWQ7fiT4U4oH6B8gKIU+IQNJ0rKjRqooVeD15G
         ZbuA==
X-Gm-Message-State: APt69E2xqLwEjFb4RYRqnylS248UT/ju0cBO/gLaS+e10obOprL/L4eJ
        hIW/o/+Dr3VM/Nd1BZKgLBYQ3D2ijyWvKiJ7WBx/3Q==
X-Google-Smtp-Source: AAOMgpd2g3SQJUbq0bsnPwEJVISUB9H4MbxhGLyRUhLW8PhV3DF1D5C+y1/ASFahs8mugBY3ZFKWerlLzGWKv1js8O0=
X-Received: by 2002:a6b:8267:: with SMTP id e100-v6mr566945iod.110.1529657466117;
 Fri, 22 Jun 2018 01:51:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:4642:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 01:51:05
 -0700 (PDT)
In-Reply-To: <20180618150933.1130612-1-arnd@arndb.de>
References: <20180618150933.1130612-1-arnd@arndb.de>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 22 Jun 2018 10:51:05 +0200
Message-ID: <CAB0TPYFkeo1qofL79WJntAGYhBnFN=cPE2jYQ6AWd1CyXRu39Q@mail.gmail.com>
Subject: Re: [PATCH] staging: android/vsoc: stop using 'timespec'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, y2038@lists.linaro.org,
        Riley Andrews <riandrews@android.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alistair Strachan <astrachan@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The timespec structure suffers from the y2038 overflow and should not
> be used. This changes handle_vsoc_cond_wait() to use ktime_t directly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Martijn Coenen <maco@android.com>

Thanks!

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
