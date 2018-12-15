Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E31C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CDD2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLfOj3HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeLONFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:05:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32907 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLONFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:05:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so1149276wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 05:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BM9Lam5UY0SoRJO/RRMhuuSq2/QrCy/k3Q55uusCXmQ=;
        b=iLfOj3HBgdX3CDXyQR7Lu5LbQThUvk3OQavDSqWfeCx5GB3oMtTxFqA+pi/FkciZB0
         TzL01EsZjx3hB5YSVPHAdZ1UdWkJr8QUfbNfcVV0SSu7JI2UKJcyWxq81gApcQK5YPvG
         mZNxAsMJzn9ikfGSmrg6yzxMmdcRy+Dgk9jlJaXEDJn/0kgri+Q4X4L8UT0zPdSsYAe8
         LjppIJRzO/+3yUNvSr1n9uDgxkIw2sOdzkCRKbIi6689YAjZyEgtweHfjh8EgTzRMtwy
         FMaoVfyDHHxuiaBKS/HTe0uQ9MrWBWwbpuCW0anyTiVNdgp565fXjlKH695WGiY+RQWY
         updQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BM9Lam5UY0SoRJO/RRMhuuSq2/QrCy/k3Q55uusCXmQ=;
        b=G+ErcVnVW5OrLbFyhm3XRVQe1GQ367lc3648VtLE3QHxojHefFlRmf/A9Bw86oVPxn
         nGxMABi1tvD2TVZHTCOW1Ka9KGOKseN0gRqENZkawNOdurYFUKBzmS1oxl7f7rrwknRL
         p9ODNHwPo0FE+fTloNnV2HRPmBeB8Ajx16JVldxRI4Z4ozV8xm3ivhWJ9EP/ccX80HnV
         9hqCl5r/Uy4QypwYvhQSWK74P1uyK9zPhUEdjw+PTsJNPjRAxmCszdEyd8fDvnUJ5trO
         6lsqplRBJCj8QI5L0a5mVrzrOF0dREqRM7ErFnYqR7NNoNV6pPVzeacjjf2L6WcInpcG
         12UA==
X-Gm-Message-State: AA+aEWZYzhrzT8F+OMBc/aJXpdi/hpR2m2yZ21SU3p8NU40HrP4GQh3m
        waSg4j/5Aoq/asBCEFSlPec=
X-Google-Smtp-Source: AFSGD/UXHjdn7p7Ew4IcL02OLp5lMcns5VT8hqZUXgKtkiKOTtJeARM6/O5rGnFTQywm4X5TKdD+8Q==
X-Received: by 2002:a1c:8cd0:: with SMTP id o199mr5879787wmd.56.1544879103980;
        Sat, 15 Dec 2018 05:05:03 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id s1sm9589159wro.9.2018.12.15.05.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Dec 2018 05:05:03 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v2 1/3] fat: Removed FAT_FIRST_ENT macro
Date:   Sat, 15 Dec 2018 08:04:30 -0500
Message-Id: <1544879072-4251-2-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment edited in this patch was the only reference to the 
FAT_FIRST_ENT macro, which is not used anymore. Moreover, the
commented line of code does not compile with the current code.

Since the FAT_FIRST_ENT macro checks the FAT variant in a way that the
patch series changes, I removed it, and instead wrote a clear explanation
of what was checked.

I verified that the changed comment is correct according to Microsoft FAT
spec, search for "BPB_Media" in the following references:

1. Microsoft FAT specification 2005
(http://read.pudn.com/downloads77/ebook/294884/FAT32%20Spec%20%28SDA%20Contribution%29.pdf).
Search for 'volume label'.
2. Microsoft Extensible Firmware Initiative, FAT32 File System Specification
(https://staff.washington.edu/dittrich/misc/fatgen103.pdf).
Search for 'volume label'.


Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/fat/inode.c                | 12 ++++++++----
 include/uapi/linux/msdos_fs.h |  3 ---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index e981e9d..708de6d 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1804,11 +1804,15 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	fat_ent_access_init(sb);
 
 	/*
-	 * The low byte of FAT's first entry must have same value with
-	 * media-field.  But in real world, too many devices is
-	 * writing wrong value.  So, removed that validity check.
+	 * The low byte of the first FAT entry must have the same value as
+	 * the media field of the boot sector. But in real world, too many
+	 * devices are writing wrong values. So, removed that validity check.
 	 *
-	 * if (FAT_FIRST_ENT(sb, media) != first)
+	 * The removed check compared the first FAT entry to a value dependent
+	 * on the media field like this:
+	 * == (0x0F00 | media), for FAT12
+	 * == (0XFF00 | media), for FAT16
+	 * == (0x0FFFFF | media), for FAT32
 	 */
 
 	error = -EINVAL;
diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
index 1216e6c..833c707 100644
--- a/include/uapi/linux/msdos_fs.h
+++ b/include/uapi/linux/msdos_fs.h
@@ -58,9 +58,6 @@
 #define MSDOS_DOT	".          "	/* ".", padded to MSDOS_NAME chars */
 #define MSDOS_DOTDOT	"..         "	/* "..", padded to MSDOS_NAME chars */
 
-#define FAT_FIRST_ENT(s, x)	((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
-	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
-
 /* start of data cluster's entry (number of reserved clusters) */
 #define FAT_START_ENT	2
 
-- 
2.7.4

