Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26588C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FC420841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaehYURN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FC420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeIAC0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:26:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33880 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeIAC0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:26:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so6120209pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1zpT7iHag5EqPTamt0NGk+eY+7hY6DG2HzAahEePJpc=;
        b=LaehYURNol1wGWYn685fZXzXQky+LV/z9KJ0Q2k4zNwmF+vh0eZyWrvz6MogKzYn+c
         jixi7kU4GLT7jfK3jZCZtOcR0Gq05xjRfuo5ocdiKPKCkStKttp6uuf6pdDKu1AAyI2o
         a0KDQ/VOIDmpYgWx6r93IIEWv40GvVUTUzfvjxATbUV/kGvK6zDEqriok5df2teJSq9g
         AG8oJohhhToMqfHxEutEhUK45ilSFMT/m6/RC07KmrcU68nUf/jj26oTa5aElT9bDU9M
         hMMOkPFLvQBtHg3X0NZ2SVrSZSZlyG21ZD5Eq4ztXgR7XRBHj0TrlNCxs/3mkqREh1eC
         LZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1zpT7iHag5EqPTamt0NGk+eY+7hY6DG2HzAahEePJpc=;
        b=ZvjS9Q2/0njt+u5EZNdOwEJEPwTAYE9p0Y19LFUHz6kx36Ysf2wJYEfrfOhl45qJ76
         OKn3d27+W4HJJyt07ztDpDBs5hugLH4T/VYgrZGZFMveiDJctiOR2kaQJweX5bSCiyCi
         B1/fUu41xbl2YcZ351JqUBfnJSquRwPNOrxtla9YsCT8qQh6pON80lVcE5P/nWoFhM1a
         fQOlD07zVaM4cgFMPpHaVbjjdydDQV/6+QmNDz0gPl5afnVcm4kW0AEKyxSlD63Xqdrk
         SKcYR4/D97tKoGRbCQ67yFM1rOiDcORI+fPMi4hPkVi+18pYq/x0qHx9puklMgFzO290
         K+4Q==
X-Gm-Message-State: APzg51C8X3g0oXvJ7HxoQchwDtR9VYibmA7YO5XHG5ukMe5lv35mdkuM
        qdXSZ7mI2bpSGQfHIkXKA0s=
X-Google-Smtp-Source: ANB0VdbDDXXGy6DRqZcZAbcHbXDZrIZby13Lv6CjHmBrz8y9JKeOw+FBfoXEnp1Z0FdkfBarrR58fA==
X-Received: by 2002:a63:f002:: with SMTP id k2-v6mr16146104pgh.8.1535753842625;
        Fri, 31 Aug 2018 15:17:22 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id w81-v6sm21317989pfk.92.2018.08.31.15.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:17:22 -0700 (PDT)
Date:   Sat, 1 Sep 2018 03:47:15 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 1/3] staging: mt7621-mmc: Delete N_MSG() and all its users
Message-ID: <95f3b2d4cb51b0eb4c5b93106913d1fd16075579.1535752537.git.nishadkamdar@gmail.com>
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

This patch removes N_MSG() and all its users since it is a no-op.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v6:
  - Delete N_MSG() and all its users.
Changes in v5:
  - Remove commented code for N_MSG()
---
 drivers/staging/mt7621-mmc/dbg.h |  10 --
 drivers/staging/mt7621-mmc/sd.c  | 242 -------------------------------
 2 files changed, 252 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 4d4898a3ab54..9152db30a2ed 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -102,16 +102,6 @@ do { \
 } while (0)
 #endif /* end of +++ */
 
