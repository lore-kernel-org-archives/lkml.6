Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D7AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2826920837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liS+Aowp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2826920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeH3W7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:59:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38608 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeH3W7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:59:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so8135751ljc.5;
        Thu, 30 Aug 2018 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hKwyYPISVLELVJeH7hc6fBh91n3hDTiNaxE+zqDOE2E=;
        b=liS+Aowpt8+VGYoiO4cbFMKhosEWZHvmwGkb8LX7E06WfW0lppO/V4ndUYSXZkSAli
         251UbXfEJL1sBd58g3OiMqcF1FDyBEN1FUNGR4/vLy0/AWKKkcvx0dlmbzEyw9mjXs7z
         Pv8tMSKdpIOFC8P07GdwRvYVMKpjZkqtC7/b784h/aRSQwb9LAYj+L/+YB/n6EdMyTip
         xemKiqVzXymY5WH/PrD+uAq/edZ0De0wThCW0AzX/Pa7GB2NIgsWhIQ2D01WRiQxUogv
         jVSiVp7arA6oIOfCePwqGnVS5iAE+VKT0asOzbRw9RU0xU82j8V3vHX0AFOfcTHVCYBm
         XcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hKwyYPISVLELVJeH7hc6fBh91n3hDTiNaxE+zqDOE2E=;
        b=PY8CN7B28eRuyVPNACgcUH+xyvsuyUFf87oVtDeob7TOO41trkzonM1erqvueLdJhf
         EWNuge9Bf5hvtvPpOOr6XdbZ6jBmKFHCxM3rI/pKvhztutwN/1Ax2fpkSSMVIhfjDI62
         XjXgTp+NNEjY8l8rUfnzHg8kYjrhD1BIjA8E1Q+r/P9jpZVsaLd6LOHA5ljHL5bN50hC
         a/olE9WSewevdRJB1K8bstF8cWd6wZR2VcJ5ndPkkRZ8YasvL630tbOFYbe+WLGfzlf1
         +8wyzbqSnDTO0jPwz7gVVcUSkgwTruq7yGn0o4vpBomMbFs+jkxqYB99YgJcsIKJAyj+
         SC0A==
X-Gm-Message-State: APzg51D6L/IATp7/wauZ1tFmjWOztvz4feq1JCNyEjlrV7KK3TdgBhya
        9v6mKCVK1xACnEq7kvgVTUc=
X-Google-Smtp-Source: ANB0VdbUVFkJ28oebsUT4iqbNIH+alsARRz5tNtgoxbeyePl4lEPSl+uxOO9gUfskFvSxxeORDALyQ==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr7929906ljk.14.1535655333964;
        Thu, 30 Aug 2018 11:55:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1373087ljd.61.2018.08.30.11.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:55:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] ARM: tegra: Fix missed EMC registers latching on resume from LP1 on Tegra30+
Date:   Thu, 30 Aug 2018 21:54:01 +0300
Message-Id: <20180830185404.7224-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830185404.7224-1-digetx@gmail.com>
References: <20180830185404.7224-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory interface configuration and re-calibration interval are left
unassigned on resume from LP1 because these registers are shadowed and
require latching after being adjusted.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 127fc78365fe..801fe58978ae 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -521,6 +521,8 @@ zcal_done:
 	ldr	r1, [r5, #0x0]		@ restore EMC_CFG
 	str	r1, [r0, #EMC_CFG]
 
+	emc_timing_update r1, r0
+
 	/* Tegra114 had dual EMC channel, now config the other one */
 	cmp	r10, #TEGRA114
 	bne	__no_dual_emc_chanl
-- 
2.18.0

