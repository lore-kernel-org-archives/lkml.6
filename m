Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8025AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CF42154E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESE5RKxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CF42154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeHWVEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:04:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43387 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHWVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:04:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so2954390pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GdfS3vnRQh4S+/6b/eNX1ma2PFxYjRiTLwMJEeBAl/I=;
        b=ESE5RKxXe+ec56Zp9/kX10J/yJIqeLSCnVYjyRvFeBTbPccCtrx8rv/ZgI2zW2/u66
         xxw7OXATX3AxmQ6UiTMznzQmIbpyscsGwklmemG42YqSenR9Os7xLs1CShs1ZpXv99bF
         4nzuCU6U0r0pOnfnyPBop9S95Ff3dO2wClUNjllFqN5IWSZqW9i3wARYE4ertcNzKJ94
         9wCGChbiJUlectIyWFoWxvJlTdFclx7smDyI7rvGj81Q7lTDl67IjzY3mJccv0LUPHZC
         y6ezq9ntpyVkqp3jViTqPqbtmmMvtai4DICFBdGXwRt8ZhAwJQ6wqP1VBE3wlscZIM7k
         +o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GdfS3vnRQh4S+/6b/eNX1ma2PFxYjRiTLwMJEeBAl/I=;
        b=LtLe7JHGRv+sCh+8vlqfSeR55SzWG9kjxB4pS8qElIookpvz5kJoNMeYFPRId6PTfp
         3r63ih0PYfKJr8+Kneu5vCbp1SqLsvcDRijDEfPUmaVNcVrsTrsO51iya/kPz/5343y3
         SQmMJWKyEjEvlFZKoun5RowTnXXo2+naY8lojmk3ZUUErf1VDSriFhgZUuW1g50W4nWY
         g48Jm1aLOyU1VVQZBDkFPkCrVHv19uP4CAUjxFDvBbQ1p+6gTwAk+x4E0+vfdq9vM+NW
         DbIDAEgXPP2zinTRyRsJktdT6DWgxuoKoxliMnfxyrTzIp1+wMrTfy9fnlPZuNi7AMpk
         Ne1w==
X-Gm-Message-State: AOUpUlFIRXPe1drEVBCQWhZIVW8TrnG3cWnpl3KHTnsjnMHIxkGrfVaO
        m6VjLMIJVpLIlDyZP+l5ZG4=
X-Google-Smtp-Source: AA+uWPxejj3I6G7YuMbj25Il0mJvvS8I4XEFz6J9BFWpusqMzTFp2msSODzTgZfW9i4+cxF9BA8JIA==
X-Received: by 2002:a17:902:4d45:: with SMTP id o5-v6mr26054587plh.78.1535045596080;
        Thu, 23 Aug 2018 10:33:16 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id m15-v6sm11100176pfk.149.2018.08.23.10.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:33:15 -0700 (PDT)
Date:   Thu, 23 Aug 2018 23:03:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 4/4] staging: mt7621-mmc: Fix debug macro IRQ_MSG and its
 usages
Message-ID: <892aecbcfc0a302e4509e540416ead2320d6a94e.1535038495.git.nishadkamdar@gmail.com>
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

Replace all usages of IRQ_MSG with with dev_<level> without __func__
or __LINE__ or current->comm and current->pid. Remove the do {}
while(0) loop for the single statement macro. Drop IRQ_MSG from dbg.h.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v5:
  - No change
---
 drivers/staging/mt7621-mmc/dbg.h | 12 -----------
 drivers/staging/mt7621-mmc/sd.c  | 36 ++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index a5fdafe80d3d..256979424309 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -104,18 +104,6 @@ do { \
 
 #define N_MSG(evt, fmt, args...)
 
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
index fd02bf819c6c..e5bd3273cc04 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -420,7 +420,9 @@ static void msdc_tasklet_card(struct work_struct *work)
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
 
-	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
+	dev_err(mmc_dev(host->mmc),
+		"%d -> card found<%s>\n",
+		host->id, inserted ? "inserted" : "removed");
 #endif
 
 	spin_unlock(&host->lock);
@@ -1848,14 +1850,17 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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
 
@@ -1873,10 +1878,15 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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
 
@@ -1909,15 +1919,23 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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

