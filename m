Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A799C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A6020657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNAb8pA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbfAKQLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:11:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35298 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfAKQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:11:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so13576735otj.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMw/7p8GH6MULi72EHkpgvgYVnYmk7U4QRbXQ9NgXdI=;
        b=bNAb8pA8axNhFJ0pm4/wd86CQg0z7sikiDO/G7zGcYP2dSV3GDzRbtFbLsXIfdU+a6
         cQaa6UbsXJJ0p1VE03S00ivezX/f031PjillIxF1KS2BuSz4GHoAnQhqlVHSBg3LZ9DV
         ehHScqpSte+5CCrV3yQ4z4lUDmj2KHC6FFXtOwvKzXFbl7Aqr4zSZRVmmFR5e5otacS5
         9M9GznQtVSWb3Y3hXUSibH1OyLkhXd+QcML/qSxQxxwx61PhsiezP2gGup7Kw1aPLxsf
         FHHOIR9nCBnzLFi2B+cQX2GIlW0R8nzyNYup74g+711LsLj6Zoy8cjY1O59/EgfoE6DH
         Ycyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMw/7p8GH6MULi72EHkpgvgYVnYmk7U4QRbXQ9NgXdI=;
        b=blz5QrH3EhIf/7OQ5DMTFKVThO9fHmH68QalkKB1MtYeCg7v+oBiWF/cWjEPTusccS
         DlGLawhxbHyVc/URpkGgvPU50tOUvH8bTceGtcUgbEP/f9aKdAKpdKxxLGloe8JTGMbK
         J8VKCE7hzN8trnQif8SvZYnUNfRrnH3HFP7coHLiZHufv6xjCM+Jbq/pAXYu8qkvL8ij
         Fd0C3iX/tPyRngC/DYAuax4qqI6b3+2xHzX1cTXf48ZMcrazBpJhXAc74vdjJKXHU38s
         EHUs0ZXXKcKtHiqdy39SAyGBKSTNtetKBIcTkolDoVmYvsgNqVbuFvRzqjmbeHUQ9taH
         QV2w==
X-Gm-Message-State: AJcUukf5EufLpMU2gYVGV2DSNVvngIxyVdLZzVO+qVLsYaDNijQv4Z4z
        qNYTaBnGmwc1kLYs4kj285Ss9VIBiKP5uRHDIfE=
X-Google-Smtp-Source: ALg8bN75/eAM+JzIDZfpdGgtqsNOTV8cjt/At9FUVl5Wd9IycYwH8yR6bdl7164QfPfY7eIVjpFP5SlIzPcVdPD1+B4=
X-Received: by 2002:a9d:4682:: with SMTP id z2mr9824342ote.104.1547223069716;
 Fri, 11 Jan 2019 08:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20190111133315.657348322@linutronix.de> <20190111133500.840117406@linutronix.de>
In-Reply-To: <20190111133500.840117406@linutronix.de>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 11 Jan 2019 08:10:33 -0800
Message-ID: <CAMe9rOrKc_i9ugz_EkA7zyQNOOVMfmtcv4=HM8JHFd+ixhprTg@mail.gmail.com>
Subject: Re: [patch 1/2] posix-cpu-timers: Unbreak timer rearming
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 5:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The recent commit which prevented a division by 0 issue in the alarm timer
> code broke posix CPU timers as an unwanted side effect.
>
> The reason is that the common rearm code checks for timer->it_interval
> being 0 now. What went unnoticed is that the posix cpu timer setup does not
> initialize timer->it_interval as it stores the interval in CPU timer
> specific storage. The reason for the separate storage is historical as the
> posix CPU timers always had a 64bit nanoseconds representation internally
> while timer->it_interval is type ktime_t which used to be a modified
> timespec representation on 32bit machines.
>
> Instead of reverting the offending commit and fixing the alarmtimer issue
> in the alarmtimer code, store the interval in timer->it_interval at CPU
> timer setup time so the common code check works. This also repairs the
> existing inconistency of the posix CPU timer code which kept a single shot
> timer armed despite of the interval being 0.
>
> The separate storage can be removed in mainline, but that needs to be a
> separate commit as the current one has to be backported to stable kernels.
>
> Fixes: 0e334db6bb4b ("posix-timers: Fix division by zero bug")
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: John Stultz <john.stultz@linaro.org>
> ---
>  kernel/time/posix-cpu-timers.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -685,6 +685,7 @@ static int posix_cpu_timer_set(struct k_
>          * set up the signal and overrun bookkeeping.
>          */
>         timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
> +       timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
>
>         /*
>          * This acts as a modification timestamp for the timer,
>
>

I verified that this patch works on 4.19.14 kernel.

Thanks.

-- 
H.J.
