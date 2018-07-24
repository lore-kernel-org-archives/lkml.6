Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6654ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F3E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQNLnYHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F3E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbeGXRua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36831 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbeGXRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so3289078pgv.3;
        Tue, 24 Jul 2018 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdPussaMOwx5eq9zggMvF7xXCLAv98sIlWjHG9vkK3o=;
        b=RQNLnYHJRt9iI77ne/tB/RGQSsrbSaTl5jVvVHHzEx8kF0bLqqZuk7TYB+jRPnMNC0
         L04f34qfnXaNmfNN+LC3w8+w5aVLPALY7BVCfwBTmG/j008UexnGppELMwRI6iY848tl
         3erSV8UpzvJ5iheEgIO5XhWBoXtPMRX1ad3Y+hxsUCPNwnAksXj96FbdxDpQcsp9ICo/
         4OkPgsruJyEXLm4VwVJInxby8Xm6vWAtE6TQFDa3b2z+EN7hUPaT8pJu0yKxck68h/aT
         5DcujtFysadB6EI5rqUuEUEg6U2sK+5lcC292baeEkSFkUuG+/kXvKu8CEH8XddbIN9l
         9pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdPussaMOwx5eq9zggMvF7xXCLAv98sIlWjHG9vkK3o=;
        b=mlUOT84h/H+ejQfQBv2gdOm4+WnQw8wIBMs4Je17phHwQf1WGP50ZklJA/3+MIm7jZ
         poeTdwrj/Ol0HXBUxSFDTvi0eQlfrKItyYX/34ACiXneg3GrjuPOAsJIbZFu6M8g+GH1
         E8KZgk3GbBVqv6pMWuiGPPws+TAJKtIhpk4l1Gd79Orb9L3JvReEV2vexeayi28pLgCo
         u9p1/5hSU+J7VB5ZZZKF+XA10RjeCXjF/DNNSQOCoTs04LpXU5if4519QD3rXKSz6gr5
         Tw9UhsET9/NstfUSWzJKfDqhZ69rt83piFgO7vz/S2HG7vHiAWQR9bZ3XRQGVw9BPkbN
         wcqg==
X-Gm-Message-State: AOUpUlFq4hrv7DLpYlwMWjgiiAVAGayIq80AcDeHjkfWRT0NWjFfV65Q
        iQotn4FOtpW8Yv0c1UZQnPY=
X-Google-Smtp-Source: AAOMgpcTJ/WzDyPEhQkZ6jNyV96xONkk2URNYEi/bLiLu5CT33WJthD26o4Cycngo+tQ8uDziYl2MQ==
X-Received: by 2002:a63:9856:: with SMTP id l22-v6mr17537285pgo.208.1532450591073;
        Tue, 24 Jul 2018 09:43:11 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:43:10 -0700 (PDT)
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
Subject: [PATCH v5 2/8] dt: bindings: tegra20-emc: Document clock property
Date:   Tue, 24 Jul 2018 19:42:15 +0300
Message-Id: <20180724164221.3307-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
References: <20180724164221.3307-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embedded memory controller has a corresponding clock, document the clock
property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
index a6fe401d0d48..add95367640b 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
@@ -11,6 +11,7 @@ Properties:
   set of tables can be present and said tables will be used
   irrespective of ram-code configuration.
 - interrupts : Should contain EMC General interrupt.
+- clocks : Should contain EMC clock.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -22,6 +23,7 @@ Example:
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
 		interrupts = <0 78 0x04>;
+		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 	}
 
 
-- 
2.18.0

