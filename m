Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A19EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE272075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="hb0zCfdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbeIGTfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:35:23 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43301 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbeIGTfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:35:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id l189-v6so5477146ywb.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aKXhT6dgRY4iCFlFoD4xbTkI/eQwmUIY+/zNex8lHDk=;
        b=hb0zCfdCJWwxfqPfjlaYsbZD0Qnjj3b2siGVNw1E7tjzT2SKRZuH8Zae2fUbT6yoeB
         5u/KLdk2wy4FDZKETzmAPztBfX6o8qRje8VpORKjgBruIHXkb/R/N1fcSMiPaNZvOjF8
         mcY/xoH2v6fsQqRyJL5A+xbMdVwwIh+N6FYKSvVfLXqxU65IzbgR2xy21z2CiQqRB9PN
         Khzb8UXshGhXmFA1kIEhYiGyTOkSTCgGaJB0RqAzQ1XTlHfn5v2oFadZ2ZbzqE0I5X2g
         j7fXK9jAJ4sty8o5CSElHfAV2LhT/GHgDrxX2GLBGZSDKvCFmDdvqI2VrhEel5RK4xMx
         Vv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aKXhT6dgRY4iCFlFoD4xbTkI/eQwmUIY+/zNex8lHDk=;
        b=ucVQZsuEjIH2jhyuLyW2AJZtjTsou96WnQbeu8npxUj2e0YxOvh4WrDg2dns8Obu2j
         9BY0O0sIsIQGSkncxJumMOg5xO85BAz1YUvvOW2d3sBVF8t8iNNfuIePWu9BpsBIvz4H
         wx8pCV3DhVXAiZtcAUyBYu/aNXKYPw5KucCJP7uTCx3mN53F6fjDmUTa1T+re/pBtT9R
         iSxZqdtSJmZ8aLBmRNzSUhz7xJ8N+5wcWJvNZ2lLoyNm/LiNkCJYfqjgajTufJkDjmrF
         cw8Ezlrx0k2nfz6vjamGdzMQ55WPoxnBPLKL/TQ73Rgn48Vns5c7pbX74wwey9ByQptj
         WmUQ==
X-Gm-Message-State: APzg51Do99LAASd9AXJlFOcqTkjnyi67YkVi5x6PiU50wgaZ+9JrpE9i
        1N7DhPNTMYyXfMn/gunpPBHFhg==
X-Google-Smtp-Source: ANB0VdbBDqli1epswfeBz1Izjhmu74fZs/j0i/lB58TtzsWU8gme0SPbP3SK/ILSm8jJg2evy+KSEg==
X-Received: by 2002:a81:70c4:: with SMTP id l187-v6mr4365404ywc.478.1536332046134;
        Fri, 07 Sep 2018 07:54:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:96d9])
        by smtp.gmail.com with ESMTPSA id p78-v6sm3659068ywp.31.2018.09.07.07.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 07:54:05 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:54:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180907145404.GB11088@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
 <20180907102458.GP24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907102458.GP24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:24:58PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 28, 2018 at 01:22:57PM -0400, Johannes Weiner wrote:
> > +static void psi_clock(struct work_struct *work)
> > +{
> > +	struct delayed_work *dwork;
> > +	struct psi_group *group;
> > +	bool nonidle;
> > +
> > +	dwork = to_delayed_work(work);
> > +	group = container_of(dwork, struct psi_group, clock_work);
> > +
> > +	/*
> > +	 * If there is task activity, periodically fold the per-cpu
> > +	 * times and feed samples into the running averages. If things
> > +	 * are idle and there is no data to process, stop the clock.
> > +	 * Once restarted, we'll catch up the running averages in one
> > +	 * go - see calc_avgs() and missed_periods.
> > +	 */
> > +
> > +	nonidle = update_stats(group);
> > +
> > +	if (nonidle) {
> > +		unsigned long delay = 0;
> > +		u64 now;
> > +
> > +		now = sched_clock();
> > +		if (group->next_update > now)
> > +			delay = nsecs_to_jiffies(group->next_update - now) + 1;
> > +		schedule_delayed_work(dwork, delay);
> > +	}
> > +}
> 
> Just a little nit; I would expect a function called *clock() to return a
> time.

Fair enough, let's rename this. How about this on top?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 92489e66840b..0f07749b60a4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -154,7 +154,7 @@ static struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
 
-static void psi_clock(struct work_struct *work);
+static void psi_update_work(struct work_struct *work);
 
 static void group_init(struct psi_group *group)
 {
@@ -163,7 +163,7 @@ static void group_init(struct psi_group *group)
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->next_update = sched_clock() + psi_period;
-	INIT_DELAYED_WORK(&group->clock_work, psi_clock);
+	INIT_DELAYED_WORK(&group->clock_work, psi_update_work);
 	mutex_init(&group->stat_lock);
 }
 
@@ -347,7 +347,7 @@ static bool update_stats(struct psi_group *group)
 	return nonidle_total;
 }
 
-static void psi_clock(struct work_struct *work)
+static void psi_update_work(struct work_struct *work)
 {
 	struct delayed_work *dwork;
 	struct psi_group *group;
