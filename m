Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F0C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816482145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STWyQAIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBJUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:37:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36339 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:36:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so13021549wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 12:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbmwev5IAtsY+6KH87DmxvW4mR3mVnCvDZlijKdF0L8=;
        b=STWyQAIL0oL8tmQdyhU+J2LwBJ2Oillvy6nV4VTbICoWg7pK+LK45bw37ffUmBvEBH
         wO47eponkKOl2CEcFXpH25w52Ehu0sd/Tpy7nvz5P1Ka1hgSXHwhK21gBFbFqDnACbHN
         KAZ2XS3BTwodw0WOX0TyP5WY3x4f7fFLnmzCZL/UtgA+HGMQXriwA2G01lX5uyGhtODh
         6pR15GUmhnuzr4VDAs7oI6uh3IYEESmT/gFq4q7DQSoXfIUgQASf5mx0AEjEHjevb2A7
         wGQdBa0w6RlHp4U5C7w15cGdJMFLAHHETcRo3t17bdCtjZKn6ChZYVMXzhluQSRiTdWu
         aN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbmwev5IAtsY+6KH87DmxvW4mR3mVnCvDZlijKdF0L8=;
        b=t49J2yWiR6NOpOtla5XgoC/ZOfzysE82KoI8O8YvFgnGDSeF4KGJWO6/brssEDRET/
         5YB9W5Lb/0udSXEky6dRp26jy7MiFTpr89tEWEndslcwIhdbYNBiMuylYg/C9W3zeHfv
         bcK9tKDTwlOCPgHI+m31VzwKpKhII0IfRNbj16bjbbwAMvYS1wG9QTH14ZgtaRW43ETF
         aNdAq+WHyFPihwIGS/DRLb8/qyLOX6EBu/MQFU3SLEx0aPjGmiMLd3y4FexnDezgT4y9
         /BXCUOLF104U0WIZ6E7eD7rbWwDEjnM4q1JrqpOkx7XBE6j3l4/miCcAGNUAXRV2+F20
         xfdQ==
X-Gm-Message-State: AHQUAuZaySyvV+XHgZQvJ5/UBB7eRfrxEg6QGBIFoblMwiohIGc4zCv+
        TRj/jg6+WZ4oWD7AGTz3wJuTrXdA
X-Google-Smtp-Source: AHgI3IZaFFiDyS+01WZ+OdQuySLQUSAfsYzFEnjXl/IHumFWUo29QD35p37oPdaqRq4hJAffZBPl3w==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr6875876wmu.52.1549831016917;
        Sun, 10 Feb 2019 12:36:56 -0800 (PST)
Received: from localhost.localdomain ([46.216.193.115])
        by smtp.gmail.com with ESMTPSA id a14sm6871858wrr.13.2019.02.10.12.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 12:36:56 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gsvqQ-0005ei-Mw; Sun, 10 Feb 2019 23:36:54 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 1/2] extcon-intel-cht-wc: Make charger detection co-existed with OTG host mode
Date:   Sun, 10 Feb 2019 23:36:48 +0300
Message-Id: <20190210203649.21691-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210203649.21691-1-jekhor@gmail.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
of charger detection procedure. Do this by manipulationg of CHGRCTRL1
register.

Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
Intel's drivers.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 38 +++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 5ef215297101..4f6ba249bc30 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -29,7 +29,16 @@
 #define CHT_WC_CHGRCTRL0_DBPOFF		BIT(6)
 #define CHT_WC_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
 
-#define CHT_WC_CHGRCTRL1		0x5e17
+#define CHT_WC_CHGRCTRL1			0x5e17
+#define CHT_WC_CHGRCTRL1_DBPEN_MASK		BIT(7)
+#define CHT_WC_CHGRCTRL1_OTGMODE		BIT(6)
+#define CHT_WC_CHGRCTRL1_FTEMP_EVENT		BIT(5)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_1500	BIT(4)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_900		BIT(3)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_500		BIT(2)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_150		BIT(1)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_100		BIT(0)
+
 
 #define CHT_WC_USBSRC			0x5e29
 #define CHT_WC_USBSRC_STS_MASK		GENMASK(1, 0)
@@ -198,6 +207,29 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
 		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
 }
 
+static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
+				      bool enable)
+{
+	unsigned int chgrctrl1;
+	int ret;
+
+	ret = regmap_read(ext->regmap, CHT_WC_CHGRCTRL1, &chgrctrl1);
+	if (ret) {
+		dev_err(ext->dev, "Error reading CHGRCTRL1 reg: %d\n", ret);
+		return;
+	}
+
+	if (enable)
+		chgrctrl1 |= CHT_WC_CHGRCTRL1_OTGMODE;
+	else
+		chgrctrl1 &= ~(CHT_WC_CHGRCTRL1_OTGMODE);
+
+	ret = regmap_write(ext->regmap, CHT_WC_CHGRCTRL1, chgrctrl1);
+	if (ret)
+		dev_err(ext->dev,
+			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
+}
+
 /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
 static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
 				    unsigned int cable, bool state)
@@ -222,10 +254,14 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 
 	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
 	if (id == USB_ID_GND) {
+		cht_wc_extcon_set_otgmode(ext, true);
+
 		/* The 5v boost causes a false VBUS / SDP detect, skip */
 		goto charger_det_done;
 	}
 
+	cht_wc_extcon_set_otgmode(ext, false);
+
 	/* Plugged into a host/charger or not connected? */
 	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
 		/* Route D+ and D- to PMIC for future charger detection */
-- 
2.20.1

