Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A3EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5669120851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE7SvWkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5669120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeLLUxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44436 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeLLUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so9430186pfh.11;
        Wed, 12 Dec 2018 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3IhCZ33Eo81tdSj/+KDeNpIwacUrTZ4TzMO/OThHFk=;
        b=bE7SvWkRXYlkvEep1jYGWnFv1bOLsjytbAL9hdZSQoIYmfrb3iCohPwmr2iT/E0q9Q
         7/JURAS4P+vCJMWH037Q/peUy29NEskNAlxsHj3c/wSqdoukhX6rbyClTkr4owf0jROd
         1LqUA++aEnJdCnWliFgLOFv5Pr4N/hpY/gYJqyHV1WhSFMkySGTZHH+fSDXE4jsmOTio
         9PPuCdiR3QfuMaE1OS9CwB6EGP8TWIcy7cQNFSbkuga2nLz7hg5QBHukLPjjMttHulB7
         iN+ChUh5gnr1ywyAMq/dA1GkuOkh1lE6Rcyaq4bEMHiRhp+2MqV7C9elmX0i5X0OIA/q
         5o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3IhCZ33Eo81tdSj/+KDeNpIwacUrTZ4TzMO/OThHFk=;
        b=LYAsLGtQ4qF4GNCUksF6dkckkeADCa01/vHWn4pQKIGnvrsQN1eLiLVQG01lrZI2KO
         i1zsZfv4ir7bxvGM46WjI5Qj4HACL4oMouuAHTEBeUkLaYbjWHGp1eHhNAiLHJVksdGY
         ylNM4xamHEZevjepZtmj7nsdMMW2I6lgPjlWo9u7aFi/H6d7O8eNcFKR9mbK7NW4NAfM
         rlgXs3/aM9/aIs9PwA5kiWVjyVNK5wJkzZ7ygt9jADIl5ewT6LSepl6hwgDzFW6EcoNl
         DBmczdyYi6WV+PrTmUISa1nwuEAWc4nTocmw/ibeVHgoMDVcyYa4RQT0ye6RtXBkrJ1d
         elhw==
X-Gm-Message-State: AA+aEWbZ87uXdQJcxD4wRrcH+XclWt+aoTmBv/4DlxmAUClNFMHufPZx
        56EmfniU2EXP8ZBiiNGODcU=
X-Google-Smtp-Source: AFSGD/XRB1a4yfnbtIDh6wB1lCiHhPtUXMy5kBk35I8/XpskuvZYb4zufaRxUqFNWKw53xS6BITgDw==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr16811291pgm.80.1544647993762;
        Wed, 12 Dec 2018 12:53:13 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:13 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/24] memory: tegra: Use relaxed versions of readl/writel
Date:   Wed, 12 Dec 2018 23:38:55 +0300
Message-Id: <20181212203907.23461-13-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for inserting of memory barriers to access registers of
Memory Controller. Hence use the relaxed versions of the accessors.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 9856f085e487..887a3b07334f 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -26,13 +26,13 @@
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
-	return readl(mc->regs + offset);
+	return readl_relaxed(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
-	writel(value, mc->regs + offset);
+	writel_relaxed(value, mc->regs + offset);
 }
 
 extern const struct tegra_mc_reset_ops terga_mc_reset_ops_common;
-- 
2.20.0

