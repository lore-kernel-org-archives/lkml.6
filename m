Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0EC7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093720881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C093720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeJOLo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:44:29 -0400
Received: from ozlabs.org ([203.11.71.1]:56045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeJOLo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:44:28 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42YPqy1Rdyz9t0P; Mon, 15 Oct 2018 15:01:01 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3b35bd48b8a06e02a25af84baba782876b8a6572
In-Reply-To: <981244f0ffb38c1aa02c9eb831c7ebf479b8f564.1538789120.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, muriloo@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v4,1/3] powerpc/process: fix casting and missing header
Message-Id: <42YPqy1Rdyz9t0P@ozlabs.org>
Date:   Mon, 15 Oct 2018 15:01:01 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-06 at 16:51:12 UTC, Christophe Leroy wrote:
> This patch fixes the following warnings. The first ones are leftovers
> from when __get_user() was replaced by probe_kernel_address().
> 
> The last one is from when show_user_instructions() was added.
> 
> arch/powerpc/kernel/process.c:1287:22: warning: incorrect type in argument 2 (different address spaces)
> arch/powerpc/kernel/process.c:1287:22:    expected void const *src
> arch/powerpc/kernel/process.c:1287:22:    got unsigned int [noderef] <asn:1>*<noident>
> arch/powerpc/kernel/process.c:1319:21: warning: incorrect type in argument 2 (different address spaces)
> arch/powerpc/kernel/process.c:1319:21:    expected void const *src
> arch/powerpc/kernel/process.c:1319:21:    got unsigned int [noderef] <asn:1>*<noident>
> arch/powerpc/kernel/process.c:1302:6: warning: symbol 'show_user_instructions' was not declared. Should it be static?
> 
> Fixes: 7b051f665c32d ("powerpc: Use probe_kernel_address in show_instructions")
> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
> Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b35bd48b8a06e02a25af84baba782

cheers
