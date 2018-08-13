Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F0C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569C621738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569C621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeHMOFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:05:00 -0400
Received: from ozlabs.org ([203.11.71.1]:54661 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbeHMOE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptd71wjhz9sBJ; Mon, 13 Aug 2018 21:23:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f2c6d0d1092e3da2bd36c768777e883fa3908548
In-Reply-To: <20180622192655.23464-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: include setup.h header file to fix warnings
Message-Id: <41ptd71wjhz9sBJ@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:23:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 19:26:53 UTC, Mathieu Malaterre wrote:
> Make sure to include setup.h to provide the following prototypes:
> 
> - irqstack_early_init
> - setup_power_save
> - initialize_cache_info
> 
> Fix the following warnings (treated as error in W=1):
> 
>   arch/powerpc/kernel/setup_32.c:198:13: error: no previous prototype for ‘irqstack_early_init’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/setup_32.c:238:13: error: no previous prototype for ‘setup_power_save’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/setup_32.c:253:13: error: no previous prototype for ‘initialize_cache_info’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2c6d0d1092e3da2bd36c768777e88

cheers
