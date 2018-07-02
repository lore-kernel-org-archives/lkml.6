Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0522CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24B425606
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCFaTK03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24B425606
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeGBUla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:41:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeGBUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KqTZyCx7rCMMg042GrAPh/iReohA/moEW67UNbjMLac=; b=UCFaTK03ZqFFdlnXK9dOk5fEX
        +iv77v7+Ledf++tDqMfc9jGEdoV17z2taxBfU3rxFQG4xY7bglnX5WaXg9NHKfZ79pQ15YX3Da7GV
        JcPnbM8pBUcNVaOnttLhx3rhqkGXxApmOMA6/k/jsepNrU4greHH91SOngCfIm5jKb5SoTJAAB71h
        NnuzRjZhr8Bvw1ioxNGSCWf9hZylskAju4uZPJ61bObYA5og9vv6lzEwVmFhMsBI3VljYVqEe3g87
        K3NP/hnn/qhFZKv3jGdecV5Y/rvs6DZfYNIDKpfdmqX+7LBMbCcTXGeMNCud3HgluOzAtpexEivBj
        nLjpcoTVg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa5dV-0006fk-74; Mon, 02 Jul 2018 20:41:25 +0000
Subject: Re: [PATCH 1/5] kconfig: include common Kconfig files from top-level
 Kconfig
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-2-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43b9a29d-27fc-1b6e-6f90-9187749bf338@infradead.org>
Date:   Mon, 2 Jul 2018 13:41:24 -0700
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

FWIW, I prefer this modification, but it's not a deal breaker.

---
From: Randy Dunlap <rdunlap@infradead.org>

Present "General setup" before "Processor type and features".
This is done by sourcing arch/$(SRCARCH)/Kconfig before arch/Kconfig
inside init/Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Kconfig      |    2 --
 init/Kconfig |    6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- linux-next-20180702.orig/Kconfig
+++ linux-next-20180702/Kconfig
@@ -9,8 +9,6 @@ comment "Compiler: $(CC_VERSION_TEXT)"
 
 source "scripts/Kconfig.include"
 
-source "arch/$(SRCARCH)/Kconfig"
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
--- linux-next-20180702.orig/init/Kconfig
+++ linux-next-20180702/init/Kconfig
@@ -1717,6 +1717,12 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+# Note:  arch/$(SRCARCH)/Kconfig needs to be before arch/Kconfig
+# so that each $ARCH can specify its values for CONFIG_PGTABLE_LEVELS
+# before the default value is found in arch/Kconfig.
+
+source "arch/$(SRCARCH)/Kconfig"
+
 source "arch/Kconfig"
 
 endmenu		# General setup

