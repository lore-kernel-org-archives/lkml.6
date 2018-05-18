Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3904782-1526646871-2-167874107478743435
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526646871; b=lQXNpxINqenop1vtBdymLQL7AkjOCAM4cUr2zKhIF95dNuGVV2
    nqYAML3xS0fpKVBVo7wWp6EJqY35FeIRNpL7z/EUpchMAG1X62iNFYhGukFWvitb
    UL3uTQjxfXCLIekwCxDrFMbmsX0Icw4ER6rSJ19XC72SaGU3Rs7F0Nn6gjvV/tUs
    djODCGVyF0662jBaB58xArYDDvGIvT+zKOtgTUdZJmM3++xVDWfAwotbLgho3CJ6
    ziV9lM4h8m62RmPkFgvvRNL6JZoEku70w+h8688vwKfk/lPKeUoftz3jH/rDVEWY
    cROgVEXL65oaDd8ohr+pqiqFaBuLtWcTpheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526646871; bh=
    WWecXvKTw3qMptRQo+W2EISJLZN/ZRzcPKqGBjR4OEE=; b=SQtfBE61PoXatn0M
    A6DJTtbxnOeDa5H+f5qzA0X6ByKGBkcH+XEZvkyMNy2Pc7vAeu85FgwIG6IDf/Pe
    gpq4ROg0rXBn0mWfxoubQo1dOw7i6p6VCid5Fw9vjqlfh1N8ggAuetXN1VLOX29T
    AWtTT2o5Luggne907NVFtN64UDfp1Z7sYo6wSZUjYibATGkI6ZjCx9eNppgPaxph
    6V1MRifmhMyQyGSDIv2+5qZuLx91MvKgvKNzy8CYVuGHTkBRQ5U0KcD2nXas/hR7
    aNpfgFHx5woXQMokBW6dxB0SewvgAhc5wpVKFC4PHiAhMf+PS3oIBigHSvvKvopc
    o6Bw8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hHZsx3Ub x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hHZsx3Ub x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTxxHLTG3yFbyO+SgVQMfJOHumXA0VrAPXKT1CwnkgEwywbDeB21Y/zA+PVBnSKgr83CV2grW0eoZDgu36v5Q64EdG39EcP3QEr9qafm8rKOSmt72Lq
    X5WZCqsJndctlicq3kUKv7xLvtcmSrmAHyRKHCPDju75F8xM01SvWxuRIrH+rZN0X3yNAsU8Xw6up5gFbAGS5wT8OtMqMlnIxawY7OuChl0h+VQQNOIREaXn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=JfrnYn6hAAAA:8 a=GNsyKJoZn9PrpM4oRc4A:9 a=4MQNZ0B9HpVkPOYV:21
    a=VEPsnuCcJBzqb1Bj:21 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeERMe1 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 08:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeERMeW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:22 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 05/11] fs: track per-sb writeback errors and report them to syncfs
Date: Fri, 18 May 2018 08:34:09 -0400
Message-Id: <20180518123415.28181-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

Usually we suggest that applications call fsync when they want to
ensure that all data written to the file has made it to the backing
store, but that can be inefficient when there are a lot of open
files.

Calling syncfs on the filesystem may be more efficient, but the error
reporting doesn't currently work the way most people expect. If a single
inode on a filesystem reports a writeback error, syncfs won't return an
error. syncfs only returns an error if __sync_blockdev fails.

It would be better if it reported an error if there were any writeback
failures. Then applications could call syncfs to see if there are any
errors on any open files, and could then call fsync on all of the other
descriptors to figure out which one failed.

This patch implements a suggestion from Willy to remedy this. It adds a
new errseq_t to struct super_block, and has mapping_set_error also
record writeback errors there.

To report errors recorded there, we also need to keep an errseq_t for in
struct file to act as a cursor, but growing struct file for this purpose
is undesirable. We could just reuse f_wb_err, but someone could mix
calls to fsync and syncfs and that would break things.

As an alternative, this patch only has syncfs report errors recorded
in s_wb_err when the file has been opened with O_PATH. Any file opened
with O_PATH will not have its fsync field defined in its
file_operations so we can be sure that nothing else will be using its
f_wb_err field.

Note that calling syncfs on an O_PATH descriptor today will return
-EBADF, so this scheme gives userland a way to tell whether this
mechanism will work at runtime.

Cc: Andres Freund <andres@anarazel.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/open.c               | 6 +++---
 fs/sync.c               | 9 +++++++--
 include/linux/fs.h      | 3 +++
 include/linux/pagemap.h | 5 ++++-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index c5ee7cd60424..3e8c7b16abb8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -739,15 +739,15 @@ static int do_dentry_open(struct file *f,
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 
-	/* Ensure that we skip any errors that predate opening of the file */
-	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
-
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH;
 		f->f_op = &empty_fops;
+		f->f_wb_err = errseq_sample(&f->f_path.dentry->d_sb->s_wb_err);
 		goto done;
 	}
 
+	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
+
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
diff --git a/fs/sync.c b/fs/sync.c
index c876fa414cae..f2400d13a65f 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -162,16 +162,21 @@ void emergency_sync(void)
  */
 SYSCALL_DEFINE1(syncfs, int, fd)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	struct super_block *sb;
+	errseq_t *wberr = NULL;
 	int ret;
 
 	if (!f.file)
 		return -EBADF;
+
 	sb = f.file->f_path.dentry->d_sb;
 
+	if (f.file->f_flags & O_PATH)
+		wberr = &f.file->f_wb_err;
+
 	down_read(&sb->s_umount);
-	ret = sync_filesystem(sb, NULL);
+	ret = sync_filesystem(sb, wberr);
 	up_read(&sb->s_umount);
 
 	fdput(f);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d40fe9ead5fb..fecd29325f36 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1416,6 +1416,9 @@ struct super_block {
 	/* Being remounted read-only */
 	int s_readonly_remount;
 
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
 	/* AIO completions deferred from interrupt context */
 	struct workqueue_struct *s_dio_done_wq;
 	struct hlist_head s_pins;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b1bd2186e6d2..2de87c5a2718 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -51,7 +51,10 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
 		return;
 
 	/* Record in wb_err for checkers using errseq_t based tracking */
-	filemap_set_wb_err(mapping, error);
+	__filemap_set_wb_err(mapping, error);
+
+	/* Record it in superblock */
+	errseq_set(&mapping->host->i_sb->s_wb_err, error);
 
 	/* Record it in flags for now, for legacy callers */
 	if (error == -ENOSPC)
-- 
2.17.0
