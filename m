Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6CC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C6E2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBXDcRrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBJUhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:37:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38682 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfBJUhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:37:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so13061783wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 12:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsc7sT2oAgde6LqGy3t3st5opYIOWy/LQC1wcatRq98=;
        b=iBXDcRrrV4DVZQNAyYwit+dC1A5uce18FzvmMmFeD3K/RGRp/oHheleOi7uAPoj0/K
         XO7/4pMeRep6bUk55BofC+P7GmIWEZtJQLsI5FzeWa09qi8kKKkAUbObv2zW6qMjBGk3
         e3izTKA6zwCahDAmmEgGP6k1CdYWwsxqc+x4ubluO6dku/NB02pq1aeCZqjR6wS8sDTE
         HDdU9MUERiXTx/Yrl+1NcbytauJAB7ssDD8pt6VX8OGwDV77YF+6E1JhSZudh8hMI4oD
         XscNJBt+/AIF3nt/5WdOd+flIe2UO0ddZ8ktAOYdgtTEB6Pgs8d1RMczokU4DQwuGDev
         VhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsc7sT2oAgde6LqGy3t3st5opYIOWy/LQC1wcatRq98=;
        b=GwxENcH5hPJIgH+N+yGBF+/ps/1n2gMUzkKlZLJIlNb7UP56tYBv7pikUDWXhwVXqw
         XzLI442PvHoAPUMhTUUlQv/+6zF1H+zisYgIxd6/Dq9Sadytif6F+9jqqJxIIT3xtN1h
         VyzkQd89wcH+8GeL42slKZDjsdH+81JZJy2HhMGIcp4yMb2zppwlDRowmjD4tzYwaNaJ
         uDatp/dH57vzVUUIqNyNOMpSiLvtRZVXwmMf1qLCz2HUcfDRnWjmvZAC3rxZarJK3Sp2
         d1m9bPHTTDGzcO62bklAUlcWqwfA2oOT8Y9vdKsBKGqTpcjPvtjufHp7zeKfux8MwrvP
         p2Pg==
X-Gm-Message-State: AHQUAubzYcPdLp0qHi2L8oHCP1i9kDPFlA431UjBAoyUmxmXgBAd+i9h
        1U4/A0n5xdI4ApERdkm6H3I21UGx
X-Google-Smtp-Source: AHgI3IaxBvONp0l1Q7+6M7BrTvd01+YDB8yOPXmtndnuSIuQut6TB1KGSbd6u8HHLmzgl4Q/zVRVsQ==
X-Received: by 2002:adf:c54d:: with SMTP id s13mr1456871wrf.169.1549831023456;
        Sun, 10 Feb 2019 12:37:03 -0800 (PST)
Received: from localhost.localdomain ([46.216.193.115])
        by smtp.gmail.com with ESMTPSA id i10sm6148654wrx.54.2019.02.10.12.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 12:37:02 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gsvqS-0005el-8y; Sun, 10 Feb 2019 23:36:56 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
Date:   Sun, 10 Feb 2019 23:36:49 +0300
Message-Id: <20190210203649.21691-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210203649.21691-1-jekhor@gmail.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configuration external charge "#charge enable" signal is
connected to PMIC. Enable it at device probing to allow charging.

Tested at Lenovo Yoga Book (YB1-X91L).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 4f6ba249bc30..00cb3084955e 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -57,6 +57,11 @@
 #define CHT_WC_USBSRC_TYPE_OTHER	8
 #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
 
+#define CHT_WC_CHGDISCTRL		0x5e2f
+#define CHT_WC_CHGDISCTRL_CCSM_DIS	0x11
+#define CHT_WC_CHGDISCTRL_CCSM_EN	0x00
+#define CHT_WC_CHGDISCTRL_CCSM_MASK	0x51
+
 #define CHT_WC_PWRSRC_IRQ		0x6e03
 #define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
 #define CHT_WC_PWRSRC_STS		0x6e1e
@@ -230,6 +235,31 @@ static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
 			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
 }
 
+static void cht_wc_extcon_enable_charging(struct cht_wc_extcon_data *ext,
+					  bool enable)
+{
+	unsigned int chgdisctrl;
+	int ret;
+
+	ret = regmap_read(ext->regmap, CHT_WC_CHGDISCTRL, &chgdisctrl);
+	if (ret) {
+		dev_err(ext->dev, "Error reading CHGDISCTRL reg: %d\n", ret);
+		return;
+	}
+
+	chgdisctrl &= CHT_WC_CHGDISCTRL_CCSM_MASK;
+
+	if (enable)
+		chgdisctrl |= CHT_WC_CHGDISCTRL_CCSM_EN;
+	else
+		chgdisctrl |= CHT_WC_CHGDISCTRL_CCSM_DIS;
+
+	dev_dbg(ext->dev, "Writing CHGDISCTRL: 0x%02x\n", chgdisctrl);
+	ret = regmap_write(ext->regmap, CHT_WC_CHGDISCTRL, chgdisctrl);
+	if (ret)
+		dev_err(ext->dev, "Error writing CHGDISCTRL: %d\n", ret);
+}
+
 /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
 static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
 				    unsigned int cable, bool state)
@@ -362,6 +392,9 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	 */
 	cht_wc_extcon_set_5v_boost(ext, false);
 
+	/* Allow charging by external battery charger*/
+	cht_wc_extcon_enable_charging(ext, true);
+
 	/* Enable sw control */
 	ret = cht_wc_extcon_sw_control(ext, true);
 	if (ret)
-- 
2.20.1

