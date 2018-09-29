Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CD2C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B22084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5d7BqJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724B22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeI2M0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:26:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43973 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbeI2M0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:26:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so4201466qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:signed-off-by;
        bh=C0hgObMFnCyQK7HydCkKIR2KzDRWKuLSsj/vzL7EcXA=;
        b=O5d7BqJCgLrjwZgR0XBQEa6EQvZ9OcCWmBmUy5cqxNdIe4C7DhKqzaiEtgDZzzq/5X
         Mf+3i3ArKj2EX1mfP3PrOnlHR7sf5ZkhPnif2Pv0KI+Jw5Hgm6oKSZFH/A7/sJQGqSQ+
         AVIZUwFGeoaJ/sMRfN2O87YLWbfUqWfpK+LZqHjOyMUX7/tTbpYKtPXUJEt1KlybeCQB
         w6+17I/foymP1PSXzkiFExjWJ27qWYFQ9mbDNNQw8NdfWxI9a8+pAoC4bW/ktkk/dbOo
         voRpY0pXtGerRE6TXn5+QjFHvqkfRHL/ti1BggBn8gnlZQdh1j2my24AfoTQjiGI33L9
         allw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:signed-off-by;
        bh=C0hgObMFnCyQK7HydCkKIR2KzDRWKuLSsj/vzL7EcXA=;
        b=qtLoPCjKP0iUTq+ORHZvZf20EJmIkD3Kv8t7QdBDfOWtiUGRbSX319IdR+KYnAwV8t
         4sxOpT352ww3hRPXaEWuop32i2Rn0W3K0bGbpKrdiYAku7ToWLzncKUJHHaIjKBMonjK
         6dhjersI3GhXU/sLNrT+sE3ERPxYijA9/G/LbmJqUIuteJOfqsDMYEUlJGGrf8fRRF9x
         Ol1YXtyyd/QZTKDSfKWAN9BQueUb33UNTMiUoeggQUNMPT0KiPV4L66fzJjgZLUurtU+
         6SGx2mQs3g8i+Cn6/QtvRCGpv810EzUHMdZ762W0V4v6TPeuHatuVPZRVkE/Tl9hbWE2
         aEBQ==
X-Gm-Message-State: ABuFfog0LQzRgH4D1wCXpkQczI9RJq4fAOb+oERoZlFOJLTYZ13fzaAL
        UYlG7X96WrK/QCU3CvorXDI=
X-Google-Smtp-Source: ACcGV63cYH1ApkMmdqzQCCUoPzYwS6i0w5jCPr9gOyxl+yW5ZCC8+MT+M5vQc3GQmYWHD7eD80yM5Q==
X-Received: by 2002:ac8:3414:: with SMTP id u20-v6mr1407209qtb.237.1538200743067;
        Fri, 28 Sep 2018 22:59:03 -0700 (PDT)
Received: from localhost.localdomain (modemcable211.182-179-173.mc.videotron.ca. [173.179.182.211])
        by smtp.gmail.com with ESMTPSA id e17-v6sm3100356qtr.32.2018.09.28.22.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 22:59:02 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH 4/4] Staging: rts5208: sd: Fixed multiple coding style issues Fixed multiple braces issues 
