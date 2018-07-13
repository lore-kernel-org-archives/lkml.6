Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30860ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D715F208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CRpjD5IQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D715F208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbeGMNFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:05:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53720 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbeGMNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:05:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so1395935wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/O/QzpvEbTCUwnA7IVGQZzKoegMixT19m9IgtOsXbo=;
        b=CRpjD5IQIgQeMNEFbBAb8aJFDduT1DrI2+VtxQnh8AM863q0O+5Y9zqPZFYc8sZc8H
         oQwfoHSlc0BQiuHqIjcS3353bk+hNauCTGE5v894N57/btRg/cTA/s886pBCOzczcus2
         /OScr5twc5jnVCdeGJPF+AHHZav2lnGBCX0IS103qsxrg6Gk7JlpahIoHgYg7WLoho3q
         ffG0JAkheVpigAMZUHtD1kruV6Qe93UcEadygEKNLpvIWrWMIZRv8wmuKDotgT/fZfvC
         1LC77wYVWmSJ5mldnxrok1+OSYM6Ul/fR7vyMJjqU9k8SBc7GGuBrh9QhOK9BMJ+iOK5
         f20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/O/QzpvEbTCUwnA7IVGQZzKoegMixT19m9IgtOsXbo=;
        b=bdL1WYpbOzPEfpS2OBL38LUWQAsrmO+6zTGuNShe9sdDMyh5YbxvlJOXobhLlBhzOw
         uM6Yi6a1e7l1guY7BL/M3Cz8ItdPFgnhb2OGB2AySVdYRdfbnhm+7OR+ZaKfKiPbtapR
         0AEF/Z0etJ/fN4UR5stL+Y3g71pk8IK4mSbTiYsSOrt4HpE7tb/1FydRu29FfKfeS5cg
         jlpVc/Up45VI0fBAn0Nm2dE4BCZ8cqCOVrGFYGuiBP+QtuPGTQ/nydDXS+aOmcnZ4+pU
         L7yc1zOgwRpzh56Pi80oWDCvx84AvqFxDyXtZEyBSvfR/k31G6q+5bc6PPWi3A2DgBYN
         uBCA==
X-Gm-Message-State: AOUpUlERQQahbgJFNWzVd2PehDscsPVwG9DMTycWyiKYBU4TT6g5jYB0
        UqOIyfpxzpnZUQMdbAv9DeoX6Q==
X-Google-Smtp-Source: AAOMgpdZ8/o9HNiwHhuAEm5UBveg8+MZLI33sapLTWVH9rdfTyCJTuzH8+tQCSioYY35qBfJTtWXBA==
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr4073238wmf.146.1531486249399;
        Fri, 13 Jul 2018 05:50:49 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f76-v6sm8541524wme.30.2018.07.13.05.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 05:50:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: add DT documentation for the sound-name-prefix property
Date:   Fri, 13 Jul 2018 14:50:42 +0200
Message-Id: <20180713125043.13242-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180713125043.13242-1-jbrunet@baylibre.com>
References: <20180713125043.13242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/name-prefix.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt

diff --git a/Documentation/devicetree/bindings/sound/name-prefix.txt b/Documentation/devicetree/bindings/sound/name-prefix.txt
new file mode 100644
index 000000000000..645775908657
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/name-prefix.txt
@@ -0,0 +1,24 @@
+Name prefix:
+
+Card implementing the routing property define the connection between
+audio components as list of string pair. Component using the same
+sink/source names may use the name prefix property to prepend the
+name of their sinks/sources with the provided string.
+
+Optional name prefix property:
+- sound-name-prefix : string using as prefix for the sink/source names of
+		      the component.
+
+Example: Two instances of the same component.
+
+amp0: analog-amplifier@0 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_3 0>;
+	sound-name-prefix = "FRONT";
+};
+
+amp1: analog-amplifier@1 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_4 0>;
+	sound-name-prefix = "BACK";
+};
-- 
2.14.4

