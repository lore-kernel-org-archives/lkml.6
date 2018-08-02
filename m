Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50303C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0547F21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Te3hK2ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0547F21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeHBPjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:39:32 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54003 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbeHBPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:39:32 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so3278301itw.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hw98tV+x1/k7wdcpw9lObaYWmH8fPxudfhgV8ZdDoAg=;
        b=Te3hK2ietz/L6CeF7bNdTc+bZK/VqHX2aDuwO1miB9MOQvyAxNFZO8DG/wmKhYnbUE
         ahMx6KpwxCoKvMCWxW8IPGLWfHZ8bQ/ENjtveSvoqNQnDG27zNMzi4aA72P0j7xEoLQ0
         4jcb/zhHQJ9w8koxceNZ+G5lXO1KTOWNpx7NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hw98tV+x1/k7wdcpw9lObaYWmH8fPxudfhgV8ZdDoAg=;
        b=MSNwDEcnh8v4pY0JsBHrG4KlFJcyKnclKoz7VRZK7rgW1lkDt0amF0SQH7OtCLF8hU
         EPp1iw4+DolO+nJ0aKSofLk0Ef+dA+hemLPlLl/HqKZateTEWAjvv5c5LSyiDHpIjJu1
         OTC+lavsk4edqrsfkpqKjgq1MLCCf1GW+Lvo2GubSmGB6QCDUgp0ZTDPU95LMjD69Esg
         l9P5+BL1MPl3QBXAYQKRCYfWvlkm0s6UCgj+rLgyVDsj+q9Tsq28Uvw+BTANnDcGAl1Q
         Gn1caFGP6zzh89aTqGvK7kvbaznPY998ElCkCGWRYqF0mfWUwJErijCQckgxYp+EzDUD
         YbBw==
X-Gm-Message-State: AOUpUlFzqEB9krFK9Z5cZefKGrCcjhB51iE6D5XnJOaGruK7VVEl8Q6b
        F/Kcupf51RL2yA5riKDNeVXO1UPky4UXOQjcgF76qg==
X-Google-Smtp-Source: AAOMgpdnmClwPgL6eNfNJ5U/eNyUJq6jKo+2byCf8GHJvSIx8MvovbqODExkCAM02DcyA8dptCDXx1ljVnJtSDCO614=
X-Received: by 2002:a24:99c4:: with SMTP id a187-v6mr2407338ite.148.1533217693592;
 Thu, 02 Aug 2018 06:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com> <20180802122629.GU2476@hirez.programming.kicks-ass.net>
 <20180802130337.uf6tlac2hg4nkbwr@queper01-lin> <20180802130801.GL2494@hirez.programming.kicks-ass.net>
 <20180802131849.mqpt5lbtcqrxbwig@queper01-lin>
In-Reply-To: <20180802131849.mqpt5lbtcqrxbwig@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Aug 2018 15:48:01 +0200
Message-ID: <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 at 15:19, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 02 Aug 2018 at 15:08:01 (+0200), Peter Zijlstra wrote:
> > On Thu, Aug 02, 2018 at 02:03:38PM +0100, Quentin Perret wrote:
> > > On Thursday 02 Aug 2018 at 14:26:29 (+0200), Peter Zijlstra wrote:
> > > > On Tue, Jul 24, 2018 at 01:25:16PM +0100, Quentin Perret wrote:
> > > > > @@ -5100,8 +5118,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > >                 update_cfs_group(se);
> > > > >         }
> > > > >
> > > > > -       if (!se)
> > > > > +       if (!se) {
> > > > >                 add_nr_running(rq, 1);
> > > > > +               /*
> > > > > +                * The utilization of a new task is 'wrong' so wait for it
> > > > > +                * to build some utilization history before trying to detect
> > > > > +                * the overutilized flag.
> > > > > +                */
> > > > > +               if (flags & ENQUEUE_WAKEUP)
> > > > > +                       update_overutilized_status(rq);
> > > > > +
> > > > > +       }
> > > > >
> > > > >         hrtick_update(rq);
> > > > >  }
> > > >
> > > > That is a somewhat dodgy hack. There is no guarantee what so ever that
> > > > when the task wakes next its history is any better. The comment doesn't
> > > > reflect this I feel.
> > >
> > > AFAICT the main use-case here is to avoid re-enabling the load balance
> > > and ruining all the task placement because of a tiny task. I don't
> > > really see how we can do that differently ...
> >
> > Sure I realize that.. but it doesn't completely avoid it. Suppose this
> > new task instantly blocks and wakes up again. Then its util signal will
> > be exactly what you didn't want but we'll account it and cause the above
> > scenario you wanted to avoid.
>
> That is true. ... I also realize now that this patch was written long
> before util_est, and that also has an impact here, especially in the
> scenario you described where the task blocks. So any wake-up after the
> first enqueue will risk to overutilize the system, even if the task
> blocked for ages.
>
> Hmm ...

Does a init value set to 0 for util_avg for newly created task can
help in EAS in this case ?
Current initial value is computed to prevent packing newly created
tasks on same CPUs because it hurts performance of some benches. In
fact it somehow assumes that newly created task will use significant
part of the remaining capacity of a CPU and want to spread tasks. In
EAS case, it seems that it prefer to assume that  newly created task
are small and we can pack them and wait a bit to make sure the new
task will be a big task and will overload the CPU
