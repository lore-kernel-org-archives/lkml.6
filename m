Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56088C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AD5208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2rHpHDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfAJVC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:02:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46020 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfAJVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:02:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so5698960plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9FkhJ6TWk9mFRRIX54SBNrz1TGkybpJui6PCOPRa8U=;
        b=e2rHpHDVmCf/wlS7XjHyJqYeTMPk8o06hT45Hxl1qq4l4g+OTqeXVxwntbcZqFYIRV
         vgDsdoixd4XU1bt2XZERZSZWSvIFx1QzpRtleqzzboX0wqCt9QthSY4Me4/zbhbe4xMJ
         ubdkrU2P8X0X97Ud2CwyWAv8vz2dBoDJPoGH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9FkhJ6TWk9mFRRIX54SBNrz1TGkybpJui6PCOPRa8U=;
        b=OkhN2JGXqLYneXuvQ178hllVmA9acXFINB78jrgFF7b9deWBXSP7+jKG0WtZAGE4pN
         jnLrpyJA/MMg2Dy9Kc88RaWGdQQj5UoRrQ4IIchLFuBZGs1LSHfiaFZJh4R4wOApEqTp
         O5ldyOp5Oig5TDrVBUIdR74pZOG/Qdjbwlupm67maoqMUj/8j0U3UdZQPWHJox9sFTnC
         1+gRxQpeY87NytmQBfAcbOK1Ul3OVp2MgogdAcykjsNnQg8rZJ2YZtvD/qxIjhmhT7jH
         7JdLcapuZBAoXRT0DFA866Xv3BXnrxFjwAWhXTd99uz6anBB/Rssm1UQHcTc8poq+I8W
         VtlA==
X-Gm-Message-State: AJcUukeVE6Y3ImQX/h1TnMQEMeV2GAwjvJ4GGQrbJ7kLeGheD38WkJLq
        NZ2hLARNcam2TtDQk4T6YdekAw==
X-Google-Smtp-Source: ALg8bN7I1YNTakOvYKjUc5+oRzM02i28xPQu+mDV5BSmTlrjqbKn/N0mwQTAas4IY+AzpW8uXk7FSQ==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr11853684plt.21.1547154175410;
        Thu, 10 Jan 2019 13:02:55 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s37sm95562617pgm.19.2019.01.10.13.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 13:02:54 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/2] spi: spi-geni-qcom: Get rid of forward declaration
Date:   Thu, 10 Jan 2019 13:02:53 -0800
Message-Id: <20190110210253.23219-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190110210253.23219-1-swboyd@chromium.org>
References: <20190110210253.23219-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need this forward declaration. Move the function to where it
needed so we can drop it and shave some lines of code.

CC: Girish Mahadevan <girishm@codeaurora.org>
CC: Dilip Kota <dkota@codeaurora.org>
CC: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 55 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c3e9464027d4..5f0b0d5bfef4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -89,9 +89,6 @@ struct spi_geni_master {
 	int irq;
 };
 
-static void handle_fifo_timeout(struct spi_master *spi,
-				struct spi_message *msg);
-
 static int get_spi_clk_cfg(unsigned int speed_hz,
 			struct spi_geni_master *mas,
 			unsigned int *clk_idx,
@@ -122,6 +119,32 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
+static void handle_fifo_timeout(struct spi_master *spi,
+				struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	unsigned long time_left, flags;
+	struct geni_se *se = &mas->se;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	reinit_completion(&mas->xfer_done);
+	mas->cur_mcmd = CMD_CANCEL;
+	geni_se_cancel_m_cmd(se);
+	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (time_left)
+		return;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	reinit_completion(&mas->xfer_done);
+	geni_se_abort_m_cmd(se);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!time_left)
+		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+}
+
 static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
@@ -356,32 +379,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
 }
 
-static void handle_fifo_timeout(struct spi_master *spi,
-				struct spi_message *msg)
-{
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
-	unsigned long time_left, flags;
-	struct geni_se *se = &mas->se;
-
-	spin_lock_irqsave(&mas->lock, flags);
-	reinit_completion(&mas->xfer_done);
-	mas->cur_mcmd = CMD_CANCEL;
-	geni_se_cancel_m_cmd(se);
-	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-	spin_unlock_irqrestore(&mas->lock, flags);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (time_left)
-		return;
-
-	spin_lock_irqsave(&mas->lock, flags);
-	reinit_completion(&mas->xfer_done);
-	geni_se_abort_m_cmd(se);
-	spin_unlock_irqrestore(&mas->lock, flags);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (!time_left)
-		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
-}
-
 static int spi_geni_transfer_one(struct spi_master *spi,
 				struct spi_device *slv,
 				struct spi_transfer *xfer)
-- 
Sent by a computer through tubes

