Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF8EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025E928052
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="muw+ZUM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025E928052
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeF2PZH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:25:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40151 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935215AbeF2PZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:25:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so2485949wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsd6m5/jf1NYKftQIH165+Sq4V8oS9AKP16X1iBrgJ0=;
        b=muw+ZUM6mut9J8Oz+xsmQE0CCyTnXOgAljMfl8V2gYwkIVdtXoOWzDLqZJO3MX5AUg
         0mQ4Fswsc/3jxcvn3oyfO6hEtql+AcYbnT7YZ6krQ0RDSL/zfDaXlE+jHXwFOXrEp1VT
         L56/7bDLwJLyQ+ORTkwlhkTiuRvkS8106hFNOf8I41M8BUKunN5H3ThLaNlLsqSBsAcd
         Z4SChG/UvKzskTU5JW4cqMbR6g+RAFpOLQ4sR3DXs95D0gww9hpvSuPNhU41/a3ZFz7d
         g4+8f4H3NJfmZrXt2nDxr4OulvAgeos411R9JYYJ8hCw0ZspzGEaRVq0CM/Gxxzlx+xA
         kKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fsd6m5/jf1NYKftQIH165+Sq4V8oS9AKP16X1iBrgJ0=;
        b=MRBGbgqXR0DjCu/XEyQKwVa1eTbaEGKfhfOrN0kvndAfUqreHbZPBneleiSvre832z
         kowafMdv4Mx8lgSyOfI0LIyk0oIZ7sq672R+A21Azkyc3RtITeAP5wuNgJeZnFIVECIp
         O4ZB0IXpYK29A48N2ntyJOYV4TV2AiVRRgK6tQx6nxCSLfwS/iDC2sRDJ8HE92b+ZVM8
         vZzifhLf5pTuwpjm7W6Ygtn89HSOa1obFZjx2pkYzp4HmOjXNqfPYhiOO2zFWErTLdy4
         AGqcrtnGZMinNIYM2MvbMj4R/QwNqIXHZH8Kel8ZCm8gF7BZsqT+TyEHoilODYUNRaXd
         b0xQ==
X-Gm-Message-State: APt69E0Mf3+yOzv6O/aK/3t7UjppkrAtxYfMosRMPa6FPDhl2SgQYYHF
        KmKIBtwoV+GLOZAS+7S4GdK3DQ==
X-Google-Smtp-Source: AAOMgpcY/N4QI7vMzFG97vrzGN6uDEqNlL8M73MAm4eoraUQ7UrCI1wJZgCH5IncnnTEMgDXopBm2g==
X-Received: by 2002:a1c:c90:: with SMTP id 138-v6mr2039917wmm.110.1530285904194;
        Fri, 29 Jun 2018 08:25:04 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q70-v6sm2754659wmd.45.2018.06.29.08.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:25:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: es7241: add dt-bindings documentation for the es7241 adc
Date:   Fri, 29 Jun 2018 17:24:43 +0200
Message-Id: <20180629152444.21525-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629152444.21525-1-jbrunet@baylibre.com>
References: <20180629152444.21525-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/everest,es7241.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7241.txt b/Documentation/devicetree/bindings/sound/everest,es7241.txt
new file mode 100644
index 000000000000..adee52281b3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7241.txt
@@ -0,0 +1,23 @@
+ES7134 i2s DA converter
+
+Required properties:
+- compatible : "everest,es7241"
+
+Optional properties:
+- VDDP-supply: regulator phandle for the VDDA supply
+- VDDA-supply: regulator phandle for the VDDP supply
+- VDDD-supply: regulator phandle for the VDDD supply
+- reset-gpios: gpio connected to the reset pin
+- m0-gpios   : gpio connected to the m0 pin
+- m1-gpios   : gpio connected to the m1 pin
+
+Example:
+
+linein: audio-codec@2 {
+	#sound-dai-cells = <0>;
+	compatible = "everest,es7241";
+	VDDA-supply = <&vcc_3v3>;
+	VDDP-supply = <&vcc_3v3>;
+	VDDD-supply = <&vcc_3v3>;
+	reset-gpios = <&gpio GPIOH_42>;
+};
-- 
2.14.4

