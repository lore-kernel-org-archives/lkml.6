Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF7921480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="h+CaO/KU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF7921480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeIYMjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:39:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50412 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeIYMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:39:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so12048518wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 23:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6KpZH0D73KVg+wWRaacagW7K6E+8TdmEq8TYGTKnet0=;
        b=h+CaO/KUo70aVsnWAy/zaYf4Owv1l7e90426VmUWbaHWXbTCUYe/eyDkTmQ1NOZLC1
         Qa2dJE2gW+E0Say+ZnX7LV5ioGwMlXg8tKVQc4d5TVYXRbNo8djZAsmKeOFO6Su2CAxL
         jnS/mqOnXNlLa/Tm4OcKG/KKYBs2LydJJnhgVpzJ9D+7z9Phe5ayjkOhg/LY8MkPYqMH
         5UNjO4/Ol0AFJVkF2U5AK+rPcadY2AEZgJo2Yt+VtmHG+crjbW/D/Tq2/pHjqQ/KVR/4
         2LreF6GQt/Fgz+8gi4S2EeRnspy5xQXPvdAWFdRH7lueJTQ1kEsjTWut6nnO5sGTh6si
         jRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6KpZH0D73KVg+wWRaacagW7K6E+8TdmEq8TYGTKnet0=;
        b=Gw6N5rxX2k8mSwZJiy1LtDuW99Wl65pzdL276PPFmmHSswJYXBK48f7PbCKQ8AMqTF
         8npukWpUDJjG36RFuDhqI0PTh/YT55yNOZimmR1XkImcTsizOr55Aw2MnAsCmwrvNu2U
         pJRaUk3B9wO0xeMYemqLNaCU4gnxxpJIYknGeZ76ScSweXRJ7wX6z8mHyCeXwOwMrBWd
         IfQYlqjRNiNeUb59NpcW6FMA5b4mObsGvRN8I62WT/Xiej194D9i+dLxPkDv1Zpmg+KM
         Hvr3T5+NLxPgJN0zJZKsDhly1U4J4GWdn6EXBx/KisJ996l1xpT44+A4Hj1WWfLQvF6M
         gmOA==
X-Gm-Message-State: ABuFfoh/Jpb1S9s/rxjdqpMZNtN8eR0dayZjHmV6kSkEZ4BuC1mTi8R8
        eXnGy2wb59TISZOUX9tUhGOySAihsi5SPw==
X-Google-Smtp-Source: ACcGV60QtBHNRu1mi19YHZBvuMNAKIcsp9DDZRzxb3PLO5GhNBiLje/BDF6O8Er6jnX58xBfRvWZYA==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr656028wme.111.1537857181377;
        Mon, 24 Sep 2018 23:33:01 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id o6-v6sm848448wmc.15.2018.09.24.23.33.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 23:33:00 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2] net: macb: Clean 64b dma addresses if they are not detected
Date:   Tue, 25 Sep 2018 08:32:50 +0200
Message-Id: <68051905ba59d7cfd74c63ef5bf0830dc2b9f6fe.1537857166.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B is
not detected on 64bit system.
The issue was observed when bootloader(u-boot) does not check macb
feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
by default. Then macb driver is reading DMACFG register back and only
adding 64bit dma configuration but not cleaning it out.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Clean reg at the first place - Edgar
- Update commit message

 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 16e4ef7d7185..ed8a5c53467e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2160,6 +2160,7 @@ static void macb_configure_dma(struct macb *bp)
 		else
 			dmacfg &= ~GEM_BIT(TXCOEN);
 
+		dmacfg &= ~GEM_BIT(ADDR64);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
 			dmacfg |= GEM_BIT(ADDR64);
-- 
1.9.1

