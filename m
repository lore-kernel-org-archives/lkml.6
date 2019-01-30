Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8348AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E1120870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RtCcN3Sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfA3CxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:53:01 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37479 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfA3CxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:53:01 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x0U2qeQ1006032;
        Wed, 30 Jan 2019 11:52:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x0U2qeQ1006032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548816760;
        bh=Fsl0b9ILMorAgdpOupfUdtF7TOBg5LutAIvosXM0TfE=;
        h=From:To:Cc:Subject:Date:From;
        b=RtCcN3SlPlJRluJqWPGcPangiGjkdZjNVZ35ONETuvfSlKDYDYVut2y0rkzUj4i+G
         J91vJqKNGRtHUlJ8O2qkj4z/Ixnpbyu2BwNSIInCFbmpzDEIjg+CrADJ7pDeDJneOp
         jENogke4txqRXvV8e+vOaBVa6hv+vaTPeAuSbpGAbrH/+IdB6Sot3Pw8bhvrVH3txU
         dwv8vXcJt/g7RH/kNpkHmh9bPqclcUATLzsLtWRkMCooY1RFVNKczu+JddBuee9f1+
         xJRr8tsY1B7MELub5t22OquT3uCe7Lbhb30qrSbCllENTIjPDfJmCNgTRl/TLaEHH6
         M2y/WdgtPAZeg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH] vfio: platform: reset: fix up include directives to remove ccflags-y
Date:   Wed, 30 Jan 2019 11:52:31 +0900
Message-Id: <1548816751-32068-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the include directive with double-quotes "", the preprocessor
searches the header in the relative path to the current file.

Fix them up, and remove the header search path option.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/vfio/platform/reset/Makefile                     | 2 --
 drivers/vfio/platform/reset/vfio_platform_amdxgbe.c      | 2 +-
 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c    | 2 +-
 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
index 57abd4f..7294c5e 100644
--- a/drivers/vfio/platform/reset/Makefile
+++ b/drivers/vfio/platform/reset/Makefile
@@ -2,8 +2,6 @@
 vfio-platform-calxedaxgmac-y := vfio_platform_calxedaxgmac.o
 vfio-platform-amdxgbe-y := vfio_platform_amdxgbe.o
 
-ccflags-y += -Idrivers/vfio/platform
-
 obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
 obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
 obj-$(CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET) += vfio_platform_bcmflexrm.o
diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
index bcd419c..3ddb270 100644
--- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
+++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
@@ -25,7 +25,7 @@
 #include <uapi/linux/mdio.h>
 #include <linux/delay.h>
 
-#include "vfio_platform_private.h"
+#include "../vfio_platform_private.h"
 
 #define DMA_MR			0x3000
 #define MAC_VR			0x0110
diff --git a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
index d45c3be..16165a6 100644
--- a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
+++ b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
@@ -23,7 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-#include "vfio_platform_private.h"
+#include "../vfio_platform_private.h"
 
 /* FlexRM configuration */
 #define RING_REGS_SIZE					0x10000
diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
index 49e5df6..e0356de 100644
--- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
+++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
@@ -24,7 +24,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 
-#include "vfio_platform_private.h"
+#include "../vfio_platform_private.h"
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
-- 
2.7.4

