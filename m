Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6113121872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LU7rIQ0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfAXNBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:01:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37164 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfAXNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:01:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so5148545ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+TtSy60AE5xODphXFL+46GqeLVir41c6n923ZIZoIg=;
        b=LU7rIQ0nMKaAs0DboQfj/1yr260XzcrEkZ16XvOWXQJ/4LbZwOy6yQi8x6Nz4MvM2M
         Hp+RK2+bGbjx2sw6/Fce9yUI017KU6dboVacGvoLQMof1hXsIf1XjAIKlGsEU8aGcOvf
         DyqX7s8d6vnfXfQYnSK4vrfop4944Z8PFLO74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+TtSy60AE5xODphXFL+46GqeLVir41c6n923ZIZoIg=;
        b=k/47nJhOdYE0XKs1zFxPW6VrjoaZFwK0aWA/92tpMosvt3hpWzMsUE59UmklVSsMTm
         7eSfoJg0SVI4ib2wSobzSHB2vgrTzega/hHf55ioG/MuwN+JpJzcfRUEvgBM5MKAe9fF
         tfBNYGwYIsIekZAie/VyCGQGOcCKCngc/NdNqJTThdIICoqJv/FHQ5MvmT3GwJnFnwvA
         rcPabBxp6o9rgS2vQla4u413jF0BliII3LRZLVK9tj56P7b4zCFZw5wLM62Dwc0/CxVF
         5ecgYPBHb0p171eytgVUNcFJuiuyvv4HEPnISOKUNmwrJS1L+CZ938Gi7DllxjCuzPop
         cMqg==
X-Gm-Message-State: AJcUukeD3tBF/E7/W34NIkZDfPUmmqAJ7XCs8/INdWGR7mtESke3TlZn
        JcRXh7zTbOzB/ZWMpm4jo9pBcA==
X-Google-Smtp-Source: ALg8bN44TRzK5qm0kHqkqnlkwr6hrW2wIh4z0XlCQFjzJLVw8hGz2pSyleKMUK8Z6ezUuGVHasHC/w==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr5394238ljk.128.1548334869471;
        Thu, 24 Jan 2019 05:01:09 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 12-v6sm967803ljf.96.2019.01.24.05.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 05:01:08 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: ipq4019: Fix MSI IRQ type
Date:   Thu, 24 Jan 2019 14:00:47 +0100
Message-Id: <20190124130047.8071-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The databook clearly states that the MSI IRQ (msi_ctrl_int) is a level
triggered interrupt.

The msi_ctrl_int will be high for as long as any MSI status bit is set,
thus the IRQ type should be set to IRQ_TYPE_LEVEL_HIGH, causing the
IRQ handler to keep getting called, as long as any MSI status bit is set.

A git grep shows that ipq4019 is the only SoC using snps,dw-pcie that has
configured this IRQ incorrectly.

Not having the correct IRQ type defined will cause us to lose interrupts,
which in turn causes timeouts in the PCIe endpoint drivers.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 19635f91e2c4..48b3cb474ba0 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -398,7 +398,7 @@
 			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
 				  0x82000000 0 0x40300000 0x40300000 0 0x400000>;
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-- 
2.20.1

