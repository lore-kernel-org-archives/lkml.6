Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCPSnz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:43:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCPSny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:43:54 -0400
Date: Fri, 16 Mar 2018 11:43:48 -0700
From: Darren Hart <dvhart@infradead.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 03/36] mm: use do_futex() instead of sys_futex() in
 mm_release()
Message-ID: <20180316184348.GA20184@localhost.localdomain>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-4-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315190529.20943-4-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 08:04:56PM +0100, Dominik Brodowski wrote:
> sys_futex() is a wrapper to do_futex() which does not modify any
> values here:
> 
> - uaddr, val and val3 are kept the same
> 
> - op is masked with FUTEX_CMD_MASK, but is always set to FUTEX_WAKE.
>   Therefore, val2 is always 0.
> 
> - as utime is set to NULL, *timeout is NULL
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Hi Dominik,

I'm missing the "why" part here. What is it you are trying to address?

do_futex is not currently in use outside of the futex implementation,
while sys_futex is. This decouples the interface from the
implementation. While this is perhaps less critical within the
kernel, I don't see a compelling reason to increase the coupling
between the mm and futex implementations.

Without a compelling WHY, Nack from me.

-- 
Darren Hart
VMware Open Source Technology Center
