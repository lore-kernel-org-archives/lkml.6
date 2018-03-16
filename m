Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbeCPOr7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:47:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56101 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeCPOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:47:58 -0400
Date: Fri, 16 Mar 2018 15:47:55 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>,
        x86@kernel.org
Subject: Re: [PATCH v2 13/36] x86/ioport: add ksys_ioperm() helper; remove
 in-kernel calls to sys_ioperm()
In-Reply-To: <20180316144554.GC14069@light.dominikbrodowski.net>
Message-ID: <alpine.DEB.2.21.1803161547400.1598@nanos.tec.linutronix.de>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <20180315190529.20943-14-linux@dominikbrodowski.net> <alpine.DEB.2.21.1803161259530.1598@nanos.tec.linutronix.de> <20180316144554.GC14069@light.dominikbrodowski.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Dominik Brodowski wrote:
> On Fri, Mar 16, 2018 at 01:00:48PM +0100, Thomas Gleixner wrote:
> > On Thu, 15 Mar 2018, Dominik Brodowski wrote:
> > 
> > > Using this helper allows us to avoid the in-kernel calls to the sys_ioperm()
> > > syscall.
> > > 
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Jiri Slaby <jslaby@suse.com>
> > > Cc: x86@kernel.org
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > 
> > Please add a few lines explaining the ksys_ prefix as you did in your reply
> > to Christoph. Other than that:
> > 
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Thanks! The commit message now reads
> 
> 	Using this helper allows us to avoid the in-kernel calls to the sys_ioperm()
> 	syscall. The ksys_ prefix denotes that this function is meant as a drop-in
> 	replacement for the syscall. In particular, it uses the same calling
> 	convention as sys_ioperm().
> 
> Does that sound OK?

Looks good.

Thanks,

	tglx
