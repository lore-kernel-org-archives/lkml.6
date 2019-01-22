Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B51C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523E221019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/qt11LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfAVNVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:21:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfAVNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:21:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so11487802plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OIolF++DBLb/hz3Yaz/nran8arOkyxEnLLroytUGF80=;
        b=a/qt11LKV/+zOK/6ySzuyxvITAkl0FBYgrPDH2o8Eg/GnYgfnPn4dUbMB4m/WuwfKt
         W5/vXs8ovAyg+9wKWFfOQPzOXmKsKvkPZxnpOfxRrtzIj4TLWZEQU/yzlImfXkeDGLAW
         bKlqJPoGSHfAB7G4IVyqXOzcRhBXBD/50uvYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OIolF++DBLb/hz3Yaz/nran8arOkyxEnLLroytUGF80=;
        b=hHG2/JTROk5vIFxAvNOnAa2s3rBrG6qb5WFCIUsiqKpI1NTagQjEEECtu2ZMLM8+hC
         m6LnuCW+6oJIikKxKPzgJ3urXg3VXwductHU20sW2kAE9EAx3qcO/a55St/SL5wuKmvd
         vRPhtZ1X966XzMlBxJ9Jl/oNSunamfyiBXSv3siEHaCbfsb+ipRw456EWyp0n85E/W7Z
         0EO8t8F4sg7ikz+cn3SPoWRvIh+hEBWj9kOgDbEWGAchIfkCbyP1ZtZw39E36cg8puKW
         he2QK7FDI5M5nf5uYfaRadX49BAv8c1oya53+hEjTmmHIFotqkmo79K9GaI02lp2isty
         xjpQ==
X-Gm-Message-State: AJcUukdtVLY3g+G1aNyK/2Ncl3X+C2aaHsQ8PsCmqe3ZVYkIm1hJJ8xy
        ZO7hexS1rHTzRTYPa8c8XdVfHw==
X-Google-Smtp-Source: ALg8bN7/0SWz5gYbYU9eFTAYHI9OW8/XaHf5Zko66LCEWBGbg7qvDe8YgkXXlE7R39+JwugTQmyOUw==
X-Received: by 2002:a17:902:292b:: with SMTP id g40mr34579416plb.82.1548163312908;
        Tue, 22 Jan 2019 05:21:52 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l185sm21609574pfl.54.2019.01.22.05.21.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 05:21:52 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     arnd@arndb.de, olof@lixom.net, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 3/3] arm64: dts: sprd: Change 2 cells to provide DMA controller specific information
Date:   Tue, 22 Jan 2019 21:20:53 +0800
Message-Id: <44135b35c8a4fb1a68bb9c57013b672dd0fab3e7.1548158832.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use 2 cells to provide the channel id and slave id for client.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 34b6ca0..dbd61f8 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -117,7 +117,7 @@
 				compatible = "sprd,sc9860-dma";
 				reg = <0 0x20100000 0 0x4000>;
 				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-				#dma-cells = <1>;
+				#dma-cells = <2>;
 				#dma-channels = <32>;
 				clock-names = "enable";
 				clocks = <&apahb_gate CLK_DMA_EB>;
@@ -273,7 +273,7 @@
 			agcp_dma: dma-controller@41580000 {
 				compatible = "sprd,sc9860-dma";
 				reg = <0 0x41580000 0 0x4000>;
-				#dma-cells = <1>;
+				#dma-cells = <2>;
 				#dma-channels = <32>;
 				clock-names = "enable", "ashb_eb";
 				clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
-- 
1.7.9.5

