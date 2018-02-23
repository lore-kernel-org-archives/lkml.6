Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBWSSZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:18:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41535 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeBWSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:18:24 -0500
Date: Fri, 23 Feb 2018 19:18:34 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>
cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
In-Reply-To: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Fri, 23 Feb 2018, Paul Menzel wrote:
> 
> On the ASRock E350M1 (AMD A50M), since Linux 4.15 I get the message below.
> 
>     do_IRQ: 1.55 No irq handler for vector

Thanks for the report, but the single line of dmesg w/o any context is not
really helpful. Can you please provide a larger piece of dmesg which shows
in which context this happens.

I assume that this happens during early boot right when CPU1 is brought up,
right?

Borislav is seeing similar issues on larger AMD machines. The interrupt
seems to come from BIOS/microcode during bringup of secondary CPUs and we
have no idea why.

Thanks,

	tglx
