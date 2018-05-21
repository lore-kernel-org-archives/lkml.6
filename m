Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1121475-1526927282-2-9261122373418064835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526927281; b=L4Uhpev0iokjazqaY6ZYUzY7Ua1Fgrf0oiQnRGu3pBa0C0lRsf
    /5sDgrPD6Elm+zqrur4AGy26X6iafmMfkEv0TqOpx0tUG3lVQh8wutgSAmJLPXLs
    CwtMyoXScHzArXDaT7/aykXAOvMi2ULHEytV2gCa7anC4WLeGORp2gOrDUHe7nyw
    /mEE5uiUuwNzADBLufp+48drdbKCUU/b46Myupf6Ih4R0JEyeR9ijoJmhPbIW+o8
    Kfn3EoFGu2snj/BYDeUD5Lqwt6jEWAEVoZ6mRqZeaKsrhZteRyHlRkwca8Yx9ivW
    C1DGCs6fw6WKVlbgcwEl/8UmnlZDYkDlk9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526927281; bh=Tg636J+Yu2lBtrimZ2TgV+8wnBnqHK
    7fncvG6VtmmNs=; b=bGgopK/fVNMib4tw+5cK/V1yqUymRGtgANkGfXS86HHlPx
    Db4LFdUgET7z0KkHoIt4GDrZnxpcV11xtjaIbYAZ+Ym6qqSVBJ0fsDzuUDL4Pwml
    D1+9CjWe0IUW7YfdjUU8NXv5YGR3t+Cr7hdLtoB7hVXaHiburT2y90iBDzjPEIrY
    PujKA+WWEMvRCjOl07VD0cAuBVGQqh8yUGYLZHxPUZG0xnU18/jRmdLjluvGkTQq
    aUfI3Joc0t648HIjNTOqCDDBWhgMPLOT6Ln4k1xIeY8GX3XoHWsWmTxO8s2w0xnd
    WRAaRQjVEiYiVDVK17jmbj/Rv25jMGiWDuCtDV4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAMrypxuszCrpI6dswuzUjnN60Al13o1lk7XC5tXJcl6I3bjMG6+6BrJja6XpwDqvhaOBg5u1MkExCyCAfDCxq06NfDBPD0u779AfFK+AO9N8cXO5a5k
    PCcUzjhxczMO7Wz3wpaxDzLAseHB4ImJLhT3aYqz5ZJyPjC0ndf5utwqAefjIiFeSZiQy5DGblkCwJIZJ9Sd7rYF3d4aKNGugBPZvYpwXIbEgwobVPNsx1F3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=a6pvGgX1m2xOoJJIZ34A:9 a=CjuIK1q_8ugA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbeEUS2A (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 14:28:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54894 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeEUS17 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 May 2018 14:27:59 -0400
Date: Mon, 21 May 2018 19:28:26 +0100
From: Will Deacon <will.deacon@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Hogan <jhogan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [RFC PATCH 01/11] prctl: Support movement of arch prctls out of
 common code
Message-ID: <20180521182825.GC19122@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
 <1526318067-4964-2-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526318067-4964-2-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dave,

On Mon, May 14, 2018 at 06:14:17PM +0100, Dave Martin wrote:
> The core framework for the prctl() syscall is unloved and looking
> rather crusty these days.  It also relies on defining ancillary
> boilerplate macros for each prctl() in order to control conditional
> compilation of the different prctl calls.  We have better ways to
> do this now, using Kconfig.
> 
> This patch defines a new arch hook arch_syscall().  Architectures
> that implemement arch-specific syscalls can now select
> HAVE_ARCH_SYSCALL in their Kconfig and define this function
> appropriately.
> 
> The core prctl() implementation now matches option against the list
> of common or legacy prctls, deferring to prctl_arch() if an
> unrecognised option is encountered.
> 
> (arch_prctl() would have been a nicer name, but it conflicts with the
> pre-existing syscall of the same name on x86, particularly in the um
> code.)
> 
> No functional change.

[...]

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index af5f8c2..c911ff0 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _LINUX_PRCTL_H
> -#define _LINUX_PRCTL_H
> +#ifndef _UAPI_LINUX_PRCTL_H
> +#define _UAPI_LINUX_PRCTL_H

Is it safe to rename this #define, or is there a possibility that userspace
could be using it for something and relying on it not changing?

Other than that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
