Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411289-2-17851233831306570343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411288; b=SjyFgUc7djVYe1WS7sej45slTjZdtYfP/c3jMXbIwkrh6zi
    3QTfreJo14xfqj9XC3zmM6h7yCGULvKEaUjkSb9QMulHdYiTOmwfB+2aHcf26NPc
    VgXILQ+5dXFHZsLnuD4SjbUf3urjn+gdiUfIiyJCVgogcdvQ4fiBtaWRSXchJjLD
    UMh+JECGmw3YaOrVL/+tuOCSYiv812/u+x/uZcxQK0lP8KcSK5Bbr6CgMThPwQNr
    3wkdXnT/ZXJBqDcYtVPV4GXyZ227oZdb6olr22unbkcpGIAddaFeFuR8+BqTqq0g
    Qof0wAAwh6d0iOwLrxta5wIfWq90wXcuIPRWk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411288; bh=ue+G4iWfBDMFPltDeXyDWiHMMz
    onP85mEMtcNyZckAA=; b=wnP1OpP5UGNKOdiASlFpH6PdIb2fM6HRM9n77SLGAy
    M0LiEZEi/hEijoNIHOg8SoQOvWRfvwjmATMnDC1KXE9CbL5RX8b58xysNfHmnfsT
    yXBCYZG67jSfSitNsHRbY4SxDnccsTOAp0uSzlyrm2jUrw5uuCDy3V/I1mz54iqt
    s/VlkznUP4DVtoshHBEsa3/mvk533Zb76Mj1I6lJJstoarrz7pWE7GAUhncxzcKA
    JpAeA3KhQ5XyvR/vNQOsMq+j5I7kWb7jdKMjN7QFQLtbVMFr1Ijd0fd+pR4Z72kv
    z9fqfNNa4XuDfNwaJLXP8IQJCxMqwf2asyxiNgRHjxVw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932800AbeBWSl0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:41:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932819AbeBWSlX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:41:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.4 156/193] ARM: tegra: select USB_ULPI from EHCI rather than platform
Date: Fri, 23 Feb 2018 19:26:29 +0100
Message-Id: <20180223170350.375917652@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit a262e87ff354f12447bb6268bd63edf7ba1c20e0 upstream.

For historic reasons, the tegra platform selects USB_ULPI from architecture
code, but that hasn't really made sense for a long time, as the only
user of that code is the Tegra EHCI driver that has its own Kconfig
symbol.

This removes the 'select' statements from mach-tegra and drivers/soc/tegra
and adds them with the device driver that actually needs them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
[arnd: rebased to 4.4-stable]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-tegra/Kconfig  |    2 --
 arch/arm64/Kconfig.platforms |    2 --
 drivers/usb/host/Kconfig     |    2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -12,8 +12,6 @@ menuconfig ARCH_TEGRA
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
 	help
 	  This enables support for NVIDIA Tegra based systems.
 
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -90,8 +90,6 @@ config ARCH_TEGRA_132_SOC
 	bool "NVIDIA Tegra132 SoC"
 	depends on ARCH_TEGRA
 	select PINCTRL_TEGRA124
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
 	help
 	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
 	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -220,6 +220,8 @@ config USB_EHCI_TEGRA
        depends on ARCH_TEGRA
        select USB_EHCI_ROOT_HUB_TT
        select USB_PHY
+	select USB_ULPI
+	select USB_ULPI_VIEWPORT
        help
          This driver enables support for the internal USB Host Controllers
          found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
