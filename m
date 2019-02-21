Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E942086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfBUKhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:37:45 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59548 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfBUKho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:37:44 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B426C1A01C6;
        Thu, 21 Feb 2019 11:37:42 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A7EAA1A015E;
        Thu, 21 Feb 2019 11:37:42 +0100 (CET)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 58621205C6;
        Thu, 21 Feb 2019 11:37:42 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
Date:   Thu, 21 Feb 2019 12:37:31 +0200
Message-Id: <20190221103731.28978-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The export of fsl_guts_get_svr() is a left-over, it's currently used
only internally and users needing SoC information should use the generic
soc_device infrastructure.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/soc/fsl/guts.c   | 3 +--
 include/linux/fsl/guts.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 4f9655087bd7..63f6df86f9e5 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -115,7 +115,7 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	return NULL;
 }
 
-u32 fsl_guts_get_svr(void)
+static u32 fsl_guts_get_svr(void)
 {
 	u32 svr = 0;
 
@@ -129,7 +129,6 @@ u32 fsl_guts_get_svr(void)
 
 	return svr;
 }
-EXPORT_SYMBOL(fsl_guts_get_svr);
 
 static int fsl_guts_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index 941b11811f85..1fc0edd71c52 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -135,8 +135,6 @@ struct ccsr_guts {
 	u32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
-u32 fsl_guts_get_svr(void);
-
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
 
-- 
2.16.2

