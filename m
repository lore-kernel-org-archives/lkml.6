Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF49ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D289E21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMP5+GOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D289E21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJQVN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:13:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42291 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeJQVN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:13:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so12521027pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5oORA148SnGinNHp2NR89sVjRY1c//I+lPO9c+freA=;
        b=vMP5+GOvgw6ACgmZMsezGoNmmncpKVLFGnCGesXN0EEQq6fTfZRjCMN8YAt9h9pQ93
         u7iNWTMhLvo3bPDBKK0nxBgejt9Kdt315kdUD8DvQP5tMcz3n2P0U8W+QtwFXHUV24Vm
         fv7xsW0f7NrcvOiBbIAfpHPqBwAjzIZA9+1PY+EYkr6a+uGyyvQKLqkcuSViz+gwMzbK
         NXZe6a6e88hxiqNB/uaXqcke/2K+5DIeZODQj588dm6q3nqrdxEKsIEYL85q8ZKgEw83
         VkUdrlXzIqwb8Z68Q8RRoKN34HbewF0k4ch2wQ1mrikJUXkGUwBHPFxMVkckakFmR40G
         9GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5oORA148SnGinNHp2NR89sVjRY1c//I+lPO9c+freA=;
        b=ZZ0dEV0tAS9Sw/w5Gerk4ofGsl1B9SjJMjUJhzIcuLQjpngx4E7WyiZDrxJ0CqYLOR
         5yfTupXhZBMIkeRjFjBEnks6xyRgfBRCU4z6yXyRETXiOeNP6W89OseBPNTxRmrxD3SD
         YSaQfVDFlWFNitEaXDf9Gsk9/VGQN6KXrMrNuohYCBfH4mTvgPhsRfzTtn90X8gzbO0x
         mhkAyoF9k524irfRdCpayrKilkTeSSfcXR1iQ3yNmhvz/aWjG6PHjU2uEYKlaqgYlq8J
         AeaHdTLiMqWw2Sfw5AQO4WfbswOds91MFO4k0n/xq9A23N2rO515+Nw5ZKkGp3ORO77i
         pebA==
X-Gm-Message-State: ABuFfojzIDLEAi3UKYh27krs7BrOPX/BcI+z4r/OQO+NEzCJSrFrAZHk
        YTuyijksmrX3jKCpFqAHLB8=
X-Google-Smtp-Source: ACcGV62PYtHzam7TP/qsLJEstrOjUM7zT+CfeM7eKu3Ch542yTgJMCeJ8oFR1KtMSIuOZZEcTKRAwQ==
X-Received: by 2002:a63:7156:: with SMTP id b22-v6mr24193966pgn.342.1539782266871;
        Wed, 17 Oct 2018 06:17:46 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id l16-v6sm34943010pfj.179.2018.10.17.06.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:17:46 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     green.hu@gmail.com, deanbo422@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     greentime@andestech.com, Zong Li <zongbox@gmail.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 2/2] nds32: Fill all TLB entries with kernel image mapping
Date:   Wed, 17 Oct 2018 21:15:52 +0800
Message-Id: <480e740a44661c04316044ed23982c730986c840.1539781832.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1539781832.git.zongbox@gmail.com>
References: <cover.1539781832.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use earlycon replace with early_printk and doesn't use
early_io_map() to create UART mapping. It is not necessary
to reserve the one way in TLB for now.

It didn't make sense if use direct-mapped and reserve one
way at the same time. It allow the direct-mapped now.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/kernel/head.S | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/nds32/kernel/head.S b/arch/nds32/kernel/head.S
index 1ce653d..2c8aac6 100644
--- a/arch/nds32/kernel/head.S
+++ b/arch/nds32/kernel/head.S
@@ -123,14 +123,7 @@ _image_size_check:
         andi    $r0, $r0, MMU_CFG_mskTBS
         srli    $r6, $r6, MMU_CFG_offTBW
         srli    $r0, $r0, MMU_CFG_offTBS
-        /*
-         * we just map the kernel to the maximum way - 1 of tlb
-         * reserver one way for UART VA mapping
-         * it will cause page fault if UART mapping cover the kernel mapping
-         *
-         * direct mapping is not supported now.
-         */
-        beqz    $r6, __error                 ! MMU_CFG.TBW = 0 is direct mappin
+	addi    $r6, $r6, #0x1               ! MMU_CFG.TBW value -> meaning
         addi    $r0, $r0, #0x2               ! MMU_CFG.TBS value -> meaning
         sll     $r0, $r6, $r0                ! entries = k-way * n-set
         mul     $r6, $r0, $r5                ! max size = entries * page size
-- 
2.7.4

