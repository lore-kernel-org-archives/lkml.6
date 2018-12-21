Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B19C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA021927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c4v6K88q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391734AbeLUT2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:28:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54515 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391590AbeLUT2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:28:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so6287060wmh.4;
        Fri, 21 Dec 2018 11:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6E3nHK/WCb1i4GAoCWYV7at12bTQmlTSdWjogLaldw=;
        b=c4v6K88qbMMdrn8XIDH+2ovx6mTMqJhSNl4ZBJUDTnYUHsV6O1CLRrrO2+/mkk+xtm
         QC7DkYLcTDoWbnv46Oig2JdIaSw1gXX3FMJ8PcdkoeDoBsVDAhdizIVeWfHLRVDpD5Q2
         UwITj8qIOhRVG3Txivi0KknoZIHhV6evU2DLxra1i48CZFNq57l/szFraT1zRaTF4T6l
         EReBMYdnOtDbGB2zG8sriYG93VYZhaEZMGQzgnqND4BO0KUBAZczfEqSB+1I2g9xy878
         9eDz36vV0HnCJ2pAnnmNQ45eGtJStFX2PZoqgjEzzuztD4jRJ8HlxrBP/GKojA1HcE+O
         pxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6E3nHK/WCb1i4GAoCWYV7at12bTQmlTSdWjogLaldw=;
        b=VJUHIhJy17F+fDyCmjp0in2c5moFrwpzrKaN8xqdaiQe2Eg/yDw/wWQTxwlUECacks
         mhtt90mrPEE8pptVLPh4OhE03iJVge8Gu86f5VeWs6Ai65oscnqWVCFuaycsRn5x1maA
         6pq6lLTHqkFYEMgRT22+xMgAeFfKGQXP+IO4gIiP3GI4Ol8H/cQZsyGqVHmAUWVKd75G
         CQv07XPNf5f2gW45yfiPQJKIolZbTwomYNUr3xcYJU/zzqVw/8B7vvEGLpqfMCh2j6J0
         GK/Rwl+FMO212xnY88TeYUh7f0bZ8wbe+sUgdQL/avqm546igILhMra6rm3Aa4UgSF82
         GzSA==
X-Gm-Message-State: AA+aEWZv1S3xltAM+yxXixOhy6MfcwlX8lwrzthz6DTMSV8KWeWJf19B
        hjQ7ggNsWSHrmQ7TQ8NEBdA=
X-Google-Smtp-Source: AFSGD/UZzBu87gt1WAj+uRwmUBb9BHUEhx+CL6HSEsM7e7B+y06TFJVWfL6AjLNXI/IEZvcX3Y4iFA==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr3953301wmi.24.1545420521790;
        Fri, 21 Dec 2018 11:28:41 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD736340074910E90C26DA08A.dip0.t-ipconnect.de. [2003:dc:d736:3400:7491:e90:c26d:a08a])
        by smtp.googlemail.com with ESMTPSA id 1sm4436246wmx.48.2018.12.21.11.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:28:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com,
        jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] f2fs: fix validation of the block count in sanity_check_raw_super
Date:   Fri, 21 Dec 2018 20:28:20 +0100
Message-Id: <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
References: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
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
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2cc21b8..3a65d5af122a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2496,10 +2496,10 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
-	if (segment_count > (le32_to_cpu(raw_super->block_count) >> 9)) {
+	if (segment_count > (le64_to_cpu(raw_super->block_count) >> 9)) {
 		f2fs_msg(sb, KERN_INFO,
 			"Wrong segment_count / block_count (%u > %u)",
-			segment_count, le32_to_cpu(raw_super->block_count));
+			segment_count, le64_to_cpu(raw_super->block_count));
 		return 1;
 	}
 
-- 
2.20.1

