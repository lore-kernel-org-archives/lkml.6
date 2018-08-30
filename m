Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E53C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B05620835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B05620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeH3Trl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeH3Trl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:47:41 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F6E20834;
        Thu, 30 Aug 2018 15:44:53 +0000 (UTC)
Date:   Thu, 30 Aug 2018 11:44:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/52] Remove rcu_state pointers for
 v4.20/v5.0
Message-ID: <20180830114452.309e104f@gandalf.local.home>
In-Reply-To: <20180830041017.GA27378@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
        <20180829220026.3579e9a1@vmware.local.home>
        <20180830032216.GF4225@linux.vnet.ibm.com>
        <20180830041017.GA27378@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 21:10:17 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Aug 29, 2018 at 08:22:16PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 29, 2018 at 10:00:26PM -0400, Steven Rostedt wrote:  
> > > On Wed, 29 Aug 2018 15:38:30 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >   
> > > > Hello!
> > > > 
> > > > This commit does RCU-consolidation cleanups that get rid of pointers to
> > > > the sole remaining rcu_state structure:
> > > > 
> > > > 1-40:	Remove the "rsp" parameter from numerous functions, given that
> > > > 	the corresponding argument will always be &rcu_state.  
> > > 
> > > Hmm, couldn't 1-40 have been made into a single patch?  
> > 
> > They could.  I separated them to make finding the inevitable typos easier.
> > But at this point, it is easy enough to squash them together, though.  
> 
> And please see below for what the resulting diff would look like.  Is
> this an improvement?

Somewhat...

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> index f5120a00f511..772c26a3865a 100644
> --- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> +++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html

I would just keep the documentation patches separate.

-- Steve


> @@ -1372,8 +1372,7 @@ that is, if the CPU is currently idle.
>  Accessor Functions</a></h3>
>  
>  <p>The following listing shows the
> -<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt>,
> -<tt>rcu_for_each_nonleaf_node_breadth_first()</tt>, and
> +<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt> and
>  <tt>rcu_for_each_leaf_node()</tt> function and macros:
>  
>  
