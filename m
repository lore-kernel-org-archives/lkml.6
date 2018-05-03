Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeECJgw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:36:52 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.176]:22568 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeECJgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:36:45 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0Nfyq4sHQ=="
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Johan Hovold <johan@kernel.org>, afd@ti.com,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 6/6] gnss: add w2sg0004 to Kconfig
Date: Thu,  3 May 2018 11:35:51 +0200
Message-Id: <7035d90fb71c4bc9d2e7c1090b77bdd6bdfd9871.1525340143.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to configure for w2sg0004 driver.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gnss/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 6abc88514512..ccc128bd0a3f 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -40,4 +40,14 @@ config GNSS_UBX_SERIAL
 
 	  If unsure, say N.
 
+config GNSS_W2SG0004
+	tristate "W2SG00x4 power on/off driver"
+	depends on GPIOLIB && SERIAL_DEV_BUS
+	help
+	  Enable on/off control of W2SG00x4 GPS module connected
+	  to some SoC UART to allow powering up/down if the /dev/gnss
+	  is opened/closed.
+
+	  It also provides a "rfkill gps" name to control the LNA power.
+
 endif # GNSS
-- 
2.12.2
