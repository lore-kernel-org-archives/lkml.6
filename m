Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D26C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7929223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+M8RKSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7929223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeHJMWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:22:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42702 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHJMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:22:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id g6-v6so3835326plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a051E4GqSMvmAhDqqTiyyKiddvx4SdUz+36qdsU6cPc=;
        b=Z+M8RKSbwAwq6JFssKZQVhbVmb7zuGlIWivUzvwhLk/EoehPDEfQ5jdFW1tMJE3PvA
         MD2w1jamgkVjtT/XHEbx2/wesWGS1YT6zBHrXYRFftWVhqfcBHEjcao79QDywiUwtugq
         bgdPJm8Ox2YhO+r10ZGeBc9qvOBYRYR8qpaH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a051E4GqSMvmAhDqqTiyyKiddvx4SdUz+36qdsU6cPc=;
        b=pf3QOuFv3i1oIi+owxB82sNZKmOHxpoiFquK19Bq685X29t3cX/xcuKiA/1O46vncl
         ytYF6Uaf4oBtOWmW5XCNgF9uH1EjWQnYFteCOa8HW4oO1p6Qgu0ZZs5BpDB7GTPZdMRZ
         8zGLJB4crU7Jl8iU5tddtRx0w25umabXz0IhHESSzucymWuj22eiwZfNzNgtggkL4zTL
         FLWVHESY3R0nCseWOzjY9nBRjaTWNO7v7SNE/wwn0rYQNPtuG+mHn4T8yjbBF9e12xEw
         VrgJk1ygYeD+v4Eg6B79qtMcjdVMB5IFi3gNI5Q28T0vOfnSWGUJnjpnPTt/AFUrLrWm
         Q3Ng==
X-Gm-Message-State: AOUpUlHL3BW0/0oVnFUnZ4ByFMAA7lOuDmRwUafz5XDTIUskLlLFu3+o
        IsxQf/2ROVPQ0NT1YsaRD26c
X-Google-Smtp-Source: AA+uWPw2OE4LCvcMt15iNWzQaOEZsJRUaJDBVkNPip4Kk0KZdxd8xGNc/UXujG4jT4TnuYmPgBn3Vw==
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr5544869pll.85.1533894792969;
        Fri, 10 Aug 2018 02:53:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:53:12 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/9] arm64: dts: actions: Add Reset Controller support for S700 SoC
Date:   Fri, 10 Aug 2018 15:21:09 +0530
Message-Id: <20180810095113.25292-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller property and bindings header for the
Actions Semi S700 SoC DTS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..30c4c6ea89ea 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/reset/actions,s700-reset.h>
 
 / {
 	compatible = "actions,s700";
@@ -165,6 +166,7 @@
 			reg = <0x0 0xe0168000 0x0 0x1000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		sps: power-controller@e01b0100 {
-- 
2.17.1

