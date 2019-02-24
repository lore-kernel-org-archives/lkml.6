Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FF6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49404206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="UDDAcq7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfBXNRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:17:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45663 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfBXNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:17:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so3197445pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FMN/0tlZxmne4krJvQF11QGgjURkPq81IO63zBf4eQs=;
        b=UDDAcq7Xo4utKNCRIdvD9br4ZKafcu5yl1jdOXiDYNmOr2/+NYqEANAzood0sdXQ86
         e4jQlif5EkYp3LTwYivyGcUYjEYfqfAxiAEmoYSZ0CtJWzYHe1a4ljkCNTlCPJ0pnEnC
         +4i1U3A+JMbBRCYCdFIbhUjL2z2bW24ycOvLuCIGUXQZX4TY/D0/w8OivJ1oTMky8ltq
         RF9B1jrOXzizumIt0hWPUOukwf5kLY49Gsf3rheBrTPXWCwAbvbDpYkycXvVsiEbgGKC
         4Y4b4GpkJa6Z5iHoSMOQdaTAJZD/+0Go1KOp95q55Ao7QdbGnHf3UbrBWeUgkSJvDKvg
         pSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FMN/0tlZxmne4krJvQF11QGgjURkPq81IO63zBf4eQs=;
        b=YcmKN+1wiSx2Mrau1qjcdU7AK1L4KVtJ/fARxWDRn2eVPOQ1bfkX1HyrWEUJnzsNxw
         5tT9w/62LMr7CDbiHjkzpTaiqme6BpVT9+PFfr0QUplyWjmngIecrVhLTVO3WZCFpGPL
         Q72ol3hwcxoYeULCjaOBZiu1gWTBfM8k7TS6r4PdTyHFj7OFV0gO1f2MlSJg60l0M98G
         dHBzmhfVDmzRWgHMA36KGuc56gVprMuTG8kuiMc85g6xP6ZLSO/5B+zHu0oJiyXWOQhR
         hvA9vQW1/5fMI7EK9JfwD/NHc2KPb6MJBthyZUjehCrjG/knRRhYE48qH5Jxa+PA6PEc
         hWpA==
X-Gm-Message-State: AHQUAuYtirJK4kWQLior2HyyT+ikH+sJl0di60uGt4c/4LutTJw2Hl94
        DH0Rr/sCKGOr8Q1P/ZC7yGbnSg==
X-Google-Smtp-Source: AHgI3Ibb9fy/sn3ReATma8Mev3F0Bj5dI6Ubt/usf+0E2LOHwBI9qWcGdaXqMqI9bcsJEwiDu8mWsw==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr13190426pgv.244.1551014224344;
        Sun, 24 Feb 2019 05:17:04 -0800 (PST)
Received: from localhost.localdomain (118-171-128-111.dynamic-ip.hinet.net. [118.171.128.111])
        by smtp.gmail.com with ESMTPSA id 23sm9055666pfn.2.2019.02.24.05.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 05:17:03 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: wm831x-dcdc: Fix list of wm831x_dcdc_ilim from mA to uA
Date:   Sun, 24 Feb 2019 21:16:51 +0800
Message-Id: <20190224131651.11462-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm831x_dcdc_ilim entries needs to be uA because it is used to compare
with min_uA and max_uA.
While at it also make the array const and change to use unsigned int.

Fixes: e4ee831f949a ("regulator: Add WM831x DC-DC buck convertor support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm831x-dcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 4a573eea284a..828f262d6be0 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -304,8 +304,8 @@ static int wm831x_buckv_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 /* Current limit options */
-static u16 wm831x_dcdc_ilim[] = {
-	125, 250, 375, 500, 625, 750, 875, 1000
+static const unsigned int wm831x_dcdc_ilim[] = {
+	125000, 250000, 375000, 500000, 625000, 750000, 875000, 1000000
 };
 
 static int wm831x_buckv_set_current_limit(struct regulator_dev *rdev,
-- 
2.17.1

