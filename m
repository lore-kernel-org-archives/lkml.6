Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeFELlt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:41:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbeFELlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:41:47 -0400
Date: Tue, 5 Jun 2018 13:41:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        stable@vger.kernel.org
Subject: Re: [patch 3/8] x86/apic: Provide apic_ack_irq()
In-Reply-To: <94117bd8-352b-1077-e8ae-8722d7ec213f@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1806051339020.1591@nanos.tec.linutronix.de>
References: <20180604162224.471925894@linutronix.de> <94117bd8-352b-1077-e8ae-8722d7ec213f@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018, Dou Liyang wrote:
> > +{
> > +	if (unlikely(irqd_is_setaffinity_pending(irqd)))
> 
> Affinity pending is also judged in
> 
> > +		irq_move_irq(irqd);
> 
> If we can remove the if(...) statement here

That requires to fix all call sites in ia64 and that's why I didn't.  But
we can make irq_move_irq() an inline function and have the check in the
inline.

Thanks,

	tglx
