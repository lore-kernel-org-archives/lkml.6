Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E36C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4742083C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tO2tIkKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4742083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeHaCkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33582 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeHaCkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id m26-v6so8481763lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pqtQEQgcmYws4XEfyflPCbTN6X5fe+IYsjDz9oA2yZI=;
        b=tO2tIkKCHTTqDX+ImB+86TWcltQLZ4UwSYVAP6DnTgClwu7a+F+Q6XoGLw6fzgfxnt
         N1tzvF/PH/J6lO+zzyuaA3OxvrXv++8+ibdSA0TcYMs1pY2gR5bmjIkDjU831MkWva2x
         +iLxA0h1akmwoaOI/JURnnhykjgRSpTR7q04A9mRTPJf8gUv33Wnx/noR30a+Q8g57UA
         FSwvHXzvkcpE84vkosQqMZ6uO6uM8ZDCmrx39HJFB6dM6t160kuieYAHDKHGeoLvbTyw
         7LD0K2MxJTVV3uZfq6edijJAEWDsjuIxEDOTaV9Pk0nNxVK+VGDqQn3h1zXqKadI0BZ8
         Ebmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pqtQEQgcmYws4XEfyflPCbTN6X5fe+IYsjDz9oA2yZI=;
        b=Jyd5eE1ZACiH7eHU0B7BJGBi3vFrH3qJp5kfAN3QG36uxZGmEEjwe3RLp8tlsA7M3S
         8jF/38fw6+nj/3J9EqvHaorMn/ZZAM3s3zkeuJVc0cd+HGhFF8zqxYF8AeIwa7nbC+Vh
         ZNgmsKEdtytq/eNPhZ74cBGPQCypMyQM9PQkOBBZf9qYLEJZUwg+FmdCAoyVHbQeClom
         iS37fXXi4VX09V3oiX6f5Foz+oFwSKYG7/LBFLMio3O9c1GW8yseOdTVUAtZfoDnotPZ
         SRlsMTUZQA4wyojK0cCdRT74DSDuG6ZNw2rGHwiYsnXHgK46jEC54uSJvHg2eRygt34g
         6W+Q==
X-Gm-Message-State: APzg51BbGDM68tcp3cCLSmtKUYgJFUmzWylDVMz34UVmZumIb5VD8vY5
        8qqJAIPdDo16ACQ5ChgYjNEN6wOJ3sE=
X-Google-Smtp-Source: ANB0VdZFCfHrsfHK2TpIIifDesrBbLjZC3M7c6gt/ndhhXXT27c5RpJbJR4NM+bSHmnIDhRy9Puz8g==
X-Received: by 2002:a19:5517:: with SMTP id n23-v6mr8953802lfe.101.1535668554195;
        Thu, 30 Aug 2018 15:35:54 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:53 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 21/23] filesystems: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:27 +0300
Message-Id: <20180830223429.30051-22-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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

