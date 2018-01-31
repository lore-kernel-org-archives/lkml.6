Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeAaH6e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:58:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeAaH6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:58:33 -0500
Date: Wed, 31 Jan 2018 08:58:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Meelis Roos <mroos@linux.ee>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: 4.15: WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244
 __irq_startup+0x80/0x100
In-Reply-To: <alpine.LRH.2.21.1801302127080.11640@math.ut.ee>
Message-ID: <alpine.DEB.2.20.1801310856390.2293@nanos>
References: <alpine.LRH.2.21.1801291809460.13788@math.ut.ee> <alpine.DEB.2.20.1801291732092.1849@nanos> <alpine.DEB.2.20.1801301935410.1797@nanos> <alpine.LRH.2.21.1801302127080.11640@math.ut.ee>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-26527525-1517385512=:2293"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-26527525-1517385512=:2293
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Wed, 31 Jan 2018, Meelis Roos wrote:
> > > Your supply of vintage hardware is amazing.
> 
> :-)
> 
> > Does the patch below fix the issue for you?
> 
>   CC      kernel/irq/autoprobe.o
> kernel/irq/autoprobe.c: In function ¡probe_irq_on¢:
> kernel/irq/autoprobe.c:74:8: error: void value not ignored as it ought to be
>     if (irq_activate_and_startup(desc, IRQ_NORESEND))
>         ^~~~~~~~~~~~~~~~~~~~~~~~

Duh.

> Just 
> irq_activate_and_startup(desc, IRQ_NORESEND);

Indeed. 

> cures the warning and at least the first bootup was working otherwise 
> too.

I'll do a proper fix and queue it so your museum is kept alive.

Thanks,

	tglx
--8323329-26527525-1517385512=:2293--
