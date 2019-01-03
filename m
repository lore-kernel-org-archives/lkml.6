Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB00208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SZ3XB+RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfACOgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:36:37 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:50254 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfACOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:36:37 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 366345C0471;
        Thu,  3 Jan 2019 15:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546526195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Kt8C8T/txUtgcPdvCiXlfr+CtmaIZNTW1fwIY2FBNcM=;
        b=SZ3XB+RQw8x4qI7n6Iym7UHFqR9A8LoH42+5/nIpekvmeibMKsHgKKCxUb1OpUDFhhTdOx
        0gnR2OfOk0Z8e/b724Tj+aNqDVTNneWKgBVESorpTarGAc58FiEj/uZ9+bUGMpgwJmjqrs
        wKYjbKxsPngdsgLtjbVMPNvH2yFwXBU=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     arnd@arndb.de, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-imx@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: imx: don't build ssi-fiq if not required
Date:   Thu,  3 Jan 2019 15:36:31 +0100
Message-Id: <20190103143631.29284-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbols provided by ssi-fiq are used in sound/soc/fsl/imx-pcm-fiq.c
only. Build ssi-fiq.o/ssi-fiq-ksym.o only if SND_SOC_IMX_PCM_FIQ is
enabled.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bae179af21f6..12b05708832d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -31,7 +31,7 @@ obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
 
-ifdef CONFIG_SND_IMX_SOC
+ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
-- 
2.19.2

