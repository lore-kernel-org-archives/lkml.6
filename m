Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4085EC67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D7E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1zMZg3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D7E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeLIUbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33045 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeLIUbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so7816907ljd.0;
        Sun, 09 Dec 2018 12:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AL9mgVWYAaaAVSfCK2qUoA1QSddHFwi3ukVWb4sw/HA=;
        b=Q1zMZg3rzLkAKm5UcjO4zLrmqbVWFkD9XfDHDxLIZXNr/5OkWR2HgZU/N8Nr53frQb
         UJwR5DDq5B1uzHa0ue2043pLykYwTgXBfht5LFVGFwo15S3mrpEWNghedRu/rihtArSd
         M8isOn46HLaODcG8hfqT9DJPzaeGatX8dlZok2xCDIegtDRRzg7ZVMXX49CMalYkL6eV
         OownIV6J3BXeut+rs73zwrya4UdtkdxsaIv8s8cTk2syWEb79ykCd7RGQHbunLY5DTTz
         glQFxaARRMgLYNf5n4EwWfENgxSWZxOjzLHMPQCoq4ITCPW67XKk2xIN4q4P0sXpLoW1
         BNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AL9mgVWYAaaAVSfCK2qUoA1QSddHFwi3ukVWb4sw/HA=;
        b=obzZHrgwral1TNsuKHhHkQHio972ctA9xnA0peIky7ofvI8NLa8JF4jj8e1L2/TLl/
         R1OtdwLagrcCbF/tsl6vOvf5VtATwAu5n2xYvZ4UAWxBtRBGwMEUPM72o1F4sDrWhkpk
         sPPkNCLhTDcmIDL4H6t12lyN3rKPVzzaIaCYkYPfzkr1Dk4z3NrQ27HM691wJqQaAeoh
         p7ByC/wT0Lc0Y2uRu3Mc5i+Fict7eaOrbH10s6+Y4P+cwVVPN+3fzabS3Vb+uXrYrZ3u
         F3QQF5Qq87Y3n+smdYeAgkfNF1Jb502YcZDBJ6v17Sv2ArrR9xwwuB/Re8akVV7Hq6Vd
         xL0Q==
X-Gm-Message-State: AA+aEWaxSDlD13hOvlAvuclDFStA0ZAeJQqR7lRm4V8qFCad9xyGJJNR
        /zj4wTFac2HhKJtUfzNRf2rN1s+4
X-Google-Smtp-Source: AFSGD/UGZeYGGcKcj+uA/B4Yc6ns0pUqduLlr6pSDq8ri3MsNwkfFjOKthAj9QMd1ofiRVQQqfulJQ==
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr4625797ljj.149.1544387471172;
        Sun, 09 Dec 2018 12:31:11 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/21] memory: tegra: Use relaxed versions of readl/writel
Date:   Sun,  9 Dec 2018 23:29:41 +0300
Message-Id: <20181209202950.31486-13-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for inserting of memory barriers to access registers of
Memory Controller. Hence use the relaxed versions of the accessors.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
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
2.19.1

