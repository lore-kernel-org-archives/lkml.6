Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BF6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1958C21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dbHRoKjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfBGNcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:32:17 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:56124 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549546333; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xg9HBMe069822OGxItmgrwyx7QeXdc8BF1xKx7sr9Sk=;
        b=dbHRoKjNKOwIR07z3kP4IqHuHzz2eGVxsb9pmM16Hxoahzrua7lVrV+rjru1LDlkepFb+g
        JSq6CSLGs2rz1ohrU+/Ld6Mgcr0yBYZriQ7rUBvW9V6NjEDTXDeC8G8WIeVc9eelxREsYr
        uYx1URdIb6kYX/BQ1vH2NUK1S+I7Gdo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/6] ASoC: codecs: Kconfig: Show knob, and depend on MIPS || COMPILE_TEST
Date:   Thu,  7 Feb 2019 10:31:42 -0300
Message-Id: <20190207133143.5232-5-paul@crapouillou.net>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the knob to enable or disable the jz4740-codec driver, add a
proper description, and add a dependency on MIPS || COMPILE_TEST, as
this driver is only useful on MIPS.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 sound/soc/codecs/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index fec894c725d3..e6ce18c21b98 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -579,8 +579,15 @@ config SND_SOC_CX20442
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
 
 config SND_SOC_JZ4725B_CODEC
 	depends on MIPS || COMPILE_TEST
-- 
2.11.0

