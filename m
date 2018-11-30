Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4836C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964E62146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZKU5b3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964E62146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeK3Ttj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:49:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeK3Tti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:49:38 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADC321473;
        Fri, 30 Nov 2018 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543567264;
        bh=tEX3EIp9v0zv12Hz6PhdBRbJ//jFE2EqCELQvbFhDpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZKU5b3Xp68rcrCLh008e6TYIWtQDKOU2s3QCQZApw5+VvQHdNxaPK8e/rhRZls33
         5nWsHEdvhjV6HaktcJVaEg2tm7as2jCDmXPo7RuicEVyTZgZX3udljelPp78Hvg445
         MxIKNTfPpULQUZgollMWms+p5rxZ4zYjc/21ZGLo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 2/2] clk: mediatek: Drop more __init markings for driver probe
Date:   Fri, 30 Nov 2018 00:41:03 -0800
Message-Id: <20181130084103.64722-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181130084103.64722-1-sboyd@kernel.org>
References: <20181130084103.64722-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is called from driver probe, which isn't the same as
__init code because driver probe can happen later. Drop the __init
marking here to fix this potential problem.

Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Wenzhen Yu <wenzhen.yu@mediatek.com>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
Fixes: 2fc0a509e4ee ("clk: mediatek: add clock support for MT7622 SoC")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt7622.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 92f7e32770c6..a8aecef1ba89 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -513,7 +513,7 @@ static const struct mtk_gate peri_clks[] = {
 	GATE_PERI1(CLK_PERI_IRTX_PD, "peri_irtx_pd", "irtx_sel", 2),
 };
 
-static struct mtk_composite infra_muxes[] __initdata = {
+static struct mtk_composite infra_muxes[] = {
 	MUX(CLK_INFRA_MUX1_SEL, "infra_mux1_sel", infra_mux1_parents,
 	    0x000, 2, 2),
 };
@@ -652,7 +652,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
 
-static int __init mtk_infrasys_init(struct platform_device *pdev)
+static int mtk_infrasys_init(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_onecell_data *clk_data;
-- 
Sent by a computer through tubes

