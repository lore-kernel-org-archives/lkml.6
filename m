Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeCIKUo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:20:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeCIKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:20:29 -0500
Date: Fri, 9 Mar 2018 11:20:12 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Palmer Dabbelt <palmer@sifive.com>
cc: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Subject: Re: Make set_handle_irq and handle_arch_irq generic, v3
In-Reply-To: <20180307235731.22627-1-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.1803091113460.1364@nanos.tec.linutronix.de>
References: <20180307235731.22627-1-palmer@sifive.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018, Palmer Dabbelt wrote:

> This is my third version of this patch set, but the original cover
> letter is still the most relevant description I can come up with.
> 
>     This patch set has been sitting around for a while, but it got a bit lost
>     in the shuffle.  In RISC-V land we currently couple do_IRQ (the C entry
>     point for interrupt handling) to our first-level interrupt controller.
>     While this isn't completely crazy (as the first-level interrupt controller
>     is specified by the ISA), it is a bit awkward.
> 
>     This patch set decouples our trap handler from our first-level IRQ chip
>     driver by copying what a handful of other architectures are doing.  This
>     does add an additional load to the interrupt handling path, but there's a
>     handful of performance problems in there that I've been meaning to look at
>     so I don't mind adding another one for now.  The advantage is that our
>     irqchip driver is decoupled from our arch port, at least at compile time.
> 
> I've build tested this with defconfigs on all the modified architectures
> after both patch 1 and 5.  I've left the old acks in for the later
> patches as the patch set has changed very little since I last submitted
> it.

This looks sensible. We have two options for getting this merged:

1)   I'll take the whole lot through tip/irq/core

2)   I'll apply patch 1/N to a special branch in tip. That branch will contain
     only this commit on top of 4.16-rc4 and can be pulled by the relevant
     architecture maintainers, so they can apply their architecture specific
     patches.

Please let me know how you want to proceed.

Thanks,

	tglx
