Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069FCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8FB208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a8NR4dqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8FB208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbeITBxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:53:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeITBxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:53:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id y139-v6so7536137wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XuiR46Cyp6YLzVFynzfpuZrH1BFvmu65hg5EdbMQNkQ=;
        b=a8NR4dqIhoWIFlonUKf2YPe2cbqeW/3qimzrqI7plSu8Eda3sGnj7tat95C7Ir6wcz
         5zWIzB/NmqcQgOAfkbym8AeMUMwfBQkK1theVZ+aD648/+GgtXwnbHZ3/TaYb85v/3r8
         zOJdIfvI/DgpUR+cgovti6HzMIRjQ7DhwE7XfrAPBsmNFfEuW1m9NNT2ompQIunUDOrU
         +1o234s3KhKTmPd8NmqwDUtS3i8MYmcIBM9PbklITPYR/G2FvtN1ILUoraqhX22viMZW
         hExFe3hRjEutv6OuuLv/tDJvIhg5/f81w9Ytngh7oCqfUEhB4APrdWFzmBAk6uPHyDap
         Kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XuiR46Cyp6YLzVFynzfpuZrH1BFvmu65hg5EdbMQNkQ=;
        b=c+ADBT+fzwdd8DDRKS8KwOgat1r7llt2t4rwX5W+2so3B7kZnR4MettvHbLiMfJ6ry
         /QA/pCtNnGPwG2S9qhW4F5mPMl7FzSVTPUVRKoHj/uLZ1x8z4r5huPEtl1dVgkUQ6YO9
         vHAQ0RdQ6bgK9SToHfq8YJI9RESjBx5F1IyHKdqrX1QBlxNhvq3sXTwKNkPd04kWBF5O
         PG8Vke/T3LnswWq8xanjlYZAtVtFRC+SA5JZ8w0of9c7ElfhF5NO+lfi9bXzu68wm/I5
         pmzfLty+u6fCqWPfW6Dz9O8PR6rxcyUQNtMmDmNdRCbwfKdA/L8lNZDrioZuRd7bLKXH
         6lpQ==
X-Gm-Message-State: APzg51ChP//DpcuFlliwjfGtct6yG+rV2e1onkPtakYc8GJU11xFStXC
        zMGb7h7k21CHaCMW1TJCN2z0uw==
X-Google-Smtp-Source: ANB0VdZC1tnkXai3naDEgxBj577k6Dxo3NPWhBYrcn+ksV1wHgtWt9e8ocQ1qaPvJ5gBtj0I8cFgTQ==
X-Received: by 2002:a1c:f03:: with SMTP id 3-v6mr21967505wmp.129.1537388061554;
        Wed, 19 Sep 2018 13:14:21 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id g129-v6sm8130649wmf.42.2018.09.19.13.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 13:14:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: sun8i: sun8i-h3-nanopi-m1-plus: enable HDMI output
Date:   Wed, 19 Sep 2018 20:14:11 +0000
Message-Id: <1537388051-39623-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable HDMI output on sun8i-h3-nanopi-m1-plus.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 65cba1050802..88b5ff6b66b6 100644
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
@@ -94,6 +109,17 @@
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
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.16.4

