Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD2C282C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9149F21902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="1UlhPHsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfAZDkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33973 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbfAZDkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so5001838pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROwabcKE05oS5nw43yFEZzfEhIHWqITag9M7+4CWFos=;
        b=1UlhPHsacddCs5uQS05aC9ch53Upezw0lNuCkcGnW60sJiS4+QelBsl8hc51g5GVB7
         0x83mBEam4Df2Z9XQFz8qqZg4/XuP7D1vS7NQqhQnBnl8yj23QRX/zfluI18YT2q/bc0
         bsX0AjB6vnyPZGhs6w9v960hrSA+xxkEpuYBtpZwmMxzuxfVgQypSrDUQCQ3YeTQLk2s
         B1XsbeHz/To+h+1Es99Px+iIslZhDqSSGZAbTPpKrQkXFtXWVIwOBAaYlADpjxuHo6L5
         wFUQFonsKrNBUPIe2PkOeq8y2TiYVPW45lI+tM5bpgu3cDcn374SLPO66rxo20yhTV7S
         RYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROwabcKE05oS5nw43yFEZzfEhIHWqITag9M7+4CWFos=;
        b=nqGwA92apP2GdjDy1c78vXd9OOCFGxjn3bva6WpE9U4O8MtGGiK7CmpQFhO81wFxCb
         5VNpvjO9NTEjuGc/6jo1Bj5zKHi5YT7jX/AdKuhDYyUz5WWn+4Q5pPDt7hwJxp9cyyE+
         c16ezSOQxAm+tAfEmebj5weBRwwGy6aU4H/7JzyXk94GI4MaLOEd70kioD/SZG9ruM3k
         lBkOXXOrddlMVo7wPcb4qbU2WG/8mm/vOviJwkIhwxzjZ3g/EcVcWMGn2p3nrLKVQTmf
         8GtQyFo2x6qX0lPuVefF10fUpkKatEoZFUVV/UQM9hXMRB5I3YKLAd5cIDGjr22MvJvg
         U1Og==
X-Gm-Message-State: AJcUukc3plbxKfqP9i6bYrSKGBvy7RPbAU/8cB+0pNhyChhWiw7OMEKx
        PmMh46gGmhxNkfu8+OMorRw2SQ==
X-Google-Smtp-Source: ALg8bN7HwIMLMqqjca2iPcetr5Ms98DpPk8/+i8ElS5GPX/1sN11ukoCsyOlbhjwr/ku1rrF6Ac9Nw==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr13494711pfm.71.1548474015598;
        Fri, 25 Jan 2019 19:40:15 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:40:14 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 6/8] regulator: lp87565: Constify lp87565_buck_ramp_delay and lp87565_buck_ops
Date:   Sat, 26 Jan 2019 11:39:05 +0800
Message-Id: <20190126033907.18427-6-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126033907.18427-1-axel.lin@ingics.com>
References: <20190126033907.18427-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp87565-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index c192357d1dea..4ed41731a5b1 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -51,7 +51,7 @@ static const struct regulator_linear_range buck0_1_2_3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1420000, 0x9e, 0xff, 20000),
 };
 
-static unsigned int lp87565_buck_ramp_delay[] = {
+static const unsigned int lp87565_buck_ramp_delay[] = {
 	30000, 15000, 10000, 7500, 3800, 1900, 940, 470
 };
 
@@ -140,7 +140,7 @@ static int lp87565_buck_get_current_limit(struct regulator_dev *rdev)
 }
 
 /* Operations permitted on BUCK0, BUCK1 */
-static struct regulator_ops lp87565_buck_ops = {
+static const struct regulator_ops lp87565_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
2.17.1

