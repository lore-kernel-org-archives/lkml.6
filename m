Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3215875-1525802782-2-2453536203644571081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525802781; b=jb8gQ+CBBIBKXTcUTpLjXmTW100ep7RYEGmyx5FZ2DnI0EKR9H
    qRbLXi3H5W/c4quMn2WQpnrZ7gjC33b/hYorLs0GOU2Z+EfK2Yq9XBysNVdbnG7V
    C3yNmWogJTm9iio/t85XUAfITllabT6B5z3MH6OpE2wLOhJglllkKQ909i1DgLos
    84hx8ChDzdfbiHEU0ptK8dig9tt7wGnPhoLOgSnz3spH37zc0+hAewklZhBHvYEM
    T5XXSVkDZ74U2+3+V1pn5JoRdZOqwPgBJR1BnCwMddRIo17xY/Fz5k7Fk29eOwF8
    opN3KrwFBEOC1+5eyIbKjEYXilrtNBfig0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525802781; bh=
    F+7iKojiLrD23am/2BgwIPj1Y1AMYkudZblDPy0ABXo=; b=IxzklzYXhcbXOhrt
    SyfTdAC8EVKL9Ux/VywsVhJmKrRwHQbFyeGqWOM0H2H/TRLbKAtUnXPbeksWqJgd
    5/R72Xnh/fTa89zSbSkLj7BRzfNyOAxG8hbW8uXTtlsUOv1QaZeDFTC+P+Nt98rd
    HSoPSSKdznOdwCfw32MZ19Niu6D37J4rBTyXuSxjfXQrPfVcYijl+OyafkJ7C80i
    OOmHJ5bQvR9Tn8ne2MNamw8phH2TeTpoaek/mtweU9jO5/Jq6xqC9OVKVnFXxe3F
    TUUp3YIr0ab5+QfvnP5419HqZlKjgRARivTFZbZYp3qFCKX9el9JCEPbAAdGgjv3
    4oXoyQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO5Bv1dhn4VY0C67EeXw699YlWw+u76scmQj3ju2r08ov471kC25tSYIYzYMxb4AOgRiTgQ9FZEr3f6eX/PXfVK8Q1Xo3Ai1b+Yt0QbJkVkA0+kjWzhx
    zkKjxaUqOY/xIh12jMRNbDFZldEJ3JMf8Z593KuLZnz7Jd7IIvmPJh8K4qQGl+/K0U+CIqQnp97AqSBh2cL3Gp69Zz0XpvBK94mO0ksZSG/uvxDfQSi/PA8e
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=DQ1cZn277rISi_ZUblwA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755857AbeEHSGS (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 14:06:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755842AbeEHSGQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:16 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 61/76] fs/qnx6: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:21 -0700
Message-Id: <20180508180436.716-62-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/qnx6/dir.c   | 8 ++++----
 fs/qnx6/inode.c | 4 ++--
 fs/qnx6/namei.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index c1cfb8a19e9d..655d0eb9d82a 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -65,7 +65,7 @@ static int qnx6_dir_longfilename(struct inode *inode,
 			unsigned de_inode)
 {
 	struct qnx6_long_filename *lf;
-	struct super_block *s = inode->i_sb;
+	struct super_block *s = inode_sb(inode);
 	struct qnx6_sb_info *sbi = QNX6_SB(s);
 	struct page *page;
 	int lf_size;
@@ -112,7 +112,7 @@ static int qnx6_dir_longfilename(struct inode *inode,
 static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *s = inode->i_sb;
+	struct super_block *s = inode_sb(inode);
 	struct qnx6_sb_info *sbi = QNX6_SB(s);
 	loff_t pos = ctx->pos & ~(QNX6_DIR_ENTRY_SIZE - 1);
 	unsigned long npages = dir_pages(inode);
@@ -175,7 +175,7 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 static unsigned qnx6_long_match(int len, const char *name,
 			struct qnx6_long_dir_entry *de, struct inode *dir)
 {
-	struct super_block *s = dir->i_sb;
+	struct super_block *s = inode_sb(dir);
 	struct qnx6_sb_info *sbi = QNX6_SB(s);
 	struct page *page;
 	int thislen;
@@ -213,7 +213,7 @@ static unsigned qnx6_match(struct super_block *s, int len, const char *name,
 unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 			 struct page **res_page)
 {
-	struct super_block *s = dir->i_sb;
+	struct super_block *s = inode_sb(dir);
 	struct qnx6_inode_info *ei = QNX6_I(dir);
 	struct page *page = NULL;
 	unsigned long start, n;
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 4aeb26bcb4d0..4be77b89f11d 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -79,7 +79,7 @@ static int qnx6_get_block(struct inode *inode, sector_t iblock,
 	phys = qnx6_block_map(inode, iblock);
 	if (phys) {
 		/* logical block is before EOF */
-		map_bh(bh, inode->i_sb, phys);
+		map_bh(bh, inode_sb(inode), phys);
 	}
 	return 0;
 }
@@ -110,7 +110,7 @@ static int qnx6_readpages(struct file *file, struct address_space *mapping,
  */
 static unsigned qnx6_block_map(struct inode *inode, unsigned no)
 {
-	struct super_block *s = inode->i_sb;
+	struct super_block *s = inode_sb(inode);
 	struct qnx6_sb_info *sbi = QNX6_SB(s);
 	struct qnx6_inode_info *ei = QNX6_I(inode);
 	unsigned block = 0;
diff --git a/fs/qnx6/namei.c b/fs/qnx6/namei.c
index 72c2770830be..0b1a626c20d8 100644
--- a/fs/qnx6/namei.c
+++ b/fs/qnx6/namei.c
@@ -27,7 +27,7 @@ struct dentry *qnx6_lookup(struct inode *dir, struct dentry *dentry,
 
 	ino = qnx6_find_entry(len, dir, name, &page);
 	if (ino) {
-		foundinode = qnx6_iget(dir->i_sb, ino);
+		foundinode = qnx6_iget(inode_sb(dir), ino);
 		qnx6_put_page(page);
 		if (IS_ERR(foundinode)) {
 			pr_debug("lookup->iget ->  error %ld\n",
-- 
2.15.1
