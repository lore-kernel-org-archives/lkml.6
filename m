Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323706-2-12490107985416521930
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
    t=1518323705; b=whCOnqeoTLnvCnWxx7G7aqdhZTHNZsuFPJ8nAFkTHNA02eg
    unepN4Ff8lY0FSh9VAinvThjKMizgabQYobYA10t/B5iA2hl0RITltfefuWbNzHG
    LAuznKnvFwRdevZpaSSDnSFLYq+ztzDzd09O1vIJZDndyfba6XcWYgKOTsA9NPUt
    juX4cNK+HxE3PqCP5KEloGy8pM9DX3osB3TlhlSGpSZExtloau+ImED59S2W0oA1
    1WcDLWdDs+uX5AaQIab/q32yvNJTTvA8xqwPIifP0X/QcSqCp98pOL/YQkSk8WG4
    PzM4f3AUOwO1/tCYJD47z1w4j5U1pkbHdEniZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323705; bh=LPD/XltgAsfkFr+22u2
    MBMNJv7XFkTAmNxnfweOkh48=; b=hAkGntuyzEsq7URX3CYWd3+3/aBCjzFxhK7
    /3Gtz5sgCju20Xr0BAybfrtxguqwRq4mY0k+DFNTImwTqYpJJzRKgYSXAUU0Vk4z
    cbuOIYkqtxn//bKkBwao822hajKnCJfztIugUiu2Ct6ELR5Tw02KCSSrynnhbJPw
    0UM74cF8GHw9iTSDJB/7v8tuHnPM3zi3k3m4cFBoCOEko5tIO5Z6I675F5zP/Fm2
    0MudqagkYEOKrdpZnxZPHASgtXwLWUT8hMofT8SG8++62yDsMJm8iGM0viYCeYP+
    p9ghPV8hCrgwSJ/TtyW1PuRk8ZhdQCggv1fPjBMuXvouBAhZ0jg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeBKEfC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41760 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753002AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jaegeuk Kim" <jaegeuk@kernel.org>,
        "Dongho Sim" <dh.sim@samsung.com>, "Chao Yu" <chao2.yu@samsung.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.546669999@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 054/136] f2fs: remove redundant lines in
 allocate_data_block
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

From: Dongho Sim <dh.sim@samsung.com>

commit 33be828ada7274ebcade2001f16e5b4e33a4636e upstream.

There are redundant lines in allocate_data_block.

In this function, we call refresh_sit_entry with old seg and old curseg.
After that, we call locate_dirty_segment with old curseg.

But, the new address is always allocated from old curseg and
we call locate_dirty_segment with old curseg in refresh_sit_entry.
So, we do not need to call locate_dirty_segment with old curseg again.

We've discussed like below:

Jaegeuk said:
 "When considering SSR, we need to take care of the following scenario.
  - old segno : X
  - new address : Z
  - old curseg : Y
  This means, a new block is supposed to be written to Z from X.
  And Z is newly allocated in the same path from Y.

  In that case, we should trigger locate_dirty_segment for Y, since
  it was a current_segment and can be dirty owing to SSR.
  But that was not included in the dirty list."

Changman said:
 "We already choosed old curseg(Y) and then we allocate new address(Z) from old
  curseg(Y). After that we call refresh_sit_entry(old address, new address).
  In the funcation, we call locate_dirty_segment with old seg and old curseg.
  So calling locate_dirty_segment after refresh_sit_entry again is redundant."

Jaegeuk said:
 "Right. The new address is always allocated from old_curseg."

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Dongho Sim <dh.sim@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/f2fs/segment.c | 3 ---
 1 file changed, 3 deletions(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -969,14 +969,12 @@ void allocate_data_block(struct f2fs_sb_
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg;
-	unsigned int old_cursegno;
 
 	curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
 
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
-	old_cursegno = curseg->segno;
 
 	/*
 	 * __add_sum_entry should be resided under the curseg_mutex
@@ -997,7 +995,6 @@ void allocate_data_block(struct f2fs_sb_
 	 * since SSR needs latest valid block information.
 	 */
 	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
-	locate_dirty_segment(sbi, old_cursegno);
 
 	mutex_unlock(&sit_i->sentry_lock);
 
