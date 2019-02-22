Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA11C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301622081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfBVJrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:47:43 -0500
Received: from ozlabs.org ([203.11.71.1]:51583 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfBVJrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:42 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RMw2j4Jz9sDr; Fri, 22 Feb 2019 20:47:40 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0bbea75c476b77fa7d7811d6be911cc7583e640f
X-Patchwork-Hint: ignore
In-Reply-To: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/traps: fix recoverability of machine check handling on book3s/32
Message-Id: <445RMw2j4Jz9sDr@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:40 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 14:11:24 UTC, Christophe Leroy wrote:
> Looks like book3s/32 doesn't set RI on machine check, so
> checking RI before calling die() will always be fatal
> allthought this is not an issue in most cases.
> 
> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
> Fixes: daf00ae71dad ("powerpc/traps: restore recoverability of machine_check interrupts")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: stable@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0bbea75c476b77fa7d7811d6be911cc7

cheers