-#define N_MSG(evt, fmt, args...)
-/*
-do {    \
-    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
-        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
-    } \
-} while(0)
-*/
-
 #define ERR_MSG(fmt, args...) \
 do { \
 	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 4cd4df4fc75f..0154117fae15 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -230,144 +230,6 @@ static unsigned int msdc_do_command(struct msdc_host   *host,
 
 static int msdc_tune_cmdrsp(struct msdc_host *host, struct mmc_command *cmd);
 
-#ifdef MT6575_SD_DEBUG
-static void msdc_dump_card_status(struct msdc_host *host, u32 status)
-{
-/* N_MSG is currently a no-op */
-#if 0
-	static char *state[] = {
-		"Idle",			/* 0 */
-		"Ready",		/* 1 */
-		"Ident",		/* 2 */
-		"Stby",			/* 3 */
-		"Tran",			/* 4 */
-		"Data",			/* 5 */
-		"Rcv",			/* 6 */
-		"Prg",			/* 7 */
-		"Dis",			/* 8 */
-		"Reserved",		/* 9 */
-		"Reserved",		/* 10 */
-		"Reserved",		/* 11 */
-		"Reserved",		/* 12 */
-		"Reserved",		/* 13 */
-		"Reserved",		/* 14 */
-		"I/O mode",		/* 15 */
-	};
-#endif
-	if (status & R1_OUT_OF_RANGE)
-		N_MSG(RSP, "[CARD_STATUS] Out of Range");
-	if (status & R1_ADDRESS_ERROR)
-		N_MSG(RSP, "[CARD_STATUS] Address Error");
-	if (status & R1_BLOCK_LEN_ERROR)
-		N_MSG(RSP, "[CARD_STATUS] Block Len Error");
-	if (status & R1_ERASE_SEQ_ERROR)
-		N_MSG(RSP, "[CARD_STATUS] Erase Seq Error");
-	if (status & R1_ERASE_PARAM)
-		N_MSG(RSP, "[CARD_STATUS] Erase Param");
-	if (status & R1_WP_VIOLATION)
-		N_MSG(RSP, "[CARD_STATUS] WP Violation");
-	if (status & R1_CARD_IS_LOCKED)
-		N_MSG(RSP, "[CARD_STATUS] Card is Locked");
-	if (status & R1_LOCK_UNLOCK_FAILED)
-		N_MSG(RSP, "[CARD_STATUS] Lock/Unlock Failed");
-	if (status & R1_COM_CRC_ERROR)
-		N_MSG(RSP, "[CARD_STATUS] Command CRC Error");
-	if (status & R1_ILLEGAL_COMMAND)
-		N_MSG(RSP, "[CARD_STATUS] Illegal Command");
-	if (status & R1_CARD_ECC_FAILED)
-		N_MSG(RSP, "[CARD_STATUS] Card ECC Failed");
-	if (status & R1_CC_ERROR)
-		N_MSG(RSP, "[CARD_STATUS] CC Error");
-	if (status & R1_ERROR)
-		N_MSG(RSP, "[CARD_STATUS] Error");
-	if (status & R1_UNDERRUN)
-		N_MSG(RSP, "[CARD_STATUS] Underrun");
-	if (status & R1_OVERRUN)
-		N_MSG(RSP, "[CARD_STATUS] Overrun");
-	if (status & R1_CID_CSD_OVERWRITE)
-		N_MSG(RSP, "[CARD_STATUS] CID/CSD Overwrite");
-	if (status & R1_WP_ERASE_SKIP)
-		N_MSG(RSP, "[CARD_STATUS] WP Eraser Skip");
-	if (status & R1_CARD_ECC_DISABLED)
-		N_MSG(RSP, "[CARD_STATUS] Card ECC Disabled");
-	if (status & R1_ERASE_RESET)
-		N_MSG(RSP, "[CARD_STATUS] Erase Reset");
-	if (status & R1_READY_FOR_DATA)
-		N_MSG(RSP, "[CARD_STATUS] Ready for Data");
-	if (status & R1_SWITCH_ERROR)
-		N_MSG(RSP, "[CARD_STATUS] Switch error");
-	if (status & R1_APP_CMD)
-		N_MSG(RSP, "[CARD_STATUS] App Command");
-
-	N_MSG(RSP, "[CARD_STATUS] '%s' State", state[R1_CURRENT_STATE(status)]);
-}
-
-static void msdc_dump_ocr_reg(struct msdc_host *host, u32 resp)
-{
-	if (resp & (1 << 7))
-		N_MSG(RSP, "[OCR] Low Voltage Range");
-	if (resp & (1 << 15))
-		N_MSG(RSP, "[OCR] 2.7-2.8 volt");
-	if (resp & (1 << 16))
-		N_MSG(RSP, "[OCR] 2.8-2.9 volt");
-	if (resp & (1 << 17))
-		N_MSG(RSP, "[OCR] 2.9-3.0 volt");
-	if (resp & (1 << 18))
-		N_MSG(RSP, "[OCR] 3.0-3.1 volt");
-	if (resp & (1 << 19))
-		N_MSG(RSP, "[OCR] 3.1-3.2 volt");
-	if (resp & (1 << 20))
-		N_MSG(RSP, "[OCR] 3.2-3.3 volt");
-	if (resp & (1 << 21))
-		N_MSG(RSP, "[OCR] 3.3-3.4 volt");
-	if (resp & (1 << 22))
-		N_MSG(RSP, "[OCR] 3.4-3.5 volt");
-	if (resp & (1 << 23))
-		N_MSG(RSP, "[OCR] 3.5-3.6 volt");
-	if (resp & (1 << 24))
-		N_MSG(RSP, "[OCR] Switching to 1.8V Accepted (S18A)");
-	if (resp & (1 << 30))
-		N_MSG(RSP, "[OCR] Card Capacity Status (CCS)");
-	if (resp & (1 << 31))
-		N_MSG(RSP, "[OCR] Card Power Up Status (Idle)");
-	else
-		N_MSG(RSP, "[OCR] Card Power Up Status (Busy)");
-}
-
-static void msdc_dump_rca_resp(struct msdc_host *host, u32 resp)
-{
-	u32 status = (((resp >> 15) & 0x1) << 23) |
-		     (((resp >> 14) & 0x1) << 22) |
-		     (((resp >> 13) & 0x1) << 19) |
-		     (resp & 0x1fff);
-
-	N_MSG(RSP, "[RCA] 0x%.4x", resp >> 16);
-	msdc_dump_card_status(host, status);
-}
-
-static void msdc_dump_io_resp(struct msdc_host *host, u32 resp)
-{
-	u32 flags = (resp >> 8) & 0xFF;
-#if 0
-	char *state[] = {"DIS", "CMD", "TRN", "RFU"};
-#endif
-	if (flags & (1 << 7))
-		N_MSG(RSP, "[IO] COM_CRC_ERR");
-	if (flags & (1 << 6))
-		N_MSG(RSP, "[IO] Illegal command");
-	if (flags & (1 << 3))
-		N_MSG(RSP, "[IO] Error");
-	if (flags & (1 << 2))
-		N_MSG(RSP, "[IO] RFU");
-	if (flags & (1 << 1))
-		N_MSG(RSP, "[IO] Function number error");
-	if (flags & (1 << 0))
-		N_MSG(RSP, "[IO] Out of range");
-
-	N_MSG(RSP, "[IO] State: %s, Data:0x%x", state[(resp >> 12) & 0x3], resp & 0xFF);
-}
-#endif
-
 static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 {
 	u32 timeout, clk_ns;
@@ -382,9 +244,6 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 	timeout = timeout > 255 ? 255 : timeout;
 
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, timeout);
-
-	N_MSG(OPS, "Set read data timeout: %dns %dclks -> %d x 65536 cycles",
-	      ns, clks, timeout + 1);
 }
 
 static void msdc_tasklet_card(struct work_struct *work)
@@ -572,8 +431,6 @@ static void msdc_pin_config(struct msdc_host *host, int mode)
 		break;
 	}
 
