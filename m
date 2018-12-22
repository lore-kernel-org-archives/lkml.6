Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129FEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF88321A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392451AbeLVRBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:10 -0500
Received: from ozlabs.org ([203.11.71.1]:54661 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389168AbeLVRBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSV0PQYz9sNJ; Sat, 22 Dec 2018 20:54:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ebd1d3b74f8542a8f3bb80b453692d6d18f84071
X-Patchwork-Hint: ignore
In-Reply-To: <20181205175355.14787-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/32: Move the old 6xx -mcpu logic before the TARGET_CPU logic
Message-Id: <43MLSV0PQYz9sNJ@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:33 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 17:53:55 UTC, Mathieu Malaterre wrote:
> The code:
> 
>   ifdef CONFIG_6xx
>   KBUILD_CFLAGS          += -mcpu=powerpc
>   endif
> 
> was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
> explicitly in kernel compiles"). This change was acceptable since the
> TARGET_CPU logic was 64-bit only.
> 
> Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
> also on PPC32") this logic is no longer acceptable after the TARGET_CPU
> specific. It currently appends -mcpu=powerpc at the end of the command
> line, after any TARGET_CPU specific:
> 
>   gcc -Wp,-MD,init/.do_mounts.o.d ...
>     -mcpu=powerpc -mbig-endian -m32 ...
>     -mcpu=e300c2 ...
>     -mcpu=powerpc ...
>     ../init/do_mounts.c
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142315.html
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ebd1d3b74f8542a8f3bb80b453692d

cheers
