Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD381C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA33820831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epNoWEfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA33820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeKUErO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:47:14 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41441 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeKUErO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:47:14 -0500
Received: by mail-ua1-f65.google.com with SMTP id z24so986392ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHomY8G6dFCnUkQv3bzhPnVeoDDrbSVv+Rav3w+pDRo=;
        b=epNoWEfIG3N5FdXQ5FWEkTBFQAZubvZtc3FsPMbcWpLd/hO7ZgmgdYrnQAn8rcwZEw
         Wpma/gNQ6rAWZXu/6Sjw1sVEZ8aVbb4LOZZSSGLNQtoYQas82RO4QJTl0tLBfRFRLNT4
         q9TGF8mvC9ALjdyQ6TT8DbrQAofpa56P+F/Q/mIxOpPCPPqfjC7MISYtzabc4CKl0Fer
         lLhlK5iWxUggu+iP774sin9KnjEGHwoe8VWYYs9F+IGCiVvboXScL4oJEy4TWNiUom0/
         WbxywHA3x+abSvgqllXyN32rtE3Q0o7s7jtMOUyaK0P0zVCDqiNujzThzaXrJNhGB7kp
         6Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHomY8G6dFCnUkQv3bzhPnVeoDDrbSVv+Rav3w+pDRo=;
        b=ewcOoubRZoh3NrVKDlKKSz2/WYHzm6OUsBd2rI+U0qs5BV4Gi7FNPDbiaBkbyX/vNS
         NTaI+zHAefLtEidc8y5Meo0cAzuyOtPPNFjkDUisxZ1c2gI6FGNJ3TU4CEY/pk6eadIX
         HovEjQSlcrGTsGj0ptMxqz9WJH0SO8sy+X58MBPZ8Om0tjg2ZKs8hqN/Z/bli0VwqYyM
         +Dhb80mKDG1C4MjMCCNG6+8wr2IDinZNgU/PjvxeeNf3S3Vz7FWVkoJq1jFTrSo4a/gx
         rwGI9LtenOVNxNy2kyXhvSGBdlNEYKov/C9huaGr6/Rrsaa0a+DznrwR9JCeoGbgzSD6
         owGA==
X-Gm-Message-State: AA+aEWZxcZVcNw80clxx62kKN4tCSEccFVN+wTcNXxskD9Sj10LaFGHf
        /l2OhwLHGRlGGZDRrCQI2VFHJQy0z1tdtRESaOAohQ==
X-Google-Smtp-Source: AFSGD/UbN/FrUIWBBUe4APjxBS4Kx/voZ3bM7pOf9K1f7w1U8ji+54ShtNs7cQb3Ju23ofuDC1VCF43BF4D1OytISgw=
X-Received: by 2002:ab0:1058:: with SMTP id g24mr1366999uab.58.1542737806322;
 Tue, 20 Nov 2018 10:16:46 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120170842.GZ2131@hirez.programming.kicks-ass.net>
In-Reply-To: <20181120170842.GZ2131@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 20 Nov 2018 10:20:44 -0800
Message-ID: <CABPqkBQyvbM0AAJRRQQeBUZOuPHr2qjD+qWe53zJg84kzR3=Ng@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Kyle Huey <me@kylehuey.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, robert@ocallahan.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 9:08 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 20, 2018 at 08:19:39AM -0800, Kyle Huey wrote:
> > tl;dr: rr is currently broken on 4.20rc2, which I bisected to
> > af3bdb991a5cb57c189d34aadbd3aa88995e0d9f. I further confirmed that
> > booting the 4.20rc2 kernel with `disable_counter_freezing=true` allows
> > rr to work.
> >
> > rr, a userspace record and replay debugger[0], uses the PMU interrupt
> > (PMI) to stop a program during replay to inject asynchronous events
> > such as signals. With perf counter freezing enabled we are reliably
> > seeing perf event overcounts during replay. This behavior is easily
> > demonstrated by attempting to record and replay the `alarm` test from
> > rr's test suite. Through bisection I determined that [1] is the first
> > bad commit, and further testing showed that booting the kernel with
> > `disable_counter_freezing=true` fixes rr.
> >
I would like to understand better the PMU behavior you are relying upon and
why the V4 freeze approach is breaking it. Could you elaborate?

> > This behavior has been observed on two different CPUs (a Core i7-6700K
> > and a Xeon E3-1505M v5). We have no reason to believe it is limited to
> > specific CPU models, this information is included only for
> > completeness.
> >
> > Given that we're already at rc3, and that this renders rr unusable,
> > we'd ask that counter freezing be disabled for the 4.20 release.
>
> Andi, can you have a look at this?
>
> Meanwhile, I suppose we should do something along these lines.
>
>
> ---
> Subject: perf/x86/intel: Default disable perfmon v4 interrupt handling
>
> Rework the 'disable_counter_freezing' __setup() parameter such that we
> can explicitly enable/disable it and switch to default disabled.
>
> To this purpose, rename the parameter to "perf_v4_pmi=" which is a much
> better description and allows requiring a bool argument.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 ++-
>  arch/x86/events/intel/core.c                    | 12 ++++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 76c82c01bf5e..ff6d1d4229e0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -856,7 +856,8 @@
>                         causing system reset or hang due to sending
>                         INIT from AP to BSP.
>
> -       disable_counter_freezing [HW]
> +       perf_v4_pmi=    [X86,INTEL]
> +                       Format: <bool>
>                         Disable Intel PMU counter freezing feature.
>                         The feature only exists starting from
>                         Arch Perfmon v4 (Skylake and newer).
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 273c62e81546..af8bea9d4006 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2306,14 +2306,18 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>         return handled;
>  }
>
> -static bool disable_counter_freezing;
> +static bool disable_counter_freezing = true;
>  static int __init intel_perf_counter_freezing_setup(char *s)
>  {
> -       disable_counter_freezing = true;
> -       pr_info("Intel PMU Counter freezing feature disabled\n");
> +       bool res;
> +
> +       if (kstrtobool(s, &res))
> +               return -EINVAL;
> +
> +       disable_counter_freezing = !res;
>         return 1;
>  }
> -__setup("disable_counter_freezing", intel_perf_counter_freezing_setup);
> +__setup("perf_v4_pmi=", intel_perf_counter_freezing_setup);
>
>  /*
>   * Simplified handler for Arch Perfmon v4:
