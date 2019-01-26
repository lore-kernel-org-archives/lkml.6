Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A834C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF1321902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="K/Ss/l3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfAZDkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42637 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAZDkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so5612665pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SkmHnpb4nZFydeXYnAyEtBy71UxgzkriU8FitSuj3ww=;
        b=K/Ss/l3zC4HbwePEwfXyYLwPYoOPaZOX/FoV3mdrTMRlPkO9qrxFhbfN6lpQB3/lVr
         HlpiGIa1D1Sd3r2LC5R/v34k3mBQ3UcxGQ5oI6tSWiQS6cvFrbyy6z4oYvAsRP4g54GI
         pSl4mWc1vT9FIQ7fUSEdCu094GDeIhLLSOHVCdOOfpUCFrwlgKEFdMY4rHRR3d3V5qV9
         JwRnq3s7B6bGUQ2ohEYIg73xTTmJCHm+9szHDNVbQwuS7dHJsvWx8evpNfvpaHglx7Pj
         dQ2YGKsH50ckcfxSxR6Wug0vZhoJzcy+H++fdG1BqqhWPlhuWuWMapq/dlfDU4T4/Eab
         0zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SkmHnpb4nZFydeXYnAyEtBy71UxgzkriU8FitSuj3ww=;
        b=rTjmpecTsH3IZzJYsAi7CUeVPZB9GMe3YjVhfrTZze9TCfJNg8aUTp27HwOojIwR5l
         3bI3ZBTx3rz+muLdW2dcVVa5s64pbEijXkdSM9ocO79su785pnIank0vqPvvxVzZSqyj
         gVChcE61ajNNJA3tnhqt22yce8VJAs3/K3tnhQajT0RGPbigLWFhhWJjJMl2E76hDNDn
         SxSzSkD4XS4Pj/4Co+0bxq8akVTCnGHaYVDH+7Rxh1Nx8ge2EMQ+k4i6qF+QHcRdE26p
         bSg3tgUekT5KjUqWxYpynGbeN3OSJwC0CZeA3WwgOt36Kr8GpCEK2EdPSab6KQHSmmLg
         eAPw==
X-Gm-Message-State: AJcUukeZRwRHaq7M8TiuPkUKSrewU+r0LmdvayU5ZEoEdTXNm/48s50u
        kt4Za5UAyyhsovsj395yHrYqmw==
X-Google-Smtp-Source: ALg8bN6ZMMA1eLooBClCE58FJmgukSjnLE6hl817DiFFMKeL4P3th4DWLNAYgNXEZKAuJsjHUMWO7w==
X-Received: by 2002:a63:4d:: with SMTP id 74mr12541273pga.248.1548474006694;
        Fri, 25 Jan 2019 19:40:06 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:40:05 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/8] regulator: lp872x: Constify regulator_ops and regulator_desc
Date:   Sat, 26 Jan 2019 11:39:02 +0800
Message-Id: <20190126033907.18427-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126033907.18427-1-axel.lin@ingics.com>
References: <20190126033907.18427-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp872x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 38992112fd6e..f8f875bad7dd 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -478,7 +478,7 @@ static unsigned int lp872x_buck_get_mode(struct regulator_dev *rdev)
 	return val & mask ? REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static struct regulator_ops lp872x_ldo_ops = {
+static const struct regulator_ops lp872x_ldo_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -489,7 +489,7 @@ static struct regulator_ops lp872x_ldo_ops = {
 	.enable_time = lp872x_regulator_enable_time,
 };
 
-static struct regulator_ops lp8720_buck_ops = {
+static const struct regulator_ops lp8720_buck_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = lp872x_buck_set_voltage_sel,
@@ -502,7 +502,7 @@ static struct regulator_ops lp8720_buck_ops = {
 	.get_mode = lp872x_buck_get_mode,
 };
 
-static struct regulator_ops lp8725_buck_ops = {
+static const struct regulator_ops lp8725_buck_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = lp872x_buck_set_voltage_sel,
@@ -517,7 +517,7 @@ static struct regulator_ops lp8725_buck_ops = {
 	.get_current_limit = lp8725_buck_get_current_limit,
 };
 
-static struct regulator_desc lp8720_regulator_desc[] = {
+static const struct regulator_desc lp8720_regulator_desc[] = {
 	{
 		.name = "ldo1",
 		.of_match = of_match_ptr("ldo1"),
@@ -602,7 +602,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 	},
 };
 
-static struct regulator_desc lp8725_regulator_desc[] = {
+static const struct regulator_desc lp8725_regulator_desc[] = {
 	{
 		.name = "ldo1",
 		.of_match = of_match_ptr("ldo1"),
@@ -820,7 +820,7 @@ static struct regulator_init_data
 
 static int lp872x_regulator_register(struct lp872x *lp)
 {
-	struct regulator_desc *desc;
+	const struct regulator_desc *desc;
 	struct regulator_config cfg = { };
 	struct regulator_dev *rdev;
 	int i;
-- 
2.17.1

