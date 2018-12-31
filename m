Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3871C213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAfoUXX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeLaS4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:56:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41230 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeLaS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:56:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so12892087plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
        b=DAfoUXX2Mm4QCjZqfBd/jHNgGDXixo8Idl2Ej2QqqP8eRoI+RjdqXc//NL6yfnGUki
         x96pi+g9+u6YtEP3M6799NXkX8CxIyuptrQkPatVQ/7t4Wpa9OBmKzf2ffLtp1crXjcD
         0onod/iPgWI3xVsGvCupVe1PmvzcKQWx74o8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
        b=E7DLpKiifhe5n5cDPgWWD4+rvxjTa/kiJa6gixYEfNr0+KRCO4BIAH1v9iSN2voOqi
         BzQiqHzktjN6Jq2IiT0LC2TgsedvSCH2yxXSmjiW1+67K7OO+EXRdiOM3bPpYN23nWO0
         sHmz5TA9Z5hXeKAc0QuO2fb1HGT8Wn2y00uk91Ue+m8PTw1OeH/f3oRGUGbcthvq3ieD
         TqSrzlf0XyF3E6wLKap+c7azCIt+kuN7hYGckyldkUgUUwZSWsxdPp5I88rAN5JG20wK
         qYZGFOrzFi8dxmQWM6HPKsA9sHu+aivsqkakpiLQfyOv5QZ4jmD9fmzuWSOupEA6LhWr
         K/Tw==
X-Gm-Message-State: AJcUukf79Oufo/75H2MSc8ha+cE8sTv30PF97Q3MaWRmE2RRalkqmK0L
        XDlOEmBWIyiHhh4HRpd1xdgV3T5qww==
X-Google-Smtp-Source: ALg8bN5xgrandwk7kDkjOhlCJwLKw+AbtdnzuOLk8O3v+FGwxL+DJprDS/hJpaHyHyUJ8W9f/MztHw==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr37492748plb.325.1546282563704;
        Mon, 31 Dec 2018 10:56:03 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
        by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 10:56:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Subject: [PATCH 4/6] ARM: dts: Remove fake UART clock for S500 based SBCs
Date:   Tue,  1 Jan 2019 00:25:15 +0530
Message-Id: <20181231185517.18517-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Actions Semi S500 SoC has gained support for Clock Management Unit
in kernel, let's remove the fake UART clocks from Cubieboard6, Guitar and
Sparky SBCs.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/owl-s500-cubieboard6.dts     | 7 -------
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts | 7 -------
 arch/arm/boot/dts/owl-s500-sparky.dts          | 7 -------
 3 files changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
index 7c96c59b610d..c2b02895910c 100644
--- a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -25,12 +25,6 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
index e610d49395d2..7ae34a23e320 100644
--- a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -18,15 +18,8 @@
 	chosen {
 		stdout-path = "serial3:115200n8";
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/owl-s500-sparky.dts
index c665ce8b88b4..9d8f7336bec0 100644
--- a/arch/arm/boot/dts/owl-s500-sparky.dts
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -25,12 +25,6 @@
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1 or 2 GiB */
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
-- 
2.17.1

