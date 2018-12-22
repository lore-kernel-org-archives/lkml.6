Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96404C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3FF21A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392428AbeLVRBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:04 -0500
Received: from ozlabs.org ([203.11.71.1]:54183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387925AbeLVRBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:01 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSZ72qCz9sMQ; Sat, 22 Dec 2018 20:54:38 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 10fdf838e5f540beca466e9d1325999c072e5d3f
X-Patchwork-Hint: ignore
In-Reply-To: <40d63adb6058b1fbb4082ca6f15225cb6e76bd62.1544429175.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
Message-Id: <43MLSZ72qCz9sMQ@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:38 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 08:08:28 UTC, Christophe Leroy wrote:
> On several arches, virt_to_phys() is in io.h
> 
> Build fails without it:
> 
>   CC      lib/test_debug_virtual.o
> lib/test_debug_virtual.c: In function 'test_debug_virtual_init':
> lib/test_debug_virtual.c:26:7: error: implicit declaration of function 'virt_to_phys' [-Werror=implicit-function-declaration]
>   pa = virt_to_phys(va);
>        ^
> 
> Fixes: e4dace361552 ("lib: add test module for CONFIG_DEBUG_VIRTUAL")
> CC: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/10fdf838e5f540beca466e9d132599

cheers
