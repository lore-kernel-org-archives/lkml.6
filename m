Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FCAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB821939
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbeLVRLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:11:01 -0500
Received: from ozlabs.org ([203.11.71.1]:33009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731640AbeLVRLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:11:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSR0hzpz9sLw; Sat, 22 Dec 2018 20:54:30 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0ed5b55884f8b1fa368454d47cc6ecf9790b8b99
X-Patchwork-Hint: ignore
In-Reply-To: <674bef4f0b56492b4c30644ccaaf318869c84992.1543340240.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: add exception frame marker
Message-Id: <43MLSR0hzpz9sLw@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 17:38:16 UTC, Christophe Leroy wrote:
> This patch adds STACK_FRAME_REGS_MARKER in the stack at exception entry
> in order to see interrupts in call traces as below:
> 
> [    0.013964] Call Trace:
> [    0.014014] [c0745db0] [c007a9d4] tick_periodic.constprop.5+0xd8/0x104 (unreliable)
> [    0.014086] [c0745dc0] [c007aa20] tick_handle_periodic+0x20/0x9c
> [    0.014181] [c0745de0] [c0009cd0] timer_interrupt+0xa0/0x264
> [    0.014258] [c0745e10] [c000e484] ret_from_except+0x0/0x14
> [    0.014390] --- interrupt: 901 at console_unlock.part.7+0x3f4/0x528
> [    0.014390]     LR = console_unlock.part.7+0x3f0/0x528
> [    0.014455] [c0745ee0] [c0050334] console_unlock.part.7+0x114/0x528 (unreliable)
> [    0.014542] [c0745f30] [c00524e0] register_console+0x3d8/0x44c
> [    0.014625] [c0745f60] [c0675aac] cpm_uart_console_init+0x18/0x2c
> [    0.014709] [c0745f70] [c06614f4] console_init+0x114/0x1cc
> [    0.014795] [c0745fb0] [c0658b68] start_kernel+0x300/0x3d8
> [    0.014864] [c0745ff0] [c00022cc] start_here+0x44/0x98
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0ed5b55884f8b1fa368454d47cc6ec

cheers
