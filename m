Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671459-2-2716776114934248032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671458; b=nF4lfGCmoqBtYeT40UKdi6vVTHwa6s7PWURBXk9Zo8j5MqXY7I
    ub55IcYUNETlZwX5zG202WKqm2k9FYtIKNpaJGGnJenD1F+/r1p25U1jztpmxa/u
    NivqMEoOxx3x4EwOuD1rUjT3W6QUjhxg+JjlNOZ1XnFeuGTTD9U+shPARVo8S8zj
    BCbTC8pIY+KJTgWukahu1QIBbcLFtG4RYXurFFafuQU9BsjYMwA7O5s3kzyRCzrw
    b9fyFkayk/QE+23GRl+hv9Foqjm1YWIcnzAUBAX4dNtLU94Sliiuy4CwzKJRJEK0
    KUNgMbASv+si9P2RDSFL3RmBZUvW0Htmtr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671458; bh=mfkUK
    bqRHMW2V2malRDw95PkAzrMZwEdsecGQXj5oPk=; b=PIHJ914UTmS+TM9i1UBYW
    5c8KhVMrBdFEUVrLBlBeZw/JwsuyX76y6UoIZf6bOYSIcNUoleMGpmqJWEh1n99Z
    sBytO1zjBdcmGB6MWCW5fknw8PkoIS1ODQUzi6eW7z/9Fd6dWGMjNsOzNq5JBLwr
    hYh70OmaghsWbWR70t8UZn+yOBk406caqa7yaUrF05jZEr5ot+JnTvGXgDbXZnkl
    49FZVx0E7jBTJ79bThSi0JVIoPphiNXo5bYyRImiZ2jbh6vrfYh4d4JMGt4Sz/lE
    Y6H3riDm/ZWxjxryFH7MQhVhyAWf2UXGCBNY0QyXhKFMLC7J/BuU/rlaNxzFuD/h
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GT0oREAy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GT0oREAy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIkFSw/C2PBPBszsITN1eUfmbNlpIJ5xx24HufJ6AXeJJFTV1gA4/L5794DA6Uu4Eqf+T03qjHtTijsa/t2I96UgD9JHGA6zKv2TLmI3g+BpSUBk6MWQ
    YiZlpl0EyWEyS69d4F0Xygt2xmIKeDqwz+0kQ52fD6KSpAKPHrL4CGJNB1P9fhboVLPzQ1BNkiQ2LVcleHqkToq3LzQJOspHEOHtu4dPXcJcjvw0Hvbsw9h2
    I2bIulLiexiknjf2L2KeLg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=-7TVv4NQSJcrZsNfVikA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 23/40] jfs: simplify procfs code
Date: Wed, 25 Apr 2018 17:48:10 +0200
Message-Id: <20180425154827.32251-24-hch@lst.de>
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
 fs/jfs/jfs_debug.c    | 43 ++++++++++++++-----------------------------
 fs/jfs/jfs_debug.h    | 10 +++++-----
 fs/jfs/jfs_logmgr.c   | 14 +-------------
 fs/jfs/jfs_metapage.c | 14 +-------------
 fs/jfs/jfs_txnmgr.c   | 28 ++--------------------------
 fs/jfs/jfs_xtree.c    | 14 +-------------
 6 files changed, 24 insertions(+), 99 deletions(-)

diff --git a/fs/jfs/jfs_debug.c b/fs/jfs/jfs_debug.c
index a70907606025..35a5b2a81ae0 100644
--- a/fs/jfs/jfs_debug.c
+++ b/fs/jfs/jfs_debug.c
@@ -29,7 +29,6 @@
 
 #ifdef PROC_FS_JFS /* see jfs_debug.h */
 
