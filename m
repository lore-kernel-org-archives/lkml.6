Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD21C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A3420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A3420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeFTMvr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:51:47 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:35191 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753475AbeFTMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:51:46 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 20 Jun 2018 21:51:43 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 20 Jun 2018 21:51:43 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 20 Jun 2018 21:51:42 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>,
        peterz@infradead.org, mingo@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dario Faggioli <raistlin@linux.it>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@gmail.com>,
        bristot@redhat.com, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RESEND PATCH v12 2/2] sched/rt: Add support for
 SD_PREFER_SIBLING on find_lowest_rq()
Message-ID: <20180620125142.GA21889@X58A-UD3R>
References: <1529297889-24551-1-git-send-email-byungchul.park@lge.com>
 <1529297889-24551-3-git-send-email-byungchul.park@lge.com>
 <20180618174203.4a1b4cf0@gandalf.local.home>
 <CANrsvROOfkPw265ObAPJ_H2epP2SJJsV64xcAGvOCbqHgwny1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrsvROOfkPw265ObAPJ_H2epP2SJJsV64xcAGvOCbqHgwny1w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:16:36PM +0900, Byungchul Park wrote:
> On Tue, Jun 19, 2018 at 6:42 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Mon, 18 Jun 2018 13:58:09 +0900
> > Byungchul Park <byungchul.park@lge.com> wrote:
> >
> >> Hello Steven,
> >>
> >> I've changed the code a little bit to avoid a compile warning caused by
> >> 'const' args of find_cpu(). Can I keep your Reviewed-by?
> >>
> >> BEFORE:
> >> static int find_cpu(const struct cpumask *mask,
> >>                   const struct sched_domain *sd,
> >>                   const struct sched_domain *prefer)
> >>
> >> AFTER:
> >> static int find_cpu(const struct cpumask *mask,
> >>                   struct sched_domain *sd,
> >>                   struct sched_domain *prefer)
> >>
> >> (I temporarily removed the Reviewed-by you gave me.)
> >> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > I would fix sched_domain_span() to take a constant and keep the
> > previous patch.
> 
> Right. I also considered it like you and asked it here:
> 
>    https://lkml.org/lkml/2018/1/11/106
> 
> But I didn't get any answer so tried to keep sched_domain_span()
> unchanged conservatively.
> 
> Peterz, what's your opinion?

Peterz and Ingo,

I cannot progress forward without your opinion. Please your opinion.

> > -- Steve
> 
> -- 
> Thanks,
> Byungchul
