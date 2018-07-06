Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B84C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AB624028
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AB624028
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeGFNcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:32:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54654 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeGFNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:32:02 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fbQq8-0002dy-Ns; Fri, 06 Jul 2018 15:32:00 +0200
Date:   Fri, 6 Jul 2018 15:32:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: remove get_cpu() from sched_fork()
Message-ID: <20180706133200.a5n47p6utvil4bvf@linutronix.de>
References: <20180706130615.g2ex2kmfu5kcvlq6@linutronix.de>
 <20180706131808.GM2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180706131808.GM2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-06 15:18:08 [+0200], Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 03:06:15PM +0200, Sebastian Andrzej Siewior wrote:
> > Based on this it is possible to remove get_cpu() and use
> > smp_processor_id() for the `cpu' variable without breaking anything.
> 
> Almost.. I think, see init_task_preempt_count().

 #define init_task_preempt_count(p) do { \
         task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
 } while (0)

and task_thread_info() references p only. It looks good, what did I
miss?

Sebastian
