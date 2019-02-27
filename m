Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40E42084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfB0LEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:04:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48519 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfB0LEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:04:09 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gyx0O-0001pm-6a; Wed, 27 Feb 2019 12:04:04 +0100
Date:   Wed, 27 Feb 2019 12:04:04 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 23/32] softirq: Remove stale comment
Message-ID: <20190227110403.sy4djsxtukd6wasp@linutronix.de>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-24-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212171423.8308-24-frederic@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-12 18:14:14 [+0100], Frederic Weisbecker wrote:
> __local_bh_disable_ip() is neither for strict internal use nor does it
> require the caller to disable hardirqs. Probaby a celebration for ancient

Probaby

> behaviour.

I think the point was to override the IP for the tracer. So everyone
else used local_bh_disable() and was recorded as the caller except for
softirq.c internal usage where __do_softirq() did also
"local_bh_disable()" but recorded its caller (instead recording
__do_softirq()).

Sebastian
