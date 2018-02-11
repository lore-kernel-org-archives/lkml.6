Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324053-2-14514724056008383606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324052; b=bnFGjc2zQMDa+Lct40LoLoSeQsNxexa2iXPHLkhpE9KDYKo
    T7kcX6Lg0OFrVazbe8GLdK2DDjScPHWravRi2fvFw3Eil9QzwpXbMZVE8qlP7nhS
    pE03FKBt5IyPTVu7smpA/QHPka3rzv/N3ycuwn70OugtZlFLbkSN4aUxsWXeZDDA
    7FkcPQit6EBWSqHuC+YUZD3rgnJyJl2NVtUT2ZcywId5kr/Yg5JP1cRep1FZuRFV
    C+RXKYpPXiB72cGlePhqd3CYXSm3PJEzzIrlTzlq+TODzmMLkCJnkjv12HftOfYn
    PbAMwCWjqHeu+zT604oilkOrQFy9jXVFNID80Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324052; bh=cqH40n3wc8hsPSVY3Le
    tnZCAoIWA4TSWlV5AlWWHqTg=; b=mSNjrVyiB6nXJye8g1adpz+4OAMoVl/VUIm
    9KVhFMmrxB2et568eKHs0QE8cdyhxw77iju2nwHzKZbN/ZQaBRQp9ZXz3czYu6Al
    0nvGbA9ZblrEFNomRk2MgTBaLRJsAWcJKaKIzcUavUYjr9tufrsEbK9767qsKjsJ
    7MT74s8iPN8erRL7oxqM4AHa02Z4mRnNXMUSwIXG6dt24OJSImhD7RA/m0VNILhm
    7Ua16fZFzgeNmEIr3i2gSOx0ubAIRZ4fOnVCj+cJYjG56W8fjZdLPM2GiVG6nnEL
    8teHBxxukaFFc8rZEBfyHPqmU+lF9qftnnhnxliWrxIQqwxqPmA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeBKEiz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41717 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752963AbeBKEeK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:10 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Yunlong Song" <yunlong.song@huawei.com>,
        "Chao Yu" <yuchao0@huawei.com>, "Jaegeuk Kim" <jaegeuk@kernel.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.436867084@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 055/136] Revert "f2fs: handle dirty segments inside
 refresh_sit_entry"
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlong Song <yunlong.song@huawei.com>

commit 65f1b80b33378501ea552ef085e9c31739af356c upstream.

This reverts commit 5e443818fa0b2a2845561ee25bec181424fb2889

The commit should be reverted because call sequence of below two parts
of code must be kept:
a. update sit information, it needs to be updated before segment
allocation since latter allocation may trigger SSR, and SSR allocation
needs latest valid block information of all segments.
b. update segment status, it needs to be updated after segment allocation
since we can skip updating current opened segment status.

Fixes: 5e443818fa0b ("f2fs: handle dirty segments inside refresh_sit_entry")
Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
[Jaegeuk Kim: remove refresh_sit_entry function]
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 3.16:
 - Don't delete refresh_sit_entry(); it has another caller here
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -988,13 +988,24 @@ void allocate_data_block(struct f2fs_sb_
 
 	stat_inc_block_count(sbi, curseg);
 
-	if (!__has_curseg_space(sbi, type))
-		sit_i->s_ops->allocate_segment(sbi, type, false);
 	/*
 	 * SIT information should be updated before segment allocation,
 	 * since SSR needs latest valid block information.
 	 */
-	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
+	update_sit_entry(sbi, *new_blkaddr, 1);
+	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
+		update_sit_entry(sbi, old_blkaddr, -1);
+
+	if (!__has_curseg_space(sbi, type))
+		sit_i->s_ops->allocate_segment(sbi, type, false);
+
+	/*
+	 * segment dirty status should be updated after segment allocation,
+	 * so we just need to update status only one time after previous
+	 * segment being closed.
+	 */
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
 	mutex_unlock(&sit_i->sentry_lock);
 
