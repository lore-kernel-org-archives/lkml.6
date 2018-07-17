Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83791ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6A720657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YM9cOJrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6A720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbeGQQRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:17:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55282 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbeGQQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so1993272wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aX4y48Nr4mxrNaEm41GH+dJkSDI+nV532cD2B8cBj8=;
        b=YM9cOJrAEiWK6K8XGSYa4RTz2z9cC5aiKtQ0BA1F/uoapQLGZPJoEGSJLEwvRUdkbf
         DIsyaYrRdjtifEH6v8sNoDr+AkV7gCtOPzrvd+/2noRwizI4XXjHGnU+1iBJgASSdwDo
         nGDhcy5JOkH81+P/KdggE/SnP/g3w8yQsTGyliTGXxmRckZ9ZvNy8LIWwdfhAIqT+pyf
         Pfncxu6iTlHQPSrWshe0FhuM+F9x1tKs8exRJm5KY4NXpT9xbYpY0d9W7G98yizjJmSO
         kr0PF9jhh7M4Nu3493ISYY003IySbEoDDz7McJnYDw93AeWFvmjNLsEIo0Zb1Kd/MQkw
         K6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aX4y48Nr4mxrNaEm41GH+dJkSDI+nV532cD2B8cBj8=;
        b=L2Bg1WorleYwyQ0DtbaCrD+3UjFWZ+Dr2Db85PuAScCgK5klXjwfkGIA43i72HEZWU
         iL89aNQNfzvwQP4MV7914GhVragvv8/PJ57Jm3GiJ27iExAurs9X+oVhVOq6PO20hPBj
         H/fzS7Py0UaLz5C4/jvcCxK/UcXBke17DKWArKHM50jLdUMXeqyy0rXEH2tJc4bt+mkE
         Hh0CoMKNlPKFpI2C+VFJwKn/3hDOpQY8YIAYJUywuQDTPO47y7SWzVc7onUeq7ua0hIH
         QaEhY1GDzMcn/XUJsJPx5iUvAdrajPRh5Pkg9kWkhrjYO2glRy01p98kdKUB0Jv+KUbU
         +3Cw==
X-Gm-Message-State: AOUpUlELK874Ct/SmRX7a6JTCdfdCgs6dWdgoxfQcat6r6fMhmRpqwAv
        pe21blWvS5USz4k5PiO04QErWg==
X-Google-Smtp-Source: AAOMgpfwLHrQ3nHY3DIUCniu4lDz5L79Ie4VFbhmBNAtQD/mycgSAE1mqCL0tjVKm+afDgXOixtDPw==
X-Received: by 2002:a1c:dcf:: with SMTP id 198-v6mr1720662wmn.131.1531842202160;
        Tue, 17 Jul 2018 08:43:22 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s12-v6sm17598252wmc.2.2018.07.17.08.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:43:21 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH RESEND 08/15] ASoC: meson: add axg tdm interface DT bindings documentation
Date:   Tue, 17 Jul 2018 17:42:57 +0200
Message-Id: <20180717154304.9973-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717154304.9973-1-jbrunet@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
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

