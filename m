Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755615AbeBOUYw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:24:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeBOUYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:24:51 -0500
Date: Thu, 15 Feb 2018 21:24:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lina Iyer <ilina@codeaurora.org>
cc: jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH v6 1/2] drivers: irqchip: pdc: Add PDC interrupt controller
 for QCOM SoCs
In-Reply-To: <20180215202141.GC23714@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1802152122480.1296@nanos.tec.linutronix.de>
References: <20180209165735.19151-1-ilina@codeaurora.org> <20180209165735.19151-2-ilina@codeaurora.org> <alpine.DEB.2.21.1802121430020.1158@nanos.tec.linutronix.de> <20180215202141.GC23714@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Lina Iyer wrote:
> On Mon, Feb 12 2018 at 13:40 +0000, Thomas Gleixner wrote:
> > On Fri, 9 Feb 2018, Lina Iyer wrote:
> > > +enum pdc_irq_config_bits {
> > > +	PDC_POLARITY_LOW	= 0,
> > > +	PDC_FALLING_EDGE	= 2,
> > > +	PDC_POLARITY_HIGH	= 4,
> > > +	PDC_RISING_EDGE		= 6,
> > > +	PDC_DUAL_EDGE		= 7,
> > 
> > My previous comment about using binary constants still stands. Please
> > either address review comments or reply at least. Ignoring reviews is not
> > an option.
> > 
> > Aside of that I really have to ask about the naming of these constants. Are
> > these names hardware register nomenclature? If yes, they are disgusting. If
> > no, they are still disgusting, but should be changed to sensible ones,
> > which just match the IRQ_TYPE naming convention.
> > 
> >    PDC_LEVEL_LOW	= 000b,
> >    PDC_EDGE_FALLING	= 010b,
> >    ....
> > 
> > 
> Checkpatch doesn't like binary constants. I guess I will need to keep
> the enum definitions in hex or decimal. I will remove the binary from
> the comments though.

Well checkpatch is not always right.

> 
> commit 95e2c6023b0e4c8499fb521697f79215f69135fe
> Author: Joe Perches <joe@perches.com>
> Date:   Wed Jul 3 15:05:20 2013 -0700
> 
>    checkpatch: warn when using gcc's binary constant ("0b") extension
> 
>    The gcc extension for binary constants that start with 0b is only
>    supported with gcc version 4.3 or higher.

Can anything of this be compiled with gcc < 4.3?  

Thanks,

	tglx
