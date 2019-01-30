Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E25C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E620869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfA3MBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:01:22 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfA3MBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:01:21 -0500
Received: from [2a01:598:b890:92b7:fc90:b8ff:fed0:1fb6] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gooYN-0006eP-8J; Wed, 30 Jan 2019 13:01:15 +0100
Date:   Wed, 30 Jan 2019 13:01:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] futex: Handle early deadlock return correctly
In-Reply-To: <alpine.DEB.2.21.1901292311410.1950@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901301259520.5537@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129084904.GB28485@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901292311410.1950@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Thomas Gleixner wrote:
>  int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
>  			      struct rt_mutex_waiter *waiter,
>  			      struct task_struct *task)
>  {
>  	int ret;
>  
> +	lockdep_asssert_held(&lock->wait_lock);

I'm a moron. I fixed that on the test box and wrote the changelog on the
laptop. Syncing the two together was too much for my futex wreckaged brain
...

