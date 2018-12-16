Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC06520672
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEU/0wLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbeLPUE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:04:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43558 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeLPUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:04:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so10199149wrs.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 12:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BM9Lam5UY0SoRJO/RRMhuuSq2/QrCy/k3Q55uusCXmQ=;
        b=VEU/0wLIGN9q22HQX7hUPeweKIXmNVD07nJyh/2WtuZbrEEikKtA4sGyYruVb8we6E
         dIGHTHKyTQFCdYAnvWHwqepUmsRtpoTYtCZ2hZo+//NvKvE2vDD/ZbInMRNFSbhvjeoW
         QsIyJBI3OS9VrVQzEXs+SVdnUDBc9bPDwRBdCsZ+Z9Z66istJa9dRURIk9GcSMxVIYV9
         9tiW5BFSWazxNhhOJxILUG2nFJMFQLNawOk3VtNllJ8K3mR30K9amkske/3NBnG4ZL2f
         uo1k54a64G1+Hlblot2hpnXaQ4SbT+GKdbbUNTUBvxVSpMl/ShMCmBr6I2m1lvGtb++O
         Af+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BM9Lam5UY0SoRJO/RRMhuuSq2/QrCy/k3Q55uusCXmQ=;
        b=aLTvsdIU7YkMHCpHqjBSza/gWjkdLe6mG+u+CFcOPpiTlsOQklqNiAo0rXCLhmN0SI
         7RHdboayTrR67PktFOc6yuRZ39ZMw0w5ll9JCmusd30PrYEul/FAfMP0jDRX5SKZR+kC
         efc0W7ZL/y0mEW0HNhQq6Ya/akrTlNgzQaIsINEBjnf/pasJbbRNx66o9IgoAo23jjy3
         ybD+QqQrdXHliHgTUUFRdF1nqjaHLKsbj3B/rAYDyKz3yTwzxbDpQ+0jPQp9Q8ecRha8
         B1vdgFnJ9VCBKw8yUG+Q1w7T0thjaGrluuNOyuB5YvTEDKzqfylqx79Qdnj9T2n2/8jf
         wRMQ==
X-Gm-Message-State: AA+aEWaNC+AgR+JTLXiF1mNHR2pqNzWKTi9vLrW27p10+hTIT7G3cGeY
        hwcfFmENvTgWIl5s/835b4Q=
X-Google-Smtp-Source: AFSGD/U48TtSzFVEKd+jJ6sAamm1HVb5boO/4l1siuYXCUi5/PGI2+MtMlGMX8t1KiXIcXuDQ1FLbQ==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr7961071wrb.167.1544990663616;
        Sun, 16 Dec 2018 12:04:23 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id v5sm10535150wrn.71.2018.12.16.12.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 12:04:22 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v3 1/3] fat: Removed FAT_FIRST_ENT macro
Date:   Sun, 16 Dec 2018 15:03:58 -0500
Message-Id: <1544990640-11604-2-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
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

