Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B61C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57528206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="r8WSXUjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfAIJbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:31:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39055 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAIJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:31:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so3324762pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=r9g2fl+uk0xYlw7mbUe7EYhhNf8SIYDQx0juUeHJ99E=;
        b=r8WSXUjgeYWnTE329V60FMztl3FpfdaRu90/0a+8HU/oGRwlSnGr8yIUfMyZO0BfMp
         J168bXmQwA4kuliZVeNOC7yjMfgI18azguJOyc+SiOpLSjUbf1Kcg7/p9UbiJwwfhfYj
         S4SzAHridJueuuThkwZBXwQNa0DE8rBEzl/8QSzZDF5O2Hmr9SYr+UaAw4R97vfdjHEj
         Its/SUqQIISlOwB3D1hPsqFRh4xJanEPR0jmL9VdAaUFRYrSdBaT0kk/FojZEUAkinMd
         ECSQhyWSNmG8pBNX0bF9iX2Wz0IucKMfAo/bkrZKriZ2Q3sAm7MTluzMDQero6sLVy/5
         2dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r9g2fl+uk0xYlw7mbUe7EYhhNf8SIYDQx0juUeHJ99E=;
        b=NdSdvdmS9pN8cV+G/pEnvc+LFYLnWBHdRlN+r5ko0mW3Px1sUltLTjlYvh18HSLC8y
         8X4uFJ/OXRBJTz5JFCjiZifFBIjB3Ahdc47BPSxheuDMUM6Mu3RCwYNNfjOJnG2oK8Ch
         9Jjaeq5xdjspKRJJtc5F9A1KJOWlwybM5SR2YllhW2zSW9+VVkvN5XDnjZ2GY3Zf+22x
         xz1eaVW3/o3Vv6Rp+UoMPVDxpmwJ10kfm484J6QgU8HZUtNXmeZA95jdFnciRi10wNp2
         Q2FawFkODdkXYiBL0ERnIGuaAEnmMnDo11+9PFEfHgTWK7BcayC7N1s3f2Z2h008eRDU
         v7XA==
X-Gm-Message-State: AJcUukcYfpL6hTqWoMtCL5JJ441YkSJylm86indblH/KvPaohGJ9qceZ
        WLR1TogogMwNLhbXeiZpAAgrlw==
X-Google-Smtp-Source: ALg8bN6yHgKEZGimoTJjYgIPIaVqOSGplY6WPvyx+rOHEqVDojN7ETew8K4lMS5FJH2+AB76iRRqvQ==
X-Received: by 2002:a17:902:4:: with SMTP id 4mr5323891pla.20.1547026260002;
        Wed, 09 Jan 2019 01:31:00 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id n21sm103789604pfg.84.2019.01.09.01.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:30:59 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: twl6030: Use of_device_get_match_data()
Date:   Wed,  9 Jan 2019 17:30:49 +0800
Message-Id: <20190109093049.19068-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl6030-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 219cbd910dbf..78b964539775 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -687,14 +687,9 @@ static int twlreg_probe(struct platform_device *pdev)
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
-	const struct of_device_id	*match;
 	struct regulator_config		config = { };
 
-	match = of_match_device(twl_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	template = match->data;
+	template = of_device_get_match_data(&pdev->dev);
 	if (!template)
 		return -ENODEV;
 
-- 
2.17.1

