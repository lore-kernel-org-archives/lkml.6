Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeEOITL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:19:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeEOITI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:19:08 -0400
Date: Tue, 15 May 2018 09:18:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 08/18] arm64: convert raw syscall invocation to C
Message-ID: <20180515081839.aenqaruro5me42av@salmiak>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-9-mark.rutland@arm.com>
 <20180514180029.GA23250@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514180029.GA23250@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 08:00:29PM +0200, Dominik Brodowski wrote:
> > +static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
> > +{
> > +	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
> > +				   regs->regs[2], regs->regs[3],
> > +				   regs->regs[4], regs->regs[5]);
> > +}
> 
> Any specific reason to have this in a separate function? This seems to be
> called only from one instance, namely

I wanted to keep the raw syscall invocation logically separate from the syscall
table lookup and ni_syscall fallback, so that it was easier to verify in isolation.

I don't think it's a big deal either way, though.

Thanks,
Mark.
