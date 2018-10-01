Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C77208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY/iHakK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C77208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeJAVV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:21:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35493 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeJAVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:21:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so9397952pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pXTmhWPw8+V9bh6i4jz6mJs/WinemTlsGiiwOih7cdQ=;
        b=ZY/iHakK8p7GbsGIkrcJZUy4yT/I4Pxoz5tIypv74yCHstLTi5RdZ96yDvcPBcvmmE
         f0rV6T2zgra4f9tI+zPy+m7/HTtlc/EJrS6aFRsZCfQSFW4sfL3HWnOb3WtHZ5GTzVCb
         8WG/4VCzOjtDmgVzryq6opFkaTnVNDlgQyQQ2+MjBHzORje4L/fJSY09PVkH05iVRnfd
         D2g+4L/yedqnn4w91YQizrxSRhUyX8iBHlCxcbZ3rX7kN4eIP/E4Bw6t7UdPLB2KP+VL
         5806vxRM5SmSpprFSuV9PFN87kpt7rB7CkqqDIRcRlaJkS5R4o92tseN6cBARao42t5f
         y0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pXTmhWPw8+V9bh6i4jz6mJs/WinemTlsGiiwOih7cdQ=;
        b=lq8/nDnJeH4oAGvIblhJEXZ40UClOf+uHcNWaO5+IZ3wJ2yGyxe7WMBSz8Kgru0bp0
         BcbOuQ7AmA04rCwtrRRCG1cXtHm+PfZnZmRNv7lwCMsttwAUZ7nR7fzKgoxenmKU7J36
         0pXmo+PAK35DGOAUBMt+UkMDa3kgYWLkm4lq1VXqs1TG6zmSJPhIagcwtrqi0F03aXhk
         tVcMTK0cxv9QKsWrCgGO8XgottjyVDvIo2eYYGfR12COYh49p7V63wjGBAaRRvdQXKNG
         ituYhEnoPtZBwdq9lXumdKj9fvI5AdH7nQJU7mRCDvtPXnQzmTGQv+Hu4reYep1YjFtY
         wMhw==
X-Gm-Message-State: ABuFfogVb/t+nYnN5BCekIhalwCzS9Kw6bpsG3At3yWUJosZVEJJ2IQS
        jAj4l9cusDOfzq1VZlpjcuU=
X-Google-Smtp-Source: ACcGV60LLuUqNJp4jy46Gr2zjnmhEgwzT0LqQ1N91jX/lk5mohIWcUTjEkUOLnmdbEiVvtfT4vOmGA==
X-Received: by 2002:a62:6c48:: with SMTP id h69-v6mr11773820pfc.61.1538405027425;
        Mon, 01 Oct 2018 07:43:47 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 76-v6sm18099366pfk.134.2018.10.01.07.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 07:43:46 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:13:40 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 1/3] staging: mt7621-mmc: Remove #if 0 blocks
Message-ID: <b0ae4cb302d68d2fb0f6584bd8ecc8043f88845c.1538402548.git.nishadkamdar@gmail.com>
References: <cover.1538402548.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538402548.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if 0 code blocks and usages of
functions defined in the #if 0 blocks.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c |  21 +--
 drivers/staging/mt7621-mmc/dbg.h |  14 --
 drivers/staging/mt7621-mmc/sd.c  | 269 -------------------------------
 3 files changed, 1 insertion(+), 303 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index 4fe4d2fd111e..2bafb3bd026e 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -66,23 +66,6 @@ u32 sdio_pro_enable;   /* make sure gpt is enabled */
 u32 sdio_pro_time;     /* no more than 30s */
 struct sdio_profile sdio_perfomance = {0};
 
