Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F4EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDE1214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndJThfiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDE1214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeHWVAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:00:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36856 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeHWVAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:00:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17-v6so2964517pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w5hukTJxb3ezS8xTLyHmxRGX/5DIyb26QwctsUXdZIU=;
        b=ndJThfiOBwNvOSER5Di7Tf32jaae4y1+VTQn1n0Wj0llgXIEDqYy4ILab/6edSXBNp
         AHD/xKyKsExWuVjwu9PSV6Inuk+yIaANiA3+6gxREoQK7OzfLU8qJWzIP1GOaXkLdcdp
         2OgbTtOocLnNLGuIT/LzvaErR/vewfLHCOBq4kn9pcZDQcss6ZV4rU6/Z2sOVs60ZqSb
         H5pyxynQKLCJUsE6a3fCcmIOE9Kvk1F7EoDhX5mGibrFkP7pEtFnleBWO/x3SxMzEv0J
         BXAw9B25ioukR3stfPYqCcaVZjs6fID6DaJztOQsni0Kw3chUuTzn2lqi58a7u5gSdQv
         VcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w5hukTJxb3ezS8xTLyHmxRGX/5DIyb26QwctsUXdZIU=;
        b=fj04cWHpjO2e4d4jqy7QQQn5ttXZZboHqkBRT74mvg0rstZXsSw055tXZxy/N1n/+r
         suFWArUnhXJb6A8X+AnX+GGQGqaWxthVPas2R1w8jEuFQNsh/STDF3Op39M1HvVTsy0X
         T4h/ADT5O9/eI88MJZZ16rtqdXq7DV3GvWwc+BgWzSWpHQmTYqgGMZ4oB6wRMD7DVb+0
         aZzHiatGcs+ffU+ucNFInbAG6alCJQIXM+TNK2+p5eTmKeRXXEx1cKBzq/SMjisbe/LZ
         SadUhuQUwwHQKKQjI1hiPjwLUh9+EvEbHrMMnoEQSCco7k0L/Z1t7Q77lsCsXtjwEIFN
         xQyA==
X-Gm-Message-State: AOUpUlElhi1LUZwo6Ymtv0lCCMOgLW/cvWKi7k5Oas1rx3zjSV6RrQ1u
        332bfr2VZivUrhLEJWeQ7Zg=
X-Google-Smtp-Source: AA+uWPxXO3vaJ05JFNtFzBRsk5YvtmD5AIYZVbdNS6UAYVSkxg3Oq5FBkU8ihh1a+l2i5FGFEXeTXw==
X-Received: by 2002:a62:6b88:: with SMTP id g130-v6mr21675029pfc.140.1535045409396;
        Thu, 23 Aug 2018 10:30:09 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id z11-v6sm7020669pff.162.2018.08.23.10.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:30:08 -0700 (PDT)
Date:   Thu, 23 Aug 2018 23:00:02 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 2/4] staging: mt7621-mmc: Fix debug macro ERR_MSG and its
 usages
Message-ID: <8df8527b0b1747e11764f4ed669de99561afe64d.1535038495.git.nishadkamdar@gmail.com>
References: <cover.1535038494.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535038494.git.nishadkamdar@gmail.com>
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
Changes in v5:
  - Remove commented ERR_MSG() usage.
