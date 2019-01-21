Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BDC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E3120989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfAUMCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:02:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64468 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfAUMCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:02:19 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 551810c34f8d6cbe; Mon, 21 Jan 2019 13:02:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hugo Lefeuvre <hle@owl.eu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Date:   Mon, 21 Jan 2019 13:01:20 +0100
Message-ID: <1854135.8TqAkcxCUf@aspire.rjw.lan>
In-Reply-To: <20190118160450.GG14054@worktop.programming.kicks-ass.net>
References: <20190117224135.GC8100@hle-laptop.local> <20190118151941.GB187589@google.com> <20190118160450.GG14054@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 18, 2019 5:04:50 PM CET Peter Zijlstra wrote:
> On Fri, Jan 18, 2019 at 10:19:41AM -0500, Joel Fernandes wrote:
> > You should document the variable names in the header comments.
> > 
> > Also, this new API appears to conflict with definition of 'freezable' in
> > wait_event_freezable I think,
> > 
> > wait_event_freezable - sleep or freeze until condition is true.
> > 
> > wait_event_freezable_hrtimeout - sleep but make sure freezer is not blocked.
> > (your API)
> > 
> > It seems to me these are 2 different definitions of 'freezing' (or I could be
> > completely confused). But in the first case it calls try_to_freeze after
> > schedule(). In the second case (your new API), it calls freezable_schedule().
> > 
> > So I am wondering why is there this difference in the 'meaning of freezable'.
> > In the very least, any such subtle differences should be documented in the
> > header comments IMO.
> 
> Also; someone was recently hating on the whole freezing thing (again,
> and rightfully). I just cannot remember who; Rafael you remember?

Nope.


