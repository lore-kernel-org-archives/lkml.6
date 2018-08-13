Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01154C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976A021771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfVUCFNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976A021771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeHMMU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:20:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39357 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeHMMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:20:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so7420885pff.6;
        Mon, 13 Aug 2018 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=REukuXf0xkQhEPITAZH5ZGcVvOwga1utjzmu9MtDmyc=;
        b=vfVUCFNupVJi8U0Qg5bvE3d8Gj08dn5ZIRcZqUIyJPeYZTKr6xSGV0VethFrVZnzbp
         iFpdGswnjjk0Ey5ad6Xb4uvy1MNkz9Ui+t3011fW7yADG37DigSLWh0V5QyBly1ecGJ9
         H1J+2nGlrtE5L9ISr0eAs+NXeCxD6g/3rnRifXEOLZm8rrOotYHpLTazMM8aMi+Pew+2
         EBOyCoF5UIB4pTLuANCnT0W5nH2cw5mlFNhl+eQC88QB5kafmoyMWd3MrlAnTgXxUVGw
         Citqe7jZHWaIF9wIuW7vOjuZ+HvLwgDMR548G76nG9cr9nyeU/PJGGfAKHAu7WVtkAXQ
         O0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=REukuXf0xkQhEPITAZH5ZGcVvOwga1utjzmu9MtDmyc=;
        b=R9JU1nGhbFNTR/hkdhgM7pT6Y+AoUXTVMPZwFS/NhBG/Z0oVYG4n/NYCT3eQF/fM4d
         TQup3qsii9d7m+IkS2CF22+82GVyuM189p+pCK+daRgXsHWC4U+ma4K4VTKhx8TfOsU+
         cMJFtHhDMvB4LJeZeNkbiFDq/0XXn7aQFWWZKrSh8jlf0MkvA/9XrIOQDuWY6JN+BKT6
         Sa7V+ksZQn+RBu0HOzB/hDIqAVeQSEuYX2ZHxGekEbo1UsNymEvyz4mFVerSnWfupj8j
         qaJwzh8YzNf56/xHITEbtGmnvlRbgWUY/U8nafui59zPsQe3xD2aKUg6hgiIxuv/y+Xo
         VTvw==
X-Gm-Message-State: AOUpUlGPEjVN65m/7/55GLBzt1nVAXM9Jm5mnReNu/mTAebViakkuZYJ
        QvNgG1baweTK2nlgf3RlzZM=
X-Google-Smtp-Source: AA+uWPx12b/H/Z6Y4EwR9Dn3IOul25G/HYZdhMZL+qSsrP7gdD2FriAeZn6C94DcUFy9d6BQ6sz8lQ==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr16021830pgs.390.1534153139826;
        Mon, 13 Aug 2018 02:38:59 -0700 (PDT)
Received: from linux-zmni.apac.novell.com ([45.122.156.254])
        by smtp.gmail.com with ESMTPSA id l79-v6sm39323128pfb.111.2018.08.13.02.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 02:38:59 -0700 (PDT)
From:   Sean Fu <fxinrong@gmail.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Fu <fxinrong@gmail.com>
Subject: [PATCH] md/bcache: Remove NULL check.
Date:   Mon, 13 Aug 2018 17:38:49 +0800
Message-Id: <1534153129-24869-1-git-send-email-fxinrong@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnessesary NULL check before kmem_cache_destroy() in
drivers/md/bcache/request.c

Signed-off-by: Sean Fu <fxinrong@gmail.com>
---
 drivers/md/bcache/request.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index ae67f5f..0ddee35 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1306,8 +1306,7 @@ void bch_flash_dev_request_init(struct bcache_device *d)
 
 void bch_request_exit(void)
 {
-	if (bch_search_cache)
-		kmem_cache_destroy(bch_search_cache);
+	kmem_cache_destroy(bch_search_cache);
 }
 
 int __init bch_request_init(void)
-- 
2.6.2

