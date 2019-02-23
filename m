Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E50EC10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A7920850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjb+/2w2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfBWGfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:35:55 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44029 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfBWGfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:35:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so3791928ota.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yhOgIfVhgUxGNA3/y93NZzblYSFJxAnLZ4az1Uovz+g=;
        b=rjb+/2w2PubEGHI9lliFmVPoFeNasdkJCgxE/2BySo9p4LpVxc8wZn+GyDpMxmmfUF
         0Pti/QbQ1y61AV9qVdT62xQelKgS5bn7luAnZKkc/J9x80tajd4eBFtPnGFqm/j4Gr+H
         u6NyvXrZ+FKzzU4mGJInLoR0QVTc/SPdqZsJ3v1QZ272YkjBnP0zUSdT1syIAMcDDcb9
         Q8yq31NXt9uvXpbqdtJLyaLVGIUD3h0McapYgi1EfQhynpA3mbhNzueTag3g2R34h6Tt
         SjmE7USfjl2LgKC2jGG5y+7hk9mGNfunxYrq4PJ7+MDcMNRU2wuMLmyAMHHWPG+kkwqt
         VClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yhOgIfVhgUxGNA3/y93NZzblYSFJxAnLZ4az1Uovz+g=;
        b=MnstL2VOhA0/el0IeUzXBKsvj+zDx2NXMne9aar2bCD4Op/zH84JpZOausnXnSXr1B
         rTsZj4x1mM5ivmMjXIdvsPRt6hr9uH6GTbHqRRnj2zMKzeR8rLZ55s9dczM2kmanTi6y
         bbqA6mQGF7hA0MDMhVw6Uf3wGKof06wPLs5DJQ+Tyf3c5F/T+QX8ucwPr/vzYMluWJb9
         HtIuUzm9LV5a4Vpn4/K+TyrvXOkdjV8CeFFK8h8ZLI1kvwiUL8ft5ErMuYVnm3dm+xVN
         yIfWiLzu30/S70vS8+JaA7WYh//MaganQHkpWsG2lW0JSRk3mVgDCDS+oFy07zMjQRhV
         TF7A==
X-Gm-Message-State: AHQUAuYungQHcbpaH7KywdkA9uIkT1M36rxSKmtXG+P7Jner9Xl/oaik
        fHmcoHZw37WqtlASadV8dgTnAg==
X-Google-Smtp-Source: AHgI3Ib7kGGQwRjZumRNBfzx4tHBxgD5HSybVQ45ClMb0XYFBia3t/NURMgVbTKpAkpjL+nJ7awQsg==
X-Received: by 2002:a9d:4b13:: with SMTP id q19mr5304066otf.304.1550903753684;
        Fri, 22 Feb 2019 22:35:53 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c24sm1510112otl.67.2019.02.22.22.35.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Feb 2019 22:35:52 -0800 (PST)
Date:   Fri, 22 Feb 2019 22:35:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] tmpfs: fix uninitialized return value in shmem_link
In-Reply-To: <20190221222123.GC6474@magnolia>
Message-ID: <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
References: <20190221222123.GC6474@magnolia>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Darrick J. Wong" <darrick.wong@oracle.com>

When we made the shmem_reserve_inode call in shmem_link conditional, we
forgot to update the declaration for ret so that it always has a known
value.  Dan Carpenter pointed out this deficiency in the original patch.

Fixes: 1062af920c07 ("tmpfs: fix link accounting when a tmpfile is linked in")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0905215fb016..2c012eee133d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2848,7 +2848,7 @@ static int shmem_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	int ret;
+	int ret = 0;
 
 	/*
 	 * No ordinary (disk based) filesystem counts links as inodes;
