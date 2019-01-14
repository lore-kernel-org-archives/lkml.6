Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FC7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C55206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dK7IFjVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfANTqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:46:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35122 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfANTqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:46:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so868522wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV2BJUAh/Zyb+wEm6tQ/gGD02vRQpuBa3p/N2HQnIFE=;
        b=dK7IFjVnrOmKfnc7HeXr0BFTbh9AHYrG1iKkfxpJ+e4zjYPqTzW1Ot1gbdJortT5+f
         2oa6CnqbVEjDdKq9JYk2yC5DM+gWwjNND8bh2j+SZ8xnz3azqvkf5anBByrDJDTHwEk7
         ZtaGLyItOIOwac8F2asTEIIo8+0MAFmMHbj2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV2BJUAh/Zyb+wEm6tQ/gGD02vRQpuBa3p/N2HQnIFE=;
        b=rq05z8wv9ez/Z7HSQhvzfMTVIhNEyG0gNQ6rfRgDJm4bfXCASUK1NTf6Rn+vMNERLz
         aTN5wsuAFZJzNumnLWKU+OTio1nxrojmzs5O7Zu1nP6F379E1/HiuWCZicOH6X2VS8MH
         cbvSq4AIawY3QQoyV9oUYYHqzc1JdKL2FUlFzHRVWUqteCLCz08XqcwG0NAEtWzDt81X
         MRZdoRva/5a+b6H9nSQb9lu4dS2diHRKy2Uy+8m/5G1IyqeB9GzDHD9rABerjOnE1MEX
         5cv7LYDmqS/i/KQL6Jfv9lQi2jLydaJnNpPKiQeYOtsYY/uoj7fT7LNsCWun3Tjw5qN9
         a+/g==
X-Gm-Message-State: AJcUukfBDnCKEE0oS3u227q+yC+fkomSECgcnEZ5SwF89BSg6MZc+zIi
        IRQR2aIXzZabOQqcS3Ku6jckiZLDUgWvNg==
X-Google-Smtp-Source: ALg8bN7okrTKxklHVrhFQG9sq4vrk9K+T8zT169BtLDr7JwcUeHxv3aWHwgGsqZMqYRfx2baWifnPQ==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr536407wmb.139.1547495194088;
        Mon, 14 Jan 2019 11:46:34 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id a6sm26475975wmh.10.2019.01.14.11.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 11:46:33 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        marc.w.gonzalez@free.fr, bjorn.andersson@linaro.org,
        kvalo@adurom.com, joe@perches.com
Subject: [PATCH v3 1/1] MAINTAINERS: update list of qcom drivers
Date:   Tue, 15 Jan 2019 01:15:49 +0530
Message-Id: <3f8a0c7a8701446abe02f1e35d412d72d9c1f0f3.1547494994.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547494994.git.amit.kucheria@linaro.org>
References: <cover.1547494994.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers didn't have a specific maintainer (other than the
subsystem maintainer). Add some generic regex patterns to capture most
qcom drivers in the list of supported drivers. For the rest, add
explicit filenames.

Sort the entries, while we're at it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 MAINTAINERS | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..a2b21a622ae1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1948,19 +1948,37 @@ M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/qcom/
+F:	Documentation/devicetree/bindings/*/qcom*
 F:	arch/arm/boot/dts/qcom-*.dts
 F:	arch/arm/boot/dts/qcom-*.dtsi
 F:	arch/arm/mach-qcom/
-F:	arch/arm64/boot/dts/qcom/*
+F:	arch/arm64/boot/dts/qcom/
+F:	drivers/*/qcom/
+F:	drivers/*/qcom*
+F:	drivers/*/*/qcom/
+F:	drivers/*/*/qcom*
+F:	drivers/*/pm8???-*
+F:	drivers/bluetooth/btqcomsmd.c
+F:	drivers/clocksource/timer-qcom.c
+F:	drivers/extcon/extcon-qcom*
+F:	drivers/iommu/msm*
 F:	drivers/i2c/busses/i2c-qup.c
-F:	drivers/clk/qcom/
-F:	drivers/dma/qcom/
-F:	drivers/soc/qcom/
+F:	drivers/i2c/busses/i2c-qcom-geni.c
+F:	drivers/mfd/ssbi.c
+F:	drivers/mmc/host/mmci_qcom*
+F:	drivers/mmc/host/sdhci_msm.c
+F:	drivers/pci/controller/dwc/pcie-qcom.c
+F:	drivers/phy/qualcomm/
+F:	drivers/power/*/msm*
+F:	drivers/reset/reset-qcom-*
+F:	drivers/scsi/ufs/ufs-qcom.*
 F:	drivers/spi/spi-qup.c
+F:	drivers/spi/spi-geni-qcom.c
+F:	drivers/spi/spi-qcom-qspi.c
 F:	drivers/tty/serial/msm_serial.c
-F:	drivers/*/pm8???-*
-F:	drivers/mfd/ssbi.c
-F:	drivers/firmware/qcom_scm*
+F:	drivers/usb/dwc3/dwc3-qcom.c
+F:	include/dt-bindings/*/qcom*
+F:	include/linux/*/qcom*
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
-- 
2.17.1

