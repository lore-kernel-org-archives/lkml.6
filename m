Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F1C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606B621523
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFEplQHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606B621523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeHSNQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 09:16:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38343 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeHSNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 09:16:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id k8-v6so1376390pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=A3q7Ly0pxUElIu3S4y+mvBMgga/15NQkLxGWjDVeeM8=;
        b=HFEplQHh5aS3dFwTj1vTZMi2hZJyUSXmwnYVF0NBd+3/m5GPtp2VM4OlwF0B8wtLU0
         G40DjTKsghscDTEd3sXVjCRYKnwg+wnIlk9KTn7yktGsnyiZhxOooWvUyL415p7CsaAk
         tZnRHNibS/e4kALDxuT292dj9QNxNZGJPqCKy0kij4VJIAR7sZKGT/ihHDO6TlCduQXQ
         vwLE3Tp62+VlVI+TLI+XVTrtEh0/gdVEp4h5GMkOev4D1h3q0LAtPjDhYNk0ChVy5np4
         dwtAVYS8NDUVdvtOEwxyQIMgqmoDrhcIqIPPeV5fVlmAKuuCXSDVFtVRsVEG9IPpImGJ
         Ib5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A3q7Ly0pxUElIu3S4y+mvBMgga/15NQkLxGWjDVeeM8=;
        b=YG1dReacf7bcD71fBePXm9wn/JdWyLtCRlLCRMUrVG5o4eIckKdaWyh8WlFEcKCy12
         Moxw117Iu13rvByaS/GkIQAy3jl3mwozt4JGOw7AK4v4HbiCajERwPPVk/a7Vds8Vg4H
         zk4Fcie9cR3zFFg+664ziQcrBsYaOeNnk+a7pQ57ljS1C1g0f0v7OyxtuJycH6t59VKX
         jJN2rBfsut7/37Sd0K/JdXx3qymhVxQhHHaG4p2+R8zw6/9y8wSyUcKHqeBNquknGt4S
         rwt2rWg+3f+IwElHbkz44sYvqAQmmUaZ6wd4yJcPOgZEc/FYFOT6hMUW6ZZ62ojEq7KW
         QNog==
X-Gm-Message-State: AOUpUlHT/ncePlZ7AzWTTwgVJkDXbknJoXbUQMcquMFR8tbEAXW+Kh/8
        hvBK3fHOqZPLGh3a3lbNrkU=
X-Google-Smtp-Source: AA+uWPwg7RKuxroa7ZcOX6bl9SvM9mJ/hjNH7hOvXOyTQ9eJRgb+V4leJL6DhvMRo8daT6SlBdY8CQ==
X-Received: by 2002:a63:ed4f:: with SMTP id m15-v6mr39153238pgk.147.1534673110746;
        Sun, 19 Aug 2018 03:05:10 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id s14-v6sm12419996pfj.105.2018.08.19.03.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 03:05:10 -0700 (PDT)
Date:   Sun, 19 Aug 2018 15:35:02 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <20180819100458.GA13296@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed four debug macros and their usages. Replaced printk with
dev_<level> without __func__ or __LINE__ or current->comm and
current->pid. Further removed the do {} while(0) loop for single
statement macros.
Out of the four, replaced all usages of ERR_MSG and IRQ_MSG with
dev_err() in the code itself and dropped them from dbg.h.
Removed all INIT_MSG usages and dropped it from dgb.h.
Issues found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v3:
  - Replace usages of ERR_MSG and IRQ_MSG with dev_err() in code itself.
  - Remove all INIT_MSG usages.
  - Drop ERR_MSG, INIT_MSG and IRQ_MSG from dbg.h.

Changes in v2:
  - Replace printk with dev_<level>.
  - Remove __func__, __LINE__, current->comm, current->pid from arguments.
  - Remove the do {} while(0) loop from these macros.
  - Modify commit message to include other changes.
