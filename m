Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C6BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67C721850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeLRLRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:17:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55630 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRLRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:17:00 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gZDMb-0007J2-W5; Tue, 18 Dec 2018 12:16:38 +0100
Date:   Tue, 18 Dec 2018 12:16:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     zhe.he@windriver.com, acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Message-ID: <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218110209.GD15430@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-18 12:02:09 [+0100], Peter Zijlstra wrote:
> On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> > Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> > thus cause the following BUG.
> 
> Hurm, I though we fixed all those long ago..
> 
> And no, the patch is horrible; that's what we have things like
> x86_pmu::cpu_dead() for.

ehm, you say we keep memory allocation +free on CPU up/down?

Sebastian
