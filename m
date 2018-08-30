Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A1FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F13205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F13205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeH3I12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:27:28 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54218 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeH3I12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:27:28 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 259E03A5A29
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 06:20:19 +0200 (CEST)
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 68622240003;
        Thu, 30 Aug 2018 04:20:10 +0000 (UTC)
Date:   Wed, 29 Aug 2018 21:20:07 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/52] Remove rcu_state pointers for
 v4.20/v5.0
Message-ID: <20180830042006.GA23159@localhost>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
 <20180829220026.3579e9a1@vmware.local.home>
 <20180830032216.GF4225@linux.vnet.ibm.com>
 <20180830041017.GA27378@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830041017.GA27378@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:10:17PM -0700, Paul E. McKenney wrote:
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

Honestly, as long as the result after each commit compiles, I prefer the
split version for ease of review.
