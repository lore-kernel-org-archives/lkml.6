Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732052-1521931700-2-16420212190380072896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521931700; b=OSbwwWuK/devB0s5/QzL1BgJgQNkBI6ClZNo3d+/WQBTuUw
    5AwCpJBtqnuqCCkVwbghK1Jb0ThRpRuTnFV0lmuzCrjxNpvBYzLS/R3lLuIyCInj
    iNRFa3sFMBi6E+5gJLr2cER62g7i9FdyKqYbrFbg8NtOrTOpA0FbU0e6yZzoup+J
    VC2UlORPPxUAe6pSrq8Ws8Y+K9yKQ+5KXgdv0LKAN2CvTBmNEuJtf2Kmx06hVSr4
    9Jp2P6rBuPRGHEOz0evPnZeuW3+MqWbsYvyDtJPKECv4cCwUfMEDW0h4Au3PxIM3
    pqHvK40zUFx1XHTJPO55/9AegtiOt8yRQezj+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521931700; bh=/FFDK4+BPFab7tbYEDquGHmkty
    eK0O4rwMjzz8cAXeE=; b=MZEJEZzE/hjch4ai36ZSTDZpDqhZPqHwILeuKrJcIi
    kcnAKfnHgR1ezpChHF9tsul1xD/2Krgip0XdhTGHgSyR6S1lJKUmmOP9d0wHBs2+
    +OrpLA7ZioVIcJjq6dlxkP8QVadGuV5CSrhfM/563sn6IsGrLLr431ZjsfMfEBGr
    /FSR7/HFeREUu72wBPZzyGzMrkVfH8ePkAvUf1q8SkEDzZw2KMu3KPrKuncbzRjv
    vmXrr0HuHPCgbzZw+dnEK3Xv8HlSpVKYzowoD0PNTPGhRGZ+pAYlHZUb0M7Dw1W3
    DzsTuHmfmf2M/fYJih5cmS7nVw1Oa56A5pl9lgxfa4mA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=free.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=free.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCXWsE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 18:48:04 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:54104 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbeCXWsE (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 24 Mar 2018 18:48:04 -0400
From: Alban Bedel <albeu@free.fr>
To: linux-usb@vger.kernel.org
Cc: Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Elder <elder@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: Remove the deprecated ATH79 USB host config options
Date: Sat, 24 Mar 2018 23:47:22 +0100
Message-Id: <1521931644-31326-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The options USB_EHCI_ATH79 and USB_OHCI_ATH79 only enable the
generic EHCI and OHCI platform drivers, and have been marked as
deprecated since 2012.

These can be safely removed if we make sure that USB_EHCI_ROOT_HUB_TT
still get enabled for the EHCI driver. This is now done be selecting
this option when the EHCI platform driver is enabled on the ATH79
platform.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/Kconfig        |  1 +
 drivers/usb/host/Kconfig | 25 -------------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8128c3b..61e9a24 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -200,6 +200,7 @@ config ATH79
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_ZBOOT_UART_PROM
 	select USE_OF
+	select USB_EHCI_ROOT_HUB_TT if USB_EHCI_HCD_PLATFORM
 	help
 	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
 
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4fcfb30..55b45dc 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -293,19 +293,6 @@ config USB_CNS3XXX_EHCI
 	  It is needed for high-speed (480Mbit/sec) USB 2.0 device
 	  support.
 
-config USB_EHCI_ATH79
-	bool "EHCI support for AR7XXX/AR9XXX SoCs (DEPRECATED)"
-	depends on (SOC_AR71XX || SOC_AR724X || SOC_AR913X || SOC_AR933X)
-	select USB_EHCI_ROOT_HUB_TT
-	select USB_EHCI_HCD_PLATFORM
-	default y
-	---help---
-	  This option is deprecated now and the driver was removed, use
-	  USB_EHCI_HCD_PLATFORM instead.
-
-	  Enables support for the built-in EHCI controller present
-	  on the Atheros AR7XXX/AR9XXX SoCs.
-
 config USB_EHCI_HCD_PLATFORM
 	tristate "Generic EHCI driver for a platform device"
 	default n
@@ -489,18 +476,6 @@ config USB_OHCI_HCD_DAVINCI
 	  controller. This driver cannot currently be a loadable
 	  module because it lacks a proper PHY abstraction.
 
-config USB_OHCI_ATH79
-	bool "USB OHCI support for the Atheros AR71XX/AR7240 SoCs (DEPRECATED)"
-	depends on (SOC_AR71XX || SOC_AR724X)
-	select USB_OHCI_HCD_PLATFORM
-	default y
-	help
-	  This option is deprecated now and the driver was removed, use
-	  USB_OHCI_HCD_PLATFORM instead.
-
-	  Enables support for the built-in OHCI controller present on the
-	  Atheros AR71XX/AR7240 SoCs.
-
 config USB_OHCI_HCD_PPC_OF_BE
 	bool "OHCI support for OF platform bus (big endian)"
 	depends on PPC
-- 
2.7.4

