Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F8920879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD6NipjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfAKAoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:44:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39453 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfAKAoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:44:03 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so10823834iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDusDtLv8W+oa6BhZoeA2nrXqwOq8YUu0guCnx8pwcI=;
        b=cD6NipjEsJHXSeM3SRC0LHz2/W8cBscR8UHt9tLykwYkmP09u/idL6EFxxU4Lh7KGB
         AcOpE+BFlC194zDBEZ7kPQ5IY2VAlHee/6mKSqzacyNRx6kNV2wstsVbevw/AjWtnV7i
         puVuWIxaMXwvNNYTeR3TGqIwSKu4OJD0odVDY1zZDogaABKQ+XwL/BgsnWbc/iUfXj8q
         PMz3Z0KOTf1SeHlCWWmyEJQrKNBuXN+hsOqL4eElvjEgpDKSwlnzGc3LDWAROOsqChQp
         bqy7x13TCUEVB7cMrrmpRqHjnYxaa4gjpC1azlGIC7Ae7S6V21abRwIiWS7vkpRKHJvA
         uHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDusDtLv8W+oa6BhZoeA2nrXqwOq8YUu0guCnx8pwcI=;
        b=R2n3vHY9vJoNFtOCDJrX7YMDY0mph0GWt8OVQvKFnO5wRQVvmTrRTE9isMK8Dqnbj2
         mNfzw/pewhHxPuctCrMSiyQEHWdz+eDPIh6DyTc9YzslfbVKdEfubBLmHcK8kWaIsHGg
         WY82h9coGLjz/43ZQ1Zo/xhiDld9rQUllcAHHbt4Z236UUyPV6SQf3ksnztQK9mObylv
         uFVGfKIjeJVnalCMisomQibNWOxWHkspc7j8SjKrNOMaCKG4JF0tziDs1il/tUkuWdgU
         SdGo8u0ybVYE/NU6xkOW6QxsWmEBtbHieTYEbhYSXa7/S4r5Aj/gTRQRnHkJ5TIqeYcv
         tLhA==
X-Gm-Message-State: AJcUukcw3doH+IGD1ivOpU61mE3iBXT+9b/znCTe8+BBo3qIjSYuVpkA
        id8qG4nLJn0zrlFm8AF/sGw=
X-Google-Smtp-Source: ALg8bN7QY1JeV4lJXqUBY7VilfS5MkPNJZXDVEWqLgC98IsCE1OIupaO+L4hytvWtqLBdpAINmRkuQ==
X-Received: by 2002:a6b:38d7:: with SMTP id f206mr8096745ioa.265.1547167441841;
        Thu, 10 Jan 2019 16:44:01 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id t7sm31142310iom.27.2019.01.10.16.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 16:44:01 -0800 (PST)
From:   thirtythreeforty@gmail.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Neil Brown <neil@brown.name>
Subject: [PATCH v2 1/2] Move ralink-gdma to its own directory
Date:   Thu, 10 Jan 2019 17:43:36 -0700
Message-Id: <20190111004337.7223-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CACmrr9gHucWaWtz07kQms6AsquLKAHbK+_Q0kF=92RGo6HmAFA@mail.gmail.com>
References: <CACmrr9gHucWaWtz07kQms6AsquLKAHbK+_Q0kF=92RGo6HmAFA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Hilliard <thirtythreeforty@gmail.com>

This is in preparation to allow it and the mt7621-dma drivers to be
built separately.  They are completely independent pieces of software,
and the Kconfig specifies very different requirements.

Cc: linux-kernel@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Cc: Neil Brown <neil@brown.name>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/Kconfig                                   | 2 ++
 drivers/staging/Makefile                                  | 1 +
 drivers/staging/mt7621-dma/Kconfig                        | 6 ------
 drivers/staging/mt7621-dma/Makefile                       | 1 -
 drivers/staging/ralink-gdma/Kconfig                       | 6 ++++++
 drivers/staging/ralink-gdma/Makefile                      | 3 +++
 drivers/staging/{mt7621-dma => ralink-gdma}/ralink-gdma.c | 0
 7 files changed, 12 insertions(+), 7 deletions(-)
 create mode 100644 drivers/staging/ralink-gdma/Kconfig
 create mode 100644 drivers/staging/ralink-gdma/Makefile
 rename drivers/staging/{mt7621-dma => ralink-gdma}/ralink-gdma.c (100%)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index e4f608815c05..b4cfde38e856 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -110,6 +110,8 @@ source "drivers/staging/mt7621-spi/Kconfig"
 
 source "drivers/staging/mt7621-dma/Kconfig"
 
+source "drivers/staging/ralink-gdma/Kconfig"
+
 source "drivers/staging/mt7621-mmc/Kconfig"
 
 source "drivers/staging/mt7621-eth/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 5868631e8f1b..e095f427177c 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-pinctrl/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-spi/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
+obj-$(CONFIG_SOC_MT7621)	+= ralink-gdma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
diff --git a/drivers/staging/mt7621-dma/Kconfig b/drivers/staging/mt7621-dma/Kconfig
index 2423c40099d1..b6e48a682c44 100644
--- a/drivers/staging/mt7621-dma/Kconfig
+++ b/drivers/staging/mt7621-dma/Kconfig
@@ -1,9 +1,3 @@
-config DMA_RALINK
-	tristate "RALINK DMA support"
-	depends on RALINK && !SOC_RT288X
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-
 config MTK_HSDMA
 	tristate "MTK HSDMA support"
 	depends on RALINK && SOC_MT7621
diff --git a/drivers/staging/mt7621-dma/Makefile b/drivers/staging/mt7621-dma/Makefile
index d3152d45cf45..c9e3e1619ab0 100644
--- a/drivers/staging/mt7621-dma/Makefile
+++ b/drivers/staging/mt7621-dma/Makefile
@@ -1,4 +1,3 @@
-obj-$(CONFIG_DMA_RALINK) += ralink-gdma.o
 obj-$(CONFIG_MTK_HSDMA) += mtk-hsdma.o
 
 ccflags-y += -I$(srctree)/drivers/dma
diff --git a/drivers/staging/ralink-gdma/Kconfig b/drivers/staging/ralink-gdma/Kconfig
new file mode 100644
index 000000000000..a12b2c672d48
--- /dev/null
+++ b/drivers/staging/ralink-gdma/Kconfig
@@ -0,0 +1,6 @@
+config DMA_RALINK
+	tristate "RALINK DMA support"
+	depends on RALINK && !SOC_RT288X
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+
diff --git a/drivers/staging/ralink-gdma/Makefile b/drivers/staging/ralink-gdma/Makefile
new file mode 100644
index 000000000000..5d917e0729bb
--- /dev/null
+++ b/drivers/staging/ralink-gdma/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_DMA_RALINK) += ralink-gdma.o
+
+ccflags-y += -I$(srctree)/drivers/dma
diff --git a/drivers/staging/mt7621-dma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
similarity index 100%
rename from drivers/staging/mt7621-dma/ralink-gdma.c
rename to drivers/staging/ralink-gdma/ralink-gdma.c
-- 
2.20.1

