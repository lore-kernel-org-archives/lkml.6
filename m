Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F720C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BCF2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nsr6xWbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BCF2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeIAU7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:59:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40885 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeIAU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:59:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so2300681pga.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u2c/hW29Ku2OOossmzLDia39VFGH20ceUz/q+FPbXeU=;
        b=Nsr6xWbOcz1gnqPyZc63r79oVcwVoul6Hk5ZHTrJDDAlIHAjv3iX7s06/odhuzuE/m
         arW9NB07wrKoQUQ4ufj5Niw/suhXPvZ4t16B1Kf8FK65Zr0D97i6VE8hPwC4AXVfW6Dz
         YTrHH2vkFNdaffsH+NBtyf5f36SUx8d8PPsTyRl10d1WtiC233WtwHwdIqd8u6DD6qSa
         TWLUPZYumllIWjbt/LkJwkeqL38i+JvjbVfJDak51ze10miosN2O6Rt9DaGkApj5d26n
         NjbGjPmvrdaj+FS2UMM93ob1jZbW5r62OlR/ikwqvlmW6zBzL3t1LqSy02piglOTS2kB
         AsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u2c/hW29Ku2OOossmzLDia39VFGH20ceUz/q+FPbXeU=;
        b=qsKC1c0N2UqXwXt+LRJsdWqXRp+yrBQQRp2D2EmJ5TP0UeF2ietOFMEfElOImahnpm
         70JnUuQK2KCbASQ1hUMcrJAjsvUZSPL9rgZiIgAQdzSQltn1GS/FaCvV0FV4D2cNtQTF
         AJ8aXaL7p/U2a7SG4GM5MjbQ1bar4DrEVLQ2gSAh28AIyKWo1tR2aa/UvpfqsYfv0SyR
         GgizqLNGba/nDOyeRaWhK6pTRfbhQUC28KEuJbZOC+kMr+1R9WVc7eaj3lhvsSjEMNn1
         dwb07GfqJ23CdcYZ9w8HwdJY95XAA7X2eSwWU+4Af9BDLjIDd73qey4smHv3ObigHqUF
         ZHew==
X-Gm-Message-State: APzg51ADvPqsfy6D69nP6m0nm3/XguG+KW6iHXzkiSyWywfP7sCDCHgW
        vQuINNWtquqB6t3+QEvLmN3GqKOY
X-Google-Smtp-Source: ANB0VdZP4mL7t5qmD2bMrp0K0HJHESWZe9MMC/EPusJDDd/1CvlRcI7wnOLRb+dnGz7gF26maBP4Qw==
X-Received: by 2002:a62:843:: with SMTP id c64-v6mr21562253pfd.14.1535820422265;
        Sat, 01 Sep 2018 09:47:02 -0700 (PDT)
Received: from dfrey-debian-linux.sierrawireless.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id x65-v6sm22994095pfk.140.2018.09.01.09.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 09:47:00 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 1/2] regmap: fix comment for regmap.use_single_write
Date:   Sat,  1 Sep 2018 09:50:40 -0700
Message-Id: <20180901165041.25026-2-dpfrey@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180901165041.25026-1-dpfrey@gmail.com>
References: <20180901165041.25026-1-dpfrey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/base/regmap/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a6bf34d6394e..16414ccace96 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -149,7 +149,7 @@ struct regmap {
 
 	/* if set, converts bulk read to single read */
 	bool use_single_read;
-	/* if set, converts bulk read to single read */
+	/* if set, converts bulk write to single write */
 	bool use_single_write;
 	/* if set, the device supports multi write mode */
 	bool can_multi_write;
-- 
2.11.0

