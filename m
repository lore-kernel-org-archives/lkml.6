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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296DAECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DBD21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+fTw5+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DBD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeJRG2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:28:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45438 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJRG2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:28:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id y15-v6so13349837plr.12;
        Wed, 17 Oct 2018 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HLBJAv0sMMzlzwqjXNvHCj/KWOFQxAuSMQyCP91bvfk=;
        b=b+fTw5+WUT6ydP+6YcfNLxzLC/uTHrsg/qbOTQKK87Hfc72I/FBaDBkEvuz7J8hYWP
         7vvw7/muNb63KkVON1yIhPc3zKXs+Ze6mpJyWeaLsv9s3hEP/ZFf3Kg/YdGQ+XNVWb9z
         Hu593f9Szkr9nVYkyFN7ODlqTMf/jDzI5FwV/QW7YymV/v7IIPbNFEBNI7CAKS4mSqpL
         0tpr+nYKjTfhKnfafSMhycLuXj4VoUjdR1PLqEuy5pZUlvnDelkVcSEZcOxq00R3e/iI
         9hbb5AidVQiSUNvcY8R/XDH7GDKG6i4txQ36DwVN+xCYhoPxeEPizUKdxb3yfT7uhrUD
         5qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HLBJAv0sMMzlzwqjXNvHCj/KWOFQxAuSMQyCP91bvfk=;
        b=SDbrnddXKwxB54CxwErhzTzTG4Xj26ad6OZXT9aQgC/cSPfDdCYDw9ochJLDIzTApx
         GakyvEJsjUmAVru8vgf9YW4EQjph9jYvAM3+jpJBvMhG223cAvX8bPPqPFt4CyN1Wze4
         4hW88ygqXItIdVmoq58dc32nAGpjeJkHN9zDzrUeMelnusO9Pxxi+O3nSYIAe1bEKxHa
         WuM1azdFymqFsRzj1avzKuhuxHPf/WhN0lBKKLyuMPhR3AWKwqrngFbZACx+xJZDOXPk
         LBFulE8VzVMCLpAf3vF3VrrjAUa77eWCMXknW6oYr9S8lqcfNoqzy6Mjw4aCHNptWLpp
         9VxQ==
X-Gm-Message-State: ABuFfohcCJTsaMbEVzirfWA+SfhnSplYe16oK0qHGtRLWL7cTr99UJB9
        PTMGLEeikTgSZMd3/xSC32my7GPlnT0=
X-Google-Smtp-Source: ACcGV602x89OWR3UU5Ffw10ZgjvCLyZJbvj0gRn62MrV828jC6VHdAmcdLRwHaWd0ahJ9Mgd+CkItQ==
X-Received: by 2002:a17:902:6689:: with SMTP id e9-v6mr3587363plk.128.1539815421024;
        Wed, 17 Oct 2018 15:30:21 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p3-v6sm352597pgl.2.2018.10.17.15.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:30:20 -0700 (PDT)
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
Subject: [PATCH V2 6/6] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Wed, 17 Oct 2018 18:29:09 -0400
Message-Id: <1539815349-24126-7-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the build system changes needed to get the Broadcom STB XHCI,
EHCI and OHCI functionality working. The link order for XHCI was
changed in the Makefile because of the way STB XHCI, EHCI and OHCI
controllers share a port which requires that the XHCI driver be
initialized first. Also update MAINTAINERS.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 MAINTAINERS               |  9 +++++++++
 drivers/usb/host/Kconfig  | 29 +++++++++++++++++++++++++++++
 drivers/usb/host/Makefile | 18 ++++++++++++------
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ac000cc006d..7e062dcbe173 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3006,6 +3006,15 @@ S:	Supported
 F:	drivers/gpio/gpio-brcmstb.c
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
 
+BROADCOM BRCMSTB USB XHCI, EHCI and OHCI DRIVERS
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	drivers/usb/host/xhci-brcm.*
+F:	drivers/usb/host/ohci-brcm.c
+F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-*.txt
+
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1a4ea98cac2a..112de3334389 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -94,6 +94,35 @@ config USB_XHCI_TEGRA
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in NVIDIA Tegra124 and later SoCs.
 
+config USB_OHCI_BRCM
+       tristate
+
+config USB_EHCI_BRCM
+       tristate
+
+config USB_XHCI_BRCM
+       tristate
+
+config BRCM_USB_PHY
+       tristate
+
+config USB_BRCM
+	tristate "Broadcom STB USB support"
+	depends on ARCH_BRCMSTB
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
+	select USB_EHCI_BRCM if USB_EHCI_HCD
+	select USB_XHCI_BRCM if USB_XHCI_HCD
+	select USB_XHCI_PLATFORM if USB_XHCI_HCD
+	select BRCM_USB_PHY if USB_OHCI_HCD || USB_EHCI_HCD || USB_XHCI_HCD
+	select GENERIC_PHY if BRCM_USB_PHY
+	default ARCH_BRCMSTB
+	help
+	  Say Y to enable support for XHCI, EHCI and OHCI host controllers
+	  found in Broadcom STB SoC's.
+
+	  Disabling this will keep the controllers and corresponding
+	  PHYs powered down.
+
 endif # USB_XHCI_HCD
 
 config USB_EHCI_HCD
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index e6235269c151..2a16226f0916 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -31,6 +31,10 @@ ifneq ($(CONFIG_USB_XHCI_RCAR), )
 	xhci-plat-hcd-y		+= xhci-rcar.o
 endif
 
+ifneq ($(CONFIG_USB_XHCI_BRCM), )
+	xhci-plat-hcd-y		+= xhci-brcm.o
+endif
+
 ifneq ($(CONFIG_DEBUG_FS),)
 	xhci-hcd-y		+= xhci-debugfs.o
 endif
@@ -39,6 +43,13 @@ obj-$(CONFIG_USB_WHCI_HCD)	+= whci/
 
 obj-$(CONFIG_USB_PCI)	+= pci-quirks.o
 
+obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
+obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
+obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
+obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
+obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk.o
+obj-$(CONFIG_USB_XHCI_TEGRA)	+= xhci-tegra.o
+
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_EHCI_PCI)	+= ehci-pci.o
 obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)	+= ehci-platform.o
@@ -52,6 +63,7 @@ obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
 obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 obj-$(CONFIG_USB_EHCI_TEGRA)	+= ehci-tegra.o
 obj-$(CONFIG_USB_W90X900_EHCI)	+= ehci-w90x900.o
+obj-$(CONFIG_USB_EHCI_BRCM)	+= ehci-brcm.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
@@ -72,12 +84,6 @@ obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
-obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
-obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
-obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
-obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
-obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk.o
-obj-$(CONFIG_USB_XHCI_TEGRA)	+= xhci-tegra.o
 obj-$(CONFIG_USB_SL811_HCD)	+= sl811-hcd.o
 obj-$(CONFIG_USB_SL811_CS)	+= sl811_cs.o
 obj-$(CONFIG_USB_U132_HCD)	+= u132-hcd.o
-- 
1.9.0.138.g2de3478

