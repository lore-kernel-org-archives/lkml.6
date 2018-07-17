Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA53ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52FB20849
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fKuLPq05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52FB20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbeGQQLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:11:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52812 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbeGQQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so1960417wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b4RC/bHYB8Vb7haYF+eVU5Z7vB8057Yr70QQourlFGQ=;
        b=fKuLPq057tUTizEiiI6rgfEsQVsb4jKxR0C3fCKyfHtTPfLG2FZRrGEt5EG3pPAzNT
         kgWIkYIM15tzez+hIr16Ed31UPGHWfObRGdB7V4Y9aX7G0J6WHY+RV3DE2RFkVzWBU14
         c3cL5xbrA9dnabkGsAvv9LGOHi8VKmQHEk2UjZ15nkZvHcTwHssBY28WR6rMEMT2e4qI
         RfTC50fo2nIfFF2974XU3iCEZwhmRyNqFThi92ZA9x6IDztxnpExawGFcB+tGGKUZ1Bf
         RwkCHuABlEv+RGtFvlId/KWwzFBODVnbIWMwaBmB0WmRVZX9Y4xJu5+UC9TFfFgGSadG
         8saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b4RC/bHYB8Vb7haYF+eVU5Z7vB8057Yr70QQourlFGQ=;
        b=RybCvrLLpKZn5olaMGeKxDKUDUpslEv67akLoFK2Tb4i4ti7JG2X7O+ig8qQgxJfGW
         P6DJSlLrQJn/wackHGOY9W8x06AsIfdqlWSSaEu7QPQ/waXcRsKSo/JxqXJkpSrStjYl
         k21XOCBkoUj8gkz5lWqxyBN72/A270RXhgVQer9WPcrfq38KOV0oEhZQFrV/56iLCf39
         ERtf3vNkrOo3DlgqLS7YXWgDaYLpqACb5qxgrRopHyjF/1Bv8Y8ZQLj/Whn/Xr8UE6yA
         5ITU350kBMgHeXZlfpBw6ggcJ9+0wbP49x8mQteDjNW3UzMSmGdhz8BT3yJ1oMZvPnCc
         DGYg==
X-Gm-Message-State: AOUpUlHTZLKI+H24TjEor35tCVb0/CLuXUN2fyoQl67YRmWGU9ksjfSJ
        bizOU/ELRhxFQwgz3CvJbVSZzA==
X-Google-Smtp-Source: AAOMgpcCsxzWQuiFs2h9pbB4g9K0JNj5+yMocwW7Pxy23RBygKW03d9icHzdKeGlbMQc0oDwCQJ/Sg==
X-Received: by 2002:a1c:f216:: with SMTP id s22-v6mr1809440wmc.50.1531841817557;
        Tue, 17 Jul 2018 08:36:57 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 08/15] ASoC: meson: add axg tdm interface DT binding documentation
Date:   Tue, 17 Jul 2018 17:36:34 +0200
Message-Id: <20180717153643.8806-11-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for axg's TDM interfaces

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-iface.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
new file mode 100644
index 000000000000..cabfb26a5f22
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
@@ -0,0 +1,22 @@
+* Amlogic Audio TDM Interfaces
+
+Required properties:
+- compatible: 'amlogic,axg-tdm-iface'
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "sclk" : bit clock.
+  * "lrclk": sample clock
+  * "mclk" : master clock
+	     -> optional if the interface is in clock slave mode.
+- #sound-dai-cells: must be 0.
+
+Example of TDM_A on the A113 SoC:
+
+tdmif_a: audio-controller@0 {
+	compatible = "amlogic,axg-tdm-iface";
+	#sound-dai-cells = <0>;
+	clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
+		 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+		 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
+	clock-names = "mclk", "sclk", "lrclk";
+};
-- 
2.14.4

