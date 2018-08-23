Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3788C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E732152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flF1tTNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E732152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHWVCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:02:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42052 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeHWVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:02:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3125911pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VF+275AGBcfncz08rauD54L/NRg1kgWG3YJqjxLIhog=;
        b=flF1tTNpWNWDobUGJNQandnHEzAzCn1vqqWON2W1Y2pdrt/lFkVf/Zi66ij4laDwkC
         l8A37plhL+E9VsyYaNa4KNwHVEmu/+ANzgXekHKRQlj8Rqr6u10pZ1gsidorBheucEzd
         oF1ouFxYUsLp5ovBL5EVRdY4GnatVOEg0F+QjNYhUOF/UYUfWEp56/OXz3sGP/pXjXJI
         vhnNwR/Xy0Zf3S29t2Dfp+42qodnFqFV2Nn5FmZJ2ZQNtxASzXxbtKF4O/fUd4HLhhrr
         7JoTgF7ftM2fd56u4j48uaLv1EwpYFGihG1TuyPj6APL6OdY4UT9VirTORuRsKOnDdxu
         1KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VF+275AGBcfncz08rauD54L/NRg1kgWG3YJqjxLIhog=;
        b=O8LO+nREsjDR7hul6C8cFMIFdaZdYKenFKaGtWkOS2FeAUE2W6nxtM7aGUw9gawXXY
         W8/ChWPfOUQF2MDgGFC0mAFENpkQA80sKa8a1vTSMMh06yihgnjP/QMqmrWb3SIuqycW
         IwDgWzqO7K9wg3s8BViaSasjLOVKujFU52baF826DQGkoGI8Z4Hw1FCAugr99MFoz0tF
         buYusYoqJ2lRoGbJVOSBXngyhFlWo0LhHwRoUj3ye1JlYVLDNtYVV+pkNaqCg45J85gY
         1dC0kNTJ4IWp1Vn+yeiIAV65kyMg3G+PgzuMBb31uXuSwuCKzoxInbf9m4xvGu4sXju9
         wJ/w==
X-Gm-Message-State: APzg51DePiib6/s/tGxYD9zGA2UN2tPkepVyyqVV1XNBDjiChnN/Zwzs
        OalsPmIUZY4nhKY+pkbjVrg=
X-Google-Smtp-Source: ANB0VdYwKNcEA7musqDJnAeYmUBUbbDfQaEqictzqOlobE7eUZsP1dcAOhU59X9NAxs9Sblx1eOGvA==
X-Received: by 2002:a62:46c8:: with SMTP id o69-v6mr7996625pfi.21.1535045478313;
        Thu, 23 Aug 2018 10:31:18 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id b1-v6sm6999670pgi.91.2018.08.23.10.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:31:17 -0700 (PDT)
Date:   Thu, 23 Aug 2018 23:01:11 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 3/4] staging: mt7621-mmc: Remove macro INIT_MSG and its
 usages
Message-ID: <2d6ea5195fcf1071f1ca0f7bea08dd02e9c411ff.1535038495.git.nishadkamdar@gmail.com>
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

Removed all usages of INIT_MSG and dropped it from dbg.h.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v5:
  - No change
---
 drivers/staging/mt7621-mmc/dbg.h |  7 -------
 drivers/staging/mt7621-mmc/sd.c  | 16 ----------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 28c0cf76664f..a5fdafe80d3d 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -106,15 +106,8 @@ do { \
 
 #if 1
 //defined CONFIG_MTK_MMC_CD_POLL
-#define INIT_MSG(fmt, args...)
 #define IRQ_MSG(fmt, args...)
 #else
-#define INIT_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
-} while (0);
-
 /* PID in ISR in not corrent */
 #define IRQ_MSG(fmt, args...) \
 do { \
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index dcd036914467..fd02bf819c6c 100644
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
 
@@ -439,7 +437,6 @@ static void msdc_select_clksrc(struct msdc_host *host, unsigned char clksrc)
 	u32 val;
 
 	BUG_ON(clksrc > 3);
-	INIT_MSG("set clock source to <%d>", clksrc);
 
 	val = readl(host->base + MSDC_CLKSRC_REG);
 	if (readl(host->base + MSDC_ECO_VER) >= 4) {
@@ -508,10 +505,6 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	host->mclk = hz;
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks); // need?
 
-	INIT_MSG("================");
-	INIT_MSG("!!! Set<%dKHz> Source<%dKHz> -> sclk<%dKHz>", hz / 1000, hclk / 1000, sclk / 1000);
-	INIT_MSG("================");
-
 	msdc_irq_restore(flags);
 }
 
@@ -669,12 +662,6 @@ static void msdc_pm(pm_message_t state, void *data)
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
@@ -1752,7 +1739,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->mclk != ios->clock) {
 		if (ios->clock > 25000000) {
 			//if (!(host->hw->flags & MSDC_REMOVABLE)) {
-			INIT_MSG("SD data latch edge<%d>", MSDC_SMPL_FALLING);
 			sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL,
 				      MSDC_SMPL_FALLING);
 			sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DSPL,
@@ -1805,7 +1791,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 		return 1;
 #else
 		host->card_inserted = (host->pm_state.event == PM_EVENT_USER_RESUME) ? 1 : 0;
-		INIT_MSG("sdio ops_get_cd<%d>", host->card_inserted);
 		return host->card_inserted;
 #endif
 	}
@@ -1829,7 +1814,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 		present = 0; /* TODO? Check DAT3 pins for card detection */
 	}
 
-	INIT_MSG("ops_get_cd return<%d>", present);
 	return present;
 }
 
-- 
2.17.1

