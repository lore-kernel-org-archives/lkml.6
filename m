Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD9ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD0A21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5gsniMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD0A21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeIUFQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:16:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38104 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUFQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:16:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id j8-v6so7298622wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4zzMasUhzULjOvHykhCu4d335VRxunBy2y8A7zIwYU=;
        b=H5gsniMQuYAMm4Zsz12QZxU0xdElKBnDuxzKgJTqgYfWjUO6XqbFwAl0QiOlqdeheW
         6S6ynn67mDR3M+aUoMaXP1pYTgKTy124VanQ26Is84O1FPSGptT+M+ae4kN2//D0W66X
         /C789G5K4I9LLRRxstsPKjqFcxLozIJlbu+UawEwb5B6J/Dh35IgSO3i01+2qTeEAvNa
         4IHBK9ODBkynGSbvkgTsMFgH+f4qSloSvsfntVXEuijPx6urte4aXxT2y+j0ojzn8HrV
         pcXL3AbFElhrXb/zvsukFjnhSfIrcupl2z0RquDjiQ6uo2b3qk6ea4lTHBmONhQEJeuu
         Mujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4zzMasUhzULjOvHykhCu4d335VRxunBy2y8A7zIwYU=;
        b=TPNfMFNUmJugy7SD5yJJX+nGbHPQvxDcFQ/nDYmNZ9MYJehoPFjv0/FJTiMWC3JXHY
         selO2VYMCTITpi3fR53nVI+b3gwdx26Ac3QI+gyR90inqoCiBRyXuogJfd6DzXFLmLOX
         zKzrQakg3iwlc4yBbRhCLXDucorH7dQ38nrpJpCabR03iFt91Xibkxc+42Or4JL2OJrG
         7qo3I8a0ZdS8pqOPtccMpXdLytdjJTpJsO0+i/QRGFPl/EXdZTYXybDvVHL9E7Ld1WYT
         wQNOvtepMRnqIbMaTwXdJC1s0JdYiin6z4/6C6+sDX2TJp4v1zwUDi8BTk4doTwBHrew
         vZuA==
X-Gm-Message-State: ABuFfoh2MPw82riLvF3nR7SgTHKlyZy753kGRNohwxA+LlUgzbkXzaDD
        lTQzvPWdErqhg+4ow+IGL+I=
X-Google-Smtp-Source: ACcGV61hGwztd5wvv5tIqfe6l3ETVHSzoC080k6q2wDQYdJC0ZroeTNv8TLYNZdF4Honw8faPFuK2g==
X-Received: by 2002:adf:a969:: with SMTP id u96-v6mr5044894wrc.222.1537486260829;
        Thu, 20 Sep 2018 16:31:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b22-v6sm3037488wme.48.2018.09.20.16.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 16:30:59 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mtd: rawnand: Use proper enum for flctl_dma_fifo0_transfer
Date:   Thu, 20 Sep 2018 16:30:25 -0700
Message-Id: <20180920233024.28534-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is converted implicitly to another:

drivers/mtd/nand/raw/sh_flctl.c:483:46: warning: implicit conversion
from enumeration type 'enum dma_transfer_direction' to different
enumeration type 'enum dma_data_direction' [-Wenum-conversion]
                flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM) > 0)
                ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
drivers/mtd/nand/raw/sh_flctl.c:542:46: warning: implicit conversion
from enumeration type 'enum dma_transfer_direction' to different
enumeration type 'enum dma_data_direction' [-Wenum-conversion]
                flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV) > 0)
                ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
2 warnings generated.

Use the proper enums from dma_data_direction to satisfy Clang.

DMA_MEM_TO_DEV = DMA_TO_DEVICE = 1
DMA_DEV_TO_MEM = DMA_FROM_DEVICE = 2

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mtd/nand/raw/sh_flctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index c0c0798f268f..4d20d033de7b 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -480,7 +480,7 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 
 	/* initiate DMA transfer */
 	if (flctl->chan_fifo0_rx && rlen >= 32 &&
-		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM) > 0)
+		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE) > 0)
 			goto convert;	/* DMA success */
 
 	/* do polling transfer */
@@ -539,7 +539,7 @@ static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
 
 	/* initiate DMA transfer */
 	if (flctl->chan_fifo0_tx && rlen >= 32 &&
-		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV) > 0)
+		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE) > 0)
 			return;	/* DMA success */
 
 	/* do polling transfer */
-- 
2.19.0

