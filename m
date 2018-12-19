Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7724AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512AE218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeLSKS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:18:57 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51614 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeLSKS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:18:57 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C47511A01CD;
        Wed, 19 Dec 2018 11:18:54 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B7AFC1A00F4;
        Wed, 19 Dec 2018 11:18:54 +0100 (CET)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AFFD20466;
        Wed, 19 Dec 2018 11:18:54 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Olof Johansson <olof@lixom.net>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: [PATCH] Revert "arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO"
Date:   Wed, 19 Dec 2018 12:18:44 +0200
Message-Id: <20181219101844.6362-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <2071995319.127120.1545163830046@email.ionos.de>
References: <2071995319.127120.1545163830046@email.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d9678adbe733a770428a98651beaa2817d503ed3.

Received below report from Stefan.
Revert the commit until CAAM driver dependency cycles are fixed.

this patch in next-20181214 breaks "make modules_install" for
arm64/defconfig on my Ubuntu machine:

DEPMOD  4.20.0-rc6-next-20181214
depmod: ERROR: Found 6 modules in dependency cycles!
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> authenc
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> fsl_mc_dpio
depmod: ERROR: Cycle detected: dpaa2_caam -> caamhash_desc -> dpaa2_caam
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> error
depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> caamalg_desc

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/arm64/configs/defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 989f51bb1bd4..d0724d4e0546 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -200,7 +200,6 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
-CONFIG_FSL_MC_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -644,7 +643,6 @@ CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
-CONFIG_FSL_MC_DPIO=m
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GENI_SE=y
 CONFIG_QCOM_GLINK_SSR=m
@@ -737,7 +735,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
-CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
-- 
2.16.2

