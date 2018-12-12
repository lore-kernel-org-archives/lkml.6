Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63ACC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7891B2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCLqBgju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7891B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeLLUxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45779 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeLLUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so9145889plm.12;
        Wed, 12 Dec 2018 12:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9TkCBVQUr3Qivq/7xJgeeQht3EZWXdqA5vbsgS4/Hk=;
        b=uCLqBgjuRgaTwZeRkrIqtuIYK/gh2RVd92by1U+wAwsY83LEsQMXwr/ZtBWPT4PLwZ
         NybyjDjULg/ubLbnW8sy14V1NNB1UR5hC9+B4jjE7xTNmW3Lmsh5lEWYs3gWhemoe7VW
         Wi9AUHQoO2PTVCCUQKzH200g2qbf63Tbgya5FfPDTk0id4BJUmSCyI7HFNjXHtWgjECQ
         hXkEiqonN0SXwwdqsYe46AEh9qhYv92LeNVW4hjoHpY+tPmsmdX/axAy71s6JfUniYTg
         gr2CRdrncqKeRVOvNilA28nb7f9GzGOAsQzibyjQgZUwpGs84G4LpbdvTgiJXStdyuwa
         1bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9TkCBVQUr3Qivq/7xJgeeQht3EZWXdqA5vbsgS4/Hk=;
        b=TLpx2tL4kAul35OJYDJxd73qm8yDBxxYoGjpF55pgS+AWQK2QljhJgStFrOIcXshsd
         UHLXOqHksZVaGB7fRRx/bV77OMxre4e0iUtWJKUY6AsoGFinA9GZ4gr0uOOPxnXOh8sE
         e6Vgl9xv2QkDcEfaXdadjHpja7s0LvynG7pxJoUD16RP4/zYaYwzZQMv2DP5RySsWDzj
         IpZQXD8/dGrWvwn6GOtd9M9/kN+f2JgQJ3+mDX4iwjm5hbMFpW4zRUrVIgI8Kn2HeW9D
         CttEC5AW2MZI7o0BiCeMqlIXWVHKPxdnZkKXrcy3RxjslmUaK4k7uvrKgeWdnA3XqyST
         Abmg==
X-Gm-Message-State: AA+aEWb6npf5c5I5387RF5A9ewqq/lktvpRzT4vCi9IZql2PNsJEO00V
        mkCz/o1pbmRi9uoorI0sOxPqMzdd
X-Google-Smtp-Source: AFSGD/XGRj+As/5ntQRgpnkqCeavfw55L9zQxvnlunaFJDUSaIf9cWuK9gIVa/F9KcI9piuMy1Obiw==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr21617108plo.205.1544648019165;
        Wed, 12 Dec 2018 12:53:39 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/24] memory: tegra: Clean up error messages
Date:   Wed, 12 Dec 2018 23:38:59 +0300
Message-Id: <20181212203907.23461-17-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all messages to start with a lower case and don't unnecessarily go
over 80 chars in the code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 570da2129fa6..0a53598d982f 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -163,7 +163,7 @@ static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
 		/* block clients DMA requests */
 		err = rst_ops->block_dma(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to block %s DMA: %d\n",
+			dev_err(mc->dev, "failed to block %s DMA: %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -173,7 +173,7 @@ static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
 		/* wait for completion of the outstanding DMA requests */
 		while (!rst_ops->dma_idling(mc, rst)) {
 			if (!retries--) {
-				dev_err(mc->dev, "Failed to flush %s DMA\n",
+				dev_err(mc->dev, "failed to flush %s DMA\n",
 					rst->name);
 				return -EBUSY;
 			}
@@ -186,7 +186,7 @@ static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
 		/* clear clients DMA requests sitting before arbitration */
 		err = rst_ops->hotreset_assert(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to hot reset %s: %d\n",
+			dev_err(mc->dev, "failed to hot reset %s: %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -215,7 +215,7 @@ static int tegra_mc_hotreset_deassert(struct reset_controller_dev *rcdev,
 		/* take out client from hot reset */
 		err = rst_ops->hotreset_deassert(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to deassert hot reset %s: %d\n",
+			dev_err(mc->dev, "failed to deassert hot reset %s: %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -225,7 +225,7 @@ static int tegra_mc_hotreset_deassert(struct reset_controller_dev *rcdev,
 		/* allow new DMA requests to proceed to arbitration */
 		err = rst_ops->unblock_dma(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to unblock %s DMA : %d\n",
+			dev_err(mc->dev, "failed to unblock %s DMA : %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -657,7 +657,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	{
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
-			dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
+			dev_err(&pdev->dev,
+				"failed to setup latency allowance: %d\n",
 				err);
 			return err;
 		}
@@ -678,7 +679,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return mc->irq;
 	}
 
-	WARN(!mc->soc->client_id_mask, "Missing client ID mask for this SoC\n");
+	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
 	mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
-- 
2.20.0

