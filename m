Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48958C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAAE218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lFr62iDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbeLSRL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:11:59 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60326 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbeLSRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:11:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id D0FF9C48
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 17:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9Ps0TClM6Alc for <linux-kernel@vger.kernel.org>;
        Wed, 19 Dec 2018 11:11:57 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A623EC71
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 11:11:57 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id q23so19243152ior.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mpgbGSojf4iIUc/IhhTETIGQooT/+0wh3zwx7ZJz4A=;
        b=lFr62iDxgPOd5Ogz/BqvNF+ibDRpJPCo3PJd3N+Jq+lop1BH8LD/M2+dRpq3s+URK4
         hp1b61z0zzPLxiPzhoq8RfiHCMiqLdHpUAPS22GWiMJF3/G6f7YFVjSsPY4AyNwlVVMR
         bQoUjBIwWnFVaoDbjGfm+zGuaxTJXfY5Lq64d1hUW/VA12f/M3/nLfBcf17SlmMpNNQ/
         hV0ACFAjhw+e1nFCBixvlWShBeIwPycvFZmc+icHal1/B3ON9/z4wuAZcmX5AD5yeKO9
         tCaoyxcWDzVyWAOde98YeWC/NaToqtbi5IUOuIft/bWBWnYvMAgbseACLcjEEjRQz2J5
         YsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mpgbGSojf4iIUc/IhhTETIGQooT/+0wh3zwx7ZJz4A=;
        b=LjoaX1+tSn1h/4ZoXYKZzEoASA9YKkjrrmYoBKqD5c9Hmfj0c+oUi8lS/od8GcjB/e
         jYHKszI5xvx8gaygTE0D53EGypcZR/iNaph2bkIjSLSRggS9Ms956zGkCJTU3v1GN0jb
         IFFA4hzp0fg7A9/SYYR8EuqLb0ba0mz2LgAzjxg+KNxkDtFeSOS8XDPihKmPOtkG9U5f
         quI7N7nvIhhwd1iT7FOpxZr0iOS6JB0D+nTmfDm0/bagOwWDCmsS19AyjOwx0wofXCKZ
         knJsLavKitBV82f6jvRh704lwSKX3e1neZ0G2bvFxgxhhlfipUiJi5yElmNjGdkJf9f6
         hibw==
X-Gm-Message-State: AA+aEWYQyMNy/yQ29l3WmfWbebW3RMzQh7Js4BpfhikOtFeVgzYRVI3Y
        +bOx9BD/BjBMoB5O1F7OhwWBgy+0m0Uz82WJbym1m8r0FveKAPCAKCH1SOcmMZ7iIORKqsZOm3H
        AAC8NBAnRojZzs0hdIDJHMrV55+PX
X-Received: by 2002:a5e:940c:: with SMTP id q12mr6431364ioj.228.1545239517280;
        Wed, 19 Dec 2018 09:11:57 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Vzc9w8c1P7GWm/ly49iXNG10CJq14biPkHn1etTp9QgYzEYZnCnPaQixV2qdpn/OY9+K+lZw==
X-Received: by 2002:a5e:940c:: with SMTP id q12mr6431345ioj.228.1545239516899;
        Wed, 19 Dec 2018 09:11:56 -0800 (PST)
Received: from er-10-131-57-120.wireless.umn.edu (er-nat-tc-131-212-249-147.eduroam.wireless.umn.edu. [131.212.249.147])
        by smtp.gmail.com with ESMTPSA id u3sm3539767ita.18.2018.12.19.09.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 09:11:55 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulator: palmas: fix a missing check of return value
Date:   Wed, 19 Dec 2018 11:11:39 -0600
Message-Id: <20181219171139.39388-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181219050413.16374-1-kjlu@umn.edu>
References: <20181219050413.16374-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If palmas_smps_read() fails, we should not use the read data in "reg"
which may contain random value. The fix inserts a check for the return
value of palmas_smps_read(): If it fails, we return the error code
upstream and stop using "reg".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/regulator/palmas-regulator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index bb5ab7d78895..c2cc392a27d4 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -443,13 +443,16 @@ static int palmas_ldo_write(struct palmas *palmas, unsigned int reg,
 static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 {
 	int id = rdev_get_id(dev);
+	int ret;
 	struct palmas_pmic *pmic = rdev_get_drvdata(dev);
 	struct palmas_pmic_driver_data *ddata = pmic->palmas->pmic_ddata;
 	struct palmas_regs_info *rinfo = &ddata->palmas_regs_info[id];
 	unsigned int reg;
 	bool rail_enable = true;
 
-	palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	ret = palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
 
-- 
2.17.2 (Apple Git-113)

