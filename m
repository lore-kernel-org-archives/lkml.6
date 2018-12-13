Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319C5C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F4720851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cx5PwlSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F4720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbeLMPPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:15:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35816 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeLMPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:14:58 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so4329289itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPsj/MZROLfvXGGh+/iYdOCofcLRXn+lJ7nLkP1VQCg=;
        b=Cx5PwlSATcMciz0gUbLOFUSQfk25LvqK/bpe4dPBQUHZtI28PNbx//1adVLKiqr11+
         pwYgUrIX7QP5/AMLKIlMzI8cNqak69x2WA433psB4I855faD+CnUwN+sfbkomtfsdgiH
         pvu2Yithy2WdAbqU4hzfgjdze24LAYm2hXSfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPsj/MZROLfvXGGh+/iYdOCofcLRXn+lJ7nLkP1VQCg=;
        b=XJVBjZuoSxaq1UJ0D65G9TAjEzHGryEh4UyYxF0SP3PtwrQDl39qot7XzYaXXOuqRM
         pI9O1RnknusLL2bpOwJcZkE1XUF1gmEsJRrKkajjM7k6l1QgiocQn6z3VkgtNqlGXb3j
         HUTko7cBF9fxhAs6cj8eQGofsjGeKERVrnPwIigDddbPB72uMvxKq61YwYN/dOc/H9mP
         57O14vSALNHw29mn6e9eQcvZgJRLi/sFzvfvP8+5xc1IzGnBLrBo0Vnb3HOenXf3At8Q
         /BoXc9/8sudauTuG3mKZzfwFjDfbqUn+1nCZoqW/d4sasXTaBOBuTMy6Q0qLiVf3S5/o
         dV1w==
X-Gm-Message-State: AA+aEWYYaYrNwV6o6g5H2zJL8KvT311YirAtDRwFOqhfH1T+RNouNxZm
        z716WBJL5O7hFfgQNFHD6keMAS8dMsOWjkKUgYwaaQ==
X-Google-Smtp-Source: AFSGD/X+tLAzecDFBzNVa43UZAW0+q2EmB5z9uPXnnt2x5cahuYdOxQXRcCK1IG3b7cH4d+q0eU6Q4JaqzbUtV61xG8=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr9966839itb.152.1544714097884;
 Thu, 13 Dec 2018 07:14:57 -0800 (PST)
MIME-Version: 1.0
References: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
 <20181213104439.GG5289@hirez.programming.kicks-ass.net> <CAKfTPtBG_gcWzi4RUWF_c2aazqxDPHbb2rGWHvWND6pQHQxPGw@mail.gmail.com>
 <20181213131211.GK2237@hirez.programming.kicks-ass.net>
In-Reply-To: <20181213131211.GK2237@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Dec 2018 16:14:46 +0100
Message-ID: <CAKfTPtCJhDStka9MP5qeNPr+FZWAgDY3UCOOHU5XNGBR3TgMUw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix 1 task per CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 14:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 13, 2018 at 12:04:20PM +0100, Vincent Guittot wrote:
> > On Thu, 13 Dec 2018 at 11:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Sep 10, 2018 at 04:43:09PM +0200, Vincent Guittot wrote:
> > > > When CPUs have different capacity because of RT/DL tasks or
> > > > micro-architecture or max frequency differences, there are situation where
> > > > the imbalance is not correctly set to migrate waiting task on the idle CPU.
> > > >
> > > > The UC uses the force_balance case:
> > > >
> > > >       if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> > > >           busiest->group_no_capacity)
> > > >               goto force_balance;
> > > >
> > > > But calculate_imbalance fails to set the right amount of load to migrate
> > > > a task because of the special condition:
> > > >
> > > >   busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)
> > > >
> > > > Add in fix_small_imbalance, this special case that triggered the force
> > > > balance in order to make sure that the amount of load to migrate will be
> > > > enough.
> > >
> > > So I think this patch is going in the wrong direction for a number of
> > > reasons:
> > >
> > >  - we'd like to get rid of fix_small_imbalance(), and this adds to it;
> > >
> > >  - the whole load_per_task stuff is terminally broken, it _cannot_ work
> > >    right.
> > >
> > >
> > > What I've suggested in the past is parameterizing the load balancer and
> > > picking different criteria to balance on:
> >
> > This patch is clearly a fix of the current implementation.
> > What you suggest below makes sense but implies a significant rework in
> > the calculate_imbalance and the load_balancer in general and will need
> > more time to reach a stable state.
> > Nevertheless, I will have a look at that
> >
> > I imagine that your feedback for https://lkml.org/lkml/2018/10/2/283
> > will be the same ?
>
> No; those actually look ok. It is mostly that I really don't think
> load_per_task makes any kind of sense.
>
> It sorta works when all tasks are of the same weight, but if you start
> using nice -- or way worse, cgroups -- then the number is complete
> bollocks.

Yes. As soon as we goes out of a simple load balance UC, load_per_task
becomes a kind of default random choice
