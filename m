Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC862083E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru0u7pnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfBSVYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:24:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53439 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfBSVYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:24:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so3787912wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tegm1mU7FILMRPzkTTOsseEqEBXAz+95p4Y1cECPT1o=;
        b=Ru0u7pnOdSLA5fsr83QFOnz8PlEv6bQ5TGDVX3Z2VK2w/5wK7lVrKxIQxhbHgeRuVZ
         usiInmBJonEKbFgdw2U4CR1r64Jk439Cy9T/b1Cb1cS1eqHbdAD1JXOx6xCdIsHz1l+Z
         kndS/1xlJH0Kshj8OeAgTzZ2GnalzXFx1+DrdPtGGNZaBkNHdOqbRAa3TabWWzFKy/HQ
         UoU0ADuHtXdXQsdeaiW+nnFda/YfYolOEBwl5VU28ymYjnMs+76wOGOfVJrf7qKAoQqn
         xWiRbbc0wgSZfG6Mlg7afabAyW0yAKSDsX89vXGr6ZugQCWjBL1nAmQ8jpDm+xWTFc+4
         Ytsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tegm1mU7FILMRPzkTTOsseEqEBXAz+95p4Y1cECPT1o=;
        b=a3tZzWHxt/6l1APyWkzCTkv9Oxwz7qDfc/eafn9AdE0TUjdSOL7JHLhlwc+97t1XZ+
         rse0Ac+RPVBA0rHPLQWphWJvZmgfkMBBUFLVZhRS6Ygt5jmpH7lkCJF9XCKUSstoQyEX
         onuXrJxEBvFaCDd5FR7FowZ1WH0bQ0dJ0hxs7UKn53bhj1v8ftumYDrl8bzoDSvC4qtv
         QjSa1fpAGgy/amNq8yfxKLOvTUb/cRCN+dIABRi6rqVtl45QS+pZe62/uIb5yMH6R5BG
         9mRCrq7kh7DtUmXo6KXgsl5WvPl+PEhEy0f12MQlOk37L5zFyiadDkT4prnTOSuNnJPi
         VRwg==
X-Gm-Message-State: AHQUAubRFsQHmmEXxw6/bBk9nlquE6uCTduSAXdgl5r1i4Frp/HOo1Q/
        RorPi8TEvLpK9pMlC0vJfOLeEeIk
X-Google-Smtp-Source: AHgI3IZ/J91F8xy/jv8AasHXOlG37Q/GMFox7T2sQvZLlxBtXnRzJaZ6KWzHgz86fLsknMPcaM/J8Q==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr4530822wmi.135.1550611490178;
        Tue, 19 Feb 2019 13:24:50 -0800 (PST)
Received: from localhost.localdomain ([46.216.153.243])
        by smtp.gmail.com with ESMTPSA id u15sm4150999wmu.17.2019.02.19.13.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 13:24:49 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gwCsf-00053b-A9; Wed, 20 Feb 2019 00:24:45 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 2/2] extcon intel-cht-wc: Enable external charger
Date:   Wed, 20 Feb 2019 00:24:41 +0300
Message-Id: <20190219212441.19391-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219212441.19391-1-jekhor@gmail.com>
References: <20190219212441.19391-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configuration external charger "#charge enable" signal is
connected to PMIC. Enable it at device probing to allow charging.

Save CHGRCTRL0 and CHGDISCTR registers at driver probing and restore
them at driver unbind to re-enable hardware charging control if it was
enabled before.

Tested at Lenovo Yoga Book (YB1-X91L).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 91 +++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 4f6ba249bc30..ac009929d244 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -57,6 +57,16 @@
 #define CHT_WC_USBSRC_TYPE_OTHER	8
 #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
 
+#define CHT_WC_CHGDISCTRL		0x5e2f
+#define CHT_WC_CHGDISCTRL_OUTPUT	BIT(0)
+/* 0 - open drain, 1 - regular output */
+#define CHT_WC_CHGDISCTRL_DRV_OD_DIS	BIT(4)
+#define CHT_WC_CHGDISCTRL_MODE_HW	BIT(6)
+
+#define CHT_WC_CHGDISCTRL_CCSM_DIS	0x11
+#define CHT_WC_CHGDISCTRL_CCSM_EN	0x00
+#define CHT_WC_CHGDISCTRL_CCSM_MASK	0x51
+
 #define CHT_WC_PWRSRC_IRQ		0x6e03
 #define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
 #define CHT_WC_PWRSRC_STS		0x6e1e
@@ -103,6 +113,8 @@ struct cht_wc_extcon_data {
 	struct regmap *regmap;
 	struct extcon_dev *edev;
 	unsigned int previous_cable;
+	unsigned int chgdisctrl_saved;
+	unsigned int chgrctrl0_saved;
 	bool usb_host;
 };
 
