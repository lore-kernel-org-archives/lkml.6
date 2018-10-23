Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C84EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4196F20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="bunJ2uXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4196F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeJXEoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:44:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46365 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeJXEoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:44:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id i4-v6so3075506wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=95Fd5rI3XvksS6xocCMzSCrV7TdI040H8LYjyP/+fwo=;
        b=bunJ2uXkxmQaxPLh50ANlx5pUrnZXgnh6cXibToudhOLcIh9Io7LjOqY451eRPntaj
         C+qrp0bjdhc2hBfJ3ZAxCBZtjxBIKFu3zlY4/CNSqczjPCD7GdYr4nF5zsuHtDBU/F+l
         +DwGVQJ+nFJV6VVTs5miyebzOKg4z9UABmbHngilb0GIwTMueoTuW61EN083Q/3Ac0+s
         TtpR8G5kJaI6FIC+MSrgsVY+TWGVOtYPzpXp8RN4g63R1Qwj5vAe8j6VhkU7LEFCsSEK
         EpDUzLkFZ6cHSfrJzpGFmNeUhwSXUZX1hXcylFID358Xp2RKQS0feB8TEAhWzqBRFF37
         QvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=95Fd5rI3XvksS6xocCMzSCrV7TdI040H8LYjyP/+fwo=;
        b=pnTEIpDCx/yxzoZOJPiuMe2xQwgMu09OFsOR554AWpCjYSFBEz44m7jgau9TEyZXYk
         V1nLxFPnLqJzSkpFOZd+5YFIbJ8rDYTtlCbfk7TnI9vnRfRVGUnmvgVnX6aAd/bS333V
         dqvzzTNFuW2w8cczhDikWzjzfHgL69YNyONONd2qdQeirwFBEJ1+8kN8q9Ng27ktk0x7
         Xe526XxLhAzWLZDOXOq29aKTcPmjmvm1Eq5v8GDWaEdCALN6ZkYHR3UarUlp4cJFrERQ
         YnNLsRVjtMk3YOPo5j0y9vTELtrKNAwsYLeKoUTuF9uEOmoDxxivIDgryneGBU23gOxM
         YgFQ==
X-Gm-Message-State: AGRZ1gJaS/BriARsI8smkCik2HvZLekJhp8XtDADbTJ2MbOeAVC/RyFo
        /Cy3XVDCfl/I+gAR9Bp2y2OEMQ==
X-Google-Smtp-Source: AJdET5ehCc00RM9LpCWbGfPgTkkR5UrJd8Tl1zumpw4iX0pR6rgoVxBYvFiDHNNHGuwbE1gxuCdR6g==
X-Received: by 2002:a5d:4086:: with SMTP id o6-v6mr20755369wrp.133.1540325996303;
        Tue, 23 Oct 2018 13:19:56 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id a18sm1470274wrx.55.2018.10.23.13.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:19:55 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:19:55 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 02/10] ufs: use fs_umode_to_dtype() helper
Message-ID: <20181023201955.GA15694@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace switch statement with common lookup table implementation.

Original patch written by Amir Goldstein.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ufs/util.h | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1fd3011ea623..8c7759860739 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -158,34 +158,7 @@ ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
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
+	de->d_u.d_44.d_type = fs_umode_to_dtype(mode);
 }
 
 static inline u32
-- 
2.17.2

