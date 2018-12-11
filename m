Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD43C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101982054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hIZN705s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101982054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeLKNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:47:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50916 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeLKNr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:47:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so2295830wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3o+VZnttimFeCQxAmu6M7QAtRnX+/U1ANv52odWswA=;
        b=hIZN705sTu6SeovdrawG+uO2CDCw3EuO1L03Klmq2GoxpJQfM4oJn34c8B29KlQ5QG
         huHHfThXHfd7/6Y94lqdkh0uRw8qgXM0USVCsaTMCJM9fIhfuIQAhBzZhdl9HWVOd7Mk
         ItcTLIbs/1j/jKlLkhh+dHi21SK7eEDPta1W0Uj8UYimWGh45Alk0J/Wkj8zRGSI2/9z
         X+h6kEzcHrdE5sZV/SXRJi9EluclWv7d+skTHxkxX5pwhc1HphKskDT0EJwuwh3xa0gY
         4Gxkz6G6mT6SAzfM2EaQQk+3T8TMbAicDQ6R/mK7K8FBIwPIwD3WiHGusxuIf0eP4NUr
         TvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3o+VZnttimFeCQxAmu6M7QAtRnX+/U1ANv52odWswA=;
        b=BcMrWbA0Uqqh7cp7T6u3Wyng+Sdoju8z3WduwAGQGIZYZFF96NoLTllSpgHC677nDy
         VKDR/uLK7Q+l9gRUdFcJvfF3WQeYWFx+byDRh2/hu8y1YiXzLxhlEwfzF3m4bfFSxuKk
         4cry/g5BtEuh8paDo3f6ahD3NOPTBrBIuxfobsXfKWb+Xh1qWtQBSprvVxTAromgbTun
         Ni7BxqJyPSiuVUBCZXO8wXmAElkCjjTIuLoWivrMSBOKAUBpLzwfuK10Rov0BF77vlxe
         7S7cY71OrwVMX2BDumofWmW/h1dfv5kn3fo+KAncYrEgLlMyZaMFmr7uMpu0CKRg1Wsj
         toZg==
X-Gm-Message-State: AA+aEWZydjrFWW+g8a7IYeZrpsGxtk4GTdVNouR6WgOGLyvSerGeuKPP
        c+m+1V+T6tKYlo+a5QwgC2BsTQ==
X-Google-Smtp-Source: AFSGD/W/NyrKCjhdHe0M1cLXzGs7Aqq7gjSm1xXM86n0BpaeIZt7fGhsC9ipLmaH45yiFviLykspZw==
X-Received: by 2002:a1c:c70f:: with SMTP id x15mr2362816wmf.130.1544536047118;
        Tue, 11 Dec 2018 05:47:27 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 126sm113768wmd.1.2018.12.11.05.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 05:47:26 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/4] ASoC: meson: add axg spdif input DT binding documentation
Date:   Tue, 11 Dec 2018 14:47:11 +0100
Message-Id: <20181211134713.4908-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211134713.4908-1-jbrunet@baylibre.com>
References: <20181211134713.4908-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for axg's SPDIF input.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifin.txt    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
new file mode 100644
index 000000000000..2e6cb7d9b202
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -0,0 +1,22 @@
+* Amlogic Audio SPDIF Input
+
+Required properties:
+- compatible: 'amlogic,axg-spdifin'
+- interrupts: interrupt specifier for the spdif input.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk" : peripheral clock.
+  * "refclk" : spdif input reference clock
+- #sound-dai-cells: must be 0.
+
+Example on the A113 SoC:
+
+spdifin: audio-controller@400 {
+	compatible = "amlogic,axg-spdifin";
+	reg = <0x0 0x400 0x0 0x30>;
+	#sound-dai-cells = <0>;
+	interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+		 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+	clock-names = "pclk", "refclk";
+};
-- 
2.19.2

