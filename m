Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A147FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EFB2252B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju34Wl1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EFB2252B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbeKOIaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbeKOIav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:51 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD542252F;
        Wed, 14 Nov 2018 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234346;
        bh=NIGjxT8I3Juh8qNPvc9qDBPYlvypKuFzzw0hwHYYBYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ju34Wl1MDLQN71sWNnUzbItfP3mbVqM3RaGaiPRp4cnA+qzD+qGVmAXrcUkuOQLLJ
         XiQgXLhT5/45F8aP3wXPRInkA3w5wpwfuq6J2hPJ1h2N98gzoo8PtICs5J1CKVV9Nq
         e+Xaagp/4rQ11u1k4iL/9++OxO/J9x6JZRVwRepM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/27] i2c: omap: Enable for ARCH_K3
Date:   Wed, 14 Nov 2018 17:25:06 -0500
Message-Id: <20181114222520.99926-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]

Allow I2C_OMAP to be built for K3 platforms.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 45a3f3ca29b3..75ea367ffd83 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -759,7 +759,7 @@ config I2C_OCORES
 
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || ARCH_K3
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.17.1

