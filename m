Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DB2206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/CcaRh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfAHNZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:25:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42218 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHNZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:25:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so1897715plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GILjKP7OqNfbuANgp3bXB5P2aPPVdL7FiqYBhMaOv/M=;
        b=o/CcaRh/eJ9APh2Gp6Jhm7ZJ6UZr6LzX8YQimsq8jt10aXyQAAvsFKBCAveK7v033B
         pvX9biqwj6mBlJZZm0xQAPXmcBqQbAuUm1NBJPpWaGo/LOfRKZFFbpcwNW6AkpbWK5rT
         0SXvMGOmqeD7kQLTqZQ+8j1mjTw+dRrTdYFZFyVhagucXzgEJH436i/aqFgIx/dzavsS
         2EpahowloqEVVkeiXOmNLnc9XeoQ6/8lX8hvHe43VYRcj364SILt8yOmMwNZN6sVqNkx
         Ig5dsgWiVhNm/NI2QHc1+JMmxHqsccdbEIeb+uPH2jT9H+aGc1iAvocyCAZu4FSfDfBN
         SO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GILjKP7OqNfbuANgp3bXB5P2aPPVdL7FiqYBhMaOv/M=;
        b=JDZE2pMXKfAH6mmvD9YSh9CAJEPApR/qH2k5leS6gqnUhPMOvXZteaPpJQ02MwCT4F
         6WvmVN/tKf+NMYqGn3woRW2a3zVVwPm6+MFkIoMrJSpfE5n9uqeWyOPuZjDeYhIDY4+p
         pt0Atjy6WhMejGmZmBAKJ/gfHY5Ibjz8snXh8BXbqnf2vxHZGB0ZlcHFB2txMuPdkIrh
         r1RXsol73lqAlyuljeEMdufiAcumjcfIbQ89BjI2iCGAmmIFWb5LQgptxOmJvKzfHK7/
         476wRyTOyiT4fm7lDTNcoQ/ILoZzY37g57cICKBm+QUS4sPhOJA0WEABZTqOe0PoXy3w
         Ej6A==
X-Gm-Message-State: AJcUukeyDi1476qSuufdgUGtWv6OoK2nPSS2cBPQ+HzGacWtTb0aDmZh
        RlaYN/X1x9FPxqmyU367Nj4=
X-Google-Smtp-Source: ALg8bN6uEWSIPzxtVBt0UzSFOvh46mYCTNKQxawtwxB+EolLZevGNh8PkqQxQ3Q8gy7RRlMWxifVJg==
X-Received: by 2002:a17:902:e012:: with SMTP id ca18mr1777954plb.218.1546953905843;
        Tue, 08 Jan 2019 05:25:05 -0800 (PST)
Received: from localhost.localdomain ([220.94.163.22])
        by smtp.gmail.com with ESMTPSA id l64sm87224371pge.73.2019.01.08.05.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 05:25:04 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Sidong Yang <realwakka@gmail.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: erofs: Add identifier for function definition arguments
Date:   Tue,  8 Jan 2019 13:24:54 +0000
Message-Id: <20190108132454.20513-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add identifier for function definition arguments in xattr_iter_handlers,
this change clears the checkpatch.pl issue and make code more explicit.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/erofs/xattr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 80dca6a4adbe..59bc5641c4e7 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -117,10 +117,12 @@ static int init_inode_xattrs(struct inode *inode)
  *                            and need to be handled
  */
 struct xattr_iter_handlers {
-	int (*entry)(struct xattr_iter *, struct erofs_xattr_entry *);
-	int (*name)(struct xattr_iter *, unsigned int, char *, unsigned int);
-	int (*alloc_buffer)(struct xattr_iter *, unsigned int);
-	void (*value)(struct xattr_iter *, unsigned int, char *, unsigned int);
+	int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry *entry);
+	int (*name)(struct xattr_iter *_it, unsigned int processed, char *buf,
+		    unsigned int len);
+	int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
+	void (*value)(struct xattr_iter *_it, unsigned int processed, char *buf,
+		      unsigned int len);
 };
 
 static inline int xattr_iter_fixup(struct xattr_iter *it)
-- 
2.17.1