-#if 0 /* --- chhung */
-void msdc_init_gpt(void)
-{
-	GPT_CONFIG config;
-
-	config.num  = GPT6;
-	config.mode = GPT_FREE_RUN;
-	config.clkSrc = GPT_CLK_SRC_SYS;
-	config.clkDiv = GPT_CLK_DIV_1;   /* 13MHz GPT6 */
-
-	if (GPT_Config(config) == FALSE)
-		return;
-
-	GPT_Start(GPT6);
-}
-#endif /* end of --- */
-
 u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32)
 {
 	u32 ret = 0;
@@ -268,10 +251,8 @@ static ssize_t msdc_debug_proc_write(struct file *file,
 		}
 	} else if (cmd == SD_TOOL_SDIO_PROFILE) {
 		if (p1 == 1) { /* enable profile */
-			if (gpt_enable == 0) {
-				// msdc_init_gpt(); /* --- by chhung */
+			if (gpt_enable == 0)
 				gpt_enable = 1;
-			}
 			sdio_pro_enable = 1;
 			if (p2 == 0)
 				p2 = 1;
diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 4ab9f10dccc2..2a044c375910 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -91,23 +91,9 @@ enum msdc_dbg {
 
 extern unsigned int sd_debug_zone[4];
 #define TAG "msdc"
-#if 0 /* +++ chhung */
-#define BUG_ON(x) \
-do { \
-	if (x) { \
-		printk("[BUG] %s LINE:%d FILE:%s\n", #x, __LINE__, __FILE__); \
-		while (1)						\
-			;						\
-	} \
-} while (0)
-#endif /* end of +++ */
 
 void msdc_debug_proc_init(void);
 
-#if 0 /* --- chhung */
-void msdc_init_gpt(void);
-extern void GPT_GetCounter64(UINT32 *cntL32, UINT32 *cntH32);
-#endif /* end of --- */
 u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32);
 void msdc_performance(u32 opcode, u32 sizes, u32 bRx, u32 ticks);
 
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index e3c1546373ba..c88b82488464 100644
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
@@ -252,7 +227,6 @@ static void msdc_tasklet_card(struct work_struct *work)
 				struct msdc_host, card_delaywork.work);
 	u32 inserted;
 	u32 status = 0;
-    //u32 change = 0;
 
 	spin_lock(&host->lock);
 
@@ -262,53 +236,16 @@ static void msdc_tasklet_card(struct work_struct *work)
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
@@ -389,115 +326,6 @@ static void msdc_abort_data(struct msdc_host *host)
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
@@ -754,14 +582,6 @@ static unsigned int msdc_do_command(struct msdc_host   *host,
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
@@ -860,12 +680,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -952,37 +766,7 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
-	}
-
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
 	}
-	//}
-#else
-	msdc_gate_clock(host->id);
-#endif
-#endif /* end of --- */
 
 	if (mrq->cmd->error)
 		host->error = 0x001;
@@ -1002,11 +786,7 @@ static int msdc_app_cmd(struct mmc_host *mmc, struct msdc_host *host)
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	cmd.opcode = MMC_APP_CMD;
-#if 0   /* bug: we meet mmc->card is null when ACMD6 */
-	cmd.arg = mmc->card->rca << 16;
-#else
 	cmd.arg = host->app_cmd_arg;
-#endif
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
@@ -1393,22 +1173,10 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
 
@@ -1428,26 +1196,6 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
@@ -1514,7 +1262,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 	case MMC_POWER_UP:
-		// msdc_set_power_mode(host, ios->power_mode); /* --- by chhung */
 		break;
 	case MMC_POWER_ON:
 		host->power_mode = MMC_POWER_ON;
@@ -1586,9 +1333,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 	/* MSDC_CD_PIN_EN set for card */
 	if (host->hw->flags & MSDC_CD_PIN_EN) {
 		spin_lock_irqsave(&host->lock, flags);
-#if 0
-		present = host->card_inserted;  /* why not read from H/W: Fix me*/
-#else
 		// CD
 		present = readl(host->base + MSDC_PS) & MSDC_PS_CDSTS;
 		if (cd_active_low)
@@ -1761,14 +1505,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 static void msdc_init_hw(struct msdc_host *host)
 {
 
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
 
@@ -1800,10 +1536,6 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	writel(0x00000000, host->base + MSDC_DAT_RDDLY1);
 	writel(0x00000000, host->base + MSDC_IOCON);
-#if 0 // use MT7620 default value: 0x403c004f
-	/* bit0 modified: Rx Data Clock Source: 1 -> 2.0*/
-	writel(0x003C000F, host->base + MSDC_PATCH_BIT0);
-#endif
 
 	if (readl(host->base + MSDC_ECO_VER) >= 4) {
 		if (host->id == 1) {
@@ -1870,7 +1602,6 @@ static void msdc_deinit_hw(struct msdc_host *host)
 
 	/* Disable card detection */
 	msdc_enable_cd_irq(host, 0);
-	// msdc_set_power_mode(host, MMC_POWER_OFF);   /* make sure power down */ /* --- by chhung */
 }
 
 /* init gpd and bd list in msdc_drv_probe */
-- 
2.17.1

