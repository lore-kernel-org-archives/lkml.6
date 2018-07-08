Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FAEC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B69208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVKA2bXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B69208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeGHQec (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:34:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeGHQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+aRE9DhWTSLhCPiJ8AQO03OY3Hmr2B/FU0KcQMn+CYQ=; b=pVKA2bXbAW19Qtp0Xo2Z23Orx
        uGzNRIQnrkJH1MtcxHRSvoK26g5aywut0BxzS02AGNhworPdL2vWFi8o2Zwf9ZFreKwtxcil2peCR
        A89cXiz67xhK7GKMdN2fgAasJetWJkik9EmWhHiPIRilLsvxEgiojJj6z/NqcmsDWpU0b6sRz5mty
        5DUMeJMx5QRDnjFGK2EDoMyTyaQyziWWIcPdTuthCGGNtGvo6wHqifCSorK6LMmDfqxMHYI/X9auy
        vZ84/6bCtSW4zbmZ02NggW6fjYbMyJjaDjhsiSFssV1mJCw+L80vi5EaCvlWA9jLdeyl+xU0LFYGu
        tb1WTwwDg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcCdq-0002Ry-Oi; Sun, 08 Jul 2018 16:34:30 +0000
Subject: Re: [PATCH 5/9] Kconfig: consolidate the "Kernel hacking" menu
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-6-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fd8c89be-1270-a54e-a69b-350105a04eca@infradead.org>
Date:   Sun, 8 Jul 2018 09:34:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180708152004.21679-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 08:20 AM, Christoph Hellwig wrote:
> Move the source of lib/Kconfig.debug and arch/$(ARCH)/Kconfig.debug to
> the top-level Kconfig.  For two architectures that means moving their
> arch-specific symbols in that menu into a new arch Kconfig.debug file,
> and for a few more creating a dummy file so that we can include it
> unconditionally.
> 
> Also move the actual 'Kernel hacking' menu to lib/Kconfig.debug, where
> it belongs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Kconfig                       |  2 ++
>  arch/alpha/Kconfig            |  2 --
>  arch/alpha/Kconfig.debug      |  5 ----
>  arch/arc/Kconfig              |  1 -
>  arch/arc/Kconfig.debug        |  5 ----
>  arch/arm/Kconfig              |  2 --
>  arch/arm/Kconfig.debug        |  5 ----
>  arch/arm64/Kconfig            |  2 --
>  arch/arm64/Kconfig.debug      |  5 ----
>  arch/c6x/Kconfig              | 15 ------------
>  arch/c6x/Kconfig.debug        | 11 +++++++++
>  arch/h8300/Kconfig            |  6 -----
>  arch/h8300/Kconfig.debug      |  1 +
>  arch/hexagon/Kconfig          |  4 ----
>  arch/hexagon/Kconfig.debug    |  1 +
>  arch/ia64/Kconfig             |  2 --
>  arch/ia64/Kconfig.debug       |  5 ----
>  arch/m68k/Kconfig             |  2 --
>  arch/m68k/Kconfig.debug       |  5 ----
>  arch/microblaze/Kconfig       |  2 --
>  arch/microblaze/Kconfig.debug |  6 -----
>  arch/mips/Kconfig             |  2 --
>  arch/mips/Kconfig.debug       |  5 ----
>  arch/nds32/Kconfig            |  4 ----
>  arch/nds32/Kconfig.debug      |  1 +
>  arch/nios2/Kconfig            |  2 --
>  arch/nios2/Kconfig.debug      |  5 ----
>  arch/openrisc/Kconfig         |  6 -----
>  arch/openrisc/Kconfig.debug   |  1 +
>  arch/parisc/Kconfig           |  2 --
>  arch/parisc/Kconfig.debug     |  5 ----
>  arch/powerpc/Kconfig          |  2 --
>  arch/powerpc/Kconfig.debug    |  5 ----
>  arch/riscv/Kconfig            | 45 -----------------------------------
>  arch/riscv/Kconfig.debug      | 37 ++++++++++++++++++++++++++++
>  arch/s390/Kconfig             |  2 --
>  arch/s390/Kconfig.debug       |  5 ----
>  arch/sh/Kconfig               |  2 --
>  arch/sh/Kconfig.debug         |  5 ----
>  arch/sparc/Kconfig            |  2 --
>  arch/sparc/Kconfig.debug      |  5 ----
>  arch/um/Kconfig               |  2 --
>  arch/um/Kconfig.debug         |  5 ----
>  arch/unicore32/Kconfig        |  2 --
>  arch/unicore32/Kconfig.debug  |  5 ----
>  arch/x86/Kconfig              |  2 --
>  arch/x86/Kconfig.debug        |  5 ----
>  arch/xtensa/Kconfig           |  2 --
>  arch/xtensa/Kconfig.debug     |  5 ----
>  lib/Kconfig.debug             |  6 +++++
>  50 files changed, 60 insertions(+), 206 deletions(-)
>  create mode 100644 arch/c6x/Kconfig.debug
>  create mode 100644 arch/h8300/Kconfig.debug
>  create mode 100644 arch/hexagon/Kconfig.debug
>  create mode 100644 arch/nds32/Kconfig.debug
>  create mode 100644 arch/openrisc/Kconfig.debug
>  create mode 100644 arch/riscv/Kconfig.debug


-- 
~Randy
