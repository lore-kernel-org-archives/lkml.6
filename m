Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85237C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4114222544
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5glXEt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4114222544
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbeKOIbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbeKOIbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:31:46 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10A622544;
        Wed, 14 Nov 2018 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234402;
        bh=cK+GwLBFuwK/QWb+dSXdmNviCYz0HpycgNdwY/ZKIC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5glXEt4fyorRObZuxZdI4cWuruomzj8HHF8cinhcCr7+fvdmxAwOqUphh2CwpcXv
         GHNE+dBgVbeVx85y4TfirFAgr90trm8eZMU2nLHAgWahBbGsw051JryikbzdFJRpej
         kUPJnyrOKHQhix9xGVYr7fCC+nb36iPtB9bn84sg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 3/3] i2c: omap: Enable for ARCH_K3
Date:   Wed, 14 Nov 2018 17:26:32 -0500
Message-Id: <20181114222636.100512-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222636.100512-1-sashal@kernel.org>
References: <20181114222636.100512-1-sashal@kernel.org>
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
index 06e99eb64295..6ced9382bf02 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -607,7 +607,7 @@ config I2C_OCORES
 
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || ARCH_K3
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.17.1

