Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327FDC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8487206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYPga0AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8487206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeI2I3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:29:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41399 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2I3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:29:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id n3-v6so5036394qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y9Md5Q6/9sV1OVcJaFcHXKzkNihD2aB3y6L1xx83wcY=;
        b=gYPga0ASo8aUQBGDz9spWvt6kCf9G+CkZEJG5OM9SkO0xLVKyxZBO/+x0baMLIDL1Y
         OrA5mQhSBrsziFTFqUOGUfgwyFGqTdqPc6Krm4Wsi+aLDpj4NHRQBXHmQfeSG0XNrzoT
         oYthJLPzzZrYmnICQySERwt3Ywkmrnf2vvBH/ul4+54Hv7Xd8T13n+L4X8ZhOnUCM2NC
         w961dGxUvUpmjKx6HRFhvgHCvD7UAEXBRM8nAATOqWw4y4pkvfJ2ltYm1bSTOiz/iCze
         bhGb85NpPiTBzFVY4lVny9sYRjgyG8SPJQb6MTC+4jj+N5AZpvO47yflPufqpoNBpOCz
         HMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y9Md5Q6/9sV1OVcJaFcHXKzkNihD2aB3y6L1xx83wcY=;
        b=i59ffE4mJ+jQ8PyuWVVhEzG1M3MNkh/VovEIW8TcMA8lAzPZgg8ay2PB3gIqM2wtWs
         zp5Aypb2ato4kS03upkmELxePRx9M88GPZbzpiUb7vlyiLFX6wmevQ0vaoD75TT68Kvw
         MPVhpE1S/7QQhfzHLFByuezUXK3FFxleu/MHEWEgeHFBLc8Btb6khdFCTie10/apGZqV
         4CRHP06jMS7orbn9KZg6TyIa6k6fWRR7lF0ams8V/ZaRzlcnYEIT+OlRYYxRWTpv5qpj
         qDMO3xOMQ+INe/1wqHmduqFj/1CBmRfXpGjV9V7N/Be8EcVqfkb6Yq8+Dc9RVcZQ5uej
         s7vQ==
X-Gm-Message-State: ABuFfogVPl4CkJbnrSM4Aq0dOkUzYgJIkCHBQDDPevSWCWEv4jXgfpGm
        TT0xg05+UWw4ch1eBiJNPPA=
X-Google-Smtp-Source: ACcGV60ARvUzAI28RGrmq/cMpes6Uo+mJHcQs8L2P3zsPZcZFiJ+HxsDJcOKtYs1t/LMzpp+IWDzyA==
X-Received: by 2002:a37:84c4:: with SMTP id g187-v6mr964152qkd.49.1538186592342;
        Fri, 28 Sep 2018 19:03:12 -0700 (PDT)
Received: from localhost.localdomain (modemcable211.182-179-173.mc.videotron.ca. [173.179.182.211])
        by smtp.gmail.com with ESMTPSA id y50-v6sm758776qta.60.2018.09.28.19.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 19:03:11 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkhl@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH] Staging: rts5208: rtsx_card: Fixed multiple coding style issues
Date:   Fri, 28 Sep 2018 22:03:00 -0400
Message-Id: <20180929020300.23321-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed multiple coding style issues

Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
---
 drivers/staging/rts5208/rtsx_card.c | 96 +++++++++++------------------
 1 file changed, 37 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_card.c b/drivers/staging/rts5208/rtsx_card.c
index d26a8e372fce..b45abbe29bc2 100644
--- a/drivers/staging/rts5208/rtsx_card.c
+++ b/drivers/staging/rts5208/rtsx_card.c
@@ -647,9 +647,8 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 	dev_dbg(rtsx_dev(chip), "Switch SSC clock to %dMHz (cur_clk = %d)\n",
 		clk, chip->cur_clk);
 
-	if ((clk <= 2) || (n > max_n)) {
+	if ((clk <= 2) || (n > max_n))
 		return STATUS_FAIL;
-	}
 
 	mcu_cnt = (u8)(125 / clk + 3);
 	if (mcu_cnt > 7)
@@ -688,15 +687,13 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 	}
 
 	retval = rtsx_send_cmd(chip, 0, WAIT_TIME);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_ERROR;
