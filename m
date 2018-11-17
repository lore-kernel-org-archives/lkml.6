Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1541FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC7A2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC7A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeKRH5o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:57:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48575 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeKRH5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:57:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A0F77207AB; Sat, 17 Nov 2018 22:39:40 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4AAB9206A7;
        Sat, 17 Nov 2018 22:39:30 +0100 (CET)
Date:   Sat, 17 Nov 2018 22:39:29 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Namespace prefix some commands
Message-ID: <20181117223929.20f6852f@xps13>
In-Reply-To: <20181117034327.72638-1-olof@lixom.net>
References: <20181117034327.72638-1-olof@lixom.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

Olof Johansson <olof@lixom.net> wrote on Fri, 16 Nov 2018 19:43:27
-0800:

> PAGE_READ is used by RISC-V arch code included through mm headers,
> and it makes sense to bring in a prefix on these in the driver.
> 
> drivers/mtd/nand/raw/qcom_nandc.c:153: warning: "PAGE_READ" redefined
>  #define PAGE_READ   0x2
> In file included from include/linux/memremap.h:7,
>                  from include/linux/mm.h:27,
>                  from include/linux/scatterlist.h:8,
>                  from include/linux/dma-mapping.h:11,
>                  from drivers/mtd/nand/raw/qcom_nandc.c:17:
> arch/riscv/include/asm/pgtable.h:48: note: this is the location of the previous definition
> 
> Caught by riscv allmodconfig.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Boris, do you want to queue this as a fix?

Thanks,
Miquèl
