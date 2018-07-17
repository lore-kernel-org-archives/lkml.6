Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF3CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7052064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nOzCp3GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7052064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeGQQLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:11:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35179 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbeGQQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id y22-v6so2009351wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTkflaydBTJzVf0ZHkleSoX0FARPEM+k3qhZfYkvVTE=;
        b=nOzCp3GB+YXez9IagCoZCya2xkPkTA/P6MDbH8qf9IV4tO7NUsHnF+2sKZNEiaHRSD
         r4/62oHZBzBmU0w0CLfWoZm8KEnNqwsy0uRtMjXkbvCwHTFzIu6jLKzZ7699kB1CEf8D
         aq8OMHpcC2a4eag/OrtLgWn9gGUiKOKRsq5R1c243htahJqlCLSTLggNHQaqip6bsrXV
         soLzQGl+8iKZOhCY3oECBRRiRweDFfGwGsMpnti0eW+5HR+Umss7LYYc3c+TA65Vu1tF
         0y1ADf3rRAWpIlKW6SLLYpYTSRAeslyvBGK7TiC9KEy3eaBkgtroC83wVftUr4iuXXdH
         LX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTkflaydBTJzVf0ZHkleSoX0FARPEM+k3qhZfYkvVTE=;
        b=Aba0STuxLD+ZL9T8z1SIeru7g2KkLlwN7/hcmsNyMV/q/XhVUtNI1prKgnqBr2S3+P
         s0+CYoduDwajr5YuPsR1pA14if6V1ECSQx2zjUV5HKldsjiumq+B5DBlEKslMaFcwWJM
         /djN/SP6/9E7Q3e19oQcxdH4HkoA2ExFrpPrKkc2dQzfkBdz800xDbHRn4Ht6DOkW+Qo
         9QY/6lWi352sDhAPCUXueDfatfYv1D1RmsxI9V2Wr7dRFUsb8zEplKiuJAa9OI0I9U02
         eKgOd9iBoiUwQPLzlie/GhSpfqNrVAgA/SZoCOH1TBUolcgwUJ47IL9GVotAaQiGYGsZ
         Mg9Q==
X-Gm-Message-State: AOUpUlEWm6+vMnYe1mZif9qjxwPLwgkwNtDartj5tZ3OJ/Jg85P9MXLx
        pMHxqNOBRTV6JjJFLB2sRgs93A==
X-Google-Smtp-Source: AAOMgpccm8nzBHRzBX9dONxzEw0MSp2Ldccqj6TvMDI2+jxOurBqyMEYvxuy1U3WM1opra+sZMg+7A==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr1778173wmc.27.1531841813426;
        Tue, 17 Jul 2018 08:36:53 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 05/15] ASoC: meson: add axg spdif output DT bindings documentation
Date:   Tue, 17 Jul 2018 17:36:30 +0200
Message-Id: <20180717153643.8806-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings documentation for axg's SPDIF output.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifout.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
new file mode 100644
index 000000000000..521c38ad89e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -0,0 +1,20 @@
+* Amlogic Audio SPDIF Output
+
+Required properties:
+- compatible: 'amlogic,axg-spdifout'
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk" : peripheral clock.
+  * "mclk" : master clock
+- #sound-dai-cells: must be 0.
+
+Example on the A113 SoC:
+
+spdifout: audio-controller@480 {
+	compatible = "amlogic,axg-spdifout";
+	reg = <0x0 0x480 0x0 0x50>;
+	#sound-dai-cells = <0>;
+	clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+		 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+	clock-names = "pclk", "mclk";
+};
-- 
2.14.4

