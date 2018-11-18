Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1973EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BF820869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BF820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeKRUzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 15:55:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52217 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbeKRUzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 15:55:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E4FD520791; Sun, 18 Nov 2018 11:35:19 +0100 (CET)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id B547A2037D;
        Sun, 18 Nov 2018 11:35:19 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: mtd: rawnand: qcom: Namespace prefix some commands
Date:   Sun, 18 Nov 2018 11:35:19 +0100
Message-Id: <20181118103519.25189-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 33bf5519ae5dd356b182a94e3622f42860274a38
In-Reply-To: <20181117034327.72638-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-17 at 03:43:27 UTC, Olof Johansson wrote:
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
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to http://git.infradead.org/linux-mtd.git master, thanks.

Boris
