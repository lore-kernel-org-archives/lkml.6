Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeAaHVj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:21:39 -0500
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:38472 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751001AbeAaHVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:21:38 -0500
Date: Wed, 31 Jan 2018 09:21:34 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: 4.15: WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244
 __irq_startup+0x80/0x100
In-Reply-To: <alpine.DEB.2.20.1801301935410.1797@nanos>
Message-ID: <alpine.LRH.2.21.1801302127080.11640@math.ut.ee>
References: <alpine.LRH.2.21.1801291809460.13788@math.ut.ee> <alpine.DEB.2.20.1801291732092.1849@nanos> <alpine.DEB.2.20.1801301935410.1797@nanos>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Your supply of vintage hardware is amazing.

:-)

> Does the patch below fix the issue for you?

  CC      kernel/irq/autoprobe.o
kernel/irq/autoprobe.c: In function ¡probe_irq_on¢:
kernel/irq/autoprobe.c:74:8: error: void value not ignored as it ought to be
    if (irq_activate_and_startup(desc, IRQ_NORESEND))
        ^~~~~~~~~~~~~~~~~~~~~~~~
Just 
irq_activate_and_startup(desc, IRQ_NORESEND);

cures the warning and at least the first bootup was working otherwise 
too.

-- 
Meelis Roos (mroos@linux.ee)
