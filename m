Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C04ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC7321473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRPc2tKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC7321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeJRG1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:27:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45985 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRG1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:27:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so13850870pfn.12;
        Wed, 17 Oct 2018 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f9A6R6aOucoDmKZi9No7wZ/RuFbvujGgsoesI9cyy0M=;
        b=SRPc2tKWCQBxK1BSf2oXIwsygBz/aj9Op1Z87fyPch+1jBb8OEA2S7yu182JBeO9j2
         ho9eMEGqXKAroyJUxlYJlXY7QD1tW+WavsJDzpn0MFFABk5BdObj+VX0ZoiEjQpTBWgf
         xb0bReyp38AF2KtqdVQWqyXMFkK9ZJUmlxFAZD5Pv6chnkuRE4t51PAQJ8D1Cd1cGLxg
         Om3RXLCVUf0Yid06AwPUgq/GGBVnQVM+sfJnoDK8tdNwLwSNXPaZY/eHj0alaeXvJ9Yb
         RdjGu5qWM6sIaYG0m24hdkfV+uUQMcZpEFK+ppXBvnKRG773iUIMpn5VM3HcqyD/mQsQ
         Vw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f9A6R6aOucoDmKZi9No7wZ/RuFbvujGgsoesI9cyy0M=;
        b=acIEvHvl8RJMOmiVioDzifaMDLPoxc57muGIdkLREdKls2VNPbV9km7XyQi+b0WfsX
         m7GrO5Tb3a3qaVOawbzMje+7CAQYEhgHfB8mv7bRoPsTFXaNlBLnaD4umZP2MtAkXrPk
         +sDFs3tZhPwCuNlZENIGOgUsTdqGBOW4f6f3uIQZLn+04BlA7I+oRlHFyI11VtqkWUW/
         0qFYXrrVbYmf4YO3rY8R82r1EBbekkKa6Nh7hwbo9EtgzsxWMBD06SqYL/ocJG9PbpCW
         dG/AyXLlX/vnaz57+3GWNr+FYrWN6DzB9htUjVGWEhDx2OxDpz8o6WDwqcZdmtPmDi2J
         NisQ==
X-Gm-Message-State: ABuFfoiiYaG4iPOKLgOtOxAkugnjdGYAn6MfIRhEm5JbYMr54fAGQSVo
        DupmQNGl2yi2+3KxGRwfTqhrGfy89KM=
X-Google-Smtp-Source: ACcGV61HPZjRevTSNN7UE6ZRHUwCYDlDL9zotT/z/HUpoVZmQQ3Vl5u8ZRzmsKy1FM9GSqhzdOYseQ==
X-Received: by 2002:a63:1302:: with SMTP id i2-v6mr26630111pgl.380.1539815405185;
        Wed, 17 Oct 2018 15:30:05 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p3-v6sm352597pgl.2.2018.10.17.15.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:30:04 -0700 (PDT)
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
Subject: [PATCH V2 2/6] usb: core: Add ability to skip phy exit on suspend and init on resume
Date:   Wed, 17 Oct 2018 18:29:05 -0400
Message-Id: <1539815349-24126-3-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to skip calling the PHY's exit routine on suspend
and the PHY's init routine on resume. This is to handle a USB PHY
that should have it's power_off function called on suspend but cannot
have it's exit function called because on exit it will disable the
PHY to the point where register accesses to the Host Controllers
using the PHY will be disabled and the host drivers will crash.

This is enabled with the HCD flag "suspend_without_phy_exit" which
can be set from any HCD driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/core/hcd.c  |  8 ++++----
 drivers/usb/core/phy.c  | 18 ++++++++++++------
 drivers/usb/core/phy.h  |  9 ++++++---
 include/linux/usb/hcd.h |  3 +++
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 1c21955fe7c0..e67e4d6b3d21 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2263,7 +2263,7 @@ int hcd_bus_suspend(struct usb_device *rhdev, pm_message_t msg)
 		hcd->state = HC_STATE_SUSPENDED;
 
 		if (!PMSG_IS_AUTO(msg))
