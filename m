Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0E320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkU2d9Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0E320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeIAC3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:29:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36630 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIAC3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:29:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id e11-v6so6059863plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhrZkuDy75ELjUgT23FQnYAEkT6SUS0uytUtJuejBXU=;
        b=IkU2d9FohwhtVPKr0mVWiALs2EB0D6TNl6QXvdoo73yZHVGvC9Tn9PEOeNxWI+3/JV
         BTRsmcTE5XUndx+c8RSaXMoip+JEeH8MEVTlUAKPIpeMURkK5FV5ltcPjrkGEYDPK51e
         ea2Z58nIfso3jzMauI0Kq5Htm8ybdweqAOjd81RtO0LJ7byiedKxWBs/OttBa/GqWRg+
         mGvsKxLHoultBTj5lEyLJ+dfUXjFot6gjVG4K53dzChxh3GkqJiteTW6GPRVuHhwNHVy
         WVuqw9v9xkSfgSHJP6jC/RS08Q2u1bYUX/7xRDBl6YUehbnlta2brt2I+9Dxsvmj4U5Q
         UcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhrZkuDy75ELjUgT23FQnYAEkT6SUS0uytUtJuejBXU=;
        b=moN3WuP2OvlPVNFWDXB1L1sXjK+85AFupZCUR/W/f5N7h7T9lN8aNyy613h35BaSOc
         6dgwpjYtm/EU1JZRXc6qEww3yeJK8YnMxVENOgf56l7vc3N5jIonLtmIL69xdpJpxhjy
         F9WTLnia8UizzncJsUcU4Qt6lqNExj8qRWkKMQN1b45/d89rKuAqU+TQuoc2H2lll9PO
         NB4kiIKZICAt3FQ3kCIJDWC9rpGByE4fdxWn9/5K+gXeEGL7EWnicn+5YZykFZcYwlhc
         rQ4O9C5gAXhQA5J939KQYVSkED3HbCI5Ezlh9nzxKqxMvqq/h3DtoXcQmTpZP90KEiju
         OT/Q==
X-Gm-Message-State: APzg51AoFp+KzKQgd0zEUNdvCxmLfvym6bNxA123wcfYpuzBhD9rEXHi
        G89aZjXCey3xEjPHnZmLcpE=
X-Google-Smtp-Source: ANB0VdZD2mhMksFp8x9HiL56WTqOCMva/Nsg6D+DkTI60hDulWBKeKTvGAS/rA9w5y5HQLUydWRn8w==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14-v6mr17469126plo.213.1535753989467;
        Fri, 31 Aug 2018 15:19:49 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id z5-v6sm16181464pfh.83.2018.08.31.15.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:19:49 -0700 (PDT)
Date:   Sat, 1 Sep 2018 03:49:43 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 2/3] staging: mt7621-mmc: Fix debug macro ERR_MSG and its
 usages
Message-ID: <2c1539f5d4cb3ed1d7af3bb163f499b4c0d6dee7.1535752537.git.nishadkamdar@gmail.com>
References: <cover.1535752537.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535752537.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all usages of ERR_MSG with with dev_<level> without __func__
or __LINE__ or current->comm and current->pid. Remove the do {}
while(0) loop for the single statement macro. Delete commented
ERR_MSG() usage. Drop ERR_MSG from dbg.h. Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v6:
  - No change
Changes in v5:
  - Remove commented ERR_MSG() usage.
---
 drivers/staging/mt7621-mmc/dbg.h |   6 --
 drivers/staging/mt7621-mmc/sd.c  | 120 +++++++++++++++++++++----------
 2 files changed, 81 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 9152db30a2ed..79914d98c573 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -102,12 +102,6 @@ do { \
 } while (0)
 #endif /* end of +++ */
 
-#define ERR_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
-} while (0);
-
 #if 1
 //defined CONFIG_MTK_MMC_CD_POLL
 #define IRQ_MSG(fmt, args...)
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 0154117fae15..7474f9ed7b5b 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -322,7 +322,6 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	//u8  clksrc = hw->clk_src;
 
 	if (!hz) { // set mmc system clock to 0 ?
-		//ERR_MSG("set mclk to 0!!!");
 		msdc_reset_hw(host);
 		return;
 	}
