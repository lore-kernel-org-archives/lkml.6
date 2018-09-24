Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5458C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A54521477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfSJ8q3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A54521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeIXGqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44679 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeIXGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so405336pgu.11;
        Sun, 23 Sep 2018 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouqXLjUunN0zjItu13Z4M/nn8hcgnEka9D6ynQqkQts=;
        b=BfSJ8q3L7S3UhQoP5s5ZbIXTB6pPwwl7TSYhUyrIxThgh0kCyN8WBd3KhOzR6kJJhp
         KzoGoTvNAUJLpXp14avtHvUMgY6w5VAq213zp4Fmndx73kKMnzNGi9FpXCZoXaWLiBhr
         SWSGe6SeF0/5ormFH32R3cezDL84AcGGGKqw1Ud+y4o77QSD27f5v0vWWUCIxYq49g1v
         bYXAVakpl8RQu5fdN5MAaa+zed8ntgedJx5UjADA1ILwRZLgtABPMb4t17+JA3AIG6Mh
         d1uHjr2qv3W5QVybv6mIWjXATvS1EgISZu3Hlc/OMXKhaNAnE5gKxNwoDoAXW7sWeMPv
         JEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouqXLjUunN0zjItu13Z4M/nn8hcgnEka9D6ynQqkQts=;
        b=Cz/XVg+mW/tf7FMVaTKa/40TmOf4J94uwx6FX+aL+6jF9hJ6KHMKvVBu1R6fgJmwDi
         sYw9irTRpc5uqEnJdnXuQJt23J/kE2HyU4tyZg4F3KYaB1WTW1k1mu1j+g4rZZ6gkJOJ
         Tc5hYRszcsh/8aIGCzKXIyoR1pICBJz9jwoClJ6c7JV2TRutB/zFy0wXV1NYBTYNjJuO
         JARX9pBvMlDnyzNQF12EVmDhGPzYGDY7PJMbHnAzIqh+FELts8Lo92qmi//IZu4dCalI
         p4Q1ZaA5Cr978/u+6/fQbQB1TYw1fD+Y5sEx2v2MHFJgfRRRzfl5xSYxv1g83RNFUaVr
         f2GQ==
X-Gm-Message-State: ABuFfoi0/OlEWNnpdM7yYztqlHG+05StxGdjkiRH2tvL3CbYuMqkUJ6M
        uJYPAOXy6W65fSWIGH5Mrmw=
X-Google-Smtp-Source: ACcGV61Yp8r3Hla30JwcleOAq02poWVLVt7pfIt8hCmMUqg0heCx5hndpVcDs9PDE+MgkRR2d4PVjQ==
X-Received: by 2002:a63:d256:: with SMTP id t22-v6mr7193480pgi.335.1537750017015;
        Sun, 23 Sep 2018 17:46:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/20] memory: tegra: Read client ID on GART page fault
Date:   Mon, 24 Sep 2018 03:41:43 +0300
Message-Id: <20180924004153.8232-11-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree binding changes, now Memory Controller has access to
GART registers. Hence it is now possible to read client ID on GART page
fault to get information about what memory client causes the fault.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 1b4ceefd82f9..5454ffe5b2e0 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -38,6 +38,7 @@
 
 #define MC_ERR_ADR 0x0c
 
+#define MC_GART_ERROR_REQ		0x30
 #define MC_DECERR_EMEM_OTHERS_STATUS	0x58
 #define MC_SECURITY_VIOLATION_STATUS	0x74
 
@@ -575,8 +576,15 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			reg = MC_GART_ERROR_REQ;
+			value = mc_readl(mc, reg);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
-- 
2.19.0

