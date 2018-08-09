Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC45C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB17921F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKEU20A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB17921F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeHIUcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41198 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeHIUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:12 -0400
Received: by mail-pl0-f65.google.com with SMTP id w19-v6so2868932ply.8;
        Thu, 09 Aug 2018 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlGM7QyTXZZAbwLjW+5tUEcWAtOHF7nYbnZjSh1iwcA=;
        b=MKEU20A+wvmTbdsM+sl5l9zrk8GHdqI8G1ZAFWNoar3kYscss6EfWAm/g86R5suhSm
         +5RXmIbkRWAOaKpz6DgfWqUzY3tXQ6ZGQ6gf8kbIuldrqWMg+Ltf9Xcm7mBRW5SB82wS
         MBJqQRISrp8Qm9gLbuIBxnO1/85cYHMkf/mhiVoNw4sffnnXl5n/kA7Q5fowAqrEeopR
         +NikCHmJbAOZwA3EX0Dbj2glCUk3kj3nxeTMR6b/3diNSk523/q6PzLAiLulqG/6p1NZ
         wW6Z72sI6vqIr0gVHZl7wjde4D/H9+pkzrzVUx4cU45LiD5l9P4MbNFqt7pyMsgYQgUT
         yOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FlGM7QyTXZZAbwLjW+5tUEcWAtOHF7nYbnZjSh1iwcA=;
        b=oCuArz0tUE2iWZ6W5e4xYHZCh6fgXu2Ve+cUSOJtgAe3umr9a/qCBpyC74sktz22D5
         Xbf6hl3s4MDtQhLzETLmE8KYbGXElguLo5nmq2Vus5O8+SAIHY7s8wnOzFdVxCu4W0eT
         jJrqF1ToMw4m2AciiN1JFjemfyFccQv5UGDv2/dRLmep4kYhUAf8YMW4DCy6P1AsrURu
         JCNhigcIXQ9VCtFSerCg0X2fM+NwdVl045K+BfQuNyM05LBIONH1eprQVmI5YYU0WeOM
         mwaYtCCM2HrhJTwvha5uoW/f4lo5YTu4mDAvOj1hEVfRuxDb60K2TtqMA/pDluuSufIZ
         G62A==
X-Gm-Message-State: AOUpUlHPNYTljs/i2Z4PXzSbk3MxWGBpfqSSd4PEGKhdTLMQiRvr3ELY
        OG1w8x4PoETD1Wn3zI18VOw=
X-Google-Smtp-Source: AA+uWPyavTl/w9ftTLqukREpWaa8XaQ9ouzTXDBrAZuVVBq3my7zDw3BAoNfl9+dLhV2AORquO9R3A==
X-Received: by 2002:a17:902:28e4:: with SMTP id f91-v6mr3021796plb.146.1533837973116;
        Thu, 09 Aug 2018 11:06:13 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id i26-v6sm9377561pfo.107.2018.08.09.11.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:12 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 10/17] btrfs: split btrfs_map_bio()
Date:   Fri, 10 Aug 2018 03:04:43 +0900
Message-Id: <20180809180450.5091-11-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch splits btrfs_map_bio() into two functions so that the following
patches can make use of the latter part of this function. The first part of
btrfs_map_bio() maps bios to a btrfs_bio and the second part submits the
mapped bios in btrfs_bio to the actual devices.

By splitting the function, we can now reuse the latter part to send
buffered btrfs_bio.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/volumes.c | 53 +++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ada13120c2cd..08d13da2553f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6435,17 +6435,44 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 	}
 }
 
+static void __btrfs_map_bio(struct btrfs_fs_info *fs_info, u64 logical,
+			    struct btrfs_bio *bbio, int async_submit)
+{
+	struct btrfs_device *dev;
+	int dev_nr;
+	int total_devs;
+	struct bio *first_bio = bbio->orig_bio;
+	struct bio *bio = first_bio;
+
+	total_devs = bbio->num_stripes;
+	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
+		dev = bbio->stripes[dev_nr].dev;
+		if (!dev || !dev->bdev ||
+		    (bio_op(first_bio) == REQ_OP_WRITE &&
+		     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
+			bbio_error(bbio, first_bio, logical);
+			continue;
+		}
+
+		if (dev_nr < total_devs - 1)
+			bio = btrfs_bio_clone(first_bio);
+		else
+			bio = first_bio;
+
+		submit_stripe_bio(bbio, bio, bbio->stripes[dev_nr].physical,
+				  dev_nr, async_submit);
+	}
+	btrfs_bio_counter_dec(fs_info);
+}
+
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num, int async_submit)
 {
-	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
 	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
 	int ret;
-	int dev_nr;
-	int total_devs;
 	struct btrfs_bio *bbio = NULL;
 
 	length = bio->bi_iter.bi_size;
@@ -6459,7 +6486,6 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		return errno_to_blk_status(ret);
 	}
 
-	total_devs = bbio->num_stripes;
 	bbio->orig_bio = first_bio;
 	bbio->private = first_bio->bi_private;
 	bbio->end_io = first_bio->bi_end_io;
@@ -6489,24 +6515,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		BUG();
 	}
 
-	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
-		dev = bbio->stripes[dev_nr].dev;
-		if (!dev || !dev->bdev ||
-		    (bio_op(first_bio) == REQ_OP_WRITE &&
-		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-			bbio_error(bbio, first_bio, logical);
-			continue;
-		}
-
-		if (dev_nr < total_devs - 1)
-			bio = btrfs_bio_clone(first_bio);
-		else
-			bio = first_bio;
-
-		submit_stripe_bio(bbio, bio, bbio->stripes[dev_nr].physical,
-				  dev_nr, async_submit);
-	}
-	btrfs_bio_counter_dec(fs_info);
+	__btrfs_map_bio(fs_info, logical, bbio, async_submit);
 	return BLK_STS_OK;
 }
 
-- 
2.18.0

