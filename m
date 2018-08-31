Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0688CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C0E20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C0E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeHaFAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeHaFAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:00:07 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E77620839;
        Fri, 31 Aug 2018 00:55:12 +0000 (UTC)
Date:   Thu, 30 Aug 2018 20:55:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH tip/core/rcu 3/3] srcu: Make early-boot call_srcu()
 reuse workqueue lists
Message-ID: <20180830205509.51a2ed34@vmware.local.home>
In-Reply-To: <20180831000952.GZ4225@linux.vnet.ibm.com>
References: <20180829215616.1c10e476@vmware.local.home>
        <20180830020701.GE4225@linux.vnet.ibm.com>
        <20180829224609.5ffdc9ec@vmware.local.home>
        <20180830032315.GG4225@linux.vnet.ibm.com>
        <20180830124444.6bb9faac@gandalf.local.home>
        <20180830173509.GL4225@linux.vnet.ibm.com>
        <20180830173742.GA17677@linux.vnet.ibm.com>
        <20180830143617.2fb85e23@gandalf.local.home>
        <20180830231211.GW4225@linux.vnet.ibm.com>
        <20180830195322.18ece5df@gandalf.local.home>
        <20180831000952.GZ4225@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 17:09:52 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Thu, Aug 30, 2018 at 07:53:22PM -0400, Steven Rostedt wrote:
> > On Thu, 30 Aug 2018 16:12:11 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> >   
> > > > > -	WARN_ON_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INIT);    
> > > > 
> > > > Well it boots without warning ;-)
> > > > 
> > > > Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>    
> > > 
> > > Thank you again!  I applied this to 1/3 and 3/3 on the assumption that
> > > you did not run rcutorture.  ;-)  
> > 
> > No rcutorture. Just reverted the tracepoint SRCU delay patch and it
> > boots with the trace event enabled.  
> 
> Very good, then I did get it right.  1/3 and 3/3, but not 2/3.
>

I did apply 2, but didn't enable rcutorture. I just applied the entire
series.

-- Steve