---
 drivers/staging/mt7621-mmc/dbg.h |  36 +------
 drivers/staging/mt7621-mmc/sd.c  | 180 ++++++++++++++++++++-----------
 2 files changed, 121 insertions(+), 95 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 2f2c56b73987..5458dae5dc03 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -104,38 +104,10 @@ do { \
 
 #define N_MSG(evt, fmt, args...)
 /*
-do {    \
-    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
-        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
-    } \
-} while(0)
-*/
-
-#define ERR_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
-} while (0);
-
-#if 1
-//defined CONFIG_MTK_MMC_CD_POLL
-#define INIT_MSG(fmt, args...)
-#define IRQ_MSG(fmt, args...)
-#else
-#define INIT_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
-} while (0);
-
-/* PID in ISR in not corrent */
-#define IRQ_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
-	       host->id,  ##args, __FUNCTION__, __LINE__);	\
-} while (0);
-#endif
+ *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
+ *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
+ *}
+ */
 
 void msdc_debug_proc_init(void);
 
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 04d23cc7cd4a..5cb6bc36e78b 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -187,12 +187,10 @@ static u32 hclks[] = {50000000}; /* +/- by chhung */
 //============================================
 #define msdc_vcore_on(host) \
 	do {								\
-		INIT_MSG("[+]VMC ref. count<%d>", ++host->pwr_ref);	\
 		(void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD");	\
 	} while (0)
 #define msdc_vcore_off(host) \
 	do {								\
-		INIT_MSG("[-]VMC ref. count<%d>", --host->pwr_ref);	\
 		(void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD");		\
 	} while (0)
 
@@ -422,7 +420,9 @@ static void msdc_tasklet_card(struct work_struct *work)
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
 
-	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
+	dev_err(mmc_dev(host->mmc),
+		"%d -> card found<%s>\n",
+		host->id, inserted ? "inserted" : "removed");
 #endif
 
 	spin_unlock(&host->lock);
@@ -439,7 +439,6 @@ static void msdc_select_clksrc(struct msdc_host *host, unsigned char clksrc)
 	u32 val;
 
 	BUG_ON(clksrc > 3);
-	INIT_MSG("set clock source to <%d>", clksrc);
 
 	val = readl(host->base + MSDC_CLKSRC_REG);
 	if (readl(host->base + MSDC_ECO_VER) >= 4) {
@@ -466,7 +465,8 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	//u8  clksrc = hw->clk_src;
 
 	if (!hz) { // set mmc system clock to 0 ?
-		//ERR_MSG("set mclk to 0!!!");
+		//dev_err(mmc_dev(host->mmc), "%d -> set mclk to 0!!!\n",
+		//	  host->id);
 		msdc_reset_hw(host);
 		return;
 	}
@@ -509,10 +509,6 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	host->mclk = hz;
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks); // need?
 
-	INIT_MSG("================");
-	INIT_MSG("!!! Set<%dKHz> Source<%dKHz> -> sclk<%dKHz>", hz / 1000, hclk / 1000, sclk / 1000);
-	INIT_MSG("================");
-
 	msdc_irq_restore(flags);
 }
 
@@ -521,7 +517,7 @@ static void msdc_abort_data(struct msdc_host *host)
 {
 	struct mmc_command *stop = host->mrq->stop;
 
-	ERR_MSG("Need to Abort.");
+	dev_err(mmc_dev(host->mmc), "%d -> Need to Abort.\n", host->id);
 
 	msdc_reset_hw(host);
 	msdc_clr_fifo(host);
@@ -530,7 +526,8 @@ static void msdc_abort_data(struct msdc_host *host)
 	// need to check FIFO count 0 ?
 
 	if (stop) {  /* try to stop, but may not success */
-		ERR_MSG("stop when abort CMD<%d>", stop->opcode);
+		dev_err(mmc_dev(host->mmc), "%d -> stop when abort CMD<%d>\n",
+			host->id, stop->opcode);
 		(void)msdc_do_command(host, stop, 0, CMD_TIMEOUT);
 	}
 
@@ -669,12 +666,6 @@ static void msdc_pm(pm_message_t state, void *data)
 	struct msdc_host *host = (struct msdc_host *)data;
 	int evt = state.event;
 
-	if (evt == PM_EVENT_USER_RESUME || evt == PM_EVENT_USER_SUSPEND) {
-		INIT_MSG("USR_%s: suspend<%d> power<%d>",
-			evt == PM_EVENT_USER_RESUME ? "EVENT_USER_RESUME" : "EVENT_USER_SUSPEND",
-			host->suspend, host->power_mode);
-	}
-
 	if (evt == PM_EVENT_SUSPEND || evt == PM_EVENT_USER_SUSPEND) {
 		if (host->suspend) /* already suspend */  /* default 0*/
 			return;
@@ -688,13 +679,17 @@ static void msdc_pm(pm_message_t state, void *data)
 
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
 
@@ -812,7 +807,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 				break;
 
 			if (time_after(jiffies, tmo)) {
-				ERR_MSG("XXX cmd_busy timeout: before CMD<%d>", opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX cmd_busy timeout: before CMD<%d>\n",
+					host->id, opcode);
 				cmd->error = -ETIMEDOUT;
 				msdc_reset_hw(host);
 				goto end;
@@ -823,7 +820,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
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
@@ -862,7 +861,9 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 
 	spin_unlock(&host->lock);
 	if (!wait_for_completion_timeout(&host->cmd_done, 10 * timeout)) {
-		ERR_MSG("XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>", opcode, cmd->arg);
+		dev_err(mmc_dev(host->mmc),
+			"%d -> XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>\n",
+			host->id, opcode, cmd->arg);
 		cmd->error = -ETIMEDOUT;
 		msdc_reset_hw(host);
 	}
@@ -1125,15 +1126,22 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
@@ -1200,7 +1208,10 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->stop && mrq->stop->error)
 		host->error |= 0x100;
 
-	//if (host->error) ERR_MSG("host->error<%d>", host->error);
+	//if (host->error)
+	//	dev_err(mmc_dev(host->mmc),
+	//		"%d -> host->error<%d>\n",
+	//		host->id, host->error);
 
 	return host->error;
 }
@@ -1260,19 +1271,27 @@ static int msdc_tune_cmdrsp(struct msdc_host *host, struct mmc_command *cmd)
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
 
@@ -1325,7 +1344,10 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1336,10 +1358,13 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1348,8 +1373,11 @@ static int msdc_tune_bread(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1458,13 +1486,18 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
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
 
@@ -1473,8 +1506,11 @@ static int msdc_tune_bwrite(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1508,7 +1544,8 @@ static int msdc_get_card_status(struct mmc_host *mmc, struct msdc_host *host, u3
 	if (mmc->card) {
 		cmd.arg = mmc->card->rca << 16;
 	} else {
-		ERR_MSG("cmd13 mmc card is null");
+		dev_err(mmc_dev(host->mmc), "%d -> cmd13 mmc card is null\n",
+			host->id);
 		cmd.arg = host->app_cmd_arg;
 	}
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
@@ -1535,7 +1572,8 @@ static int msdc_check_busy(struct mmc_host *mmc, struct msdc_host *host)
 		if (err)
 			return err;
 		/* need cmd12? */
-		ERR_MSG("cmd<13> resp<0x%x>", status);
+		dev_err(mmc_dev(host->mmc), "%d -> cmd<13> resp<0x%x>\n",
+			host->id, status);
 	} while (R1_CURRENT_STATE(status) == 7);
 
 	return err;
@@ -1559,7 +1597,9 @@ static int msdc_tune_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1711,7 +1751,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->mclk != ios->clock) {
 		if (ios->clock > 25000000) {
 			//if (!(host->hw->flags & MSDC_REMOVABLE)) {
-			INIT_MSG("SD data latch edge<%d>", MSDC_SMPL_FALLING);
 			sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL,
 				      MSDC_SMPL_FALLING);
 			sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DSPL,
@@ -1764,7 +1803,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 		return 1;
 #else
 		host->card_inserted = (host->pm_state.event == PM_EVENT_USER_RESUME) ? 1 : 0;
-		INIT_MSG("sdio ops_get_cd<%d>", host->card_inserted);
 		return host->card_inserted;
 #endif
 	}
@@ -1788,7 +1826,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 		present = 0; /* TODO? Check DAT3 pins for card detection */
 	}
 
-	INIT_MSG("ops_get_cd return<%d>", present);
 	return present;
 }
 
@@ -1823,14 +1860,17 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 	if (intsts & MSDC_INT_CDSC) {
 		if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
 			return IRQ_HANDLED;
-		IRQ_MSG("MSDC_INT_CDSC irq<0x%.8x>", intsts);
+		dev_err(mmc_dev(host->mmc),
+			"%d -> MSDC_INT_CDSC irq<0x%.8x>\n", host->id, intsts);
 		schedule_delayed_work(&host->card_delaywork, HZ);
 		/* tuning when plug card ? */
 	}
 
 	/* sdio interrupt */
 	if (intsts & MSDC_INT_SDIOIRQ) {
-		IRQ_MSG("XXX MSDC_INT_SDIOIRQ");  /* seems not sdio irq */
+		dev_err(mmc_dev(host->mmc),
+			"%d -> XXX MSDC_INT_SDIOIRQ\n",
+			host->id); /* seems not sdio irq */
 		//mmc_signal_sdio_irq(host->mmc);
 	}
 
@@ -1848,10 +1888,15 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 			msdc_clr_int();
 
 			if (intsts & MSDC_INT_DATTMO) {
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATTMO", host->mrq->cmd->opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX CMD<%d> MSDC_INT_DATTMO\n",
+					host->id, host->mrq->cmd->opcode);
 				data->error = -ETIMEDOUT;
 			} else if (intsts & MSDC_INT_DATCRCERR) {
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATCRCERR, SDC_DCRC_STS<0x%x>", host->mrq->cmd->opcode, readl(host->base + SDC_DCRC_STS));
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX CMD<%d> MSDC_INT_DATCRCERR, SDC_DCRC_STS<0x%x>\n",
+					host->id, host->mrq->cmd->opcode,
+					readl(host->base + SDC_DCRC_STS);
 				data->error = -EIO;
 			}
 
@@ -1884,15 +1929,23 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 			}
 		} else if ((intsts & MSDC_INT_RSPCRCERR) || (intsts & MSDC_INT_ACMDCRCERR)) {
 			if (intsts & MSDC_INT_ACMDCRCERR)
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_ACMDCRCERR", cmd->opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX CMD<%d> MSDC_INT_ACMDCRCERR\n",
+					host->id, cmd->opcode);
 			else
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_RSPCRCERR", cmd->opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX CMD<%d> MSDC_INT_RSPCRCERR\n",
+					host->id, cmd->opcode);
 			cmd->error = -EIO;
 		} else if ((intsts & MSDC_INT_CMDTMO) || (intsts & MSDC_INT_ACMDTMO)) {
 			if (intsts & MSDC_INT_ACMDTMO)
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_ACMDTMO", cmd->opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX CMD<%d> MSDC_INT_ACMDTMO\n",
+					host->id, cmd->opcode);
 			else
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_CMDTMO", cmd->opcode);
+				dev_err(mmc_dev(host->mmc),
+					"%d -> XXX CMD<%d> MSDC_INT_CMDTMO\n",
+					host->id, cmd->opcode);
 			cmd->error = -ETIMEDOUT;
 			msdc_reset_hw(host);
 			msdc_clr_fifo(host);
@@ -2289,7 +2342,8 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	BUG_ON(!host);
 
-	ERR_MSG("removed !!!");
+	dev_err(mmc_dev(host->mmc), "%d -> removed !!!\n",
+		host->id);
 
 	platform_set_drvdata(pdev, NULL);
 	mmc_remove_host(host->mmc);
-- 
2.17.1