Date:   Sat, 29 Sep 2018 01:58:50 -0400
Message-Id: <20180929055850.25615-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/staging/rts5208/sd.c | 704 +++++++++++++----------------------
 1 file changed, 268 insertions(+), 436 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index e7efa34195c7..930c61ccb047 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -109,9 +109,8 @@ static int sd_check_data0_status(struct rtsx_chip *chip)
 	u8 stat;
 
 	retval = rtsx_read_register(chip, REG_SD_STAT1, &stat);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (!(stat & SD_DAT0_STATUS)) {
 		sd_set_err_code(chip, SD_BUSY);
@@ -234,9 +233,8 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 		if ((cmd_idx != SEND_RELATIVE_ADDR) &&
 		    (cmd_idx != SEND_IF_COND)) {
 			if (cmd_idx != STOP_TRANSMISSION) {
-				if (ptr[1] & 0x80) {
+				if (ptr[1] & 0x80)
 					return STATUS_FAIL;
-				}
 			}
 #ifdef SUPPORT_SD_LOCK
 			if (ptr[1] & 0x7D) {
@@ -284,9 +282,8 @@ static int sd_read_data(struct rtsx_chip *chip,
 	if (!buf)
 		buf_len = 0;
 
-	if (buf_len > 512) {
+	if (buf_len > 512)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -331,9 +328,8 @@ static int sd_read_data(struct rtsx_chip *chip,
 
 	if (buf && buf_len) {
 		retval = rtsx_read_ppbuf(chip, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -359,9 +355,8 @@ static int sd_write_data(struct rtsx_chip *chip, u8 trans_mode,
 
 	if (buf && buf_len) {
 		retval = rtsx_write_ppbuf(chip, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	rtsx_init_cmd(chip);
@@ -426,9 +421,8 @@ static int sd_check_csd(struct rtsx_chip *chip, char check_wp)
 			break;
 	}
 
-	if (i == 6) {
+	if (i == 6)
 		return STATUS_FAIL;
-	}
 
 	memcpy(sd_card->raw_csd, rsp + 1, 15);
 
@@ -543,9 +537,8 @@ static int sd_set_sample_push_timing(struct rtsx_chip *chip)
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x1C, val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -606,9 +599,8 @@ static int sd_set_clock_divider(struct rtsx_chip *chip, u8 clk_div)
 		val = 0x20;
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, mask, val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -619,16 +611,14 @@ static int sd_set_init_para(struct rtsx_chip *chip)
 	int retval;
 
 	retval = sd_set_sample_push_timing(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	sd_choose_proper_clock(chip);
 
 	retval = switch_clock(chip, sd_card->sd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -651,9 +641,8 @@ int sd_select_card(struct rtsx_chip *chip, int select)
 	}
 
 	retval = sd_send_cmd_get_rsp(chip, cmd_idx, addr, cmd_type, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -667,9 +656,8 @@ static int sd_update_lock_status(struct rtsx_chip *chip)
 
 	retval = sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, rsp, 5);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (rsp[1] & 0x02)
 		sd_card->sd_lock_status |= SD_LOCKED;
@@ -679,9 +667,8 @@ static int sd_update_lock_status(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "sd_card->sd_lock_status = 0x%x\n",
 		sd_card->sd_lock_status);
 
-	if (rsp[1] & 0x01) {
+	if (rsp[1] & 0x01)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -698,9 +685,8 @@ static int sd_wait_state_data_ready(struct rtsx_chip *chip, u8 state,
 		retval = sd_send_cmd_get_rsp(chip, SEND_STATUS,
 					     sd_card->sd_addr, SD_RSP_TYPE_R1,
 					     rsp, 5);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (((rsp[3] & 0x1E) == state) &&
 		    ((rsp[3] & 0x01) == data_ready))
@@ -719,31 +705,28 @@ static int sd_change_bank_voltage(struct rtsx_chip *chip, u8 voltage)
 			retval = rtsx_write_phy_register(chip, 0x08,
 							 0x4FC0 |
 							 chip->phy_voltage);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
+
 		} else {
 			retval = rtsx_write_register(chip, SD_PAD_CTL,
 						     SD_IO_USING_1V8, 0);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	} else if (voltage == SD_IO_1V8) {
 		if (chip->asic_code) {
 			retval = rtsx_write_phy_register(chip, 0x08,
 							 0x4C40 |
 							 chip->phy_voltage);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		} else {
 			retval = rtsx_write_register(chip, SD_PAD_CTL,
 						     SD_IO_USING_1V8,
 						     SD_IO_USING_1V8);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	} else {
 		return STATUS_FAIL;
@@ -760,22 +743,20 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SD_BUS_STAT,
 				     SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP,
 				     SD_CLK_TOGGLE_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = sd_send_cmd_get_rsp(chip, VOLTAGE_SWITCH, 0, SD_RSP_TYPE_R1,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	udelay(chip->sd_voltage_switch_delay);
 
 	retval = rtsx_read_register(chip, SD_BUS_STAT, &stat);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if (stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
 				SD_DAT1_STATUS | SD_DAT0_STATUS)) {
 		return STATUS_FAIL;
@@ -783,27 +764,26 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT, 0xFF,
 				     SD_CLK_FORCE_STOP);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = sd_change_bank_voltage(chip, SD_IO_1V8);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	wait_timeout(50);
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT, 0xFF,
 				     SD_CLK_TOGGLE_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	wait_timeout(10);
 
 	retval = rtsx_read_register(chip, SD_BUS_STAT, &stat);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if ((stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
 				SD_DAT1_STATUS | SD_DAT0_STATUS)) !=
 			(SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
@@ -817,9 +797,8 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT,
 				     SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -831,23 +810,23 @@ static int sd_reset_dcm(struct rtsx_chip *chip, u8 tune_dir)
 	if (tune_dir == TUNE_RX) {
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF,
 					     DCM_RESET | DCM_RX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF, DCM_RX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	} else {
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF,
 					     DCM_RESET | DCM_TX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF, DCM_TX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	}
 
 	return STATUS_SUCCESS;
@@ -877,28 +856,28 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 	if (chip->asic_code) {
 		retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK,
 					     CHANGE_CLK);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, SD_VP_CTL, 0x1F,
 					     sample_point);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	} else {
 		rtsx_read_register(chip, SD_VP_CTL, &val);
 		dev_dbg(rtsx_dev(chip), "SD_VP_CTL: 0x%x\n", val);
@@ -909,30 +888,30 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 			retval = rtsx_write_register(chip, SD_VP_CTL,
 						     PHASE_CHANGE,
 						     PHASE_CHANGE);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			udelay(50);
 			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
 						     PHASE_CHANGE |
 						     PHASE_NOT_RESET |
 						     sample_point);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 		} else {
 			retval = rtsx_write_register(chip, CLK_CTL,
 						     CHANGE_CLK, CHANGE_CLK);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			udelay(50);
 			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
 						     PHASE_NOT_RESET |
 						     sample_point);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 		}
 		udelay(100);
 
@@ -942,45 +921,41 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 		rtsx_add_cmd(chip, CHECK_REG_CMD, SD_DCMPS_CTL,
 			     DCMPS_CHANGE_DONE, DCMPS_CHANGE_DONE);
 		retval = rtsx_send_cmd(chip, SD_CARD, 100);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto fail;
-		}
 
 		val = *rtsx_get_cmd_data(chip);
-		if (val & DCMPS_ERROR) {
+		if (val & DCMPS_ERROR)
 			goto fail;
-		}
 
-		if ((val & DCMPS_CURRENT_PHASE) != sample_point) {
+		if ((val & DCMPS_CURRENT_PHASE) != sample_point)
 			goto fail;
-		}
+
 
 		retval = rtsx_write_register(chip, SD_DCMPS_CTL,
 					     DCMPS_CHANGE, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if (ddr_rx) {
 			retval = rtsx_write_register(chip, SD_VP_CTL,
 						     PHASE_CHANGE, 0);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 		} else {
 			retval = rtsx_write_register(chip, CLK_CTL,
 						     CHANGE_CLK, 0);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 
 		udelay(50);
 	}
 
 	retval = rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 
@@ -1005,9 +980,8 @@ static int sd_check_spec(struct rtsx_chip *chip, u8 bus_width)
 
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SEND_SCR;
 	cmd[1] = 0;
@@ -1024,9 +998,8 @@ static int sd_check_spec(struct rtsx_chip *chip, u8 bus_width)
 
 	memcpy(sd_card->raw_scr, buf, 8);
 
-	if ((buf[0] & 0x0F) == 0) {
+	if ((buf[0] & 0x0F) == 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1207,29 +1180,26 @@ static int sd_check_switch_mode(struct rtsx_chip *chip, u8 mode, u8 func_group,
 
 		dev_dbg(rtsx_dev(chip), "Maximum current consumption: %dmA\n",
 			cc);
-		if ((cc == 0) || (cc > 800)) {
+		if ((cc == 0) || (cc > 800))
 			return STATUS_FAIL;
-		}
 
 		retval = sd_query_switch_result(chip, func_group,
 						func_to_switch, buf, 64);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if ((cc > 400) || (func_to_switch > CURRENT_LIMIT_400)) {
 			retval = rtsx_write_register(chip, OCPPARA2,
 						     SD_OCP_THD_MASK,
 						     chip->sd_800mA_ocp_thd);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PWR_CTL,
 						     PMOS_STRG_MASK,
 						     PMOS_STRG_800mA);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	}
 
@@ -1278,9 +1248,9 @@ static int sd_check_switch(struct rtsx_chip *chip,
 			}
 
 			retval = rtsx_read_register(chip, SD_STAT1, &stat);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			if (stat & SD_CRC16_ERR) {
 				dev_dbg(rtsx_dev(chip), "SD CRC16 error when switching mode\n");
 				return STATUS_FAIL;
@@ -1293,9 +1263,8 @@ static int sd_check_switch(struct rtsx_chip *chip,
 		wait_timeout(20);
 	}
 
-	if (!switch_good) {
+	if (!switch_good)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1310,9 +1279,8 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 	/* Get supported functions */
 	retval = sd_check_switch_mode(chip, SD_CHECK_MODE, NO_ARGUMENT,
 				      NO_ARGUMENT, bus_width);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	sd_card->func_group1_mask &= ~(sd_card->sd_switch_fail);
 
@@ -1394,13 +1362,13 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 	if (CHK_SD_DDR50(sd_card)) {
 		retval = rtsx_write_register(chip, SD_PUSH_POINT_CTL, 0x06,
 					     0x04);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = sd_set_sample_push_timing(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	}
 
 	if (!func_to_switch || (func_to_switch == HS_SUPPORT)) {
@@ -1454,9 +1422,9 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 		retval = sd_check_switch(chip, SD_FUNC_GROUP_4, func_to_switch,
 					 bus_width);
 		if (retval != STATUS_SUCCESS) {
-			if (sd_check_err_code(chip, SD_NO_CARD)) {
+			if (sd_check_err_code(chip, SD_NO_CARD))
 				return STATUS_FAIL;
-			}
+
 		}
 		dev_dbg(rtsx_dev(chip), "Switch current limit finished! (%d)\n",
 			retval);
@@ -1464,9 +1432,8 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 
 	if (CHK_SD_DDR50(sd_card)) {
 		retval = rtsx_write_register(chip, SD_PUSH_POINT_CTL, 0x06, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1480,9 +1447,9 @@ static int sd_wait_data_idle(struct rtsx_chip *chip)
 
 	for (i = 0; i < 100; i++) {
 		retval = rtsx_read_register(chip, SD_DATA_STATE, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if (val & SD_DATA_IDLE) {
 			retval = STATUS_SUCCESS;
 			break;
@@ -1500,9 +1467,8 @@ static int sd_sdr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	u8 cmd[5];
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SEND_TUNING_PATTERN;
 	cmd[1] = 0;
@@ -1529,17 +1495,15 @@ static int sd_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	u8 cmd[5];
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "sd ddr tuning rx\n");
 
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SD_STATUS;
 	cmd[1] = 0;
@@ -1573,9 +1537,8 @@ static int mmc_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 		bus_width = SD_BUS_WIDTH_1;
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "mmc ddr tuning rx\n");
 
@@ -1603,15 +1566,13 @@ static int sd_sdr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	int retval;
 
 	retval = sd_change_phase(chip, sample_point, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
@@ -1625,9 +1586,8 @@ static int sd_sdr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1639,9 +1599,8 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	u8 cmd[5], bus_width;
 
 	retval = sd_change_phase(chip, sample_point, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_SD(sd_card)) {
 		bus_width = SD_BUS_WIDTH_4;
@@ -1655,15 +1614,13 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	}
 
 	retval = sd_wait_state_data_ready(chip, 0x08, 1, 1000);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	cmd[0] = 0x40 | PROGRAM_CSD;
 	cmd[1] = 0;
@@ -1681,9 +1638,8 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr, SD_RSP_TYPE_R1,
 			    NULL, 0);
@@ -1826,11 +1782,10 @@ static int sd_tuning_rx(struct rtsx_chip *chip)
 			tuning_cmd = sd_sdr_tuning_rx_cmd;
 
 	} else {
-		if (CHK_MMC_DDR52(sd_card)) {
+		if (CHK_MMC_DDR52(sd_card))
 			tuning_cmd = mmc_ddr_tuning_rx_cmd;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 	}
 
 	for (i = 0; i < 3; i++) {
@@ -1855,14 +1810,12 @@ static int sd_tuning_rx(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "RX phase_map = 0x%08x\n", phase_map);
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_RX);
-	if (final_phase == 0xFF) {
+	if (final_phase == 0xFF)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1877,9 +1830,8 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	phase_map = 0;
 	for (i = MAX_PHASE; i >= 0; i--) {
@@ -1904,22 +1856,19 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	dev_dbg(rtsx_dev(chip), "DDR TX pre tune phase_map = 0x%08x\n",
 		phase_map);
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_TX);
-	if (final_phase == 0xFF) {
+	if (final_phase == 0xFF)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "DDR TX pre tune phase: %d\n",
 		(int)final_phase);
@@ -1943,11 +1892,10 @@ static int sd_tuning_tx(struct rtsx_chip *chip)
 			tuning_cmd = sd_sdr_tuning_tx_cmd;
 
 	} else {
-		if (CHK_MMC_DDR52(sd_card)) {
+		if (CHK_MMC_DDR52(sd_card))
 			tuning_cmd = sd_ddr_tuning_tx_cmd;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 	}
 
 	for (i = 0; i < 3; i++) {
@@ -1974,14 +1922,12 @@ static int sd_tuning_tx(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "TX phase_map = 0x%08x\n", phase_map);
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_TX);
-	if (final_phase == 0xFF) {
+	if (final_phase == 0xFF)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1991,14 +1937,12 @@ static int sd_sdr_tuning(struct rtsx_chip *chip)
 	int retval;
 
 	retval = sd_tuning_tx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_tuning_rx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2009,27 +1953,25 @@ static int sd_ddr_tuning(struct rtsx_chip *chip)
 
 	if (!(chip->sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_ddr_pre_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	} else {
 		retval = sd_change_phase(chip, (u8)chip->sd_ddr_tx_phase,
 					 TUNE_TX);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	retval = sd_tuning_rx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!(chip->sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	}
 
 	return STATUS_SUCCESS;
@@ -2041,27 +1983,23 @@ static int mmc_ddr_tuning(struct rtsx_chip *chip)
 
 	if (!(chip->sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_ddr_pre_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = sd_change_phase(chip, (u8)chip->mmc_ddr_tx_phase,
 					 TUNE_TX);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	retval = sd_tuning_rx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!(chip->sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2074,14 +2012,12 @@ int sd_switch_clock(struct rtsx_chip *chip)
 	int re_tuning = 0;
 
 	retval = select_card(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = switch_clock(chip, sd_card->sd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (re_tuning) {
 		if (CHK_SD(sd_card)) {
@@ -2094,9 +2030,8 @@ int sd_switch_clock(struct rtsx_chip *chip)
 				retval = mmc_ddr_tuning(chip);
 		}
 
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2126,25 +2061,21 @@ static int sd_prepare_reset(struct rtsx_chip *chip)
 	chip->sd_io = 0;
 
 	retval = sd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return retval;
-	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0xFF, 0x40);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = rtsx_write_register(chip, CARD_STOP, SD_STOP | SD_CLR_ERR,
 				     SD_STOP | SD_CLR_ERR);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = select_card(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2157,60 +2088,59 @@ static int sd_pull_ctl_disable(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, CARD_PULL_CTL1, 0xFF,
 					     XD_D3_PD | SD_D7_PD | SD_CLK_PD |
 					     SD_D5_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
 					     SD_D6_PD | SD_D0_PD | SD_D1_PD |
 					     XD_D5_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
 					     SD_D4_PD | XD_CE_PD | XD_CLE_PD |
 					     XD_CD_PU);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
 					     XD_RDY_PD | SD_D3_PD | SD_D2_PD |
 					     XD_ALE_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
 					     MS_INS_PU | SD_WP_PD | SD_CD_PU |
 					     SD_CMD_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	} else if (CHECK_PID(chip, 0x5288)) {
 		if (CHECK_BARO_PKG(chip, QFN)) {
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	}
 
@@ -2250,9 +2180,8 @@ int sd_pull_ctl_enable(struct rtsx_chip *chip)
 	}
 
 	retval = rtsx_send_cmd(chip, SD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2262,36 +2191,32 @@ static int sd_init_power(struct rtsx_chip *chip)
 	int retval;
 
 	retval = sd_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!chip->ft2_fast_mode)
 		wait_timeout(250);
 
 	retval = enable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->asic_code) {
 		retval = sd_pull_ctl_enable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_SD_PULL_CTL_BIT | 0x20, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_on(chip, SD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		wait_timeout(260);
 
@@ -2306,9 +2231,8 @@ static int sd_init_power(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, CARD_OE, SD_OUTPUT_EN,
 				     SD_OUTPUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2318,14 +2242,13 @@ static int sd_dummy_clock(struct rtsx_chip *chip)
 	int retval;
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	wait_timeout(5);
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x01, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2373,9 +2296,8 @@ static int sd_check_wp_state(struct rtsx_chip *chip)
 
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SD_STATUS;
 	cmd[1] = 0;
@@ -2689,9 +2611,8 @@ static int reset_sd(struct rtsx_chip *chip)
 
 		retval = rtsx_write_register(chip, SD30_DRIVE_SEL, 0x07,
 					     chip->sd30_drive_sel_1v8);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		retval = sd_set_init_para(chip);
 		if (retval != STATUS_SUCCESS)
@@ -2753,14 +2674,13 @@ static int reset_sd(struct rtsx_chip *chip)
 	if (sd_card->sd_lock_status & SD_UNLOCK_POW_ON) {
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_H, 0xFF,
 					     0x02);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_L, 0xFF,
 					     0x00);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 #endif
 
@@ -2780,9 +2700,8 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 
 	retval = sd_send_cmd_get_rsp(chip, BUSTEST_W, 0, SD_RSP_TYPE_R1, NULL,
 				     0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return SWITCH_FAIL;
-	}
 
 	if (width == MMC_8BIT_BUS) {
 		buf[0] = 0x55;
@@ -2798,9 +2717,8 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x02, 0x02);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return SWITCH_ERR;
-	}
 
 	retval = sd_write_data(chip, SD_TM_AUTO_WRITE_3, NULL, 0, byte_cnt, 1,
 			       bus_width, buf, len, 100);
@@ -2811,9 +2729,8 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x02, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return SWITCH_ERR;
-	}
 
 	dev_dbg(rtsx_dev(chip), "SD/MMC CMD %d\n", BUSTEST_R);
 
@@ -2979,9 +2896,8 @@ static int mmc_switch_timing_bus(struct rtsx_chip *chip, bool switch_ddr)
 
 	sd_choose_proper_clock(chip);
 	retval = switch_clock(chip, sd_card->sd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	/* Test Bus Procedure */
 	retval = mmc_test_switch_bus(chip, MMC_8BIT_BUS);
@@ -3028,18 +2944,16 @@ static int reset_mmc(struct rtsx_chip *chip)
 
 switch_fail:
 	retval = sd_prepare_reset(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return retval;
-	}
 
 	SET_MMC(sd_card);
 
 RTY_MMC_RST:
 	retval = sd_send_cmd_get_rsp(chip, GO_IDLE_STATE, 0, SD_RSP_TYPE_R0,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	do {
 		if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
@@ -3075,9 +2989,8 @@ static int reset_mmc(struct rtsx_chip *chip)
 		i++;
 	} while (!(rsp[1] & 0x80) && (i < 255));
 
-	if (i == 255) {
+	if (i == 255)
 		return STATUS_FAIL;
-	}
 
 	if ((rsp[1] & 0x60) == 0x40)
 		SET_MMC_SECTOR_MODE(sd_card);
@@ -3086,47 +2999,40 @@ static int reset_mmc(struct rtsx_chip *chip)
 
 	retval = sd_send_cmd_get_rsp(chip, ALL_SEND_CID, 0, SD_RSP_TYPE_R2,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	sd_card->sd_addr = 0x00100000;
 	retval = sd_send_cmd_get_rsp(chip, SET_RELATIVE_ADDR, sd_card->sd_addr,
 				     SD_RSP_TYPE_R6, rsp, 5);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_check_csd(chip, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	spec_ver = (sd_card->raw_csd[0] & 0x3C) >> 2;
 
 	retval = sd_select_card(chip, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200, SD_RSP_TYPE_R1,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 MMC_UNLOCK_ENTRY:
 	retval = sd_update_lock_status(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 #endif
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	chip->card_bus_width[chip->card2lun[SD_CARD]] = 1;
 
@@ -3136,30 +3042,27 @@ static int reset_mmc(struct rtsx_chip *chip)
 			retval = mmc_switch_timing_bus(chip, switch_ddr);
 			if (retval != STATUS_SUCCESS) {
 				retval = sd_init_power(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
+
 				sd_card->mmc_dont_switch_bus = 1;
 				goto switch_fail;
 			}
 		}
 
-		if (CHK_MMC_SECTOR_MODE(sd_card) && (sd_card->capacity == 0)) {
+		if (CHK_MMC_SECTOR_MODE(sd_card) && (sd_card->capacity == 0))
 			return STATUS_FAIL;
-		}
 
 		if (switch_ddr && CHK_MMC_DDR52(sd_card)) {
 			retval = sd_set_init_para(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			retval = mmc_ddr_tuning(chip);
 			if (retval != STATUS_SUCCESS) {
 				retval = sd_init_power(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 
 				switch_ddr = false;
 				goto switch_fail;
@@ -3170,9 +3073,8 @@ static int reset_mmc(struct rtsx_chip *chip)
 				retval = sd_read_lba0(chip);
 				if (retval != STATUS_SUCCESS) {
 					retval = sd_init_power(chip);
-					if (retval != STATUS_SUCCESS) {
+					if (retval != STATUS_SUCCESS)
 						return STATUS_FAIL;
-					}
 
 					switch_ddr = false;
 					goto switch_fail;
@@ -3185,14 +3087,13 @@ static int reset_mmc(struct rtsx_chip *chip)
 	if (sd_card->sd_lock_status & SD_UNLOCK_POW_ON) {
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_H, 0xFF,
 					     0x02);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_L, 0xFF,
 					     0x00);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 #endif
 
@@ -3214,88 +3115,78 @@ int reset_sd_card(struct rtsx_chip *chip)
 	chip->capacity[chip->card2lun[SD_CARD]] = 0;
 
 	retval = enable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->ignore_sd && CHK_SDIO_EXIST(chip) &&
 	    !CHK_SDIO_IGNORED(chip)) {
 		if (chip->asic_code) {
 			retval = sd_pull_ctl_enable(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
+
 		} else {
 			retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 						     FPGA_SD_PULL_CTL_BIT |
 						     0x20, 0);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
+
 		}
 		retval = card_share_mode(chip, SD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		chip->sd_io = 1;
 		return STATUS_FAIL;
 	}
 
 	retval = sd_init_power(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->sd_ctl & RESET_MMC_FIRST) {
 		retval = reset_mmc(chip);
 		if (retval != STATUS_SUCCESS) {
-			if (sd_check_err_code(chip, SD_NO_CARD)) {
+			if (sd_check_err_code(chip, SD_NO_CARD))
 				return STATUS_FAIL;
-			}
 
 			retval = reset_sd(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		}
 	} else {
 		retval = reset_sd(chip);
 		if (retval != STATUS_SUCCESS) {
-			if (sd_check_err_code(chip, SD_NO_CARD)) {
+			if (sd_check_err_code(chip, SD_NO_CARD))
 				return STATUS_FAIL;
-			}
 
-			if (chip->sd_io) {
+			if (chip->sd_io)
 				return STATUS_FAIL;
-			}
+
 			retval = reset_mmc(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		}
 	}
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_L, 0xFF, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_H, 0xFF, 2);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity;
 
 	retval = sd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "sd_card->sd_type = 0x%x\n", sd_card->sd_type);
 
@@ -3321,40 +3212,34 @@ static int reset_mmc_only(struct rtsx_chip *chip)
 	chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity = 0;
 
 	retval = enable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_init_power(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = reset_mmc(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_L, 0xFF, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_H, 0xFF, 2);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity;
 
 	retval = sd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "In %s, sd_card->sd_type = 0x%x\n",
 		__func__, sd_card->sd_type);
@@ -3380,9 +3265,8 @@ static int wait_data_buf_ready(struct rtsx_chip *chip)
 		retval = sd_send_cmd_get_rsp(chip, SEND_STATUS,
 					     sd_card->sd_addr, SD_RSP_TYPE_R1,
 					     NULL, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (sd_card->sd_data_buf_ready) {
 			return sd_send_cmd_get_rsp(chip, SEND_STATUS,
@@ -3460,9 +3344,8 @@ static inline int sd_auto_tune_clock(struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -3819,9 +3702,8 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 
 			if (rsp_type & SD_WAIT_BUSY_END) {
 				retval = sd_check_data0_status(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return retval;
-				}
 			} else {
 				sd_set_err_code(chip, SD_TO_ERR);
 			}
@@ -3859,26 +3741,22 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 	if ((cmd_idx == SELECT_CARD) || (cmd_idx == APP_CMD) ||
 	    (cmd_idx == SEND_STATUS) || (cmd_idx == STOP_TRANSMISSION)) {
 		if ((cmd_idx != STOP_TRANSMISSION) && !special_check) {
-			if (ptr[1] & 0x80) {
+			if (ptr[1] & 0x80)
 				return STATUS_FAIL;
-			}
 		}
 #ifdef SUPPORT_SD_LOCK
 		if (ptr[1] & 0x7D) {
 #else
-		if (ptr[1] & 0x7F) {
-#endif
-			return STATUS_FAIL;
-		}
-		if (ptr[2] & 0xF8) {
+		if (ptr[1] & 0x7F)
+#endif			return STATUS_FAIL;
+
+		if (ptr[2] & 0xF8)
 			return STATUS_FAIL;
-		}
 
 		if (cmd_idx == SELECT_CARD) {
 			if (rsp_type == SD_RSP_TYPE_R2) {
-				if ((ptr[3] & 0x1E) != 0x04) {
+				if ((ptr[3] & 0x1E) != 0x04)
 					return STATUS_FAIL;
-				}
 			}
 		}
 	}
@@ -3915,9 +3793,8 @@ int ext_sd_get_rsp(struct rtsx_chip *chip, int len, u8 *rsp, u8 rsp_type)
 	rtsx_add_cmd(chip, READ_REG_CMD, REG_SD_CMD5, 0xFF, 0);
 
 	retval = rtsx_send_cmd(chip, SD_CARD, 100);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (rsp) {
 		int min_len = (rsp_len < len) ? rsp_len : len;
@@ -4057,9 +3934,8 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 	if (sd_card->pre_cmd_err) {
 		sd_card->pre_cmd_err = 0;
@@ -4085,39 +3961,34 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if ((sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) == 0) {
 		if (CHK_MMC_8BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_8);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else if (CHK_SD(sd_card) || CHK_MMC_4BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_4);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 		}
 	}
 #else
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03, SD_BUS_WIDTH_4);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 #endif
 
 	if (standby) {
 		retval = sd_select_card(chip, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_cmd_failed;
-		}
 	}
 
 	if (acmd) {
@@ -4125,29 +3996,25 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 sd_card->sd_addr,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_cmd_failed;
-		}
 	}
 
 	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
 					 sd_card->rsp, rsp_len, false);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_cmd_failed;
-	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_cmd_failed;
-		}
 	}
 
 #ifdef SUPPORT_SD_LOCK
 	retval = sd_update_lock_status(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_cmd_failed;
-	}
 #endif
 
 	scsi_set_resid(srb, 0);
@@ -4186,9 +4053,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 	cmd_idx = srb->cmnd[2] & 0x3F;
 	if (srb->cmnd[1] & 0x04)
@@ -4211,9 +4077,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if ((sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) == 0) {
@@ -4235,16 +4100,14 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, data_len,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (acmd) {
@@ -4252,9 +4115,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 sd_card->sd_addr,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (data_len <= 512) {
@@ -4273,9 +4135,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		cmd[4] = srb->cmnd[6];
 
 		buf = kmalloc(data_len, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return TRANSPORT_ERROR;
-		}
 
 		retval = sd_read_data(chip, SD_TM_NORMAL_READ, cmd, 5, byte_cnt,
 				      blk_cnt, bus_width, buf, data_len, 2000);
@@ -4340,43 +4201,37 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = ext_sd_get_rsp(chip, rsp_len, sd_card->rsp, rsp_type);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_read_cmd_failed;
-	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (send_cmd12) {
 		retval = ext_sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION, 0,
 						 SD_RSP_TYPE_R1b, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (data_len < 512) {
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if ((srb->cmnd[1] & 0x02) || (srb->cmnd[1] & 0x04))
@@ -4390,9 +4245,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_read_cmd_failed;
-	}
 
 	scsi_set_resid(srb, 0);
 	return TRANSPORT_GOOD;
@@ -4438,9 +4292,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 	cmd_idx = srb->cmnd[2] & 0x3F;
 	if (srb->cmnd[1] & 0x04)
@@ -4472,48 +4325,42 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if ((sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) == 0) {
 		if (CHK_MMC_8BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_8);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else if (CHK_SD(sd_card) || CHK_MMC_4BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_4);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 		}
 	}
 #else
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03, SD_BUS_WIDTH_4);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 #endif
 
 	if (data_len < 512) {
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, data_len,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (acmd) {
@@ -4521,25 +4368,22 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 sd_card->sd_addr,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
 					 sd_card->rsp, rsp_len, false);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_write_cmd_failed;
-	}
 
 	if (data_len <= 512) {
 		u16 i;
 		u8 *buf;
 
 		buf = kmalloc(data_len, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return TRANSPORT_ERROR;
-		}
 
 		rtsx_stor_get_xfer_buf(buf, data_len, srb);
 
@@ -4663,37 +4507,32 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (send_cmd12) {
 		retval = ext_sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION, 0,
 						 SD_RSP_TYPE_R1b, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (data_len < 512) {
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if ((srb->cmnd[1] & 0x02) || (srb->cmnd[1] & 0x04))
@@ -4707,9 +4546,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_write_cmd_failed;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if (cmd_idx == LOCK_UNLOCK) {
@@ -4888,36 +4726,31 @@ int sd_power_off_card3v3(struct rtsx_chip *chip)
 	int retval;
 
 	retval = disable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_OE, SD_OUTPUT_EN, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, SD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		mdelay(50);
 	}
 
 	if (chip->asic_code) {
 		retval = sd_pull_ctl_disable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_SD_PULL_CTL_BIT | 0x20,
 					     FPGA_SD_PULL_CTL_BIT);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -4944,9 +4777,8 @@ int release_sd_card(struct rtsx_chip *chip)
 	memset(sd_card->raw_scr, 0, 8);
 
 	retval = sd_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
-- 
2.17.1

