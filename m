Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72487C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A88217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bIwSzl6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A88217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbeHGN4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:56:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51234 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388901AbeHGN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:56:30 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 06/18] dmaengine: dma-jz4780: Don't depend on MACH_JZ4780
Date:   Tue,  7 Aug 2018 13:42:06 +0200
Message-Id: <20180807114218.20091-7-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642152; bh=04ny1OxuMbHmhpz/vkFc1aKgw4v319jUCoDc8CXK68U=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bIwSzl6uUStiraCtTSfepWMLa2XCXDF45CET2k/Tk34wlTKxUg2Pwo6xXXjwmc1Q22fKCL9eZH5AMr871iH3wt80kMgo4SY6z2g+Qm2EDo0/YiZcA8d2pL66+g3NKwjif+I73mT81JgatX/yoXQwX3h8Y9yHs/k8xW2gO2HfXnE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we make this driver depend on MACH_JZ4780, that means it can be
enabled only if we're building a kernel specially crafted for a
JZ4780-based board, while most GNU/Linux distributions will want one
generic MIPS kernel that works on multiple boards.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v3: New patch

v4: No change

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ca1680afa20a..0680e1eb0d73 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -143,7 +143,7 @@ config DMA_JZ4740
 
 config DMA_JZ4780
 	tristate "JZ4780 DMA support"
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.11.0

