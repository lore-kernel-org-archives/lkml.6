Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF1AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193342170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193342170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeI1PGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:06:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50830 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbeI1PGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:06:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 069081A0104;
        Fri, 28 Sep 2018 10:43:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EEE091A00F4;
        Fri, 28 Sep 2018 10:43:40 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7ED362064C;
        Fri, 28 Sep 2018 10:43:40 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH v2 3/5] soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
Date:   Fri, 28 Sep 2018 11:43:22 +0300
Message-Id: <1538124204-31406-4-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Pledge <roy.pledge@nxp.com>

The QBMan block is memory mapped on SoCs above a 32 bit (4 Gigabyte)
boundary so enabling 64 bit DMA addressing is needed for QBMan to
be usuable.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
index d570cb5fd381..b0943e541796 100644
--- a/drivers/soc/fsl/qbman/Kconfig
+++ b/drivers/soc/fsl/qbman/Kconfig
@@ -1,6 +1,6 @@
 menuconfig FSL_DPAA
 	bool "QorIQ DPAA1 framework support"
-	depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
+	depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE) && ARCH_DMA_ADDR_T_64BIT)
 	select GENERIC_ALLOCATOR
 	help
 	  The Freescale Data Path Acceleration Architecture (DPAA) is a set of
-- 
2.1.0

