Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438C1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E831821581
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eZBh7J8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E831821581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbeHNQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:27:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732699AbeHNQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k+8R+6z46bVB2iZsvpD7giljjGQimxF66Sl1WygAko0=; b=eZBh7J8A93Kxm3jL19AbaahYl
        PI1Zfo6kzQGyucLhzZDVTDv9E4ofo5/KXlh7/kdWrD6lXJumLVfwe0gaVGb6rG73aCCbsiIZ3g9to
        OH5Gqe1w9x9QFf2GHsMhCqzAgdyBXQQC2r1DSoX65HJ30m8TAdG3XWtPM7Qb+f80XUSqJ5+lSWntv
        x3wXpzS8BN8nt133FJszlW/+jscQXezHUSPHFURgTcgGJ6rsYoU6gZ/jL1Yzd5zAlkF9bHqh22e9t
        WWH4WSUzVDS/UimSmiE8ZuWkmNF+xJ0UMGTXCJKtxffpDI7XMVpFFEl4nLcShu2G7llAtcZZkX4Nl
        I88jO+bIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpZYh-00057G-4e; Tue, 14 Aug 2018 13:40:27 +0000
Date:   Tue, 14 Aug 2018 06:40:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net,
        aou@eecs.berkeley.edu, Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, Marcus Comstedt <marcus@mc.pp.se>,
        tklauser@distanz.ch, linux-riscv@lists.infradead.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v3 2/2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
Message-ID: <20180814134027.GD28080@infradead.org>
References: <20180809221952.24260-1-palmer@sifive.com>
 <20180809221952.24260-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809221952.24260-3-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> index 818655b0d535..690beb002d1d 100644
> --- a/arch/riscv/include/uapi/asm/syscalls.h
> +++ b/arch/riscv/include/uapi/asm/syscalls.h
> @@ -1,10 +1,13 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0

/* ... */  is the right style SPDX tag for headers, so please keep it
as-is.
