Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeC0Pik (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:38:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeC0Pij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:38:39 -0400
Date: Tue, 27 Mar 2018 17:38:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Palmer Dabbelt <palmer@sifive.com>
cc: Arnd Bergmann <arnd@arndb.de>, fengguang.wu@intel.com,
        kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error:
 implicit declaration of function 'set_handle_irq'; did you mean
 'vic_handle_irq'?
In-Reply-To: <mhng-71f262e9-b9a8-4dd8-9657-955d76aab956@palmer-si-x1c4>
Message-ID: <alpine.DEB.2.21.1803271734170.1964@nanos.tec.linutronix.de>
References: <mhng-71f262e9-b9a8-4dd8-9657-955d76aab956@palmer-si-x1c4>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Palmer Dabbelt wrote:
> On Mon, 26 Mar 2018 22:27:36 PDT (-0700), tglx@linutronix.de wrote:
> > 
> > The commits in tip right now are:
> > 
> >   cc6c98485f8e ("RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler")
> >   caacdbf4aa56 ("genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER")
> > 
> > I surely can revert them, but I don't see how they would break arm or
> > anything else.
> 
> If GENERIC_IRQ_MULTI_HANDLER is set via randconfig then set_handle_irq() is
> pulled in from the generic code, which conflicts with the definitions in arm,
> arm64, and openrisc.  The RISC-V commit depends on the genirq one.

Two ways to fix that:

 - Rename set_handle_irq() in tip:irq/core and then convert the rest of the
   tree over. A few more files touched, but nothing harmful

 - Make GENERIC_IRQ_MULTI_HANDLER depend on !IRQ_MULTI_HANDLER. That should
   cure it as well

Thanks,

	tglx
