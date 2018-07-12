Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176872147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176872147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbeGLNr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeGLNr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:47:27 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4187E21479;
        Thu, 12 Jul 2018 13:37:49 +0000 (UTC)
Date:   Thu, 12 Jul 2018 09:37:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 5/7] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180712093747.4fca1642@gandalf.local.home>
In-Reply-To: <20180712083805.GA67912@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-6-joel@joelfernandes.org>
        <20180711131256.GH2476@hirez.programming.kicks-ass.net>
        <20180711091944.4d8e78ef@gandalf.local.home>
        <20180712083805.GA67912@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 01:38:05 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> So actually with or without the clean up, I don't see any issues with
> dropping lockdep_recursing in my tests at the moment. I'm not sure something
> else changed between then and now causing the issue to go away. I can include
> Peter's clean up in my series though if he's Ok with it since you guys agree
> its a good clean up anyway. Would you prefer I did that, and then also
> dropped the lockdep_recursing checks? Or should I keep the
> lockdep_recursing() checks just to be safe? Do you see cases where you want
> irqsoff tracing while lockdep_recursing() is true?

I say rewrite it as per Peter's suggestion. Perhaps even add credit to
Peter like:

Cleaned-up-code-by: Peter Zijlstra <peterz@infradead.org>

  ;-)

And yes, I would recommend dropping the lockdep_recursion() if you
can't trigger issues from within your tests. If it shows up later, we
can always add it back.

Thanks!

-- Steve
