Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B17C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E94208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E94208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeGaP0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732127AbeGaP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:26:43 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E3A2083D;
        Tue, 31 Jul 2018 13:46:18 +0000 (UTC)
Date:   Tue, 31 Jul 2018 09:46:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        ying.huang@intel.com, mingo@kernel.org, jiangshanlai@gmail.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        len.brown@intel.com, glider@google.com, peter@hurleysoftware.com,
        aik@ozlabs.ru
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction
 before traversing
Message-ID: <20180731094616.6d70c130@gandalf.local.home>
In-Reply-To: <20180731093809.GC12241@X58A-UD3R>
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
        <20180731085257.GR2494@hirez.programming.kicks-ass.net>
        <20180731093809.GC12241@X58A-UD3R>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 18:38:09 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> On Tue, Jul 31, 2018 at 10:52:57AM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 31, 2018 at 09:58:36AM +0900, Byungchul Park wrote:  
> > > In restrictive cases like only addtions happen but never deletion, can't
> > > we safely traverse a llist? I believe llist can be more useful if we can
> > > release the restriction. Can't we?  
> > 
> > Yes you can, but I'm not sure it makes much sense to confuse the
> > comments with this.
> > 
> > This really ends up in the 'you had better know what you're doing'
> > category.  
> 
> Partially agree with you. But why not add more explanation?
> 
> If you think the comment confuse us, then it's ok to keep it itself.
> 

It appears that you will only have your own users that will be doing
this, correct? How many use cases have no deletion? I wouldn't change
the generic comments on llist for something that's a one off and hardly
used.

-- Steve
