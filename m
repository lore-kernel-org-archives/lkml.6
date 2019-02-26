Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5652173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgsU7KBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfBZKBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:01:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40830 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfBZKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:01:14 -0500
Received: by mail-io1-f66.google.com with SMTP id p17so10005676iol.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XPdvcN55GXXJYoFeIVELbAxZdGJpfqMfjraXI72SsM=;
        b=PgsU7KBn49k/iGidXQt6/D06CRw9CY7+Gkph7ZPoniGhxNGF+a+HGjyGn1fIHlWgr6
         qC8/WKAUoAu3rSgnVy70ylmoJ2F8BzKMq/1515HXG8MLwa0sNsN8GC3GTFq6tblgUDul
         0BDYY0EZu9jc4P7V+USnJJfV01vFKl32HHbKLbB1F3pkxhgFdN5Lbo9U2nYoTdbuIcDO
         ExZRfo+kwCo4H6zRqcmtmJtiZHxikktxb4DzcOkx6Mdsw+1zvZpmEJ6xObgxKQYAm+n2
         ljeVr50rgaDfMBlbDGlAGKfXMplfa1DdQxm3SdQIiuuZR0dTuzrGXyY7HNpdX6KwxVdg
         uXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XPdvcN55GXXJYoFeIVELbAxZdGJpfqMfjraXI72SsM=;
        b=VNMJJcuXS+guRBa8XTGXC+IsTz5UsAudN4KbZUu4qeteGZFiWOTqLrZPIGPz3NpDxi
         OltsdOKyOcgYogiBI/atKKh0k09gUIh5vLSHw0Zb+T/rCg1fEgscdRD3NuuQchcBVrRq
         5LvPz4ACLPDC9Sbc0pVZakT3TFm36E/aMDs5d6kvNw8FmyvGKV4LJUvzujR9XXC+Cays
         EORUY45sDEoZ88gDFyp4KQnP4MaLxoDuzJHEMru9Gke1Nk3A32nJAigrzVfzxU0pjCHA
         cvKfdkKGEpKZYeQSSR/oKGaw/RrL6GBLP0eJVlcFjUVqw6OCanBtl9qKyG3v6IeC2tj0
         BVvA==
X-Gm-Message-State: AHQUAuYRRMYq4TUkuAhwl3wtRvSEl3OxHQOM8lh/ZtsLaBL1ZjC2hbVR
        S7jHw7Lf/PcqzSbq+4ezmR0gTCVl+8jsT0abvPgH6Q==
X-Google-Smtp-Source: AHgI3IZG+2VWpbo29ruFcBvHlJdxt1cAfyYEX41/rY/CTeno2OFS40Kn7EG2sqI+ONuQetoppyQ8lUPpkQf1z/JgdM8=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr10453242ioc.282.1551175273011;
 Tue, 26 Feb 2019 02:01:13 -0800 (PST)
MIME-Version: 1.0
References: <1551175083-10669-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1551175083-10669-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Feb 2019 11:01:02 +0100
Message-ID: <CACT4Y+aZ17d2R5nauSSHtKBJ0X8QtgPD7ijSv4FRs6G4cg0KjA@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: Use continuously blocked time when reporting.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:58 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since commit a2e514453861dd39 ("kernel/hung_task.c: allow to set checking
> interval separately from timeout") added hung_task_check_interval_secs,
> setting a value different from hung_task_timeout_secs
>
>   echo 0 > /proc/sys/kernel/hung_task_panic
>   echo 120 > /proc/sys/kernel/hung_task_timeout_secs
>   echo 5 > /proc/sys/kernel/hung_task_check_interval_secs
>
> causes confusing output as if the task was blocked for
> hung_task_timeout_secs seconds from the previous report.
>
>   [  399.395930] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  405.027637] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  410.659725] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  416.292860] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  421.932305] INFO: task kswapd0:75 blocked for more than 120 seconds.
>
> Although we could update t->last_switch_time after sched_show_task(t) if
> we want to report only every 120 seconds, reporting every 5 seconds might
> not be very bad for monitoring after a problematic situation has started.
> Thus, let's use continuously blocked time instead of updating previously
> reported time.
>
>   [  677.985011] INFO: task kswapd0:80 blocked for more than 122 seconds.
>   [  693.856126] INFO: task kswapd0:80 blocked for more than 138 seconds.
>   [  709.728075] INFO: task kswapd0:80 blocked for more than 154 seconds.
>   [  725.600018] INFO: task kswapd0:80 blocked for more than 170 seconds.
>   [  741.473133] INFO: task kswapd0:80 blocked for more than 186 seconds.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/hung_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 4a91916..6429139 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -126,7 +126,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>                 if (sysctl_hung_task_warnings > 0)
>                         sysctl_hung_task_warnings--;
>                 pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
> -                       t->comm, t->pid, timeout);
> +                      t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);

Looks like an improvement to me.

Acked-by: Dmitry Vyukov <dvyukov@google.com>



>                 pr_err("      %s %s %.*s\n",
>                         print_tainted(), init_utsname()->release,
>                         (int)strcspn(init_utsname()->version, " "),
> --
> 1.8.3.1
