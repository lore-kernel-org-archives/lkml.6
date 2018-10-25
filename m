Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC186C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD362083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kdAw+vi/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M4fMqiP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD362083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeJZBOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:14:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJZBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:14:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3369660C1B; Thu, 25 Oct 2018 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540485650;
        bh=Mw3CQWac6GyP5PPd+3EhkAawTJMCncA95D1YTxzc64k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdAw+vi/Mz4qXh1f7g9MM36sKdup8mlWhBTZJQf/so0iocHTUxb6d0pstWGdrRcv1
         mskVrEQ6OyYyzXGmmZMfmGk4mcZxIAAPBT9hN75AxMu8clLYrTGEhotKAFqrGDfi1w
         d0Cc4Xw0xuXFo2LZBtF/JZT0x+QGZSWOCUCXq1rI=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5463560C1B;
        Thu, 25 Oct 2018 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540485649;
        bh=Mw3CQWac6GyP5PPd+3EhkAawTJMCncA95D1YTxzc64k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4fMqiP2kGJpvLlOifm1RlHfZ/p6Ye0x5iIleP5ZQs2ZS4bApCZIzoZDbunC/dI8w
         cu6rpGIp+WDxEfAXI5r3uBunaAluntwYgy9Dg/7wkFQwIh1XwLxC50xWohp6+gP7AE
         EzWX3VLMivV6lJedoOjhYoes7W/yj02RrXS669pw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5463560C1B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 1/2] spi: spi-geni-qcom: fix nitpicks
Date:   Thu, 25 Oct 2018 22:10:28 +0530
Message-Id: <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the nitpicks.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6432ecc..d1830fb 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -64,15 +64,13 @@
 #define TIMESTAMP_AFTER		BIT(3)
 #define POST_CMD_DELAY		BIT(4)
 
-/* SPI M_COMMAND OPCODE */
-enum spi_mcmd_code {
+enum spi_m_cmd_opcode {
 	CMD_NONE,
 	CMD_XFER,
 	CMD_CS,
 	CMD_CANCEL,
 };
 
-
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -87,7 +85,7 @@ struct spi_geni_master {
 	struct completion xfer_done;
 	unsigned int oversampling;
 	spinlock_t lock;
-	unsigned int cur_mcmd;
+	enum spi_m_cmd_opcode cur_mcmd;
 	int irq;
 };
 
@@ -129,7 +127,7 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
 	struct spi_master *spi = dev_get_drvdata(mas->dev);
 	struct geni_se *se = &mas->se;
-	unsigned long timeout;
+	unsigned long time_left;
 
 	reinit_completion(&mas->xfer_done);
 	pm_runtime_get_sync(mas->dev);
@@ -142,8 +140,8 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	else
 		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
 
-	timeout = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (!timeout)
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!time_left)
 		handle_fifo_timeout(spi, NULL);
 
 	pm_runtime_put(mas->dev);
@@ -485,7 +483,6 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	struct geni_se *se = &mas->se;
 	u32 m_irq;
 	unsigned long flags;
-	irqreturn_t ret = IRQ_HANDLED;
 
 	if (mas->cur_mcmd == CMD_NONE)
 		return IRQ_NONE;
@@ -533,7 +530,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
 	spin_unlock_irqrestore(&mas->lock, flags);
-	return ret;
+	return IRQ_HANDLED;
 }
 
 static int spi_geni_probe(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

