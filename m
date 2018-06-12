Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6CE3AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225DF208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LwLAHV5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225DF208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934468AbeFLUWD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:22:03 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38409 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934327AbeFLUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:21:59 -0400
Received: by mail-qk0-f195.google.com with SMTP id y4-v6so189401qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ttMBoJsqaaXfGMDXMMsDLHG8z4FALyGmqaeVgXYPskQ=;
        b=LwLAHV5mJoKCpRlU2DHqDrVMMGaK1pEuTsnBgasRR95Pcikcpm8REga7prfTDo0nl5
         9d3X6iYsZq6g/4XtatY8jR34Jdqk2rErYmRwiaImz/HJI2MGaTtYbVRPkEwXYgWLOCMa
         QIY9ZkCxDoHzeGgvft3wkxZKOUeDD0x+FsCFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ttMBoJsqaaXfGMDXMMsDLHG8z4FALyGmqaeVgXYPskQ=;
        b=WZjp3Yb3F/AQUMxhYZA1IH/8wj0aWdFcdQ5rTyF64D8KgQHRfOnqBuA1/7MfNjwXzX
         Dte50AhxWgoKU9WsjLYfZXl4D9VYdoUB7heQxU7vF9r3Airo0xMx6YS9R5e+cg6BnktP
         IMmUgl+oiSL846KACsdmxVocIrxhrM/iGwOw8QfccMYVfy/3JOB03qghwc4aml26jp/c
         4nsPg8lJGwZVDAItyPGQiIiBP1SU8Bgy5H3X+ksjmorOA6D3uof8TrRQMnYjT+vFSAnb
         M4rMJNmmRLcPdcnoQff7AZga/JQEduFmF96rvSdAQ10Ag5muGO+CF08Q8A+5/R991oJW
         +emg==
X-Gm-Message-State: APt69E27hw7ROBWahz9V9rWcaso4Ffnt+vrjPmIBeehUy8cgNr7TXmpq
        7iYOzcnWctSgVloiquMiMpJmcw==
X-Google-Smtp-Source: ADUXVKLKGKS7VtcikVKyf3tsUAZyMMD+JOg6aQ3ZfBZ0C7zbYKl/Fy9+KvFRVvnwk/7x57nP2Wo1Gw==
X-Received: by 2002:a37:1399:: with SMTP id 25-v6mr1867788qkt.83.1528834918312;
        Tue, 12 Jun 2018 13:21:58 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l9-v6sm635080qtp.25.2018.06.12.13.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 13:21:57 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 5/5] ARM64: dts: Stingray: Fix I2C controller interrupt type
Date:   Tue, 12 Jun 2018 13:21:31 -0700
Message-Id: <1528834891-17807-6-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for
Broadcom Stingray SoC

Fixes: 1256ea18875d ("arm64: dts: Add I2C DT nodes for Stingray SoC")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 99aaff0..b203152 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -409,7 +409,7 @@
 			reg = <0x000b0000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 177 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
@@ -453,7 +453,7 @@
 			reg = <0x000e0000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 178 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
-- 
2.1.4

