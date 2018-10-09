Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D99DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B66214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="LAaGAgCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B66214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJIUdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:33:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44798 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIUdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:33:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so1781385wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lx0cw+9rF/07CO1RshCjn2zaAnRoqJpQJvSZ7+l+DRw=;
        b=LAaGAgCi0NcoEr3wwat/e6ZyDuU14AkDDOfnN+3QBPF028QxAebXHkBCYbFoZNe8L1
         fsXjgN/2B33XZQ+HU8Pv8Qj5HpqEZDFYUDUB+FQNwF2401yEEmWoew8rviCkJotmGKZV
         Y/JUuRYUQrFCtkGsZg+PCKSUgaNBxpAGWBJwAzhEb/czs0/IWbQHmuhHUOG34pMkXP4L
         py71DYajKZOEncWBF4vRG2dOsyfMoPtuFpLWDvxNUHRVfg40PCJYLEoI5KRaWW3UBeBQ
         fCZXv5wGgZG0ChtgDCPodiNSpBy1nqF0B/QYinnagBkxddSGH3sz+GEO4zWyOy1ohGw3
         /XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lx0cw+9rF/07CO1RshCjn2zaAnRoqJpQJvSZ7+l+DRw=;
        b=I7vmKpIt1DI2Xoj2u8yfFZURuSm6Yh+OzbtXe6/1fq4obX5G4KtICuLVbvR+xLCALK
         /0njfoh9Loat+NPUGlERJKkTBYKRd8rkBBU0JpootxUoeJI4AFfSk4HCV+e8KDtQWtVA
         EzzPJrlXfGhR5dmp4XAUP8DP/8tnTojdNbSVq8Lh0auUZLS/+H/V+wg8MWflWmZ7sQEm
         FwE0y94IHIjNhVi5AWQKzxeBvNts6HiNTNSdWwbF33vOEVZiUWLmYDWcALGntgO9TskY
         MhfQ66Pou6q1sHh7mYwren/r0RhO4GCPq+kQCTwqs5pxfjYYZvy3mf9w5mw8za79pPpQ
         Ap0g==
X-Gm-Message-State: ABuFfohcETS7hB5t7/SN6s6ODO/D0HJSSQpC84QgPCxTL0WOcsWPM2ah
        wBueIBY9/zZ6Kqfm0mIXLhJQPrGj038=
X-Google-Smtp-Source: ACcGV62hRTHg5BLXobzObx33vPtNsulKdPStQUa17M/n8T4lZ4uFYB9xXlzPMbaUmdjHacSxrbbdhw==
X-Received: by 2002:a5d:4d4b:: with SMTP id a11-v6mr20844411wru.40.1539090983211;
        Tue, 09 Oct 2018 06:16:23 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id g76-v6sm13767986wmd.25.2018.10.09.06.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 06:16:22 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:16:21 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181009131621.GA7113@pathfinder>
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

