Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9910C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D977206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+lBLGhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D977206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeHVMHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:07:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44074 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHVMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:07:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so608996pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yt9+dPyUroIEjLZq89UbN/gvGQORY5hKketO3wmqZcE=;
        b=I+lBLGhJFLjNuebfF6xs7U7AeLmHJCez8SkfijWBcbO9XhFse3/kW+6FFFaSxiAPN8
         V33BL7F/By9KJpgq4BXfg9bmo/1CoXmowzqc1oJ3gkDbfmet2Duous6X5VFECGBogjSu
         iEDeSuRQFTRzLC+JOSmwwruSmi1lZjChsYRpQ6rWGq9LtAMw+bv5avHMP/rFxtTz+yzT
         XHRC8ZrPpiez9jJ8ze8j9Cuzge3Pjou6VhTuGK5cw066jdFUtWPoZYlGkBR6GlqvEJZ3
         tKkSTKS8TTvyu3QWkkq4eHx975KGOfteDeuZ1mcI1EHnoaxI+7f9eoXT1sDPFKr9wXq4
         HDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yt9+dPyUroIEjLZq89UbN/gvGQORY5hKketO3wmqZcE=;
        b=Ji6XpnXxC9TmPPaA46xLCSb0AIFTm/lJivlia372k53YOWuRus78FWr6uDGnXTinE1
         7Jb/nZbh7inZSx4NX72i37A+3F+61/8koDI7IhUqkAJgblctnJliVQZ1LlLf7hW1sGLe
         sUPiD+PH7AcHJdhX4kyyLSVrSFNsXe61bt+YoF/smheWJxtHzGwLqN7nyxxCowSJvA5F
         etZY+AKs0E20oM70MI/0Sh4OM2X2YOJlCt45776up9jFtIUGy0DlHiJegXNBCil4laeo
         pRqwBW4S3aeieUTIWYeYUI0FBK5i0r14IM44WZKPkgF53YZGDFVMOUtgfAHu0mfJwFmE
         3qtg==
X-Gm-Message-State: AOUpUlF+3OAtXZY6XzHRZXl4oscpxwv/KPmhl9irVIAfhN8MX/IXUjDI
        ycBzPfYXi+rsY/CXzZmTxPA=
X-Google-Smtp-Source: AA+uWPzXIon0VI8mi++Z5VH/kKWQ6duiMQp5M0WeKnJxLdLK20Nh0tSdBdm9ALWbXs+HW27/yvDE0Q==
X-Received: by 2002:a62:c00c:: with SMTP id x12-v6mr56719309pff.216.1534927394938;
        Wed, 22 Aug 2018 01:43:14 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id e14-v6sm1487324pff.128.2018.08.22.01.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 01:43:14 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:13:07 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 2/4] staging: mt7621-mmc: Fix debug macro ERR_MSG and its
 usages
Message-ID: <52fcb157ea0de00e7c08d90ebd8a5c1db3c33bae.1534923403.git.nishadkamdar@gmail.com>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1534923403.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all usages of ERR_MSG with with dev_<level> without __func__
or __LINE__ or current->comm and current->pid. Remove the do {}
while(0) loop for the single statement macro. Drop ERR_MSG from dbg.h.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h |   6 --
 drivers/staging/mt7621-mmc/sd.c  | 128 ++++++++++++++++++++++---------
 2 files changed, 90 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index c56fb896617a..71295df59ed0 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -109,12 +109,6 @@ do { \
  *}
  */
 
-#define ERR_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
-} while (0);
-
 #if 1
 //defined CONFIG_MTK_MMC_CD_POLL
 #define INIT_MSG(fmt, args...)
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 04d23cc7cd4a..6b2c72fc61f2 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -466,7 +466,8 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	//u8  clksrc = hw->clk_src;
 
 	if (!hz) { // set mmc system clock to 0 ?
-		//ERR_MSG("set mclk to 0!!!");
+		//dev_err(mmc_dev(host->mmc), "%d -> set mclk to 0!!!\n",
+		//	  host->id);
 		msdc_reset_hw(host);
 		return;
 	}
