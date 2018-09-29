Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405ABC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC88220879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh31vuB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC88220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeI2WWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:22:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35342 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbeI2WWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:22:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id a189-v6so5709795qkb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fafIhU0ydVre1h5NTvmMX+bGbfiiR9/Lo6pBZ8Bp300=;
        b=Yh31vuB4R3+tcBqI4WWNeD9T1W2rhWqRElofdTobxb3cwfGK/7BHsdq3Zp6tK9LMZz
         xS203E4i9qVxY0FKAYx9rqvMOATDeXPz7FEdwKnSU9E5AgnA2NV2FfXbXrSQsFSaplW2
         RSGcsPpPS5GyLke2ne/H8se/BqeMr/AI9o6byJkM+Y9nXbBqvOj/i3AAYuDHsOPjwM0a
         1on/FCaGLB1qOi2b2+2evW/G5ijHBG8uf99AEPSKZm71+UMzJnwTs2dBl0WBOeYBZN+8
         vXZiWim/lgjKjO/5A2ocjXp7fGHC9CI5Lqiwuv2wi0vXkSZE0qzFr5cQEjziYU7BB4FP
         VB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fafIhU0ydVre1h5NTvmMX+bGbfiiR9/Lo6pBZ8Bp300=;
        b=uAaS1rh2i49S01SqPrcQoH5vIHqTYXvDJb8Btk3Vhc9VJqc0bPF3TJrPmhKwYkw33Y
         JDIQKMGLrvNI6SEa1yP/uRJqSbSzjTpCUVfaqG5MIbEYHsSjzgX0JefbqTKHoa956bq1
         j6GZqbdxjcTl+3nNL7jG8ox4EkUa07VBBSJNXdHJlQ8qmiIQcgkEIV6uL75ahZY6zjzd
         kI91DM3Se63U8USXwbJSNQrXblEJyFQ+Yozgs9uBRSwIbpE7J/Vl+FOyaoyFD6DpUZBg
         mhs69lE6BYAdK0oA8GR7K0i28iOViNY9Vwa70rGvrsJkbqya7i3di2TeJZGq/1lATLYH
         XXcg==
X-Gm-Message-State: ABuFfogFmj4mXaFoohisG2NWJIBx0zJ1PSqvVrVv5EzOCV+LnVQx4R0r
        OoqQKZT2N0kX3vMhM83SyLnTSmUpNh8=
X-Google-Smtp-Source: ACcGV617ePFd428rwbkSpWYvIMSq9qq5wzAjEeH40ZpF+F3+WFaMkpPXqr1ZyzrTSlDRtDC/0bCjYA==
X-Received: by 2002:a37:6888:: with SMTP id d130-v6mr2676019qkc.192.1538236420000;
        Sat, 29 Sep 2018 08:53:40 -0700 (PDT)
Received: from localhost.localdomain (modemcable211.182-179-173.mc.videotron.ca. [173.179.182.211])
        by smtp.gmail.com with ESMTPSA id c2-v6sm4201365qkc.20.2018.09.29.08.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 08:53:39 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH 2/4] Staging: rts5208: rtsx_chip.c: Fixed all braces issues of the file
