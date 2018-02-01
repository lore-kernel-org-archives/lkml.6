Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeBAJ4f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:56:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBAJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:56:33 -0500
Date: Thu, 1 Feb 2018 10:56:13 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Meelis Roos <mroos@linux.ee>,
        Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [tip:irq/urgent] genirq: Make legacy autoprobing work again
In-Reply-To: <CAMuHMdUfGUXmjFdyjLdBiyOayy22p-91Oonp-hK4x0hqcOnPUA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1802011055240.1472@nanos.tec.linutronix.de>
References: <alpine.DEB.2.20.1801301935410.1797@nanos> <tip-55595980acc3232b018ba30df8ee6e0ac40ad184@git.kernel.org> <CAMuHMdUfGUXmjFdyjLdBiyOayy22p-91Oonp-hK4x0hqcOnPUA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2018, Geert Uytterhoeven wrote:
> On Wed, Jan 31, 2018 at 10:54 AM, tip-bot for Thomas Gleixner
> > -void irq_activate_and_startup(struct irq_desc *desc, bool resend)
> > +int irq_activate_and_startup(struct irq_desc *desc, bool resend)
> >  {
> >         if (WARN_ON(irq_activate(desc)))
> >                 return;
> 
> As reported by 0day, this should return something.
> 
> if CONFIG_IRQ_DOMAIN=n or CONFIG_IRQ_DOMAIN_HIERARCHY=n,
> irq_activate() will never return 1, and the code path can be eliminated.
> 
> BTW, is gcc becoming too smart, and already eliminating code before it
> generates warnings for it? Recently I've seen some other cases where buggy
> code was not warned about, as it was considered not having any impact.

Looks like. Fixed it up.

Thanks,

	tglx
