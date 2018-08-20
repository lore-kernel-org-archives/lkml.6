Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F831C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEA921570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oXHtAtui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEA921570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeHTVYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:24:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47762 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTVYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:24:06 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     od@zcrc.me, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] rtc: jz4740: Drop dependency on MACH_INGENIC
Date:   Mon, 20 Aug 2018 20:07:16 +0200
Message-Id: <20180820180716.1853-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534788444; bh=NgGTtVuUdy4sZdw26AV7/gPAV8I+NLNxPZuI4kkMIyU=; h=From:To:Cc:Subject:Date:Message-Id; b=oXHtAtui6erz98iGiO06BDjBLyzV+xUBJeibnIFltUSp35m5uJOuomG6oBLJK5OWU8SsPMDEI30+0Ql4GtfFGz3Gfd3DHOG9XFIuQuLIYRO+xpFTlQYWSRSB4NgmCyrQGsDjfQkI4QLlMalBUdNsFuScHy95+RVuRHNwpAxeHps=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a2ba5db36145..98c7f19256b1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1608,7 +1608,7 @@ config RTC_DRV_MPC5121
 
 config RTC_DRV_JZ4740
 	tristate "Ingenic JZ4740 SoC"
-	depends on MACH_INGENIC || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
 	  controllers.
-- 
2.11.0

