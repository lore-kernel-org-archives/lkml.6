Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C412087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C412087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJJSiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:38:18 -0400
Received: from ms01.santannapisa.it ([193.205.80.99]:52644 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:38:17 -0400
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133570418; Wed, 10 Oct 2018 13:16:36 +0200
Date:   Wed, 10 Oct 2018 13:16:29 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181010131629.6623ddb4@luca64>
In-Reply-To: <20181010105710.GP5728@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
        <20181010123417.26c682ef@luca64>
        <20181010105710.GP5728@hirez.programming.kicks-ass.net>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 12:57:10 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 10, 2018 at 12:34:17PM +0200, luca abeni wrote:
> > So, I would propose to make the proxy() function of patch more
> > generic, and not strictly bound to mutexes. Maybe a task structure
> > can contain a list of tasks for which the task can act as a proxy,
> > and we can have a function like "I want to act as a proxy for task
> > T" to be invoked when a task blocks?  
> 
> Certainly possible, but that's something I'd prefer to look at after
> it all 'works'.

Of course :)
I was mentioning this idea because maybe it can have some impact on the
design.

BTW, here is another "interesting" issue I had in the past with changes
like this one: how do we check if the patchset works as expected?

"No crashes" is surely a requirement, but I think we also need some
kind of testcase that fails if the inheritance mechanism is not working
properly, and is successful if the inheritance works.

Maybe we can develop some testcase based on rt-app (if noone has such a
testcase already)


			Thanks,
				Luca
> The mutex blocking thing doesn't require external
> interfaces etc..

