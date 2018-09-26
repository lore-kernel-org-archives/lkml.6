Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827B82154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="qshl/CCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827B82154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeI0Efv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:35:51 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:57594 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbeI0Efu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:35:50 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id A64E530C02D;
        Wed, 26 Sep 2018 15:20:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com A64E530C02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1538000443;
        bh=2Wy8IBXJFxcP8I9pNgnTD1wJPstuHPNZgoANhcN/0lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qshl/CCU9sv5DpMSUm883aFrzWIQYHG22Rn7BFfK0v/UnfiaGG+Xxcrow8vVXhBhc
         pxIrEy3mmOYoQMJzONFjdyJ+h7uFyna4HcK2ky825JbdhBA9yOnyPoljUmjfdmXPxq
         xlFvLqcgD+i3tRnQm++WVEY57rs6HttE6A01FvH0=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 62C78AC074A;
        Wed, 26 Sep 2018 15:20:41 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        James Hogan <jhogan@kernel.org>, Alban Bedel <albeu@free.fr>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 5/5] usb: host: Enable building of new Broadcom STB USB drivers
Date:   Wed, 26 Sep 2018 18:20:14 -0400
Message-Id: <1538000414-24873-6-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
References: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to Makefile and Kconfig to enable building of the new
Broadcom STB OHCI, EHCI and XHCI drivers. Also update MAINTAINERS.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 MAINTAINERS               |  9 +++++++++
 drivers/usb/host/Kconfig  | 27 +++++++++++++++++++++++++++
 drivers/usb/host/Makefile |  7 +++++++
 3 files changed, 43 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02a39617ec82..9b8e7caad2ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3007,6 +3007,15 @@ S:	Supported
 F:	drivers/gpio/gpio-brcmstb.c
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
 
+BROADCOM BRCMSTB USB XHCI, EHCI and OHCI DRIVERS
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	drivers/usb/host/xhci-brcm.c
+F:	drivers/usb/host/ehci-brcm.c
+F:	drivers/usb/host/ohci-brcm.c
+
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1a4ea98cac2a..1693a5076980 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -798,3 +798,30 @@ config USB_HCD_TEST_MODE
 	  This option is of interest only to developers who need to validate
 	  their USB hardware designs.  It is not needed for normal use.  If
 	  unsure, say N.
+
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
+	select USB_OHCI_BRCM if USB_OHCI_HCD
+	select USB_EHCI_BRCM if USB_EHCI_HCD
+	select USB_XHCI_BRCM if USB_XHCI_HCD
+	select BRCM_USB_PHY if USB_OHCI_HCD || USB_EHCI_HCD || USB_XHCI_HCD
+	select GENERIC_PHY if BRCM_USB_PHY
+	default ARCH_BRCMSTB
+	help
+	  Say Y to enable the drivers for the onchip USB controllers.
+
+	  If your chipset supports power management, disabling this driver
+	  will keep the device permanently powered down.
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index e6235269c151..13e4f45a3a1d 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -91,3 +91,10 @@ obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
 obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
 obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
+
+# The order is important here because it controls the order that
+# the drivers will be initialized and we always need to init
+# the drivers in the order XHCI, EHCI and OHCI.
+obj-$(CONFIG_USB_XHCI_BRCM)	+= xhci-brcm.o
+obj-$(CONFIG_USB_EHCI_BRCM)	+= ehci-brcm.o
+obj-$(CONFIG_USB_OHCI_BRCM)	+= ohci-brcm.o
-- 
1.9.0.138.g2de3478

