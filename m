Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8172AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E3F20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjPjbRRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E3F20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeH3XIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:08:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeH3XIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:08:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so8170804ljj.0;
        Thu, 30 Aug 2018 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PWwixFchd3j2epg14Ed630kPPS9AkG7eDnqhnfVkDdI=;
        b=kjPjbRRsUfwwZAXadnR8F0SUru0EYc9Jqr3I42KRwSfM4Zbp88noOm65IjZ12gn2aR
         Jy+psyBBeUaXVIUL4pdt0EkkdYBL2UQHhd9Yy7Fu0IKn+1t16SM/Nt6zNFquykl7IGFF
         BAea5mJChg2fXmz609bMSWI86aHfs7rU7G3MKNDnRfQM11wKj2xla9GrKZC+zOC0KB15
         vNx6mIvr/nMgZj9MAP93lb845QVZlAekYgHDDW90dqz9Cgy1yiawJuMrbSJmNSNtXbWj
         eJzg+/oWKbnloPG8LcED+TarqhtMsKMyUHwD5D98RVuBFydseBpGSg/p+kWS0ylMjlX4
         tSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PWwixFchd3j2epg14Ed630kPPS9AkG7eDnqhnfVkDdI=;
        b=CVfufpI6efj70mq6H4k9K5/hVinnpRGjUZASrXh6NhSb3Lopdz06JYnvzHDGw0B52Q
         bi0RW6bvodKlChUQtMrpnRYS2NkxxvhbA7tB77gi4wt8JdU+wDQlnljt3XfOvK0lAmWE
         l3biGAncI3n4Nzo5dndINQGetM5wYloSUUBXx1AzAPSAMChxv/WsmB+zaWuvPwHeMXCg
         q+WhUdePy5JE1oTaOpMSX9c7lYqlf/4YMpXfoLAgY3d1Hnwmt1QH40GV07m07kigmier
         8Xivmzy5OWJHEbTz88rosfMMAHDqsB1zXqe0rk9xilUhLZqXsSbR/uMRmlaEYSIzdJ8o
         pdoQ==
X-Gm-Message-State: APzg51CPAf72eaANhRt9ZmTjIia9V6OqGzzPNX7D5iQ+eS/q1Q46HdJJ
        U6rEz8hX/bGReCdduyHVQRU=
X-Google-Smtp-Source: ANB0VdaittQbZgZIwa+ipv5nVXWSDOAw+n5A462e3H9CahV7nqxOM7QSf4VfNlrrztIRWvIqDTkEEA==
X-Received: by 2002:a2e:720e:: with SMTP id n14-v6mr8489374ljc.93.1535655909081;
        Thu, 30 Aug 2018 12:05:09 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q128-v6sm1373081ljq.72.2018.08.30.12.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:05:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30
Date:   Thu, 30 Aug 2018 22:04:54 +0300
Message-Id: <20180830190454.8729-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830190454.8729-1-digetx@gmail.com>
References: <20180830190454.8729-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early-resume code shall not switch CPU to PLLX because PLLX
configuration could be unstable or PLLX could be even disabled if
CPU entered suspend on PLLP, it the case if CPUFREQ driver is active.
The actual PLLX configuration and burst policy shall be restored by
the clock driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index d572d4b860be..127fc78365fe 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -396,8 +396,8 @@ _pll_m_c_x_done:
 	str	r4, [r0, #CLK_RESET_SCLK_BURST]
 
 	cmp	r10, #TEGRA30
-	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
-	movteq	r4, #:upper16:((1 << 28) | (0x8))
+	movweq	r4, #:lower16:((1 << 28) | (0x4))	@ burst policy is PLLP
+	movteq	r4, #:upper16:((1 << 28) | (0x4))
 	movwne	r4, #:lower16:((1 << 28) | (0xe))
 	movtne	r4, #:upper16:((1 << 28) | (0xe))
 	str	r4, [r0, #CLK_RESET_CCLK_BURST]
-- 
2.18.0

