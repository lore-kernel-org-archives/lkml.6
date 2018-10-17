Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E61BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AE821526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="2Pr7LSjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AE821526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJQSDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:03:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39579 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:03:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so1503050wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lx0cw+9rF/07CO1RshCjn2zaAnRoqJpQJvSZ7+l+DRw=;
        b=2Pr7LSjzhDj0BACYKlsB5/35jjRH/akXhTwsa6UMp0Nzc8IGSpZxeR4CHRTLyYcEkU
         p66F+8VgHEKrty/uVuldYE0JXfc+PMevT6VVutVlsBmQPLjqCH3I1HHLjhkr1ojEIVVc
         PVW3CE78UBqztvG/y1J71EhxbgSEsTd/n4CT0IEHxbgJaj3WviHQ4a/5QqGsB10znT8M
         s+cQWTKAGHRLYg2U/QAigeJ9670cC3vfRqRKAPjOw0ZeLvjEIMpZkHJK5ODNVO/IzMMX
         Cq5o5egv9DMVCWiCHQCOYscPuiBENr316xgbt3lmhafZlwdTfDNb1iQcqHsr0U1EP33t
         qxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lx0cw+9rF/07CO1RshCjn2zaAnRoqJpQJvSZ7+l+DRw=;
        b=pUtBOsYVhqXlH+EofoEoQ6G7Pa0IhQWx6GvE0kZb9r+u2xeEOYp7As/QjnId7pmfqr
         iG5/td8ZccP2kURkVSOig64OxBasQGX1xhgF5Seu8Q+bOkw9Tkw+Hor+ZJ2wEHlK+INL
         yN+Aoi2YKe6jTnx/ktctDeVxX7ApNuTnmhE9WttIqMuCVztMzQ0jXFUpc31cZt5hUQOT
         rfTpWJYW4vhAFA6vOtYeyWMbXcdmaBX0/gnt87nqCLwUNbPauH1KTZuwOVD3ZpTuJRfO
         4Eq/gEfhm5No6bT2A+jWXTyiaH2ELbluLLNU9FQk4wNIQ5j10gzJjyuaU1LceOIykWGR
         WoRA==
X-Gm-Message-State: ABuFfoiOi4bXEB37zFUcDmaSfSdLVnpLlKKYyIuvE6Nclnv5kua8U2db
        1o8j82gUwHab8WnAhPJltHtk4Q==
X-Google-Smtp-Source: ACcGV62ReuRn8UFxlWuwqj8sKgRib39ILxwvvvOJ+hdAzk81sPI8AwBtcGhUNUQKkLQaHg0QQvmlYw==
X-Received: by 2002:a1c:5fc2:: with SMTP id t185-v6mr2115908wmb.12.1539770891024;
        Wed, 17 Oct 2018 03:08:11 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id o201-v6sm1783038wmg.16.2018.10.17.03.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 03:08:10 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:08:09 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181017100809.GA9070@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
header and replace with simple assignment. For each case, S_IFx >> 12
is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
us the correct file type. For invalid cases, upper layer validation
catches this anyway, so this improves readability and arguably
performance by assigning (mode & S_IFMT) >> 12 directly.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ufs/util.h | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1fd3011ea623..7e0c0878b9f9 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -16,6 +16,7 @@
  * some useful macros
  */
 #define in_range(b,first,len)	((b)>=(first)&&(b)<(first)+(len))
+#define S_SHIFT			12
 
 /*
  * functions used for retyping
@@ -158,34 +159,7 @@ ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
-	/*
-	 * TODO turn this into a table lookup
-	 */
-	switch (mode & S_IFMT) {
-	case S_IFSOCK:
-		de->d_u.d_44.d_type = DT_SOCK;
-		break;
-	case S_IFLNK:
-		de->d_u.d_44.d_type = DT_LNK;
-		break;
-	case S_IFREG:
-		de->d_u.d_44.d_type = DT_REG;
-		break;
-	case S_IFBLK:
-		de->d_u.d_44.d_type = DT_BLK;
-		break;
-	case S_IFDIR:
-		de->d_u.d_44.d_type = DT_DIR;
-		break;
-	case S_IFCHR:
-		de->d_u.d_44.d_type = DT_CHR;
-		break;
-	case S_IFIFO:
-		de->d_u.d_44.d_type = DT_FIFO;
-		break;
-	default:
-		de->d_u.d_44.d_type = DT_UNKNOWN;
-	}
+	de->d_u.d_44.d_type = (mode & S_IFMT) >> S_SHIFT;
 }
 
 static inline u32
-- 
2.17.0

