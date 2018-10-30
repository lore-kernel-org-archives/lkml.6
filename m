Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F77BECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC84020870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WRdBXun+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC84020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeJ3TPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:15:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41908 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeJ3TPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:15:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so11920118wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ldt4WJfI4AQU3DusZodwyg3UdR/b7k3L1OUI368L5js=;
        b=WRdBXun+6RJXnuDEuatGFExhIB5+eaIgJBTeM7RBuldCHfFaoGgAnR6NsHpqSeDKVq
         n9kSuaFr3IkK3F87+XlJNuvrSPS1LV0/Q4fbcGpE2hkY7K4Rnhp9SmlGorRIEh4DvkNd
         km7Keq6Uf+7b9UPQgjPCJtjdk0UavGUv2YwA8wF/7ZYjiKXEhGTfmWmRjTMcCmniFog1
         tX6rQOB85l4ti+mLWdjovNcvFoTDUXeMZeyiljHcvf8ol3GkfkZEggYpoNTW5ikZ9ZJA
         8kor1L78X+oO+T9hVMpsl+s4dHxqSmL1M+PectcNE33RGIxmDc01pvqICwWcDYFTpnIr
         5zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ldt4WJfI4AQU3DusZodwyg3UdR/b7k3L1OUI368L5js=;
        b=mjcnAcEoG2FbODEx8DWLFr4CZEdl28WSVKyJJ/6OukWnrOAAc9bXQcdrkSPY7utK9B
         vrCsVRFlR95pY6HMzWS2xFQInePNfO1FIqcCEY1ToWy1odXEQlFCn7iC2qQfK/lbUayO
         i2eL9B9HWTEC6Yjbianx2a/fw6XThfoWHRcQabpKv7aL3Mft71p6IGu/FtY1P1CD3auv
         7GYKDiIO+4QUizm02BtiAq63bDAHuplsWDqC0oxsQ6L/Eijweml7gFXklaSe6E6JuL91
         wE2T/a9tugG5ODeG4jin5IY5PknfJ5pgSPOCerhNdag/5Z1TmLAfI8oquU2XoXXTPEGj
         hJkw==
X-Gm-Message-State: AGRZ1gJks7w+tjIQrLVuQlriykdmYRatiBkYWeqtM5Y6Mnyk1+SJ6AQS
        j8VT1vY3hZqe/MRRXVN8wNC75Q==
X-Google-Smtp-Source: AJdET5dl2ogEPQnxe6yMFr7g1KHIfKHvVj9wG0JNyf8Xj7SEpXrF9caIk7RrZ7P4HQWe0kT9WPODag==
X-Received: by 2002:a5d:5086:: with SMTP id a6-v6mr5550614wrt.31.1540894961593;
        Tue, 30 Oct 2018 03:22:41 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i204-v6sm26638614wmd.28.2018.10.30.03.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:22:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: meson-gx: add efuse pclk
Date:   Tue, 30 Oct 2018 11:22:30 +0100
Message-Id: <20181030102231.4851-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181030102231.4851-1-jbrunet@baylibre.com>
References: <20181030102231.4851-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required peripheral clock for the efuse device.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 1ade7e486828..524f533e41d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -282,6 +282,10 @@
 	compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
 };
 
+&efuse {
+	clocks = <&clkc CLKID_EFUSE>;
+};
+
 &ethmac {
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_FCLK_DIV2>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8f0bb3c44bd6..8ccab9a1ebcc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -75,6 +75,10 @@
 	};
 };
 
+&efuse {
+	clocks = <&clkc CLKID_EFUSE>;
+};
+
 &ethmac {
 	reg = <0x0 0xc9410000 0x0 0x10000
 	       0x0 0xc8834540 0x0 0x4>;
-- 
2.17.2

