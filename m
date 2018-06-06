Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XQPCMTA4GFt3XwAAmS7hNA
	; Wed, 06 Jun 2018 19:38:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B038D607F7; Wed,  6 Jun 2018 19:38:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svOePnVO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2E78E6074D;
	Wed,  6 Jun 2018 19:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E78E6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeFFTiV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:38:21 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36908 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeFFTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:38:18 -0400
Received: by mail-wr0-f173.google.com with SMTP id d8-v6so7517339wro.4;
        Wed, 06 Jun 2018 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Z1ZeCDzzHPpIAtG+J58n8zm1/TreNJEVzd+QikzxCg4=;
        b=svOePnVOQSFIipDP3xsYwkV9Fc7u5l/WJSOXrR1XKKppB6b/dkI8SbMOXgKLtSa9og
         7OWHug449yQxhAMvklScx84kNP2uKFcxpg1af0idaSmmUIuE8cXTvnr3/dzx/u9w1F0Z
         6VVff6jvqzxSC7p1MhY3yY604LPN68CZIspMUYcyD0iaP+mxCvjMdxQvufUF30wN41Ol
         YwqvbOU2Fg3YOAX9hXUEJj/nF3ZIX+cnb0+AludRhHlPN7CCJOLxKdA5tJtZCb8QDD7g
         Ok45crvAYzUpcKETFVOnthZ1snEingD5vla8EaHJLTwtcyWIr9izUdMfrMsSXPDabDMv
         2K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Z1ZeCDzzHPpIAtG+J58n8zm1/TreNJEVzd+QikzxCg4=;
        b=h7+qkO6Uh83yju958FQ+D4tZLVEicRs4uX3BqFYosX9J/LQgZa0EI8XMSVKM4tNMSB
         0/N/YdVZxYf7wAjwL90MWsz7ZIufnSV21ifwFDJNSVU5sxMkzhdUCc8y+NJC/AxqMBIA
         cEnd+gQEv0jh0nERetlGUMfoICKxU8NUKN7cU6xpd10f1B0KTj3XI4898e6d3NkTtqNo
         qCN1nZvpv8ORdn4umebCMGrKN8Qy3j5/C+TqDLXg6lEXW93NXKKGE249MFMVARKSB22Z
         xeaRZAI+kpM4OmtaPihziWpveGHcxLXXvctO6iUfp9BxWY0j8r8mUC0QeArgYo1xHXtB
         1h/w==
X-Gm-Message-State: APt69E017OjgBK3OTr+JL6fzZV5ybcq2WUP+RkEzE1NKdiqU8ejZdJIV
        57DZFt3kc7jZndRdyrEOhxw=
X-Google-Smtp-Source: ADUXVKIdPYjME0V4hu0RwCEQFDNdhtD9DGuNFFDwfqZzQUHu00pkFUhD6Qsa10w0AhvdPfsdWpkViQ==
X-Received: by 2002:adf:8e30:: with SMTP id n45-v6mr3208621wrb.27.1528313897095;
        Wed, 06 Jun 2018 12:38:17 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id o13-v6sm4060590wmc.33.2018.06.06.12.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:38:16 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9519F10C2B80; Wed,  6 Jun 2018 21:38:15 +0200 (CEST)
From: Mathieu Malaterre <malat@debian.org>
To: James Hogan <jhogan@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Date: Wed,  6 Jun 2018 21:38:08 +0200
Message-Id: <20180606193811.16007-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to select SND_JZ4740_SOC_I2S on MACH_JZ4780

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 sound/soc/jz4740/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 1a354a6b6e87..35d82d96e781 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,20 +1,20 @@
 config SND_JZ4740_SOC
-	tristate "SoC Audio for Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740 || COMPILE_TEST
+	tristate "SoC Audio for Ingenic JZ4740/JZ4780 SoC"
+	depends on MACH_JZ4740 || MACH_JZ4780 || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-	  the JZ4740 I2S interface. You will also need to select the audio
+	  the JZ4740/JZ4780 I2S interface. You will also need to select the audio
 	  interfaces to support below.
 
 if SND_JZ4740_SOC
 
 config SND_JZ4740_SOC_I2S
-	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
+	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740/JZ4780 SoC"
 	depends on HAS_IOMEM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
-	  based boards.
+	  or JZ4780 based boards.
 
 config SND_JZ4740_SOC_QI_LB60
 	tristate "SoC Audio support for Qi LB60"
-- 
2.11.0
