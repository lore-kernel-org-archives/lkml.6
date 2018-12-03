Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C78EC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAE6208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX7RE7fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAE6208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeLCClF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:41:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37840 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeLCClF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:41:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so5579874pfb.4;
        Sun, 02 Dec 2018 18:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZvLIAlDfVFll4RNhvGLQor7E1TZwgmEZVXwo3GSiUM=;
        b=pX7RE7fkxAuejyhlHM6MJjV0u2xpHDkwMEHcAOjTUUh43VLMsqhJpc5TYbxKiF07/z
         GXvHcUZTRp/tBoR7FH0rppPsxjInsHOv+5yBa78P2b1M9e2yu2WLcv8Sj07iiDVi0pxA
         76Au8di9dYr42RvwRA8AtXH9LxQjzAGyWLXUFpDbaxdsAzls44cp+0LQljM+Ld9PQnoA
         iaig9bfx9Jh5p0+E+bOjnPSgoX39hUMZpDNhFsHRoPmboqgIYdUNnE4/Q0bH0UD1xpJU
         vIdCZQY4I8L0kSpWOdN0waLYy1LqNyByMOebl6mA3AgWzXLq77rhzXIw0k+Wcj5W03lE
         rldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PZvLIAlDfVFll4RNhvGLQor7E1TZwgmEZVXwo3GSiUM=;
        b=hFA2fWQGnOpGafZIdQK8XZIfZlSk9n3Zm2R5p6UP73Oylpd/wzmbMX36UpdpTMV5nm
         i1nQtnyWVOuUDgUNCKs/9BMpeFdaCP4vuF5n8VHSDCK/vnANtE3ANrsoh3enMt3mnFMm
         is0fPbUD+9qwU1MGnwHSn4nlLllY+naM3gG9aydaARiBqb1Fk3LK+/vmptEdjdWD/h8R
         RBPSXmepUop58ODBIcLRVd4rUFUi9IyN1bRAbCOAnsxsAWWjoDvLbsaaU0srwWKrnzyq
         jF69pHdaC4aqrbnKkDZFnd2UMKOqHnb0XGcIbFsjKtObGhBSHoKge8m6eoebmoPaowuT
         tj0g==
X-Gm-Message-State: AA+aEWYjVCbydpM4aNvOegO8zF7+6tMW9s6G78Jtwi4iy0V1iRdkHe9D
        l8Ka3eDMoSru6T11uktHtLQ=
X-Google-Smtp-Source: AFSGD/VvcpA6dHMQE14lKsqb1PFqwWRUXXj8rZYvB47+cqWHGtC1Isf8Xmba3iRVsU/238OZ/EgB7g==
X-Received: by 2002:a63:e615:: with SMTP id g21mr12096980pgh.290.1543804860767;
        Sun, 02 Dec 2018 18:41:00 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z62sm18805864pfi.4.2018.12.02.18.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 18:40:59 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v4 2/7] zram: fix double free backing device
Date:   Mon,  3 Dec 2018 11:40:40 +0900
Message-Id: <20181203024045.153534-3-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181203024045.153534-1-minchan@kernel.org>
References: <20181203024045.153534-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If blkdev_get fails, we shouldn't do blkdev_put. Otherwise,
kernel emits below log. This patch fixes it.

[   31.073006] WARNING: CPU: 0 PID: 1893 at fs/block_dev.c:1828 blkdev_put+0x105/0x120
[   31.075104] Modules linked in:
[   31.075898] CPU: 0 PID: 1893 Comm: swapoff Not tainted 4.19.0+ #453
[   31.077484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   31.079589] RIP: 0010:blkdev_put+0x105/0x120
[   31.080606] Code: 48 c7 80 a0 00 00 00 00 00 00 00 48 c7 c7 40 e7 40 96 e8 6e 47 73 00 48 8b bb e0 00 00 00 e9 2c ff ff ff 0f 0b e9 75 ff ff ff <0f> 0b e9 5a ff ff ff 48 c7 80 a0 00 00 00 00 00 00 00 eb 87 0f 1f
[   31.085080] RSP: 0018:ffffb409005c7ed0 EFLAGS: 00010297
[   31.086383] RAX: ffff9779fe5a8040 RBX: ffff9779fbc17300 RCX: 00000000b9fc37a4
[   31.088105] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff9640e740
[   31.089850] RBP: ffff9779fbc17318 R08: ffffffff95499a89 R09: 0000000000000004
[   31.091201] R10: ffffb409005c7e50 R11: 7a9ef6088ff4d4a1 R12: 0000000000000083
[   31.092276] R13: ffff9779fe607b98 R14: 0000000000000000 R15: ffff9779fe607a38
[   31.093355] FS:  00007fc118d9b840(0000) GS:ffff9779fc600000(0000) knlGS:0000000000000000
[   31.094582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.095541] CR2: 00007fc11894b8dc CR3: 00000000339f6001 CR4: 0000000000160ef0
[   31.096781] Call Trace:
[   31.097212]  __x64_sys_swapoff+0x46d/0x490
[   31.097914]  do_syscall_64+0x5a/0x190
[   31.098550]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   31.099402] RIP: 0033:0x7fc11843ec27
[   31.100013] Code: 73 01 c3 48 8b 0d 71 62 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 62 2c 00 f7 d8 64 89 01 48
[   31.103149] RSP: 002b:00007ffdf69be648 EFLAGS: 00000206 ORIG_RAX: 00000000000000a8
[   31.104425] RAX: ffffffffffffffda RBX: 00000000011d98c0 RCX: 00007fc11843ec27
[   31.105627] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000011d98c0
[   31.106847] RBP: 0000000000000001 R08: 00007ffdf69be690 R09: 0000000000000001
[   31.108038] R10: 00000000000002b1 R11: 0000000000000206 R12: 0000000000000001
[   31.109231] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   31.110433] irq event stamp: 4466
[   31.111001] hardirqs last  enabled at (4465): [<ffffffff953ebd43>] __free_pages_ok+0x1e3/0x490
[   31.112437] hardirqs last disabled at (4466): [<ffffffff95201b7a>] trace_hardirqs_off_thunk+0x1a/0x1c
[   31.113973] softirqs last  enabled at (3420): [<ffffffff95e00333>] __do_softirq+0x333/0x446
[   31.115364] softirqs last disabled at (3407): [<ffffffff9527aee1>] irq_exit+0xd1/0xe0

Cc: stable@vger.kernel.org # 4.14+
Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 21a7046958a3..d1459cc1159f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -387,8 +387,10 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	bdev = bdgrab(I_BDEV(inode));
 	err = blkdev_get(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram);
-	if (err < 0)
+	if (err < 0) {
+		bdev = NULL;
 		goto out;
+	}
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
-- 
2.20.0.rc1.387.gf8505762e3-goog

