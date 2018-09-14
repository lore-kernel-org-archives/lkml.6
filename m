Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CFA2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BvviUvFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CFA2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeINQeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:34:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36823 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeINQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:34:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id j192-v6so1556523wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=62vLNLXZ7x3GkD7nOWesqrpDww00Q4Ssvw8B5sgwW7o=;
        b=BvviUvFvdDsoHlYxFQTnJQzndj3/1mw+c08CIFQksZa46K7Q90os16ThzMgqazFkYw
         YVVd6Qq35Us/EIzZv8nuXvV2nwA3UZQac7ljqIQmcdHqejxCCKyIXpB8B5d4D+Eh/vgf
         b/X4M+m4i25ykRNC4VB/kzZha8dtDljhpAeeFliTrdVB5LpN/kPve2UgbkBSYlG2BEUg
         /u1IhWgrNSGW3pyhdzcR5StPCXfz1Y6c/D5kqPNKq/uMIV668NFvOyUjv4tvWR4hGKx4
         oAhS13YOwp3noI7n9xtdimKDVVzJL/BsA/mNLWxhvLIWhrZx7ZePii5Ez1HmbC16J53L
         xQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=62vLNLXZ7x3GkD7nOWesqrpDww00Q4Ssvw8B5sgwW7o=;
        b=NzHmB3YRQpBouAEs8iTwX6QQhnPc9nb1xhHA2tk9f+Ku11NR+AOwCwNqCBC7G9LJcP
         G64dK2DbQdaD5mODRNzJJshrCtYTCQtMMVi/iFV0eOxW/1iwP/kV07L59zhEbqNT0v9n
         /g8aJlOJsf5jrnOS8vWRb9oTX4txc0Es1ce5ugUbIT4FAOKgqu9GOoA0bw4/t3U5fgRO
         ph2F5upmE/22UJskTAffYUyvIX0gd57iHUT2gUyqFRsuNk9VemJyH0u80aPwsZpK2DEs
         bSfIFTj6w9RNLTvfzOyqigQk0+o6nzRlcc4MAPxCYguvurFUltczCFxIV63fcstm/mOH
         q4gA==
X-Gm-Message-State: APzg51BlQkgoW5svciaMlxrrP7gu6Da/TM6aEO4KM8zOYGuZN3EcfiE+
        G9NMubm+s2s+m+AFrDTKyY1IkQ==
X-Google-Smtp-Source: ANB0VdanqwojOannoXHdXAmyshwRREqKDeKyq57lLsmT1jswNZfiQPN6ThsIYNximvMTZIXEuUaIOA==
X-Received: by 2002:a1c:200c:: with SMTP id g12-v6mr1749722wmg.102.1536924015466;
        Fri, 14 Sep 2018 04:20:15 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm1733982wmf.25.2018.09.14.04.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 04:20:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net: ethernet: ti: add missing GENERIC_ALLOCATOR dependency
Date:   Fri, 14 Sep 2018 11:20:07 +0000
Message-Id: <1536924007-2440-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch mades TI_DAVINCI_CPDMA select GENERIC_ALLOCATOR.
without that, the following sparc64 build failure happen

drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_check_free_tx_desc':
(.text+0x278): undefined reference to `gen_pool_avail'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_chan_submit':
(.text+0x340): undefined reference to `gen_pool_alloc'
(.text+0x5c4): undefined reference to `gen_pool_free'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `__cpdma_chan_free':
davinci_cpdma.c:(.text+0x64c): undefined reference to `gen_pool_free'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_desc_pool_destroy.isra.6':
davinci_cpdma.c:(.text+0x17ac): undefined reference to `gen_pool_size'
davinci_cpdma.c:(.text+0x17b8): undefined reference to `gen_pool_avail'
davinci_cpdma.c:(.text+0x1824): undefined reference to `gen_pool_size'
davinci_cpdma.c:(.text+0x1830): undefined reference to `gen_pool_avail'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_ctlr_create':
(.text+0x19f8): undefined reference to `devm_gen_pool_create'
(.text+0x1a90): undefined reference to `gen_pool_add_virt'
Makefile:1011: recipe for target 'vmlinux' failed

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 9263d63..f932923 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -41,6 +41,7 @@ config TI_DAVINCI_MDIO
 config TI_DAVINCI_CPDMA
 	tristate "TI DaVinci CPDMA Support"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
+	select GENERIC_ALLOCATOR
 	---help---
 	  This driver supports TI's DaVinci CPDMA dma engine.
 
-- 
2.7.4

