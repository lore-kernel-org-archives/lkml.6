Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071BCC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6D32077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="gUaNQWOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6D32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJIQIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:08:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34027 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:08:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so496955plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3UhzX1sWkt6wCXg3IKpKTKTFMjY1cRkxypCoZjYYLzc=;
        b=gUaNQWOur0ApcwdA/+ALBEFVVI3c0i5QW39kOXQ7UcUzMbEiSHfmvG9TctgN+bC5mz
         Zv/EQY+3MVKkXgEs+KFc4C4e/d9gcazIQva8G107jwd4NcyvCSH1zVVH8c9A6miGYDGF
         qOLJ5LdpJ8zJI7QC7t1NxVN5YtN9Cak9afq69IVk7PvzkwTmPHK83jemmJhb7TdN4S2M
         mJB6eVbKs9I4zIM3VYs8RG49BPK4XmBUOjeeY6wY5KSZM1N9+lgg0nOuhNbqWGoeTKec
         /cQ/M5gOMudRX2aukxl7i2NWV1XzC62Qcvn7/0b2Zx+I2e/+cumF0V5H/JCTRjKt+9LN
         RIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3UhzX1sWkt6wCXg3IKpKTKTFMjY1cRkxypCoZjYYLzc=;
        b=QCCqB2EmT/y1I0L0sDGdwveGjz8oiMsIqMgIMR29rtQfXL9+e35kA8DkXjKX5yhGhe
         apZV7McAWbehIFbT3BUnZqGw3B9dp9bm2ykA1RmQVT0Ef8B/kziM2oaNhYZn6Rikcr07
         GGxNC+MspdxpFenOdHJ/vzkSstfTHrBpxJ5Nc7DoSmVRq2EzUK/5qNHjKCw6ZLXYWeyp
         ZoXArdhPyRqi7JgL1btYWZyQmYZJ0ti6hxg9Y5EYqQwnWyz6dVENnWMx/QV3q8BgiVz8
         tJhSKdThfpA0vmQyYCG76Ue9rOoZJZYa25xHnp5NAUWRMURqS9uoy6wbqwx1g/xKVCv3
         0DGw==
X-Gm-Message-State: ABuFfojf/Qi9VeKHoljlAplzRfavQBbMuWrInG9EJG1LfMQFN1oKbsEy
        tprWb02kfLU9MeX8Cnk+qgBMpA==
X-Google-Smtp-Source: ACcGV60yarqqE1hA8WYn8ZChr1tKNmDOKstMPoOulSAFSkqAxBgTEX7Lwc2H5NsUgaV3dqrRPUpUSQ==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6-v6mr26950819plt.19.1539075177981;
        Tue, 09 Oct 2018 01:52:57 -0700 (PDT)
Received: from localhost.localdomain (118-171-131-16.dynamic-ip.hinet.net. [118.171.131.16])
        by smtp.gmail.com with ESMTPSA id l10-v6sm35324475pgs.45.2018.10.09.01.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 01:52:56 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     pascal paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: stpmic1: Return REGULATOR_MODE_INVALID for invalid mode
Date:   Tue,  9 Oct 2018 16:52:21 +0800
Message-Id: <20181009085221.31137-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-EINVAL is not a valid return value for .of_map_mode, return
REGULATOR_MODE_INVALID instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stpmic1_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 96f18083a3b6..e15634edb8ce 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -441,7 +441,7 @@ static unsigned int stpmic1_map_mode(unsigned int mode)
 	case STPMIC1_BUCK_MODE_LP:
 		return REGULATOR_MODE_STANDBY;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
-- 
2.17.1

