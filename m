Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA346217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhtqGWhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeLRBPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:15:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35665 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeLRBPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:15:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so14212929wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 17:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtV8grmjLA0rwx3YhGhQj1UX/LL1RwYw0cDYDYDCZQ4=;
        b=HhtqGWhr4ELtOVTsQaCzl2jfH5UQSFbjJ7o0cQPu3tty6slMA5FrhcMyuWO1862TPC
         TovMgF0u9tuNUPWYSU3wBU+0sTAK7m7KKZ51S+rSpJNjy8Z5TEPt8HN2xJLke0aWMze2
         g6huHXJmZfpJgb82OUlb80GH6G72sXqfTLAkuFGOO8uML3Dw7NUlIwBiaAubDnk6GyiC
         RQxOzg3vvGHYzXPfDRWdgwrvpD3M3+HNrEUpI1oAKGR9FrpzlZ9mRzp4lf3qUM9Pij8v
         Uq/mmngb36fGkAijmpWMUx7rWM5WCXfaRx8ZyJokBUrz8Gt2kg+Fals6cH5C1wyK/Q4h
         qobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtV8grmjLA0rwx3YhGhQj1UX/LL1RwYw0cDYDYDCZQ4=;
        b=bxZ8tH2BkK/dGdlA1iD4YQIfNsWS8kDGH3MXNMZOuAA1p5C04Wk+3pahCE2NsUvV2V
         HGSguZ6kE3JIzC8i6BfSET88SAydtWlvfQ2x3QpJ0fu4nCmMQ4109cZQSLjSMGbYy1L/
         2vSnoFmXx74B58b9IVY5vHiTPL8zUnlPys1jkrHgHixsrNKembUQON5SLHaQDFHWBT/v
         8sp7TCGGwkkbNiuS6dBLOJAlyN063zOH1qjElb2RbB5D2P/+TM44fxgS/3WZ6sS+gYst
         vEEN6yU5pXfJ7HeYbNXKuLMQywnwugzxBSs714q+WpbS/7+mzK4sjURAdzfla67kqhwV
         klnQ==
X-Gm-Message-State: AA+aEWaYxwrhkL88UqMJsDEpD6LFNQ+A3CLFNQ1O6ZHMp4OdWjlNX0ny
        Y7uFZIxn21zn330veszuX2ah238sS8Giw3VCicMeUA==
X-Google-Smtp-Source: AFSGD/UgXuKn+3a1qdcEW43eWrLYEELDM6mjwQz2LqFVq3s3vrEjGagQxiaQO8dZFeEPY1t3L6G93/uIM6p4Fk1Pb1E=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr12163482wru.291.1545095704461;
 Mon, 17 Dec 2018 17:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20181214171508.7791-1-surenb@google.com> <20181214171508.7791-5-surenb@google.com>
 <20181217155525.GC2218@hirez.programming.kicks-ass.net>
In-Reply-To: <20181217155525.GC2218@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Dec 2018 17:14:53 -0800
Message-ID: <CAJuCfpHrQB7OtEC535=s4iJqwan17nAc-mbycV1aJ3RUQTWCPA@mail.gmail.com>
Subject: Re: [PATCH 4/6] psi: introduce state_mask to represent stalled psi states
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 7:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Dec 14, 2018 at 09:15:06AM -0800, Suren Baghdasaryan wrote:
> > The psi monitoring patches will need to determine the same states as
> > record_times(). To avoid calculating them twice, maintain a state mask
> > that can be consulted cheaply. Do this in a separate patch to keep the
> > churn in the main feature patch at a minimum.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/psi_types.h |  3 +++
> >  kernel/sched/psi.c        | 29 +++++++++++++++++++----------
> >  2 files changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > index 2cf422db5d18..2c6e9b67b7eb 100644
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -53,6 +53,9 @@ struct psi_group_cpu {
> >       /* States of the tasks belonging to this group */
> >       unsigned int tasks[NR_PSI_TASK_COUNTS];
> >
> > +     /* Aggregate pressure state derived from the tasks */
> > +     u32 state_mask;
> > +
> >       /* Period time sampling buckets for each state of interest (ns) */
> >       u32 times[NR_PSI_STATES];
> >
>
> Since we spend so much time counting space in that line, maybe add a
> note to the Changlog about how this fits.

Will do.

> Also, since I just had to re-count, you might want to add explicit
> numbers to the psi_res and psi_states enums.

Sounds reasonable.

> > +             if (state_mask & (1 << s))
>
> We have the BIT() macro, but I'm honestly not sure that will improve
> things.

I was mimicking the rest of the code in psi.c that uses this kind of
bit masking. Can change if you think that would be better.
