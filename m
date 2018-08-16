Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50C7214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50C7214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbeHPML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:11:58 -0400
Received: from foss.arm.com ([217.140.101.70]:34640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbeHPML6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:11:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 151697A9;
        Thu, 16 Aug 2018 02:14:48 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9C463F5BD;
        Thu, 16 Aug 2018 02:14:47 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 1110E1AE11BC; Thu, 16 Aug 2018 10:14:54 +0100 (BST)
Date:   Thu, 16 Aug 2018 10:14:54 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Vishal Bhoj <vishal.bhoj@linaro.org>
Subject: Re: [GIT PULL] arm64: updates for 4.19
Message-ID: <20180816091454.GA31093@arm.com>
References: <20180814113633.GE28664@arm.com>
 <CALAqxLVeSHp+D=9t0f7ve7YgSzqVNTkVVzv-8tdQkJARJ8Bo8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLVeSHp+D=9t0f7ve7YgSzqVNTkVVzv-8tdQkJARJ8Bo8Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Aug 15, 2018 at 04:55:15PM -0700, John Stultz wrote:
> On Tue, Aug 14, 2018 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > Please pull these arm64 updates for 4.19. Details in the tag, but please be
> > aware that we've pulled in the x86/mm branch from -tip so that we can make
> > use of the core ioremap changes which allow us to put down huge mappings
> > in the vmalloc area without screwing up the TLB. Much of the positive
> > diffstat is because of the rseq selftest for arm64.
> >
> > There is a trivial conflict in arch/arm64/Makefile with your tree, since
> > we effectively rewrote a fix that was merged in -rc5 [96f95a17c1cf]. The
> > correct resolution is therefore to prefer the code using ld-option, which
> > is what we have here. We also ran into a couple of trivial conflicts that
> > were resolved in -next with the KVM and EFI trees.
> >
> 
> Hey Will,
>   So I noticed issues booting Linus' master on the HiKey960 board I
> have today (something hangs early in boot before I get any serial
> output), and isolated the issue down to your branch here.
> 
> It seems to be coming from 693350a79980 ("arm64: insn: Don't fallback
> on nosync path for general insn patching"), and reverting that change
> resolves the issue for me.
> 
> If you have any suggestions for alternative fixes or things to try,
> please let me know.

Hmm, sorry about that. It's also just been reported on linux-arm-kernel[1], and
they have a backtrace, so I'll take a look today.

Cheers,

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/596961.html