Date:   Sat, 29 Sep 2018 11:53:32 -0400
Message-Id: <20180929155332.18645-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all the braces issues of the rtsx_chip.c file

Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
---
 drivers/staging/rts5208/rtsx_chip.c | 463 ++++++++++++----------------
 1 file changed, 199 insertions(+), 264 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index 6b1234bff09c..6bec2ddc75f2 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -116,34 +116,31 @@ static int rtsx_pre_handle_sdio_old(struct rtsx_chip *chip)
 						     0xFF,
 						     MS_INS_PU | SD_WP_PU |
 						     SD_CD_PU | SD_CMD_PU);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 		} else {
 			retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 						     0xFF,
 						     FPGA_SD_PULL_CTL_EN);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 		}
 		retval = rtsx_write_register(chip, CARD_SHARE_MODE, 0xFF,
 					     CARD_SHARE_48_SD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		/* Enable SDIO internal clock */
 		retval = rtsx_write_register(chip, 0xFF2C, 0x01, 0x01);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		retval = rtsx_write_register(chip, SDIO_CTRL, 0xFF,
 					     SDIO_BUS_CTRL | SDIO_CD_CTRL);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		chip->sd_int = 1;
 		chip->sd_io = 1;
@@ -164,16 +161,16 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 	if (chip->driver_first_load) {
 		if (CHECK_PID(chip, 0x5288)) {
 			retval = rtsx_read_register(chip, 0xFE5A, &tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			if (tmp & 0x08)
 				sw_bypass_sd = true;
 		} else if (CHECK_PID(chip, 0x5208)) {
 			retval = rtsx_read_register(chip, 0xFE70, &tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			if (tmp & 0x80)
 				sw_bypass_sd = true;
 		}
@@ -192,9 +189,9 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 		u8 cd_toggle_mask = 0;
 
 		retval = rtsx_read_register(chip, TLPTISTAT, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		cd_toggle_mask = 0x08;
 
 		if (tmp & cd_toggle_mask) {
@@ -202,22 +199,20 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 			if (CHECK_PID(chip, 0x5288)) {
 				retval = rtsx_write_register(chip, 0xFE5A,
 							     0x08, 0x00);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
+
 			} else if (CHECK_PID(chip, 0x5208)) {
 				retval = rtsx_write_register(chip, 0xFE70,
 							     0x80, 0x00);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
 			}
 
 			retval = rtsx_write_register(chip, TLPTISTAT, 0xFF,
 						     tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 
 			chip->need_reset |= SD_CARD;
 		} else {
@@ -225,36 +220,35 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 
 			if (chip->asic_code) {
 				retval = sd_pull_ctl_enable(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
+
 			} else {
 				retval = rtsx_write_register
 						(chip, FPGA_PULL_CTL,
 						 FPGA_SD_PULL_CTL_BIT | 0x20,
 						 0);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
+
 			}
 			retval = card_share_mode(chip, SD_CARD);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			/* Enable sdio_bus_auto_switch */
 			if (CHECK_PID(chip, 0x5288)) {
 				retval = rtsx_write_register(chip, 0xFE5A,
 							     0x08, 0x08);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
+
 			} else if (CHECK_PID(chip, 0x5208)) {
 				retval = rtsx_write_register(chip, 0xFE70,
 							     0x80, 0x80);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
+
 			}
 
 			chip->chip_insert_with_sdio = 1;
@@ -262,9 +256,8 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 		}
 	} else {
 		retval = rtsx_write_register(chip, TLPTISTAT, 0x08, 0x08);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		chip->need_reset |= SD_CARD;
 	}
@@ -283,32 +276,30 @@ static int rtsx_reset_aspm(struct rtsx_chip *chip)
 
 		ret = rtsx_write_cfg_dw(chip, 2, 0xC0, 0xFF,
 					chip->aspm_l0s_l1_en);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		return STATUS_SUCCESS;
 	}
 
 	if (CHECK_PID(chip, 0x5208)) {
 		ret = rtsx_write_register(chip, ASPM_FORCE_CTL, 0xFF, 0x3F);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
+
 	}
 	ret = rtsx_write_config_byte(chip, LCTLR, chip->aspm_l0s_l1_en);
-	if (ret != STATUS_SUCCESS) {
+	if (ret != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	chip->aspm_level[0] = chip->aspm_l0s_l1_en;
 	if (CHK_SDIO_EXIST(chip)) {
 		chip->aspm_level[1] = chip->aspm_l0s_l1_en;
 		ret = rtsx_write_cfg_dw(chip, CHECK_PID(chip, 0x5288) ? 2 : 1,
 					0xC0, 0xFF, chip->aspm_l0s_l1_en);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	}
 
 	chip->aspm_enabled = 1;
@@ -327,9 +318,9 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 
 	if (chip->phy_debug_mode) {
 		ret = rtsx_write_register(chip, CDRESUMECTL, 0x77, 0);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
+
 		rtsx_disable_bus_int(chip);
 	} else {
 		rtsx_enable_bus_int(chip);
@@ -339,27 +330,23 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 		u16 reg;
 
 		ret = rtsx_read_phy_register(chip, 0x00, &reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		reg &= 0xFE7F;
 		reg |= 0x80;
 		ret = rtsx_write_phy_register(chip, 0x00, reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		ret = rtsx_read_phy_register(chip, 0x1C, &reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		reg &= 0xFFF7;
 		ret = rtsx_write_phy_register(chip, 0x1C, reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (chip->driver_first_load && (chip->ic_version < IC_VER_C))
@@ -377,100 +364,94 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	rtsx_disable_aspm(chip);
 
 	retval = rtsx_write_register(chip, HOST_SLEEP_STATE, 0x03, 0x00);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	/* Disable card clock */
 	retval = rtsx_write_register(chip, CARD_CLK_EN, 0x1E, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 #ifdef SUPPORT_OCP
 	/* SSC power on, OCD power on */
 	if (CHECK_LUN_MODE(chip, SD_MS_2LUN)) {
 		retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	} else {
 		retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN,
 					     MS_OC_POWER_DOWN);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	}
 
 	retval = rtsx_write_register(chip, OCPPARA1, OCP_TIME_MASK,
 				     OCP_TIME_800);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, OCPPARA2, OCP_THD_MASK,
 				     OCP_THD_244_946);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, OCPCTL, 0xFF,
 				     CARD_OC_INT_EN | CARD_DETECT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 #else
 	/* OC power down */
 	retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN,
 				     OC_POWER_DOWN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 #endif
 
 	if (!CHECK_PID(chip, 0x5288)) {
 		retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0xFF, 0x03);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	}
 
 	/* Turn off LED */
 	retval = rtsx_write_register(chip, CARD_GPIO, 0xFF, 0x03);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 
 	/* Reset delink mode */
 	retval = rtsx_write_register(chip, CHANGE_LINK_STATE, 0x0A, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	/* Card driving select */
 	retval = rtsx_write_register(chip, CARD_DRIVE_SEL, 0xFF,
 				     chip->card_drive_sel);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 #ifdef LED_AUTO_BLINK
 	retval = rtsx_write_register(chip, CARD_AUTO_BLINK, 0xFF,
 				     LED_BLINK_SPEED | BLINK_EN | LED_GPIO0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 #endif
 
 	if (chip->asic_code) {
 		/* Enable SSC Clock */
 		retval = rtsx_write_register(chip, SSC_CTL1, 0xFF,
 					     SSC_8X_EN | SSC_SEL_4M);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, SSC_CTL2, 0xFF, 0x12);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	/*
@@ -482,72 +463,66 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	 *    bit[4]	u_non_sticky_rst_n_dbg	rst_value = 0
 	 */
 	retval = rtsx_write_register(chip, CHANGE_LINK_STATE, 0x16, 0x10);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	/* Enable ASPM */
 	if (chip->aspm_l0s_l1_en) {
 		retval = rtsx_reset_aspm(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	} else {
 		if (chip->asic_code && CHECK_PID(chip, 0x5208)) {
 			retval = rtsx_write_phy_register(chip, 0x07, 0x0129);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
+
 		}
 		retval = rtsx_write_config_byte(chip, LCTLR,
 						chip->aspm_l0s_l1_en);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	}
 
 	retval = rtsx_write_config_byte(chip, 0x81, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_SDIO_EXIST(chip)) {
 		retval = rtsx_write_cfg_dw(chip,
 					   CHECK_PID(chip, 0x5288) ? 2 : 1,
 					   0xC0, 0xFF00, 0x0100);
 
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	}
 
 	if (CHECK_PID(chip, 0x5288) && !CHK_SDIO_EXIST(chip)) {
 		retval = rtsx_write_cfg_dw(chip, 2, 0xC0, 0xFFFF, 0x0103);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = rtsx_write_cfg_dw(chip, 2, 0x84, 0xFF, 0x03);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	}
 
 	retval = rtsx_write_register(chip, IRQSTAT0, LINK_RDY_INT,
 				     LINK_RDY_INT);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = rtsx_write_register(chip, PERST_GLITCH_WIDTH, 0xFF, 0x80);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = rtsx_enable_pcie_intr(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	chip->need_reset = 0;
 
@@ -569,17 +544,15 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 #else  /* HW_AUTO_SWITCH_SD_BUS */
 		retval = rtsx_pre_handle_sdio_old(chip);
 #endif  /* HW_AUTO_SWITCH_SD_BUS */
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 	} else {
 		chip->sd_io = 0;
 		retval = rtsx_write_register(chip, SDIO_CTRL,
 					     SDIO_BUS_CTRL | SDIO_CD_CTRL, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 nextcard:
@@ -590,78 +563,73 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (chip->int_reg & CARD_EXIST) {
 		retval = rtsx_write_register(chip, SSC_CTL1, SSC_RSTB,
 					     SSC_RSTB);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	}
 
 	dev_dbg(rtsx_dev(chip), "In %s, chip->need_reset = 0x%x\n", __func__,
 		(unsigned int)(chip->need_reset));
 
 	retval = rtsx_write_register(chip, RCCTL, 0x01, 0x00);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (CHECK_PID(chip, 0x5208) || CHECK_PID(chip, 0x5288)) {
 		/* Turn off main power when entering S3/S4 state */
 		retval = rtsx_write_register(chip, MAIN_PWR_OFF_CTL, 0x03,
 					     0x03);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	if (chip->remote_wakeup_en && !chip->auto_delink_en) {
 		retval = rtsx_write_register(chip, WAKE_SEL_CTL, 0x07, 0x07);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if (chip->aux_pwr_exist) {
 			retval = rtsx_write_register(chip, PME_FORCE_CTL,
 						     0xFF, 0x33);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	} else {
 		retval = rtsx_write_register(chip, WAKE_SEL_CTL, 0x07, 0x04);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, PME_FORCE_CTL, 0xFF, 0x30);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	}
 
 	if (CHECK_PID(chip, 0x5208) && (chip->ic_version >= IC_VER_D)) {
 		retval = rtsx_write_register(chip, PETXCFG, 0x1C, 0x14);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	}
 
 	if (chip->asic_code && CHECK_PID(chip, 0x5208)) {
 		retval = rtsx_clr_phy_reg_bit(chip, 0x1C, 2);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (chip->ft2_fast_mode) {
 		retval = rtsx_write_register(chip, CARD_PWR_CTL, 0xFF,
 					     MS_PARTIAL_POWER_ON |
 					     SD_PARTIAL_POWER_ON);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		udelay(chip->pmos_pwr_on_interval);
 		retval = rtsx_write_register(chip, CARD_PWR_CTL, 0xFF,
 					     MS_POWER_ON | SD_POWER_ON);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		wait_timeout(200);
 	}
@@ -715,20 +683,20 @@ static int rts5208_init(struct rtsx_chip *chip)
 	u8 val = 0;
 
 	retval = rtsx_write_register(chip, CLK_SEL, 0x03, 0x03);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_read_register(chip, CLK_SEL, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	chip->asic_code = val == 0 ? 1 : 0;
 
 	if (chip->asic_code) {
 		retval = rtsx_read_phy_register(chip, 0x1C, &reg);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 
 		dev_dbg(rtsx_dev(chip), "Value of phy register 0x1C is 0x%x\n",
 			reg);
@@ -737,24 +705,24 @@ static int rts5208_init(struct rtsx_chip *chip)
 
 	} else {
 		retval = rtsx_read_register(chip, 0xFE80, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		chip->ic_version = val;
 		chip->phy_debug_mode = 0;
 	}
 
 	retval = rtsx_read_register(chip, PDINFO, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "PDINFO: 0x%x\n", val);
 	chip->aux_pwr_exist = val & AUX_PWR_DETECTED ? 1 : 0;
 
 	retval = rtsx_read_register(chip, 0xFE50, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	chip->hw_bypass_sd = val & 0x01 ? 1 : 0;
 
 	rtsx_read_config_byte(chip, 0x0E, &val);
@@ -765,9 +733,9 @@ static int rts5208_init(struct rtsx_chip *chip)
 
 	if (chip->use_hw_setting) {
 		retval = rtsx_read_register(chip, CHANGE_LINK_STATE, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		chip->auto_delink_en = val & 0x80 ? 1 : 0;
 	}
 
@@ -781,42 +749,41 @@ static int rts5288_init(struct rtsx_chip *chip)
 	u32 lval = 0;
 
 	retval = rtsx_write_register(chip, CLK_SEL, 0x03, 0x03);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_read_register(chip, CLK_SEL, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	chip->asic_code = val == 0 ? 1 : 0;
 
 	chip->ic_version = 0;
 	chip->phy_debug_mode = 0;
 
 	retval = rtsx_read_register(chip, PDINFO, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "PDINFO: 0x%x\n", val);
 	chip->aux_pwr_exist = val & AUX_PWR_DETECTED ? 1 : 0;
 
 	retval = rtsx_read_register(chip, CARD_SHARE_MODE, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "CARD_SHARE_MODE: 0x%x\n", val);
 	chip->baro_pkg = val & 0x04 ? QFN : LQFP;
 
 	retval = rtsx_read_register(chip, 0xFE5A, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	chip->hw_bypass_sd = val & 0x10 ? 1 : 0;
 
 	retval = rtsx_read_cfg_dw(chip, 0, 0x718, &lval);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	max_func = (u8)((lval >> 29) & 0x07);
 	dev_dbg(rtsx_dev(chip), "Max function number: %d\n", max_func);
@@ -827,9 +794,9 @@ static int rts5288_init(struct rtsx_chip *chip)
 
 	if (chip->use_hw_setting) {
 		retval = rtsx_read_register(chip, CHANGE_LINK_STATE, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		chip->auto_delink_en = val & 0x80 ? 1 : 0;
 
 		if (CHECK_BARO_PKG(chip, LQFP))
@@ -905,28 +872,26 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 		chip->mmc_ddr_tx_phase = 0;
 
 	retval = rtsx_write_register(chip, FPDCTL, SSC_POWER_DOWN, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	wait_timeout(200);
 	retval = rtsx_write_register(chip, CLK_DIV, 0x07, 0x07);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "chip->use_hw_setting = %d\n",
 		chip->use_hw_setting);
 
 	if (CHECK_PID(chip, 0x5208)) {
 		retval = rts5208_init(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 	} else if (CHECK_PID(chip, 0x5288)) {
 		retval = rts5288_init(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (chip->ss_en == 2)
@@ -973,9 +938,8 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 	}
 
 	retval = rtsx_reset_chip(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1403,9 +1367,8 @@ int rtsx_write_register(struct rtsx_chip *chip, u16 addr, u8 mask, u8 data)
 	for (i = 0; i < MAX_RW_REG_CNT; i++) {
 		val = rtsx_readl(chip, RTSX_HAIMR);
 		if ((val & BIT(31)) == 0) {
-			if (data != (u8)val) {
+			if (data != (u8)val)
 				return STATUS_FAIL;
-			}
 
 			return STATUS_SUCCESS;
 		}
@@ -1432,9 +1395,8 @@ int rtsx_read_register(struct rtsx_chip *chip, u16 addr, u8 *data)
 			break;
 	}
 
-	if (i >= MAX_RW_REG_CNT) {
+	if (i >= MAX_RW_REG_CNT)
 		return STATUS_TIMEDOUT;
-	}
 
 	if (data)
 		*data = (u8)(val & 0xFF);
@@ -1454,9 +1416,9 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 mask,
 			retval = rtsx_write_register(chip, CFGDATA0 + i,
 						     0xFF,
 						     (u8)(val & mask & 0xFF));
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			mode |= (1 << i);
 		}
 		mask >>= 8;
@@ -1465,27 +1427,25 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 mask,
 
 	if (mode) {
 		retval = rtsx_write_register(chip, CFGADDR0, 0xFF, (u8)addr);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CFGADDR1, 0xFF,
 					     (u8)(addr >> 8));
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		retval = rtsx_write_register(chip, CFGRWCTL, 0xFF,
 					     0x80 | mode |
 					     ((func_no & 0x03) << 4));
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		for (i = 0; i < MAX_RW_REG_CNT; i++) {
 			retval = rtsx_read_register(chip, CFGRWCTL, &tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			if ((tmp & 0x80) == 0)
 				break;
 		}
@@ -1502,33 +1462,31 @@ int rtsx_read_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 *val)
 	u32 data = 0;
 
 	retval = rtsx_write_register(chip, CFGADDR0, 0xFF, (u8)addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, CFGADDR1, 0xFF, (u8)(addr >> 8));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, CFGRWCTL, 0xFF,
 				     0x80 | ((func_no & 0x03) << 4));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < MAX_RW_REG_CNT; i++) {
 		retval = rtsx_read_register(chip, CFGRWCTL, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if ((tmp & 0x80) == 0)
 			break;
 	}
 
 	for (i = 0; i < 4; i++) {
 		retval = rtsx_read_register(chip, CFGDATA0 + i, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		data |= (u32)tmp << (i * 8);
 	}
 
@@ -1547,9 +1505,8 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	int dw_len, i, j;
 	int retval;
 
-	if (!buf) {
+	if (!buf)
 		return STATUS_NOMEM;
-	}
 
 	if ((len + offset) % 4)
 		dw_len = (len + offset) / 4 + 1;
@@ -1559,9 +1516,8 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	dev_dbg(rtsx_dev(chip), "dw_len = %d\n", dw_len);
 
 	data = vzalloc(array_size(dw_len, 4));
-	if (!data) {
+	if (!data)
 		return STATUS_NOMEM;
-	}
 
 	mask = vzalloc(array_size(dw_len, 4));
 	if (!mask) {
@@ -1617,9 +1573,9 @@ int rtsx_read_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	dev_dbg(rtsx_dev(chip), "dw_len = %d\n", dw_len);
 
 	data = vmalloc(array_size(dw_len, 4));
-	if (!data) {
+	if (!data)
 		return STATUS_NOMEM;
-	}
+
 
 	for (i = 0; i < dw_len; i++) {
 		retval = rtsx_read_cfg_dw(chip, func, aligned_addr + i * 4,
@@ -1655,36 +1611,34 @@ int rtsx_write_phy_register(struct rtsx_chip *chip, u8 addr, u16 val)
 	u8 tmp;
 
 	retval = rtsx_write_register(chip, PHYDATA0, 0xFF, (u8)val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, PHYDATA1, 0xFF, (u8)(val >> 8));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, PHYADDR, 0xFF, addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, PHYRWCTL, 0xFF, 0x81);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < 100000; i++) {
 		retval = rtsx_read_register(chip, PHYRWCTL, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if (!(tmp & 0x80)) {
 			finished = true;
 			break;
 		}
 	}
 
-	if (!finished) {
+	if (!finished)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1698,38 +1652,36 @@ int rtsx_read_phy_register(struct rtsx_chip *chip, u8 addr, u16 *val)
 	u8 tmp;
 
 	retval = rtsx_write_register(chip, PHYADDR, 0xFF, addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, PHYRWCTL, 0xFF, 0x80);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < 100000; i++) {
 		retval = rtsx_read_register(chip, PHYRWCTL, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if (!(tmp & 0x80)) {
 			finished = true;
 			break;
 		}
 	}
 
-	if (!finished) {
+	if (!finished)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_read_register(chip, PHYDATA0, &tmp);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	data = tmp;
 	retval = rtsx_read_register(chip, PHYDATA1, &tmp);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	data |= (u16)tmp << 8;
 
 	if (val)
@@ -1745,28 +1697,27 @@ int rtsx_read_efuse(struct rtsx_chip *chip, u8 addr, u8 *val)
 	u8 data = 0;
 
 	retval = rtsx_write_register(chip, EFUSE_CTRL, 0xFF, 0x80 | addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < 100; i++) {
 		retval = rtsx_read_register(chip, EFUSE_CTRL, &data);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if (!(data & 0x80))
 			break;
 		udelay(1);
 	}
 
-	if (data & 0x80) {
+	if (data & 0x80)
 		return STATUS_TIMEDOUT;
-	}
+
 
 	retval = rtsx_read_register(chip, EFUSE_DATA, &data);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if (val)
 		*val = data;
 
@@ -1787,28 +1738,25 @@ int rtsx_write_efuse(struct rtsx_chip *chip, u8 addr, u8 val)
 		dev_dbg(rtsx_dev(chip), "Write 0x%x to 0x%x\n", tmp, addr);
 
 		retval = rtsx_write_register(chip, EFUSE_DATA, 0xFF, tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, EFUSE_CTRL, 0xFF,
 					     0xA0 | addr);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		for (j = 0; j < 100; j++) {
 			retval = rtsx_read_register(chip, EFUSE_CTRL, &data);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			if (!(data & 0x80))
 				break;
 			wait_timeout(3);
 		}
 
-		if (data & 0x80) {
+		if (data & 0x80)
 			return STATUS_TIMEDOUT;
-		}
 
 		wait_timeout(5);
 	}
@@ -1822,16 +1770,14 @@ int rtsx_clr_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 	u16 value;
 
 	retval = rtsx_read_phy_register(chip, reg, &value);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (value & (1 << bit)) {
 		value &= ~(1 << bit);
 		retval = rtsx_write_phy_register(chip, reg, value);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1843,16 +1789,14 @@ int rtsx_set_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 	u16 value;
 
 	retval = rtsx_read_phy_register(chip, reg, &value);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if ((value & (1 << bit)) == 0) {
 		value |= (1 << bit);
 		retval = rtsx_write_phy_register(chip, reg, value);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2153,9 +2097,8 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 	u16 reg_addr;
 	u8 *ptr;
 
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	ptr = buf;
 	reg_addr = PPBUF_BASE2;
@@ -2166,9 +2109,8 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 			rtsx_add_cmd(chip, READ_REG_CMD, reg_addr++, 0, 0);
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 
 		memcpy(ptr, rtsx_get_cmd_data(chip), 256);
 		ptr += 256;
@@ -2181,9 +2123,8 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 			rtsx_add_cmd(chip, READ_REG_CMD, reg_addr++, 0, 0);
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 	}
 
 	memcpy(ptr, rtsx_get_cmd_data(chip), buf_len % 256);
@@ -2198,9 +2139,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 	u16 reg_addr;
 	u8 *ptr;
 
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	ptr = buf;
 	reg_addr = PPBUF_BASE2;
@@ -2214,9 +2154,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 		}
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (buf_len % 256) {
@@ -2229,9 +2168,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 		}
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2239,9 +2177,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 
 int rtsx_check_chip_exist(struct rtsx_chip *chip)
 {
-	if (rtsx_readl(chip, 0) == 0xFFFFFFFF) {
+	if (rtsx_readl(chip, 0) == 0xFFFFFFFF)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2264,9 +2201,8 @@ int rtsx_force_power_on(struct rtsx_chip *chip, u8 ctl)
 
 	if (mask) {
 		retval = rtsx_write_register(chip, FPDCTL, mask, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (CHECK_PID(chip, 0x5288))
 			wait_timeout(200);
@@ -2294,9 +2230,8 @@ int rtsx_force_power_down(struct rtsx_chip *chip, u8 ctl)
 	if (mask) {
 		val = mask;
 		retval = rtsx_write_register(chip, FPDCTL, mask, val);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
-- 
2.17.1

