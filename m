Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44401C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCF920844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dDU2Zd9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfBEDL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:11:57 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42020 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfBEDLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549336313; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3heJhw2TaqfcrnGsHzdFE//pMCqfvVmrvhEbr/JmP9Y=;
        b=dDU2Zd9U0D6Fj1cfDKDkLAmPNhXYyEJt/RQkqPelfkqnOc/5kxDr/QSJD8bBsWbC0Xdomk
        3pL/DlULU0Sb6wqd7ak8x0Uho9s6qcJ01h07GZTxTYYt0k6KTMezluYTYsUxLL/1Tagdpk
        AstthZXmG2268jBpwEgwaESW0JFTaOw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/6] ASoC: codecs: Kconfig: Show knob, and depend on MIPS || COMPILE_TEST
Date:   Tue,  5 Feb 2019 00:11:07 -0300
Message-Id: <20190205031108.26171-5-paul@crapouillou.net>
In-Reply-To: <20190205031108.26171-1-paul@crapouillou.net>
References: <20190205031108.26171-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the knob to enable or disable the jz4740-codec driver, add a
proper description, and add a dependency on MIPS || COMPILE_TEST, as
this driver is only useful on MIPS.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 62bdb7e333b8..2a6d3f86ca96 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -560,8 +560,15 @@ config SND_SOC_CX20442
 	depends on TTY
 
 config SND_SOC_JZ4740_CODEC
+	depends on MIPS || COMPILE_TEST
 	select REGMAP_MMIO
-	tristate
+	tristate "Ingenic JZ4740 internal CODEC"
+	help
+	  Enable support for the internal CODEC found in the JZ4740 SoC
+	  from Ingenic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called snd-soc-jz4740-codec.
 
 config SND_SOC_L3
        tristate
-- 
2.11.0

