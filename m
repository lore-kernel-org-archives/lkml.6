Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1762C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5531A21746
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="Dr8Usv8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5531A21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeJUGV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:21:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36823 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeJUGV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:21:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so40952665wrw.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DQPfYTeJT1zRChYCDTnPeEBah2R+Ieqvgt0nAJjUPhI=;
        b=Dr8Usv8c5ZTtY7xQyN6FFUsC2wrlWdHtgj1OMHqmu5tBSfnPOQHyfd5l9SVJpUcNpX
         82iQqkdT9Q3JKMY4o5w+zU+3aYLM0POierhFBz+inyLTgZ+vqbO7qIofQlbftllkHRAR
         13EM54Q+Zm8fZ1xKL3Kb7aYt/FlsdyUBgYGifzeR0SA/fztB60PUkfbRr9l7bWMwRN5N
         KYnEpxXGnTSoI1SRth4TlmFXmnLT0hNclsI08s8AJ6G8vUtEEvercDp7BUCC0Gs+jTy2
         +7swbNyxEYisgK1wL3r+57IaKd432A2EuFGcbejTshmSNxai61nTiluZQUWYbyEuprl1
         4dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DQPfYTeJT1zRChYCDTnPeEBah2R+Ieqvgt0nAJjUPhI=;
        b=cJAOCXSDCteFZiZcTtlBfgGWTMh0ip0kG6CoAyhj7VJhiZ3jPm4lSc+zNqae36FoK9
         7tlHSfkfKdgKA5gfBPa0TsPfvoX/OkycZX6jVHlZWkNkc6vKJfi3MFwhosHe7UKnXt6I
         pFTAYb07/2tgDANiudbiw7xZRqQkbHPrIitSIughmW/DC5oq3LoBrlqiN6zV+6JiP0tb
         r2ORsKFAkt1i+KKWEmHu6sFSs8JbSA1+1GHVvNCav2qwO+i9JIL54uN6Zi0OB4AysE4j
         TdrtQYqSDXcMdbwCHh0ACIm7T4GZsWeyIrG5tCjf31PtYU3bYs6D2jYuVy62n/D+rkZs
         vGLw==
X-Gm-Message-State: ABuFfoiefDXDUux+hH0n0OFGukFoKZAJo+AemfS6X9ALcHh8y03UUUzI
        fr+ImSRyfBASKYgI9F0w7URA/Q==
X-Google-Smtp-Source: ACcGV63L25CjCNRinPw+fA78eCWzJgWXiArlzYuDxifXfiLL+A2CZijO5FWOdVlUABjOd3qDVtU2Ow==
X-Received: by 2002:adf:ae41:: with SMTP id u1-v6mr37824379wrd.43.1540073399265;
        Sat, 20 Oct 2018 15:09:59 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id 64-v6sm24915336wrr.64.2018.10.20.15.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 15:09:58 -0700 (PDT)
Date:   Sat, 20 Oct 2018 23:09:57 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     dushistov@mail.ru
Cc:     viro@zeniv.linux.org.uk, David.Laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181020220957.GA7267@pathfinder>
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
us the correct file type. It is expected that for *nix compatibility
reasons, the relation between S_IFx and DT_x will not change. For
cases where the mode is invalid, upper layer validation catches this
anyway, so this improves readability and arguably performance by
assigning (mode & S_IFMT) >> 12 directly without any jump table
or conditional logic.

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
2.17.2

