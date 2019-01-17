Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B068C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC77F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FW+e53Rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfAQVDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:03:34 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33806 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfAQVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:03:33 -0500
Received: by mail-ua1-f67.google.com with SMTP id c24so3987800uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8lza2fWqMQIISOBA2zwbVAD4ydLvisc2ffqkqc09zk=;
        b=FW+e53Rxb+o7EAR/9OVCbdlHrNYD/aO9WdMscX88Yergx7ix76XQw/CoQZYUFwt40G
         +BLxAXk2YM6kA++OyQx94NbsXthcG4fsfGngDjdlqDefjbIMZoE6gmq8KHPbqWlDE7L3
         3efk4gkISAuxXtLkOfPczoCXPaHdB++MUHFAGeU5UvZKQsEKgvbL6Z9as6cWcr7kOvR+
         KcjtiDqUvAhMOUcW7Px71BJ6z+PWE0WnpmWRY4D7+q5jHl6GYmsBGLBysVXilecr+qc5
         HgWz4z9ruMt0L1OXyf7st0C/9v6UbPggvBbXaACVsPmW5AgWfA5p6NDU8Uw1IVjQzTcr
         BkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8lza2fWqMQIISOBA2zwbVAD4ydLvisc2ffqkqc09zk=;
        b=LE67jP9MKr+3f/InopjgJpjHoMOGYA/2dO7WvAF7cyBjK7IMV9aMpceWcniZi2fOe7
         AYymuQNvqm+UnMA5g+04mbJ4WLnGvNDWrV1BAZ+2hSB8I/p5K7ApNs10BbUNqceJdg+m
         h3u2SQv7FKRialPyzwSLUh9eMt+gknSJk6T152+FGA7rP/hCsvDv/TNqdqOk1Szv+eW4
         wJePzefcSmTCiatFKFzLfdiRwKmK+Sbd8oVCgbMt7SLVyepwwhNrdzExfFalkoBp2o3n
         ea9XoaHZzZg6757E0DYfSfL4CF3UCUknGMwyS0d1B8jVyXOBA6erFEIhG9sLSTvLKK9A
         UAjQ==
X-Gm-Message-State: AJcUukc869GN+7omwcwfFknXa93thBgitGKHfLGwijInQYxpXzuhVFMN
        OtkboKtvWGAu3bDQLL7q2ibgzmfTA9ml62bFCa+Rsf0QURY=
X-Google-Smtp-Source: ALg8bN7FISpgC+WwsH/QMnozZVs4L7eQpqYhQ+TvVOOlsrUb33TJ/obxJpuP9wfPFjxrnhUoENmL+5bZ/NzReuYRgPY=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr5978486uaj.42.1547759011675;
 Thu, 17 Jan 2019 13:03:31 -0800 (PST)
MIME-Version: 1.0
References: <1547169436-6266-1-git-send-email-eranian@google.com>
In-Reply-To: <1547169436-6266-1-git-send-email-eranian@google.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 17 Jan 2019 13:03:20 -0800
Message-ID: <CABPqkBS30_Afu3a1hycMAnB5KaqdFe=JYPoENfZG4ZtUYAE7mQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix perf_proc_update_handler() bug
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 5:17 PM Stephane Eranian <eranian@google.com> wrote:
>
> The perf_proc_update_handler() handles /proc/sys/kernel/perf_event_max_sample_rate
> syctl variable.  When the PMU IRQ handler timing monitoring is disabled, i.e,
> when /proc/sys/kernel/perf_cpu_time_max_percent is equal to 0 or 100,
> then no modification to sysctl_perf_event_sample_rate is allowed to prevent
> possible hang from wrong values.
>
> The problem is that the test to prevent modification is made after the
> sysctl variable is modified in perf_proc_update_handler().
>
> You get an error:
>
> $ echo 10001 >/proc/sys/kernel/perf_event_max_sample_rate
> echo: write error: invalid argument
>
> But the value is still modified causing all sorts of inconsistencies:
>
> $ cat /proc/sys/kernel/perf_event_max_sample_rate
> 10001
>
> This patch fixes the problem by moving the parsing of the value after
> the test.
>
> Signed-off-by: Stephane Eranian <eranian@google.com>

Ping.

> ---
>  kernel/events/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3cd13a30f732..e5ede6918050 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -436,18 +436,18 @@ int perf_proc_update_handler(struct ctl_table *table, int write,
>                 void __user *buffer, size_t *lenp,
>                 loff_t *ppos)
>  {
> -       int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -
> -       if (ret || !write)
> -               return ret;
> -
> +       int ret;
> +       int perf_cpu = sysctl_perf_cpu_time_max_percent;
>         /*
>          * If throttling is disabled don't allow the write:
>          */
> -       if (sysctl_perf_cpu_time_max_percent == 100 ||
> -           sysctl_perf_cpu_time_max_percent == 0)
> +       if (write && (perf_cpu == 100 || perf_cpu == 0))
>                 return -EINVAL;
>
> +       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +       if (ret || !write)
> +               return ret;
> +
>         max_samples_per_tick = DIV_ROUND_UP(sysctl_perf_event_sample_rate, HZ);
>         perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
>         update_perf_cpu_limits();
> --
> 2.7.4
>
