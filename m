Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6PtR9pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLRDnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:43:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34401 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeLRDnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:43:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so7444663pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=Q6PtR9pAVXjj423b3NL5eKGkc0ulrDFggfzUPOVNkQHL8XKJTqcEyc4/vuvOy67ctZ
         y5n0fPopTsnoWebqLWbuY44NIcn8BUUyWASsyh6efdFo28r8bX0xaXagAiJ1lEKciVfM
         GacO5TpLBwujee+Wql4l/uwctm6idQzY/KBxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=G0LDxp5lAvPjkhXTPe7pV8v0LSLUEElj8pRhMWcj0CEPCl8/3xgQn8paqB8h3cdenK
         QizuG6a59uAtj43h7mJEewAPhgHgP7OPI3KaMg2xIdCpRHiO19+3J82Cl8Y42Iw0IpHh
         TFIVpRL3btqxdo62timUsYNdDpu2Gk6El3p5NL33njyHD5tKue3v1iZqDPCj7BcF4VYm
         K4VzNGoOWB1D04f/UZc4hzPdPcDkRX05s7gF2W6+drJlVX1dPl5I3AIUoBNyA52XIy5X
         r9JMw/ultJleuV2N9jZ/5E0asxXK3C3A8g7HNSMgqC5d4Z8zIjcSWvaZqjY655ibD/la
         ITKg==
X-Gm-Message-State: AA+aEWbFGkhZd4GyZOGD1UVAKKv1GnupXal2GZB7JUvgzW3Xs3dr5gXN
        DWV7nAVyDfkH9n4V4KMHIar8
X-Google-Smtp-Source: AFSGD/UIi+PMaiuLib0DZL4C0r3MugYkv3oIsNK1WVEkrFGr56dpyzkkhrfqoWnq28RC4gIJ99rCJg==
X-Received: by 2002:a63:6b05:: with SMTP id g5mr13963311pgc.15.1545104589847;
        Mon, 17 Dec 2018 19:43:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:43:09 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 09/11] ARM: dts: rda8810pl: Add interrupt support for UART
Date:   Tue, 18 Dec 2018 09:11:30 +0530
Message-Id: <20181218034132.5070-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 84baa4c0a14c..19cde895bf65 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -71,18 +71,21 @@
 		uart1: serial@0 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x0 0x1000>;
+			interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart2: serial@10000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x10000 0x1000>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart3: serial@90000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1

