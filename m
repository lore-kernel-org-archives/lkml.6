Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2C1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6E62075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jls4d24e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6E62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeLNF6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:58:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40482 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNF6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:58:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so2290814pfo.7;
        Thu, 13 Dec 2018 21:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p/3Io+yWOBV2KksLV3wu5k80Nq8VCOojYa4YE4rh5RQ=;
        b=Jls4d24eNMzUV2xQd9x2Rrvf7ZmVGKB+Ljg9zCufxFdrvkes2snixQ3XN+GpFBAyZB
         YNsM1HfnOLtognw+5Kiu9VSJZCApOZgsy+t2ZkpOu/gPzZ83OmJC0cBDPhDrEDMNNIwT
         xomSLW3ChpqGyGsNQmiXeJMkWU4EUbbNAtEZVq18Qj7M1MoZJk1tPT+E74ykK1tmsEj3
         RAt+uzqHAdmmvLgUF7wH/Iarx0yo7Le+BM2sjimYDlC7ydJxl31haFSsrk+If9KHizQO
         LNFcrYdyRaMJ31hWOYheFWl7el/auSrdFCVk1N2aDWCuN+JlQOW+m47NQngrFI5Z8zmX
         P6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p/3Io+yWOBV2KksLV3wu5k80Nq8VCOojYa4YE4rh5RQ=;
        b=T3MjdeJSy6ijfqkGJ+hZSAh06IKDYdY80OKBgPR/KDMKL02kVJGiybX2q1csoUhSue
         XfSnpKMsReJfKUEquoRA5HkSsVKzVInUNXZzQ/fiIg6EPxNMRUBVaS6bEKC3EMIrPAe7
         tDHib61ysnzwgFH7yBse0ORgF6eRHaicbiuW2+XlPqmVvWqRLfeLSheCET8ZSDmL3A9D
         Y1kSq5yCHtTlzfR69pAtIwCPhmM9Zs7rdCD/rEYmoSBa2GfC+nxt1i7mNuW5JjUvRyTn
         RW54pTfpOIQceTz5Jdvg4KRFBnuOjwkdSEMScT1ZRIdgTBUAp+yaHjfo1eXVmrr69DGL
         2OBw==
X-Gm-Message-State: AA+aEWb6NtTY0+j+PC1LA85fXZ7ZfdS4pgWr+naQAng/8UpPJa2sHJYa
        CCW8BzQ0tA8PvJuyf7MhUAs=
X-Google-Smtp-Source: AFSGD/Wfj+r0zbbSAiTYpGOcDJPIiEp2JGYAbwtoT9Lvd2DBcZJjfXCh0iTeHKkXYmG+qYUImrRHaQ==
X-Received: by 2002:a62:b511:: with SMTP id y17mr1627461pfe.199.1544767087575;
        Thu, 13 Dec 2018 21:58:07 -0800 (PST)
Received: from gmail.com (104.194.84.186.16clouds.com. [104.194.84.186])
        by smtp.gmail.com with ESMTPSA id w88sm6410009pfk.11.2018.12.13.21.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 21:58:06 -0800 (PST)
From:   zhangjun <openzhangj@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        zhangjun <openzhangj@gmail.com>
Subject: [PATCH] fix page_count in ->iomap_migrate_page()
Date:   Fri, 14 Dec 2018 00:56:01 -0500
Message-Id: <1544766961-3492-1-git-send-email-openzhangj@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMAP uses PG_private a little different with buffer_head based
filesystem.
It uses it as marker and when set, the page counter is not incremented,
migrate_page_move_mapping() assumes that PG_private indicates a counter
of +1.
so, we have to pass a extra count of -1 to migrate_page_move_mapping()
if the flag is set.

Signed-off-by: zhangjun <openzhangj@gmail.com>
---
 fs/iomap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 64ce240..352e58a 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -544,8 +544,17 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 		struct page *page, enum migrate_mode mode)
 {
 	int ret;
+	int extra_count = 0;
 
-	ret = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
+	/*
+	 * IOMAP uses PG_private as marker and does not raise the page counter.
+	 * migrate_page_move_mapping() expects a incremented counter if PG_private
+	 * is set. Therefore pass -1 as extra_count for this case.
+	 */
+	if (page_has_private(page))
+		extra_count = -1;
+	ret = migrate_page_move_mapping(mapping, newpage, page,
+		       NULL, mode, extra_count);
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
-- 
2.7.4

