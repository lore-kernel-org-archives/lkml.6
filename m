Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D21CECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EE721476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YyQwKvlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EE721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeIOEGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 00:06:51 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52472 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeIOEGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 00:06:51 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C053E10C0726;
        Fri, 14 Sep 2018 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536965421; bh=7Evyt2YeSVBlfLSLBrRyNWzGIm1a+npy5JD28JKwB7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyQwKvlmXzEm9hbcULGIKORe7aBzfK3ALVogpGY2CZ5KPl4bRmSYdW+KzsY1iWEne
         01d94N2CZxFD8oD5KKySM18bsOEm3SOcAxqYGoeRZaz8muq6VrXzH8Zy2yGG6rqaoJ
         633HuIc0o6mSrodOIEpzsIGP7HUhABE2ieiZPKYiggMTEFCbnbI5cEqrhGPmlD7FlB
         ULCOiLuy1ry3H/Y0/72ZeTG4BHTkRMrikjuGq7HXpDSVtNFwxPLOWjBbQrptl6uJ4L
         anGaaLG1Rf7LiNddHhLgP4IVxjTpEs67XygKIbJM3MEJ7DwsVckBcJu1WleFWkn0I0
         nn2RpBZCLR6kg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 567E63DA3;
        Fri, 14 Sep 2018 15:50:19 -0700 (PDT)
Received: from de02dwemt291.internal.synopsys.com (de02dwemt291.internal.synopsys.com [10.225.18.65])
        by de02.synopsys.com (Postfix) with ESMTP id 879463EF4C;
        Sat, 15 Sep 2018 00:50:18 +0200 (CEST)
Received: from de02dwemt291.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt291.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w8EMoI0K027348;
        Sat, 15 Sep 2018 00:50:18 +0200
Received: (from lolivei@localhost)
        by de02dwemt291.internal.synopsys.com (8.14.4/8.14.4/Submit) id w8EMoHC3027347;
        Sat, 15 Sep 2018 00:50:17 +0200
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     all-jpinto-org-pt02@synopsys.com,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 1/5] media: platform: Add DesignWare MIPI CSI2 Host placeholder
Date:   Sat, 15 Sep 2018 00:48:37 +0200
Message-Id: <20180914224849.27173-2-lolivei@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180914224849.27173-1-lolivei@synopsys.com>
References: <20180914224849.27173-1-lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has the intention of make the patchseries more clear by creating
a dwc folder and a Kconfig variable that sets dependencies.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
 drivers/media/platform/Kconfig     |  1 +
 drivers/media/platform/Makefile    |  3 +++
 drivers/media/platform/dwc/Kconfig | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 drivers/media/platform/dwc/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f627587..f627a27 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -137,6 +137,7 @@ source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 source "drivers/media/platform/rcar-vin/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
+source "drivers/media/platform/dwc/Kconfig"
 
 config VIDEO_TI_CAL
 	tristate "TI CAL (Camera Adaptation Layer) driver"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 6ab6200..def2f33 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -98,3 +98,6 @@ obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 obj-y					+= meson/
 
 obj-y					+= cros-ec-cec/
+
+obj-y					+= dwc/
+
diff --git a/drivers/media/platform/dwc/Kconfig b/drivers/media/platform/dwc/Kconfig
new file mode 100644
index 0000000..6b1e985
--- /dev/null
+++ b/drivers/media/platform/dwc/Kconfig
@@ -0,0 +1,19 @@
+#
+#  Synopsys DWC Platform drivers
+#	Most drivers here are currently for MIPI CSI-2 and MIPI DPHY support
+
+config DWC_MIPI_CSI2_HOST
+	bool "Synopsys Designware CSI-2 Host Controller and DPHY-RX support"
+	select VIDEO_DEV
+	select VIDEO_V4L2
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_VMALLOC
+	select VIDEOBUF2_DMA_CONTIG
+	select GENERIC_PHY
+	select VIDEO_OV5647
+	help
+   	 This selects the CSI-2 host controller support.
+	 If you have a controller with this interface, say Y
+
+	  If unsure, say N.
+
-- 
2.9.3

