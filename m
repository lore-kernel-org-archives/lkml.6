Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DDCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BC621B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpScjLrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfBQHaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 02:30:39 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39243 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfBQHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 02:30:39 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so21087156iti.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 23:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB8m/G/yjJJ5tRJEh/5vp8eT+5HSD9oX2DbxFowzUq0=;
        b=IpScjLrTWaIKybjutJv/qZutcf7GeOJ4wdG44uFSpR9ZvywHEiKPM77HVvndjrkPqa
         Bl9H/MDGFJq2Cae4tElfomB5ShsOCpU/bNbT6Z55lGwLniUaIfRaxvfMJz1x+/MgWFVh
         w719tOL26PCZST5CVDi0XSQNlm/gEUyaqVklE/kID5STHsYY0KUX1jJFYGH1asGWZLjc
         8F9K5uDP0xNp1vbZKspRISycpyicihKJGYDe7s6GHKcZ9EZzWDJfw5tkZZNUafvo+CSM
         /t/U8877Bzwnf6blEXtMtZdEUl+ccXuxx/NqoOrosmTaHCVkmtViGlDscK177ap6NOpz
         swHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB8m/G/yjJJ5tRJEh/5vp8eT+5HSD9oX2DbxFowzUq0=;
        b=a4D49iWWABj9FNU1B5rUYxD1yRnHQ9gB1Z3tMvx9WJm0MuyOEYonbtGktFWi3X3Fv3
         Faee0X9hauAFNz95rrPfr5J/AkMFl89zNURcZJwjU0FrbR59Av91ynUN6PxCt+l9CvsR
         hamx1gBsund7lmpHzXiPgqb+qUGGAl9c7EH+DyiE3vnWJS6Kkwsk+QyvLbK9q3sPLz5E
         GL2xpbYbWa9Bb1zj0oPp8LIIASA7N3KxvdjKo+aL4x6dQsWeaJHxtiE8UO+i0Kw75Fk1
         fhkLP21sxgpIWTWCnncsEXdpPNo0Ow8xwp3OpC8ofi7k0usnl6BInw1lRQC5jBAHfBpR
         JWBw==
X-Gm-Message-State: AHQUAuatM2gkErz2GKEUsb43pionEPbhMLi5/jvsaVclomt6nk301BCs
        vig47zUUlklmqzBBxRiQCmyNtlR/y6QEWZUXjpXVzw==
X-Google-Smtp-Source: AHgI3IZz3NiMhZ6+RJejFNWSPS04S4qmtJR0hLYMDQfWhvtgILLIS1ZNbRcZIxb881FrmQ0uevlc9V4wyOpbBWAUrZk=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr9180689ioc.282.1550388637986;
 Sat, 16 Feb 2019 23:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20190217043434.46233-1-cai@lca.pw>
In-Reply-To: <20190217043434.46233-1-cai@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 17 Feb 2019 08:30:25 +0100
Message-ID: <CACT4Y+ZYd0LFLJTwBbPRXpS1SorgPjN6c6woUB+25Vd6GuStsw@mail.gmail.com>
Subject: Re: [PATCH] trace: skip hwasan
To:     Qian Cai <cai@lca.pw>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
>
> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> because there is a burst of too much pointer access, and then KASAN will
> dereference each byte of the shadow address for the tag checking which
> will kill all the CPUs.

Hi Qian,

Could you please elaborate what exactly happens and who/why kills
CPUs? Number of memory accesses should not make any difference.
With hardware support (MTE) it won't be possible to disable
instrumentation (loads and stores check tags themselves), so it would
be useful to keep track of exact reasons we disable instrumentation to
know how to deal with them with hardware support.
It would be useful to keep this info in the comment in the Makefile.

Thanks

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/trace/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c2b2148bb1d2..fdd547a68385 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -28,6 +28,11 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>
> +# Too much pointer access will kill hwasan.
> +ifdef CONFIG_KASAN_SW_TAGS
> +KASAN_SANITIZE := n
> +endif
> +
>  CFLAGS_trace_benchmark.o := -I$(src)
>  CFLAGS_trace_events_filter.o := -I$(src)
>
> --
> 2.17.2 (Apple Git-113)
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190217043434.46233-1-cai%40lca.pw.
> For more options, visit https://groups.google.com/d/optout.
