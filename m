Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80067C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3163F208D8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+x/fJDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3163F208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbeGHQaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:30:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeGHQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hm+qQPWFHiA21hqanZnIX2t6LC6gA/80Gnt4JzJ06KA=; b=N+x/fJDdTl7YIqheWXzFjxsQ+
        1CmMBiU/Pw6meI7QsYa45/Ev8nGwjP5Oj52JthqgPETrVhQljZCGurCccmOPhKW0UXmJUCD87GIcB
        zGLPlmHaK6Fv0dUKfkRop7vD5w9G5MTHXUPaWRuKROP4CqZoRqKPmmxVj6Tbf+ozncZadJqbFiNhQ
        mpkauW6L6VXL8+MLbJQo3o/Am9PWWEPMm11rs14KBrRaEbA0d43bKXHR5F39/fuo72iIABlJCXglp
        ty89zW4CPftsI3+LobQcFQerWmRLruZA3jl9oNGYhohTG5+xzNH8MYyF7CjvMvfp3a6HT64kvSiLV
        mghMuNu5Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcCZg-0001Jc-Kr; Sun, 08 Jul 2018 16:30:12 +0000
Subject: Re: [PATCH 6/9] kconfig: include kernel/Kconfig.preempt from
 init/Kconfig
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-7-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e007f24e-fea0-9238-73e3-9d8e10290e6c@infradead.org>
Date:   Sun, 8 Jul 2018 09:30:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180708152004.21679-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 08:20 AM, Christoph Hellwig wrote:
> Almost all architectures include it.  Add a ARCH_NO_PREEMPT symbol to
> disable preempt support for alpha, hexagon, non-coldfire m68k and
> user mode Linux.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  arch/Kconfig            | 3 +++
>  arch/alpha/Kconfig      | 1 +
>  arch/arc/Kconfig        | 2 --
>  arch/arm/Kconfig        | 2 --
>  arch/arm64/Kconfig      | 1 -
>  arch/c6x/Kconfig        | 2 --
>  arch/h8300/Kconfig      | 6 ------
>  arch/hexagon/Kconfig    | 1 +
>  arch/ia64/Kconfig       | 2 --
>  arch/m68k/Kconfig       | 5 +----
>  arch/microblaze/Kconfig | 2 --
>  arch/mips/Kconfig       | 2 --
>  arch/nds32/Kconfig      | 1 -
>  arch/nios2/Kconfig      | 2 --
>  arch/openrisc/Kconfig   | 1 -
>  arch/parisc/Kconfig     | 1 -
>  arch/powerpc/Kconfig    | 1 -
>  arch/riscv/Kconfig      | 2 --
>  arch/s390/Kconfig       | 2 --
>  arch/sh/Kconfig         | 2 --
>  arch/sparc/Kconfig      | 2 --
>  arch/um/Kconfig         | 1 +
>  arch/unicore32/Kconfig  | 2 --
>  arch/x86/Kconfig        | 2 --
>  arch/xtensa/Kconfig     | 2 --
>  init/Kconfig            | 1 +
>  kernel/Kconfig.preempt  | 2 ++
>  27 files changed, 10 insertions(+), 43 deletions(-)


-- 
~Randy
