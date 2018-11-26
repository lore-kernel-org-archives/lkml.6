Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17808C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19D120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19D120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeK0EaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:30:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44733 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeK0EaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:30:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so12760990qkh.11;
        Mon, 26 Nov 2018 09:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=ItZT/cVdy3Go+gbEHXeG/NlMN9vVMWvGTo+dGdK6Irs=;
        b=pF0zFB2cvSgtCt6X41G0G5koo1MyIk3zBoCyEE3Jka7lUDGAgec9MRj0svDHWGI+7V
         UoXO2mXE2oJv3eomNSyt09FMOdBG3XjnuyK1OhqtrQRTZ3tADEh+B5phtEp+zEx1fX5m
         VNemBd6Bwgs9yMKJeJlwIrQzSZv9vWIrgLBxXQYOForB0BmgMhHHIS1xWHdpHR98gs7B
         DfRCUJefxu4/4EykOTNMrfmrgbwoiUDj60LGT/tc/rePGgOS2OIuiep+s3doxugtO8Jr
         V7VLEp8BosBPw/qwzPEKbHVaExrIU1+mEwHKutWiCnpa4eZFd3RDE/RsJMJqFph9w5yt
         JbEQ==
X-Gm-Message-State: AA+aEWYnits7kg5CguS3xJdXmSmwETTSpJqoJfSn7QyhxqY/2K/6rIxx
        /4LRfFId5A1IvntZ4jcri13m1VSV
X-Google-Smtp-Source: AFSGD/WT4TXUCMT7JarL5svQUhqRk9BpRPOQ+5lHB7Y+tjKC601utJ3OB9OvA8W7tbGUq+zlwM2U6g==
X-Received: by 2002:a37:7cc5:: with SMTP id x188mr24919107qkc.307.1543253728639;
        Mon, 26 Nov 2018 09:35:28 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id v50sm726526qtc.7.2018.11.26.09.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 09:35:27 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Mon, 26 Nov 2018 15:35:22 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 3/4] ARM: dts: rockchip: Add UART DMA support for rv1108
Date:   Mon, 26 Nov 2018 15:35:05 -0200
Message-Id: <20181126173506.24068-3-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126173506.24068-1-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the 'dmas' property to the UART ports so that DMA can
be supported.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

Changes in v2:
- fixup commit signed-off-by
- fixup commit log

 arch/arm/boot/dts/rv1108.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 300de8e1475b..23ac4b10d690 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -116,6 +116,8 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 6>, <&pdma 7>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
@@ -130,6 +132,8 @@
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 4>, <&pdma 5>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
@@ -144,6 +148,8 @@
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 2>, <&pdma 3>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
-- 
2.19.2

