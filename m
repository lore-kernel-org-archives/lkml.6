Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE480C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AA820644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AA820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeH2Uqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:46:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47185 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2Uqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:46:55 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fv3eU-0000nZ-Pn; Wed, 29 Aug 2018 18:49:06 +0200
Date:   Wed, 29 Aug 2018 18:49:06 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/2] irqchip/gic-v3-its: Move ITS' ->pend_page allocation
 into an early CPU up callback
Message-ID: <20180829164906.q3wvue7s3x6tm2rh@linutronix.de>
References: <20180718154205.13704-1-bigeasy@linutronix.de>
 <20180718154205.13704-3-bigeasy@linutronix.de>
 <3302f069-8f4e-8d97-5166-0dec01b43c4c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3302f069-8f4e-8d97-5166-0dec01b43c4c@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-06 09:15:32 [+0100], Marc Zyngier wrote:
> Hi Sebastian,
Hi Marc,

> I must say I'm not overly keen on the extra hotplug notifier, and I'd
> rather allocate all the memory upfront on the boot CPU.
> 
> I've implemented this as part of a series that is required for
> kexec/kdump support[1] (and specifically this[2] patch). Could you
> please have a look and let me know if that works for you? I otherwise
> plan to post it for review once the 4.19 merge window has closed.

This looks good, thank you. I can't test this because I don't have a
GICv3 box atm. The last one I had died somehow.
I pull that patch into my next RT release and ask for some feedback.
One question: You have
	its_allocate_pending_table(GFP_NOWAIT);

for the allocation. Shouldn't GFP_KERNEL do the job, too? 

> Thanks,
> 
> 	M.

Sebastian
