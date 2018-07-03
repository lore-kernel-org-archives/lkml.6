Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE9FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6935B23E51
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xC8jxGwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6935B23E51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeGCN3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:29:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38251 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeGCN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:28:52 -0400
Received: by mail-wr0-f196.google.com with SMTP id j33-v6so1987246wrj.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2a4YlPp82XXhtbstYb9AyI/InJJaeU2xFpxue7j/yCM=;
        b=xC8jxGwP9Dzngt/5UWhwlmgHGjIFnyMPxRV3rA/AtSGdHbjXqueQscahxekvZLL5hs
         CyMMlLArt6yqSzLeLBaVudMhqjHqokTpIzmYKa8JShj8NDNjxuAnQzL8CxufPsp9shYF
         82xgPHGubn0GoKDp/0d2hyBOUBoKBgoNTKlklfqzhx15+k+/5K3DyBVVqJzRSJN1J9cf
         f28HL5V8DIDUWTGmxCN0qjGuvbOXwPCRRdDiDO9zkAegFBqz+TOv4geItJxGQpsaKqKo
         HuTSKbU10ekJfQFF79eVR2eIWiqe1gRbfYcm5viksoF4m3WsHwrrV5ww4vPQIA+JjhXw
         9frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2a4YlPp82XXhtbstYb9AyI/InJJaeU2xFpxue7j/yCM=;
        b=KZywJVHjcRbsGugTTohgP7b2bo/dAjeGuRqOcb/r31BlFy3VlW8x+/S+2/8/vhfb5F
         dWpFq3pf8wvFxklPG3r/oGOKy9ijAtBUV0ARx1HF270aBBqtj43ANCsv65FLG+hlIZuH
         Lc2PZNz6imyEKqs64DWR14K10A2qZzAOKhxpt44ptqlN9oVbBIVOKTac8dQXexbKELTx
         47SDysWSbpdIR/QkcUCwTeUbvDcUmWpC6NIwozgSBH2tJp9L+6VAQxOWYhf9X13Cz0+A
         63pAxvVT37WRzZZ0EUTUcwaszm0a48cx564W+qniE+mxit5/lPLdNAu9I2doAvJjhQDx
         S3tg==
X-Gm-Message-State: APt69E0jMws8HIMcxje1AiNXf3Kt5VvTaG5k0uKI49tNVyzTKDRQedYW
        ppldBD1zKihdHeFh6SudiL8kXM3L
X-Google-Smtp-Source: AAOMgpd2JQYehfac2dGaPKQr/DtS1LyEuAHLmBUsUcPSNSLYCeRq9xLtzwAUvjLyLaJzcyJBxDKUBA==
X-Received: by 2002:adf:fac6:: with SMTP id a6-v6mr21860273wrs.74.1530624530994;
        Tue, 03 Jul 2018 06:28:50 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q140-v6sm2247763wmb.35.2018.07.03.06.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 06:28:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ASoC: es7241: add dt-bindings documentation for the es7241 adc
Date:   Tue,  3 Jul 2018 15:28:44 +0200
Message-Id: <20180703132845.26554-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703132845.26554-1-jbrunet@baylibre.com>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/everest,es7241.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7241.txt b/Documentation/devicetree/bindings/sound/everest,es7241.txt
new file mode 100644
index 000000000000..28f82cf4959f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7241.txt
@@ -0,0 +1,28 @@
+ES7241 i2s AD converter
+
+Required properties:
+- compatible : "everest,es7241"
+- VDDP-supply: regulator phandle for the VDDA supply
+- VDDA-supply: regulator phandle for the VDDP supply
+- VDDD-supply: regulator phandle for the VDDD supply
+
+Optional properties:
+- reset-gpios: gpio connected to the reset pin
+- m0-gpios   : gpio connected to the m0 pin
+- m1-gpios   : gpio connected to the m1 pin
+- everest,sdout-pull-down:
+   Format used by the serial interface is controlled by pulling
+   the sdout. If the sdout is pulled down, leftj format is used.
+   If this property is not provided, sdout is assumed to pulled
+   up and i2s format is used
+
+Example:
+
+linein: audio-codec@2 {
+	#sound-dai-cells = <0>;
+	compatible = "everest,es7241";
+	VDDA-supply = <&vcc_3v3>;
+	VDDP-supply = <&vcc_3v3>;
+	VDDD-supply = <&vcc_3v3>;
+	reset-gpios = <&gpio GPIOH_42>;
+};
-- 
2.14.4

