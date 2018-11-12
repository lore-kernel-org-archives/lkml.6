Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D93C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACF5223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACF5223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeKLVG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:06:59 -0500
Received: from ozlabs.org ([203.11.71.1]:60847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbeKLVG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:06:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42tp6n051sz9s3q;
        Mon, 12 Nov 2018 22:14:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joel Stanley <joel@jms.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Daniel Axtens <dja@axtens.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/boot: Set target when cross-compiling for clang
In-Reply-To: <20181112042116.5271-3-joel@jms.id.au>
References: <20181112042116.5271-1-joel@jms.id.au> <20181112042116.5271-3-joel@jms.id.au>
Date:   Mon, 12 Nov 2018 22:14:07 +1100
Message-ID: <87muqea6ps.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Stanley <joel@jms.id.au> writes:

> Clang needs to be told which target it is building for when cross
> compiling.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/259
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/boot/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 39354365f54a..111f97b1ccec 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -55,6 +55,11 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
>  
>  BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
>  
> +ifdef CONFIG_CC_IS_CLANG
> +BOOTCFLAGS += $(CLANG_FLAGS)
> +BOOTAFLAGS += $(CLANG_FLAGS)
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO
>  BOOTCFLAGS	+= -g
>  endif
> -- 
> 2.19.1
