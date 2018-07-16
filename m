Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC95208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kXF7li3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC95208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbeGPKjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:39:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50927 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeGPKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so14590191wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KWehxplu+ULl9a/m1vuMcbjaWxLdOrl+tmPJcIPpeww=;
        b=kXF7li3Y/xkCQYprPoE6RdjkzWlxhW4ulJp24CqFSZYrjCUt7YXo+P7Ud+Azf61GJj
         EPCr4GMkR2+SGiAU3ExHbWVPUhPFuyDovdKZ+pA9/3i7iPlYYmFLxDY1wFESdSIutmP2
         +2wByQVWPdIgkqKhAXisVsibP6EA5SZFdIpWx9aozeR61K/UHbZR1HaGNAD87pU/sJWk
         7ylHjv+azMExacgeRYQlQuY39Ox631C2RGbweTWFjF19Zm7gux1AAZgY9uPUcP9svjN1
         18DZq3sB33ebGh18QubRtdwgmWH6GuX6S6QmZ987mmFYmAOnnIUCCjYaSjtgBH9VMm77
         fTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KWehxplu+ULl9a/m1vuMcbjaWxLdOrl+tmPJcIPpeww=;
        b=SUoJq5xZzIKZVQwTAkS86R7eRqUP/EijUNoXYidHNXSfEI8RFCCll6u7LuiVEpRsj6
         k9lJDOwRXXHL7fNmXFu7cM8BrDiYBFlBAk6zEfRpsNbQZdq29IhFyzbuSzKap61vC0qC
         /76KjSWybEHVHyqarESLXgh5NA72RwAKsasapynAnUN91zJnukcSnyLQEmkuqIMNJcyJ
         g9yqT83kqjPonImk4Yw16WZijB+yFGbalsEHC9jdbU/p9JssspeZdXuTE8xEBTM//u0U
         UQphhwdeYypYY+nPoMcMFNgvigpI2a0Yh4JY6Z5ntfcA1G05s/1C9GILWQ4hENFzkmJ/
         iMnQ==
X-Gm-Message-State: AOUpUlHStv1uvDrjaoKrmFRsBPZCF/v+YFdu2qbxO7W0MspUJjg56EmN
        UMuuYxWtmSJs+a4pxXQTK+rhGw==
X-Google-Smtp-Source: AAOMgpf4zNy1L5HEXvPwYzD0mEFIBNlcbWnJyg7+VHx7kjPxhpc5B2r6fP7PWBWDelqqSvQ9mlQqPw==
X-Received: by 2002:a1c:1ad0:: with SMTP id a199-v6mr9568003wma.131.1531735915915;
        Mon, 16 Jul 2018 03:11:55 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h14-v6sm10219094wro.15.2018.07.16.03.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 03:11:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/6] ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
Date:   Mon, 16 Jul 2018 12:11:46 +0200
Message-Id: <20180716101151.31109-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator should not be defined inside the SoC dtsi file.
vddio_ao18 is already defined in the S400 board dts anyway.

Fixes: e1969df34357 ("ARM64: dts: meson-axg: add saradc support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index c87bafc4b101..08e5f431c025 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -91,13 +91,6 @@
 		method = "smc";
 	};
 
-	vddio_ao18: regulator-vddio_ao18 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDDIO_AO18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.14.4

