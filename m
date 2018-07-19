Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997BECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D879B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppGlSjsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D879B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbeGSOFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:05:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33695 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeGSOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so7475224ljj.0;
        Thu, 19 Jul 2018 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdPussaMOwx5eq9zggMvF7xXCLAv98sIlWjHG9vkK3o=;
        b=ppGlSjskJZzjWU6zHPqMGhG+mbxVT6Z+6i9CqgyWopPwDXTZNOYsa0chjjJIJv4N3/
         f3sTwPC3k5/7Rt9vSf3toMFc8ti8eTd/il1YvvKXhu+UIXmP33M1D7SBguMPQMIjasC/
         akIoFQYHrYPXk2kblCsw43s5nuK3gTwvjjlwzFCnipX30r7GMa/iK0OFh/lbLkuYzxGM
         IlOlJ5eP7GxVmZQStFt0bRFc43ljCXcLQ4c0t31hQWbx18bfBh9SlvGxZ6MhTsIztPwW
         lx6rkvCwPkkPaq+y463qFLDHHen4O3rEtUOvxcszxsEI+xN7uaHjQUZeThAvNX9h/wAk
         b94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdPussaMOwx5eq9zggMvF7xXCLAv98sIlWjHG9vkK3o=;
        b=gv+ORUpTe5jTfsk7T3iLPRpMifLbINnau0odU7ihlF9IJibeZy6q8/wWECDrz9p6Ky
         dzix98PQqsEnLumVd1h9Bl/kgfeNczbZmJCHT7+2qy606mCAO5pIa4ZRYSU4jLaC7sBj
         KpsaBAA+gXS1ehqvnuRaEVF0T8oFlpS+YQLZ2fpokpARtBVF4cjuTTljR/JTPJpeslG4
         2sn/16SM8YAIHJnHsUXbFGZzbshnM5AaWcA6BQpC0rQ7ZovKDCwXj8ZIx9m78515RRqw
         bfeVGjb4c+TjN/WdyR+r6jLgDsCOL0cH/TI4ZjDclZZiJCQSyeXgmoZDoUikVzZqh3aA
         y63A==
X-Gm-Message-State: AOUpUlFRWd4X82gvu5WsBqSVLgqiannLKQ4pKf7Z8e+u69TbHkMKsys+
        KrcyZJlFDKdRX4EF52VGeo4=
X-Google-Smtp-Source: AAOMgpcGrRtxxDQAMmBrHhZnMGwp4lEiDZrUL0TQrtj5Zznk5JeQqNgk66icIG1o4WLraNt4qrhy3w==
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr7635973ljd.67.1532006553342;
        Thu, 19 Jul 2018 06:22:33 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:32 -0700 (PDT)
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
Subject: [PATCH v4 2/8] dt: bindings: tegra20-emc: Document clock property
Date:   Thu, 19 Jul 2018 16:21:26 +0300
Message-Id: <20180719132132.16153-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719132132.16153-1-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com>
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

