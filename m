Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96799C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4F5216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heWPqvZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4F5216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeI0V74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:59:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39673 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbeI0V74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:59:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so2245518pge.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PQm+cIXewEhMrEI6/qMOvXsV6F98CGSJu/ep4UaZ7no=;
        b=heWPqvZazjHSthdS24Om2IHTB/DxqnBhkTQUKmbqIJx2bJ2yZe8BY+XPim/Bzvwdu2
         2iST/iV85u032FdxIpk2e/WKb3slvhw2RQXZAfJbpm5OUXof7LdvMXCMkVbQu2yRZv0+
         77pibeE3ZarWOdBp1p6NnTA9OWjUNjTMyrwyV9cFGHrF+kir3/VCHUZPN+WTrTfejf3X
         8hmwRcFo5I4mIvjCOWPd0z9baVlRwvO6CJk3sEW+WTC+Z2ds/1QpgwiWp2PCGstcxu3c
         YsJWBETo0d/XGDRqPPaj/kZ61jBZQo6B/DvYsoInfkyLHkQubMjrFyBxvpwdO/c6NKMR
         aPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PQm+cIXewEhMrEI6/qMOvXsV6F98CGSJu/ep4UaZ7no=;
        b=c0gNwG6LTfw8XZza0dVIxDLd8eDorVb+q2imAqfkV93bBq+PH4/apElQA6zpJCaabU
         PWPIM1lC2YFR4RNo3ZFAwXWQbfr2ieKb+eE3HMw8sOjc0044uEfAh0EJAoW0oF0DdzmV
         0P4c0KR5ecvmZmE7hwLZRoz0Q0f9pT2Dgu3nOG5gFLqujzD1WQldMK1z9cAEug3I6Rl+
         5ORktTu3oy0w3IL5gMvrE+2woN68okGxljqS8XZdg4MnvxM6LinepFmqDnOWIOzgl5o5
         tIoDIyMMEQ7Typ5eTu09vN0dZVUHkhH/GS5S9YSbePS9/eayzaarXg5d5tfu+zaBYmut
         SBYg==
X-Gm-Message-State: ABuFfojbNlCt0TDwSyxbAyHpKuLcPv2Yue3AwtInnlGRd135GSiuNyG9
        Jm+oogerm5KUL3JXTkIMMos=
X-Google-Smtp-Source: ACcGV621o8bFoO4az0ozQXMT/1hEN9w9SXUnjQ1vw7e8XjAyt/NwnMY+9uA3Tw55hCcEBquYgN1Rfg==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr11766997plg.108.1538062864579;
        Thu, 27 Sep 2018 08:41:04 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id v36-v6sm4731989pgn.85.2018.09.27.08.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:41:04 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:10:57 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3] staging: mt7621-mmc: Remove #if 0 blocks and fix macros
 in sd.c
Message-ID: <20180927154053.GA3526@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if 0 code blocks and usages of the
functions defined in the #if 0 code block. It removes
the macro msdc_irq_restore() and replaces its usage
with call to the function called in the macro definition.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v3:
  - Remove the #if 0 code blocks and usages of the functions
    defined in the #if 0 code block.
  - Delete msdc_irq_restore() and replace its usage directly
    with call to the function being called by the macro.
Changes in v2:
  - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
  - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
    msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
    with calls to the function being called by these macros.
---
 drivers/staging/mt7621-mmc/sd.c | 306 +-------------------------------
 1 file changed, 2 insertions(+), 304 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index e3c1546373ba..dbf4dcb28b3c 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -72,11 +72,6 @@
 #define GPIO_PULL_DOWN      (0)
 #define GPIO_PULL_UP        (1)
 
-#if 0 /* --- by chhung */
-#define MSDC_CLKSRC_REG     (0xf100000C)
-#define PDN_REG           (0xF1000010)
-#endif /* end of --- */
-
 #define DEFAULT_DEBOUNCE    (8)       /* 8 cycles */
 #define DEFAULT_DTOC        (40)      /* data timeout counter. 65536x40 sclk. */
 