-	}
 
 	udelay(10);
 	retval = rtsx_write_register(chip, CLK_CTL, CLK_LOW_FREQ, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->cur_clk = clk;
 
@@ -790,49 +787,44 @@ int switch_normal_clock(struct rtsx_chip *chip, int clk)
 	}
 
 	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, CLK_LOW_FREQ);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if (sd_vpclk_phase_reset) {
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
 					     PHASE_NOT_RESET, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 	retval = rtsx_write_register(chip, CLK_DIV, 0xFF,
 				     (div << 4) | mcu_cnt);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, CLK_SEL, 0xFF, sel);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (sd_vpclk_phase_reset) {
 		udelay(200);
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		udelay(200);
 	}
 	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->cur_clk = clk;
 
@@ -878,9 +870,8 @@ int enable_card_clock(struct rtsx_chip *chip, u8 card)
 		clk_en |= MS_CLK_EN;
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, clk_en);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -898,9 +889,8 @@ int disable_card_clock(struct rtsx_chip *chip, u8 card)
 		clk_en |= MS_CLK_EN;
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -924,9 +914,8 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, mask, val1);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	udelay(chip->pmos_pwr_on_interval);
 
@@ -934,9 +923,8 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, mask, val2);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -955,9 +943,8 @@ int card_power_off(struct rtsx_chip *chip, u8 card)
 	}
 
 	retval = rtsx_write_register(chip, CARD_PWR_CTL, mask, val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -969,9 +956,8 @@ int card_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	unsigned int lun = SCSI_LUN(srb);
 	int i;
 
-	if (!chip->rw_card[lun]) {
+	if (!chip->rw_card[lun])
 		return STATUS_FAIL;
-	}
 
 	for (i = 0; i < 3; i++) {
 		chip->rw_need_retry = 0;
@@ -1009,36 +995,33 @@ int card_share_mode(struct rtsx_chip *chip, int card)
 
 	if (CHECK_PID(chip, 0x5208)) {
 		mask = CARD_SHARE_MASK;
-		if (card == SD_CARD) {
+		if (card == SD_CARD)
 			value = CARD_SHARE_48_SD;
-		} else if (card == MS_CARD) {
+		else if (card == MS_CARD)
 			value = CARD_SHARE_48_MS;
-		} else if (card == XD_CARD) {
+		else if (card == XD_CARD)
 			value = CARD_SHARE_48_XD;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 
 	} else if (CHECK_PID(chip, 0x5288)) {
 		mask = 0x03;
-		if (card == SD_CARD) {
+		if (card == SD_CARD)
 			value = CARD_SHARE_BAROSSA_SD;
-		} else if (card == MS_CARD) {
+		else if (card == MS_CARD)
 			value = CARD_SHARE_BAROSSA_MS;
-		} else if (card == XD_CARD) {
+		else if (card == XD_CARD)
 			value = CARD_SHARE_BAROSSA_XD;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 
 	} else {
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_SHARE_MODE, mask, value);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1050,30 +1033,26 @@ int select_card(struct rtsx_chip *chip, int card)
 	if (chip->cur_card != card) {
 		u8 mod;
 
-		if (card == SD_CARD) {
+		if (card == SD_CARD)
 			mod = SD_MOD_SEL;
-		} else if (card == MS_CARD) {
+		else if (card == MS_CARD)
 			mod = MS_MOD_SEL;
-		} else if (card == XD_CARD) {
+		else if (card == XD_CARD)
 			mod = XD_MOD_SEL;
-		} else if (card == SPI_CARD) {
+		else if (card == SPI_CARD)
 			mod = SPI_MOD_SEL;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 
 		retval = rtsx_write_register(chip, CARD_SELECT, 0x07, mod);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		chip->cur_card = card;
 
 		retval =  card_share_mode(chip, card);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
-
 	return STATUS_SUCCESS;
 }
 
@@ -1120,9 +1099,8 @@ int detect_card_cd(struct rtsx_chip *chip, int card)
 	}
 
 	status = rtsx_readl(chip, RTSX_BIPR);
-	if (!(status & card_cd)) {
+	if (!(status & card_cd))
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
-- 
2.17.1

