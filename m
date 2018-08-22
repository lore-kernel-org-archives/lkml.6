Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9484CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0DE21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+dWibI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0DE21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeHVMLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:11:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43115 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeHVMLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:11:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so647988pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6MkwBdnlRzwQUVbhqbPm3HsZ30DhNA/K1cBW+sAiVc=;
        b=u+dWibI8QSPm7jdIcjRJLshQsdQ79bg/E3+ntB/lRbT/NnorKvffPJ5zlYH157VIZ9
         DifkzRiSmwicZhamLVXWmX+iyaVQhg61l0+36rWPUqCpRv5hmlsEXGBOuhRvVrHk4pEo
         fbdsW+8bfAhMZilkupdyoZSB8wn6x7O9vb1Rrl50SML6rSfrtwUePFU136omElqDU+Fn
         sGAzhzaZfEmNfHsFNlLyd1vjjZRnj8nMRYACAymvGXAleI1cNH7v/FxHibQGoo3btrIJ
         Qf4q2TdQViMrFp23YLiG0syZuwkHnGWFE4teMccjJTz00F6Q4xsoTN+S1PgAyguVnMLW
         RePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6MkwBdnlRzwQUVbhqbPm3HsZ30DhNA/K1cBW+sAiVc=;
        b=Winq38Bbs/H26H/TzfjYrzVtOhY2fwJ/V9g1Hbme3LDHEHj+01JohWZO3122t2ViVs
         L4h9hlno4pn1m2DTiyXtb+GXmAS7/D9nApGjfcEc3IwnRKPbYqeJBU6A2VAUsgdP8LN+
         ZVo4Ub6BEpAhpJ3i7uMIUo4C/ghJGQjoVadenktuUlawRjOZDjurPr43eI30OCei+vV8
         NJecch4bjD0Eap1KeU/FNk7K/edC0y+tgvGKXxjj35mlIOkiFmUx01j2a/aO02LCwWuk
         /onF8aCtZBdi9S0j/u45mG6NBTH9G5tts5no9C75IpNvCrWPCrvEBTXYqNUoqz/MhHb4
         cAWA==
X-Gm-Message-State: AOUpUlETLMbNQyz2kOZJEwp3EpgR9/gHSU0MNoRVUt81Zy5jgkLN5vqY
        3DBP8yIbo/FdOXNS7CdrllU=
X-Google-Smtp-Source: AA+uWPyCChxlz3ORvQTwUaYxK5CW3zNChzMshNCPwjqazt65C4Zd/z1rUhUahHbNhoI6VvcTCyjgbA==
X-Received: by 2002:a63:4283:: with SMTP id p125-v6mr51065819pga.142.1534927670066;
        Wed, 22 Aug 2018 01:47:50 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id f6-v6sm1941298pff.29.2018.08.22.01.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 01:47:49 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:17:42 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 4/4] staging: mt7621-mmc: Fix debug macro IRQ_MSG and its
 usages
Message-ID: <982c8787c55fcd98f7b39be4b8fb985d0e71fdc6.1534923403.git.nishadkamdar@gmail.com>
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

Replace all usages of IRQ_MSG with with dev_<level> without __func__
or __LINE__ or current->comm and current->pid. Remove the do {}
while(0) loop for the single statement macro. Drop IRQ_MSG from dbg.h.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h | 12 -----------
 drivers/staging/mt7621-mmc/sd.c  | 36 ++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 8d2c16450ef5..5458dae5dc03 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -109,18 +109,6 @@ do { \
  *}
  */
 
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
index 327c1cd7fd04..5cb6bc36e78b 100644
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
@@ -1858,14 +1860,17 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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
 
@@ -1883,10 +1888,15 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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
 
@@ -1919,15 +1929,23 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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

