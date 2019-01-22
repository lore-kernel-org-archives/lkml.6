Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3256C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3AA20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z4yHd0mM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfAVHq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:46:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39748 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfAVHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:46:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so13077901wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zWujFp1sxIXzRoLjmY4y3kr0Z+vcNH29TjUq5dOgR2s=;
        b=Z4yHd0mM1YcNoTUS7aFQGHkpQ3HGB4OsRux4/lojMTkPIkxWOvjwmxQQdv+RNE0v8M
         dV6fYN6N7L9tTxGFsKFifzYTA0ldiAW3cjkygiBwnXYoe0pFbuHKRGIC9I2coTIPc1Eg
         oBwo6SGc5kjIIiwZU+3Pm7nioA+pcto5IH9lW094Nv0LbKv1I/cLdSlLCf11WDb8iWso
         3R9aHDDK9DNLaIBO9WvIa+9oX2GBA0FiZIYH/r2a7VmXwbnZhtDLEemXFRZ+5XB3TswB
         MLmrJnvULaHhZl4kSNvBVbfk+EOgodx3iQqT2aqF6boumOob5NLWQLQm6f7RseDclA+2
         DXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zWujFp1sxIXzRoLjmY4y3kr0Z+vcNH29TjUq5dOgR2s=;
        b=l3D6YqYkYEwOTibmXJWpGumWTnz2ccjbsGGay2MwVZSgT3m3SbM6OyJbAyxTj2m8Sc
         GvZp2GFXZZZCpLK/r9eCHn3Mwp4ZYgbC7qAC9rm68jVkASZAZ73vJfsw0laM3KL8smjp
         nd/mOA+TFrZdh1pEGk3ziy81L0oEvrnGAPJakfIFFJShCmSccfh8P1MEkRytJHXBef/f
         eUMkEQwtH19lKmzcvk4loeActiAFA1ts7f0Rwb7zbHXfqd5MM87e/JfbDtU5Vh1o5XIe
         nuTUYcMA69rX/Pw6JEXRJMDk5mpTxvqehxOTXgoG38R3NYCUAwYzLF20/E7jjX9kMQoD
         RJkw==
X-Gm-Message-State: AJcUukeNKXebcymf9dA5ZE2PDGmqi+/y5+uLCedom3R93IHtjC3LiwuU
        Tf6pMODpa1em6RVqaFMypU6gYQ==
X-Google-Smtp-Source: ALg8bN7vl8/Hwn7aZfLcgdvniz3RDOzhzlFxz8iiQ192towOF1h8ZKQmTB/8AhKYWIBkX2wTK8mjnw==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr2465052wmj.14.1548143215495;
        Mon, 21 Jan 2019 23:46:55 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p6sm123766439wrx.50.2019.01.21.23.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 23:46:54 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] arm: sun8i-h3-nanopi-m1-plus: enable HDMI
Date:   Tue, 22 Jan 2019 07:46:46 +0000
Message-Id: <1548143206-11404-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable HDMI output on sun8i-h3-nanopi-m1-plus.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- removed status=okay from hdmi_out
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 65cba1050802..4ec94d72f021 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -67,6 +67,21 @@
 		pinctrl-names = "default";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+};
+
+&de {
+	status = "okay";
 };
 
 &ehci1 {
@@ -94,6 +109,16 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.19.2

