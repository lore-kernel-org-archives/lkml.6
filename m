Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671463-2-4141688904425623601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671462; b=Ltj+BuFPDUDKa3s1la/DLwWsjjujnSmr9qvF4h+yJKf+5tA0vc
    mRMfftNPj7IGBU3cXcJ35m68T4amUn94R08gzy4wIfbplsTzUDGf1ik9erUB+Bvk
    YqGv8W0eULn6UDYxrAH32AlPtpE6x3YkOqobTjb9pVhAjTmLvz+BwTLWuzXOxPFy
    NRYzvHBjaGoI1vF3KhJyvJyNRFI8ZBXJbbKds9KrhlYZl/Zje/M/asu3ghFvijfC
    SBjCV84Uma7V6l4JQLE2VhjMGix/1xr+TgjCWqQfyZ+vw9TCQoNrcl5vWeDfV8ae
    OBB/1wnmkpgb0t6jPZYGpyVRQsM2+gaXDQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671462; bh=EnrS2
    QiryAyYtBptWN8xARpHIzoZBmJt8J66YpjpZ9M=; b=Uak5bOv9eC5ZZhSUyOOh+
    OehDvzWUqntzj2ueyu8ls85uBCN+PU6n9Lboyoo9RhSPCgNo/2HiQFebC9YKrofx
    06f7MLpYh0nH8WcOg288NXzQ6afy1zwQBMipzhsbmGiCZalDBFMhDtsoWKv6iWXd
    SJf/aS45zJd0e41fhCincVPrI4LS2srUFR7rZ6YZrEZgvjAoIiMDAlEHn5P/+4de
    B3rHBbHWHcNFgsyrPzMzB4D6ITtut4yOxsBSkEUgAdMIsR3NvbIHXzwUFs/eU8lf
    gFMHumT3+rRihr0PE8D7qxNEGnvCd9oznwRC5r0GbYWGt5hp0UHI6gW96BD9vOxW
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=JQihAz1b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=JQihAz1b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfG3XxAUv51J9uEGFeje/jPWbFroY/NrWoSDInnPiqjoQjMosRvVnGWrvrRjuPZIFcPfNMtw8vGKebBZYaqYuDqbn1FxyWHgMSfnbIf63/FkCjZcrQ4Kg
    QIeYSGgbwYwXjJXwkSCBYjMOvG3PhtgetJNTHSOsVfoxkTa1lC9TKWq6Vr4c7/flqrqabpGaZLRGbot0IWD/aSrh+Eg+Sugtr6l/VhwM2owob8GcPMi7aoGy
    cNmNPFGyNTJkJI3Qsq8pSA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=7-VHn9h51eMD-OB7GYIA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 21/40] afs: simplify procfs code
Date: Wed, 25 Apr 2018 17:48:08 +0200
Message-Id: <20180425154827.32251-22-hch@lst.de>
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
 fs/afs/proc.c | 134 ++++++--------------------------------------------
 1 file changed, 15 insertions(+), 119 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 839a22280606..3aad32762989 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -62,7 +62,6 @@ static const struct file_operations afs_proc_rootcell_fops = {
 	.llseek		= no_llseek,
 };
 
-static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file);
 static void *afs_proc_cell_volumes_start(struct seq_file *p, loff_t *pos);
 static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
 					loff_t *pos);
@@ -76,15 +75,6 @@ static const struct seq_operations afs_proc_cell_volumes_ops = {
 	.show	= afs_proc_cell_volumes_show,
 };
 
-static const struct file_operations afs_proc_cell_volumes_fops = {
-	.open		= afs_proc_cell_volumes_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static int afs_proc_cell_vlservers_open(struct inode *inode,
-					struct file *file);
 static void *afs_proc_cell_vlservers_start(struct seq_file *p, loff_t *pos);
 static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
 					  loff_t *pos);
@@ -98,14 +88,6 @@ static const struct seq_operations afs_proc_cell_vlservers_ops = {
 	.show	= afs_proc_cell_vlservers_show,
 };
 
