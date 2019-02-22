Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB312086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfBVJsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:48:40 -0500
Received: from ozlabs.org ([203.11.71.1]:40729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBVJrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:46 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RN035Q4z9sBp; Fri, 22 Feb 2019 20:47:43 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 78ca1108b10927b3d068c8da91352b0f4cd01fc5
X-Patchwork-Hint: ignore
In-Reply-To: <a96a221fb2ce681076b86c27d28ba4ec6b9bbb8d.1548419273.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        joakim.tjernlund@infinera.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [10/10] powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB handling
Message-Id: <445RN035Q4z9sBp@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:43 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-25 at 12:34:20 UTC, Christophe Leroy wrote:
> For pages without _PAGE_USER, PP field is 00
> For pages with _PAGE_USER, PP field is 10 for RW and 11 for RO.
> 
> This patch sets _PAGE_USER to 0x002 and _PAGE_RW to 0x001
> is order to simplify TLB handling by reducing amount of shifts.
> 
> The location of _PAGE_PRESENT and _PAGE_HASHPTE doesn't matter
> as they are only SW related flags.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/78ca1108b10927b3d068c8da91352b0f

cheers
