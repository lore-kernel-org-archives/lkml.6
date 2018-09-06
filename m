Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C993C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C72320857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C72320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeIFRmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:42:38 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:41236 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbeIFRmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:42:38 -0400
Received: from dslb-094-222-221-043.094.222.pools.vodafone-ip.de ([94.222.221.43] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1fxtzz-0000bV-GX; Thu, 06 Sep 2018 15:07:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] mt76: MT76x0U requires MT76_USB
Date:   Thu,  6 Sep 2018 15:06:43 +0200
Message-Id: <1536239203-21733-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're building MT76x0U, we must select MT76_USB. Otherwise,
compilation fails because of undefined references.

MT76x2U already does this correctly, fix it for MT76x0U as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/net/wireless/mediatek/mt76/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 6a270e759006..cec977b81305 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -17,6 +17,7 @@ config MT76x2_COMMON
 config MT76x0U
 	tristate "MediaTek MT76x0U (USB) support"
 	select MT76_CORE
+	select MT76_USB
 	depends on MAC80211
 	depends on USB
 	select MT76x02_LIB
-- 
2.1.4

