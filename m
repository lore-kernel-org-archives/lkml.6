Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeENVAt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:00:49 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33954 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeENVAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:00:45 -0400
Date: Mon, 14 May 2018 22:57:44 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 18/18] arm64: implement syscall wrappers
Message-ID: <20180514205744.GC26773@light.dominikbrodowski.net>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-19-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-19-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:40AM +0100, Mark Rutland wrote:
> Note that we play games with sys_ni_syscall(). It can't be defined with
> SYSCALL_DEFINE0() because we must avoid the possibility of error
> injection. Additionally, there are a couple of locations where we need
> to call it from C code, and we don't (currently) have a
> ksys_ni_syscall().  While it has no wrapper, passing in a redundant
> pt_regs pointer is benign per the AAPCS.
> 
> When ARCH_HAS_SYSCALL_WRAPPER is selected, no prototype is define for
> sys_ni_syscall(). Since we need to treat it differently for in-kernel
> calls and the syscall tables, the prototype is defined as-required.

> Largely the wrappers are largely the same as their x86 counterparts, but

That's one "Largely" too much.

> simplified as we don't have a variety of compat calling conventions that
> require separate stubs. Unlike x86, we have some zero-argument compat
> syscalls, and must define COMPAT_SYSCALL_DEFINE0().

... for consistent naming, or is there another reason for that?

This patch looks good in any case.

Thanks,
	Dominik
