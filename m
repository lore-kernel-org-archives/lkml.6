Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCTIJB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:09:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCTIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:08:55 -0400
Date: Tue, 20 Mar 2018 09:08:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] sched/debug: fix per-task line continuation for
 console
Message-ID: <20180320080852.GM4043@hirez.programming.kicks-ass.net>
References: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
 <1521484555-8620-2-git-send-email-joe.lawrence@redhat.com>
 <20180319201723.GK4043@hirez.programming.kicks-ass.net>
 <6b826ab1-c6a4-244e-ace6-d735b415a268@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b826ab1-c6a4-244e-ace6-d735b415a268@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 04:43:28PM -0400, Joe Lawrence wrote:
> On 03/19/2018 04:17 PM, Peter Zijlstra wrote:

> I don't have the commit offhand that changed the printk behavior, but
> from observation:

4bcc595ccd80 ("printk: reinstate KERN_CONT for printing continuation lines")

and thereabout I think.

> > Does pr_cont("\n") DTRT? it seems like something weird.
> > 
> 
> Yeah, pr_cont() is kind of a hack.  It will terminate a line if that's
> the first newline, but as demonstrated above, I don't think it likes
> extra newline chars.

Fair enough I suppose, just a bit weird.

> A better fix would be to marshal the text into temp buffer then dump it
> out.  Dunno if you prefer that kind of churn for these stats.

Yeah, not worth it, simple is better here.
