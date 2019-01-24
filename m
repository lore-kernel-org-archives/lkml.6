Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982EC282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D0B218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GJQucvAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfAXRxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:53:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36429 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfAXRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:53:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so2983935pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbsXHLYVuaSSki/5gBqN9dEz8c1gbFJZDIVccUSbq1o=;
        b=GJQucvACT94g+OmxNwrimLVxF9hx/p8FuwbEf5GkEcQMZDKqXdcwnyzauzN6u9aq4A
         qbjnD1ql3Zznl7t4N1m3D9bxsg2IxPgevjqgdRR/iI8SYO9x2/uc+MrqzdDXPsikKyGL
         60VirQn1DS49BkuwbVqtR/YEem/1a9gHOfb/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WbsXHLYVuaSSki/5gBqN9dEz8c1gbFJZDIVccUSbq1o=;
        b=sCRLlqBzNwFwVgDXOJbGJI+nuLZM0UdHA5gQzB0OG955qUX5d1ioAXmUsBQwo1y1Kd
         51NRO/QbI5QY06biJx7SOFufvbr/E3Y+QxoJPuAPoBCzVwC2TndnsOOu3wFJrhuBLenw
         tq6f64/lCX5XjCBUPnR3YtiOvWz4SZ7ARflYsMxhkEKPVebXU0fdp3c2MUN1vpsyTgnK
         GkcPH9VLh+dIBISAXe9QZBY7dzdX0j0j90Rw4OP3xYCRd43tGeMD0+NzAhqAE5QNQc0y
         GvWmLDq3np5uVJmx4pcysfXRaSw/Zukt63hIGvXh7hxm/0fPMAKgBl0lv5998487Q+d4
         kI3Q==
X-Gm-Message-State: AJcUuke2vUZ1FuOTYQvXdwRFIeMDCyYPWkuwjU/bfTvtyzb1hCRu97em
        qM6Eok8yIstCmTE1qVZwyNOLABp4348=
X-Google-Smtp-Source: ALg8bN5naYAcJ/Pi4m1FbHpyWwDfbl1lgEGaHg3wMUMF5Pk2fjN76mKZ/Cw/+jjLmS2IRI4NfE4p/Q==
X-Received: by 2002:aa7:824f:: with SMTP id e15mr7290447pfn.192.1548352412780;
        Thu, 24 Jan 2019 09:53:32 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id r187sm77989332pfc.63.2019.01.24.09.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 09:53:32 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: dts: allwinner: a64-amarula-relic: Add STLM75 sensor
Date:   Thu, 24 Jan 2019 23:22:54 +0530
Message-Id: <20190124175254.27650-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amarula A64 Relic has STLM75 sensor for digital temperature
and thermal watchdog.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: the respective driver change is already in mainline
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2e9a41bbc1079776dabe42ed8113b086b99ae56c

 .../dts/allwinner/sun50i-a64-amarula-relic.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 6cb2b7f0c817..5d942543d978 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -34,6 +34,21 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	temp@48 {
+		compatible = "st,stlm75";
+		reg = <0x48>;
+	};
+};
+
+&i2c0_pins {
+	bias-pull-up;
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-- 
2.18.0.321.gffc6fa0e3

