Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DE0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB28A222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="Q3FxjuCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfBLVvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:51:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55488 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfBLVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:51:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so226211wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JN1AEnmAft6YdhaB9N9IbIog1CeBLAKXkz5ScgmOkQU=;
        b=Q3FxjuCZ5BpI8wEZMgb0ohV64rPlT1B+fGPmnpXS7bAizooy2NhO4cTPWQ1NtAkgrw
         c5niJnM+vU8h5eCsScxQs6MoqtY7A6015rvqjCB6Q/oHLvtJ1O2DjguQoy2fQgfEcDJD
         RSYsU6eqfbt4d7YBlF8t4wKCP+tnw1emWv2IXrgfFdqhig5SeeQSTzIL6jE//olxvWpj
         HqaDVV6YiHydqSSWYvdLKsELuG2haRiVMiE3l3RndyhpY9JaniaxkvKC9zdNccv2a4C3
         ftUqzvEG1IbjrtBd9gi02v9zMH2MElrwGzkZjY6K35zfaOGRn+H6/zndIR9hY8Qdiw9H
         Dt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JN1AEnmAft6YdhaB9N9IbIog1CeBLAKXkz5ScgmOkQU=;
        b=dqA0j2VkxB7s7TR5OaWbJ5tzouyP1nX9P9/NWfXG74mK+UlkNNZSR+l3Czn0j8klSm
         4ZW8IjT2lYMl+9EvP5Eb3xvMkTsG8RNBa9dzNBEQXdhLG1sZkeMk4Zhk913PYGhFdE7z
         1ONKF2giMW6uDrV+xrhvktF25ttVdECosiTJRLo6IkgXeXDI2yiCkKoWw0X72/+bsiKm
         Md9KPtMtBiY+S5EQMrd/sjK895F5LJkezpOKJ+RvvBTKcA3nTmBM5a1gE8SE/KbQRsJz
         svHaykxEg9kuoLvXj0brIhsGUgiH80GLBcwzjHRCWjOHJU+kEgiFn6VBWPxULG0gm9WZ
         JMzw==
X-Gm-Message-State: AHQUAuaLTr7cQHcSRRwSjvjapl7QCWD7Kw+hfKVmhSOAmCNf/IxduUi/
        RthiLZHTmBhXUd3TlM0yHMpqIw==
X-Google-Smtp-Source: AHgI3Ia0f4QMWLYrXrAs+tEoSTOhg0p3FuJc5M7/veLyzKRGe0Gv7zFSXPFOyO+bFnGfZOjv/qsZCA==
X-Received: by 2002:a1c:e911:: with SMTP id q17mr772390wmc.31.1550008282767;
        Tue, 12 Feb 2019 13:51:22 -0800 (PST)
Received: from localhost.localdomain (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id y24sm7784528wma.0.2019.02.12.13.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 13:51:21 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH v2] regulator: s2mpa01: Fix step values for some LDOs
Date:   Tue, 12 Feb 2019 21:51:18 +0000
Message-Id: <20190212215118.9779-1-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The step values for some of the LDOs appears to be incorrect, resulting
in incorrect voltages (or at least, ones which are different from the
Samsung 3.4 vendor kernel).

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/s2mpa01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 095d25f3d2ea..58a1fe583a6c 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -298,13 +298,13 @@ static const struct regulator_desc regulators[] = {
 	regulator_desc_ldo(2, STEP_50_MV),
 	regulator_desc_ldo(3, STEP_50_MV),
 	regulator_desc_ldo(4, STEP_50_MV),
-	regulator_desc_ldo(5, STEP_50_MV),
+	regulator_desc_ldo(5, STEP_25_MV),
 	regulator_desc_ldo(6, STEP_25_MV),
 	regulator_desc_ldo(7, STEP_50_MV),
 	regulator_desc_ldo(8, STEP_50_MV),
 	regulator_desc_ldo(9, STEP_50_MV),
 	regulator_desc_ldo(10, STEP_50_MV),
-	regulator_desc_ldo(11, STEP_25_MV),
+	regulator_desc_ldo(11, STEP_50_MV),
 	regulator_desc_ldo(12, STEP_50_MV),
 	regulator_desc_ldo(13, STEP_50_MV),
 	regulator_desc_ldo(14, STEP_50_MV),
@@ -315,11 +315,11 @@ static const struct regulator_desc regulators[] = {
 	regulator_desc_ldo(19, STEP_50_MV),
 	regulator_desc_ldo(20, STEP_50_MV),
 	regulator_desc_ldo(21, STEP_50_MV),
-	regulator_desc_ldo(22, STEP_25_MV),
-	regulator_desc_ldo(23, STEP_25_MV),
+	regulator_desc_ldo(22, STEP_50_MV),
+	regulator_desc_ldo(23, STEP_50_MV),
 	regulator_desc_ldo(24, STEP_50_MV),
 	regulator_desc_ldo(25, STEP_50_MV),
-	regulator_desc_ldo(26, STEP_50_MV),
+	regulator_desc_ldo(26, STEP_25_MV),
 	regulator_desc_buck1_4(1),
 	regulator_desc_buck1_4(2),
 	regulator_desc_buck1_4(3),
-- 
2.13.6

