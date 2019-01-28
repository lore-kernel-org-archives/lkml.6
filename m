Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D961214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="V0ujtbxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfA1OTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:19:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA1OTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:19:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so8074146pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRngC1dA3hMx46ETRzEuQszNvRxr6KbPu7kcH4HfePo=;
        b=V0ujtbxHhcT9eRZHpEan3oUjFsKHeW+l8vzJ4bt873f7OuHyC21dW4sbbxKZzZ+4V8
         lPHTK+njKgEg/4CS6lKiQ7KQHGbdK5C975zpOZBgB+TH+OCiTE/rOLPLp/45QTBFOqa3
         LTAIYaSMPRIEVOriYb9IRXS/d51t5DyI4Z0rsAZ/iEQBRtJbbZqoW7jOnEcg29mHtFdQ
         BbU0xGrrZZ9FEJQxiPgc8s96plVU0aVvLvU1zGLDb1dSTnEJm8+z5tL2C4VgxdMzLG79
         QEYT7gPwTVRHmzYb/13X/Tpyg7KxJMF7xP2qU2Kiq8G5MziUV6NvqA9oiZvupx53deVr
         1B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRngC1dA3hMx46ETRzEuQszNvRxr6KbPu7kcH4HfePo=;
        b=rCwYHoYregmUxNgliDjM8CCVbcm0aiOSltbInmsKQFUu8iXIn10M3+re7IMghSnYGm
         cNoSHBsXoZfvMrCZWgP94kifXs3xg1mpD1vJN9CSJsrNx7iu8gmbIo6fZrdRbXeMZ627
         ptMoeTXVUXW9oxGdWU1HNA39GN9wWpETDHQmiUqoIIhuGQzs4ltjZ6S4Pskt28b4KLMs
         JLXK898q+MBx9T0shfb3YMfgke2JKgpeITqDt3RHUmju5HjHVGMeDT+fpbVBVHfW8TgH
         bxBsdVZteuXnSA0JHpnKRsR7ZqaMD6iOyQs2qq153FTijp9tyDfTbJebhwGBZ5Z1WNvG
         zpLA==
X-Gm-Message-State: AJcUukdvZ14gwU0cnGWXvWvwC7W7iAj/e0w6QxfF840J90tfa+HeCgyH
        g5M7dDdQJ0ScLU/pB//APjd5jBFJmBo=
X-Google-Smtp-Source: ALg8bN7lrSiOUWZbdLHygcOOaopExORQWrBoZT/wPofF7L+LOER2TFgl1clGApPh6pfulw+kgDIgkA==
X-Received: by 2002:a62:6385:: with SMTP id x127mr22346342pfb.15.1548685175607;
        Mon, 28 Jan 2019 06:19:35 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id c4sm66255698pfm.151.2019.01.28.06.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:19:34 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: isl6271a: Constify isl_core_ops and isl_fixed_ops
Date:   Mon, 28 Jan 2019 22:19:21 +0800
Message-Id: <20190128141921.19043-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128141921.19043-1-axel.lin@ingics.com>
References: <20190128141921.19043-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/isl6271a-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index ae29c8773057..6f28bba81d13 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -65,14 +65,14 @@ static int isl6271a_set_voltage_sel(struct regulator_dev *dev,
 	return err;
 }
 
-static struct regulator_ops isl_core_ops = {
+static const struct regulator_ops isl_core_ops = {
 	.get_voltage_sel = isl6271a_get_voltage_sel,
 	.set_voltage_sel = isl6271a_set_voltage_sel,
 	.list_voltage	= regulator_list_voltage_linear,
 	.map_voltage	= regulator_map_voltage_linear,
 };
 
-static struct regulator_ops isl_fixed_ops = {
+static const struct regulator_ops isl_fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 };
 
-- 
2.17.1

