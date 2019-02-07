Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A8EC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588662175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kMRtPItA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBGN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:26:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfBGN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:26:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so6750197wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XylRKB64rC0etlFc8MGnuHKrAg5r8/oAGOA99T2tC4=;
        b=kMRtPItAaBPkNvo3gAV2Y9er+9FSAnNPV+ICuvBPuMmMMV4POhRy7nveOWRwQZz5uM
         MnU4x1Q5o/XVzzv9OjHiEzS2NLR4bBrtEdEviWTkA8ubXKlzPsfj3HBT93Z3/ubzfybC
         sdm6rQJg5wUu1HnKVARHuXEy3WYZ9Ncd8L3GKADrpqD7GdzU8PUnStc4tywrEp0JKLRy
         oJD4Z2HWu4QaGCIBHKExQ9KlZXDt+Q6clRkZnv+3L++E1UR9kWxyijizFarutBgPvC6b
         fppEfZUsTXguscPeBeTo5U3Np5ME0zfJ0mFcP+xFYXY7DSc9W8v6UWSRSz+IVwDMGK1k
         FJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XylRKB64rC0etlFc8MGnuHKrAg5r8/oAGOA99T2tC4=;
        b=fQ8S36oucZlqyG44T5EkYQ+Nh/EjHtMDjMcfI61lmrkKAY+jFJ1dOpFg9BqsXSkWIY
         vYuVV8Ns24KyCgzD51v8y9uUWYPdm+hIuakiP1AGB6EH/reNtPQRgxVZL/WhguRN7dI7
         y2plW6aqnRr6Aa81Ld5hpPxBS94piuxTErTT6akqvExcUXe9H1u62iBqDHBzuZn1nZyV
         IGw46rn4WDGn+A0vYb0sJE59upot7uFXO/l4Xscz65wms+IwCEfldgOV7s581xvydn1F
         QFp1UIU6iVJ64dVDSzvqjtkRupRnjJwi+zX6kWqwmF0NTKMCehSBqPhUkAFHVtUTLXWS
         Mh9w==
X-Gm-Message-State: AHQUAuaJH3MPPDCIrizmicELB2itrII8ro08txLP38QRGc7N57IXSboZ
        sbMl0QOiAR9aCkWMISKfC0j06g==
X-Google-Smtp-Source: AHgI3IazHRtY/RT/wDeZ+hWjsf9AxYG8eJn5ILrK1Gs0DTZgAxISkZ90bOPieDKYv5UpyabnUNn8Og==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr7266686wml.121.1549545984743;
        Thu, 07 Feb 2019 05:26:24 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id v22sm11061612wml.37.2019.02.07.05.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 05:26:23 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: meson: g12a: fix clk_msr node
Date:   Thu,  7 Feb 2019 14:26:02 +0100
Message-Id: <20190207132603.694-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207132603.694-1-jbrunet@baylibre.com>
References: <20190207132603.694-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk-msr node should be in cbus.

Fixes: eeca2cf15e05 ("arm64: dts: meson: g12a: add clk measure support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index c9d53103a58b..05ea750b8c16 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -217,11 +217,11 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
-		};
 
-		clk_msr: clock-measure@ffd18000 {
-			compatible = "amlogic,meson-g12a-clk-measure";
-			reg = <0x0 0xffd18000 0x0 0x10>;
+			clk_msr: clock-measure@18000 {
+				compatible = "amlogic,meson-g12a-clk-measure";
+				reg = <0x0 0x18000 0x0 0x10>;
+			};
 		};
 	};
 
-- 
2.20.1

