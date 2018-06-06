Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nLsXGvo3GFvEXgAAmS7hNA
	; Wed, 06 Jun 2018 19:38:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74140608BA; Wed,  6 Jun 2018 19:38:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JacDx+Sw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D38746074D;
	Wed,  6 Jun 2018 19:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D38746074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFFTiY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:38:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38095 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeFFTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:38:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so1125939wmf.3;
        Wed, 06 Jun 2018 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iZtBVOWqAYziJ/NdJ7U6CZ/xJhq//WZIkEI3sVArBcE=;
        b=JacDx+SwS1JRLUJv6DyMFn7+7FcNTuVed3PvLd3spNSjsPaIDoup/ZE6uPH3wX5yZn
         z+3ehdclDtg8hEdP7G5FWns22Q7qHzeck2N+Q/rOBkEWZE3sAWAJ/9kIDaNeYGVl2Mwu
         6WWjPBmhgl4EX1I37RzR5+7gpFqdyEb3i3+dyLY1C3i7p33eb3iUZiZEHkjcrt9fwFzE
         PchcqMMQfkMjXvXC7sS+Iq2FC/okfGcXjLA2udY2+UKr+C9RXPYdMX4UMjlLUvYGnZ8+
         LiWOB6py4Jxey6hRJ6VxXVA6Itl55pd6CtVKmKRhGCWaPupcDSWj3cdNtZxoynUm0C96
         bgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iZtBVOWqAYziJ/NdJ7U6CZ/xJhq//WZIkEI3sVArBcE=;
        b=bIFLuGY9WTGeOpMoSNLEv677aQKn386HuqKaKzeQqWehu7Vr8xDDADBasw06FjjgDd
         8DpcGB4dB/CHxR1+IWF2XvPDsI/vpbL2fVUfT8+WHxTB1SnnE/F3D+KXfX+XO2zR9FA4
         O3WIkgCpOoJnYXFSdd2f3X5Zxm2ioEpuNMQkR8DiS+3zaj5cxf26SkCOEzj4L9+/hjyU
         JFa25luRLFRWXR0nG7NwM6iTgsrEGceYYDV8V6zpbJPxXtDtESzPz/CaxFnZzmoeC8vP
         11EYw3scG3ZZ1tgBTdQ9LSdKhqeQxqFrNFcuSK+AjYYOLIQJ7EJF7sg/FY43N1eZ9o1x
         oDQw==
X-Gm-Message-State: APt69E0ILUYSK5l/GrmjIzmcFzY0NIP9wV+7RiWFNMPzNxWxemTife5k
        /iEtQzAq5bQu+prl8iTWI0Y=
X-Google-Smtp-Source: ADUXVKJioHcccl2ND0wTYMDWNRoGPt67a0qrvVfo4nZoX7FJWTiRP1/pwYEUEMo2Ten4uBjlIrOBGg==
X-Received: by 2002:a1c:688:: with SMTP id 130-v6mr2807867wmg.82.1528313900423;
        Wed, 06 Jun 2018 12:38:20 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id l142-v6sm7111830wmd.16.2018.06.06.12.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:38:19 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D1B0F10C2B81; Wed,  6 Jun 2018 21:38:18 +0200 (CEST)
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
Subject: [PATCH 3/3] MIPS: jz4780: DTS: Probe the jz4740-i2s driver from devicetree
Date: Wed,  6 Jun 2018 21:38:10 +0200
Message-Id: <20180606193811.16007-3-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
References: <20180606193811.16007-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 967beb2e8777 ("ASoC: jz4740: Add jz4780 support"), jz4740-i2s
driver supports jz4780 hardware. Use proper compatible string.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index ae57976bc016..308079ee8dd3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -57,6 +57,18 @@
 		clock-names = "rtc";
 	};
 
+	i2s: i2s@10020000 {
+		compatible = "ingenic,jz4780-i2s";
+		reg = <0x10020000 0x94>;
+
+		clocks = <&cgu JZ4780_CLK_AIC>, <&cgu JZ4780_CLK_I2SPLL>;
+		clock-names = "aic", "i2s";
+
+		dmas = <&dma 0 JZ4780_DMA_I2S0_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_I2S0_TX 0 0xffffffff>;
+		dma-names = "rx" , "tx";
+	};
+
 	pinctrl: pin-controller@10010000 {
 		compatible = "ingenic,jz4780-pinctrl";
 		reg = <0x10010000 0x600>;
-- 
2.11.0
