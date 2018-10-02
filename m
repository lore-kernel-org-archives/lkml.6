Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4911C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F5F2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="aJ1r6ESx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F5F2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeJBXZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:25:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44510 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJBXZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:25:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so2981257wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lx0cw+9rF/07CO1RshCjn2zaAnRoqJpQJvSZ7+l+DRw=;
        b=aJ1r6ESx/4Zn+D/z1M3S3UmtlyeBUi2Y7AOi/vgUyQmdFJY3bQ5FXHUdFWKFesRY4B
         eL8oaAF7Ipb3BSyuDq2Jm4cOXiLH47iUQmMzjwiqY7jRbc3pYm3aUd/+CoPlULF1WkMG
         0t+TyDudQClpl1eicP8tXD6mGWyNxoc57xJbki50t10aH0CtSZ2O7h0FncnkJmhQU9T0
         cZeK2SYtGWM4gn5HROLaCOml4Bq79L29BOQjVqIQXk7rHvfTWscyUjAB5HOZAaiz0afp
         deJw5tBG7tevMnfE5/UqjFzTqK2rhk+EJZ6d1NRTBWj2IzQZB4rWjQFXZGQoz9UYQX42
         PmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lx0cw+9rF/07CO1RshCjn2zaAnRoqJpQJvSZ7+l+DRw=;
        b=tIbT9nAsZvO2ZUoEH7JWKZ92zKjgxW6pAGvm1um4b0GIS5x7S41QQzkhACaW+MnSNP
         kJdIXjVmEz5Hmrm8VM6qkUSxNI1V+uRUArCnD3Fxf/CraAIE4DPW9ysjcdqT9Ss2ZyLo
         N2ZQySisafEI42gOusGtbrxoY9mlm73mhWncCM5vRnjHDM7TcIxrk8i3/wAe/L8lS2EV
         p5MIsR02nShrl4fc5CaZ8r0Iq8e1UDm+bcaU6l8z8SMHKIx5XqqLy2gYuFpiI+Vt8LrO
         VE2ycuveJEK7bu6K8aIJMQ9tPcHyRwT+7rZIJCBY9DO4n11gBcZkXf60oMvFJjNBsUj3
         h8SA==
X-Gm-Message-State: ABuFfoh1wZPi42etc+RSoX0QCB8saW5LZU+aV/IXb1ZF/7IDc/5MbIvt
        Yq83NM5h5UcL0O4PyMz3BfElTAWgi9rCQw==
X-Google-Smtp-Source: ACcGV60q6IEot5bodaCTy4XYxtu9aTEC4Oxt4qYReV83PZX+lj5vUeoiDI4lkfKYFun6XuHnUtVV6w==
X-Received: by 2002:adf:db8e:: with SMTP id u14-v6mr11684165wri.217.1538498484331;
        Tue, 02 Oct 2018 09:41:24 -0700 (PDT)
Received: from pathfinder (host-78-148-28-244.as13285.net. [78.148.28.244])
        by smtp.gmail.com with ESMTPSA id e127-v6sm10200217wmg.45.2018.10.02.09.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 09:41:23 -0700 (PDT)
Date:   Tue, 2 Oct 2018 17:41:23 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181002164123.GA17538@pathfinder>
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

