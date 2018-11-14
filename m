Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B56C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BD42145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xTKblbnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BD42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeKOIzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:55:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeKOIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=t/Rcn4W6gJKPOl/Zgp1byaANmB59v0pQuhwTzcad+l4=; b=xTKblbnpRHD/
        /VrUEb6iwkrgAf92h/MRex9eUmr7B/PKGSs+rYIWQ7UJIsD/828cX7jJ2S4bCky9/puJtXzB9mm51
        Y8rVnwTOT+o1YGyFUYGQl1fiw5a4c/VQHEDzVNhv76QSbBNDdIp4lRc+gVM4DM9icTST/x0wooLPD
        7/cMY=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gN3cf-0004aq-Ja; Wed, 14 Nov 2018 22:26:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 571A2440079; Wed, 14 Nov 2018 22:26:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits)" to the regmap tree
In-Reply-To: 
Message-Id: <20181114222654.571A2440079@finisterre.ee.mobilebroadband>
Date:   Wed, 14 Nov 2018 22:26:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits)

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 43fac3238c1d9363b2a93d8d56c2be0c29c64e6c Mon Sep 17 00:00:00 2001
From: Tony Xie <tony.xie@rock-chips.com>
Date: Tue, 30 Oct 2018 18:07:56 +0800
Subject: [PATCH] regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits)

if there are lots of irqs for a device and the register addresses for these
irqs is continuous, we can use this macro to initialize regmap_irq value.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a367d59c301d..3930f3331652 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1110,6 +1110,12 @@ struct regmap_irq {
 #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
 	[_irq] = { .reg_offset = (_off), .mask = (_mask) }
 
+#define REGMAP_IRQ_REG_LINE(_id, _reg_bits) \
+	[_id] = {				\
+		.mask = BIT((_id) % (_reg_bits)),	\
+		.reg_offset = (_id) / (_reg_bits),	\
+	}
+
 /**
  * struct regmap_irq_chip - Description of a generic regmap irq_chip.
  *
-- 
2.19.1

