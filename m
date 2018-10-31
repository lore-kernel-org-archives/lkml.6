Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B3AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D77220838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7O8WBH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D77220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJaSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:16:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34695 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJaSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:16:09 -0400
Received: by mail-io1-f65.google.com with SMTP id d80-v6so9168084iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqESkq9AtZ7dSGE1LN01rZhHamFgyrI9PHchU5ozMuI=;
        b=V7O8WBH9OgSrFyUOkFbXYGytQrp4Q9426j5PanxxnvOrLw9kuZC0QnNeMStoIm5q91
         Eq0XLy+GpbWCBsyGq2u4w3kFo6BsgDp3x2R+46vbBqUrGfgeWhS5MDSCVs0c33+UwJTk
         tT0M9egoG2WOSuTrCfOt63TTNXGFpHL6KFtwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqESkq9AtZ7dSGE1LN01rZhHamFgyrI9PHchU5ozMuI=;
        b=eawur8NLfCLIpo/H13j2wsNyR56O0pmUIwEMESYuC0MvCq3/DOFq+WR8cU+7CSlCHs
         CKkwd1EhJu5Gry57kjVEZMs7HYJZPCbxPMCbgLKwbRclWvH++8EADm95bMg9VjK7sMHe
         XHTJsGx0hr9fekGNEex5GaHEEwZqWTfiuJtsrWqNts3525V6aKK4M/CgQC+ihTLVtGby
         n2XSvgJZ7YiJKbEVzmRQ6bsgDpHG0dFZtt1CDWAfWJ5o6R5fDN9U8cUyeuBI4CeQmlxr
         Jc06InqpB86S9bvWYg6UNz7t0zHPTmb9ROGRgZRkrg9BZ3v3NYMShLAtvKJqolstGFEp
         P7Cg==
X-Gm-Message-State: AGRZ1gKcRQB/tfQsZqpKL8E3fEadvcH/8gckyou8STRogz1zdvgf08/a
        2c5AdHBN4TiY7E1unprUk3uCkV5KrndNX9Zl+jYZUQ==
X-Google-Smtp-Source: AJdET5e2wVemKACcLz/umE19+MuB1wYJ/otr62PUN9Timg72NXmz+BwmbrwfpjuyXZbKOTNxDIc1hLn47Cr1aNDKs1s=
X-Received: by 2002:a6b:244:: with SMTP id 65-v6mr1322241ioc.183.1540977531261;
 Wed, 31 Oct 2018 02:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org> <6d0b324e-5e26-a510-9bcd-97f475e515ed@arm.com>
In-Reply-To: <6d0b324e-5e26-a510-9bcd-97f475e515ed@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 31 Oct 2018 10:18:39 +0100
Message-ID: <CAKfTPtAPsq3fYrLEX7otQ+6Wy5JrQsYG8nLnEWT+09JBi=iKnQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Wed, 31 Oct 2018 at 08:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 10/26/18 6:11 PM, Vincent Guittot wrote:
>
> [...]
>
> >   static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
> >   static unsigned long task_h_load(struct task_struct *p);
> > @@ -764,7 +763,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
> >                        * such that the next switched_to_fair() has the
> >                        * expected state.
> >                        */
> > -                     se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
> > +                     se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
> >                       return;
> >               }
> >       }
>
> There is this 1/cpu scaling of se->avg.util_sum (running_sum) in
> update_tg_cfs_runnable() so it can be used to calculate
> se->avg.runnable_load_sum (runnable_sum). I guess with your approach
> this should be removed.

Yes good catch

>
> > @@ -3466,7 +3465,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >   /* Update task and its cfs_rq load average */
> >   static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >   {
> > -     u64 now = cfs_rq_clock_task(cfs_rq);
> > +     u64 now = cfs_rq_clock_pelt(cfs_rq);
> >       struct rq *rq = rq_of(cfs_rq);
> >       int cpu = cpu_of(rq);
> >       int decayed;
> > @@ -6694,6 +6693,12 @@ done: __maybe_unused;
> >       if (new_tasks > 0)
> >               goto again;
> >
> > +     /*
> > +      * rq is about to be idle, check if we need to update the
> > +      * lost_idle_time of clock_pelt
> > +      */
> > +     update_idle_rq_clock_pelt(rq);
> > +
> >       return NULL;
> >   }
>
> [...]
