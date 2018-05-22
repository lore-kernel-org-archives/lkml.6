Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeEVORq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:17:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40103 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeEVORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:17:44 -0400
Date: Tue, 22 May 2018 16:17:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        hpa@zytor.com
Subject: Re: [PATCH] x86/idt: Simplify the idt_setup_apic_and_irq_gates()
In-Reply-To: <e756f124-0690-ccdc-6dbd-9e1e68aef771@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1805221617080.1711@nanos.tec.linutronix.de>
References: <20180426054452.32308-1-douly.fnst@cn.fujitsu.com> <alpine.DEB.2.21.1805191424560.1599@nanos.tec.linutronix.de> <e756f124-0690-ccdc-6dbd-9e1e68aef771@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1887395153-1526998660=:1711"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1887395153-1526998660=:1711
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 22 May 2018, Dou Liyang wrote:

> Hi Thomas,
> 
> At 05/19/2018 08:32 PM, Thomas Gleixner wrote:
> > On Thu, 26 Apr 2018, Dou Liyang wrote:
> > 
> > > The vectors between FIRST_SYSTEM_VECTOR and NR_VECTORS are special IRQ
> > > vectors used by the SMP architecture. But, if X86_LOCAL_APIC=n, it will
> > > not be used, and the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS.
> > 
> > Correct, but that function has nothing to do with FIRST_SYSTEM_VECTOR.
> > 
> 
> Oops, sorry, when I reread, my changelog even made me misunderstand.
> the patch hided it.
> 
>     void __init idt_setup_apic_and_irq_gates(void)
>     ...
>         for_each_clear_bit_from(i, system_vectors, FIRST_SYSTEM_VECTOR)
>                                                    ^^^^^^^^^^^^^^^^^^^
>     ...
>         for_each_clear_bit_from(i, system_vectors, NR_VECTORS)
> 
> What I want to say is:
> 
>   In the APIC=n system, the FIRST_SYSTEM_VECTOR is equal to
>   NR_VECTORS, So all entries has been set by
> 
>     for_each_clear_bit_from(i, system_vectors, FIRST_SYSTEM_VECTOR)
>        ...
> 
>   the following setup code for APIC=n is redundant. Just setup gates for
>   APIC=y.
> 
> If it is OK, I will send v2.

Right you are. I got confused ....
--8323329-1887395153-1526998660=:1711--