@@ -521,7 +522,7 @@ static void msdc_abort_data(struct msdc_host *host)
 {
 	struct mmc_command *stop = host->mrq->stop;
 
-	ERR_MSG("Need to Abort.");
+	dev_err(mmc_dev(host->mmc), "%d -> Need to Abort.\n", host->id);
 
 	msdc_reset_hw(host);
 	msdc_clr_fifo(host);
@@ -530,7 +531,8 @@ static void msdc_abort_data(struct msdc_host *host)
 	// need to check FIFO count 0 ?
 
 	if (stop) {  /* try to stop, but may not success */
-		ERR_MSG("stop when abort CMD<%d>", stop->opcode);
+		dev_err(mmc_dev(host->mmc), "%d -> stop when abort CMD<%d>\n",
+			host->id, stop->opcode);
 		(void)msdc_do_command(host, stop, 0, CMD_TIMEOUT);
 	}
 
@@ -688,13 +690,17 @@ static void msdc_pm(pm_message_t state, void *data)
 
 	} else if (evt == PM_EVENT_RESUME || evt == PM_EVENT_USER_RESUME) {
 		if (!host->suspend) {
-			//ERR_MSG("warning: already resume");
+			//dev_err(mmc_dev(host->mmc),
+			//	  "%d -> warning: already resume\n",
+			//	  host->id);
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
 
@@ -812,7 +818,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 				break;
 
 			if (time_after(jiffies, tmo)) {
-				ERR_MSG("XXX cmd_busy timeout: before CMD<%d>", opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX cmd_busy timeout: before CMD<%d>\n",
+					host->id, opcode);
 				cmd->error = -ETIMEDOUT;
 				msdc_reset_hw(host);
 				goto end;
@@ -823,7 +831,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
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
@@ -862,7 +872,9 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 
 	spin_unlock(&host->lock);
 	if (!wait_for_completion_timeout(&host->cmd_done, 10 * timeout)) {
-		ERR_MSG("XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>", opcode, cmd->arg);
+		dev_err(mmc_dev(host->mmc),
+			"%d -> XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>\n",
+			host->id, opcode, cmd->arg);
 		cmd->error = -ETIMEDOUT;
 		msdc_reset_hw(host);
 	}
@@ -1125,15 +1137,22 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
@@ -1200,7 +1219,10 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->stop && mrq->stop->error)
 		host->error |= 0x100;
 
-	//if (host->error) ERR_MSG("host->error<%d>", host->error);
+	//if (host->error)
+	//	dev_err(mmc_dev(host->mmc),
+	//		"%d -> host->error<%d>\n",
+	//		host->id, host->error);
 
 	return host->error;
 }
@@ -1260,19 +1282,27 @@ static int msdc_tune_cmdrsp(struct msdc_host *host, struct mmc_command *cmd)
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
 
@@ -1325,7 +1355,10 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1336,10 +1369,13 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1348,8 +1384,11 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1458,13 +1497,18 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
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
 
@@ -1473,8 +1517,11 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1508,7 +1555,8 @@ static int msdc_get_card_status(struct mmc_host *mmc, struct msdc_host *host, u3
 	if (mmc->card) {
 		cmd.arg = mmc->card->rca << 16;
 	} else {
-		ERR_MSG("cmd13 mmc card is null");
+		dev_err(mmc_dev(host->mmc), "%d -> cmd13 mmc card is null\n",
+			host->id);
 		cmd.arg = host->app_cmd_arg;
 	}
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
@@ -1535,7 +1583,8 @@ static int msdc_check_busy(struct mmc_host *mmc, struct msdc_host *host)
 		if (err)
 			return err;
 		/* need cmd12? */
-		ERR_MSG("cmd<13> resp<0x%x>", status);
+		dev_err(mmc_dev(host->mmc), "%d -> cmd<13> resp<0x%x>\n",
+			host->id, status);
 	} while (R1_CURRENT_STATE(status) == 7);
 
 	return err;
@@ -1559,7 +1608,9 @@ static int msdc_tune_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -2289,7 +2340,8 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	BUG_ON(!host);
 
-	ERR_MSG("removed !!!");
+	dev_err(mmc_dev(host->mmc), "%d -> removed !!!\n",
+		host->id);
 
 	platform_set_drvdata(pdev, NULL);
 	mmc_remove_host(host->mmc);
-- 
2.17.1

