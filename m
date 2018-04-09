Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2124738-1523311436-2-4789511261239260210
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523311435; b=LV4wahq1qzaKhTOscKiINZvFOnE6sBfneSjtlwAjfKUGqcq5Fo
    qnfvzjweKHFE0fdt8p6Wn5ox3CAhm4WqLA3x2J2Ra91NJ1z8lB86tKmZLTZ3B2da
    2wZ/SCDaHhg6gB6u4OnDl0iLvyCn9piuz5yq07sbc7QKicueEM0OfkcQtbwg9oqX
    lygAjC1sxul8lKt5oubpTP4JxuWWBrZyLZl/oOW9MyWboYiE91xngJjp3MOGxX/C
    DpuQiFN/kFD2S2/g/HuakcclUEEIOR9kDtdDOr8zDc04kMOhu/WvGZlIyAP3JUz4
    TZ/D36fBFmLJU1ZuHXyMwl1KKvfjtrBq4uhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1523311435; bh=YlpAsNgAC12xpkJo/gC/GU1cDbDnC8JuA0c6cDg
    TYfk=; b=FfbpRrroJ6jNYdzZLhjHxGoGdeR0yNTnI6uzTHf0d6z69FuB0FPxC9v
    pTH6N8KEkr+GzLQFHZ31N66WjJXYYCpMfG3m/E/K+p+olZUokZY3ugmwQLXUr1cn
    wWx05eoaHrnC7hQZcS8ZKYou0Z+2ZMLGOzGiIoEx6dcbx6lPHR27uJtwcE/wLLP4
    lbe4kGK6aP9eLTyLfTRkB4XabYLz6TU3mlG+3dwbGmPIKN0p8/2wg+pb/O2HATx4
    F6mMCb1bryfvtaAvwVvlazRNBpkNMlNruwgfRTGKYCSjC9prilPAH/2tu+qbLdRb
    d7aXZkzU9uO6rcxq82vyAdBRnbB7Xrw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JcxJa51t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WfXJsQiM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JcxJa51t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WfXJsQiM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGXMZ0cD6ZTRM+oCDkN8aMTPWorLq1oJhFJARobroc6yrCKH3/UCU/2FWm8cir4/Ij5dV77gt43+e8wjA89pSuZlDcEMMcqTMJ+Sntb94ry/vPW98/Dh
    FeMir1Mt80YIS052Xkn+nXyvlqqfHiw4x4JWQG9gUKQSzKMQF4rauY4e1RGtWa+TVanF4n/FEo19IYMSUJMsITKfOdFTUej3F1O9GSTXG5G0tVtQMmXlwuRp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=YhKUcPloZ5QA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=pIfNtZ8X2Qh1XE2h6-MA:9
    a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDIWDl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 18:03:41 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41683 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeDIWDh (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 18:03:37 -0400
X-Google-Smtp-Source: AIpwx4/vqo9w7tvKpMgVNQuel4l2BETi+6xReNfIaVjgN4f4c2dyPad8/37M5PD4K1vYO/QY8BdD2A==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] usb: phy: Add Kconfig entry for Tegra PHY driver
Date: Tue, 10 Apr 2018 01:02:59 +0300
Message-Id: <aad79a65528636ee5fd217cfb7273de10147fc13.1523307883.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523307883.git.digetx@gmail.com>
References: <cover.1523307883.git.digetx@gmail.com>
In-Reply-To: <cover.1523307883.git.digetx@gmail.com>
References: <cover.1523307883.git.digetx@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tegra's EHCI driver has a build dependency on Tegra's PHY driver and
currently Tegra's PHY driver is built only when Tegra's EHCI driver is
built. Add own Kconfig entry for the Tegra's PHY driver so that drivers
other than ehci-tegra (like ChipIdea UDC) could work with ehci-tegra
driver being disabled in kernels config by allowing user to manually
select the PHY driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/host/Kconfig | 4 +---
 drivers/usb/phy/Kconfig  | 9 +++++++++
 drivers/usb/phy/Makefile | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5d958da8e1bc..9f0aeb068acb 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -234,9 +234,7 @@ config USB_EHCI_TEGRA
        tristate "NVIDIA Tegra HCD support"
        depends on ARCH_TEGRA
        select USB_EHCI_ROOT_HUB_TT
-       select USB_PHY
-	select USB_ULPI
-	select USB_ULPI_VIEWPORT
+       select USB_TEGRA_PHY
        help
          This driver enables support for the internal USB Host Controllers
          found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 0f8ab981d572..b9b0a44be679 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -159,6 +159,15 @@ config USB_MXS_PHY
 
 	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
 
+config USB_TEGRA_PHY
+	tristate "NVIDIA Tegra USB PHY Driver"
+	depends on ARCH_TEGRA
+	select USB_PHY
+	select USB_ULPI
+	help
+	  This driver provides PHY support for the USB controllers found
+	  on NVIDIA Tegra SoC's.
+
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
 	depends on ARM || ARM64
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 25e579fb92b8..df1d99010079 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_AM335X_CONTROL_USB)	+= phy-am335x-control.o
 obj-$(CONFIG_AM335X_PHY_USB)		+= phy-am335x.o
 obj-$(CONFIG_OMAP_OTG)			+= phy-omap-otg.o
 obj-$(CONFIG_TWL6030_USB)		+= phy-twl6030-usb.o
-obj-$(CONFIG_USB_EHCI_TEGRA)		+= phy-tegra-usb.o
+obj-$(CONFIG_USB_TEGRA_PHY)		+= phy-tegra-usb.o
 obj-$(CONFIG_USB_GPIO_VBUS)		+= phy-gpio-vbus-usb.o
 obj-$(CONFIG_USB_ISP1301)		+= phy-isp1301.o
 obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
-- 
2.16.3

