Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELuTQJuxp/VxJNVgBYpdrfZWYTdLE0PcrotxlNxaKD6rSya1ofMBSkc41iQ1wfo1h9u4Nazk
ARC-Seal: i=1; a=rsa-sha256; t=1521059062; cv=none;
        d=google.com; s=arc-20160816;
        b=q9DIoB4RIsieYXYQEsBo5ZYlyqqqwsBwiK6hQ0+eiJ9hDQlwigbwTGb6ZAk1TvILvE
         LWW4hr1xY8qZ2pAEDudy1Xyfu7RvnZId31vZ6HDmeKNflyDmL/xLKmsCrsnKFGVlB8Nm
         GibBtYnQ81CFrkNFvFuE/6zyTyWKWBVZbFfrV7OwlNd989MzUFnTCi0NKxyqexkdg0fF
         DrQAo/kKA6xiSys00Aj0QT/+q6Cv0fEnvLcyfIrH92TKEfeGicoOOGKSNL/XlKoNO0Qy
         k3tlz4hJCpx31p0DpkI+Us7neZx2gJOKWYKnGnMEsPmdrBnEUgMIfr0m0sRWhhHHECUW
         aUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=CUb6FeSS/ixkWajAv11GdldFhkSDyxSVZHCRuACRI74=;
        b=YwiACJBjgtqy492tb5egDzvmmlwl4INoHGLowhLZ3d7VOz7sElP+gCTRyDgbLHPHq1
         hlnsbgRIIEHyumioIDxhrviM+LgX84RwuK5lKcLW0tD3wXWbheSXjM33CQqYgmbvIqvs
         y9mYZmyjUUhGjOYK2upxCN0tmmFV9pdy4RwYMxTI8EQBIzJC+el6HLNo4Eby0S9PpnmK
         M4PzXsgAS/K9QyA/rKg8Bw/ygN6ss1F3MCTpTFHgmQV9ND6HPUKbfRq/RcLjR3VNMfWc
         4HluG+2ldqC0XW4vqN77j/bV/QXkTLnJzzKeYaxZTi6qY7RXBCPRIPlIzK5Vnnem4LNd
         TE+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:36 +1100
Subject: [PATCH 12/13] staging: mt7621-eth: mediatek: add Kconfig and
 Makefile
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895639.22262.4809012060622510853.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594946027996469388?=
X-GMAIL-MSGID: =?utf-8?q?1594946027996469388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Crispin <blogic@openwrt.org>

This patch adds the Makefile and Kconfig required to make the driver build.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/Kconfig             |    2 ++
 drivers/staging/Makefile            |    1 +
 drivers/staging/mt7621-eth/Kconfig  |   39 +++++++++++++++++++++++++++++++++++
 drivers/staging/mt7621-eth/Makefile |   14 +++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 drivers/staging/mt7621-eth/Kconfig
 create mode 100644 drivers/staging/mt7621-eth/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 4c872bf7c280..d9cddad71da2 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -132,4 +132,6 @@ source "drivers/staging/mt7621-dma/Kconfig"
 
 source "drivers/staging/mt7621-mmc/Kconfig"
 
+source "drivers/staging/mt7621-eth/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 8ce10da1ab1d..2a7defcd6836 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-gpio/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-spi/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
+obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
diff --git a/drivers/staging/mt7621-eth/Kconfig b/drivers/staging/mt7621-eth/Kconfig
new file mode 100644
index 000000000000..44ea86c7a96c
--- /dev/null
+++ b/drivers/staging/mt7621-eth/Kconfig
@@ -0,0 +1,39 @@
+config NET_VENDOR_MEDIATEK_STAGING
+	bool "MediaTek ethernet driver - staging version"
+	depends on RALINK
+	---help---
+	  If you have an MT7621 Mediatek SoC with ethernet, say Y.
+
+if NET_VENDOR_MEDIATEK_STAGING
+choice
+	prompt "MAC type"
+
+config NET_MEDIATEK_MT7621
+	bool "MT7621"
+	depends on MIPS && SOC_MT7621
+
+endchoice
+
+config NET_MEDIATEK_SOC_STAGING
+	tristate "MediaTek SoC Gigabit Ethernet support"
+	depends on NET_VENDOR_MEDIATEK_STAGING
+	select PHYLIB
+	---help---
+	  This driver supports the gigabit ethernet MACs in the
+	  MediaTek SoC family.
+
+config NET_MEDIATEK_MDIO
+	def_bool NET_MEDIATEK_SOC_STAGING
+	depends on NET_MEDIATEK_MT7621
+	select PHYLIB
+
+config NET_MEDIATEK_MDIO_MT7620
+	def_bool NET_MEDIATEK_SOC_STAGING
+	depends on NET_MEDIATEK_MT7621
+	select NET_MEDIATEK_MDIO
+
+config NET_MEDIATEK_GSW_MT7621
+	def_tristate NET_MEDIATEK_SOC_STAGING
+	depends on NET_MEDIATEK_MT7621
+
+endif #NET_VENDOR_MEDIATEK_STAGING
diff --git a/drivers/staging/mt7621-eth/Makefile b/drivers/staging/mt7621-eth/Makefile
new file mode 100644
index 000000000000..018bcc3596b3
--- /dev/null
+++ b/drivers/staging/mt7621-eth/Makefile
@@ -0,0 +1,14 @@
+#
+# Makefile for the Ralink SoCs built-in ethernet macs
+#
+
+mtk-eth-soc-y					+= mtk_eth_soc.o ethtool.o
+
+mtk-eth-soc-$(CONFIG_NET_MEDIATEK_MDIO)		+= mdio.o
+mtk-eth-soc-$(CONFIG_NET_MEDIATEK_MDIO_MT7620)	+= mdio_mt7620.o
+
+mtk-eth-soc-$(CONFIG_NET_MEDIATEK_MT7621)	+= soc_mt7621.o
+
+obj-$(CONFIG_NET_MEDIATEK_GSW_MT7621)		+= gsw_mt7621.o
+
+obj-$(CONFIG_NET_MEDIATEK_SOC_STAGING)		+= mtk-eth-soc.o
