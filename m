Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308BFC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D449E20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGygZNE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D449E20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeIKXm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:29 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33176 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:27 -0400
Received: by mail-yb1-f193.google.com with SMTP id m123-v6so9741880ybm.0;
        Tue, 11 Sep 2018 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FkDgmX6YNgFCNFUn3Et8v5b6B07m4GOk66oKL1F2CRg=;
        b=mGygZNE6R8vykkRJpASf0GghNDi/HMMohnHWuxa5UMirclwqDK6yWQFiht/cECSYxa
         Q5RGNy0B6E4DoS01BWEZoT7RVb3FVqaq+u4qS6MiWnOt2/utnbtTYotziTsNJAlx4f2/
         4yBS8HuTEAuTkdUzi7ZW1aTgR7Q/QYxq0eDbUdSqd6PMN/l3fliYR534AyjF1iSBbRPp
         l9A6TJxM0c4Vym3fWG9vFcOTce5dI9EKiGi0qgeX6L+UZIUc+nEUgwPNiFbgx0r2ZAJF
         LmlvIM92ZsElKIxZFBirxLyvzJ9LPu/z6u8YfEGm6XSPd++52sv1rxvAJKru7bCRx0jz
         jflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FkDgmX6YNgFCNFUn3Et8v5b6B07m4GOk66oKL1F2CRg=;
        b=MM1zXbPV+mPXDA/w64KJE3iHPT3k0n3JDmKkGQHn+FB2lyOWI28LXxY4CEcr6NyPmj
         +5QvnFj/9vDSAtfRBxZuEQ1nwb9YBszE6Z8T8YPwrMsA1s29NkX9BrpwqwYOWGT8IqO5
         Sc1RtTC4yvehfzD1NZcsInwr9zM0s02Q5ij4cdfRSk01Ipgx9BU/SWDl476qeJy/1O6n
         BMGGzY08Xhzxi+EujniSTKDRaJVn5gwVIqc+xWm8BYWNaFTqKUadY7LK6HLg+DSX4CtD
         EPylIpKvMTQZhSdD1znmvHTHUMQKHRG8BVXA+ldzAAsMve7FyAAHkk4mQvg6v7NdQHx0
         IWhw==
X-Gm-Message-State: APzg51DN7zma1UwJYU5hw/TZw2d2D39scKb3YQMqRE7GSQZajGyw/Dgs
        z2gmaviM+kAqvP0y4ycWiPThE7igpTY=
X-Google-Smtp-Source: ANB0VdZFMjBueQsW+LhHFGB094Me3z5a1gtZiu+BfO4jswBUfOn8HHV7/uXsQHFIUkaJXJJ1DHNtBw==
X-Received: by 2002:a25:220a:: with SMTP id i10-v6mr12983355ybi.489.1536691311120;
        Tue, 11 Sep 2018 11:41:51 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:50 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 07/12] blkcg: associate writeback bios with a blkg
Date:   Tue, 11 Sep 2018 14:41:32 -0400
Message-Id: <20180911184137.35897-8-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

One of the goals of this series is to remove a separate reference to
the css of the bio. This can and should be accessed via bio_blkcg. In
this patch, the wbc_init_bio call is changed such that it must be called
after a queue has been associated with the bio.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 +++++---
 fs/buffer.c                             | 10 +++++-----
 fs/ext4/page-io.c                       |  2 +-
 include/linux/writeback.h               |  5 +++--
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 184193bcb262..caf36105a1c7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1857,8 +1857,10 @@ following two functions.
 
   wbc_init_bio(@wbc, @bio)
 	Should be called for each bio carrying writeback data and
-	associates the bio with the inode's owner cgroup.  Can be
-	called anytime between bio allocation and submission.
+	associates the bio with the inode's owner cgroup and the
+	corresponding request queue.  This must be called after
+	a queue (device) has been associated with the bio and
+	before submission.
 
   wbc_account_io(@wbc, @page, @bytes)
 	Should be called for each data segment being written out.
@@ -1877,7 +1879,7 @@ the configuration, the bio may be executed at a lower priority and if
 the writeback session is holding shared resources, e.g. a journal
 entry, may lead to priority inversion.  There is no one easy solution
 for the problem.  Filesystems can try to work around specific problem
-cases by skipping wbc_init_bio() or using bio_associate_blkcg()
+cases by skipping wbc_init_bio() or using bio_associate_create_blkg()
 directly.
 
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 6f1ae3ac9789..109f55196866 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3060,11 +3060,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
-	if (wbc) {
-		wbc_init_bio(wbc, bio);
-		wbc_account_io(wbc, bh->b_page, bh->b_size);
-	}
-
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
@@ -3084,6 +3079,11 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 		op_flags |= REQ_PRIO;
 	bio_set_op_attrs(bio, op, op_flags);
 
+	if (wbc) {
+		wbc_init_bio(wbc, bio);
+		wbc_account_io(wbc, bh->b_page, bh->b_size);
+	}
+
 	submit_bio(bio);
 	return 0;
 }
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index db7590178dfc..2aa62d58d8dd 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -374,13 +374,13 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 	if (!bio)
 		return -ENOMEM;
-	wbc_init_bio(io->io_wbc, bio);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
+	wbc_init_bio(io->io_wbc, bio);
 	return 0;
 }
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fdfd04e348f6..738a0c24874f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -246,7 +246,8 @@ static inline void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
  *
  * @bio is a part of the writeback in progress controlled by @wbc.  Perform
  * writeback specific initialization.  This is used to apply the cgroup
- * writeback context.
+ * writeback context.  Must be called after the bio has been associated with
+ * a device.
  */
 static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 {
@@ -257,7 +258,7 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 	 * regular writeback instead of writing things out itself.
 	 */
 	if (wbc->wb)
-		bio_associate_blkcg(bio, wbc->wb->blkcg_css);
+		bio_associate_blkg_from_css(bio, wbc->wb->blkcg_css);
 }
 
 #else	/* CONFIG_CGROUP_WRITEBACK */
-- 
2.17.1

