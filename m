Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C050C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA76C2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA76C2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJBQnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:43:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeJBQnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:43:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2926E7A9;
        Tue,  2 Oct 2018 03:01:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.Emea.Arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17E783F5B3;
        Tue,  2 Oct 2018 03:00:59 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:00:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        James Morse <james.morse@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andy Gross <andy.gross@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
Message-ID: <20181002100056.GA225812@arrakis.emea.arm.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:44:52PM -0700, Mark Salyzyn wrote:
> On 10/01/2018 11:49 AM, John Stultz wrote:
> > On Mon, Oct 1, 2018 at 10:58 AM, Mark Salyzyn <salyzyn@android.com> wrote:
> > > Last sent 23 Nov 2016.
> > > 
> > > The following 23 patches are rebased and resent, and represent a
> > > rewrite of the arm and arm64 vDSO into C, adding support for arch32
> > > (32-bit user space hosted 64-bit kernels) and into a common library
> > > that other (arm, or non-arm) architectures may utilize.
> > So I feel like this has gone around a few times w/o much comment from
> > the arm/arm64 maintainers. I'm not sure if there's a reason?
> 
> I am "forming an opinion"(tm) that ARM is not interested in any work on 32
> bit arm architectures. They have no manpower that they are willing to devote
> to this.

Actually, we are interested in this work but, TBH, I find it a bit hard
to read your series and have postponed looking into it in detail. Just
look at the patch numbering/versioning for example:

> [PATCH v5 01/12] arm: vdso: rename vdso_datapage variables
> [PATCH v5 02/12] arm: vdso: add include file defining __get_datapage()
> [PATCH v5 03/12] arm: vdso: inline assembler operations to compiler.h
> [PATCH v5 04/12] arm: vdso: do calculations outside reader loops
> [PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
> [PATCH v5 06/12] arm: vdso: add support for clock_getres
> [PATCH v5 07/12] arm: vdso: disable profiling
> [PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
> [PATCH v5 09/12] arm: vdso: move vgettimeofday.c to lib/vdso/
> [PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C
> [PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
> [PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
> [PATCH] lib: vdso: add support for time
> [PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
> [PATCH v2 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
> [PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
> [PATCH] arm64: compat: Expose offset to registers in sigframes
> [PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
> [PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
> [PATCH 3/6] arm64: Refactor vDSO init/setup
> [PATCH v2 4/6] arm64: compat: Add a 32-bit vDSO
> [PATCH 5/6] arm64: compat: 32-bit vDSO setup
> [PATCH 6/6] arm64: Wire up and expose the new compat vDSO

The above may look obvious to you as you've worked on it but not to
maintainers who have to read lots of other patchsets.

> Despite the gain of 0.4% for screen-on battery life, where Android has a mix
> of 64 and 32 bit applications, thus still relevant _today_ on 64 bit
> architectures (providing vDSO32 for 32-bit applications).

As Russell said, if that's the only gain, you may need other selling
points.

The main advantage I see is to avoid code duplication, hence a vdso
library that could be shared by arm/arm64/arm64-compat _and_ future or
existing architectures that need vdso support.

> ARM has complained that they want them all at one time because individually
> they represent more work. So the whole set is here ready to go.

Having five separate series without a clear dependency between them was
worse than the current numbering scheme ;).

Anyway, since I still think this series is important, some weeks ago I
assigned Vincenzo Frascino in my team the task of de-cluttering this
patchset and posting it to the list. So we may see a new series later
this month (and any feedback welcome).

-- 
Catalin
