Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671466-2-1924094196923516693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671465; b=c1ygKHZJosyVI5gr5evp1RTJGXfLQBqw/bltCaFh9e6FTGTz54
    iS8zJ2Wze84U73V6mE8G7rVoPcabjvk+2CbsZcZrF2HxP0Hr77aTX4g5sHdYqePH
    qnnd09u2NmjFLgsKi7epoYd34gEnKwJ65ALkuUgDQBiyHPnoJQj7tqXtzTKkbMc4
    8LTCsL8UZ5o2JwHdSfEqj68IVvpwIWzrQSa4V1tsToQZQbnw+BKHaA8he77gr0Gp
    jq1YYjT+apltBvmGe02baSkNaQ8Trp9GoePpiOrM0FFztDlINja9mUwOgT1yHUBM
    46KyE1r0cy5bzYpoiIGLAF9B0cBGAC55LSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671465; bh=q7rpD
    MfD5SI2pfYR+8BF8zyPiWkoEKepaPE4oPolDgk=; b=S3N0DB031D1XI+bwVsMJA
    +WKK9/sQ4e/u85yzrErZUMbbwd0Y8pw5G0rFTaNWTSvxUojLczdw+1IAvW4UyGga
    SBbuy+Qg62+F6NUc02x7zzWM5cvOGH8fftCR4XGtJDqNyzKIQLQ+BnC90Fp29WOq
    qMixGA+olbPxaUO+4WlCvuPOVuyxWq59FE6Zw+tBrtsFoZQx4TrFUsfPmZf2xoJW
    sqZXkxUtFpuHWBBfa5XAsDDmx6p4JocJCmkO7QAIoe+kF/CoPTx2qK3cTcAhUgKn
    SVr/ZoJVQSHt3fbdmd1vZM8P/O06QkiYdyzvAznPy6UD/8nwj6pCDpt1lyBZW3gS
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eJ907jIp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eJ907jIp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKo/3EKisOqq904DHQurHvIdW+KIdwtA1vBHgHuBJ9E/fRuyy92GuvMypGHW0okF8UC1eaL6nrR8zRewbJ500jwKDrUJ0BnzMvTQtspsIiCGY9N6P9h8
    QlBBKRyRSJlkqpAdeoS7xVFJfIINhYlyXnSIMx0Zcbu8tkk1x4Aq9rO4DulJk/ZwPK+vnUgQcUHGLTpdAfIvDHNqHehlHaF8wfv86iwno65HjOE7qfg8D6X2
    krO7Ks/7uxfNeyAmuFJCVg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=4aXlkbbbZBFjr_qRE6UA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 22/40] ext4: simplify procfs code
Date: Wed, 25 Apr 2018 17:48:09 +0200
Message-Id: <20180425154827.32251-23-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use remove_proc_subtree to remove the whole subtree on cleanup, and
unwind the registration loop into individual calls.  Switch to use
proc_create_seq where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/mballoc.c | 29 ++++------------------------
 fs/ext4/sysfs.c   | 49 +++++++++--------------------------------------
 3 files changed, 14 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a42e71203e53..229ea4da6785 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2390,7 +2390,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
 extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
 
 /* mballoc.c */
-extern const struct file_operations ext4_seq_mb_groups_fops;
+extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
 extern int ext4_mb_init(struct super_block *);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 769a62708b1c..6884e81c1465 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2254,7 +2254,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t *pos)
 {
-	struct super_block *sb = seq->private;
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
 	ext4_group_t group;
 
 	if (*pos < 0 || *pos >= ext4_get_groups_count(sb))
@@ -2265,7 +2265,7 @@ static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t *pos)
 
 static void *ext4_mb_seq_groups_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct super_block *sb = seq->private;
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
 	ext4_group_t group;
 
 	++*pos;