-			usb_phy_roothub_suspend(hcd->self.sysdev,
+			usb_phy_roothub_suspend(hcd,
 						hcd->phy_roothub);
 
 		/* Did we race with a root-hub wakeup event? */
@@ -2304,7 +2304,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 	}
 
 	if (!PMSG_IS_AUTO(msg)) {
-		status = usb_phy_roothub_resume(hcd->self.sysdev,
+		status = usb_phy_roothub_resume(hcd,
 						hcd->phy_roothub);
 		if (status)
 			return status;
@@ -2347,7 +2347,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 		}
 	} else {
 		hcd->state = old_state;
-		usb_phy_roothub_suspend(hcd->self.sysdev, hcd->phy_roothub);
+		usb_phy_roothub_suspend(hcd, hcd->phy_roothub);
 		dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
 				"resume", status);
 		if (status != -ESHUTDOWN)
@@ -2744,7 +2744,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	struct usb_device *rhdev;
 
 	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
-		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
+		hcd->phy_roothub = usb_phy_roothub_alloc(hcd);
 		if (IS_ERR(hcd->phy_roothub))
 			return PTR_ERR(hcd->phy_roothub);
 
diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 9879767452a2..b54db39eee4c 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -45,10 +45,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
 	return 0;
 }
 
-struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
+struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd)
 {
 	struct usb_phy_roothub *phy_roothub;
 	int i, num_phys, err;
+	struct device *dev = hcd->self.sysdev;
 
 	if (!IS_ENABLED(CONFIG_GENERIC_PHY))
 		return NULL;
@@ -161,26 +162,30 @@ void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
 
-int usb_phy_roothub_suspend(struct device *controller_dev,
+int usb_phy_roothub_suspend(struct usb_hcd *hcd,
 			    struct usb_phy_roothub *phy_roothub)
 {
+	struct device *controller_dev = hcd->self.sysdev;
+
 	usb_phy_roothub_power_off(phy_roothub);
 
 	/* keep the PHYs initialized so the device can wake up the system */
-	if (device_may_wakeup(controller_dev))
+	if (device_may_wakeup(controller_dev) || hcd->suspend_without_phy_exit)
 		return 0;
 
 	return usb_phy_roothub_exit(phy_roothub);
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_suspend);
 
-int usb_phy_roothub_resume(struct device *controller_dev,
+int usb_phy_roothub_resume(struct usb_hcd *hcd,
 			   struct usb_phy_roothub *phy_roothub)
 {
+	struct device *controller_dev = hcd->self.sysdev;
 	int err;
 
 	/* if the device can't wake up the system _exit was called */
-	if (!device_may_wakeup(controller_dev)) {
+	if (!device_may_wakeup(controller_dev) &&
+	    !hcd->suspend_without_phy_exit) {
 		err = usb_phy_roothub_init(phy_roothub);
 		if (err)
 			return err;
@@ -189,7 +194,8 @@ int usb_phy_roothub_resume(struct device *controller_dev,
 	err = usb_phy_roothub_power_on(phy_roothub);
 
 	/* undo _init if _power_on failed */
-	if (err && !device_may_wakeup(controller_dev))
+	if (err && !device_may_wakeup(controller_dev)
+	    && !hcd->suspend_without_phy_exit)
 		usb_phy_roothub_exit(phy_roothub);
 
 	return err;
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index 88a3c037e9df..34293e11a917 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -5,13 +5,16 @@
  * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
  */
 
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
 #ifndef __USB_CORE_PHY_H_
 #define __USB_CORE_PHY_H_
 
 struct device;
 struct usb_phy_roothub;
 
-struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev);
+struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd);
 
 int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub);
 int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
@@ -19,9 +22,9 @@
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
 void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
 
-int usb_phy_roothub_suspend(struct device *controller_dev,
+int usb_phy_roothub_suspend(struct usb_hcd *hcd,
 			    struct usb_phy_roothub *phy_roothub);
-int usb_phy_roothub_resume(struct device *controller_dev,
+int usb_phy_roothub_resume(struct usb_hcd *hcd,
 			   struct usb_phy_roothub *phy_roothub);
 
 #endif /* __USB_CORE_PHY_H_ */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 97e2ddec18b1..87a104055b5e 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -157,6 +157,9 @@ struct usb_hcd {
 	 */
 	unsigned		skip_phy_initialization:1;
 
+	/* Some phys don't want the phy's exit/init called on suspend/resume */
+	unsigned		suspend_without_phy_exit:1;
+
 	/* The next flag is a stopgap, to be removed when all the HCDs
 	 * support the new root-hub polling mechanism. */
 	unsigned		uses_new_polling:1;
-- 
1.9.0.138.g2de3478

