Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED55C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430A24E46
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MLRey/cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E430A24E46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeGBUEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:04:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGBUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ijNIXhNDjzX6SrxLRnXI3iF2BMHE921zFUVvf8oH1vY=; b=MLRey/cpTY7jagD1eAXp8Oiy7
        9XY3QHFpVoo3E4OUOC9f5MVnUYIq0PO8i8vlua6TlXiUMoFip+sEeUoqvwlHMFQ1D1SFt/TH+OprT
        xDmsiI0WD607Xa2gPMk9Ojce0SBgTh9imj/FmLPf5/hfFvSOTKxmuFevfXvxII1D0NOJgxK49w2tl
        +0/slvfd9tT7wnILHo1tTeUtkQ0lnjGTQqHs+WNlJTrjSgXySwlsg2v96h9zuvFE31LRmkB+38rXs
        iAvrQg00axKe8+l/b5JqRIRXSfnXOyepsfM4gW3oM/P4hpY1Tif0vzRITUcTnQXsrlPk4lLgY7pkd
        RUQ/g8Agw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa53I-0006z2-4I; Mon, 02 Jul 2018 20:04:00 +0000
Subject: Re: [PATCH 1/5] kconfig: include common Kconfig files from top-level
 Kconfig
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-2-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5c090e3f-ced0-62c5-c511-f4c66804ed32@infradead.org>
Date:   Mon, 2 Jul 2018 13:03:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702144711.22111-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 07:47, Christoph Hellwig wrote:
> Instead of duplicating the source statements in every architecture just
> do it once in the toplevel Kconfig file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Kconfig                 | 22 ++++++++++++++++++++++
>  arch/alpha/Kconfig      | 20 --------------------
>  arch/arc/Kconfig        | 16 ----------------
>  arch/arm/Kconfig        | 25 -------------------------
>  arch/arm64/Kconfig      | 23 -----------------------
>  arch/c6x/Kconfig        | 24 ------------------------
>  arch/h8300/Kconfig      | 24 ------------------------
>  arch/hexagon/Kconfig    | 16 ----------------
>  arch/ia64/Kconfig       | 20 --------------------
>  arch/m68k/Kconfig       | 24 ------------------------
>  arch/microblaze/Kconfig | 24 ------------------------
>  arch/mips/Kconfig       | 24 ------------------------
>  arch/nds32/Kconfig      | 16 ----------------
>  arch/nios2/Kconfig      | 24 ------------------------
>  arch/openrisc/Kconfig   | 23 -----------------------
>  arch/parisc/Kconfig     | 24 ------------------------
>  arch/powerpc/Kconfig    | 19 -------------------
>  arch/riscv/Kconfig      | 24 ------------------------
>  arch/s390/Kconfig       | 24 ------------------------
>  arch/sh/Kconfig         | 24 ------------------------
>  arch/sparc/Kconfig      | 24 ------------------------
>  arch/unicore32/Kconfig  | 24 ------------------------
>  arch/x86/Kconfig        | 22 +---------------------
>  arch/xtensa/Kconfig     | 25 -------------------------
>  24 files changed, 23 insertions(+), 512 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index a90d9f9e268b..5499b1273ba5 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -10,3 +10,25 @@ comment "Compiler: $(CC_VERSION_TEXT)"
>  source "scripts/Kconfig.include"
>  
>  source "arch/$(SRCARCH)/Kconfig"
> +
> +source "init/Kconfig"

Hi Christoph,

Looks good overall.  I'm still doing some testing on it.

I would prefer to have init/Kconfig before arch/$(SRCARCH)/Kconfig.
Is there a reason that you chose the ordering above?
Any known dependencies?

Thanks.

> +
> +source "kernel/Kconfig.freezer"
> +
> +menu "Executable file formats"
> +source "fs/Kconfig.binfmt"
> +endmenu
> +
> +source "mm/Kconfig"
> +
> +source "net/Kconfig"
> +
> +source "drivers/Kconfig"
> +
> +source "fs/Kconfig"
> +
> +source "security/Kconfig"
> +
> +source "crypto/Kconfig"
> +
> +source "lib/Kconfig"


-- 
~Randy