-	N_MSG(CFG, "Pins mode(%d), down(%d), up(%d)",
-	      mode, MSDC_PIN_PULL_DOWN, MSDC_PIN_PULL_UP);
 }
 
 void msdc_pin_reset(struct msdc_host *host, int mode)
@@ -595,9 +452,6 @@ void msdc_pin_reset(struct msdc_host *host, int mode)
 
 static void msdc_core_power(struct msdc_host *host, int on)
 {
-	N_MSG(CFG, "Turn %s %s power (copower: %d -> %d)",
-		on ? "on" : "off", "core", host->core_power, on);
-
 	if (on && host->core_power == 0) {
 		msdc_vcore_on(host);
 		host->core_power = 1;
@@ -611,8 +465,6 @@ static void msdc_core_power(struct msdc_host *host, int on)
 
 static void msdc_host_power(struct msdc_host *host, int on)
 {
-	N_MSG(CFG, "Turn %s %s power ", on ? "on" : "off", "host");
-
 	if (on) {
 		//msdc_core_power(host, 1); // need do card detection.
 		msdc_pin_reset(host, MSDC_PIN_PULL_UP);
@@ -624,8 +476,6 @@ static void msdc_host_power(struct msdc_host *host, int on)
 
 static void msdc_card_power(struct msdc_host *host, int on)
 {
-	N_MSG(CFG, "Turn %s %s power ", on ? "on" : "off", "card");
-
 	if (on) {
 		msdc_pin_config(host, MSDC_PIN_PULL_UP);
 		//msdc_vdd_on(host);  // need todo card detection.
@@ -639,8 +489,6 @@ static void msdc_card_power(struct msdc_host *host, int on)
 
 static void msdc_set_power_mode(struct msdc_host *host, u8 mode)
 {
-	N_MSG(CFG, "Set power mode(%d)", mode);
-
 	if (host->power_mode == MMC_POWER_OFF && mode != MMC_POWER_OFF) {
 		msdc_host_power(host, 1);
 		msdc_card_power(host, 1);
@@ -789,8 +637,6 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 		rawcmd &= ~(0x0FFF << 16);
 	}
 
-	N_MSG(CMD, "CMD<%d><0x%.8x> Arg<0x%.8x>", opcode, rawcmd, cmd->arg);
-
 	tmo = jiffies + timeout;
 
 	if (opcode == MMC_SEND_STATUS) {
@@ -859,40 +705,6 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 	host->cmd = NULL;
 
 //end:
-#ifdef MT6575_SD_DEBUG
-	switch (resp) {
-	case RESP_NONE:
-		N_MSG(RSP, "CMD_RSP(%d): %d RSP(%d)", opcode, cmd->error, resp);
-		break;
-	case RESP_R2:
-		N_MSG(RSP, "CMD_RSP(%d): %d RSP(%d)= %.8x %.8x %.8x %.8x",
-			opcode, cmd->error, resp, cmd->resp[0], cmd->resp[1],
-			cmd->resp[2], cmd->resp[3]);
-		break;
-	default: /* Response types 1, 3, 4, 5, 6, 7(1b) */
-		N_MSG(RSP, "CMD_RSP(%d): %d RSP(%d)= 0x%.8x",
-			opcode, cmd->error, resp, cmd->resp[0]);
-		if (cmd->error == 0) {
-			switch (resp) {
-			case RESP_R1:
-			case RESP_R1B:
-				msdc_dump_card_status(host, cmd->resp[0]);
-				break;
-			case RESP_R3:
-				msdc_dump_ocr_reg(host, cmd->resp[0]);
-				break;
-			case RESP_R5:
-				msdc_dump_io_resp(host, cmd->resp[0]);
-				break;
-			case RESP_R6:
-				msdc_dump_rca_resp(host, cmd->resp[0]);
-				break;
-			}
-		}
-		break;
-	}
-#endif
-
 	/* do we need to save card's RCA when SD_SEND_RELATIVE_ADDR */
 
 	if (!tune)
@@ -934,7 +746,6 @@ static unsigned int msdc_do_command(struct msdc_host   *host,
 
 end:
 
-	N_MSG(CMD, "        return<%d> resp<0x%.8x>", cmd->error, cmd->resp[0]);
 	return cmd->error;
 }
 
@@ -943,8 +754,6 @@ static unsigned int msdc_do_command(struct msdc_host   *host,
 static void msdc_dma_resume(struct msdc_host *host)
 {
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_RESUME, 1);
-
-	N_MSG(DMA, "DMA resume");
 }
 #endif /* end of --- */
 
@@ -955,8 +764,6 @@ static void msdc_dma_start(struct msdc_host *host)
 	sdr_set_bits(host->base + MSDC_INTEN, wints);
 	//dsb(); /* --- by chhung */
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
-
-	N_MSG(DMA, "DMA start");
 }
 
 static void msdc_dma_stop(struct msdc_host *host)
@@ -964,7 +771,6 @@ static void msdc_dma_stop(struct msdc_host *host)
 	//u32 retries=500;
 	u32 wints = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO | MSDC_INTEN_DATCRCERR;
 
-	N_MSG(DMA, "DMA status: 0x%.8x", readl(host->base + MSDC_DMA_CFG));
 	//while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS);
 
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP, 1);
@@ -973,8 +779,6 @@ static void msdc_dma_stop(struct msdc_host *host)
 
 	//dsb(); /* --- by chhung */
 	sdr_clr_bits(host->base + MSDC_INTEN, wints); /* Not just xfer_comp */
-
-	N_MSG(DMA, "DMA stop");
 }
 
 /* calc checksum */
@@ -997,8 +801,6 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 
 	BUG_ON(sglen > MAX_BD_NUM); /* not support currently */
 
-	N_MSG(DMA, "DMA sglen<%d> xfersz<%d>", sglen, host->xfer_size);
-
 	gpd = dma->gpd;
 	bd  = dma->bd;
 
@@ -1031,10 +833,6 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_MODE, 1);
 
 	writel(PHYSADDR((u32)dma->gpd_addr), host->base + MSDC_DMA_SA);
-
-	N_MSG(DMA, "DMA_CTRL = 0x%x", readl(host->base + MSDC_DMA_CTRL));
-	N_MSG(DMA, "DMA_CFG  = 0x%x", readl(host->base + MSDC_DMA_CFG));
-	N_MSG(DMA, "DMA_SA   = 0x%x", readl(host->base + MSDC_DMA_SA));
 }
 
 static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -1059,7 +857,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 #if 0 /* --- by chhung */
 	//if(host->id ==1){
-	N_MSG(OPS, "enable clock!");
 	msdc_ungate_clock(host->id);
 	//}
 #endif /* end of --- */
@@ -1151,8 +948,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		}
 #endif
 
-		N_MSG(OPS, "CMD<%d> data<%s %s> blksz<%d> block<%d> error<%d>", cmd->opcode, (dma ? "dma" : "pio"),
-			(read ? "read " : "write"), data->blksz, data->blocks, data->error);
 	}
 
 #if 0 /* --- by chhung */
@@ -1161,16 +956,13 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (send_type == SND_CMD) {
 		if (cmd->opcode == MMC_SEND_STATUS) {
 			if ((cmd->resp[0] & CARD_READY_FOR_DATA) || (CARD_CURRENT_STATE(cmd->resp[0]) != 7)) {
-				N_MSG(OPS, "disable clock, CMD13 IDLE");
 				msdc_gate_clock(host->id);
 			}
 		} else {
-			N_MSG(OPS, "disable clock, CMD<%d>", cmd->opcode);
 			msdc_gate_clock(host->id);
 		}
 	} else {
 		if (read) {
-			N_MSG(OPS, "disable clock!!! Read CMD<%d>", cmd->opcode);
 			msdc_gate_clock(host->id);
 		}
 	}
@@ -1646,8 +1438,6 @@ static void msdc_set_buswidth(struct msdc_host *host, u32 width)
 	}
 
 	writel(val, host->base + SDC_CFG);
