Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13C9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C4F20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C4F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIERhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeIERhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:37:17 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26910206BA;
        Wed,  5 Sep 2018 13:07:04 +0000 (UTC)
Date:   Wed, 5 Sep 2018 09:07:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, joel@joelfernandes.org
Subject: Re: 4.19-rc1: ./include/linux/rcupdate.h:631 rcu_read_lock() used
 illegally while idle!
Message-ID: <20180905090702.339d94b2@gandalf.local.home>
In-Reply-To: <20180905125941.GE4225@linux.vnet.ibm.com>
References: <20180901173559.GC26871@zn.tnic>
        <20180901175442.GO4225@linux.vnet.ibm.com>
        <20180901184531.72ffb792@vmware.local.home>
        <20180902041639.GQ4225@linux.vnet.ibm.com>
        <20180904162611.6a120068@gandalf.local.home>
        <20180904205321.GQ4225@linux.vnet.ibm.com>
        <20180905082254.GA2237@zn.tnic>
        <20180905125941.GE4225@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 05:59:41 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Sep 05, 2018 at 10:22:54AM +0200, Borislav Petkov wrote:
> > On Tue, Sep 04, 2018 at 01:53:21PM -0700, Paul E. McKenney wrote:  
> > > I must defer to Borislav on this one.  Assuming it has the desired
> > > effect, I am good with it.  
> > 
> > It did survive a bunch of reboots (the WARN would fire after boot
> > finishes, normally) so I guess we can run with it and see how it works
> > out in the next couple of weeks.
> > 
> > Thanks guys!  
> 
> Woo-hoo!!!  Thank you for testing this!

OK, I'll make this into an official patch and put it into my test
suite. I should be able to push it out to Linus tomorrow.

-- Steve

