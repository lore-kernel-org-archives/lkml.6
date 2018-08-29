Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B9C43143
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F342083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Sv/R+Ukm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F342083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeH2S6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:58:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39635 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeH2S6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:58:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id o37-v6so5144420wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M3ulMuAVOTpyiu7CM7KID8UePIh9rpVFCKWBlNIO4N4=;
        b=Sv/R+UkmGDOneWQ1vOl2ZQN1NkzWSxynTM5r3zgoruDAmwQ7Pzzs3Wb8Si9Br4ZiEt
         Ppvplkt829dOxcPSlZaPjnujJ6w/tfzBk1q6tnJpz0yVNV8n8CKWPbwf0/DuQZNbIAa2
         tlhEsVKWgM4WuZNJlkLZXwScaEx1l/B1sd30KgjGcLb8OLuKGomFAys/rQI5v7A/QuVp
         /+5Bz6mHz3Rm0syn9nAg7cZpo59UopwLb90JC2bb4eeRmVuwJfb1u1gVLslUgJ+E+oKM
         ySH0XqS9NY5/DqisBghOZSITBK2aq8NcI6/CFNjVrAYJbXzRh0zHCin4jMepuH3c5y1q
         hiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M3ulMuAVOTpyiu7CM7KID8UePIh9rpVFCKWBlNIO4N4=;
        b=gBy7fAeqUpwMZuCsfqDsu+JKxqWpR+3lTJTwV/Zvv1VBsqbmIcBwfdX9HwIFVoj11H
         /eYHIDy0/vRkCr9ir8y1I/rXqbLFtouKnLHHNFAenABOVhX+ecemaoA4iS7NeSTzUX7b
         bWXyD4eHH2mRyV1Bw67OVFRZ4rUTlHCztfxv2dJd2OwV5nCxJV31IvmTCYYGt0vZWgla
         1ng/iSc+kFrYd7+9derU6tfFjc6uJzQWhsITroG16QNWwRHzqn8KS8YY9KR2sMl7XRnE
         F0xk0ItreK6ASuz6Jj1UOehTkO8iwKFMzosVZiRFrHPJGfORlhCm9WJjOYKNdkWVtFeU
         X3tQ==
X-Gm-Message-State: APzg51CJhAJekTseIwrUIF+thd54V2E8PnmN8tg/Jlz9QT9oDLbxt/RP
        x8dyZtSToQT2uu5H6pxigdk3a6mr5F0=
X-Google-Smtp-Source: ANB0VdaWBD4X+xBHaPEwsm0QTym3/lgumkc6A0v/5yaNR+19pJrXakuuD882K0VxNxKjbmc3NP6HfA==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr4565744wrc.45.1535554861409;
        Wed, 29 Aug 2018 08:01:01 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v46-v6sm7267217wrc.63.2018.08.29.08.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:01:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ASoC: meson: add axg pdm input DT binding documentation
Date:   Wed, 29 Aug 2018 17:00:50 +0200
Message-Id: <20180829150051.18190-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829150051.18190-1-jbrunet@baylibre.com>
References: <20180829150051.18190-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for axg's PDM input

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-pdm.txt        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
new file mode 100644
index 000000000000..5672d0bc5b16
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -0,0 +1,24 @@
+* Amlogic Audio PDM input
+
+Required properties:
+- compatible: 'amlogic,axg-pdm'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"   : peripheral clock.
+  * "dclk"   : pdm digital clock
+  * "sysclk" : dsp system clock
+- #sound-dai-cells: must be 0.
+
+Example of PDM on the A113 SoC:
+
+pdm: audio-controller@ff632000 {
+	compatible = "amlogic,axg-pdm";
+	reg = <0x0 0xff632000 0x0 0x34>;
+	#sound-dai-cells = <0>;
+	clocks = <&clkc_audio AUD_CLKID_PDM>,
+		 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+		 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+	clock-names = "pclk", "dclk", "sysclk";
+};
-- 
2.17.1

