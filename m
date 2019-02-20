Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9243420880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfBTPa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:30:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:30:58 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gwTpo-00079t-84; Wed, 20 Feb 2019 16:30:56 +0100
Date:   Wed, 20 Feb 2019 16:30:56 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
Subject: Re: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Message-ID: <20190220153055.dt7vm47c2auove3d@linutronix.de>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
 <20190219171905.qrpr5uurayfqbehp@linutronix.de>
 <20190220074751.GJ21785@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220074751.GJ21785@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-20 08:47:51 [+0100], Juri Lelli wrote:
> > In this case you prepare the wakeup and then wake the CPU anyway. There
> > should be no downside to this unless the housekeeping CPU is busy and in
> > irq-off regions which would increase the latency. Also in case of
> > 	cyclictest -d0
> > 
> > the one CPU would have to process all timers. So the latency will be
> > worse compared to every CPU does its own wakeup. And on RT you probably
> > do not want to do deep idle anyway.
> 
> Mmm, right. But, still very much dependent on the workload, I understand
> you are saying? So, no one size fits all solution.

Now that I slept over it, I think it makes sense from RT point of view
to always pin the timer. I'm not sure if we want to swap the sysctl or
make the PINNED change like you suggested.
 
> Thanks,
> 
> - Juri

Sebastian
