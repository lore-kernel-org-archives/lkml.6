Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXwXCvLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E2720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeIGUzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:55:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38721 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeIGUzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:55:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so12741847ljc.5;
        Fri, 07 Sep 2018 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uU3iOjwDbuiq9iWp3teh7YUFYDt8JteuS6QVaTQs0e8=;
        b=sXwXCvLTbt0oPJQ7IRlXSXefFmPNeMzEGRejkDFriLheDn4LZiw7M6ZzPXCQfUkPdF
         xSduSdtSmRc8uZX7e1t03SeDgGVakdef7MTZR9mHjXuVePGBCFz/Z860EjX4JbaZkGmv
         wSE/iyHh2PEvJPzZwdPP9BgxB8wSZw7e5HPCIOXUAVJEThP7Ag/r29NcZMaaTqq8lbC6
         cWt0ZHJrKN6g5xjEGoevPUD/lJIYF7z7a5vDwE8Y1sW16M8IpMvKsR823BRq1o4aFTM5
         bdhWkzz0U5fziXd59hrmn0OQUB42R5ZoU4Gcs3V+fhVhYwxXRQuOxQ2qQ4+QqPigqWHd
         vYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uU3iOjwDbuiq9iWp3teh7YUFYDt8JteuS6QVaTQs0e8=;
        b=pnEJOXivFTBAUq7/jVjpIwe5SFzMEhRoRcIBHKLX51C03NpaUqnrkN/QnLbPikxhHd
         Cryds8xWQyZoQ0C2/5ErUBMH69vuFPExjakZRii92yRHRM1V6cdrFSIKGnbidA44mZrv
         V4SSWzOc27eLieBQgbl926yAy18ufGOkb6z3Q/ntQX+MMQyvbAuyyDc6fBO5CKNIMlRB
         pdZ9/0I0WgiQo5EdvecBWa4J0FJIiaSr4Y/reW/MF28LG9j4stDRa3MISCBLaR648dlk
         O70hsplNUC3Icw20uLeOAR4qn4K4JvztsEEiJArFStHqlHc4wrVkfE+9gukz+PXDYwUu
         OQ0g==
X-Gm-Message-State: APzg51AHRU1mrYlkzedcflpeTrbn6sTpjb8OAvPBldtgqFhz0gTsv+tG
        /G60SF0WxULptL87wDQ5mK0=
X-Google-Smtp-Source: ANB0VdZs8s6QA/+t/mXIUCsnbM43PTKGKNG8r0HQeXFdh3vdg5zrLRI/xFTXjysNJQ9x8WUxIjR78A==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr5349784ljf.102.1536336855551;
        Fri, 07 Sep 2018 09:14:15 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id x20-v6sm1358857lfi.8.2018.09.07.09.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:14:14 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] filesystems: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 19:14:05 +0300
Message-Id: <20180907161405.23761-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..19a9e4b378d3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -750,7 +750,7 @@ static int do_dentry_open(struct file *f,
 		f->f_mode |= FMODE_ATOMIC_POS;
 
 	f->f_op = fops_get(inode->i_fop);
-	if (unlikely(WARN_ON(!f->f_op))) {
+	if (WARN_ON(!f->f_op)) {
 		error = -ENODEV;
 		goto cleanup_all;
 	}
-- 
2.17.1

