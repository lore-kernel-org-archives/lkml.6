Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF841C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B416925C87
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B416925C87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965633AbeGBKdw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:33:52 -0400
Received: from foss.arm.com ([217.140.101.70]:57072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965411AbeGBKdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:33:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5455018A;
        Mon,  2 Jul 2018 03:33:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 254273F5BA;
        Mon,  2 Jul 2018 03:33:50 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6B3251AE5596; Mon,  2 Jul 2018 11:34:29 +0100 (BST)
Date:   Mon, 2 Jul 2018 11:34:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Use aarch64elf and aarch64elfb emulation mode
 variants
Message-ID: <20180702103429.GC28665@arm.com>
References: <20180702091659.17571-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702091659.17571-1-contact@paulk.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 11:16:59AM +0200, Paul Kocialkowski wrote:
> The aarch64linux and aarch64linuxb emulation modes are not supported by
> bare-metal toolchains and Linux using them forbids building the kernel
> with these toolchains.
> 
> Since there is apparently no reason to target these emulation modes, the
> more generic elf modes are used instead, allowing to build on bare-metal
> toolchains as well as the already-supported ones.
> 
> Fixes: 3d6a7b99e3fa ("arm64: ensure the kernel is compiled for LP64")
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm64/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 87f7d2f9f17c..3e959ac43b40 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -67,14 +67,14 @@ KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
>  AS		+= -EB
>  LD		+= -EB
> -LDFLAGS		+= -maarch64linuxb
> +LDFLAGS		+= -maarch64elfb
>  UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  CHECKFLAGS	+= -D__AARCH64EL__
>  AS		+= -EL
>  LD		+= -EL
> -LDFLAGS		+= -maarch64linux
> +LDFLAGS		+= -maarch64elf
>  UTS_MACHINE	:= aarch64
>  endif

Acked-by: Will Deacon <will.deacon@arm.com>

Will
