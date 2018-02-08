Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBHSpM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:45:12 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47862 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHSpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:45:11 -0500
Date: Thu, 08 Feb 2018 13:45:06 -0500 (EST)
Message-Id: <20180208.134506.1374787894560277876.davem@davemloft.net>
To: bigeasy@linutronix.de
Cc: frederic@kernel.org, linux-kernel@vger.kernel.org,
        alexander.levin@verizon.com, peterz@infradead.org,
        mchehab@s-opensource.com, torvalds@linux-foundation.org,
        hannes@stressinduktion.org, paulmck@linux.vnet.ibm.com,
        wanpeng.li@hotmail.com, dima@arista.com, tglx@linutronix.de,
        akpm@linux-foundation.org, pabeni@redhat.com, rrendec@arista.com,
        mingo@kernel.org, sgruszka@redhat.com, riel@redhat.com,
        edumazet@google.com
Subject: Re: [RFC PATCH 2/4] softirq: Per vector deferment to workqueue
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
References: <1516376774-24076-1-git-send-email-frederic@kernel.org>
        <1516376774-24076-3-git-send-email-frederic@kernel.org>
        <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 8 Feb 2018 18:44:52 +0100

> May I instead suggest to stick to ksoftirqd? So you run in softirq
> context (after return from IRQ) and if takes too long, you offload the
> vector to ksoftirqd instead. You may want to play with the metric on
> which you decide when you want switch to ksoftirqd / account how long a
> vector runs.

Having read over this stuff for the past few weeks this is how I feel
as well.  Just make ksofbitrq do what we want (only execute the
overloaded softirq vectors).

The more I look at the workqueue stuff, the more complications and
weird behavioral artifacts we are getting for questionable gain.
