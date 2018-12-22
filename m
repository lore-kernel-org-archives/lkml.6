Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4835CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112B821A7E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SDN0wNmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbeLVRnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:43:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52551 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeLVRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:43:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so8051940wml.2;
        Sat, 22 Dec 2018 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nu56ZjjKt3W+61nxUblgFLnzLm5JPACjcouTaxTYq7c=;
        b=SDN0wNmt0pYeTBLzn6ePWkGf5J3ByhHINSubT99UiEcUsgIaASTiJyeKJxEbPK/nTe
         uDGxJ8VK3JAYjUSyAlVLZc6wRPLlJNcA3ScsBqWm+//HloLPLfQrUPEdf7IjFtQ13Lyr
         g6H7ccNzM6q2lgizd51hthzDud3UXtNC/9MQ5Xo+nGUcJwY7heu9en+b+ImHmzeKmJFh
         Cqt8qjnfZk+zp+Sxy5z88aXfsRNylESPUyxZIrDuO6NFwxm4wfENgL4OosqhVV+cRFAi
         7VqeBGU/fyEZdBVN4KiEP+mt7k0TGQm/2smexZZ/IGvt5f7SNFGqXWF2U5fxVHxolnzj
         D9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nu56ZjjKt3W+61nxUblgFLnzLm5JPACjcouTaxTYq7c=;
        b=MAMV1FYpWav3/qiavsiCWU6nXv5NT62P9TroQN23PCnaw8kL7yQDddP2Q4z2h/olmK
         x9xSXpVjuzwTKTUKxaFMvz4e3WRZpoERYaIbKLAd8c0zJjpZYJbDAn+HeGwdn1XlhAfz
         vLsgo/bPkiqNp2Pr7Gbbt6V4UCwTCtqcZpd87VAtQg3YpbU92tzB4+qjhI3r6EzoA5c3
         ADYysvYjPGPMXISPFmNKETuZSsRwQLkK9Cxglu8V90ldeYbHCJ2pbgNWbM2UzrotqZIU
         cXHF60FxhgM0ZEVCdmoGuTO2IyzOWLvnPnEjW6jAEIy0Z8+GmnVgjo/IXgKDtwLGMvb2
         4WPQ==
X-Gm-Message-State: AA+aEWaf5OzLbVX8TXLAG4aQwAbn++l1pBXmioupHc+vcXWT6KvIC3EP
        FfpyICfmmkUDrZxQuL6HyP12W4Ob
X-Google-Smtp-Source: ALg8bN6+A7dNVhJ2i9MFHtIDqfz3ExyUfq7NfjVt5XqRpU0wcR0FOOpKAUCeIWmX1ei/doAntY5dcA==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr6197640wmz.8.1545474152915;
        Sat, 22 Dec 2018 02:22:32 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD739590074910E90C26DA08A.dip0.t-ipconnect.de. [2003:dc:d739:5900:7491:e90:c26d:a08a])
        by smtp.googlemail.com with ESMTPSA id v6sm11883735wro.57.2018.12.22.02.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 02:22:31 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com,
        jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/1] f2fs: fix validation of the block count in sanity_check_raw_super
Date:   Sat, 22 Dec 2018 11:22:26 +0100
Message-Id: <20181222102226.10050-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181222102226.10050-1-martin.blumenstingl@googlemail.com>
References: <20181222102226.10050-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat "block_count" from struct f2fs_super_block as 64-bit little endian
value in sanity_check_raw_super() because struct f2fs_super_block
declares "block_count" as "__le64".

This fixes a bug where the superblock validation fails on big endian
devices with the following error:
  F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
  F2FS-fs (sda1): Can't find valid F2FS filesystem in 1th superblock
  F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
  F2FS-fs (sda1): Can't find valid F2FS filesystem in 2th superblock
As result of this the partition cannot be mounted.

With this patch applied the superblock validation works fine and the
partition can be mounted again:
  F2FS-fs (sda1): Mounted with checkpoint version = 7c84

My little endian x86-64 hardware was able to mount the partition without
this fix.
To confirm that mounting f2fs filesystems works on big endian machines
again I tested this on a 32-bit MIPS big endian (lantiq) device.

Fixes: 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid potential overflows")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2cc21b8..d3911d3f948b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2496,10 +2496,10 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
-	if (segment_count > (le32_to_cpu(raw_super->block_count) >> 9)) {
+	if (segment_count > (le64_to_cpu(raw_super->block_count) >> 9)) {
 		f2fs_msg(sb, KERN_INFO,
-			"Wrong segment_count / block_count (%u > %u)",
-			segment_count, le32_to_cpu(raw_super->block_count));
+			"Wrong segment_count / block_count (%u > %llu)",
+			segment_count, le64_to_cpu(raw_super->block_count));
 		return 1;
 	}
 
-- 
2.20.1

