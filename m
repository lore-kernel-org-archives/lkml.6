Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE798ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595D7208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KscFRgPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595D7208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIOIP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:15:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46909 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:15:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id t19-v6so4966709ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TkLtFOEYYROSlkVIw7utkKt01/T6LPmDw3rQ3ODZDB8=;
        b=KscFRgPoPUIi6eELI8tRGVSjfticYdWt3ga+8Cg1F5tgnh/IJHHinU0s31NZaTD8X/
         S/dVzk14E4vvLxHobubfEJFQpdKcoUtL18kfdn9oarMOlGq/tPwWS2KVfJvmaY2MF9mC
         OJJh4dvFSttY12MELw72ybfVlLxA2+/gLcl9qReIyCs5JNb/Xs/MqXD8bvIvSym7zcKw
         UwNPXWGLBdllR59Ip14groImw90FoFfQflaensw0wvv5eSjptucQdxA5WAjehyqKHtHI
         tGc13hpDr1atsVPcCUoPZvGbss7L9lcx7umIYLHVkkZ3jTm+4efT/wjZ6FJoFlh3lKAK
         cFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TkLtFOEYYROSlkVIw7utkKt01/T6LPmDw3rQ3ODZDB8=;
        b=YmD4jlu2lDJKpIGCvFmKNR7PEbdCrUrDKfTRI0KNXJsWKMo1blS4lYBaQd0W464tke
         k1GUt14Ec7lY8CFh3i54xOhbRvnHYRpClkF97AVRe8PuIg4bapDXd/vZEBErDFz4VW4x
         4sQSgMbGRor8Aljgl1Kjp8ymaJPyWProtjhqwyHSoiUMzjNbcIpM1VzCldVog3KkJGjs
         xi7yd8jq4EH9TKvxHiNAZhj+5Op51GDPu2nlauqq8YAXHq8dm0c4AEPOM3NjKpGoiNqy
         y6Q5V3Brkmk1czN3CsK9XNP+0npNF2maG0WSklCOkjRHcO5iCuSZpSWJHn0Ahol7g+Ct
         9lUA==
X-Gm-Message-State: APzg51AcLLqu3vmlPJcKw4hlTUb6UN73YNLt1BrYSRD54r99EPJZd+NJ
        f7EvkdGM4INpn+CWtmdCJoY=
X-Google-Smtp-Source: ANB0VdZNqAkMDQa6+YggcStCwYKQoLJ4W5+xTljEctPSjy1zTE78+0kBpdhNTh53beVJLRT2LQAKWA==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr14771862plp.282.1536980289583;
        Fri, 14 Sep 2018 19:58:09 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id b73-v6sm12988121pfj.93.2018.09.14.19.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 19:58:09 -0700 (PDT)
Date:   Sat, 15 Sep 2018 08:28:03 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v7 1/1] staging: mt7621-mmc: Delete IRQ_MSG() and its users.
Message-ID: <0bc3daf340308eb8a1aa5510ee33417ef7d8bd89.1536978716.git.nishadkamdar@gmail.com>
References: <cover.1536978715.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536978715.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes IRQ_MSG() and its users as currently it is a no-op.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v7:
  - Delete IRQ_MSG() and all its users
Changes in v6:
  - No change
Changes in v5:
  - No change
---
 drivers/staging/mt7621-mmc/dbg.h | 12 ------------
 drivers/staging/mt7621-mmc/sd.c  | 19 -------------------
 2 files changed, 31 deletions(-)

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
index 7474f9ed7b5b..273593427d3a 100644
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
@@ -1663,10 +1654,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 			msdc_clr_int();
 
 			if (intsts & MSDC_INT_DATTMO) {
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATTMO", host->mrq->cmd->opcode);
 				data->error = -ETIMEDOUT;
 			} else if (intsts & MSDC_INT_DATCRCERR) {
-				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATCRCERR, SDC_DCRC_STS<0x%x>", host->mrq->cmd->opcode, readl(host->base + SDC_DCRC_STS));
 				data->error = -EIO;
 			}
 
@@ -1698,16 +1687,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
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

