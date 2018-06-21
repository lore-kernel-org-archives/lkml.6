Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C81C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F82721A36
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvHE6up9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F82721A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbeFUSm3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:42:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34690 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:42:28 -0400
Received: by mail-it0-f66.google.com with SMTP id y127-v6so3326081itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDW+thVYAoXXxodQ2uiUELEeeKA5rcom49FTrSc7mXc=;
        b=fvHE6up9voby08N3R9fgI9cdKZv56bGvYzcEs8WTfdnqaHLNEen+Q98LzwPTeY+hda
         llKkr/rd7a1MfFm0a/6jWVxCTJ/+sgtBn5GfwYsMZQGC4KUDfGERFXVPmpS8Opl9RxpK
         4zmStGb/i53LMZnm0girlwmw1qW81vZFWEKsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDW+thVYAoXXxodQ2uiUELEeeKA5rcom49FTrSc7mXc=;
        b=ahyVNXS427faMzrE56nM6Q/p+OobxH/TkiMFie/qWq7A8OZqINJXbGipau9b6ARndP
         TPnS1O77Ip5eymKkHVNhgOVUtrh3/APR4Su3yGOm1duoL7uVex4hVgsgU64p2SJ486Ip
         OIT9ibgaRIOFxVhtDHZ+FCJQ7COX1IJPSrD70yUQypDK7FJnnTZiPX5xw4HlHtRB7UTF
         fSLO3Vj+J0wAf3BAFg1Ft2+oBMyFvi6pzHxv6bAWlSoLbSgU2AETsfcP/FrWd35s4iqp
         tfeNbotSu5tsEfIYBRhLlOEKYTfi2vRn7V7SavzvR13jsoPC/nCTaiQBbPvYKlBck7Ka
         pH9Q==
X-Gm-Message-State: APt69E0HEpiw1x7C6U76WSpsEeTgMmK1IHWlToNa9Ym/801l4Anti/Gl
        cxMY0nWEHrP/zVFl/Hneah0TJjN2zxivodTA+BRZIw==
X-Google-Smtp-Source: ADUXVKIAoWPT5ZXrP2/bWT+rN1taJtgs8eeX6SCFIBmO9n3hmEFzwwn5PXT8ae/NPwPIQypPBCwrSmG0V/Wc0Ot0Hqg=
X-Received: by 2002:a24:9401:: with SMTP id j1-v6mr3698860ite.89.1529606548066;
 Thu, 21 Jun 2018 11:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-3-git-send-email-vincent.guittot@linaro.org> <20180621143316.GA27616@hirez.programming.kicks-ass.net>
In-Reply-To: <20180621143316.GA27616@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Jun 2018 20:42:16 +0200
Message-ID: <CAKfTPtDVDhojjq-zg5X5iQ5-h=Ra1Kaxt7nJQR82pwN-pGXMhQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] sched/pelt: remove blank line
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 at 16:33, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 08, 2018 at 02:09:45PM +0200, Vincent Guittot wrote:
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index e6ecbb2..4174582 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -287,7 +287,6 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
> >
> >       if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
> >                               cfs_rq->curr == se)) {
> > -
> >               ___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
> >               cfs_se_util_change(&se->avg);
> >               return 1;
> > @@ -302,7 +301,6 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
> >                               scale_load_down(cfs_rq->load.weight),
> >                               scale_load_down(cfs_rq->runnable_weight),
> >                               cfs_rq->curr != NULL)) {
> > -
> >               ___update_load_avg(&cfs_rq->avg, 1, 1);
> >               return 1;
> >       }
>
> So I put them there on purpose, I find it easier to read when a
> multi-line if statement and the body are separated. Makes it clearer
> where the if ends and the block begins.
>
> I mean, all whitespace in C is superfluous, and yet we keep adding it to
> these files :-)

I'm fine with keeping it as well as for newly added ones; Patrick
raised the point on a similar empty line  for the newly added
update_rt_rq_load_avg() function on previous revision and just wanted
to keep them all aligned
