Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD0ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972DB20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972DB20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJaOjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:39:36 -0400
Received: from ozlabs.org ([203.11.71.1]:48913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeJaOjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:39:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42lHLB39xtz9sN6; Wed, 31 Oct 2018 16:42:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cc4ebf5c0a3440ed0a32d25c55ebdb6ce5f3c0bc
In-Reply-To: <944206be46c14b9f0578f385bdc653a9c3b8cfe2.1539931702.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v6, 01/20] Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for CONFIG_SWAP"
Message-Id: <42lHLB39xtz9sN6@ozlabs.org>
Date:   Wed, 31 Oct 2018 16:42:58 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 06:54:54 UTC, Christophe Leroy wrote:
> This reverts commit 4f94b2c7462d9720b2afa7e8e8d4c19446bb31ce.
> 
> That commit was buggy, as it used rlwinm instead of rlwimi.
> Instead of fixing that bug, we revert the previous commit in order to
> reduce the dependency between L1 entries and L2 entries
> 
> Fixes: 4f94b2c7462d9 ("powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for CONFIG_SWAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cc4ebf5c0a3440ed0a32d25c55ebdb

cheers
