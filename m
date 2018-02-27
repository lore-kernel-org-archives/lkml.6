Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-351074-1519705848-2-10785444300430422735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705847; b=nV73aN/60bvFkYpGWLVo1GqDa6Mj7rmQZc7NYR3W3PITRiK
    gvOrVweYg/JUT9sL79BvZ/tuqq+o38IiVfT6MqZjw/eHwwfb1TfRVpHB8kZqLZTq
    JzsqgGNd7iPdxUhwH13HF0BpRDbhvtJPt+47ABKwLov9Yix58g+fR6fnlTjK35G6
    cA7Hws3FymtQHlu70ef6MkDSMc4a5BrAoMU4CxWeom3243JjvQC9B9xx7gCkfVES
    CpPOeqdxNu8ZcQBYcK++ugLqF46QVqATKDGn7Hl4DnDLp2rNpERzeOF4RWbFL4Dg
    jjt4eo2uD+d5dQAr0+P6W+RugpB7VzpIm7wcJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705847; bh=ou7v2ZjXRQbOgZ4ueJOxUClWDcFhDc6LK/ipJ4jJbQw=; b=j
    7+CFXCdMOQqYGg8axa8BI8Fur3TYzQ4JAdIHgsLsBT7c8oXmFVMSRcsBmiMBsRw+
    bN77IwH2tES8KOx5afZYgiTFYganC3N0VZ0CEi2kMt+F0SKL7S+lHyPwQ3+zIYD7
    I8lhmgtY61eUvxwjY/L0MrMC7zSAmFfS9GLuKCU7SbooHZlfquavs3RhzwY54vuu
    H5ahfdG/XRZZfP1zbHO62OSe0nyfs72gWzoYWcOMWRiuHGj6AkoyKrcT+DNcpvZc
    yfaYGySh9MfFFYe0iovRVdRPI6nS4InLDDzHsm5IUx6CLF8xjXCBZ/3hVbo4eRlt
    k1KcF0IRrVsd77R/AQ7Gw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeB0E3z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:18034 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbeB0E3y (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="178335563"
Subject: [PATCH v4 10/12] fs, dax: kill IS_DAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 26 Feb 2018 20:20:48 -0800
Message-ID: <151970524837.26729.14336810163194275690.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation for fixing the broken definition of S_DAX in the
CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all the remaining
IS_DAX() usages to use explicit tests for FSDAX.

Cc: Jan Kara <jack@suse.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/iomap.c          |    2 +-
 include/linux/dax.h |    2 +-
 include/linux/fs.h  |    3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index afd163586aa0..fe379d8949fd 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -377,7 +377,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		offset = pos & (PAGE_SIZE - 1); /* Within page */
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
-		if (IS_DAX(inode))
+		if (IS_FSDAX(inode))
 			status = iomap_dax_zero(pos, offset, bytes, iomap);
 		else
 			status = iomap_zero(inode, pos, offset, bytes, iomap);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 47edbce4fc52..ce520e932adc 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -124,7 +124,7 @@ static inline ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 static inline bool dax_mapping(struct address_space *mapping)
 {
-	return mapping->host && IS_DAX(mapping->host);
+	return mapping->host && IS_FSDAX(mapping->host);
 }
 
 struct writeback_control;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a5aa8761011..8021f10068d3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1903,7 +1903,6 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_IMA(inode)		((inode)->i_flags & S_IMA)
 #define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)
 #define IS_NOSEC(inode)		((inode)->i_flags & S_NOSEC)
-#define IS_DAX(inode)		((inode)->i_flags & S_DAX)
 #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
 
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
@@ -3203,7 +3202,7 @@ extern int file_update_time(struct file *file);
 
 static inline bool io_is_direct(struct file *filp)
 {
-	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
+	return (filp->f_flags & O_DIRECT) || IS_FSDAX(filp->f_mapping->host);
 }
 
 static inline bool vma_is_dax(struct vm_area_struct *vma)