-
-	N_MSG(CFG, "Bus Width = %d", width);
 }
 
 /* ops.set_ios */
@@ -1890,34 +1680,6 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		printk(KERN_INFO "msdc[%d] MMCIRQ: SDC_CSTS=0x%.8x\r\n",
 		       host->id, readl(host->base + SDC_CSTS));
 
-#ifdef MT6575_SD_DEBUG
-	{
-/*        msdc_int_reg *int_reg = (msdc_int_reg*)&intsts;*/
-		N_MSG(INT, "IRQ_EVT(0x%x): MMCIRQ(%d) CDSC(%d), ACRDY(%d), ACTMO(%d), ACCRE(%d) AC19DN(%d)",
-			intsts,
-			int_reg->mmcirq,
-			int_reg->cdsc,
-			int_reg->atocmdrdy,
-			int_reg->atocmdtmo,
-			int_reg->atocmdcrc,
-			int_reg->atocmd19done);
-		N_MSG(INT, "IRQ_EVT(0x%x): SDIO(%d) CMDRDY(%d), CMDTMO(%d), RSPCRC(%d), CSTA(%d)",
-			intsts,
-			int_reg->sdioirq,
-			int_reg->cmdrdy,
-			int_reg->cmdtmo,
-			int_reg->rspcrc,
-			int_reg->csta);
-		N_MSG(INT, "IRQ_EVT(0x%x): XFCMP(%d) DXDONE(%d), DATTMO(%d), DATCRC(%d), DMAEMP(%d)",
-			intsts,
-			int_reg->xfercomp,
-			int_reg->dxferdone,
-			int_reg->dattmo,
-			int_reg->datcrc,
-			int_reg->dmaqempty);
-	}
-#endif
-
 	return IRQ_HANDLED;
 }
 
@@ -1942,8 +1704,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 		return;
 	}
 
-	N_MSG(CFG, "CD IRQ Enable(%d)", enable);
-
 	if (enable) {
 		/* card detection circuit relies on the core power so that the core power
 		 * shouldn't be turned off. Here adds a reference count to keep
@@ -2078,8 +1838,6 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, DEFAULT_DTOC);
 
 	msdc_set_buswidth(host, MMC_BUS_WIDTH_1);
-
-	N_MSG(FUC, "init hardware done!");
 }
 
 /* called by msdc_drv_remove */
-- 
2.17.1

