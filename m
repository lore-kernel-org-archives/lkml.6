Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF08C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968C120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDhHGpu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968C120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJCF5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:57:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39467 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCF5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:57:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id c25-v6so3965454qtp.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3N1wzedVA0efFG3NGyvrjlOjwranfgU0sWxolivwhmU=;
        b=lDhHGpu4FL6jTB66+i2Ribf3NKhMXp3iPoZRBxUGEauFai4f9/JQXho+fBFOt/TTFF
         zE/a7VWgF1oHW2cTyOkmy47gQmZt8+WU82eWhPZ3Y14DKIJSruPU7SEqlnDbhT+FIb16
         ww5v+yf1S8YXR0XWt90AmB+hqkqgtqny6T2zZhMwGTTIr5BFTYB8/j63E4Xbvq6zhI/J
         ipKduHTnDhMaG0fSlLVPvVN2gemrpwaPy1FStM1YvteqP6E/1PBh8AOjxTXuwfpO2wkh
         x6ffW8Mi2fFH/nhSw0q8hSytVhMK++plW36rLUjc9u936WAfia8m0BQk+Y37dtODYbsM
         yzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3N1wzedVA0efFG3NGyvrjlOjwranfgU0sWxolivwhmU=;
        b=e643HZwMycQ5+EytKj5HLxxgDDFX5v6Qmmqd5PI6XsnG9gEQWFL2LD8ZchVKk9baZn
         zJn1BtJ5p7q+tGdOwgLOX8DLmIq/a7OkGh1mpVE8vpV+kBY5rS0FiXSquAncLQi+2i6s
         6iAIDxmQfjZ6PWaMi3IEb3mqnDVv9lVB/MwPYiMzfK20knjt/qPPo48O/9b0sXr8Tonj
         tyWnTShXyLgrmTc2c2kccfgA6BFHmIKUd94tjPbe7gdUEsDTvDJWWsVLOW7ZQII/NoEQ
         OfF3SlVjKG3SDQ+f/LNuJpiuGUddgpOMhhb0SDnWY+iFjL0DdybB/6Ff36aMIbR60baj
         Q9mA==
X-Gm-Message-State: ABuFfoicPeOu6mpSgO9B7AQ0nJNfsdkNf52XvHhxoalfABsuQaIyhirw
        rBCmkSnx0ZnlUv3XxNt7UOA=
X-Google-Smtp-Source: ACcGV62F/K3M75fGhKBqiTqOyYx9viFQ0BK4zVgL0VYw/AJuMDl7RaN/J2bJC1nQWRq/umOPvXfTVw==
X-Received: by 2002:ac8:440d:: with SMTP id j13-v6mr14771274qtn.257.1538521895274;
        Tue, 02 Oct 2018 16:11:35 -0700 (PDT)
Received: from localhost.localdomain (modemcable043.227-201-24.mc.videotron.ca. [24.201.227.43])
        by smtp.gmail.com with ESMTPSA id 35-v6sm5535423qtr.91.2018.10.02.16.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:11:34 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH 1/6] Staging: rts5208: rtsx_card.c: Fixed all braces issues of the file
Date:   Tue,  2 Oct 2018 19:11:26 -0400
Message-Id: <20181002231126.10352-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all the braces issues of the rtsx_card.c file

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

