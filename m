Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8C7C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B4320834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B4320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJEIdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:33:32 -0400
Received: from ozlabs.org ([203.11.71.1]:40623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeJEIdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:33:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42RC6W5WYYz9sBN; Fri,  5 Oct 2018 11:37:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b45ba4a51cde29b2939365ef0c07ad34c8321789
In-Reply-To: <6acad0a13b7f6c2845b2022737c6a11a445ed3c2.1538394860.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Neuling <mikey@neuling.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/lib: fix book3s/32 boot failure due to code patching
Message-Id: <42RC6W5WYYz9sBN@ozlabs.org>
Date:   Fri,  5 Oct 2018 11:37:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 12:21:10 UTC, Christophe Leroy wrote:
> Commit 51c3c62b58b3 ("powerpc: Avoid code patching freed init
> sections") accesses 'init_mem_is_free' flag too early, before the
> kernel is relocated. This provokes early boot failure (before the
> console is active).
> 
> As it is not necessary to do this verification that early, this
> patch moves the test into patch_instruction() instead of
> __patch_instruction().
> 
> This modification also has the advantage of avoiding unnecessary
> remappings.
> 
> Fixes: 51c3c62b58b3 ("powerpc: Avoid code patching freed init sections")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b45ba4a51cde29b2939365ef0c07ad

cheers
