Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334C3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C815020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C815020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeH3TpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH3TpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:45:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1EF20658;
        Thu, 30 Aug 2018 15:42:19 +0000 (UTC)
Date:   Thu, 30 Aug 2018 11:42:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/52] Remove rcu_state pointers for
 v4.20/v5.0
Message-ID: <20180830114218.39743075@gandalf.local.home>
In-Reply-To: <20180830042006.GA23159@localhost>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
        <20180829220026.3579e9a1@vmware.local.home>
        <20180830032216.GF4225@linux.vnet.ibm.com>
        <20180830041017.GA27378@linux.vnet.ibm.com>
        <20180830042006.GA23159@localhost>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 21:20:07 -0700
Josh Triplett <josh@joshtriplett.org> wrote:


> > And please see below for what the resulting diff would look like.  Is
> > this an improvement?  
> 
> Honestly, as long as the result after each commit compiles, I prefer the
> split version for ease of review.

You and I have different preferences for reviewing changes like this ;-)

I prefer the one patch (I do think it is an improvement). It's all
basically the exact same change. Looking at 40 different patches is
much more work IMHO, then just looking at a single patch, and testing
it, then testing 40 different patches. That's a lot of compiling.

I usually stop reviewing after 10 patches of the same kind, as I run
out of time to review them.

-- Steve
