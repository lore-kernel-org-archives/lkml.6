Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeE3Ve3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:34:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3Ve0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:34:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: tegra: select USB_COMMON
Date: Wed, 30 May 2018 23:33:50 +0200
Message-Id: <20180530213406.618544-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:119IMb4qLp4j3KVQNMwvpOLU2KgQaFGCO8x+SsiPG3mDu0heo/0
 VdPxu9s4HNUZfb6FZPmEbMtcIYu6hhIJXFe/CbezV4GiJ0SYbww2+1GlJtLadCz9VTj3Hom
 UUwtJIMIcY8VO5QGoXQM/dKtAcdnuRmUXRq9IKzbO584AliasuwACFDshA0nDTkBpO+VuLd
 kphOtnTc2p9cEAV0BKrSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hQLYyeoqy7Y=:lkTlnrh1rLuFWG2tNukPBE
 LLNOv6HeQegzeC9R42OHD2mbTNuen9KWrJtIyLesRSOKmat6485/2j/LTN73f68gImHLn6Soc
 K3zpXuHGmuk0DBOl9Is7p8BJLVRwVIswIzXZiKQZwSmVWP1AlucIb3J4+8Mg1h7HrRHaWG73y
 dxM6a8rRdIHzPkSKCykNXbQIrDSSLei7WE/fjWFyWZ2IKvSeQGYtyoG+tmOmPgF0w1/Q4+vKi
 UmbaWBz93teSP///Dq2hnMP5ovzRJ3gcIe0YKuk5dylTnWWzxvg+UH5ZmSIqAu5kmbL4lLfMP
 J77n7Jx09ikpkgh+EZrBWdA/F+5M/TEI/h2lYgFj8AS2+aWbbG7Ch+2JwiTFQzlRQ8qTeDtU8
 geJnp4VaTECULDklgMhlZaic0+Wmcuua33DSLsRsbNHS5PgwB0RYXo2Rv+jsQQiMwyd/fbwY0
 DXQZDVzZVQanKSrXIBCDAjf/gDD1dtHhvLz6gbwTnbTt392gl5C3D8ffiWjj9s5az84dYR7Ec
 LP1vGDxogVZUbOefw4PgvYoTAlfvvnkkqq0sPobjzc1ccBMz8bk+6eAy77FVOPq5CUD7d7452
 E4grnlvqS+6SadfoXTXfipu1rAQK30JuHocd2G08d1AvB4W+B61rzyJPNuxA4izagzog7701b
 fy1IF/5o13hBVp9xH2D9dIhFQTwJB4xHLrFwfTUdzP6uJV6gtT2m/O/+XnQPTB3RA0xM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A built-in PHY driver cannot link against modular USB core code:

drivers/usb/phy/phy-tegra-usb.o: In function `tegra_usb_phy_probe':
phy-tegra-usb.c:(.text+0x6bc): undefined reference to `usb_get_dr_mode'

This uses a 'select' statement in Kconfig like we have for other such
PHY drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index b9b0a44be679..d7312eed6088 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -162,6 +162,7 @@ config USB_MXS_PHY
 config USB_TEGRA_PHY
 	tristate "NVIDIA Tegra USB PHY Driver"
 	depends on ARCH_TEGRA
+	select USB_COMMON
 	select USB_PHY
 	select USB_ULPI
 	help
-- 
2.9.0
