Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeBXI7K (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 03:59:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42104 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeBXI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 03:59:09 -0500
Date: Sat, 24 Feb 2018 09:59:11 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
cc: Borislav Petkov <bp@alien8.de>,
        Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
In-Reply-To: <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de> <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de> <20180223190950.GJ4981@pd.tnic> <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2018, Paul Menzel wrote:
> Am 23.02.2018 um 20:09 schrieb Borislav Petkov:
> > On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
> > > Borislav is seeing similar issues on larger AMD machines. The interrupt
> > > seems to come from BIOS/microcode during bringup of secondary CPUs and we
> > > have no idea why.
> > 
> > Paul, can you boot 4.14 and grep your dmesg for something like:
> > 
> > [    0.000000] spurious 8259A interrupt: IRQ7. >
> > ?
> 
> No, I do not see that. Please find the logs attached.

>From your 4.14 log:

Feb 19 09:48:06.843173 kodi kernel: CPU 0 irqstacks, hard=e9b0a000 soft=e9b0c000
Feb 19 09:48:06.843216 kodi kernel: spurious 8259A interrupt: IRQ7.
Feb 19 09:48:06.843258 kodi kernel: Console: colour VGA+ 80x25

So this has been there in 4.14 already just the detection mechanism has
changed due to the modifications of the interrupt vector management code.
It's not a real issue, just annoying ....

Thanks,

	tglx