@@ -373,7 +372,7 @@ static void msdc_abort_data(struct msdc_host *host)
 {
 	struct mmc_command *stop = host->mrq->stop;
 
-	ERR_MSG("Need to Abort.");
+	dev_err(mmc_dev(host->mmc), "%d -> Need to Abort.\n", host->id);
 
 	msdc_reset_hw(host);
 	msdc_clr_fifo(host);
@@ -382,7 +381,8 @@ static void msdc_abort_data(struct msdc_host *host)
 	// need to check FIFO count 0 ?
 
 	if (stop) {  /* try to stop, but may not success */
-		ERR_MSG("stop when abort CMD<%d>", stop->opcode);
+		dev_err(mmc_dev(host->mmc), "%d -> stop when abort CMD<%d>\n",
+			host->id, stop->opcode);
 		(void)msdc_do_command(host, stop, 0, CMD_TIMEOUT);
 	}
 
@@ -523,13 +523,14 @@ static void msdc_pm(pm_message_t state, void *data)
 
 	} else if (evt == PM_EVENT_RESUME || evt == PM_EVENT_USER_RESUME) {
 		if (!host->suspend) {
-			//ERR_MSG("warning: already resume");
 			return;
 		}
 
 		/* No PM resume when USR suspend */
 		if (evt == PM_EVENT_RESUME && host->pm_state.event == PM_EVENT_USER_SUSPEND) {
-			ERR_MSG("PM Resume when in USR Suspend");		/* won't happen. */
+			dev_err(mmc_dev(host->mmc),
+				"%d -> PM Resume when in USR Suspend\n",
+				host->id); /* won't happen. */
 			return;
 		}
 
@@ -645,7 +646,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 				break;
 
 			if (time_after(jiffies, tmo)) {
-				ERR_MSG("XXX cmd_busy timeout: before CMD<%d>", opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX cmd_busy timeout: before CMD<%d>\n",
+					host->id, opcode);
 				cmd->error = -ETIMEDOUT;
 				msdc_reset_hw(host);
 				goto end;
@@ -656,7 +659,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 			if (!sdc_is_busy())
 				break;
 			if (time_after(jiffies, tmo)) {
-				ERR_MSG("XXX sdc_busy timeout: before CMD<%d>", opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX sdc_busy timeout: before CMD<%d>\n",
+					host->id, opcode);
 				cmd->error = -ETIMEDOUT;
 				msdc_reset_hw(host);
 				goto end;
@@ -695,7 +700,9 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 
 	spin_unlock(&host->lock);
 	if (!wait_for_completion_timeout(&host->cmd_done, 10 * timeout)) {
-		ERR_MSG("XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>", opcode, cmd->arg);
+		dev_err(mmc_dev(host->mmc),
+			"%d -> XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>\n",
+			host->id, opcode, cmd->arg);
 		cmd->error = -ETIMEDOUT;
 		msdc_reset_hw(host);
 	}
@@ -909,15 +916,22 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 		spin_unlock(&host->lock);
 		if (!wait_for_completion_timeout(&host->xfer_done, DAT_TIMEOUT)) {
-			ERR_MSG("XXX CMD<%d> wait xfer_done<%d> timeout!!", cmd->opcode, data->blocks * data->blksz);
-			ERR_MSG("    DMA_SA   = 0x%x",
-				readl(host->base + MSDC_DMA_SA));
-			ERR_MSG("    DMA_CA   = 0x%x",
-				readl(host->base + MSDC_DMA_CA));
-			ERR_MSG("    DMA_CTRL = 0x%x",
-				readl(host->base + MSDC_DMA_CTRL));
-			ERR_MSG("    DMA_CFG  = 0x%x",
-				readl(host->base + MSDC_DMA_CFG));
+			dev_err(mmc_dev(host->mmc),
+				"%d -> XXX CMD<%d> wait xfer_done<%d> timeout!!\n",
+				host->id, cmd->opcode,
+				data->blocks * data->blksz);
+			dev_err(mmc_dev(host->mmc),
+				"%d ->     DMA_SA   = 0x%x\n",
+				host->id, readl(host->base + MSDC_DMA_SA));
+			dev_err(mmc_dev(host->mmc),
+				"%d ->     DMA_CA   = 0x%x\n",
+				host->id, readl(host->base + MSDC_DMA_CA));
+			dev_err(mmc_dev(host->mmc),
+				"%d ->     DMA_CTRL = 0x%x\n",
+				host->id, readl(host->base + MSDC_DMA_CTRL));
+			dev_err(mmc_dev(host->mmc),
+				"%d ->     DMA_CFG  = 0x%x\n",
+				host->id, readl(host->base + MSDC_DMA_CFG));
 			data->error = -ETIMEDOUT;
 
 			msdc_reset_hw(host);
@@ -979,8 +993,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->stop && mrq->stop->error)
 		host->error |= 0x100;
 
-	//if (host->error) ERR_MSG("host->error<%d>", host->error);
-
 	return host->error;
 }
 
@@ -1039,19 +1051,27 @@ static int msdc_tune_cmdrsp(struct msdc_host *host, struct mmc_command *cmd)
 			if (host->app_cmd) {
 				result = msdc_app_cmd(host->mmc, host);
 				if (result) {
-					ERR_MSG("TUNE_CMD app_cmd<%d> failed: RESP_RXDLY<%d>,R_SMPL<%d>",
-						host->mrq->cmd->opcode, cur_rrdly, cur_rsmpl);
+					dev_err(mmc_dev(host->mmc),
+						"%d -> TUNE_CMD app_cmd<%d> failed: RESP_RXDLY<%d>,R_SMPL<%d>\n",
+						host->id,
+						host->mrq->cmd->opcode,
+						cur_rrdly, cur_rsmpl);
 					continue;
 				}
 			}
 			result = msdc_do_command(host, cmd, 0, CMD_TIMEOUT); // not tune.
-			ERR_MSG("TUNE_CMD<%d> %s PAD_CMD_RESP_RXDLY[26:22]<%d> R_SMPL[1]<%d>", cmd->opcode,
-				(result == 0) ? "PASS" : "FAIL", cur_rrdly, cur_rsmpl);
+			dev_err(mmc_dev(host->mmc),
+				"%d -> TUNE_CMD<%d> %s PAD_CMD_RESP_RXDLY[26:22]<%d> R_SMPL[1]<%d>\n",
+				host->id, cmd->opcode,
+				(result == 0) ? "PASS" : "FAIL", cur_rrdly,
+				cur_rsmpl);
 
 			if (result == 0)
 				return 0;
 			if (result != -EIO) {
-				ERR_MSG("TUNE_CMD<%d> Error<%d> not -EIO", cmd->opcode, result);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> TUNE_CMD<%d> Error<%d> not -EIO\n",
+					host->id, cmd->opcode, result);
 				return result;
 			}
 
@@ -1104,7 +1124,10 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
 			if (host->app_cmd) {
 				result = msdc_app_cmd(host->mmc, host);
 				if (result) {
-					ERR_MSG("TUNE_BREAD app_cmd<%d> failed", host->mrq->cmd->opcode);
+					dev_err(mmc_dev(host->mmc),
+						"%d -> TUNE_BREAD app_cmd<%d> failed\n",
+						host->id,
+						host->mrq->cmd->opcode);
 					continue;
 				}
 			}
@@ -1115,10 +1138,13 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
 				      &dcrc); /* RO */
 			if (!ddr)
 				dcrc &= ~SDC_DCRC_STS_NEG;
