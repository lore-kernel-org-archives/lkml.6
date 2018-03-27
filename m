Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeC0F1x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:27:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeC0F1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:27:52 -0400
Date: Tue, 27 Mar 2018 07:27:36 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Palmer Dabbelt <palmer@sifive.com>
cc: Arnd Bergmann <arnd@arndb.de>, fengguang.wu@intel.com,
        kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error:
 implicit declaration of function 'set_handle_irq'; did you mean
 'vic_handle_irq'?
In-Reply-To: <mhng-ca8cf5ce-3363-405e-ab78-bbbe4f79dbcd@palmer-si-x1c4>
Message-ID: <alpine.DEB.2.21.1803270726140.1537@nanos.tec.linutronix.de>
References: <mhng-ca8cf5ce-3363-405e-ab78-bbbe4f79dbcd@palmer-si-x1c4>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018, Palmer Dabbelt wrote:
> On Mon, 26 Mar 2018 01:07:54 PDT (-0700), Arnd Bergmann wrote:
> > On Tue, Mar 20, 2018 at 6:52 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> > > On Tue, 20 Mar 2018 00:53:21 PDT (-0700), tglx@linutronix.de wrote:
> > > > 
> > > > On Tue, 20 Mar 2018, kbuild test robot wrote:
> > > > 
> > > > > Hi Palmer,
> > > > > 
> > > > > FYI, the error/warning still remains.
> > > > 
> > > > 
> > > > Zapped the commit as well...
> > > 
> > > 
> > > Sorry, I got the flu at ELC and have been offline for a bit.  It looks
> > > like
> > > you've kept the IRQ and RISC-V patches, I'll fix up the others are
> > > re-submit
> > > them as a separate patch set.
> > 
> > Not sure which patches are in flight at the moment. To get a clean build
> > on arm32 and arm64 randconfig kernels, I needed the fixup below
> > on top of linux-next (not meant to be applied like this, just for
> > reference).
> 
> Thanks, I missed these during my original patch submission.  I think the
> cleanest way to submit this is to spin a whole new patch set, including those
> that are already in tip.  Would it be possible to just remove my IRQ cleanups
> from tip so I can try again?

The commits in tip right now are:

  cc6c98485f8e ("RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler")
  caacdbf4aa56 ("genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER")

I surely can revert them, but I don't see how they would break arm or
anything else.

Thanks,

	tglx
