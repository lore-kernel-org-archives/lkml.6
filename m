Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D95C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557542086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfBVJr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:47:58 -0500
Received: from ozlabs.org ([203.11.71.1]:44699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbfBVJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:52 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RN572ccz9sB8; Fri, 22 Feb 2019 20:47:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fe1ef6bcdb4fca33434256a802a3ed6aacf0bd2f
X-Patchwork-Hint: ignore
In-Reply-To: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
To:     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: fix 32-bit KVM-PR lockup and panic with MacOS guest
Message-Id: <445RN572ccz9sB8@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:49 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 14:33:19 UTC, Mark Cave-Ayland wrote:
> Commit 8792468da5e1 "powerpc: Add the ability to save FPU without giving it up"
> unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used to
> update the MSR of the previous thread in __giveup_fpu() causing a KVM-PR MacOS
> guest to lockup and panic the kernel.
> 
> Reinstate these bits to the MSR bitmask to enable MacOS guests to run under
> 32-bit KVM-PR once again without issue.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fe1ef6bcdb4fca33434256a802a3ed6a

cheers
