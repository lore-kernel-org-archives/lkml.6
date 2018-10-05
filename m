Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA5EC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7802147D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYxFbV2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7802147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeJEXP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbeJEXOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30BF4214AB;
        Fri,  5 Oct 2018 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756096;
        bh=RSNWp/31LUT27EjA3QWGSyQoIYwurNVlfFkzzfahw/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYxFbV2tXk3QW2ebvy0LLnXsvhpB6iCDLpiDU+8fn6qHug5N2BJ1Ptd+6b5cHk/9Q
         aQHTzmTi1uTQOyCSRyHWii5igiALTPx8hT/Ce1GgSmuZGAXg9bc7HPZamIdz8Zmx1Z
         Ge3703LvgXJHMVpyt26gOUiaCYP2bbr8p36yrgWE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 35/48] net: ethernet: ti: add missing GENERIC_ALLOCATOR dependency
Date:   Fri,  5 Oct 2018 12:14:11 -0400
Message-Id: <20181005161424.20521-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit f025571e96caa95ffc3c1792f762a584893de582 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 9263d638bd6d..f932923f7d56 100644
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
2.17.1

