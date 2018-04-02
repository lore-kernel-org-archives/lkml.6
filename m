Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeDBPRk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbeDBPRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:17:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA82B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 2 Apr 2018 11:17:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] trace: Default to using trace_global_clock if
 sched_clock is unstable
Message-ID: <20180402111736.763c861e@gandalf.local.home>
In-Reply-To: <20180330150132.16903-1-chris@chris-wilson.co.uk>
References: <20180330150132.16903-1-chris@chris-wilson.co.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 16:01:31 +0100
Chris Wilson <chris@chris-wilson.co.uk> wrote:

> Across suspend, we may see a very large drift in timestamps if the sched
> clock is unstable, prompting the global trace's ringbuffer code to warn
> and suggest switching to the global clock. Preempt this request by
> detecting when the sched clock is unstable (determined during
> late_initcall) and automatically switching the default clock over to
> trace_global_clock.
> 
> This should prevent requiring user interaction to resolve warnings such
> as:
> 
>     Delta way too big! 18446743856563626466 ts=18446744054496180323 write stamp = 197932553857
>     If you just came from a suspend/resume,
>     please switch to the trace global clock:
>     echo global > /sys/kernel/debug/tracing/trace_clock
> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> v2: Tell the user what's happening and what they can do to correct it.
>

Thanks, I pulled them in. I'll start testing them before I post to git.

-- Steve
