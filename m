Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406352-2-16142620690533938226
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406351; b=bSunaUbFniB/e0fyfzPAHiDJnf2HMgeev8qfCr72T9nlaadHLT
    Mt6FF+8JFtP6URqR2Y52HVdj3aCI52oPidA3kF69Yy4YWZD6Kt8AaOkmXcVU1y5S
    +Ms8FhX4bw6d0vTAJuf8z5ZSkUSWtAL3a+XeQzE//rXBE9oufJNorPlFn09bGK2z
    XDY1OG1hnIw9avYb/7z7d/kDUWkvRrEUA4N9TUCRdJdEG39fg+RLEN5cpjN/WoyI
    8pevBjoVMMjTvqLT0y15txvGp7XoVqI7vnR+sZGXViYsnmuJDHjodyZirQ/SjSqE
    u+BqtaEdIOQbPF2yOpJI8+T2Xk1hi3C2BzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406351; bh=p5wTW6sV41dIyceP8zg3Pugvqz0tjr
    +zS2opNhDgSEU=; b=vDyTJGPBbJ8E9JBjfGE8uxA3fcGCakb3AmKv+YRKo4zsj9
    uGGHU5l/tQOi6SQ3f+IZDoDyPwcQ6aICZayfkTcYSuHdoZeITHyu/no2ZfUgSQeb
    pbdJZTC7dgyjxoXWGHX5XpkwLwJBnShCGwASZLRWBHpCTuuMd3yY+hNr30NVKBI3
    RWPiMyq2yA36LbzLhPLsGI36Z0vCyFFAhoxxJSkytgPFGeZVp9hXS5JAWYnZSz3D
    Z3un6gI7vFh9MUcw17a9tLx/q6VNeackY6w4xDuWWAwDtwa2EVGF0wY2iWemo5t8
    zvol1889H6XB/gVyneu79pHgQ3mCeepXUo1yE1Hg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBkZNfj6z/DsGNx2J+ZnVV6sCAnpckx+/zaD3YmrCkm1ak4Uw+6uxREChVHdN80XfgRGc7jgipt0jHq779U0FdiHKGh0lHYCiwLQnm0GySb7SbnimI9S
    jeJ5wKfNjb2d2QssuLsty66QvJhK+Uo4kAl6GhUK0mNmxqyz5RixgH5jTrQlclU4YUnO+1ScahxhqbwEkDCORtM8VdkwWIae22f/IO804W9UOu8U0WBTqFh3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=0siZiybVqcb_7OcERy0A:9
    a=W2gqdsOa5MjL25bu:21 a=ui_qwDen8V4aT1Za:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756643AbeDVOM1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:12:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756665AbeDVOMY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:12:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xu <wen.xu@gatech.edu>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 37/95] ext4: add validity checks for bitmap block numbers
Date: Sun, 22 Apr 2018 15:53:06 +0200
Message-Id: <20180422135211.941652389@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 7dac4a1726a9c64a517d595c40e95e2d0d135f6f upstream.

An privileged attacker can cause a crash by mounting a crafted ext4
image which triggers a out-of-bounds read in the function
ext4_valid_block_bitmap() in fs/ext4/balloc.c.

This issue has been assigned CVE-2018-1093.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199181
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1560782
Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/balloc.c |   16 ++++++++++++++--
 fs/ext4/ialloc.c |    7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -337,20 +337,25 @@ static ext4_fsblk_t ext4_valid_block_bit
 	/* check whether block bitmap block number is set */
 	blk = ext4_block_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
 
 	/* check whether the inode bitmap block number is set */
 	blk = ext4_inode_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
 
 	/* check whether the inode table block number is set */
 	blk = ext4_inode_table(sb, desc);
 	offset = blk - group_first_block;
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= sb->s_blocksize)
+		return blk;
 	next_zero_bit = ext4_find_next_zero_bit(bh->b_data,
 			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
 			EXT4_B2C(sbi, offset));
@@ -416,6 +421,7 @@ struct buffer_head *
 ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh;
 	ext4_fsblk_t bitmap_blk;
 	int err;
@@ -424,6 +430,12 @@ ext4_read_block_bitmap_nowait(struct sup
 	if (!desc)
 		return ERR_PTR(-EFSCORRUPTED);
 	bitmap_blk = ext4_block_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid block bitmap block %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot get buffer for block bitmap - "
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -119,6 +119,7 @@ static struct buffer_head *
 ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh = NULL;
 	ext4_fsblk_t bitmap_blk;
 	int err;
@@ -128,6 +129,12 @@ ext4_read_inode_bitmap(struct super_bloc
 		return ERR_PTR(-EFSCORRUPTED);
 
 	bitmap_blk = ext4_inode_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid inode bitmap blk %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot read inode bitmap - "
