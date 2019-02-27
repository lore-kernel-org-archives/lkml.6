Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA4C21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="v20kVgIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfB0Fyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 00:54:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33121 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfB0Fye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 00:54:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so7470642pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 21:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rPbU/rt1LOVVheudziZvt7JTQqGvlEoYaEmFMS5krLs=;
        b=v20kVgIzoQKKOngZQT0VHafOM7s1/mCTFb4sfS4LLkF8g8N0d49+6zuGVxJP4nkiXe
         spgu84gxsjI0YrLrYKiMAbPDTjGfxHoTGDNqVhxGZ7wqPwLGPSK/Flt9MdqP9E7/b7Wj
         aqsUXuTXTR5/wTR2znX1+WyaB7zdCpqeD/scvxw0PhLUSDyNq8FQWnlDArSFwbIwG3UR
         61jx9OY0kEv5/58ibJLpqbk5G20/gJVciqilg00TVrOGS6pULVZYi+Y8Ev+uNIghXqH+
         gSp9o1Nm+mFA4raGG3PaF3VXjdxzL1wpSRpL2GW6KOxK7yhZ/75IWbP9Sgk0AgUysSc2
         PUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rPbU/rt1LOVVheudziZvt7JTQqGvlEoYaEmFMS5krLs=;
        b=LuEMoIEEP4WH+dU4Lqofy0H10pqXyx4VEsw1MurMsdjn6wuAOcpc1giNuPTVe/7Ejx
         YRIj7hVlJ3U9XKbvp2zNfBPSz24dVa73ZjmGw/CTtGon/m8fyWG6JylAP8k29dAKPA8b
         1W2Dm+FQZbOOqID/yG3Oc7hBxHEEEpgejuORjcQBI2CK+XFWrwTC9r9fOiLxpFvKP902
         HqoqCrTyL1+pUE2JNZq5INbuostKevkrgJJbLY3YUFzrmYlP9sPe2UaIl9IW6a6Vwx5c
         Nnwi2mi+/4amin2aJI3GcbR/ZzJYQMKLBo2LI2jECcBcnBDxWFFLyVsTRulp8lEivQXE
         3RNg==
X-Gm-Message-State: AHQUAuYzUbZA5r+lWDu0jQU6144T0B5+FRbl9bgszrBxYK6+zlvDIcHy
        oKMHiJwQf76LV6AKSn95QRaICxW6Dba4zQ==
X-Google-Smtp-Source: AHgI3IbIdFrUUBIGDlbhotPPZPXRT86yltjV/HnHa+weZSYtORlEwThHOUoXWGva7VycFefAkdoEzg==
X-Received: by 2002:a63:cc15:: with SMTP id x21mr1365655pgf.380.1551246874041;
        Tue, 26 Feb 2019 21:54:34 -0800 (PST)
Received: from localhost.localdomain (36-239-237-193.dynamic-ip.hinet.net. [36.239.237.193])
        by smtp.gmail.com with ESMTPSA id j8sm18075482pfe.130.2019.02.26.21.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 21:54:33 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: wm8400: Fix trivial typo
Date:   Wed, 27 Feb 2019 13:54:21 +0800
Message-Id: <20190227055421.27582-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use WM8400_DC2_ENA_MASK for DCDC2 enable_mask.
The define is the same as WM8400_DC1_ENA_MASK, just a cleanup.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm8400-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index 40c4e6628471..5ce86b92851b 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -194,7 +194,7 @@ static struct regulator_desc regulators[] = {
 		.id = WM8400_DCDC2,
 		.ops = &wm8400_dcdc_ops,
 		.enable_reg = WM8400_DCDC2_CONTROL_1,
-		.enable_mask = WM8400_DC1_ENA_MASK,
+		.enable_mask = WM8400_DC2_ENA_MASK,
 		.n_voltages = WM8400_DC2_VSEL_MASK + 1,
 		.vsel_reg = WM8400_DCDC2_CONTROL_1,
 		.vsel_mask = WM8400_DC2_VSEL_MASK,
-- 
2.17.1

