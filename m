Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B807FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848FB21903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIZgUdQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfBSVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:24:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36453 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfBSVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:24:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so23607786wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ms2tRmhgh7YfcmvnmAX6PNIwDOg54reqN7wxeDE3+AA=;
        b=nIZgUdQ6ogeKoCSTVws8IMHkQXW2ifFvlnVAg7lALMhMGlxMK1afCZJ03AvrknLMsi
         sESlJACPQfmV9x3crfCrkahfg7m9BFURdjbev8UkyoC3uWEwJ21vwV1yxIuQ5fsmSIzQ
         3gsGAWgar6lPar6U3svBUF7bl12RKdGyprsEpUx9I136SguT5NLKAN+g6KmafhBAIRxC
         ikezTdZFyk4JQk7OGgOE8sl5cv30FVAQB1JxKITavIwY9szgGaPNPw0IMeMqvd6nJTl2
         elTb4iQdy+BBZuxcO9CwRGHRB+YCdQwYViwON+3sVFF/jrNFEluf8JydzTgCxokDU93E
         GjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ms2tRmhgh7YfcmvnmAX6PNIwDOg54reqN7wxeDE3+AA=;
        b=WHqnryOlr0CRaF4r3UThhDJKgBDbwJ2nC5D9dHaAuuCCQjciGOxWzDGfKd0iELkM7a
         k1jmpqRbsa/4454hZUOVHbxMjm6quUIvmVBUqKqfxlqsB9sZxTb88GTDpHlwffwJlhDP
         QfR9wZDCtQKnNNFZrkwIb7BFXB67ezcuJXYzJru1eWXwTS6AIX2uU38AmZhZ+bRyfgL8
         1NE3it5sQ91m8ufsSpbZoV5AzDtcfZ6eOLlidL32xJbv6QagEyxT4Gfez+Vnnbf1Njih
         Jt2sP7Ar5/T+7BhyIcuwX1MdjUOlSSSp2BLgfgrsss+Ag648pVORamaluuPg0bOhJM/j
         Tblg==
X-Gm-Message-State: AHQUAuYTYW6vYfLV4giB7gHJfKVznoxqRyR0tMh/YnTIETcFVzdrzmsj
        8Zswf3ZTnaqL9+egRU9oyqbqH2+q
X-Google-Smtp-Source: AHgI3Ian/TIf3lZ1M/uhPP+QoTR8yNp6VmvCqCgGXdwFToiwohySUVZ4AjBU4/kqryx3qi1XedSseQ==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr23409869wrv.251.1550611488595;
        Tue, 19 Feb 2019 13:24:48 -0800 (PST)
Received: from localhost.localdomain ([46.216.153.243])
        by smtp.gmail.com with ESMTPSA id n11sm12311758wrw.60.2019.02.19.13.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 13:24:47 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gwCsf-00053Z-9W; Wed, 20 Feb 2019 00:24:45 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 1/2] extcon-intel-cht-wc: Make charger detection co-existed with OTG host mode
Date:   Wed, 20 Feb 2019 00:24:40 +0300
Message-Id: <20190219212441.19391-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219212441.19391-1-jekhor@gmail.com>
References: <20190219212441.19391-1-jekhor@gmail.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

