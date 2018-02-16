Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161970AbeBPRbN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161857AbeBPRbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:31:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01F9217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 12:31:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] kernel/sofirq: consolidate common code in
 __tasklet_schedule() + _hi_
Message-ID: <20180216123109.5098b1ca@gandalf.local.home>
In-Reply-To: <20180216085302.ptzq5yspmdq3zlh6@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
        <20180215172042.31573-2-bigeasy@linutronix.de>
        <20180215150707.49cc2332@gandalf.local.home>
        <20180216085302.ptzq5yspmdq3zlh6@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 09:53:03 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> As for the second invocation (tasklet_action_common() part) is always
> invoked in BH-disabled context (even if called from ksoftirqd) so you
> are never preemptible() and can't switch CPUs.
> So I am going to correct this patch as you suggested but I don't see the
> reason to do the same in the second one.

Should we add something like:

	WARN_ON_ONCE(!in_atomic());

?

-- Steve
