Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1289ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828022089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsunix.de header.i=@tsunix.de header.b="rLLlJrmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828022089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=tsunix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeGNW4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:56:08 -0400
Received: from mail.tsunix.de ([45.77.140.229]:44871 "EHLO mail.tsunix.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731552AbeGNW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:56:06 -0400
Received: from railgun.de (i59F5AC05.versanet.de [89.245.172.5])
        by mail.tsunix.de (Postfix) with ESMTPSA id 9ECF93EDBE;
        Sun, 15 Jul 2018 00:26:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tsunix.de 9ECF93EDBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsunix.de;
        s=default; t=1531607201;
        bh=9xRvQd32PRPkjLbOUHcA1pxjAc7oHdeCdQgoPReHOhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLLlJrmf+DR+DQUoDrpb8LQsT1npR6mqOkVSqQJaziJEADhQ4BD9oyoTmjcq+GInB
         mPqek9XynW9WnNSDvBoLnyigbIs4mByDMEkUmLX0SnRPAFOk9RAW/ipPxg3LJJASeu
         U06cN8brs/ejQBjljcz7kcus3L8wXOoOv6e5SaBc=
From:   Cristian Kubis <cristian.kubis@tsunix.de>
Cc:     jfrederich@gmail.com, dsd@laptop.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        cristian.kubis@tsunix.de
Subject: [PATCH 1/2] staging: olpc_dcon: prefer 'help' in KConfig
Date:   Sun, 15 Jul 2018 00:25:40 +0200
Message-Id: <20180714222541.2564-2-cristian.kubis@tsunix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714222541.2564-1-cristian.kubis@tsunix.de>
References: <20180714222541.2564-1-cristian.kubis@tsunix.de>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for a style warning reported by checkpatch.pl in KConfig
suggesting to use 'help' instead of '---help---'.

Signed-off-by: Cristian Kubis <cristian.kubis@tsunix.de>
---
 drivers/staging/olpc_dcon/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index d277f048789e..c91a56f77bcb 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -4,7 +4,7 @@ config FB_OLPC_DCON
 	depends on I2C
 	depends on (GPIO_CS5535 || GPIO_CS5535=n)
 	select BACKLIGHT_CLASS_DEVICE
-	---help---
+	help
 	  In order to support very low power operation, the XO laptop uses a
 	  secondary Display CONtroller, or DCON.  This secondary controller
 	  is present in the video pipeline between the primary display
@@ -18,7 +18,7 @@ config FB_OLPC_DCON_1
 	bool "OLPC XO-1 DCON support"
 	depends on FB_OLPC_DCON && GPIO_CS5535
 	default y
-	---help---
+	help
 	  Enable support for the DCON in XO-1 model laptops.  The kernel
 	  communicates with the DCON using model-specific code.  If you
 	  have an XO-1 (or if you're unsure what model you have), you should
@@ -28,7 +28,7 @@ config FB_OLPC_DCON_1_5
 	bool "OLPC XO-1.5 DCON support"
 	depends on FB_OLPC_DCON && ACPI
 	default y
-	---help---
+	help
 	  Enable support for the DCON in XO-1.5 model laptops.  The kernel
 	  communicates with the DCON using model-specific code.  If you
 	  have an XO-1.5 (or if you're unsure what model you have), you
-- 
2.18.0

