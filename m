Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5D1ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B46021476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B46021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJSKz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:55:29 -0400
Received: from ozlabs.org ([203.11.71.1]:43241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeJSKz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:55:28 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42br5m5cmJz9sj7; Fri, 19 Oct 2018 13:51:24 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 422123ccb9a13dcea2e008194ae6c262fbb64604
In-Reply-To: <c96ba8d949aa62604af12cfa030e2357f9a93597.1539587888.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/traps: fix machine check handlers to use pr_cont()
Message-Id: <42br5m5cmJz9sj7@ozlabs.org>
Date:   Fri, 19 Oct 2018 13:51:24 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 07:20:45 UTC, Christophe Leroy wrote:
> When printing the machine check cause, the cause appears on the
> following line due to bad use of printk without \n:
> 
> [   33.663993] Machine check in kernel mode.
> [   33.664011] Caused by (from SRR1=9032):
> [   33.664036] Data access error at address c90c8000
> 
> This patch fixes it by using pr_cont() for the second part:
> 
> [  133.258131] Machine check in kernel mode.
> [  133.258146] Caused by (from SRR1=9032): Data access error at address c90c8000
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/422123ccb9a13dcea2e008194ae6c2

cheers
