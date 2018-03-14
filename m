Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeCNTgf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:36:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNTge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:36:34 -0400
Date: Wed, 14 Mar 2018 20:36:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Palmer Dabbelt <palmer@sifive.com>
cc: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/5] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <mhng-154bcacc-ddfa-4875-b5c5-e3efc72f3e42@palmer-si-x1c4>
Message-ID: <alpine.DEB.2.21.1803142035520.1946@nanos.tec.linutronix.de>
References: <mhng-154bcacc-ddfa-4875-b5c5-e3efc72f3e42@palmer-si-x1c4>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Palmer Dabbelt wrote:
> On Wed, 14 Mar 2018 10:07:35 PDT (-0700), tglx@linutronix.de wrote:
> > On Wed, 7 Mar 2018, Palmer Dabbelt wrote:
> > 
> > > This converts the ARM port to use the recently added
> > > GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
> > > existhing MULTI_IRQ_HANDLER.  The only changes are:
> > > 
> > > * handle_arch_irq is now defined in a generic C file instead of an
> > >   arm-specific assembly file.
> > > * handle_arch_irq is not marked as __ro_after_init.
> > 
> > Why? What prevents the generic implementation from doing so?
> 
> Sorry, I guess that should have said "handle_arch_irq was not marked as
> __ro_after_init".  The patch set has __ro_after_init for the generic
> implementation, which was not the case for the arm version.

That makes sense.... I'll fix that up.

Thanks,

	tglx
