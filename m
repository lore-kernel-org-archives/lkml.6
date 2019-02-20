Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B4821773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBziC1/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfBTFSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53682 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfBTFSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:15 -0500
Received: by mail-it1-f196.google.com with SMTP id x131so12432800itc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wowct3K4dPgXXojBuflSXWxnwjNKq9pFZQYObBOGVPY=;
        b=ZBziC1/glnjFoqs0CBX0q8trfAhqGB5rGedmZ0pVBX6kwzp2TW5xwhOEpZrZtABD+Y
         UDC3UmnhgbwyYJU8xyQGtM94sUx59pvd5eIlOBL/zeNMMEvgfe9+E8fuEK8XR2UH+wjR
         SwPH0pEVv4TS/t84DlNXBONuj4QXkJaF63ypO1f8+pvMEITHWRDQKRlj2Qnl2tJtF+22
         /feVHaorX4yq6+2eGZrIALlWR7fSH9141WnkxOd0QzZcUdD4M9LUSfbmFnKARYnKmiH9
         v6jnYXpZMfPt+Oqkb1eTzhGNLqO56Jms1/YM+tXahfxeoWs/JbTR1fHlE+DWTvtZdcEE
         asQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wowct3K4dPgXXojBuflSXWxnwjNKq9pFZQYObBOGVPY=;
        b=NJvt5lIh4GA+gzuwOmScy7HMPCPxCBJDptVEd58dTID068RZI3rTdowpOi5zLB2MOq
         WiEyVby0OlhJH/YaZbh1KKZLasK7sEJqDAPDpH90Ob8bQ8yWDAd+yI3LRPWjKbm5LKvh
         GJHQNJNZv1X7fLdCY7l5Kd8RpYG/6t7WoZIqlUEuapIUocqiT/ZCgsSDzcZrPnAlc9Vi
         QZkOnt5d1dOQGri3wfiLJq1IpFdCELbQGkJDGQ+RTzEFppVTHyCwAO8fpAjLg5mONY4r
         6lw6krG+GqYHg8RS79lIIYQns0nBLikaF+TD2BVZyxz4RxLkiCulfiMXisBi+Ozm2eYT
         x56Q==
X-Gm-Message-State: AHQUAuac8zoGELLcb7uqHqRSB/qxYsOHB24iFN+ZXu+h6GehfNTQ4e3B
        CJxyVpyYFWyoHhCnoLFSzFM=
X-Google-Smtp-Source: AHgI3IYtQpxVhJDWANTlyPEpuy8wd3jT69S7Tx4OZoxg6UZDkFBxRAWPnITpt9u3OtXXdjA9a/GQDA==
X-Received: by 2002:a24:a81:: with SMTP id 123mr4379680itw.43.1550639893900;
        Tue, 19 Feb 2019 21:18:13 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:13 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 07/10] staging: mt7621-mmc: Initialize completions a single time during probe
Date:   Tue, 19 Feb 2019 22:17:51 -0700
Message-Id: <20190220051754.12195-8-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module was initializing completions whenever it was going to wait on
them, and not when the completion was allocated.  This is incorrect
according to the completion docs:

    Calling init_completion() on the same completion object twice is
    most likely a bug [...]

Re-initialization is also unnecessary because the module never uses
complete_all().  Fix this by only ever initializing the completion a
single time.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index f12f9d6611c9..942c0d63d710 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -468,7 +468,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 	host->cmd     = cmd;
 	host->cmd_rsp = resp;
 
-	init_completion(&host->cmd_done);
+	// The completion should have been consumed by the previous command
+	// response handler, because the mmc requests should be serialized
+	BUG_ON(completion_done(&host->cmd_done));
 
 	sdr_set_bits(host->base + MSDC_INTEN, wints);
 	sdc_send_cmd(rawcmd, cmd->arg);
@@ -490,7 +492,6 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 		    MSDC_INT_ACMD19_DONE;
 
 	BUG_ON(in_interrupt());
-	//init_completion(&host->cmd_done);
 	//sdr_set_bits(host->base + MSDC_INTEN, wints);
 
 	spin_unlock(&host->lock);
@@ -674,7 +675,10 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		//msdc_clr_fifo(host);  /* no need */
 
 		msdc_dma_on();  /* enable DMA mode first!! */
-		init_completion(&host->xfer_done);
+
+		// The completion should have been consumed by the previous xfer
+		// response handler, because the mmc requests should be serialized
+		BUG_ON(completion_done(&host->xfer_done));
 
 		/* start the command first*/
 		if (msdc_command_start(host, cmd, CMD_TIMEOUT) != 0)
@@ -693,7 +697,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		/* for read, the data coming too fast, then CRC error
 		 *  start DMA no business with CRC.
 		 */
-		//init_completion(&host->xfer_done);
 		msdc_dma_start(host);
 
 		spin_unlock(&host->lock);
@@ -1708,6 +1711,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 	msdc_init_gpd_bd(host, &host->dma);
 
+	init_completion(&host->cmd_done);
+	init_completion(&host->xfer_done);
 	INIT_DELAYED_WORK(&host->card_delaywork, msdc_tasklet_card);
 	spin_lock_init(&host->lock);
 	msdc_init_hw(host);
-- 
2.20.1

