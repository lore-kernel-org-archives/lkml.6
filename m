Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5242E20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5242E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeHaQV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:21:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52447 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeHaQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:21:57 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fviJn-0004Md-Jj; Fri, 31 Aug 2018 14:14:27 +0200
Date:   Fri, 31 Aug 2018 14:14:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     mojha@codeaurora.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:smp/urgent] cpu/hotplug: Remove skip_onerr field from
 cpuhp_step structure
In-Reply-To: <20180831083316.GR24082@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1808311413280.4105@nanos.tec.linutronix.de>
References: <1535439294-31426-1-git-send-email-mojha@codeaurora.org> <tip-935aad3015fb4afc0b7ef6e6c18175b95461de47@git.kernel.org> <20180831083316.GR24082@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-557380923-1535717667=:4105"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-557380923-1535717667=:4105
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 31 Aug 2018, Peter Zijlstra wrote:

> On Thu, Aug 30, 2018 at 04:03:58AM -0700, tip-bot for Mukesh Ojha wrote:
> > Commit-ID:  935aad3015fb4afc0b7ef6e6c18175b95461de47
> > Gitweb:     https://git.kernel.org/tip/935aad3015fb4afc0b7ef6e6c18175b95461de47
> > Author:     Mukesh Ojha <mojha@codeaurora.org>
> > AuthorDate: Tue, 28 Aug 2018 12:24:54 +0530
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Thu, 30 Aug 2018 12:59:30 +0200
> 
> > @@ -644,12 +637,6 @@ static void cpuhp_thread_fun(unsigned int cpu)
> >  
> >  	WARN_ON_ONCE(!cpuhp_is_ap_state(state));
> >  
> > -	if (st->rollback) {
> > -		struct cpuhp_step *step = cpuhp_get_step(state);
> > -		if (step->skip_onerr)
> > -			goto next;
> > -	}
> > -
> >  	if (cpuhp_is_atomic_state(state)) {
> >  		local_irq_disable();
> >  		st->result = cpuhp_invoke_callback(cpu, state, bringup, st->node, &st->last);
> 
> 
> Can you fold this in?
> 
> ../kernel/cpu.c: In function ‘cpuhp_thread_fun’:
> ../kernel/cpu.c:663:1: warning: label ‘next’ defined but not used [-Wunused-label]

Bah. I even saw the warning and wanted to fix it before pushing it
out. That's what you get for doing 20 things at once....

Folded in and force pushed. Thanks Peter!
--8323329-557380923-1535717667=:4105--
