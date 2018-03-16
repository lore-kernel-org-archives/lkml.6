Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCPL7H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:59:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55517 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeCPL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:59:06 -0400
Date: Fri, 16 Mar 2018 12:58:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 03/36] mm: use do_futex() instead of sys_futex() in
 mm_release()
In-Reply-To: <20180315190529.20943-4-linux@dominikbrodowski.net>
Message-ID: <alpine.DEB.2.21.1803161258290.1598@nanos.tec.linutronix.de>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <20180315190529.20943-4-linux@dominikbrodowski.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Dominik Brodowski wrote:

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

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
