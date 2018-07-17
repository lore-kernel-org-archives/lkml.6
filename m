Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A3A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rsuc+sQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A3A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGQQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51782 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbeGQQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1983984wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=12Tv3Q/nsmVkP07JHXVAe92gfJ5PlgKfbwQM/5tbbp8=;
        b=rsuc+sQ83N22uVOXm9o82UWN+urZarzQaFN9YtveJGElinZNbKrPMIdHAd6eCq/mJh
         9oFTufug4w2RwIca4znrsn0N7puObnEfeAnkXhUZyDA/dteU0SFEAjeGjR4ZHuLuTXPs
         HeqS1o3XPPBzSNXIiy+oI9DlzFgp6eq5y4Ny4ObjijCox9ViuWM6Vm9j8iSYouSlMvRD
         BSHTHUVChGw7wKrEWqs2l4at72gEIYhHmP2Jljm6lcgwgA65YgfLH7i7JtQFjNVvaf0o
         wsTPYAvBi36fTdG/r7RlgxxK1FSJbZ9Irje6Nxuy65w+tSVQwxBzIhFXuuMGaFu5kcN7
         Ph3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=12Tv3Q/nsmVkP07JHXVAe92gfJ5PlgKfbwQM/5tbbp8=;
        b=fLZ8shPkJSQnxt0HZJW1cUcxIHLSUKiZ1WEAB/o7gHG0Zqr6yRF4aksaRIrMNccBev
         fHUtcXwBAeS7YrOvONHMrt6MAnGekzPWExUMquni8peyMAckwO6ImZ4V+dk5shjHBY+0
         sZbGh9xxs3suN5K3Al0Y4cQ+z2X//W+9DJg56Y7VH191TwdxbI5Xj4zdW7usMQbXGjAp
         t/SowBY4r8DqFCXh6bJD6EpXaayoJ7W8rDrcjpiZslBYiVKa7lo6hS2NeFQn+VXQCq0J
         HI313TOi+R6qdWjl9MuajqPX0wEzgTO8tW1Uhba2aJ7a4Hnz0tdY48JTQU66tPTwujP+
         VgFA==
X-Gm-Message-State: AOUpUlFy9ETISU8/CYezf1WBn1zgXkE+5efBga05zKXVVUSpd9A6Ytmu
        sMS3Y9x8PYG/csJqy2S4/1Jgew==
X-Google-Smtp-Source: AAOMgpc1bJ6vG92RmzxAaqpNwpgYWvZe6ipr9yILCSLuwt6kwyu50IkpyqERNH3/SwGNqmUMphVaCg==
X-Received: by 2002:a1c:ee5d:: with SMTP id m90-v6mr1717434wmh.107.1531841816545;
        Tue, 17 Jul 2018 08:36:56 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 07/15] ASoC: meson: add axg tdm formatters DT bindings documentation
Date:   Tue, 17 Jul 2018 17:36:33 +0200
Message-Id: <20180717153643.8806-10-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
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