-static const struct file_operations afs_proc_cell_vlservers_fops = {
-	.open		= afs_proc_cell_vlservers_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static int afs_proc_servers_open(struct inode *inode, struct file *file);
 static void *afs_proc_servers_start(struct seq_file *p, loff_t *pos);
 static void *afs_proc_servers_next(struct seq_file *p, void *v,
 					loff_t *pos);
@@ -119,13 +101,6 @@ static const struct seq_operations afs_proc_servers_ops = {
 	.show	= afs_proc_servers_show,
 };
 
-static const struct file_operations afs_proc_servers_fops = {
-	.open		= afs_proc_servers_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int afs_proc_sysname_open(struct inode *inode, struct file *file);
 static int afs_proc_sysname_release(struct inode *inode, struct file *file);
 static void *afs_proc_sysname_start(struct seq_file *p, loff_t *pos);
@@ -152,7 +127,7 @@ static const struct file_operations afs_proc_sysname_fops = {
 	.write		= afs_proc_sysname_write,
 };
 
-static const struct file_operations afs_proc_stats_fops;
+static int afs_proc_stats_show(struct seq_file *m, void *v);
 
 /*
  * initialise the /proc/fs/afs/ directory
@@ -167,8 +142,8 @@ int afs_proc_init(struct afs_net *net)
 
 	if (!proc_create("cells", 0644, net->proc_afs, &afs_proc_cells_fops) ||
 	    !proc_create("rootcell", 0644, net->proc_afs, &afs_proc_rootcell_fops) ||
-	    !proc_create("servers", 0644, net->proc_afs, &afs_proc_servers_fops) ||
-	    !proc_create("stats", 0644, net->proc_afs, &afs_proc_stats_fops) ||
+	    !proc_create_seq("servers", 0644, net->proc_afs, &afs_proc_servers_ops) ||
+	    !proc_create_single("stats", 0644, net->proc_afs, afs_proc_stats_show) ||
 	    !proc_create("sysname", 0644, net->proc_afs, &afs_proc_sysname_fops))
 		goto error_tree;
 
@@ -196,16 +171,7 @@ void afs_proc_cleanup(struct afs_net *net)
  */
 static int afs_proc_cells_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *m;
-	int ret;
-
-	ret = seq_open(file, &afs_proc_cells_ops);
-	if (ret < 0)
-		return ret;
-
-	m = file->private_data;
-	m->private = PDE_DATA(inode);
-	return 0;
+	return seq_open(file, &afs_proc_cells_ops);
 }
 
 /*
@@ -430,10 +396,11 @@ int afs_proc_cell_setup(struct afs_net *net, struct afs_cell *cell)
 	if (!dir)
 		goto error_dir;
 
-	if (!proc_create_data("vlservers", 0, dir,
-			      &afs_proc_cell_vlservers_fops, cell) ||
-	    !proc_create_data("volumes", 0, dir,
-			      &afs_proc_cell_volumes_fops, cell))
+	if (!proc_create_seq_data("vlservers", 0, dir,
+			&afs_proc_cell_vlservers_ops, cell))
+		goto error_tree;
+	if (!proc_create_seq_data("volumes", 0, dir, &afs_proc_cell_volumes_ops,
+			cell))
 		goto error_tree;
 
 	_leave(" = 0");
@@ -458,29 +425,6 @@ void afs_proc_cell_remove(struct afs_net *net, struct afs_cell *cell)
 	_leave("");
 }
 
-/*
- * open "/proc/fs/afs/<cell>/volumes" which provides a summary of extant cells
- */
-static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file)
-{
-	struct afs_cell *cell;
-	struct seq_file *m;
-	int ret;
-
-	cell = PDE_DATA(inode);
-	if (!cell)
-		return -ENOENT;
-
-	ret = seq_open(file, &afs_proc_cell_volumes_ops);
-	if (ret < 0)
-		return ret;
-
-	m = file->private_data;
-	m->private = cell;
-
-	return 0;
-}
-
 /*
  * set up the iterator to start reading from the cells list and return the
  * first item
@@ -488,7 +432,7 @@ static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file)
 static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
 	__acquires(cell->proc_lock)
 {
-	struct afs_cell *cell = m->private;
+	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
 
 	_enter("cell=%p pos=%Ld", cell, *_pos);
 
@@ -502,7 +446,7 @@ static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
 static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
 					loff_t *_pos)
 {
-	struct afs_cell *cell = p->private;
+	struct afs_cell *cell = PDE_DATA(file_inode(p->file));
 
 	_enter("cell=%p pos=%Ld", cell, *_pos);
 	return seq_list_next(v, &cell->proc_volumes, _pos);
@@ -514,7 +458,7 @@ static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
 static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
 	__releases(cell->proc_lock)
 {
-	struct afs_cell *cell = p->private;
+	struct afs_cell *cell = PDE_DATA(file_inode(p->file));
 
 	read_unlock(&cell->proc_lock);
 }
@@ -530,7 +474,7 @@ static const char afs_vol_types[3][3] = {
  */
 static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 {
-	struct afs_cell *cell = m->private;
+	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
 	struct afs_volume *vol = list_entry(v, struct afs_volume, proc_link);
 
 	/* Display header on line 1 */
@@ -546,30 +490,6 @@ static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-/*
- * open "/proc/fs/afs/<cell>/vlservers" which provides a list of volume
- * location server
- */
-static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
-{
-	struct afs_cell *cell;
-	struct seq_file *m;
-	int ret;
-
-	cell = PDE_DATA(inode);
-	if (!cell)
-		return -ENOENT;
-
-	ret = seq_open(file, &afs_proc_cell_vlservers_ops);
-	if (ret<0)
-		return ret;
-
-	m = file->private_data;
-	m->private = cell;
-
-	return 0;
-}
-
 /*
  * set up the iterator to start reading from the cells list and return the
  * first item
@@ -578,7 +498,7 @@ static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
 	struct afs_addr_list *alist;
-	struct afs_cell *cell = m->private;
+	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
 	loff_t pos = *_pos;
 
 	rcu_read_lock();
@@ -603,7 +523,7 @@ static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
 					  loff_t *_pos)
 {
 	struct afs_addr_list *alist;
-	struct afs_cell *cell = p->private;
+	struct afs_cell *cell = PDE_DATA(file_inode(p->file));
 	loff_t pos;
 
 	alist = rcu_dereference(cell->vl_addrs);
@@ -643,15 +563,6 @@ static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-/*
- * open "/proc/fs/afs/servers" which provides a summary of active
- * servers
- */
-static int afs_proc_servers_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &afs_proc_servers_ops);
-}
-
 /*
  * Set up the iterator to start reading from the server list and return the
  * first item.
@@ -931,18 +842,3 @@ static int afs_proc_stats_show(struct seq_file *m, void *v)
 		   atomic_long_read(&net->n_store_bytes));
 	return 0;
 }
-
-/*
- * Open "/proc/fs/afs/stats" to allow reading of the stat counters.
- */
-static int afs_proc_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, afs_proc_stats_show, NULL);
-}
-
-static const struct file_operations afs_proc_stats_fops = {
-	.open		= afs_proc_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release        = single_release,
-};
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
