Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF991208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="mRgDsJG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF991208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeGLLJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:09:11 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57228 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeGLLJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:09:11 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 34C255C002A;
        Thu, 12 Jul 2018 12:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531393190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=0gAZItBeTE/PmbuexXXwMjyEm88CvnfZ5T72cmVZrmM=;
        b=mRgDsJG3rmSbHm10loreDzFi73MHzauwq8bdOoJVZCHifTsRai3HWNWkia2jbc51Xr08og
        Sg2Yi5WHXem7qKzw8J2VLEaRRal38PLRRpoWUfWiokfppMYVnYS9vEWw7J9lLs9UZJrS66
        a6dCUymG3wPRz4kyBBs/SRXohBrVM2Y=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, marek.vasut@gmail.com,
        fabio.estevam@nxp.com, leonard.crestez@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] ARM: mxs_defconfig: use MXSFB DRM driver
Date:   Thu, 12 Jul 2018 12:59:41 +0200
Message-Id: <20180712105942.25245-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the the DRM driver for MXSFB LCD controller (used in i.MX23/
i.MX28/i.MX6SX or i.MX7). Remove CONFIG_FB_MXS which will soon be
removed.

Note that this does not remove CONFIG_FB. CONFIG_FB gets selected
implicity by CONFIG_DRM/CONFIG_DRM_KMS_FB_HELPER.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/mxs_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index a508eb302e7a..148226e36152 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -94,8 +94,9 @@ CONFIG_STMP3XXX_RTC_WATCHDOG=y
 CONFIG_MFD_MXS_LRADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_FB=y
-CONFIG_FB_MXS=y
+CONFIG_DRM=y
+CONFIG_DRM_MXSFB=y
+CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-- 
2.18.0