-			ERR_MSG("TUNE_BREAD<%s> dcrc<0x%x> DATRDDLY0/1<0x%x><0x%x> dsmpl<0x%x>",
-				(result == 0 && dcrc == 0) ? "PASS" : "FAIL", dcrc,
-				readl(host->base + MSDC_DAT_RDDLY0),
-				readl(host->base + MSDC_DAT_RDDLY1), cur_dsmpl);
+			dev_err(mmc_dev(host->mmc),
+				"%d -> TUNE_BREAD<%s> dcrc<0x%x> DATRDDLY0/1<0x%x><0x%x> dsmpl<0x%x>\n",
+				host->id,
+				(result == 0 && dcrc == 0) ? "PASS" : "FAIL",
+				dcrc, readl(host->base + MSDC_DAT_RDDLY0),
+				readl(host->base + MSDC_DAT_RDDLY1),
+				cur_dsmpl);
 
 			/* Fix me: result is 0, but dcrc is still exist */
 			if (result == 0 && dcrc == 0) {
@@ -1127,8 +1153,11 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
 				/* there is a case: command timeout, and data phase not processed */
 				if (mrq->data->error != 0 &&
 				    mrq->data->error != -EIO) {
-					ERR_MSG("TUNE_READ: result<0x%x> cmd_error<%d> data_error<%d>",
-						result, mrq->cmd->error, mrq->data->error);
+					dev_err(mmc_dev(host->mmc),
+						"%d -> TUNE_READ: result<0x%x> cmd_error<%d> data_error<%d>\n",
+						host->id, result,
+						mrq->cmd->error,
+						mrq->data->error);
 					goto done;
 				}
 			}
