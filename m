Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41155C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25A12083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0jufl+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25A12083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIACat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:30:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37312 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIACat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:30:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id d12-v6so6055240pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tC5LLLPeZn2Xw9XHqNrwq5gqQZEwZSsBW9pLCFnbSfA=;
        b=n0jufl+3XqgpFQpITyLrX8uyNXDWj0mpFz4qfcRpTy02fqJWvVmm5t0wF9HQZKWjUr
         bbxoboVXMUtpZB7lS6Lu0nClM86EogX/j43eJQxHnDrLfLUXxdTxz96W5E6sSt4yzJ8P
         zGo/aqXmIZO33+wIV7PhMRv6UjSc2fcYqfXM1Q7QGvwsJJOfjQ+ybPw1sM2OSJ8V5eqb
         V6LIOL+tKO86R69wVb7YLQmynYjIeDWZl3FazqQpzRp6/XOYyNreLtSMtMATpNMlBvLP
         N6urArmfOzNr7WTQOE64CYdzT8UDdnvEw2JyXwM1bIFM2k62/LWmCgoFDqVdXpNWjLX3
         ZRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tC5LLLPeZn2Xw9XHqNrwq5gqQZEwZSsBW9pLCFnbSfA=;
        b=JgMEgm5NOSdm+sTzXtpdtVly2QwUDf/hT8O9I8wN8D5mVCTPyX2PQYTki6Y930375E
         Rf76iH90Gp89205pbSFAzHODo1V0Nlj5OQT/g44/OYGdgUhFnqGQsKD35YlohSyJJ4mH
         PFSwAQ16zijH9o9K8AmgPeM5AxOcPPR3GC0mp/ZM+FQ4IN1fO4L1PwiNGrI1jnFZpDpE
         Jny6j+kTzGsoO5NUTfTSPiVU0dvCY1RhqW2jzouPrb4h3SaImLNLPW3s4VbldZM2H7zn
         KXlfLgAj4QHP88ANY0eI6qQmz2gG8BwDCPDw2dZy0qt9PnJQLPbWh0MAAQawy04GGbmR
         UInw==
X-Gm-Message-State: APzg51CwXj6yvs14FzO6mlJa2DYXfji2gXaCtN8Y1BFedMCH0qSa3zVz
        4CBNfmU8hRF4f3QyhuLT+tk=
X-Google-Smtp-Source: ANB0VdaeKJ0TUigAdIDJENxKlVa51SjvHOMF7fiH7XgAVzKCzqIflMZhvKn40Ls7rN+/7jDs9hItzQ==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2-v6mr17780959plb.280.1535754077894;
        Fri, 31 Aug 2018 15:21:17 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id b14-v6sm24345730pfc.178.2018.08.31.15.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:21:17 -0700 (PDT)
Date:   Sat, 1 Sep 2018 03:51:10 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 3/3] staging: mt7621-mmc: Fix debug macro IRQ_MSG and its
 usages
Message-ID: <8f8cff3f1042e3fd303350baa261876cf4e3d7e7.1535752537.git.nishadkamdar@gmail.com>
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

Replace all usages of IRQ_MSG with with dev_<level> without __func__
or __LINE__ or current->comm and current->pid. Remove the do {}
while(0) loop for the single statement macro. Drop IRQ_MSG from dbg.h.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v6:
  - No change
Changes in v5:
  - No change
---
 drivers/staging/mt7621-mmc/dbg.h | 12 -----------
 drivers/staging/mt7621-mmc/sd.c  | 36 ++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 79914d98c573..4ab9f10dccc2 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -102,18 +102,6 @@ do { \
 } while (0)
 #endif /* end of +++ */
 
-#if 1
-//defined CONFIG_MTK_MMC_CD_POLL
-#define IRQ_MSG(fmt, args...)
-#else
-/* PID in ISR in not corrent */
-#define IRQ_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
-	       host->id,  ##args, __FUNCTION__, __LINE__);	\
-} while (0);
-#endif
-
 void msdc_debug_proc_init(void);
 
 #if 0 /* --- chhung */
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 7474f9ed7b5b..f3ae19fe0f76 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -279,7 +279,9 @@ static void msdc_tasklet_card(struct work_struct *work)
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
 
-	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
+	dev_err(mmc_dev(host->mmc),
+		"%d -> card found<%s>\n",
+		host->id, inserted ? "inserted" : "removed");
 #endif
 
 	spin_unlock(&host->lock);
@@ -1638,14 +1640,17 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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
 
@@ -1663,10 +1668,15 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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
 
@@ -1699,15 +1709,23 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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
-- 
2.17.1

