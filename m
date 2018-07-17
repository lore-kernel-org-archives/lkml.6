Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763672064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tdgkWRw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763672064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39990 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbeGQQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so1994187wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vXYXkidVJx381ShSQL8RzCcLiMOwBCQSWCB4qdwObFE=;
        b=tdgkWRw3qyJqmKwRFAbbe/4QVyxkp5qQbvsv/6HvK/v/8SpQft/qvBWeDBINFE8YQo
         jx6UYLQCPVx2XdCtzjesBdA9drCTS+K6rJF3QY1ErHeC+R1qhzBYOQnP/u9rnlr/KNOX
         UEbMNKkX1R6vBVI859iz5EdM5u5S2vYWzKasUyCRoSs94+mj1EzkqW8iJo+S/t5Di4WM
         xgwGuYNIrslHJWD9t+dAJwkERCKeNOuOlsNDf0iXrz/JIdyocGu46VEL2RJBXkVYDp/B
         1IP90ER/YH+pKoBtMDSKDh3tsElqhCi6bAXNGUSMl7YBZUmemZ9qucyOpK2Wkk7pAll1
         T8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vXYXkidVJx381ShSQL8RzCcLiMOwBCQSWCB4qdwObFE=;
        b=iAv6NL2rfrXUUfZaGj+/03M5x1JhxOw1VTMq5A9GB8Xd+zNxbSF4QwxvqiSqa3MHNz
         cWIlj1ub1B0BdArw0edFhYt28VPzb6qTm9D1inzDVhMxR3dTuhs1K4YSWImxoX6lu3Ed
         qqkg3KkYiHPUeL/aDTTjRDxvK7TSfAvOnipUTGxkI3RlsbZbFsx47OA+L8oN9WHsfQoR
         ptumlbM2wXCL8y7BdXsLE35a4Zkynr53Oy0ZDa62h/TIiXefPocByX9LgrrYwUomyYLi
         pH907cRYwcKbwn1DLzNZyKxUQNGmdo2oXg4LBsyvCp5RKI49c7oWTEwRmV9P6RFSmY/F
         LMIQ==
X-Gm-Message-State: AOUpUlH8XWSw5adVDUltcqMKHyHZMb6VsVmyRVkf/fBvfBLTh9KJi2SC
        rYoaj4fIb3N9jGhw8/bTzNYt9g==
X-Google-Smtp-Source: AAOMgpcBv74OSXeevaTJUXCDGvj/xwLN8MSzUtBaYPzY3ph57h3wiEeVk4ec3x4dsHZCj03zXL19iA==
X-Received: by 2002:a1c:7506:: with SMTP id o6-v6mr1703579wmc.60.1531841812409;
        Tue, 17 Jul 2018 08:36:52 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 05/15] ASoC: meson: add axg spdif output DT binding documentation
Date:   Tue, 17 Jul 2018 17:36:29 +0200
Message-Id: <20180717153643.8806-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for axg's SPDIF output.

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

