Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8382AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2720851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="jtg4bmyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD2720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeK1JIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:08:22 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45984 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1JIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:08:22 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so8193021uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+25T8y4M7WNr1sxhtaIV30jNHrbI1F45DQh6UEMKJw=;
        b=jtg4bmyLes4Chl9JZwAStE4mbSCxmdQCZShe5niGv1yIwuNPqhbho2borMhAzxj+BX
         ISA7dcDZEiiVQ1fgA6VAALzDGWHDnGxS7chYxs9RsVx47kGvUhsdxeZNKXEYCZLmH4os
         zTfBFBgfAWnIM5YprZ7uzc7tn1f6S9oW3nRRamybhB+wfY4Wrn//8lhu3AVW/H8N9zqF
         pSR50yxFgZl3/yZ9uEHYqGyDuEjBfCDQQQUBd0OxcXFhyREBkY4ZMEuNZvqbuZpmQ7zS
         EQNBhkLTnINWGGQJaXNYl9zOWTcDkLleOQblBoBTAUYHSos6UlQnkeTpKWSEL+2A5RhT
         gQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+25T8y4M7WNr1sxhtaIV30jNHrbI1F45DQh6UEMKJw=;
        b=J6R8lnSSkNrQbkxJCR0eJDWBSJ/tqasNK96AU53XhPCZtJvgJKbdmX1Oc2DGB5I0BH
         YvjHJqRa+cuziv4fsWNpbRN9DHa++4jX1sRYIKYg+h6ld9kNZVmOigasXu22rTssZSzH
         LRAqYb9FQkbrQ5xbil12V4oaL8dCN8SFPaaMbQMIj/32gE0jwuf24MuWrgdXgvvqP5MV
         G7VdH4pbta1A7LIUYXdvLbC5O2HygG0VxsNYIPwa1Etm6CjoBIganu5s6EMcvgdfU4ke
         o0ja4HzZ9LG3GF7a1z7F9FFaUst9LI6Lup6uQb/QpvxURU+i3tsWy1Ni45YTobPkmflh
         cMCw==
X-Gm-Message-State: AA+aEWYtgYxA153F4IL7X6AcVXjfUkRG/Mo9EgH0b2EHRPAn2juMaT/B
        0U9FyreRJEAsIjjJJKv6cpBk3Jnsfx69eAsdGfBIDA==
X-Google-Smtp-Source: AFSGD/U0vLFgklQUW7LfQ6/uZ3uSVeLHmxHNUyN07xPyWtcliMr0qFUKdcRYHMKONKA9T8SSSjiTYXQ2R1sYrWxj6FE=
X-Received: by 2002:ab0:6151:: with SMTP id w17mr12028020uan.114.1543356541041;
 Tue, 27 Nov 2018 14:09:01 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com> <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com> <20181120221642.GE2131@hirez.programming.kicks-ass.net>
 <20181120222549.GA2149@hirez.programming.kicks-ass.net> <20181120223854.GH13936@tassilo.jf.intel.com>
 <20181121081420.GF2131@hirez.programming.kicks-ass.net>
In-Reply-To: <20181121081420.GF2131@hirez.programming.kicks-ass.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 27 Nov 2018 14:08:46 -0800
Message-ID: <CAP045AqRs4+F5rNKXLYHeuvLCvzd9U=eZY0X0NnHXxz3qk9TUw@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
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

On Wed, Nov 21, 2018 at 12:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 20, 2018 at 02:38:54PM -0800, Andi Kleen wrote:
> > > In fact, I'll argue FREEZE_ON_OVERFLOW is unfixably broken for
> > > independent counters, because while one counter overflows, we'll stall
> > > counting on all others until we've handled the PMI.
> > >
> > > Even though the PMI might not be for them and they very much want/need
> > > to continue counting.
> >
> > We stop all counters in any case for the PMI. With freeze-on-PMI it just
> > happens slightly earlier.
>
> Hiding the PMI is fine and good. The PMI is not the workload. Stopping
> it earlier is _NOT_ good, it hides your actual workload.

It does seem that FREEZE_PERFMON_ON_PMI (misnamed as it is) is of
rather limited use (or even negative, in our case) to a counter that's
already restricted to ring 3.

- Kyle