-static struct proc_dir_entry *base;
 #ifdef CONFIG_JFS_DEBUG
 static int jfs_loglevel_proc_show(struct seq_file *m, void *v)
 {
@@ -66,43 +65,29 @@ static const struct file_operations jfs_loglevel_proc_fops = {
 };
 #endif
 
-static struct {
-	const char	*name;
-	const struct file_operations *proc_fops;
-} Entries[] = {
-#ifdef CONFIG_JFS_STATISTICS
-	{ "lmstats",	&jfs_lmstats_proc_fops, },
-	{ "txstats",	&jfs_txstats_proc_fops, },
-	{ "xtstat",	&jfs_xtstat_proc_fops, },
-	{ "mpstat",	&jfs_mpstat_proc_fops, },
-#endif
-#ifdef CONFIG_JFS_DEBUG
-	{ "TxAnchor",	&jfs_txanchor_proc_fops, },
-	{ "loglevel",	&jfs_loglevel_proc_fops }
-#endif
-};
-#define NPROCENT	ARRAY_SIZE(Entries)
-
 void jfs_proc_init(void)
 {
-	int i;
+	struct proc_dir_entry *base;
 
-	if (!(base = proc_mkdir("fs/jfs", NULL)))
+	base = proc_mkdir("fs/jfs", NULL);
+	if (!base)
 		return;
 
-	for (i = 0; i < NPROCENT; i++)
-		proc_create(Entries[i].name, 0, base, Entries[i].proc_fops);
+#ifdef CONFIG_JFS_STATISTICS
+	proc_create_single("lmstats", 0, base, jfs_lmstats_proc_show);
+	proc_create_single("txstats", 0, base, jfs_txstats_proc_show);
+	proc_create_single("xtstat", 0, base, jfs_xtstat_proc_show);
+	proc_create_single("mpstat", 0, base, jfs_mpstat_proc_show);
+#endif
+#ifdef CONFIG_JFS_DEBUG
+	proc_create_single("TxAnchor", 0, base, jfs_txanchor_proc_show);
+	proc_create("loglevel", 0, base, &jfs_loglevel_proc_fops);
+#endif
 }
 
 void jfs_proc_clean(void)
 {
-	int i;
-
-	if (base) {
-		for (i = 0; i < NPROCENT; i++)
-			remove_proc_entry(Entries[i].name, base);
-		remove_proc_entry("fs/jfs", NULL);
-	}
+	remove_proc_subtree("fs/jfs", NULL);
 }
 
 #endif /* PROC_FS_JFS */
diff --git a/fs/jfs/jfs_debug.h b/fs/jfs/jfs_debug.h
index eafd1300a00b..0d9e35da8462 100644
--- a/fs/jfs/jfs_debug.h
+++ b/fs/jfs/jfs_debug.h
@@ -62,7 +62,7 @@ extern void jfs_proc_clean(void);
 
 extern int jfsloglevel;
 
-extern const struct file_operations jfs_txanchor_proc_fops;
+int jfs_txanchor_proc_show(struct seq_file *m, void *v);
 
 /* information message: e.g., configuration, major event */
 #define jfs_info(fmt, arg...) do {			\
@@ -105,10 +105,10 @@ extern const struct file_operations jfs_txanchor_proc_fops;
  *	----------
  */
 #ifdef	CONFIG_JFS_STATISTICS
-extern const struct file_operations jfs_lmstats_proc_fops;
-extern const struct file_operations jfs_txstats_proc_fops;
-extern const struct file_operations jfs_mpstat_proc_fops;
-extern const struct file_operations jfs_xtstat_proc_fops;
+int jfs_lmstats_proc_show(struct seq_file *m, void *v);
+int jfs_txstats_proc_show(struct seq_file *m, void *v);
+int jfs_mpstat_proc_show(struct seq_file *m, void *v);
+int jfs_xtstat_proc_show(struct seq_file *m, void *v);
 
 #define	INCREMENT(x)		((x)++)
 #define	DECREMENT(x)		((x)--)
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 0e5d412c0b01..6b68df395892 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2493,7 +2493,7 @@ int lmLogFormat(struct jfs_log *log, s64 logAddress, int logSize)
 }
 
 #ifdef CONFIG_JFS_STATISTICS
-static int jfs_lmstats_proc_show(struct seq_file *m, void *v)
+int jfs_lmstats_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m,
 		       "JFS Logmgr stats\n"
@@ -2510,16 +2510,4 @@ static int jfs_lmstats_proc_show(struct seq_file *m, void *v)
 		       lmStat.partial_page);
 	return 0;
 }
-
-static int jfs_lmstats_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, jfs_lmstats_proc_show, NULL);
-}
-
-const struct file_operations jfs_lmstats_proc_fops = {
-	.open		= jfs_lmstats_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif /* CONFIG_JFS_STATISTICS */
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 1a3b0cc22ad3..fa2c6824c7f2 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -815,7 +815,7 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 }
 
 #ifdef CONFIG_JFS_STATISTICS
-static int jfs_mpstat_proc_show(struct seq_file *m, void *v)
+int jfs_mpstat_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m,
 		       "JFS Metapage statistics\n"
@@ -828,16 +828,4 @@ static int jfs_mpstat_proc_show(struct seq_file *m, void *v)
 		       mpStat.lockwait);
 	return 0;
 }
-
-static int jfs_mpstat_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, jfs_mpstat_proc_show, NULL);
-}
-
-const struct file_operations jfs_mpstat_proc_fops = {
-	.open		= jfs_mpstat_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 4d973524c887..a5663cb621d8 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2998,7 +2998,7 @@ int jfs_sync(void *arg)
 }
 
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_JFS_DEBUG)
-static int jfs_txanchor_proc_show(struct seq_file *m, void *v)
+int jfs_txanchor_proc_show(struct seq_file *m, void *v)
 {
 	char *freewait;
 	char *freelockwait;
@@ -3032,22 +3032,10 @@ static int jfs_txanchor_proc_show(struct seq_file *m, void *v)
 		       list_empty(&TxAnchor.unlock_queue) ? "" : "not ");
 	return 0;
 }
-
-static int jfs_txanchor_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, jfs_txanchor_proc_show, NULL);
-}
-
-const struct file_operations jfs_txanchor_proc_fops = {
-	.open		= jfs_txanchor_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif
 
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_JFS_STATISTICS)
-static int jfs_txstats_proc_show(struct seq_file *m, void *v)
+int jfs_txstats_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m,
 		       "JFS TxStats\n"
@@ -3072,16 +3060,4 @@ static int jfs_txstats_proc_show(struct seq_file *m, void *v)
 		       TxStat.txLockAlloc_freelock);
 	return 0;
 }
-
-static int jfs_txstats_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, jfs_txstats_proc_show, NULL);
-}
-
-const struct file_operations jfs_txstats_proc_fops = {
-	.open		= jfs_txstats_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 5cde6d2fcfca..2c200b5256a6 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -3874,7 +3874,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 }
 
 #ifdef CONFIG_JFS_STATISTICS
-static int jfs_xtstat_proc_show(struct seq_file *m, void *v)
+int jfs_xtstat_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m,
 		       "JFS Xtree statistics\n"
@@ -3887,16 +3887,4 @@ static int jfs_xtstat_proc_show(struct seq_file *m, void *v)
 		       xtStat.split);
 	return 0;
 }
-
-static int jfs_xtstat_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, jfs_xtstat_proc_show, NULL);
-}
-
-const struct file_operations jfs_xtstat_proc_fops = {
-	.open		= jfs_xtstat_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
