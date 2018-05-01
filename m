Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755633AbeEAM7n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:59:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755015AbeEAM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:59:42 -0400
Date: Tue, 1 May 2018 14:59:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-15?Q?J=F6rg_Otte?= <jrg.otte@gmail.com>
cc: kirill.shutemov@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2
 mitigation.
In-Reply-To: <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com> <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de> <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-285914814-1525179579=:1596"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-285914814-1525179579=:1596
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 1 May 2018, Jörg Otte wrote:
> 2018-04-30 21:53 GMT+02:00 Thomas Gleixner <tglx@linutronix.de>:
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -848,6 +848,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
> >                 c->x86_power = edx;
> >         }
> >
> > +       if (c->extended_cpuid_level >= 0x80000008) {
> > +               cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> > +               c->x86_capability[CPUID_8000_0008_EBX] = ebx;
> > +       }
> > +
> >         if (c->extended_cpuid_level >= 0x8000000a)
> >                 c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
> >
> 
> No, does not fix it.

Then I really have no idea how reverting the patch you pointed out would
fix it.

Thanks,

	tglx
--8323329-285914814-1525179579=:1596--