@@ -100,26 +95,6 @@ static int cd_active_low = 1;
 //#define PERI_MSDC2_PDN    (17)
 //#define PERI_MSDC3_PDN    (18)
 
-#if 0 /* --- by chhung */
-/* gate means clock power down */
-static int g_clk_gate = 0;
-#define msdc_gate_clock(id) \
-	do {					       \
-		g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));	\
-	} while (0)
-/* not like power down register. 1 means clock on. */
-#define msdc_ungate_clock(id) \
-	do {					    \
-		g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);	\
-	} while (0)
-
-// do we need sync object or not
-void msdc_clk_status(int *status)
-{
-	*status = g_clk_gate;
-}
-#endif /* end of --- */
-
 /* +++ by chhung */
 struct msdc_hw msdc0_hw = {
 	.clk_src        = 0,
@@ -169,11 +144,6 @@ static void msdc_clr_fifo(struct msdc_host *host)
 		sdr_clr_bits(host->base + MSDC_INTEN, val);	\
 	} while (0)
 
-#define msdc_irq_restore(val) \
-	do {					\
-		sdr_set_bits(host->base + MSDC_INTEN, val);	\
-	} while (0)
-
 /* clock source for host: global */
 #if defined(CONFIG_SOC_MT7620)
 static u32 hclks[] = {48000000}; /* +/- by chhung */
@@ -181,32 +151,6 @@ static u32 hclks[] = {48000000}; /* +/- by chhung */
 static u32 hclks[] = {50000000}; /* +/- by chhung */
 #endif
 
