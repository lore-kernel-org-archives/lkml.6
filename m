Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B77C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B88215EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B88215EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeHNAFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:05:18 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47146 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:05:18 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Ma9tP-1fbEhV0Kzv-00Ln7c; Mon, 13 Aug 2018 23:21:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: revert "fix TODO to compile spi and sdio components in single module"
Date:   Mon, 13 Aug 2018 23:20:33 +0200
Message-Id: <20180813212108.2442868-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:MH2nlDB8Nr5wY/uPrpJDBt9tMAeQ8rQWBad/4/g9Pi4FeoXNQXP
 uWHpVB+9nG7p3k9Y5mqFWPVbe5WRv8FRcq1yIQ4v6swLFyp5d2clKBhJ+wcHGSNcKWh8jaH
 qJrBjMzg0BbvLGiFySrT5/quAe2CJtflzmtMGArTTknezjH45zkVq4AheTH+i6QJS+3dfEr
 tn3cT1OkTWByjMwhCUVHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/980x5dbf3Q=:Pk51ZQiggwkL5p24pMXeZ/
 JSlG0CGebAI8IYkevbsnJydRbFiEOYCdqHtnx8NwQmEQth3uYptjjrk9CUH9nFPpHBEracOXJ
 eBmjDb8YoTYvmSzLNDgn5huBszrcvprVkKmeUf1Pmw33TbVUii9d/ELx+TCGHqVmSSVLWpTv9
 qUmgEU1M/rwdIvt/EccPKeS/GsyXUS74F2RyLK7sysEPXoGZqGxhfRap6P+o+GdAZ3gl8lHhQ
 oO/ALsUIW6IuCvRZRC1JeldVSFVQ0RJlb0ey84ufiyw+CBu8VKhFjLP3b5/ax3EDrN6ycuZJ7
 itDjKEsDTN26eAnEPxDydNLRAQ/9YbfM706M7723QLTZthbh7s4B8FXI43qlk5K8SBQLNDHhr
 95PDpzB25ZevOYQStgdSu52ElRkBJu8yivKHEfH/CEuuNs10UXyMZy9BLaz9wq2cCF0QV5lYD
 +fb3irWXC17qTPy/HEWx3LryoClSmnO4URwpqhSp5/4DW2NKnMrak8Hfc0ji7r6FUB0GdADVN
 UBxoCE3ndCvXBPvSYuHLJQis2x9/qlrJkgpjS6Ip6vq3keWO1PN7JKp0lwlnoUG8TP49bSRle
 Airm+U2avmzWb+ZNbuqBpeOlz5cWgcpteoW1oQ1QFRhrHOmHqh/PhygfSM5HPGgzpyfGgnbxT
 jav14z+flHB65lI4d1knlGXZRnmK31ZCCxXU0++biN/tkhOeSJzMZzQmb7MS818qqBv0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TODO item named "make spi and sdio components coexist in one build"
was apparently addressed a long time ago, but never removed from the
TODO file. However, the new patch that tries to address it actually
makes it worse again by duplicating the common parts of the driver into
two separate modules rather than sharing them. This also introduces a
build regression when one of the two is built-in while the other is a
loadable module:

drivers/staging/wilc1000/wilc_debugfs.o:(.data+0x10): undefined reference to `__this_module'

Reverting the patch makes it build again. I'm leaving the TODO file
modification though, as there is nothing left to do for this item.

A related problem however still seems to exist: one still cannot have
multiple concurrent instances of wilc1000 devices present in the
system, as there are lots of shared global variables such as

host_interface.c:static struct wilc_vif *periodic_rssi_vif;
wilc_sdio.c:static struct wilc_sdio g_sdio;
wilc_wlan.c:static enum chip_ps_states chip_ps_state = CHIP_WAKEDUP;
wilc_wlan.c:static u32 pending_acks;
wilc_wfi_cfgoperations.c:int wilc_connecting;

In order to have multiple instances working (sdio, spi, or mixed),
all such variables need to be dynamically allocated per instance and
stored in 'struct wilc' or one of the structures referenced by it.

Fixes: 9abc44ba4e2f ("staging: wilc1000: fix TODO to compile spi and sdio components in single module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/wilc1000/Makefile       | 3 +--
 drivers/staging/wilc1000/linux_wlan.c   | 6 ++++--
 drivers/staging/wilc1000/wilc_debugfs.c | 7 +++++--
 drivers/staging/wilc1000/wilc_wlan.c    | 6 ++++++
 drivers/staging/wilc1000/wilc_wlan_if.h | 2 --
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/wilc1000/Makefile b/drivers/staging/wilc1000/Makefile
index f7b07c0b5ce2..ee7e26b886a5 100644
--- a/drivers/staging/wilc1000/Makefile
+++ b/drivers/staging/wilc1000/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_WILC1000) += wilc1000.o
 
 ccflags-y += -DFIRMWARE_1002=\"atmel/wilc1002_firmware.bin\" \
 		-DFIRMWARE_1003=\"atmel/wilc1003_firmware.bin\"
@@ -11,9 +12,7 @@ wilc1000-objs := wilc_wfi_cfgoperations.o linux_wlan.o linux_mon.o \
 			wilc_wlan.o
 
 obj-$(CONFIG_WILC1000_SDIO) += wilc1000-sdio.o
-wilc1000-sdio-objs += $(wilc1000-objs)
 wilc1000-sdio-objs += wilc_sdio.o
 
 obj-$(CONFIG_WILC1000_SPI) += wilc1000-spi.o
-wilc1000-spi-objs += $(wilc1000-objs)
 wilc1000-spi-objs += wilc_spi.o
diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index 01cf4bd2e192..3b8d237decbf 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -1038,8 +1038,8 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 	}
 
 	kfree(wilc);
-	wilc_debugfs_remove();
 }
+EXPORT_SYMBOL_GPL(wilc_netdev_cleanup);
 
 static const struct net_device_ops wilc_netdev_ops = {
 	.ndo_init = mac_init_fn,
@@ -1062,7 +1062,6 @@ int wilc_netdev_init(struct wilc **wilc, struct device *dev, int io_type,
 	if (!wl)
 		return -ENOMEM;
 
-	wilc_debugfs_init();
 	*wilc = wl;
 	wl->io_type = io_type;
 	wl->hif_func = ops;
@@ -1124,3 +1123,6 @@ int wilc_netdev_init(struct wilc **wilc, struct device *dev, int io_type,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(wilc_netdev_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/wilc1000/wilc_debugfs.c b/drivers/staging/wilc1000/wilc_debugfs.c
index edc72876458d..8001df66b8c2 100644
--- a/drivers/staging/wilc1000/wilc_debugfs.c
+++ b/drivers/staging/wilc1000/wilc_debugfs.c
@@ -19,6 +19,7 @@ static struct dentry *wilc_dir;
 
 #define DBG_LEVEL_ALL	(DEBUG | INFO | WRN | ERR)
 static atomic_t WILC_DEBUG_LEVEL = ATOMIC_INIT(ERR);
+EXPORT_SYMBOL_GPL(WILC_DEBUG_LEVEL);
 
 static ssize_t wilc_debug_level_read(struct file *file, char __user *userbuf,
 				     size_t count, loff_t *ppos)
@@ -87,7 +88,7 @@ static struct wilc_debugfs_info_t debugfs_info[] = {
 	},
 };
 
-int wilc_debugfs_init(void)
+static int __init wilc_debugfs_init(void)
 {
 	int i;
 	struct wilc_debugfs_info_t *info;
@@ -103,10 +104,12 @@ int wilc_debugfs_init(void)
 	}
 	return 0;
 }
+module_init(wilc_debugfs_init);
 
-void wilc_debugfs_remove(void)
+static void __exit wilc_debugfs_remove(void)
 {
 	debugfs_remove_recursive(wilc_dir);
 }
+module_exit(wilc_debugfs_remove);
 
 #endif
diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc1000/wilc_wlan.c
index 6787b6e9f124..8b184aa30d25 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -417,6 +417,7 @@ void chip_allow_sleep(struct wilc *wilc)
 	wilc->hif_func->hif_write_reg(wilc, 0xf0, reg & ~BIT(0));
 	wilc->hif_func->hif_write_reg(wilc, 0xfa, 0);
 }
+EXPORT_SYMBOL_GPL(chip_allow_sleep);
 
 void chip_wakeup(struct wilc *wilc)
 {
@@ -471,6 +472,7 @@ void chip_wakeup(struct wilc *wilc)
 	}
 	chip_ps_state = CHIP_WAKEDUP;
 }
+EXPORT_SYMBOL_GPL(chip_wakeup);
 
 void wilc_chip_sleep_manually(struct wilc *wilc)
 {
@@ -484,6 +486,7 @@ void wilc_chip_sleep_manually(struct wilc *wilc)
 	chip_ps_state = CHIP_SLEEPING_MANUAL;
 	release_bus(wilc, RELEASE_ONLY);
 }
+EXPORT_SYMBOL_GPL(wilc_chip_sleep_manually);
 
 void host_wakeup_notify(struct wilc *wilc)
 {
@@ -491,6 +494,7 @@ void host_wakeup_notify(struct wilc *wilc)
 	wilc->hif_func->hif_write_reg(wilc, 0x10b0, 1);
 	release_bus(wilc, RELEASE_ONLY);
 }
+EXPORT_SYMBOL_GPL(host_wakeup_notify);
 
 void host_sleep_notify(struct wilc *wilc)
 {
@@ -498,6 +502,7 @@ void host_sleep_notify(struct wilc *wilc)
 	wilc->hif_func->hif_write_reg(wilc, 0x10ac, 1);
 	release_bus(wilc, RELEASE_ONLY);
 }
+EXPORT_SYMBOL_GPL(host_sleep_notify);
 
 int wilc_wlan_handle_txq(struct net_device *dev, u32 *txq_count)
 {
@@ -871,6 +876,7 @@ void wilc_handle_isr(struct wilc *wilc)
 
 	release_bus(wilc, RELEASE_ALLOW_SLEEP);
 }
+EXPORT_SYMBOL_GPL(wilc_handle_isr);
 
 int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size)
diff --git a/drivers/staging/wilc1000/wilc_wlan_if.h b/drivers/staging/wilc1000/wilc_wlan_if.h
index 00d13b153f80..b81a73b9bd67 100644
--- a/drivers/staging/wilc1000/wilc_wlan_if.h
+++ b/drivers/staging/wilc1000/wilc_wlan_if.h
@@ -831,6 +831,4 @@ struct wilc;
 int wilc_wlan_init(struct net_device *dev);
 u32 wilc_get_chipid(struct wilc *wilc, bool update);
 
-int wilc_debugfs_init(void);
-void wilc_debugfs_remove(void);
 #endif
-- 
2.18.0