@@ -1237,13 +1266,18 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
 				if (host->app_cmd) {
 					result = msdc_app_cmd(host->mmc, host);
 					if (result) {
-						ERR_MSG("TUNE_BWRITE app_cmd<%d> failed", host->mrq->cmd->opcode);
+						dev_err(mmc_dev(host->mmc),
+							"%d -> TUNE_BWRITE app_cmd<%d> failed\n",
+							host->id,
+							host->mrq->cmd->opcode);
 						continue;
 					}
 				}
 				result = msdc_do_request(mmc, mrq);
 
-				ERR_MSG("TUNE_BWRITE<%s> DSPL<%d> DATWRDLY<%d> MSDC_DAT_RDDLY0<0x%x>",
+				dev_err(mmc_dev(host->mmc),
+					"%d -> TUNE_BWRITE<%s> DSPL<%d> DATWRDLY<%d> MSDC_DAT_RDDLY0<0x%x>\n",
+					host->id,
 					result == 0 ? "PASS" : "FAIL",
 					cur_dsmpl, cur_wrrdly, cur_rxdly0);
 
@@ -1252,8 +1286,11 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
 				} else {
 					/* there is a case: command timeout, and data phase not processed */
 					if (mrq->data->error != -EIO) {
-						ERR_MSG("TUNE_READ: result<0x%x> cmd_error<%d> data_error<%d>",
-							result, mrq->cmd->error, mrq->data->error);
+						dev_err(mmc_dev(host->mmc),
+							"%d -> TUNE_READ: result<0x%x> cmd_error<%d> data_error<%d>\n",
+							host->id, result,
+							mrq->cmd->error,
+							mrq->data->error);
 						goto done;
 					}
 				}
@@ -1287,7 +1324,8 @@ static int msdc_get_card_status(struct mmc_host *mmc, struct msdc_host *host, u3
 	if (mmc->card) {
 		cmd.arg = mmc->card->rca << 16;
 	} else {
-		ERR_MSG("cmd13 mmc card is null");
+		dev_err(mmc_dev(host->mmc), "%d -> cmd13 mmc card is null\n",
+			host->id);
 		cmd.arg = host->app_cmd_arg;
 	}
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
@@ -1314,7 +1352,8 @@ static int msdc_check_busy(struct mmc_host *mmc, struct msdc_host *host)
 		if (err)
 			return err;
 		/* need cmd12? */
-		ERR_MSG("cmd<13> resp<0x%x>", status);
+		dev_err(mmc_dev(host->mmc), "%d -> cmd<13> resp<0x%x>\n",
+			host->id, status);
 	} while (R1_CURRENT_STATE(status) == 7);
 
 	return err;
@@ -1338,7 +1377,9 @@ static int msdc_tune_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	} else {
 		ret = msdc_check_busy(mmc, host);
 		if (ret) {
-			ERR_MSG("XXX cmd13 wait program done failed");
+			dev_err(mmc_dev(host->mmc),
+				"%d -> XXX cmd13 wait program done failed\n",
+				host->id);
 			return ret;
 		}
 		/* CRC and TO */
@@ -2031,7 +2072,8 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	BUG_ON(!host);
 
-	ERR_MSG("removed !!!");
+	dev_err(mmc_dev(host->mmc), "%d -> removed !!!\n",
+		host->id);
 
 	platform_set_drvdata(pdev, NULL);
 	mmc_remove_host(host->mmc);
-- 
2.17.1

