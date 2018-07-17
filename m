Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F89ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17202086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="icSkR1+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17202086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeGQQKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34288 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbeGQQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so1726882wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aX4y48Nr4mxrNaEm41GH+dJkSDI+nV532cD2B8cBj8=;
        b=icSkR1+VKHX+RZrGD5HIdKOa4QbHYysYIQVdHihx1ZBWcyHXBwfRSKUEqnQAab6F3p
         sl3pUl3of/QCUkO9KxmsL6qPEWgKI2vijvrg5XrjJVNhdF3uT98YOEiytjcGpe6G3Jj2
         tNWPRS8jYTuGNsRcIPcQ5i3wcu/vZKznCjnyapGqSpDAlCUvRx/Sc8Sf239Td56GUQxk
         VFI2yJQLPVfHjhtyE2a/TizDNg3Y+Ce8u4YQOLd4kgfm1ws1K9ZeKGPL+ygudz5gCv2Q
         QFAjGQXTzvuQbc6MvKIjXBHrIOo/n2VhoEEvrJYtz8LIyOwSuO8V2z9VNCNGKhtTIGBO
         CpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aX4y48Nr4mxrNaEm41GH+dJkSDI+nV532cD2B8cBj8=;
        b=QPLEOX07fSHMcSOhv9kEPnCXTlSHJqRwPBvI3tCixCdANsts8pLe14wpouLGRuwbxb
         hcaTh5zO6F9WAyQh+NK+rQAL+4Ti0eKMjeD8pqPLbMx+jViHeJt9A40cilEPt7ZyGu79
         xd9km5oQTRzFr2ieZ2P/Xd9uRNJdVX+RtIAspKoFDENgIbZX4v9YVTmQ5OgfjiXpTLWT
         BK+yOznI97b8H02DyB/HSQWFQDj6URKRo4xYoeuzl01ka/GDSY2hr6fsTZZewFRbH7go
         EQb0IfloyXwjrKXwcNloSQtgw8EbsCOrvAU/t2NWnAAXDwNU/BhdybsTOUtrYtZOql2n
         t43g==
X-Gm-Message-State: AOUpUlGEz04hCv8DXhPtbCu82dgax5PbXVczy4TzHT6FqkK1A5sA+91e
        6zZ+iJdVSa2dFEmZcYDBpXzOdw==
X-Google-Smtp-Source: AAOMgpekLrlaZchcgPlskxm85A8XUrltaiUwaxDWznqsArtKpB7M3szInvxvIzhzLc9j/60ClngFbw==
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr1828270wrt.265.1531841818513;
        Tue, 17 Jul 2018 08:36:58 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 08/15] ASoC: meson: add axg tdm interface DT bindings documentation
Date:   Tue, 17 Jul 2018 17:36:35 +0200
Message-Id: <20180717153643.8806-12-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings documentation for axg's TDM interfaces

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

