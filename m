Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A87BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A194A20837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TylwYp7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A194A20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIBAHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 20:07:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36665 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeIBAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 20:07:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id v26-v6so12536360ljj.3;
        Sat, 01 Sep 2018 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2CQwVn88qMtr+nDBz6JZccNLoDxgrniszTOuZEmAvL0=;
        b=TylwYp7xmkWixy9lGCLePD32T0KYBIQsfsVSNSQIxj1d61pqu+FfadsX0sg7XI3X0t
         1zwNDwJ1TvynbOgN4c6JvwrKVo5ha4x93sh1QiK1Y9uvpbIJjOMmS5/+kzI+jpd9jI3r
         bnqkW5MgscZmFNKNUk2edXDLZsPzGPylnAZ+i9o/4YMqlSugzzh1V2sNDSdfYqyfTLk6
         Oc5yxRxiz5yG6sJcSNisuzJ8xWm4NYBE96tqHgEadze84+kR1Sy8R3y+wCieJpt9XXno
         KRSBKULUhfv/gHKr96amFeBeeWXvM+IQNGpBHPqRIcHhfFrIUJieZMhsK0QeUkxrxz0J
         6e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2CQwVn88qMtr+nDBz6JZccNLoDxgrniszTOuZEmAvL0=;
        b=CY10gI+/+ooxbdzd0/b6pSDlt2qZVqnefF9KQCtw6QqzNS+Yp7w3POJov2LtZKvCX+
         HHbnF/2zlojpcA0i7RyGY4yY/jUItf2tP5Yd4xnJNx/GyIGUx5fFvP4RrE8e5WGlZUKb
         YU1PBLJtgweX+A94ug/X5P7oooSZkIJTsgvAb7uuBK5b+xOnqMss7hTI6MjG1nTo+/OU
         DoaqveVY+t8DJbvCHVTB70gLr/KU74JeNVs4LC+yYNDNY4X4caioWbCuoa8Sk+jWPQ/8
         YvVYtYcPPUVN9gByPJPeqE3IREe3lTHYVDMVU9cC1+D8q2zbfkWG1CmBCN3ppipDKknm
         PIog==
X-Gm-Message-State: APzg51Dg8Y3qNpp45KfQo451PZZhtbHIUsS1V3veAufsoPyL6qBjndbY
        UCjCvZ/51E/JO62SHZE1T/bAXSvY
X-Google-Smtp-Source: ANB0VdZRlLRNfKC0Wr8fnwazioQKu4ldYFzlWc5lj/c0L3mDCc9XfsRWHzYiicHHYNfQNZC6Ys2uvQ==
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr3889026ljh.6.1535831666551;
        Sat, 01 Sep 2018 12:54:26 -0700 (PDT)
Received: from localhost (89-70-31-6.dynamic.chello.pl. [89.70.31.6])
        by smtp.gmail.com with ESMTPSA id t15-v6sm1490011lft.41.2018.09.01.12.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 12:54:25 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: bh1750: switch to SPDX identifier
Date:   Sat,  1 Sep 2018 21:51:44 +0200
Message-Id: <20180901195144.11389-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop boilerplate license text and use SPDX identifier instead.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/light/bh1750.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index a814828e69f5..493ca7420602 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensor driver
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Data sheets:
  *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1710fvc-e.pdf
  *  http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/light/bh1715fvc-e.pdf
-- 
2.18.0

