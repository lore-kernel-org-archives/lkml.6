Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B5ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9591D2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9591D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeJVRzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:55:14 -0400
Received: from ozlabs.org ([203.11.71.1]:39869 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeJVRzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:55:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42dryv3v1yz9sDC; Mon, 22 Oct 2018 20:37:27 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: daf00ae71dad8aa05965713c62558aeebf2df48e
In-Reply-To: <f79824d5da910441ede885fa32a25083c4cc9359.1539422122.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/traps: restore recoverability of machine_check interrupts
Message-Id: <42dryv3v1yz9sDC@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:37:27 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-13 at 09:16:22 UTC, Christophe Leroy wrote:
> commit b96672dd840f ("powerpc: Machine check interrupt is a non-
> maskable interrupt") added a call to nmi_enter() at the beginning of
> machine check restart exception handler. Due to that, in_interrupt()
> always returns true regardless of the state before entering the
> exception, and die() panics even when the system was not already in
> interrupt.
> 
> This patch calls nmi_exit() before calling die() in order to restore
> the interrupt state we had before calling nmi_enter()
> 
> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/daf00ae71dad8aa05965713c62558a

cheers
