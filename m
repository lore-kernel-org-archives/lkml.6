Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EEAC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254C12176D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3jLkVn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254C12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeHDCUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:20:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40815 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731959AbeHDCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:20:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so3228032plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lk/Nf14DXiH2q4i7OiDTuNaOniv+6pKtvltdbkxSRhQ=;
        b=p3jLkVn/gig8c0Kl6lmIGm7Dk70euCl2pO3/Lt3FjGypCJ6p5QR2OBnntBVBN7paTr
         vaUmYLk3PyNX5LfsUZCrda7idHaxroSH0xcg71cLqGiXOxWn5T+cFBEofZkHX4oyOD74
         2c4ZVIc81Oye7leQasDqTN9Y1Qn1w3NRB8wPhZrb+YGWUHW9GE1SH3mLTWNE0/xIHf8C
         b8ANN+OIF81SEFZv11iKuHpVOPdObyAqJGV1gXQsK/yel2gcb0bP/KOHI3UCxJVeyYGs
         HdRqeKCtWP6FNffQqAkjjKI5kK1StXZQhbE2CKX3sAD418PbqncEPE5Eep8K3hHqtZPh
         IknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lk/Nf14DXiH2q4i7OiDTuNaOniv+6pKtvltdbkxSRhQ=;
        b=MuWFk/B1fTiFAEcdKsQNOdKKl196uChhwpOjv61EjEpMBunwOYYhGGkoLzlY1T/XTg
         /PVW+s9BSCZ7GtcEy3spyHfHk1ZrnQjPhBWOQ2So8zsQMl55bGQ+9mY/kUqQPVxuy1RD
         EaC7ZB9gXtH1ifoSUgSSTBioX3K5koppOy/c+M/mA+1z46hdPJXB8QMAOZ4Kshpvc3Re
         PfeFtQkGjOdwFcbYq2SKqqGGTyMhWj08MTWdmXyf3IpuzHbrvLL339dhCOY0cc9H3wgu
         JkWHaqxKNU/TgPSOCWF2txaEc7PzocL34midw5oRRQhwkZFjp5DsoK7QzvFUiPOSu80Y
         spRw==
X-Gm-Message-State: AOUpUlFTofVvTB1tQ/IRFKMDktynSekqYY+JjAuM9YWmUjYq6KwStCwC
        n/A5SdhapzDcf1AB6kP/fFA=
X-Google-Smtp-Source: AAOMgpfoA09CsM7l7ByzuMqAQ9ieYbO+oAOkwKwrH9HZJC8p5I1b20k1eIh5arAhZtdjubmt5ZKRcA==
X-Received: by 2002:a17:902:543:: with SMTP id 61-v6mr5504617plf.126.1533342117545;
        Fri, 03 Aug 2018 17:21:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id k6-v6sm5545032pgc.71.2018.08.03.17.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:21:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: r300: Replace mdelay() with msleep() and usleep_range() in r300_asic_reset()
Date:   Sat,  4 Aug 2018 08:21:50 +0800
Message-Id: <20180804002150.18247-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r300_asic_reset() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/r300.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 21161aa8acbf..55cf02400d5a 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -434,9 +434,9 @@ int r300_asic_reset(struct radeon_device *rdev, bool hard)
 	WREG32(R_0000F0_RBBM_SOFT_RESET, S_0000F0_SOFT_RESET_VAP(1) |
 					S_0000F0_SOFT_RESET_GA(1));
 	RREG32(R_0000F0_RBBM_SOFT_RESET);
-	mdelay(500);
+	msleep(500);
 	WREG32(R_0000F0_RBBM_SOFT_RESET, 0);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	status = RREG32(R_000E40_RBBM_STATUS);
 	dev_info(rdev->dev, "(%s:%d) RBBM_STATUS=0x%08X\n", __func__, __LINE__, status);
 	/* resetting the CP seems to be problematic sometimes it end up
@@ -446,9 +446,9 @@ int r300_asic_reset(struct radeon_device *rdev, bool hard)
 	 */
 	WREG32(R_0000F0_RBBM_SOFT_RESET, S_0000F0_SOFT_RESET_CP(1));
 	RREG32(R_0000F0_RBBM_SOFT_RESET);
-	mdelay(500);
+	msleep(500);
 	WREG32(R_0000F0_RBBM_SOFT_RESET, 0);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	status = RREG32(R_000E40_RBBM_STATUS);
 	dev_info(rdev->dev, "(%s:%d) RBBM_STATUS=0x%08X\n", __func__, __LINE__, status);
 	/* restore PCI & busmastering */
-- 
2.17.0