@@ -230,6 +242,20 @@ static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
 			"Error writing CHGRCTRL1 OTG mode bit: %d\n", ret);
 }
 
+static void cht_wc_extcon_enable_charging(struct cht_wc_extcon_data *ext,
+					  bool enable)
+{
+	unsigned int val;
+	int ret;
+
+	val = enable ? 0 : CHT_WC_CHGDISCTRL_OUTPUT;
+
+	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
+				 CHT_WC_CHGDISCTRL_OUTPUT, val);
+	if (ret)
+		dev_err(ext->dev, "Error updating CHGDISCTRL reg: %d\n", ret);
+}
+
 /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
 static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
 				    unsigned int cable, bool state)
@@ -254,6 +280,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 
 	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
 	if (id == USB_ID_GND) {
+		cht_wc_extcon_enable_charging(ext, false);
 		cht_wc_extcon_set_otgmode(ext, true);
 
 		/* The 5v boost causes a false VBUS / SDP detect, skip */
@@ -261,6 +288,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 	}
 
 	cht_wc_extcon_set_otgmode(ext, false);
+	cht_wc_extcon_enable_charging(ext, true);
 
 	/* Plugged into a host/charger or not connected? */
 	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
@@ -314,6 +342,14 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
 {
 	int ret, mask, val;
 
+	val = enable ? 0 : CHT_WC_CHGDISCTRL_MODE_HW;
+	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
+			CHT_WC_CHGDISCTRL_MODE_HW, val);
+	if (ret)
+		dev_err(ext->dev,
+			"Error setting sw control for charger enable: %d\n",
+			ret);
+
 	mask = CHT_WC_CHGRCTRL0_SWCONTROL | CHT_WC_CHGRCTRL0_CCSM_OFF;
 	val = enable ? mask : 0;
 	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGRCTRL0, mask, val);
@@ -323,6 +359,52 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
 	return ret;
 }
 
+static int cht_wc_save_initial_state(struct cht_wc_extcon_data *ext)
+{
+	int ret;
+
+	/*
+	 * Save the external charger control output state for restoring it at
+	 * driver unbinding
+	 */
+	ret = regmap_read(ext->regmap, CHT_WC_CHGDISCTRL,
+			  &ext->chgdisctrl_saved);
+	if (ret) {
+		dev_err(ext->dev, "Error reading CHGDISCTRL: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = regmap_read(ext->regmap, CHT_WC_CHGRCTRL0,
+			  &ext->chgrctrl0_saved);
+	if (ret) {
+		dev_err(ext->dev, "Error reading CHGRCTRL0: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cht_wc_restore_initial_state(struct cht_wc_extcon_data *ext)
+{
+	int ret;
+
+	ret = regmap_write(ext->regmap, CHT_WC_CHGDISCTRL,
+			   ext->chgdisctrl_saved);
+	if (ret)
+		dev_err(ext->dev, "Error restoring of CHGDISCTRL reg: %d\n",
+			ret);
+
+	ret = regmap_write(ext->regmap, CHT_WC_CHGRCTRL0,
+			   ext->chgrctrl0_saved);
+	if (ret)
+		dev_err(ext->dev, "Error restoring of CHGRCTRL0 reg: %d\n",
+			ret);
+
+	return ret;
+}
+
 static int cht_wc_extcon_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
@@ -347,6 +429,8 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	if (IS_ERR(ext->edev))
 		return PTR_ERR(ext->edev);
 
+	cht_wc_save_initial_state(ext);
+
 	/*
 	 * When a host-cable is detected the BIOS enables an external 5v boost
 	 * converter to power connected devices there are 2 problems with this:
@@ -365,7 +449,10 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	/* Enable sw control */
 	ret = cht_wc_extcon_sw_control(ext, true);
 	if (ret)
-		return ret;
+		goto disable_sw_control;
+
+	/* Disable charging by external battery charger */
+	cht_wc_extcon_enable_charging(ext, false);
 
 	/* Register extcon device */
 	ret = devm_extcon_dev_register(ext->dev, ext->edev);
@@ -400,6 +487,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 
 disable_sw_control:
 	cht_wc_extcon_sw_control(ext, false);
+	cht_wc_restore_initial_state(ext);
 	return ret;
 }
 
@@ -408,6 +496,7 @@ static int cht_wc_extcon_remove(struct platform_device *pdev)
 	struct cht_wc_extcon_data *ext = platform_get_drvdata(pdev);
 
 	cht_wc_extcon_sw_control(ext, false);
+	cht_wc_restore_initial_state(ext);
 
 	return 0;
 }
-- 
2.20.1

