Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02012083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o2IbnRjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02012083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGQQQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:16:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38767 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbeGQQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so1734807wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTkflaydBTJzVf0ZHkleSoX0FARPEM+k3qhZfYkvVTE=;
        b=o2IbnRjNYWuLXiTnISziSIqs8i1qAN2K1thxLHEt60Gv7oMpwwxZe54qQxipW9p8cP
         o/mEBbSMR7SxL4Y7Y4HoSSHKUfEDQhma+Pz0Inc/DY/Jb/hmnlAIPkPap40iJ1C82uaZ
         wwf/p3a58KX3gSu3yu08kWF34Ubxx01kT2P4e/p758fIZ986+IKWJfoSJjnwH0EVEvib
         Y5XN6AAEEoazChwinY8TBLqj0/cvVebKlawvDRL+jSy3WXs/c/jyHXVSIX22bdq2mnZz
         nyT2O7dyLI+rI7woKmnbGm7kN5KbtllaZesR6Qjwo9tNWmy3/quCRZsRHuUTmsJMykOo
         4usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTkflaydBTJzVf0ZHkleSoX0FARPEM+k3qhZfYkvVTE=;
        b=pY+Bus+lrn4IS622q6xSIbXQtjpt6ESL9RjlzVaYuyB5YMJ30kP7QJQMpDslHrscsJ
         UXrjzaxkklAMVsMJ0fCgCnalVwzdLBv1tNpUOQcx3JaQFkiJk+LBzn3r4lVpb9euWk9p
         U7rOReZJOOjWo0PU7aJbX1gUabw+0FC2gsfq9OaxyOHzIS2kBTQJeY7ZQO71hqqUn9rS
         KGziECn+49Dg/m3gR83Qfkp+7GtScLH1bftcT3yx66/Kbi/xU8PEAWRiR/49IrWsXlG/
         GvVQpMlzF7+mRfStzq4CmEpo/r+8Rou06TfRlyceuf621UMY6rKSbkrwLvrqz/1I5FfL
         kUIQ==
X-Gm-Message-State: AOUpUlGQkf69PLz4BlAI6Pvx2ivzYb93oCwPGpVwI7X2CP1JiXUccKKf
        myEeMoRKQ+Oh1ePbU7LCgniG6g==
X-Google-Smtp-Source: AAOMgpcPxeFv4F8RiC7n/qylbz2QuH5Mfl4yWAV/9eCA49wnxlZg2d/IcSOkJ+W4akLi9vBUg3lG6g==
X-Received: by 2002:adf:b2f4:: with SMTP id g107-v6mr1847981wrd.53.1531842198784;
        Tue, 17 Jul 2018 08:43:18 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s12-v6sm17598252wmc.2.2018.07.17.08.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:43:18 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH RESEND 05/15] ASoC: meson: add axg spdif output DT bindings documentation
Date:   Tue, 17 Jul 2018 17:42:54 +0200
Message-Id: <20180717154304.9973-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717154304.9973-1-jbrunet@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
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

