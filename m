Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162662AbeBPSCl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162511AbeBPSCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:02:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA0221775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 13:02:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] kernel/sofirq: consolidate common code in
 __tasklet_schedule() + _hi_
Message-ID: <20180216130237.2a955563@gandalf.local.home>
In-Reply-To: <20180216175508.vezb3ll32dxvlz4z@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
        <20180215172042.31573-2-bigeasy@linutronix.de>
        <20180215150707.49cc2332@gandalf.local.home>
        <20180216085302.ptzq5yspmdq3zlh6@linutronix.de>
        <20180216123109.5098b1ca@gandalf.local.home>
        <20180216175508.vezb3ll32dxvlz4z@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 18:55:09 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:


> > Should we add something like:
> > 
> > 	WARN_ON_ONCE(!in_atomic());
> > 
> > ?  
> 
> Doubt it. this_cpu_ptr() screams already with CONFIG_DEBUG_PREEMPT.

If that's the case then, yeah I agree. I couldn't remember if
this_cpu_ptr() did that or not. I remember having an argument with
Christoph Lameter about whether or not this_cpu_* functions would
complain with preemption off, as some of the use cases were for being
used with preemption enabled. I remember there was some kind of
compromise but didn't remember exactly what that was.

-- Steve
