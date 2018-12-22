Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2735BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40B521A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392417AbeLVRBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:03 -0500
Received: from ozlabs.org ([203.11.71.1]:44985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLVRBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:01 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSR6WTrz9sDP; Sat, 22 Dec 2018 20:54:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 385e89d5b20f5a7c33fd7c1904da0e6a8e1b366f
X-Patchwork-Hint: ignore
In-Reply-To: <62fcfb8435c2f801d820eff469fd01e68c1b107d.1543425412.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3] powerpc/mm: add exec protection on powerpc 603
Message-Id: <43MLSR6WTrz9sDP@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:31 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-28 at 17:21:10 UTC, Christophe Leroy wrote:
> The 603 doesn't have a HASH table, TLB misses are handled by
> software. It is then possible to generate page fault when
> _PAGE_EXEC is not set like in nohash/32.
> 
> There is one "reserved" PTE bit available, this patch uses
> it for _PAGE_EXEC.
> 
> In order to support it, set_pte_filter() and
> set_access_flags_filter() are made common, and the handling
> is made dependent on MMU_FTR_HPTE_TABLE
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/385e89d5b20f5a7c33fd7c1904da0e

cheers
