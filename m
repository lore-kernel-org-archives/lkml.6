Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7702C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8920849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RUnwFh8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF8920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeLMOg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:36:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35955 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbeLMOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:36:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so1271671wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m88udau/ikGQTftb3kkyEEVxwlYtl5cz4zTyGujJo8k=;
        b=RUnwFh8tQtIHv0gaQ9xRx+HkM9ckL/Zh3HAN0c5utLU5cezOpHiPPkiS/pK2qwLYY4
         +hLmVJoU3B33JpdRQ3Ohvwj1/tCBPgus8KjnVWyfYsW4G5rBCWxkX3LEmTZDZZABOCP9
         5yMRwtXaeavutUD7KQSCse1SE/YCkgrK99jGItZU9t9b7DLQheBfdAWldh+JVaB8hsHC
         OGMJPa1UyBgLiijjDpPBc64cKJ/fEVqQ/ZqQOTrBsaVt0cRUctB5r/u2THl4RDWRNcjx
         0N4Jo9GCMsoJ4mGbe3mB+D0kTunBWLKiurlGimsbouOdPbUA+TiR0aWKXGYA2q8wWv04
         OtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m88udau/ikGQTftb3kkyEEVxwlYtl5cz4zTyGujJo8k=;
        b=joyrSN4+PXoexQ9ZNsQHW5SakER0SnKWqsoIRs74LTCACeWq/Pz+bFG2FYoQGcEHiY
         j56wPzMXhgMnRBFO6wQAtmCHC4PFRTSxIezhVopmi0zyWmrC36SqUdkeIph8NniCocap
         Hg8Kgn5CuyZdtKrK7IoIdT/TWxSpwWCxXJpPUUjXRDyLH2rcPeHDcXfjETZxqO7DCMEy
         K8lznnO5THUfFHpPMPCukpUHXueKNfwmiNP5+vWfri83p3NAYSeHTHqFNlajsVAAJrP7
         xpuYoWxNnF6yOIl7a6CfX0UopnnVQqOrMhRjQaKCXI5sUeNhsker2Q2AzSoGDp82T0Ks
         kYjg==
X-Gm-Message-State: AA+aEWarG1annuSHGJ04VhwQi9eMeHhRVW2iilAa4XzjLUc8UNi/ThQ8
        mfzC+OpPxPKQ+mXVJh8xoKNhHg==
X-Google-Smtp-Source: AFSGD/UabJYkWYrgD3gYyk95at84HwJGThzAIrfdZ0SO3fbEdfwFIIIyA/zirgiJCzC3H3OBNVbj7g==
X-Received: by 2002:adf:9422:: with SMTP id 31mr22766966wrq.106.1544711802495;
        Thu, 13 Dec 2018 06:36:42 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id e12sm4929930wmf.22.2018.12.13.06.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:36:41 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson-axg: s400: add spdif-dir codec
Date:   Thu, 13 Dec 2018 15:36:30 +0100
Message-Id: <20181213143631.19218-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213143631.19218-1-jbrunet@baylibre.com>
References: <20181213143631.19218-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDIF capture codec to the axg s400 board

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index af2f2619bbc1..2f622a0b599a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -95,6 +95,13 @@
 		sound-name-prefix = "MIC";
 	};
 
+	spdif_dir: audio-codec-4 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dir";
+		status = "okay";
+		sound-name-prefix = "DIR";
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-- 
2.19.2