@@ -2277,7 +2277,7 @@ static void *ext4_mb_seq_groups_next(struct seq_file *seq, void *v, loff_t *pos)
 
 static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 {
-	struct super_block *sb = seq->private;
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
 	ext4_group_t group = (ext4_group_t) ((unsigned long) v);
 	int i;
 	int err, buddy_loaded = 0;
@@ -2330,34 +2330,13 @@ static void ext4_mb_seq_groups_stop(struct seq_file *seq, void *v)
 {
 }
 
-static const struct seq_operations ext4_mb_seq_groups_ops = {
+const struct seq_operations ext4_mb_seq_groups_ops = {
 	.start  = ext4_mb_seq_groups_start,
 	.next   = ext4_mb_seq_groups_next,
 	.stop   = ext4_mb_seq_groups_stop,
 	.show   = ext4_mb_seq_groups_show,
 };
 
-static int ext4_mb_seq_groups_open(struct inode *inode, struct file *file)
-{
-	struct super_block *sb = PDE_DATA(inode);
-	int rc;
-
-	rc = seq_open(file, &ext4_mb_seq_groups_ops);
-	if (rc == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = sb;
-	}
-	return rc;
-
-}
-
-const struct file_operations ext4_seq_mb_groups_fops = {
-	.open		= ext4_mb_seq_groups_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
 {
 	int cache_index = blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 9ebd26c957c2..f34da0bb8f17 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -346,39 +346,9 @@ static struct kobject *ext4_root;
 
 static struct kobject *ext4_feat;
 
-#define PROC_FILE_SHOW_DEFN(name) \
-static int name##_open(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, ext4_seq_##name##_show, PDE_DATA(inode)); \
-} \
-\
-static const struct file_operations ext4_seq_##name##_fops = { \
-	.open		= name##_open, \
-	.read		= seq_read, \
-	.llseek		= seq_lseek, \
-	.release	= single_release, \
-}
-
-#define PROC_FILE_LIST(name) \
-	{ __stringify(name), &ext4_seq_##name##_fops }
-
-PROC_FILE_SHOW_DEFN(es_shrinker_info);
-PROC_FILE_SHOW_DEFN(options);
-
-static const struct ext4_proc_files {
-	const char *name;
-	const struct file_operations *fops;
-} proc_files[] = {
-	PROC_FILE_LIST(options),
-	PROC_FILE_LIST(es_shrinker_info),
-	PROC_FILE_LIST(mb_groups),
-	{ NULL, NULL },
-};
-
 int ext4_register_sysfs(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	const struct ext4_proc_files *p;
 	int err;
 
 	init_completion(&sbi->s_kobj_unregister);
@@ -392,11 +362,14 @@ int ext4_register_sysfs(struct super_block *sb)
 
 	if (ext4_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, ext4_proc_root);
-
 	if (sbi->s_proc) {
-		for (p = proc_files; p->name; p++)
-			proc_create_data(p->name, S_IRUGO, sbi->s_proc,
-					 p->fops, sb);
+		proc_create_single_data("options", S_IRUGO, sbi->s_proc,
+				ext4_seq_options_show, sb);
+		proc_create_single_data("es_shrinker_info", S_IRUGO,
+				sbi->s_proc, ext4_seq_es_shrinker_info_show,
+				sb);
+		proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
+				&ext4_mb_seq_groups_ops, sb);
 	}
 	return 0;
 }
@@ -404,13 +377,9 @@ int ext4_register_sysfs(struct super_block *sb)
 void ext4_unregister_sysfs(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	const struct ext4_proc_files *p;
 
-	if (sbi->s_proc) {
-		for (p = proc_files; p->name; p++)
-			remove_proc_entry(p->name, sbi->s_proc);
-		remove_proc_entry(sb->s_id, ext4_proc_root);
-	}
+	if (sbi->s_proc)
+		remove_proc_subtree(sb->s_id, ext4_proc_root);
 	kobject_del(&sbi->s_kobj);
 }
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