---
 drivers/staging/mt7621-mmc/dbg.h |   6 --
 drivers/staging/mt7621-mmc/sd.c  | 120 +++++++++++++++++++++----------
 2 files changed, 81 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 6f6b4505337f..28c0cf76664f 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -104,12 +104,6 @@ do { \
 
 #define N_MSG(evt, fmt, args...)
 
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
index 04d23cc7cd4a..dcd036914467 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -466,7 +466,6 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	//u8  clksrc = hw->clk_src;
 
 	if (!hz) { // set mmc system clock to 0 ?
-		//ERR_MSG("set mclk to 0!!!");
 		msdc_reset_hw(host);
 		return;
 	}
@@ -521,7 +520,7 @@ static void msdc_abort_data(struct msdc_host *host)
 {
 	struct mmc_command *stop = host->mrq->stop;
 
-	ERR_MSG("Need to Abort.");
+	dev_err(mmc_dev(host->mmc), "%d -> Need to Abort.\n", host->id);
 
 	msdc_reset_hw(host);
 	msdc_clr_fifo(host);
@@ -530,7 +529,8 @@ static void msdc_abort_data(struct msdc_host *host)
 	// need to check FIFO count 0 ?
 
 	if (stop) {  /* try to stop, but may not success */
-		ERR_MSG("stop when abort CMD<%d>", stop->opcode);
+		dev_err(mmc_dev(host->mmc), "%d -> stop when abort CMD<%d>\n",
+			host->id, stop->opcode);
 		(void)msdc_do_command(host, stop, 0, CMD_TIMEOUT);
 	}
 
@@ -688,13 +688,14 @@ static void msdc_pm(pm_message_t state, void *data)
 
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
 
@@ -812,7 +813,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 				break;
 
 			if (time_after(jiffies, tmo)) {
-				ERR_MSG("XXX cmd_busy timeout: before CMD<%d>", opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX cmd_busy timeout: before CMD<%d>\n",
+					host->id, opcode);
 				cmd->error = -ETIMEDOUT;
 				msdc_reset_hw(host);
 				goto end;
@@ -823,7 +826,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
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
@@ -862,7 +867,9 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 
 	spin_unlock(&host->lock);
 	if (!wait_for_completion_timeout(&host->cmd_done, 10 * timeout)) {
-		ERR_MSG("XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>", opcode, cmd->arg);
+		dev_err(mmc_dev(host->mmc),
+			"%d -> XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>\n",
+			host->id, opcode, cmd->arg);
 		cmd->error = -ETIMEDOUT;
 		msdc_reset_hw(host);
 	}
@@ -1125,15 +1132,22 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
@@ -1200,8 +1214,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->stop && mrq->stop->error)
 		host->error |= 0x100;
 
-	//if (host->error) ERR_MSG("host->error<%d>", host->error);
-
 	return host->error;
 }
 
@@ -1260,19 +1272,27 @@ static int msdc_tune_cmdrsp(struct msdc_host *host, struct mmc_command *cmd)
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
 
@@ -1325,7 +1345,10 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1336,10 +1359,13 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1348,8 +1374,11 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1458,13 +1487,18 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
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
 
@@ -1473,8 +1507,11 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1508,7 +1545,8 @@ static int msdc_get_card_status(struct mmc_host *mmc, struct msdc_host *host, u3
 	if (mmc->card) {
 		cmd.arg = mmc->card->rca << 16;
 	} else {
-		ERR_MSG("cmd13 mmc card is null");
+		dev_err(mmc_dev(host->mmc), "%d -> cmd13 mmc card is null\n",
+			host->id);
 		cmd.arg = host->app_cmd_arg;
 	}
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
@@ -1535,7 +1573,8 @@ static int msdc_check_busy(struct mmc_host *mmc, struct msdc_host *host)
 		if (err)
 			return err;
 		/* need cmd12? */
-		ERR_MSG("cmd<13> resp<0x%x>", status);
+		dev_err(mmc_dev(host->mmc), "%d -> cmd<13> resp<0x%x>\n",
+			host->id, status);
 	} while (R1_CURRENT_STATE(status) == 7);
 
 	return err;
@@ -1559,7 +1598,9 @@ static int msdc_tune_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -2289,7 +2330,8 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	BUG_ON(!host);
 
-	ERR_MSG("removed !!!");
+	dev_err(mmc_dev(host->mmc), "%d -> removed !!!\n",
+		host->id);
 
 	platform_set_drvdata(pdev, NULL);
 	mmc_remove_host(host->mmc);
-- 
2.17.1

