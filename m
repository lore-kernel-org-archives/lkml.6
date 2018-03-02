Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-441027-1519963426-6-6845323425006523341
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
    t=1519963426; b=IiN/H27tzN+jGyXGx5wJjBCFjXiUk4/YWvQaxKipKlCYvB6
    hwk8jJcHrtRsAWOvLdOPnARFstp3P7Nxk/seLZmIyfRA0pLWSXBnTUC6Or90ba78
    NbGmMVoS9jOzeCLyC/lcJAOLGU/tRDoxcxNcKNE8UKBuABMu9bZK2F6CJVIfVu7P
    UnbmnpfKIvsb5y1pXOgzLbhQOY0cTSc0b6jP+Jp5/VFrzil9uCSzDsjrZpcSlXYi
    mTlui0llt54vXZkJmq5+Yk26CHB7LGqT2C0pmdpYBN0wyLDJOIwmUSnpfrfgsnns
    ESl+1IgXUkboymqXyALA7op64D/pk4Le0NgLAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519963426; bh=/1nntOixSjJqsq6Bne4BEbkJKNtooycqZokXgvYb64o=; b=l
    O/abu0T/cs7AkE9UZcCxXl7TB0RXnpiFnpJ6ML1PGO/IBlgUpxuiqAX4lXoXtGF/
    QZEGuPM+OKuU3uOM4yRhFGCNjln00Ziax3NDkKlUmgHZWEmo1PiHcB1lEjZVWrVV
    0NtD3szW4KlcUXIYtQ3RlDw3oAOdxWZm3wETLMlqBnDPIdsmnPP8bXsJPdaiVA+r
    5ULS0K27aCOpPwy3bxhXyToF7uPZfex5j+fTfmSaKoUEo0kc0tOaLl4N64baRjpm
    oTprCuCAQ/nWFj0jaiBCa0woNb7wkepICF6pCrSwoBugFLkHFchiXKrIExHK51no
    Q8xmoK6qQLUiVbOoEgQgA==
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
        id S1164896AbeCBEDi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:03:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:10237 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164868AbeCBEDf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 23:03:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="34878637"
Subject: [PATCH v5 10/12] fs, dax: kill IS_DAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-xfs@vger.kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 19:54:28 -0800
Message-ID: <151996286805.28483.12933227722062678008.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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

Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reviewed-by: Jan Kara <jack@suse.cz>
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
index 33e859e7d100..b2b2e15d227b 100644
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
