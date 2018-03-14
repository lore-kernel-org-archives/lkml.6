Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCNTfd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:35:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:35:32 -0400
Date: Wed, 14 Mar 2018 20:35:29 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH 0/3] irqchip: GIC kexec/kdump improvement and
 workarounds
In-Reply-To: <8e20eae8-aa9f-28a4-3e7d-3d8ec71b2953@arm.com>
Message-ID: <alpine.DEB.2.21.1803142034130.1946@nanos.tec.linutronix.de>
References: <20180313172103.24281-1-marc.zyngier@arm.com> <20180313175156.gmncij4rnqcdl5ie@lakrids.cambridge.arm.com> <72c7a6d2-a4c4-26b2-2982-c1d1ffb39b81@arm.com> <20180314165708.daoui66waxvicciq@lakrids.cambridge.arm.com> <alpine.DEB.2.21.1803141808350.2481@nanos.tec.linutronix.de>
 <8e20eae8-aa9f-28a4-3e7d-3d8ec71b2953@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Marc Zyngier wrote:
> On 14/03/18 17:11, Thomas Gleixner wrote:
> > Makes sense. Do we have any indicator that tells us that a particular irq
> > chip is missing something in the init code or do we have to rely on crash
> > reports?
> A way to work out what is potentially missing would be to make sure that
> whatever we're removing from machine_kexec_mask_interrupts, we can find
> it in the irqchip init code. Not an easy task, and certainly not perfect
> (patches 1 and 2 in this series have no equivalent in the kexec code).
> 
> There is still another category of "reset" stuff that belongs to the
> teardown path, and that's for things that may have an impact on the
> secondary kernel.
> 
> The case I have in mind is that of the GIC LPI pending tables. These are
> allocated to the GIC, which can write pending bits at any time. Think of
> it as a DMA engine. At the moment we enter the secondary kernel, we must
> make sure the GIC has already been shut down, as the table memory will
> be reallocated.

Yes, you surely need to prevent that.

Thanks,

	tglx
