Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97905ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593502145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWyzRpfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593502145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeJRG2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:28:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38391 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRG17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:27:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so10283416pll.5;
        Wed, 17 Oct 2018 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G/avwaNHR2AwcRj8BPEvkwQlcWjIT4+gT2UzKciw+Gs=;
        b=CWyzRpfh3in0HjrziB0WF7IfjdlJgWDIGi+EUIzlUQ5rizDgb+wrJHZwZfzLV6vIED
         TQ3t3+7UJmQP5QMG+Ojnfb7mXfmNfRG5CzlpQw0Zz/wqB48Xw8kKnibEuO1NfbCY0OCR
         qHwEvETYqrwqJnFaFvlGHQE9OQB9HxzeaAA24ev6898PIAxup+K6kYe2Zguy1WZjhcoB
         Hagv1b0tFTcZq6Z6ejh6CMI641COCrty4+y4hTYnXuENCoTGkW8VRIGsKhdxYTRYtXaW
         IOLw/sCaA+wHAXmtlH2OO0LbRdtQ27pEeucNX3o0zhCjhxvmY97mvuAuZ/ZZ+F3gn/CV
         Zg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G/avwaNHR2AwcRj8BPEvkwQlcWjIT4+gT2UzKciw+Gs=;
        b=KtOXQ7ApBUQKKWWX/2hNl69CvN16QutxyM8Q+jLnuMfW7CkOeeRDbZJCgxnKz/ne8t
         xb3tTS9pT4tNVVBVhhuJFRqLadBrG5mD+THCxJ5X4XE4z9IEyWZXKSV1HOJExVSR1NrU
         vGXn+oDUzfwnPJxik9Mz6kyyZpyEKTUN7+/YHWhYQlOtDs0SJQaEB+S45Z/hE7oienKn
         Crsvn/0nb246KCFXc8SuidZR0ScWlRvJ/mwus6RzAb7a8Eb9MLhjVZCIGJG9ll6mP7K0
         5wrEbweYxjBZx6ainQ0NPGD72xVbDNKAJJafQK45nW15f9hu8UP3Qq+JkLogvqF6tWh+
         S2lw==
X-Gm-Message-State: ABuFfohUClRqjF6DdwjKE7Tvgk/avXQANGv5GanbS7Z3SDshB2OlEvO/
        Mhg95BOGvH2BACAssJl+gekpcrw3bL0=
X-Google-Smtp-Source: ACcGV61u664iHvXBUIUDQl+1OeNUaT2iFmeRT/rORzqrQNU3WiktxvC+jRi0xHnKsBMmSkvt0e5+sg==
X-Received: by 2002:a17:902:9696:: with SMTP id n22-v6mr19008508plp.282.1539815413047;
        Wed, 17 Oct 2018 15:30:13 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p3-v6sm352597pgl.2.2018.10.17.15.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:30:12 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V2 4/6] usb: ohci-platform: Add support for Broadcom STB SoC's
Date:   Wed, 17 Oct 2018 18:29:07 -0400
Message-Id: <1539815349-24126-5-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the ohci platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/ohci-platform.c | 35 +++++++++++++++++++++++++++++------
 include/linux/usb/ohci_pdriver.h |  1 +
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 65a1c3fdc88c..363d6fa676a5 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -99,12 +100,24 @@ static int ohci_platform_probe(struct platform_device *dev)
 	if (usb_disabled())
 		return -ENODEV;
 
-	/*
-	 * Use reasonable defaults so platforms don't have to provide these
-	 * with DT probing on ARM.
-	 */
-	if (!pdata)
-		pdata = &ohci_platform_defaults;
+	if (!pdata) {
+		const struct usb_ohci_pdata *match_pdata;
+
+		match_pdata = of_device_get_match_data(&dev->dev);
+		if (match_pdata) {
+			pdata = devm_kzalloc(&dev->dev, sizeof(*pdata),
+					     GFP_KERNEL);
+			if (!pdata)
+				return -ENOMEM;
+			*pdata = *match_pdata;
+		} else {
+			/*
+			 * Use reasonable defaults so platforms don't have
+			 * to provide these with DT probing on ARM.
+			 */
+			pdata = &ohci_platform_defaults;
+		}
+	}
 
 	err = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
 	if (err)
@@ -177,6 +190,8 @@ static int ohci_platform_probe(struct platform_device *dev)
 		ohci->flags |= OHCI_QUIRK_FRAME_NO;
 	if (pdata->num_ports)
 		ohci->num_ports = pdata->num_ports;
+	if (pdata->suspend_without_phy_exit)
+		hcd->suspend_without_phy_exit = 1;
 
 #ifndef CONFIG_USB_OHCI_BIG_ENDIAN_MMIO
 	if (ohci->flags & OHCI_QUIRK_BE_MMIO) {
@@ -305,10 +320,18 @@ static int ohci_platform_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static const struct usb_ohci_pdata ohci_plat_brcm_bcm7445_ohci = {
+	.power_on =		ohci_platform_power_on,
+	.power_suspend =	ohci_platform_power_off,
+	.power_off =		ohci_platform_power_off,
+	.suspend_without_phy_exit = 1,
+};
+
 static const struct of_device_id ohci_platform_ids[] = {
 	{ .compatible = "generic-ohci", },
 	{ .compatible = "cavium,octeon-6335-ohci", },
 	{ .compatible = "ti,ohci-omap3", },
+	{ .compatible = "brcm,bcm7445-ohci", &ohci_plat_brcm_bcm7445_ohci},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ohci_platform_ids);
diff --git a/include/linux/usb/ohci_pdriver.h b/include/linux/usb/ohci_pdriver.h
index 7eb16cf587ee..16b24ea1e3bb 100644
--- a/include/linux/usb/ohci_pdriver.h
+++ b/include/linux/usb/ohci_pdriver.h
@@ -35,6 +35,7 @@ struct usb_ohci_pdata {
 	unsigned	big_endian_desc:1;
 	unsigned	big_endian_mmio:1;
 	unsigned	no_big_frame_no:1;
+	unsigned	suspend_without_phy_exit:1;
 	unsigned int	num_ports;
 
 	/* Turn on all power and clocks */
-- 
1.9.0.138.g2de3478

