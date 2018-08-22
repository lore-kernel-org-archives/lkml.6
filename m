Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFB4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA71214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LirF1cbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA71214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeHVMJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:09:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43000 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbeHVMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:09:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id g23-v6so581114plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UMLphm380qYQxIZwPjZMCqP/sC0vFsl+pCz59x7YDQU=;
        b=LirF1cbQ5Oh5cZafvMRGsRn1ssI+t9seBSnEDgXOd8ENW6RTPxct2hxtXTH34uiPNT
         TlrxXQIZaSY5MiKL4lXBgXll2WEg04J1fFScCgti2Vaj3zqaSsovQUBSsDlH/3jzanYy
         ZOXct0/0vQrVroksl6vqeGsWKvzZTAE6TWgJdeNwUT9hojCQIPYxoLjhnXD+9x6ZoT8H
         913QaK5l1w1pOpZpzhcUGcWdNp9dJ3qvXNxkHcFS2KgkXw5Ed3O1fqjA+7kO8uTMx6by
         OCLXdfPZFZ43cYts+2Nn1KId0DsxMldKMs4z07yC6Qw/jC3ajKVNoELPJwPhMnsrGYkS
         yM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UMLphm380qYQxIZwPjZMCqP/sC0vFsl+pCz59x7YDQU=;
        b=f5o73E8VYkggn37TZlJPp9KKcEr7jSSG3ezSFh8/yXMijhRoWt7kKPnYnXQxccJXOE
         ozt5dZhcDR54SFwTQBCDD6Sixaua1H6BZM6JtPlmk2oJQvdY1cjT6caCw2gSCI9SJTk/
         5Lzaaa7kyG68iculyBNDaD6StfH8jkipgr3rywLv1gsOILmT83aOSjcfpmOW7AqFM/kp
         gV3/nAfZEmIPuXDITIgZQoNrAHQLCcydxKR0moz7sRIUN27NjBEzDTQb62PaEpl9MXW1
         ygKqRbMxkECkMXL3wWDGoVIP5LKMK3Fb9P/USJo8ehPLERxhEoyyJADLmS+fqPtCQKrD
         hEBw==
X-Gm-Message-State: AOUpUlFWWpQlV9UID1SDJwteL5nTsW3si7lxTdPsrWUcSROsCwb6b+sm
        xbDRJNiJbbUgdxy9Mo/wfm9dW3MGR4Q=
X-Google-Smtp-Source: AA+uWPyGBJDBqwi32l0yJL0tIpI6su4jJwpWvx+lEIPks/6d3aXBwcZ6LOpsFl8pcTg6iKwMSAUklg==
X-Received: by 2002:a17:902:6909:: with SMTP id j9-v6mr52799630plk.196.1534927513048;
        Wed, 22 Aug 2018 01:45:13 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 1-v6sm1969399pfm.145.2018.08.22.01.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 01:45:12 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:15:06 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 3/4] staging: mt7621-mmc: Remove macro INIT_MSG and its
 usages
Message-ID: <94aac7e18d74390ea64246d26cb0d735cdedf17a.1534923403.git.nishadkamdar@gmail.com>
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

Removed all usages of INIT_MSG and dropped it from dbg.h.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h |  7 -------
 drivers/staging/mt7621-mmc/sd.c  | 16 ----------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 71295df59ed0..8d2c16450ef5 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -111,15 +111,8 @@ do { \
 
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
index 6b2c72fc61f2..327c1cd7fd04 100644
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
@@ -510,10 +507,6 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	host->mclk = hz;
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks); // need?
 
-	INIT_MSG("================");
-	INIT_MSG("!!! Set<%dKHz> Source<%dKHz> -> sclk<%dKHz>", hz / 1000, hclk / 1000, sclk / 1000);
-	INIT_MSG("================");
-
 	msdc_irq_restore(flags);
 }
 
@@ -671,12 +664,6 @@ static void msdc_pm(pm_message_t state, void *data)
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
@@ -1762,7 +1749,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->mclk != ios->clock) {
 		if (ios->clock > 25000000) {
 			//if (!(host->hw->flags & MSDC_REMOVABLE)) {
-			INIT_MSG("SD data latch edge<%d>", MSDC_SMPL_FALLING);
 			sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL,
 				      MSDC_SMPL_FALLING);
 			sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DSPL,
@@ -1815,7 +1801,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 		return 1;
 #else
 		host->card_inserted = (host->pm_state.event == PM_EVENT_USER_RESUME) ? 1 : 0;
-		INIT_MSG("sdio ops_get_cd<%d>", host->card_inserted);
 		return host->card_inserted;
 #endif
 	}
@@ -1839,7 +1824,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 		present = 0; /* TODO? Check DAT3 pins for card detection */
 	}
 
-	INIT_MSG("ops_get_cd return<%d>", present);
 	return present;
 }
 
-- 
2.17.1

