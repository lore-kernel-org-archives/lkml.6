Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A785ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B40120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B40120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKIBl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:41:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKIBl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:41:28 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKmo1-0003Rg-JB; Thu, 08 Nov 2018 17:05:17 +0100
Date:   Thu, 8 Nov 2018 17:05:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rcu: make RCU_BOOST default on RT
Message-ID: <20181108160517.qnibb5yve7nlpzdq@linutronix.de>
References: <20181101232518.GA12385@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101232518.GA12385@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 16:25:18 [-0700], Paul E. McKenney wrote:
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -36,7 +36,7 @@ config TINY_RCU
> >  
> >  config RCU_EXPERT
> >  	bool "Make expert-level adjustments to RCU configuration"
> > -	default n
> > +	default y if PREEMPT_RT_FULL
> 
> Would it work to leave this as is, and ...
> 
> >  	help
> >  	  This option needs to be enabled if you wish to make
> >  	  expert-level adjustments to RCU configuration.  By default,
> > @@ -191,7 +191,7 @@ config RCU_FAST_NO_HZ
> >  config RCU_BOOST
> >  	bool "Enable RCU priority boosting"
> >  	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
> 
> ... make the above line instead be:
> 
>   	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT_FULL
> 
> Or am I missing something?
> 
> I agree that the risk might currently seem small, but if Linus ever
> starts building PREEMPT_RT_FULL kernels, I really really do not want
> RCU_EXPERT to be set.  ;-)

okay, this would work. Let me teak this in my current tree.

> 								Thanx, Paul

Sebastian
