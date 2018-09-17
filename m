Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A86ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75787214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75787214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeIQNUj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:20:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeIQNUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:20:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g1oMN-00048I-Oz; Mon, 17 Sep 2018 09:54:19 +0200
Date:   Mon, 17 Sep 2018 09:54:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bernhard Landauer <oberon@manjaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: Re: [PATCH] Drivers: hv: vmbus: include header for get_irq_regs()
Message-ID: <20180917075418.e67gzam25zrkjpc4@linutronix.de>
References: <20180830075503.vh3qcdcnxcjobj55@linutronix.de>
 <CY4PR21MB0773BB754D1B949C43B591FCDC180@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CY4PR21MB0773BB754D1B949C43B591FCDC180@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-15 23:26:53 [+0000], Michael Kelley (EOSG) wrote:
> From Sebastian Andrzej Siewior   Sent: Thursday, August 30, 2018 12:55 AM
> > 
> > On !RT the header file get_irq_regs() gets pulled in via other header files. On
> > RT it does not and the build fails:
> > 
> >     drivers/hv/vmbus_drv.c:975 implicit declaration of function ‘get_irq_regs’ [-
> > Werror=implicit-function-declaration]
> >     drivers/hv/hv.c:115 implicit declaration of function ‘get_irq_regs’ [-Werror=implicit-
> > function-declaration]
> > 
> > Add the header file for get_irq_regs() in a common header so it used by
> > vmbus_drv.c by hv.c for their get_irq_regs() usage.
> > 
> 
> get_irq_regs() is not used explicitly in either vmbus_drv.c or in hv.c.  And I
> couldn't make the line numbers in the errors above line up with anything
> in the source code that might be implicitly using get_irq_regs().  Is it the
> calls to add_interrupt_randomness()?   Did you figure out
> exactly what line of code is causing the compile error?

The line mentioned in the patch, is correct. I just figured out that
function is added as part preempt-RT.

> I'm wondering whether adding the #include of irq.h into hyperv_vmbus.h
> is really the right solution.  More correct might be to have the file where
> get_irq_regs() is actually used to #include irq_regs.h.

nah, leave it. I'm sorry, that I haven't seen it earlier. I will submit
a complete patch once I get there. It popped during a stable update so I
assumed it was something that came via stable but it actually was there
the whole time. Again, sorry for the noise.

> Michael

Sebastian