-//============================================
-// the power for msdc host controller: global
-//    always keep the VMC on.
-//============================================
-#define msdc_vcore_on(host) \
-	do {								\
-		(void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD");	\
-	} while (0)
-#define msdc_vcore_off(host) \
-	do {								\
-		(void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD");		\
-	} while (0)
-
-//====================================
-// the vdd output for card: global
-//   always keep the VMCH on.
-//====================================
-#define msdc_vdd_on(host) \
-	do {								\
-		(void)hwPowerOn(MT65XX_POWER_LDO_VMCH, VOL_3300, "SD"); \
-	} while (0)
-#define msdc_vdd_off(host) \
-	do {							\
-		(void)hwPowerDown(MT65XX_POWER_LDO_VMCH, "SD"); \
-	} while (0)
-
 #define sdc_is_busy()          (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
 #define sdc_is_cmd_busy()      (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
 
@@ -252,7 +196,6 @@ static void msdc_tasklet_card(struct work_struct *work)
 				struct msdc_host, card_delaywork.work);
 	u32 inserted;
 	u32 status = 0;
-    //u32 change = 0;
 
 	spin_lock(&host->lock);
 
@@ -262,53 +205,17 @@ static void msdc_tasklet_card(struct work_struct *work)
 	else
 		inserted = (status & MSDC_PS_CDSTS) ? 1 : 0;
 
-#if 0
-	change = host->card_inserted ^ inserted;
-	host->card_inserted = inserted;
-
-	if (change && !host->suspend) {
-		if (inserted)
-			host->mmc->f_max = HOST_MAX_MCLK;  // work around
-		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
-	}
-#else  /* Make sure: handle the last interrupt */
+	/* Make sure: handle the last interrupt */
 	host->card_inserted = inserted;
 
 	if (!host->suspend) {
 		host->mmc->f_max = HOST_MAX_MCLK;
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
-#endif
 
 	spin_unlock(&host->lock);
 }
 
-#if 0 /* --- by chhung */
-/* For E2 only */
-static u8 clk_src_bit[4] = {
-	0, 3, 5, 7
-};
-
-static void msdc_select_clksrc(struct msdc_host *host, unsigned char clksrc)
-{
-	u32 val;
-
-	BUG_ON(clksrc > 3);
-
-	val = readl(host->base + MSDC_CLKSRC_REG);
-	if (readl(host->base + MSDC_ECO_VER) >= 4) {
-		val &= ~(0x3  << clk_src_bit[host->id]);
-		val |= clksrc << clk_src_bit[host->id];
-	} else {
-		val &= ~0x3; val |= clksrc;
-	}
-	writel(val, host->base + MSDC_CLKSRC_REG);
-
-	host->hclk = hclks[clksrc];
-	host->hw->clk_src = clksrc;
-}
-#endif /* end of --- */
-
 static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 {
 	//struct msdc_hw *hw = host->hw;
@@ -362,7 +269,7 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	host->mclk = hz;
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks); // need?
 
-	msdc_irq_restore(flags);
+	sdr_set_bits(host->base + MSDC_INTEN, flags);
 }
 
 /* Fix me. when need to abort */
@@ -389,115 +296,6 @@ static void msdc_abort_data(struct msdc_host *host)
 	//}
 }
 
-#if 0 /* --- by chhung */
-static void msdc_pin_config(struct msdc_host *host, int mode)
-{
-	struct msdc_hw *hw = host->hw;
-	int pull = (mode == MSDC_PIN_PULL_UP) ? GPIO_PULL_UP : GPIO_PULL_DOWN;
-
-	/* Config WP pin */
-	if (hw->flags & MSDC_WP_PIN_EN) {
-		if (hw->config_gpio_pin) /* NULL */
-			hw->config_gpio_pin(MSDC_WP_PIN, pull);
-	}
-
-	switch (mode) {
-	case MSDC_PIN_PULL_UP:
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPU, 1); /* Check & FIXME */
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPD, 0); /* Check & FIXME */
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPU, 1);
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPD, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPU, 1);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPD, 0);
-		break;
-	case MSDC_PIN_PULL_DOWN:
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPU, 0); /* Check & FIXME */
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPD, 1); /* Check & FIXME */
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPD, 1);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPD, 1);
-		break;
-	case MSDC_PIN_PULL_NONE:
-	default:
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPU, 0); /* Check & FIXME */
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPD, 0); /* Check & FIXME */
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPD, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPD, 0);
-		break;
-	}
-
-}
-
-void msdc_pin_reset(struct msdc_host *host, int mode)
-{
-	struct msdc_hw *hw = (struct msdc_hw *)host->hw;
-	int pull = (mode == MSDC_PIN_PULL_UP) ? GPIO_PULL_UP : GPIO_PULL_DOWN;
-
-	/* Config reset pin */
-	if (hw->flags & MSDC_RST_PIN_EN) {
-		if (hw->config_gpio_pin) /* NULL */
-			hw->config_gpio_pin(MSDC_RST_PIN, pull);
-
-		if (mode == MSDC_PIN_PULL_UP)
-			sdr_clr_bits(host->base + EMMC_IOCON, EMMC_IOCON_BOOTRST);
-		else
-			sdr_set_bits(host->base + EMMC_IOCON, EMMC_IOCON_BOOTRST);
-	}
-}
-
-static void msdc_core_power(struct msdc_host *host, int on)
-{
-	if (on && host->core_power == 0) {
-		msdc_vcore_on(host);
-		host->core_power = 1;
-		msleep(1);
-	} else if (!on && host->core_power == 1) {
-		msdc_vcore_off(host);
-		host->core_power = 0;
-		msleep(1);
-	}
-}
-
-static void msdc_host_power(struct msdc_host *host, int on)
-{
-	if (on) {
-		//msdc_core_power(host, 1); // need do card detection.
-		msdc_pin_reset(host, MSDC_PIN_PULL_UP);
-	} else {
-		msdc_pin_reset(host, MSDC_PIN_PULL_DOWN);
-		//msdc_core_power(host, 0);
-	}
-}
-
-static void msdc_card_power(struct msdc_host *host, int on)
-{
-	if (on) {
-		msdc_pin_config(host, MSDC_PIN_PULL_UP);
-		//msdc_vdd_on(host);  // need todo card detection.
-		msleep(1);
-	} else {
-		//msdc_vdd_off(host);
-		msdc_pin_config(host, MSDC_PIN_PULL_DOWN);
-		msleep(1);
-	}
-}
-
-static void msdc_set_power_mode(struct msdc_host *host, u8 mode)
-{
-	if (host->power_mode == MMC_POWER_OFF && mode != MMC_POWER_OFF) {
-		msdc_host_power(host, 1);
-		msdc_card_power(host, 1);
-	} else if (host->power_mode != MMC_POWER_OFF && mode == MMC_POWER_OFF) {
-		msdc_card_power(host, 0);
-		msdc_host_power(host, 0);
-	}
-	host->power_mode = mode;
-}
-#endif /* end of --- */
-
 #ifdef CONFIG_PM
 /*
    register as callback function of WIFI(combo_sdio_register_pm) .
@@ -754,14 +552,6 @@ static unsigned int msdc_do_command(struct msdc_host   *host,
 	return cmd->error;
 }
 
-#if 0 /* --- by chhung */
-// DMA resume / start / stop
-static void msdc_dma_resume(struct msdc_host *host)
-{
-	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_RESUME, 1);
-}
-#endif /* end of --- */
-
 static void msdc_dma_start(struct msdc_host *host)
 {
 	u32 wints = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO | MSDC_INTEN_DATCRCERR;
@@ -860,12 +650,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	cmd  = mrq->cmd;
 	data = mrq->cmd->data;
 
-#if 0 /* --- by chhung */
-	//if(host->id ==1){
-	msdc_ungate_clock(host->id);
-	//}
-#endif /* end of --- */
-
 	if (!data) {
 		send_type = SND_CMD;
 		if (msdc_do_command(host, cmd, 1, CMD_TIMEOUT) != 0)
@@ -952,38 +736,8 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 		host->blksz = 0;
-
-#if 0 // don't stop twice!
-		if (host->hw->flags & MSDC_REMOVABLE && data->error) {
-			msdc_abort_data(host);
-			/* reset in IRQ, stop command has issued. -> No need */
-		}
-#endif
-
 	}
 
-#if 0 /* --- by chhung */
-#if 1
-	//if(host->id==1) {
-	if (send_type == SND_CMD) {
-		if (cmd->opcode == MMC_SEND_STATUS) {
-			if ((cmd->resp[0] & CARD_READY_FOR_DATA) || (CARD_CURRENT_STATE(cmd->resp[0]) != 7)) {
-				msdc_gate_clock(host->id);
-			}
-		} else {
-			msdc_gate_clock(host->id);
-		}
-	} else {
-		if (read) {
-			msdc_gate_clock(host->id);
-		}
-	}
-	//}
-#else
-	msdc_gate_clock(host->id);
-#endif
-#endif /* end of --- */
-
 	if (mrq->cmd->error)
 		host->error = 0x001;
 	if (mrq->data && mrq->data->error)
@@ -1002,11 +756,7 @@ static int msdc_app_cmd(struct mmc_host *mmc, struct msdc_host *host)
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	cmd.opcode = MMC_APP_CMD;
-#if 0   /* bug: we meet mmc->card is null when ACMD6 */
-	cmd.arg = mmc->card->rca << 16;
-#else
 	cmd.arg = host->app_cmd_arg;
-#endif
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
@@ -1393,22 +1143,10 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 
-	//=== for sdio profile ===
-#if 0 /* --- by chhung */
-	u32 old_H32, old_L32, new_H32, new_L32;
-	u32 ticks = 0, opcode = 0, sizes = 0, bRx = 0;
-#endif /* end of --- */
-
 	WARN_ON(host->mrq);
 
 	/* start to process */
 	spin_lock(&host->lock);
-#if 0 /* --- by chhung */
-	if (sdio_pro_enable) {  //=== for sdio profile ===
-		if (mrq->cmd->opcode == 52 || mrq->cmd->opcode == 53)
-			GPT_GetCounter64(&old_L32, &old_H32);
-	}
-#endif /* end of --- */
 
 	host->mrq = mrq;
 
@@ -1428,26 +1166,6 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host->mrq = NULL;
 
-#if 0 /* --- by chhung */
-	//=== for sdio profile ===
-	if (sdio_pro_enable) {
-		if (mrq->cmd->opcode == 52 || mrq->cmd->opcode == 53) {
-			GPT_GetCounter64(&new_L32, &new_H32);
-			ticks = msdc_time_calc(old_L32, old_H32, new_L32, new_H32);
-
-			opcode = mrq->cmd->opcode;
-			if (mrq->cmd->data) {
-				sizes = mrq->cmd->data->blocks * mrq->cmd->data->blksz;
-				bRx = mrq->cmd->data->flags & MMC_DATA_READ ? 1 : 0;
-			} else {
-				bRx = mrq->cmd->arg	& 0x80000000 ? 1 : 0;
-			}
-
-			if (!mrq->cmd->error)
-				msdc_performance(opcode, sizes, bRx, ticks);
-		}
-	}
-#endif /* end of --- */
 	spin_unlock(&host->lock);
 
 	mmc_request_done(mmc, mrq);
@@ -1514,7 +1232,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 	case MMC_POWER_UP:
-		// msdc_set_power_mode(host, ios->power_mode); /* --- by chhung */
 		break;
 	case MMC_POWER_ON:
 		host->power_mode = MMC_POWER_ON;
@@ -1586,9 +1303,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 	/* MSDC_CD_PIN_EN set for card */
 	if (host->hw->flags & MSDC_CD_PIN_EN) {
 		spin_lock_irqsave(&host->lock, flags);
-#if 0
-		present = host->card_inserted;  /* why not read from H/W: Fix me*/
-#else
 		// CD
 		present = readl(host->base + MSDC_PS) & MSDC_PS_CDSTS;
 		if (cd_active_low)
@@ -1730,7 +1444,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		 * shouldn't be turned off. Here adds a reference count to keep
 		 * the core power alive.
 		 */
-		//msdc_vcore_on(host); //did in msdc_init_hw()
 
 		if (hw->config_gpio_pin) /* NULL */
 			hw->config_gpio_pin(MSDC_CD_PIN, GPIO_PULL_UP);
@@ -1753,22 +1466,12 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		/* Here decreases a reference count to core power since card
 		 * detection circuit is shutdown.
 		 */
-		//msdc_vcore_off(host);
 	}
 }
 
 /* called by msdc_drv_probe */
 static void msdc_init_hw(struct msdc_host *host)
 {
-
-	/* Power on */
-#if 0 /* --- by chhung */
-	msdc_vcore_on(host);
-	msdc_pin_reset(host, MSDC_PIN_PULL_UP);
-	msdc_select_clksrc(host, hw->clk_src);
-	enable_clock(PERI_MSDC0_PDN + host->id, "SD");
-	msdc_vdd_on(host);
-#endif /* end of --- */
 	/* Configure to MMC/SD mode */
 	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_MODE, MSDC_SDMMC);
 
@@ -1800,10 +1503,6 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	writel(0x00000000, host->base + MSDC_DAT_RDDLY1);
 	writel(0x00000000, host->base + MSDC_IOCON);
-#if 0 // use MT7620 default value: 0x403c004f
-	/* bit0 modified: Rx Data Clock Source: 1 -> 2.0*/
-	writel(0x003C000F, host->base + MSDC_PATCH_BIT0);
-#endif
 
 	if (readl(host->base + MSDC_ECO_VER) >= 4) {
 		if (host->id == 1) {
@@ -1870,7 +1569,6 @@ static void msdc_deinit_hw(struct msdc_host *host)
 
 	/* Disable card detection */
 	msdc_enable_cd_irq(host, 0);
-	// msdc_set_power_mode(host, MMC_POWER_OFF);   /* make sure power down */ /* --- by chhung */
 }
 
 /* init gpd and bd list in msdc_drv_probe */
-- 
2.17.1

