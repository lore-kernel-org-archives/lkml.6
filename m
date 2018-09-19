Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB1B2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGn/2W35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1B2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeISW4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:56:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35405 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732111AbeISW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:56:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so3023084pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jk0B8pE8gaEHRYCYpCyRA7O++qfdmA0rd9Gf74fyepU=;
        b=IGn/2W35g6cWgu2Ur5eE+4JBgGYW0VJRPPRMeSOtc4sPn9b9ca+nhp8kHXCSBUoKXn
         ViIX94BqcWVS6AtYU+Z8UoPlN9c9qML9Kn6QtGTJdjDKbkuY2X9iszVnLf8Utjw3sTzJ
         xvT5j4nmmoLnEhNejz1gOsM1b/eqXE+W+tJUXXsLeJ/vFnHqi3Hs/raSELA8dmfAApua
         9iNZwp+24qlsgGykdQNPuiZcFywQmWRw77cfBNWZGZbTxyki+9jd9BdDvrGjJQdwrGZF
         99L4Edk7lDJR0YioKXW0TSDILg6U0716DXgIq1lkOvXvf3+k0V1zCfztECDVJ7Pulo5T
         Opaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jk0B8pE8gaEHRYCYpCyRA7O++qfdmA0rd9Gf74fyepU=;
        b=HdPKEEOIq8QB0WMf8iOYaH5WygS7SBt7z3tiGMzgmQKMRKNHCIWbdYjVbtv8ZFfWSI
         CuYkixP4uJAz3zjiDPEFZuHY+A/O9R1ruC68HrbKwdHaK/Ijs1fJpVY9vR3J++ExgPW7
         w1weoOTKHch9EL3uCX/FnspSpdO+dHMDvuQgLzqb0Ykl2LlheXhHQjOtcoOPm6BfVr1X
         IlFb91trAS1RyatXXjCP3EvPg0/pjAKcrpYG7Rax9i8oIhmmfw3gqfz5+Rg6s2Uvo1iV
         jwnaJu+tGyWwafBRUSmn/ZmiTrOoaroSBqrflH+pQYMDdNjtHW6/zNFwRJgSTMVLIaqj
         QHAw==
X-Gm-Message-State: APzg51D/bQFwJP0YKztLlqoY2a7aXfwuko40F3FyXFVIiYYkQ0X7tsoi
        Zk1/LJAosDPxnesrBiMwy94=
X-Google-Smtp-Source: ANB0VdaGBeKYDlO+qBw/GsDtStgDOeiqqiElhtQ6YAxeymI+DqBlE/pnzooDZBmqZnObiODcS7MgZw==
X-Received: by 2002:a63:e841:: with SMTP id a1-v6mr32815999pgk.126.1537377446734;
        Wed, 19 Sep 2018 10:17:26 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id c88-v6sm31618881pfe.132.2018.09.19.10.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:17:26 -0700 (PDT)
Date:   Wed, 19 Sep 2018 22:47:19 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v8 1/1] staging: mt7621-mmc: Delete IRQ_MSG() and its users
Message-ID: <0709c9e75d5aeb90cc3b2a0ac03c75d4adf60f89.1537376030.git.nishadkamdar@gmail.com>
References: <cover.1537376030.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537376030.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes IRQ_MSG() and its users as currently it is a no-op.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v8:
  - Remove unnecessary {} for single statement if
Changes in v7:
  - Delete IRQ_MSG() and all its users
Changes in v6:
  - No change
Changes in v5:
  - No change
---
 drivers/staging/mt7621-mmc/dbg.h | 12 ------------
 drivers/staging/mt7621-mmc/sd.c  | 24 ++----------------------
 2 files changed, 2 insertions(+), 34 deletions(-)

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
index 7474f9ed7b5b..e3c1546373ba 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -278,8 +278,6 @@ static void msdc_tasklet_card(struct work_struct *work)
 		host->mmc->f_max = HOST_MAX_MCLK;
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
-
-	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
 #endif
 
 	spin_unlock(&host->lock);
@@ -1638,17 +1636,10 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 	if (intsts & MSDC_INT_CDSC) {
 		if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
 			return IRQ_HANDLED;
-		IRQ_MSG("MSDC_INT_CDSC irq<0x%.8x>", intsts);
 		schedule_delayed_work(&host->card_delaywork, HZ);
 		/* tuning when plug card ? */
 	}
 
-	/* sdio interrupt */
-	if (intsts & MSDC_INT_SDIOIRQ) {
-		IRQ_MSG("XXX MSDC_INT_SDIOIRQ");  /* seems not sdio irq */
-		//mmc_signal_sdio_irq(host->mmc);
-	}
-
 	/* transfer complete interrupt */
 	if (data != NULL) {
 		if (inten & MSDC_INT_XFER_COMPL) {
@@ -1662,13 +1653,10 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 			msdc_clr_fifo(host);
 			msdc_clr_int();
 
-			if (intsts & MSDC_INT_DATTMO) {
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATTMO", host->mrq->cmd->opcode);
+			if (intsts & MSDC_INT_DATTMO)
 				data->error = -ETIMEDOUT;
-			} else if (intsts & MSDC_INT_DATCRCERR) {
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATCRCERR, SDC_DCRC_STS<0x%x>", host->mrq->cmd->opcode, readl(host->base + SDC_DCRC_STS));
+			else if (intsts & MSDC_INT_DATCRCERR)
 				data->error = -EIO;
-			}
 
 			//if(readl(MSDC_INTEN) & MSDC_INT_XFER_COMPL) {
 			complete(&host->xfer_done); /* Read CRC come fast, XFER_COMPL not enabled */
@@ -1698,16 +1686,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 				break;
 			}
 		} else if ((intsts & MSDC_INT_RSPCRCERR) || (intsts & MSDC_INT_ACMDCRCERR)) {
-			if (intsts & MSDC_INT_ACMDCRCERR)
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_ACMDCRCERR", cmd->opcode);
-			else
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_RSPCRCERR", cmd->opcode);
 			cmd->error = -EIO;
 		} else if ((intsts & MSDC_INT_CMDTMO) || (intsts & MSDC_INT_ACMDTMO)) {
-			if (intsts & MSDC_INT_ACMDTMO)
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_ACMDTMO", cmd->opcode);
-			else
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_CMDTMO", cmd->opcode);
 			cmd->error = -ETIMEDOUT;
 			msdc_reset_hw(host);
 			msdc_clr_fifo(host);
-- 
2.17.1

