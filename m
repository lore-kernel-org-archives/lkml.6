Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB3FC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1411921903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Ya02Rfui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfAZDkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33199 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbfAZDkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so5006611pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FB2HDBo2fJ1Vg2n17fymgtY1AAQPiycb4kajZ5KihdI=;
        b=Ya02RfuicFkEhFX+gY8bbL1rSmRMMPXth9KQkinnCzp7i0sTTMurpAKuDFH8SsQLCM
         zXukfvHeGVGWeL+69BOf5TulYP+COG7Prg48KXdb49vML+F/fH3NdzQKGyNKlrUzd88m
         rnGoJQJXbkg50WBmGf6nZOR/m16B5rwzjZdGV0PK4Y5KPTtLkHpPXasu1B8srgty1TMo
         GnjVeoVHOMVrT3rN6ZXp+RmNj3lgsi+VALHSNR6tQjYy57rYUvU8OvASYk6LEi06NVGP
         A8BFuWEAMkuf8iq89BBaocAMofzTYgCKZ+vS6JI6MQfjXiz3ZIB0j7POjH3Dsl7hOJgS
         8joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FB2HDBo2fJ1Vg2n17fymgtY1AAQPiycb4kajZ5KihdI=;
        b=FL8UqGe7eQboQN+zCfn/RE3cTAVbKVvUSRwGcqvy6X25nL8I+xvpC2/hIkEN0L3QtM
         5k7Cjdcph4tWL026urCoTT+KWe51b4YwBF+iuA7Yh6bMVkive5OUjsuhkuWmFrCf5D9i
         PtF4Bzu8Cpft84EAEMnxQ6azPSL0vlaxqNmQgQ7GawUdklQ7ci9QGUFCFZL9h0ykuA/k
         VBGrMwx9rEhX/7LL6Yiu72jj8dJRv6PvzCBrKiVNzBnzDgQMgmiuJYYPyNyLrdyvqCLT
         kB/21/q07gtQQouE/BUis2VBfIZa6j9XLc0udf6pqOHcQR98cGj4oFnuzEVq8zENRbK3
         kU7g==
X-Gm-Message-State: AJcUukcZoBNtvhWeU9UmkcPIdX6oZuEU1QptbfYjpFFN2etewxflGsfP
        chGCxaMGhhAJTKlNZRXfFENDHA==
X-Google-Smtp-Source: ALg8bN519i1ym9op8YCSA5zT7w/xeISwXElJtwAThOXYE1NHtqv0KH4YVlElubyzJ0zJsjzmsILb6A==
X-Received: by 2002:a62:1992:: with SMTP id 140mr13609177pfz.33.1548474018577;
        Fri, 25 Jan 2019 19:40:18 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:40:17 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 7/8] regulator: lp8788-buck: Constify lp8788_buck_desc
Date:   Sat, 26 Jan 2019 11:39:06 +0800
Message-Id: <20190126033907.18427-7-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126033907.18427-1-axel.lin@ingics.com>
References: <20190126033907.18427-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8788-buck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index ec46290b647e..30de784d8e30 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -370,7 +370,7 @@ static const struct regulator_ops lp8788_buck34_ops = {
 	.get_mode = lp8788_buck_get_mode,
 };
 
-static struct regulator_desc lp8788_buck_desc[] = {
+static const struct regulator_desc lp8788_buck_desc[] = {
 	{
 		.name = "buck1",
 		.id = BUCK1,
-- 
2.17.1

