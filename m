Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450CAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6FD214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZlbMHNVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6FD214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHUQXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:23:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57748 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeHUQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:23:37 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     od@zcrc.me, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] mmc: jz4740: Drop dependency on MACH_JZ4740/80
Date:   Tue, 21 Aug 2018 15:03:20 +0200
Message-Id: <20180821130320.1682-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534856612; bh=iguKCsCVE4CWABfhDtgAVqaOgrAMEcyZpUjZs2tM1/M=; h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ZlbMHNVTX/jwY5CiDL+u6SdGfAiJCAynDIalj0yDe6ma/H7FDsDE7pnMcJaQq2/RuYhDxLYWlc8YL7X8I6MBwV6E0T3ZPB21YgTrbIs2/mYyJtN14ALVSojkqkEP6/8rB+VPAZl9dJl2704114SpC0lUq9HKZedbTwbvMaJQHcc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_JZ4740 | MACH_JZ4780 prevent us from creating a generic
kernel that works on more than one MIPS board. Instead, we just depend on
MIPS being set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c199c996..71d9bdc52422 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -761,7 +761,7 @@ config MMC_SH_MMCIF
 
 config MMC_JZ4740
 	tristate "Ingenic JZ47xx SD/Multimedia Card Interface support"
-	depends on MACH_JZ4740 || MACH_JZ4780
+	depends on MIPS
 	help
 	  This selects support for the SD/MMC controller on Ingenic
 	  JZ4740, JZ4750, JZ4770 and JZ4780 SoCs.
-- 
2.11.0

