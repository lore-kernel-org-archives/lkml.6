Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82ADC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A7D2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkRZaHyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A7D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeKYIvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 03:51:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54564 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKYIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 03:51:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so14750834wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 14:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=0Xi//oXh+pxyZDIhcSwHFoXu6Kl41Z2PaGpv0+WJec4=;
        b=KkRZaHyIeRD1mFHBEcEdWF8nBL1vTG/Y27MLny+ymeAnvBP16QG8GBk3TrzJijY8bN
         A5mn9Y6PxtAvIZ91KiugP8CHo1FWWnbbw2fzF4Spc7+rq2PRXFXZZP0aJG41fWdyqHac
         sNiXwwhAa51IomE+BseuA8Ej89t0Cg2wjv4lqyXqJ7cvx74I0HCknVNjiqyKSdaogUTd
         egAX5bc+mnttZi29Nx5QqEzE19QoNaBndaWFM13hmm5p2hFISEcS3r5vrrN3uGSkHDXv
         /0/LAe6deGJWcWTV6DlT0KwDbid6PnZMqE5UfaXfHjmozkFRFMEcWZvdfuymcczO/sq4
         e8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=0Xi//oXh+pxyZDIhcSwHFoXu6Kl41Z2PaGpv0+WJec4=;
        b=EQRbccrQYLFF2/9cV7okW6wznoUJp6voEQJwLKlIR7j2Jus95frM0QbN6Lw4OFXjpA
         tTymp79L8AuVWUD1Lwx53Cv7mXlLnGT2OmYUtuiw7CvBPHKw4vWr+RINjdEzQYGJZUZK
         jxLQ05U6Iws/T+gBDoIo7AqeM4HWL7byzCR58OhfbB+RYl+reyuIwuhhu+7/WuA3UCPV
         Q8cdR5QS9Ixt9gIzXOU3pbazbkjcaa/m04XmJI/rPXJc6G/A98SukjTcjVBMVdJA+Wc3
         OgH0Fsr7FzBkOraXcnTR5RBHMHD/6pUPsEzhWl990Yy9g0eD6h8MWL5n+z/FTJP0dSDo
         aVpQ==
X-Gm-Message-State: AA+aEWZKUwwwmyk6/gIC2jqiv+646YpKyTjK4ThT1kIXToSXT2kFKgnb
        sjVm9Xf2eVGDmSpLQtAOVp92xkCchQk=
X-Google-Smtp-Source: AJdET5cNNhbaEiABdRCB6dNSj8VWnsKlzUALyCWY8uvFJI3hRoZxpyHezDWumP0TxGnFWg7zpAl1MA==
X-Received: by 2002:a1c:8448:: with SMTP id g69-v6mr18615570wmd.63.1543096899493;
        Sat, 24 Nov 2018 14:01:39 -0800 (PST)
Received: from osboxes.localdomain (bzq-79-178-252-231.red.bezeqint.net. [79.178.252.231])
        by smtp.googlemail.com with ESMTPSA id e17sm13578999wrs.79.2018.11.24.14.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 14:01:38 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     axboe@kernel.dk, sergey.senozhatsky@gmail.com, jthumshirn@suse.de,
        bvanassche@acm.org, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, carmeli.tamir@gmail.com
Subject: [PATCH] fat: Replaced 11 magic to MSDOS_NAME for volume label
Date:   Sat, 24 Nov 2018 17:01:19 -0500
Message-Id: <1543096879-82837-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FAT file system volume label file stored in the root directory should
match the volume label field in the FAT boot sector. As consequence, the
max length of these fields ought to be the same. This patch replaces the
magic '11' usef in the struct fat_boot_sector with MSDOS_NAME,
which is used in struct msdos_dir_entry.

Please check the following references:
1. Microsoft FAT specification 2005 
(http://read.pudn.com/downloads77/ebook/294884/FAT32%20Spec%20%28SDA%20Contribution%29.pdf).
Search for 'volume label'.
2. Microsoft Extensible Firmware Initiative, FAT32 File System Specification
(https://staff.washington.edu/dittrich/misc/fatgen103.pdf). 
Search for 'volume label'.
3. User space code that creates FAT filesystem 
sometimes uses MSDOS_NAME for the label, sometimes not.
Search for 'if (memcmp(label, NO_NAME, MSDOS_NAME))'. 
I consider to make the same patch there as well.
https://github.com/dosfstools/dosfstools/blob/master/src/mkfs.fat.c


Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 include/uapi/linux/msdos_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
index fde7537..1216e6c 100644
--- a/include/uapi/linux/msdos_fs.h
+++ b/include/uapi/linux/msdos_fs.h
@@ -135,7 +135,7 @@ struct fat_boot_sector {
 						   for mount state. */
 			__u8	signature;  /* extended boot signature */
 			__u8	vol_id[4];	/* volume ID */
-			__u8	vol_label[11];	/* volume label */
+			__u8	vol_label[MSDOS_NAME];	/* volume label */
 			__u8	fs_type[8];		/* file system type */
 			/* other fields are not added here */
 		} fat16;
@@ -158,7 +158,7 @@ struct fat_boot_sector {
 						   for mount state. */
 			__u8	signature;  /* extended boot signature */
 			__u8	vol_id[4];	/* volume ID */
-			__u8	vol_label[11];	/* volume label */
+			__u8	vol_label[MSDOS_NAME];	/* volume label */
 			__u8	fs_type[8];		/* file system type */
 			/* other fields are not added here */
 		} fat32;
-- 
2.7.4

