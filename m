Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeENVAq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:00:46 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33950 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeENVAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:00:45 -0400
Date: Mon, 14 May 2018 22:24:45 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/18] arm64: convert raw syscall invocation to C
Message-ID: <20180514202445.GA26773@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514125351.GK7753@e103592.cambridge.arm.com>
 <20180514114104.oubxdf526hf2m6t5@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 12:41:10PM +0100, Mark Rutland wrote:
> I agree it would be nicer if it had a wrapper that took a pt_regs, even
> if it does nothing with it.
> 
> We can't use SYSCALL_DEFINE0() due to the fault injection muck, we'd
> need a ksys_ni_syscall() for our traps.c logic, and adding this
> uniformly would involve some arch-specific rework for x86, too, so I
> decided it was not worth the effort.

Couldn't you just open-code the "return -ENOSYS;" in traps.c? Error
injection has no reasonable stable ABI/API expectations, so that's not a
show-stopper either.

Thanks,
	Dominik
