Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326413-2-14977419153237982569
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
    t=1518326412; b=R6+DXdiBPuyS3/N0oFbSdVpEjg0db65qFaT1Qaz+lAPT43K
    B1vJ7+cx1yVFp3B9Cue5gONrEJ3lPbzn2djfDiKllKT+g4BOSKstYtPQbV+VdGBd
    cNxQfMK2CQbWLgcGAu8HtIwZLkvSEHHyqO4ZRqZQ73BXNw9a3+NDU85+aib5RLWc
    e0z24IsGBdmrccwShR3Q9fTtjPXed6uEbQiJSxmbyvaPXlZQoUhSWLEzfwjnQs0l
    2A0LGMMBhC3pda08e2Pt/b8TEa9QQp9ZBVKwKCHATf//HHvmn4BmstiiCAy44ZBL
    xL37G/DtFwF1DFz1xWJv8PIY1/dey2HKiHdjaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326412; bh=dAFbsKiM/eqkQzUXyKI
    ya3WMwAIlpDzeksPxaHHoM5Q=; b=U4eqFcccWCm4nTzBy7gSgHMla8XrRSk0rpL
    qL17AiriIgspGGBMiLEAdtU2SleW6w+RWtya2osjA+okCuTp50f6MAR7D+yd8gXd
    guPndIhJM2ealW1TMYMWw+qWExYM6VWadqUeSdxCIq/9m9g/9xV7xMNrrSeU/h96
    PfO8+fNq4H+UC9JkTTH5RFnhNcPH+vzZfe5Ef72OlMIs8zm3v6RlB/pujDU3q5Wi
    HCxgz/DlEacuXDBbLxr8qONz/dNPrAccWIjAA2r3kngSwX+F5OHv7b6OvjQOpTEE
    pirebp3RJwg0ekt6xffrfII725+8/LZbdv7qX0Jy8/nF4vqOC/w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeBKFUB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:20:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753314AbeBKFSR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:17 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jaegeuk Kim" <jaegeuk@kernel.org>,
        "Chao Yu" <yuchao0@huawei.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.166462567@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 030/136] f2fs: expose some sectors to user in inline
 data or dentry case
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 5b4267d195dd887c4412e34b5a7365baa741b679 upstream.

If there's some data written through inline data or dentry, we need to shouw
st_blocks. This fixes reporting zero blocks even though there is small written
data.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
[Jaegeuk Kim: avoid link file for quotacheck]
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 3.16:
 - Inline dentries are not supported
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -460,6 +460,11 @@ int f2fs_getattr(struct vfsmount *mnt,
 	struct inode *inode = dentry->d_inode;
 	generic_fillattr(inode, stat);
 	stat->blocks <<= 3;
+
+	/* we need to show initial sectors used for inline_data/dentries */
+	if (S_ISREG(inode->i_mode) && f2fs_has_inline_data(inode))
+		stat->blocks += (stat->size + 511) >> 9;
+
 	return 0;
 }
 
