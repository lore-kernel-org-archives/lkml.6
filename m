Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44751C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DED20891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DED20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbeGZNlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:41:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729801AbeGZNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:41:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0AC4EB3A1291F;
        Thu, 26 Jul 2018 20:25:10 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:25:04 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 08/25] staging: erofs: update Kconfig and Makefile
Date:   Thu, 26 Jul 2018 20:21:51 +0800
Message-ID: <1532607728-103372-9-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds Makefile and Kconfig for erofs, and
updates Makefile and Kconfig files in the fs directory.

Signed-off-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/Kconfig        |  2 ++
 drivers/staging/Makefile       |  1 +
 drivers/staging/erofs/Kconfig  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/staging/erofs/Makefile | 11 +++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 drivers/staging/erofs/Kconfig
 create mode 100644 drivers/staging/erofs/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 75a4804..de9c95a 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -126,4 +126,6 @@ source "drivers/staging/mt7621-eth/Kconfig"
 
 source "drivers/staging/mt7621-dts/Kconfig"
 
+source "drivers/staging/erofs/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e84959a..a33ac34 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
+obj-$(CONFIG_EROFS_FS)		+= erofs/
diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
new file mode 100644
index 0000000..077430f
--- /dev/null
+++ b/drivers/staging/erofs/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config EROFS_FS
+	tristate "EROFS filesystem support"
+	depends on BLOCK
+	help
+	  EROFS(Enhanced Read-Only File System) is a lightweight
+	  read-only file system with modern designs (eg. page-sized
+	  blocks, inline xattrs/data, etc.) for scenarios which need
+	  high-performance read-only requirements, eg. firmwares in
+	  mobile phone or LIVECDs.
+
+	  It also provides VLE compression support, focusing on
+	  random read improvements, keeping relatively lower
+	  compression ratios, which is useful for high-performance
+	  devices with limited memory and ROM space.
+
+	  If unsure, say N.
+
+config EROFS_FS_DEBUG
+	bool "EROFS debugging feature"
+	depends on EROFS_FS
+	help
+	  Print EROFS debugging messages and enable more BUG_ONs
+	  which check the filesystem consistency aggressively.
+
+	  For daily use, say N.
+
+config EROFS_FS_USE_VM_MAP_RAM
+	bool "EROFS VM_MAP_RAM Support"
+	depends on EROFS_FS
+	help
+	  use vm_map_ram/vm_unmap_ram instead of vmap/vunmap.
+
+	  If you don't know what these are, say N.
+
diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
new file mode 100644
index 0000000..31e909e
--- /dev/null
+++ b/drivers/staging/erofs/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+EROFS_VERSION = "1.0pre1"
+
+ccflags-y += -Wall -DEROFS_VERSION=\"$(EROFS_VERSION)\"
+
+obj-$(CONFIG_EROFS_FS) += erofs.o
+# staging requirement: to be self-contained in its own directory
+ccflags-y += -I$(src)/include
+erofs-objs := super.o inode.o data.o namei.o dir.o
+
-- 
1.9.1

