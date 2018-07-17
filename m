Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0B6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC9920657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sUb+SpBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC9920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbeGQQQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:16:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40580 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbeGQQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so2015406wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=12Tv3Q/nsmVkP07JHXVAe92gfJ5PlgKfbwQM/5tbbp8=;
        b=sUb+SpBtY5p/OU0TIz0fdNH1wlzroS5oqKzTfMNAICZU8xfDqnfOImzyrXR5zYekG4
         Kc0H2wQz4XTdhY19IkrVeB6wcQtM9lPRDJ1R8mbNgCkoomBoovudcw8G8hLwwvXtdP+X
         3JJ4OeaonsWG/t3clLvN9Zg6uN4Q9ubrIUQORxhZzZmEo6MyqsqMjaqSlqRNFxmJ8it3
         zRHsxf3NV6P8p8VYAI5cXlAfba0ZvAJHc3MN3lK+A0JW0harWosuwFEw2ZC4ccPMzmSt
         2Ftny++fux1KVGWrIh7fhDSmhMjOxsmMdrbTi9l9Pf+qxHX5h8Wdg6mdQ8zVDHIGXhFz
         cPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=12Tv3Q/nsmVkP07JHXVAe92gfJ5PlgKfbwQM/5tbbp8=;
        b=IFGKX3iNc4g5Q8NWtxvegv6EbVMJ0Ayum7iBTx8g36IOFdsb08ZHHMiNI5MWDk7uyF
         Z5TzInYtefykHiIhV/iQaj71bVkzamxKOIdKM9+0LPlzqiKJDLstDQZZedRFBSf5YrwH
         fGBnZE0yvsNUuPPoGlOAMpye6Jx9dG3pAe9c6kiYh2uDfcyc+8+EKRXCIUANWtUa6kqz
         Qgp4rYQB3uXR+L7ePAwZAQK0LLFbjFrjqlbPCdpU4JW5fGTArUv/F4U8oRovbP3DXlcr
         pPw8mST12Ov//fnJMppyBrzQ4eqEgs2hXVpfRxDHLsoJoI2N6FL8s3PoKtFl8sn8Y4VN
         p5jw==
X-Gm-Message-State: AOUpUlGkafsRT7uSBN40qgDpMqmDtgRVNUO69EeTBuqsACPxX60MoUTu
        i+qrFshz1sn94slyH5vJEQjSuw==
X-Google-Smtp-Source: AAOMgpcop+bCqQPwXP4YczK8V24l2874qHrUgWKQQwYuqMxxcNlKKIbXPQPEOvPr4u/y5NcZO1gHcg==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr1788908wmd.77.1531842201023;
        Tue, 17 Jul 2018 08:43:21 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s12-v6sm17598252wmc.2.2018.07.17.08.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:43:20 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH RESEND 07/15] ASoC: meson: add axg tdm formatters DT bindings documentation
Date:   Tue, 17 Jul 2018 17:42:56 +0200
Message-Id: <20180717154304.9973-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717154304.9973-1-jbrunet@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings documentation for axg's TDM formatters: TDMIN
and TDMOUT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-formatters.txt  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
new file mode 100644
index 000000000000..1c1b7490554e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -0,0 +1,28 @@
+* Amlogic Audio TDM formatters
+
+Required properties:
+- compatible: 'amlogic,axg-tdmin' or
+	      'amlogic,axg-tdmout'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"     : peripheral clock.
+  * "sclk"     : bit clock.
+  * "sclk_sel" : bit clock input multiplexer.
+  * "lrclk"    : sample clock
+  * "lrclk_sel": sample clock input multiplexer
+
+Example of TDMOUT_A on the A113 SoC:
+
+tdmout_a: audio-controller@500 {
+	compatible = "amlogic,axg-tdmout";
+	reg = <0x0 0x500 0x0 0x40>;
+	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+	clock-names = "pclk", "sclk", "sclk_sel",
+		      "lrclk", "lrclk_sel";
+};
-- 
2.14.4

