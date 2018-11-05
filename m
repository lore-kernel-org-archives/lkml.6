Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF04C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A4120854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PCbhJHr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A4120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeKEVXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:23:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48454 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbeKEVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=reVoXo/fPEg6BI7U8iCPvatujlfIkXk04CjbX8uRfas=; b=PCbhJHr/hwXw
        6iE1duKf6GJEAQdoftwndOgL+sNFNfzWmf8RwFf4EHm35GCKwBZDqAUw8gHDuLOj3JPU71F2j2qnW
        GARnDspPSxvndut/GRgqfmEgiCdT1Gajp+upgGEDkHpBHSpaLorLeG5ooNh1cDVZjEfLdSjI5dTEN
        A3ooA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdbj-0008Kt-G9; Mon, 05 Nov 2018 12:03:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3803A1124D98; Mon,  5 Nov 2018 12:03:51 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, swboyd@chromium.org,
        dianders@chromium.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-geni-qcom: fix nitpicks" to the spi tree
In-Reply-To:  <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
Message-Id: <20181105120351.3803A1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:03:51 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-geni-qcom: fix nitpicks

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0dccff3ce73aa6e9b1b4b0ddb3831c1d7fde9507 Mon Sep 17 00:00:00 2001
From: Alok Chauhan <alokc@codeaurora.org>
Date: Thu, 25 Oct 2018 22:10:28 +0530
Subject: [PATCH] spi: spi-geni-qcom: fix nitpicks

fixed the nitpicks.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6432ecc4e2ca..d1830fbf2fc6 100644
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
2.19.0.rc2

