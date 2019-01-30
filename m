Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB485C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E8B20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="soleJmBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfA3HLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:11:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46781 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfA3HLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:11:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so10986685pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b9W/DiI/W1PSX1SBnB5bkSjvvVWBgaSy15m2sxiaSW8=;
        b=soleJmBYBpZPXe4xEmC4Kcyfkau3GyvsLHO3lwG5QYqUjI3a8U3zptO6GYUZtu2jCt
         NvF/VikJvwQpF2Qo1N4QL0oXneMVyoRP75GhMCC9aEnWycG15hv2kd3XNvGgUZi7aA4q
         cLrhjuaJhaWMWa7dZGBlZ1e7HNtzUtoXavbYoWADZbA2/dn+3I6+N5z6Mcqudo8NbRwI
         y1yxBmGlSsuRNjyf5tiL+vkFYulIYh1SvQYUZ4rkPEK+Rrkom26ipbOFprjr0iP66N+c
         SnmzXTVtIyhFSMMbPqo6lMOJb9+8CfvFdZGra6SGJRE3T82i9wjLwN2eB9HKrtDHeiea
         nF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b9W/DiI/W1PSX1SBnB5bkSjvvVWBgaSy15m2sxiaSW8=;
        b=pAZbkiK6oY8HTlUdvwVotSrwmldfH9k4HxKSLWneAmrguKyL92J+EBJdnQP5cfinv3
         2JwRNeb7h4pJ0KZw/SXAcxW+WL1tkx+7AAcsz1EB8UFVwq5b0LN2fBqfCjr4NNoQ2WVi
         l3A+xVK3wSXmIiEreZnMLZVjnWQ2a6+Qb1p5Ha0v+l2JP09hwqVl+AdvUXHHDmm4xiPj
         h89SqURu98P0XiYbob5cdHabbwK78e9162oOwpm18AatU1FZHIhZ95at/NtVvkL67l49
         /9AIyXDKDhaxIow4YLlSmdnRzsZe9VZeDRHrEx13Q+6kTWL/hu0JrzWamjvtA5ITReck
         t3eQ==
X-Gm-Message-State: AJcUukc5sVdI8+cgh5EHx+Fs/gDlXAZKmQNBpHELxJ1lGvpBaUlRxwoA
        qGdDMBVCbEPymAthHecrMRqQWg==
X-Google-Smtp-Source: ALg8bN7dV9DppPgK5zGmvj76TFoW71g9cCBrL3CjajqewuVPCQFFx3ITqq2DF1fCILyJHAL+orCkIA==
X-Received: by 2002:a62:8add:: with SMTP id o90mr29152223pfk.210.1548832290523;
        Tue, 29 Jan 2019 23:11:30 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id z62sm1409056pfi.4.2019.01.29.23.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 23:11:29 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: uniphier: Constify uniphier_regulator_ops
Date:   Wed, 30 Jan 2019 15:11:10 +0800
Message-Id: <20190130071110.26050-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130071110.26050-1-axel.lin@ingics.com>
References: <20190130071110.26050-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/uniphier-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 6ba0ae405f2b..9026d5a3e964 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -32,7 +32,7 @@ struct uniphier_regulator_priv {
 	const struct uniphier_regulator_soc_data *data;
 };
 
-static struct regulator_ops uniphier_regulator_ops = {
+static const struct regulator_ops uniphier_regulator_ops = {
 	.enable     = regulator_enable_regmap,
 	.disable    = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.17.1

