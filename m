Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519705923-2-2291371602274598308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519705922; b=UyVNeHovHj2/pldg/0/+937mB4mnMPPXp46LLchSpNVb0/q
    of3gWmRA5AEg9/y40Tard80VC3xTooxDb0vR2EiKXua3RxNMz5+2OtAkj9QXhkkX
    2Q1dAmWlOZl8NaYaZLl2VsRysbmXslPhqJw0hrB1UjlpzHW//pQYh+VWs6cOtoMz
    D2wQ6btY0KqGk/2T2eqJqpxzk98pQkxroBe0R5jGp87y5feqYa5AJpwFL/mtMFvm
    2Zs7rzO2QxuhZr7A3YEE6YlUXSMm3WdzrTSA2FZ6nZUMRPoKSKaNp1yvKbyIPmST
    PmhF7Yu7L02Bwyzdjum9+kywSMaKglbKw62JHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705922; bh=gEH81IVJK1GdrDp5IemFj0/CsA6uIEayyWWcQVR4rx0=; b=D
    NAoV7xaU7WqVpVXX+JfRyuotzXHUEwbfFnMTs9lf0wSTvmUt0uyRcGzw9hwrF7U0
    vsUSz5906Gsl7n1Fwy7ZF0uiD/8zd+MhVzbMPlQJ4RtObRIh1IGxsS6vbHYYcOPR
    SgT+ZeqJOK3GhNfn8kz43p4bkGURX0Tx2ahmOEmFjM+HamFJh47VfmdRORskyfby
    y53kWK3dhRWfZHoLL1us5rOyCQZDi+K0ERm4be/gijwjGiTCV6BMsXJK185WBhGw
    QWAYV+rIyQqI7/O9JF3G3UM1MRxRnliNajNVd+saeRdiI9FkSvc9fklNEoJlPAZn
    4JUztbbeF/I1Ti0B3Et6A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeB0E3Z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:29:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:33145 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbeB0E3W (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="178335453"
Subject: [PATCH v4 04/12] ext2,
 dax: define ext2_dax_*() infrastructure in all cases
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jan Kara <jack@suse.com>
Date: Mon, 26 Feb 2018 20:20:16 -0800
Message-ID: <151970521671.26729.14342103844044388890.stgit@dwillia2-desk3.amr.corp.intel.com>
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

In preparation for fixing S_DAX to be defined in the CONFIG_FS_DAX=n +
CONFIG_DEV_DAX=y case, move the definition of these routines outside of
the "#ifdef CONFIG_FS_DAX" guard. This is also a coding-style fix to
move all ifdef handling to header files rather than in the source. The
compiler will still be able to determine that all the related code can
be discarded in the CONFIG_FS_DAX=n case.

Cc: Jan Kara <jack@suse.com>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext2/file.c      |    8 --------
 include/linux/dax.h |   10 ++++++++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 1c7ea1bcddde..5ac98d074323 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -29,7 +29,6 @@
 #include "xattr.h"
 #include "acl.h"
 
-#ifdef CONFIG_FS_DAX
 static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
@@ -128,9 +127,6 @@ static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_MIXEDMAP;
 	return 0;
 }
-#else
-#define ext2_file_mmap	generic_file_mmap
-#endif
 
 /*
  * Called when filp is released. This happens when all file descriptors
@@ -162,19 +158,15 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-#ifdef CONFIG_FS_DAX
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_read_iter(iocb, to);
-#endif
 	return generic_file_read_iter(iocb, to);
 }
 
 static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-#ifdef CONFIG_FS_DAX
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_write_iter(iocb, from);
-#endif
 	return generic_file_write_iter(iocb, from);
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0185ecdae135..47edbce4fc52 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -93,8 +93,6 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 
-ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops);
 int dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
 int dax_finish_sync_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
@@ -107,6 +105,8 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
 		unsigned int offset, unsigned int length);
+ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops);
 #else
 static inline int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
@@ -114,6 +114,12 @@ static inline int __dax_zero_page_range(struct block_device *bdev,
 {
 	return -ENXIO;
 }
+
+static inline ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops)
+{
+	return -ENXIO;
+}
 #endif
 
 static inline bool dax_mapping(struct address_space *mapping)
