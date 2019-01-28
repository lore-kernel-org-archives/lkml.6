Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C7AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2512214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Ti/fk/2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfA1OTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:19:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40078 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA1OTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:19:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so8051325pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TIrA+UiZ8OzYSgvryO7ku2L7kELl7Q69BD0bYjhsNrc=;
        b=Ti/fk/2qklvW94TK1w3xYLz/H9SoCp8YqiJpq0tTEqMR8vp1smQZDTz/sG5eTE7tjv
         4njUHMw1Y9ItSpQjyHYrCWIASEqLLc+cgVQ9dlr0ygP7sFwTjRO4p5m6Wbql2ia/WCn2
         oKPe8DMyEWHKNakNWZtOCwMpQ10YLZN5gHXWKN5dm6m7ROEKoiTqDR2l6cUmQeSN1QKT
         yL3S/7vCti3qRKELQVooyQF9ri13Te8MV8hgs+LyJ3xWdbCtkGhaTs+Lmh8B31k5Ap8q
         MDcTrCJRH2D/qqO9ATucVicl+7sUBTr1Q8WXiTTpPulDOMp+xGQNAe+t4iOML5bRx6G+
         viqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TIrA+UiZ8OzYSgvryO7ku2L7kELl7Q69BD0bYjhsNrc=;
        b=byiC1l016Td12gnM1lhC2ApnRrTSMT1rrudAk3zUtlu1hadFQ96uGQ/AX2kpNw2trl
         wv3dVlNsJleCoWk2B5gt/U0zkj7/K2MY/4M8Yka+BjBrj0WJomvD7lq6j6B20s26BJek
         aNlNiXyNwhvH/8+MMOo07BNzd/sEmN52S8N2W9REDNSl7LAr0/2a+wB/WB0IoIoOKrkz
         gu1z9cgycEEEBV4r/AX4YRigyDRVc3UJM3gG35oGAAKW9SjUyTZnTNWZaiTHccttI8a0
         YPO/Ksk3+7ph6IOXgt5PNDVDhJlVuVgkBiJoRf01zmH6CDUvm61o7dzRkVeQUy4OUdn4
         2fQw==
X-Gm-Message-State: AJcUukcIT2nnlkY6oTpsZYqbVa6bxhij2syFNNNG5k9HaQ7fXPX4oXH7
        n78596EYjXBUdwcE/ocrYN66kg==
X-Google-Smtp-Source: ALg8bN5W/js08JYu7toqgby8QLsqzHiOBc/6FAiKEuEkLiPSoBqFP6zF+SreO0KaMWt2ug6P3bewOA==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr19702752pgc.72.1548685172104;
        Mon, 28 Jan 2019 06:19:32 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id c4sm66255698pfm.151.2019.01.28.06.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:19:31 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: isl6271a: Remove *rdev[3] from struct isl_pmic
Date:   Mon, 28 Jan 2019 22:19:20 +0800
Message-Id: <20190128141921.19043-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is using devm_regulator_register, so it's not necessary to
store *rdev[3] in struct isl_pmic. Use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/isl6271a-regulator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index 4abd8e9c81e5..ae29c8773057 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -31,7 +31,6 @@
 /* PMIC details */
 struct isl_pmic {
 	struct i2c_client	*client;
-	struct regulator_dev	*rdev[3];
 	struct mutex		mtx;
 };
 
@@ -109,6 +108,7 @@ static const struct regulator_desc isl_rd[] = {
 static int isl6271a_probe(struct i2c_client *i2c,
 				     const struct i2c_device_id *id)
 {
+	struct regulator_dev *rdev;
 	struct regulator_config config = { };
 	struct regulator_init_data *init_data	= dev_get_platdata(&i2c->dev);
 	struct isl_pmic *pmic;
@@ -133,11 +133,10 @@ static int isl6271a_probe(struct i2c_client *i2c,
 			config.init_data = NULL;
 		config.driver_data = pmic;
 
-		pmic->rdev[i] = devm_regulator_register(&i2c->dev, &isl_rd[i],
-							&config);
-		if (IS_ERR(pmic->rdev[i])) {
+		rdev = devm_regulator_register(&i2c->dev, &isl_rd[i], &config);
+		if (IS_ERR(rdev)) {
 			dev_err(&i2c->dev, "failed to register %s\n", id->name);
-			return PTR_ERR(pmic->rdev[i]);
+			return PTR_ERR(rdev);
 		}
 	}
 
-- 
2.17.1

