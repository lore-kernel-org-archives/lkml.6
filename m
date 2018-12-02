Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD71C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E08C2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSrXGWXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E08C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbeLBVXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43018 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLBVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so10113098wrs.10;
        Sun, 02 Dec 2018 13:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6LxUnav0zIyn7lCfJyICRwEWEm6FUE24Ta1FtH9WUg0=;
        b=GSrXGWXrOqtYtYyb8EOJeB8iD7RCnNokxW2iXm8cK2okjT7DaYq1on3gZA6qB5yvNM
         gKRD3bjQKjU3ZwQCc3jc9CEuhweFJ+bCdgajKLkucJRddwZEuvSLz2vk9nnvLm/8F5+Q
         qTdD4xMc22DfTdtTjIMDEZ4Vg34ZwEe9c2fgsdbEvSjA6IhKWR93spm0AMmKaNsf76Ko
         PPrFtuZeEwS2jCTqVrEF9WBfZ1HuYHNu4LMXpq0Qb+QwLpniaw+CzywCTAkKiP/p0fT5
         h7H9uwneXP2dRMHlbNfCzIKgGBUE7EZZZ3YAW08ZkhQ+KC3Xxc1GBKVhYotrSf/5QUJF
         iNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6LxUnav0zIyn7lCfJyICRwEWEm6FUE24Ta1FtH9WUg0=;
        b=IpytsHR7pLgJKlQzBLOqp2jTs9WlUAZqE8O1I/6ngdZ/1HNkym8XoIGpljGT51A8CE
         EywhINhZreP3yh9tYRmTLx6KE84fZNaoRxmiccclyi8gDKHKLAuezKEYgw3tTzyVy0nq
         l4IQfU2KNdvDH4nAFf6R/QYRo4xZfp3jkexf85JUmwRu+QDKYrZK6YbeNKLGD4j4oxz4
         0j4eRiJGdmbBfOhP8oOMj0AQSHyokLreG9vLKDdyfuBYkE/ZbFCrRXr5X8AL6M45SKKJ
         nTHZs3G1JuALB8cbvRD93/fdh9PNbLpu52UD/d21SSrA8U1hkwZe8udflZba6B8KEQuU
         fbOA==
X-Gm-Message-State: AA+aEWZ+4RuDNgsogSng0Ye7lzeVLuBQ0hw8BrDWHFOVSeChGq4RN+/9
        EG1//pWf7NoT+84GcooNZ6Lo7nly8cc=
X-Google-Smtp-Source: AFSGD/UXqTlLRnQ9qFyi7CzYKDOg0vCB0/xVT+soOuMlleGNZ0QEam8bkTB8W6Uvggfp79R/8Pfxtg==
X-Received: by 2002:adf:a743:: with SMTP id e3mr11378257wrd.56.1543785826048;
        Sun, 02 Dec 2018 13:23:46 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:45 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 09/10] ARM: dts: suniv: f1c100s: Add support for Audio Codec
Date:   Mon,  3 Dec 2018 00:23:16 +0300
Message-Id: <5f9f6c3e7c21a33c425396717211601f4460c488.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s now has basic audio codec support. Enable it
under device tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 4c96a9e..130d31e 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -154,5 +154,19 @@
 			resets = <&ccu 26>;
 			status = "disabled";
 		};
+
+		codec: codec@1c23c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,suniv-f1c100s-codec";
+			reg = <0x01c23c00 0x400>;
+			interrupts = <21>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_CODEC>;
+			clock-names = "apb", "codec";
+			dmas = <&dma SUN4I_DMA_NORMAL 12>,
+			       <&dma SUN4I_DMA_NORMAL 12>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_CODEC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4

