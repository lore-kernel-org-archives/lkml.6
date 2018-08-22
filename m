Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC7E20A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OYzEJzok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC7E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeHVUzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:55:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeHVUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:55:43 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alex Smith <alex@alex-smith.me.uk>
Cc:     od@zcrc.me, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] memory: jz4780_nemc: Drop dependency on MACH_JZ4780, use COMPILE_TEST
Date:   Wed, 22 Aug 2018 19:29:51 +0200
Message-Id: <20180822172953.11281-2-paul@crapouillou.net>
In-Reply-To: <20180822172953.11281-1-paul@crapouillou.net>
References: <20180822172953.11281-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534958995; bh=W87aSIRFzin9Bcl2L6OhclHOMyDai1x0/RTMjPAt7cE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OYzEJzoklDsuPmRMQ0P+mFn+oKmrZzXxJS3xmVSsJL8QRhzV126Adi2X5gQUNQBrQuB0ZqCbLMLLHP8TwoTc7FhUY9liYkOGciNyrQqAg2C3S78G58ligZ1uZ3OAtAlMVqcxK1jLa56HdW9gN6P8FfM1KnrmiTIGu6FxEkKivd4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_JZ4780 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/memory/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 8d731d6c3e54..68bf8b2b45f6 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -120,8 +120,8 @@ config FSL_IFC
 
 config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
-	default y
-	depends on MACH_JZ4780
+	default MACH_JZ4780
+	depends on MIPS || COMPILE_TEST
 	help
 	  This driver is for the NAND/External Memory Controller (NEMC) in
 	  the Ingenic JZ4780. This controller is used to handle external
-- 
2.18.0

