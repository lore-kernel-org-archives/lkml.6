Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BBFC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC85220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXfPZkTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC85220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeIGBsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:48:24 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39638 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbeIGBsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:23 -0400
Received: by mail-yb1-f195.google.com with SMTP id c4-v6so4692759ybl.6;
        Thu, 06 Sep 2018 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FkDgmX6YNgFCNFUn3Et8v5b6B07m4GOk66oKL1F2CRg=;
        b=KXfPZkTowXdNn4bSmWJdu0fIAq+PTWF8ppkRCr5mf+HPR/zHI8m586ResP00rTLnio
         z5f83bPQwcEOWBEQ9aFxMYcFsWRE/Gk1Df+CUI2S9wGfSMdZAMuEZEI/y0JUCEy9EYQB
         QTWRQZZY1JIVBhBf2WTL6kUp11fUEkfVL44iehQ76JGSlOmONIkS7ll2icYTsE0zNVeP
         ioOaWALWwpegBqrO4CGSooBz6rZ+p5Okp/icK8PRI6nJ2DbKesauU4gUnyjNGD31F1Kx
         US/47kq1IwRVL/6HZcTa0Htvg/USykojSp9QRO/Gly93pQjNVnUUmHlwkWNKzUQrZXNH
         bWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FkDgmX6YNgFCNFUn3Et8v5b6B07m4GOk66oKL1F2CRg=;
        b=nC4CE3s22Rl0i6D7U4SG2zUXwIj7GfcxSWEwLsMEo1XqJi5YuX2WYUHiofA3WUwLVN
         TSSt9e00prKOOkhDN0gtGUSqOHMJE1tVNBk5ACmbZ03J97ygi/FcRmrAagBnMebxE5jj
         WCI41l0fjIDqFjXlXSJp7UerE8RUJZQdh8JsloSlxxF8OGpTe0b1Zo+lKbfFHjefQoNb
         0BbwnlwllWU9wpHRtUwLFEAGMELJCB3ivIttzR+amMMVojG/uLbxI8RdTM6/I5TAYD68
         K61x+2mCdpIvtm1B44FuA5GSaWrtA14JFIWUilKL/G3Sg3Q+P8itBs6gImG0dLgvRw4C
         YtOA==
X-Gm-Message-State: APzg51D1Mcd+MrTfL9Dzfy60s1vTnlvyugb8Vk167bjbor7l0aUhnuxk
        Vll42+aN54crfxuz+VXP3qA=
X-Google-Smtp-Source: ANB0VdaJ8ce4tIhJADb+dzV4LqSQXJQ1xw1+Zz12NBW2PrLimyrdckgTfGT9w7wtvANavEdJeMII7g==
X-Received: by 2002:a25:3c84:: with SMTP id j126-v6mr2643399yba.29.1536268265461;
        Thu, 06 Sep 2018 14:11:05 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:11:04 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 07/12] blkcg: associate writeback bios with a blkg
Date:   Thu,  6 Sep 2018 17:10:40 -0400
Message-Id: <20180906211045.29055-8-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
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

