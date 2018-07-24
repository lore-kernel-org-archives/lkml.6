Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ACEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED53120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUHZPxLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED53120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbeGXRux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33518 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbeGXRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id b17-v6so981896pfi.0;
        Tue, 24 Jul 2018 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xr6zoJuis9T7PH6Y1NR12kXsVCPvALyX6ctcsGCCpqU=;
        b=sUHZPxLHFV6faoTUSPp4pA2yUNd+ul6OTtkFiprtDH4rMZlPO49Hnwt46czLW4mnfh
         UrnqrQj2s72r+gNa53MxUW4UZ0Y27E+qZx57lLDUdtsQCydZUPuYz+q/j4iZoHnS5JB8
         SqSjqAMORCgDU6J2mWwa8GzN7jW51WnTi4t6MiuHj6eisB2qGHSC+SIKvg4hDiL5U8Ej
         Pf5d2RzO4AufK7/etoiuqEg1fx97T4HSCrlo7H9R7mZ/qxTU413SSCRpq5s1t+C1sKG+
         FoLiBOa8uhc4Fucg1CyKtJdQ0D9cXkOAURzq4E7TLTIWvkEc8VNQcDv5teDxPsteGz+y
         P/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xr6zoJuis9T7PH6Y1NR12kXsVCPvALyX6ctcsGCCpqU=;
        b=mpNT+v9M6FIcfnych5eHXi01+cOlXJEn+7wheGTACeMaCYMmlbCoDO6jcYYR6pDhsh
         bswOPPHJb4nL4jsf1VzD1Jj0gIriIzPzh8G8Mh8STtlvUDlzsIu7oFwnzXcB6Q2c/YS8
         ji3HXxowLqRfyp6oWSL0WkZwBqdkjmDEEIlcJceB4a+2HqjD7xV4ZFUpI1iQDKMp/ZbC
         ectdLmgAg4ryU9YoJbrrBXEsZV3zZHPQyIgGwZg1xyikR/HSAooZ3xti5lSsEtEleZM4
         oVGbNrzonuJlioK1eiz8w/bhbr9KBTLDc0NKiqymlJEYSpoDmcMJDWivyiYVsnqEz2kD
         PbrA==
X-Gm-Message-State: AOUpUlE/3ibAG4T2WLnWfjVwQGSkF+jkpznXA+ZH4xtnGc9DRhKdIwgd
        jdhqE4Whr/ISoYG3mMHR0Jw=
X-Google-Smtp-Source: AAOMgpfEIib51K/m7s4VL7X6fUH/fHinT3QvjbGD6mgdFplSc4RfsB6vdtnUIqxijGRMWggPgJI02Q==
X-Received: by 2002:a62:1016:: with SMTP id y22-v6mr18523062pfi.109.1532450613615;
        Tue, 24 Jul 2018 09:43:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:43:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] ARM: dts: tegra20: Add clock entry to External Memory Controller
Date:   Tue, 24 Jul 2018 19:42:18 +0300
Message-Id: <20180724164221.3307-6-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
References: <20180724164221.3307-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9eb4163a4390..979f38293fe5 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -633,6 +633,7 @@
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.18.0

