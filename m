Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1059C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6B20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRFhLzvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD6B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeIBRfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:35:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55551 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbeIBRfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:35:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so9048851wmc.5;
        Sun, 02 Sep 2018 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNIW/GOTSFNOeCG0nYfmSyxZnU8H/fKbyMd7AKsZW/0=;
        b=SRFhLzvjVt2gEpgi+ik5UFKw/SYOqY74qeqzn064DLBE6e1ZDTxdvHeS0dg/znvve4
         nVlPcFW8MUleT/Q9iOdcTy9hswx4Ywns5EbYh26CwkM/ck7q8QL5+DHgnmpZh0c2yoXa
         VDJ9INus1X+tNNWjd46wliU7gPSw5D6xt0vlBgAz5OlZotVKKWk6YwdVm0CwuER+XKb9
         giz3/avGuc6qpi0EXoJZP2e/UCp24GWfmU7lnQ70cxPA0MJXBoS00hCGIeiHxo4nIFwf
         pSRXOgS48ZfTbumbPeJpv0tMEQcet8zn5cYs/chHzUq1rqZcuCvFh7q4mbFGPxKzknlh
         HTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNIW/GOTSFNOeCG0nYfmSyxZnU8H/fKbyMd7AKsZW/0=;
        b=UXKUmqy38tLGghLQ1aqMm21L80Sy3jEE6o1+pzXLoFZqipW4WRMw1347eQfFd8P3lB
         QVuKb+7mIFGCFwYtamDOM0rYxhJRikYMOh6UXpi28/lMwW/MWy3w3iKKclndo66qIIp8
         iQIcNVpKcbNI6P17HF8sMV85wjqh717vMufSNSVqEnGWJh2Rtq02HoXpjIHt79S+OrGo
         CIK5CGjA288O6hpjgjrbykQdKY9FLNfQmw6t1OczaqybIxAlsJgc/mXcEskZSSz2/3aT
         621aWCavMuGCfcPCd5ZVM9iZLjjuzJg6wvsUTlm0Rieoa1OoyqkVfP7e0mJTjUKwVAIL
         qApQ==
X-Gm-Message-State: APzg51B/8qwH6LhnyNhv82yBFWWWa/dYMj6LuZ4aLojof+YD22VMWVi0
        59/2ISHp01ydQnnyZMv+QU96kyij
X-Google-Smtp-Source: ANB0Vdb1DyR08xibj2qBJ0AwHy9kldTUH/HCmQTJmeUvSfgsrIkrfzDUAL2YkU/B0sJ1N8tj+gtIgw==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr2903439wmd.52.1535894394877;
        Sun, 02 Sep 2018 06:19:54 -0700 (PDT)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id p89-v6sm25354802wrc.97.2018.09.02.06.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 06:19:53 -0700 (PDT)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fat: Relax checks for sector size and media type
Date:   Sun,  2 Sep 2018 15:19:32 +0200
Message-Id: <20180902131932.11558-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Windows fastfat.sys driver accepts also media types 0x00 and 0x01 and
sector sizes 128 and 256 bytes. Linux mkfs.fat can format disk also to
larger FAT sector sizes then 4096 bytes, therefore relax also upper limit
restriction.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

---
Source code of Windows 10 Anniversary Update fastfat.sys driver is now
available on github.

Check for valid media types in fastfat.sys is there:
https://github.com/Microsoft/Windows-driver-samples/blob/96eb96dfb613e4c745db6bd1f53a92fe7e2290fc/filesys/fastfat/fsctrl.c#L2601-L2611

And check for valid sector size is there:
https://github.com/Microsoft/Windows-driver-samples/blob/96eb96dfb613e4c745db6bd1f53a92fe7e2290fc/filesys/fastfat/fsctrl.c#L2542-L2547
---
 fs/fat/inode.c           | 4 +---
 include/linux/msdos_fs.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d6b81e31..f2556f71 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1506,9 +1506,7 @@ static int fat_read_bpb(struct super_block *sb, struct fat_boot_sector *b,
 		goto out;
 	}
 
-	if (!is_power_of_2(bpb->fat_sector_size)
-	    || (bpb->fat_sector_size < 512)
-	    || (bpb->fat_sector_size > 4096)) {
+	if (!is_power_of_2(bpb->fat_sector_size)) {
 		if (!silent)
 			fat_msg(sb, KERN_ERR, "bogus logical sector size %u",
 			       (unsigned)bpb->fat_sector_size);
diff --git a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
index b7a5d4c7..e5b3f613 100644
--- a/include/linux/msdos_fs.h
+++ b/include/linux/msdos_fs.h
@@ -7,6 +7,6 @@
 /* media of boot sector */
 static inline int fat_valid_media(u8 media)
 {
-	return 0xf8 <= media || media == 0xf0;
+	return 0xf8 <= media || media == 0xf0 || media == 0x00 || media == 0x01;
 }
 #endif /* !_LINUX_MSDOS_FS_H */
-- 
2.11.0

