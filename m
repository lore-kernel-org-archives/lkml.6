Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D1FC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2572147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Y/528pzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2572147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeKUIRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:17:53 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42825 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:17:53 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so2017805vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4Mx4xoo0SOnqc8GkEhoqygnyA2JFl4/0RvL1igw+gs=;
        b=Y/528pzZjps892DM9klEZqgYVl275V5S1qHOGcc2si0xaCIjEtNcNre1XbDzpPCLNH
         Bs3TN9oCOjP6Es9ZYOmrqaO7fFbK+qOboW4muV/QkvnNa+ltTJsJYNoCu1tUzms/PXJP
         2GavqqGN23RLnLo4MNRcZgPXpWwapDGwVgdsrDbIZ61HKCjnZ0egdSumfQw1J+o96pYh
         WoJA2tDo2nGnpJWW4BFyQqHy49B7YOCRXBcezgFICurQ9Sc2tJNQYU42C/a7vV8v1dsI
         4t0UNoXsek/+cdfjSxVVN3rvgCFNRY88tF5ob3QVGPdAN+yf6j61pGloMTAC7Z1XRo+Y
         f/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4Mx4xoo0SOnqc8GkEhoqygnyA2JFl4/0RvL1igw+gs=;
        b=doYP9wBiNdC4fZzEHO/rJ2LySP0/SvyvaaEzVL9+xbpSLy9q6DKN2BwDyVIn5h3ws1
         Z3RL1Jrx3SvAyIrlEcZtmjMIBbLLUNs687fbasONK41EfGofFKcVJyClrB2xENln04Fw
         rY4Ufom/HQsQ4dQ9Tr1HKkUFha831TwwQHiX54CapZ+mqbtxDenMnu/JFu3TN6tBnA1o
         A+X27g3Jv6np0dot7ogOpN0YHb/JzF710ueLRipR123nkGXZLeuKk5Qlne47AXGgKzWu
         k9oaZ4TeWZseiXWfpxDyDzlVwhxP9IB9II7VDDl08+zwh7WvZdsu+4jLDTGIEyu7gxf3
         j92A==
X-Gm-Message-State: AGRZ1gLXLMdXsHMf9+YFrB2ol/VIJgv3znUYsuXMj5d/Lhyjs+D/14fx
        WjUo4zgUpynaJrKX6nvWOFrWBP5LF/viXrXRHzFcyA==
X-Google-Smtp-Source: AJdET5dDfxOCigjPGMpAEXMwcoCxHthq6WWLhlSgPIZAntWs8t1hNrODE4TzB92Dpp4m+ICzgB42NMqncAXntClyHSU=
X-Received: by 2002:a67:6346:: with SMTP id x67mr1600973vsb.114.1542750396637;
 Tue, 20 Nov 2018 13:46:36 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com> <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com> <CAP045AoF7-3VBjhaij8JrVLuw+1dUxmLAGthPJm7CsTyY7T9nA@mail.gmail.com>
 <20181120211803.GF13936@tassilo.jf.intel.com>
In-Reply-To: <20181120211803.GF13936@tassilo.jf.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 20 Nov 2018 13:46:05 -0800
Message-ID: <CAP045AprqsgphfBpUe37MjVFu4T9KTb_mYuMj=q0T+9-kbK0qw@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:18 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > I suppose that's fair that it's better for some use cases. The flip
> > side is that it's no longer possible to get exactly accurate counts
> > from user space if you're using the PMI (because any events between
> > the overflow itself and the transition to the PMI handler are
> > permanently lost) which is catastrophically bad for us :)
>
> Yes that's a fair point. For most usages it doesn't matter.
>
> I suspect that's a case for supporting opt-out for freezing
> per perf event, and rr using that.

I don't see how you could easily opt-out on a per perf event basis. If
I'm reading the SDM correctly the Freeze_PerfMon_On_PMI setting is
global and affects all counters on that CPU. Even counters that don't
use the PMI at all will still be frozen if another counter overflows
and counter freezing is enabled. It would seem that a counter that
wants to use counter freezing and a counter that wants the behavior we
want would be mutually exclusive. I suppose the kernel could handle
all of that but it's a bit involved.

- Kyle
