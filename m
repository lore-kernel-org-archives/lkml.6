Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-90266-1527077838-2-5399515514726056175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527077837; b=Mit3KLctHNphg73nAsJvty7WR+HhdAioJHj3Gpd1SYBj+VRDBZ
    m+5MbMVc0lz4Z/rIp1j49j4dp9+7Djj83N4EZZwkQX7t7ZWCdb3PPV1i2Bzytb7w
    3Yg1ybm131K5p9v8DPgfowuJbWqZ1OB6tEqP8Cru1A//QtVAsvrkqJQUacRFsD3g
    DhW3Z5yFDpYEYnP47Re+cKu7e874pZdADAhUNjiAwdxljbsoS622cq/wZSNcK6NT
    YC6DQ4pp9CCQaoUARfBV70Q5J9Fdb/l2dvKwRGMcuSwuwjUj54IKLUzoF37QVoJv
    9MXRR1x5CHBcbI3K/JV3X4yMiDfOensDQAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527077837;
    bh=yO2d1h7rDn0+H2HZTswvIVuthjbPdFvZ57GYfGDXjyc=; b=bQWuv+RyIgEo
    Wo/+26rwMawevrS75DR+OZNb50V9Lc5hpGOn7fXqCTMkjT/TE7Q7EJmQaCouS6OH
    YeBUdrp3co+O8UTCL+IHOxXlQf4wYR/NpnXM0RvYq9kZ5wzj9H3eeSO8NAeen6bb
    6jHQmUAj1vuFl0tl4NLbspjr5xczccIiAEYnOY9ssdDFP8vRiqsqIxwQzIVuP8rW
    YUd8Qr1/l1l3NS5flY73c/aTsquD3NbukP2h8zO7w4sPzIkn7Ic1M9aqdJwogHX/
    4he3IUVzWmCzw/FiPBoXLq49e2hTzIlCXHJfCw93dAn+vEYHchwFuZaziEV8bd1L
    epfuzS3jFQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLv80ADboO+OrK9RYGtwRLHokrP6HwQoXidfLlCmxGNqb/blq9Fccs5pdjtFQBGzJ3LNmLWX1dLBaz1oWJ0p/yRdBmrvObAJ5hL5/DFEx5LL4X01Ei3a
    6gQdBPo1uHgzvLjdxwjgt/yQqksMLPwNsWEZn0/bjyHiIk1AwdPe5jcYVG6kNCj8EqdETZj7kCclxsOQvhBFvMwGTKPHRVskiun5gKWX+c0D4u4Lrglfl/19
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=-iJ9rt0oNpbPqqwcRxgA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932650AbeEWMRM (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 08:17:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932087AbeEWMRI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 08:17:08 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/8] afs: Rearrange fs/afs/proc.c to remove remaining
 predeclarations.
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:17:06 +0100
Message-ID: <152707782679.27887.7071602765331014280.stgit@warthog.procyon.org.uk>
In-Reply-To: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
References: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rearrange fs/afs/proc.c to get rid of all the remaining predeclarations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |  352 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 160 insertions(+), 192 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index b20098b7b7ee..b45ee7576aa8 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -27,72 +27,8 @@ static inline struct afs_net *afs_seq2net(struct seq_file *m)
 	return &__afs_net; // TODO: use seq_file_net(m)
 }
 
-static void *afs_proc_cells_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_cells_next(struct seq_file *p, void *v, loff_t *pos);
-static void afs_proc_cells_stop(struct seq_file *p, void *v);
-static int afs_proc_cells_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_cells_ops = {
-	.start	= afs_proc_cells_start,
-	.next	= afs_proc_cells_next,
-	.stop	= afs_proc_cells_stop,
-	.show	= afs_proc_cells_show,
-};
-
-static void *afs_proc_cell_volumes_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
-					loff_t *pos);
-static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v);
-static int afs_proc_cell_volumes_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_cell_volumes_ops = {
-	.start	= afs_proc_cell_volumes_start,
-	.next	= afs_proc_cell_volumes_next,
-	.stop	= afs_proc_cell_volumes_stop,
-	.show	= afs_proc_cell_volumes_show,
-};
-
-static void *afs_proc_cell_vlservers_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
-					  loff_t *pos);
-static void afs_proc_cell_vlservers_stop(struct seq_file *p, void *v);
-static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_cell_vlservers_ops = {
-	.start	= afs_proc_cell_vlservers_start,
-	.next	= afs_proc_cell_vlservers_next,
-	.stop	= afs_proc_cell_vlservers_stop,
-	.show	= afs_proc_cell_vlservers_show,
-};
-
-static void *afs_proc_servers_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_servers_next(struct seq_file *p, void *v,
-					loff_t *pos);
-static void afs_proc_servers_stop(struct seq_file *p, void *v);
-static int afs_proc_servers_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_servers_ops = {
-	.start	= afs_proc_servers_start,
-	.next	= afs_proc_servers_next,
-	.stop	= afs_proc_servers_stop,
-	.show	= afs_proc_servers_show,
-};
-
-static void *afs_proc_sysname_start(struct seq_file *p, loff_t *pos);
-static void *afs_proc_sysname_next(struct seq_file *p, void *v,
-					loff_t *pos);
-static void afs_proc_sysname_stop(struct seq_file *p, void *v);
-static int afs_proc_sysname_show(struct seq_file *m, void *v);
-
-static const struct seq_operations afs_proc_sysname_ops = {
-	.start	= afs_proc_sysname_start,
-	.next	= afs_proc_sysname_next,
-	.stop	= afs_proc_sysname_stop,
-	.show	= afs_proc_sysname_show,
-};
-
 /*
- * display a header line followed by a load of cell lines
+ * Display the list of cells known to the namespace.
  */
 static int afs_proc_cells_show(struct seq_file *m, void *v)
 {
@@ -110,38 +46,31 @@ static int afs_proc_cells_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-/*
- * set up the iterator to start reading from the cells list and return the
- * first item
- */
 static void *afs_proc_cells_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
-	struct afs_net *net = afs_seq2net(m);
-
 	rcu_read_lock();
-	return seq_list_start_head(&net->proc_cells, *_pos);
+	return seq_list_start_head(&afs_seq2net(m)->proc_cells, *_pos);
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_cells_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct afs_net *net = afs_seq2net(m);
-
-	return seq_list_next(v, &net->proc_cells, pos);
+	return seq_list_next(v, &afs_seq2net(m)->proc_cells, pos);
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_cells_stop(struct seq_file *m, void *v)
 	__releases(rcu)
 {
 	rcu_read_unlock();
 }
 
+static const struct seq_operations afs_proc_cells_ops = {
+	.start	= afs_proc_cells_start,
+	.next	= afs_proc_cells_next,
+	.stop	= afs_proc_cells_stop,
+	.show	= afs_proc_cells_show,
+};
+
 /*
  * handle writes to /proc/fs/afs/cells
  * - to add cells: echo "add <cellname> <IP>[:<IP>][:<IP>]"
@@ -230,6 +159,9 @@ static const struct file_operations afs_proc_cells_fops = {
 	.release	= seq_release,
 };
 
+/*
+ * Read the name of the current workstation cell.
+ */
 static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
 				      size_t size, loff_t *_pos)
 {
@@ -270,8 +202,10 @@ static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
 }
 
 /*
- * handle writes to /proc/fs/afs/rootcell
- * - to initialize rootcell: echo "cell.name:192.168.231.14"
+ * Set the current workstation cell and optionally supply its list of volume
+ * location servers.
+ *
+ *	echo "cell.name:192.168.231.14" >/proc/fs/afs/rootcell
  */
 static ssize_t afs_proc_rootcell_write(struct file *file,
 				       const char __user *buf,
@@ -326,7 +260,7 @@ static const char afs_vol_types[3][3] = {
 };
 
 /*
- * display a header line followed by a load of volume lines
+ * Display the list of volumes known to a cell.
  */
 static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 {
@@ -346,36 +280,23 @@ static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-/*
- * set up the iterator to start reading from the cells list and return the
- * first item
- */
 static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
 	__acquires(cell->proc_lock)
 {
 	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
 
-	_enter("cell=%p pos=%Ld", cell, *_pos);
-
 	read_lock(&cell->proc_lock);
 	return seq_list_start_head(&cell->proc_volumes, *_pos);
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
 					loff_t *_pos)
 {
 	struct afs_cell *cell = PDE_DATA(file_inode(p->file));
 
-	_enter("cell=%p pos=%Ld", cell, *_pos);
 	return seq_list_next(v, &cell->proc_volumes, _pos);
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
 	__releases(cell->proc_lock)
 {
@@ -384,8 +305,15 @@ static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
 	read_unlock(&cell->proc_lock);
 }
 
+static const struct seq_operations afs_proc_cell_volumes_ops = {
+	.start	= afs_proc_cell_volumes_start,
+	.next	= afs_proc_cell_volumes_next,
+	.stop	= afs_proc_cell_volumes_stop,
+	.show	= afs_proc_cell_volumes_show,
+};
+
 /*
- * display a header line followed by a load of volume lines
+ * Display the list of Volume Location servers we're using for a cell.
  */
 static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 {
@@ -402,10 +330,6 @@ static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-/*
- * set up the iterator to start reading from the cells list and return the
- * first item
- */
 static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
@@ -428,9 +352,6 @@ static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 	return alist->addrs + pos;
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
 					  loff_t *_pos)
 {
@@ -448,17 +369,48 @@ static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
 	return alist->addrs + pos;
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_cell_vlservers_stop(struct seq_file *p, void *v)
 	__releases(rcu)
 {
 	rcu_read_unlock();
 }
 
+static const struct seq_operations afs_proc_cell_vlservers_ops = {
+	.start	= afs_proc_cell_vlservers_start,
+	.next	= afs_proc_cell_vlservers_next,
+	.stop	= afs_proc_cell_vlservers_stop,
+	.show	= afs_proc_cell_vlservers_show,
+};
+
+static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
+{
+	struct afs_cell *cell;
+	struct seq_file *m;
+	int ret;
+
+	cell = PDE_DATA(inode);
+	if (!cell)
+		return -ENOENT;
+
+	ret = seq_open(file, &afs_proc_cell_vlservers_ops);
+	if (ret<0)
+		return ret;
+
+	m = file->private_data;
+	m->private = cell;
+
+	return 0;
+}
+
+static const struct file_operations afs_proc_cell_vlservers_fops = {
+	.open		= afs_proc_cell_vlservers_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /*
- * display a header line followed by a load of volume lines
+ * Display the list of fileservers we're using within a namespace.
  */
 static int afs_proc_servers_show(struct seq_file *m, void *v)
 {
@@ -479,82 +431,99 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-/*
- * Set up the iterator to start reading from the server list and return the
- * first item.
- */
 static void *afs_proc_servers_start(struct seq_file *m, loff_t *_pos)
 	__acquires(rcu)
 {
-	struct afs_net *net = afs_seq2net(m);
-
 	rcu_read_lock();
-	return seq_hlist_start_head_rcu(&net->fs_proc, *_pos);
+	return seq_hlist_start_head_rcu(&afs_seq2net(m)->fs_proc, *_pos);
 }
 
-/*
- * move to next cell in cells list
- */
 static void *afs_proc_servers_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct afs_net *net = afs_seq2net(m);
-
-	return seq_hlist_next_rcu(v, &net->fs_proc, _pos);
+	return seq_hlist_next_rcu(v, &afs_seq2net(m)->fs_proc, _pos);
 }
 
-/*
- * clean up after reading from the cells list
- */
 static void afs_proc_servers_stop(struct seq_file *p, void *v)
 	__releases(rcu)
 {
 	rcu_read_unlock();
 }
 
-void afs_put_sysnames(struct afs_sysnames *sysnames)
-{
-	int i;
+static const struct seq_operations afs_proc_servers_ops = {
+	.start	= afs_proc_servers_start,
+	.next	= afs_proc_servers_next,
+	.stop	= afs_proc_servers_stop,
+	.show	= afs_proc_servers_show,
+};
 
-	if (sysnames && refcount_dec_and_test(&sysnames->usage)) {
-		for (i = 0; i < sysnames->nr; i++)
-			if (sysnames->subs[i] != afs_init_sysname &&
-			    sysnames->subs[i] != sysnames->blank)
-				kfree(sysnames->subs[i]);
-	}
+static int afs_proc_servers_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &afs_proc_servers_ops);
 }
 
+static const struct file_operations afs_proc_servers_fops = {
+	.open		= afs_proc_servers_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /*
- * Handle opening of /proc/fs/afs/sysname.  If it is opened for writing, we
- * assume the caller wants to change the substitution list and we allocate a
- * buffer to hold the list.
+ * Display the list of strings that may be substituted for the @sys pathname
+ * macro.
  */
-static int afs_proc_sysname_open(struct inode *inode, struct file *file)
+static int afs_proc_sysname_show(struct seq_file *m, void *v)
 {
-	struct afs_sysnames *sysnames;
-	struct seq_file *m;
-	int ret;
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *sysnames = net->sysnames;
+	unsigned int i = (unsigned long)v - 1;
 
-	ret = seq_open(file, &afs_proc_sysname_ops);
-	if (ret < 0)
-		return ret;
+	if (i < sysnames->nr)
+		seq_printf(m, "%s\n", sysnames->subs[i]);
+	return 0;
+}
 
-	if (file->f_mode & FMODE_WRITE) {
-		sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
-		if (!sysnames) {
-			seq_release(inode, file);
-			return -ENOMEM;
-		}
+static void *afs_proc_sysname_start(struct seq_file *m, loff_t *pos)
+	__acquires(&net->sysnames_lock)
+{
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *names = net->sysnames;
 
-		refcount_set(&sysnames->usage, 1);
-		m = file->private_data;
-		m->private = sysnames;
-	}
+	read_lock(&net->sysnames_lock);
 
-	return 0;
+	if (*pos >= names->nr)
+		return NULL;
+	return (void *)(unsigned long)(*pos + 1);
+}
+
+static void *afs_proc_sysname_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct afs_net *net = afs_seq2net(m);
+	struct afs_sysnames *names = net->sysnames;
+
+	*pos += 1;
+	if (*pos >= names->nr)
+		return NULL;
+	return (void *)(unsigned long)(*pos + 1);
+}
+
+static void afs_proc_sysname_stop(struct seq_file *m, void *v)
+	__releases(&net->sysnames_lock)
+{
+	struct afs_net *net = afs_seq2net(m);
+
+	read_unlock(&net->sysnames_lock);
 }
 
+static const struct seq_operations afs_proc_sysname_ops = {
+	.start	= afs_proc_sysname_start,
+	.next	= afs_proc_sysname_next,
+	.stop	= afs_proc_sysname_stop,
+	.show	= afs_proc_sysname_show,
+};
+
 /*
- * Handle writes to /proc/fs/afs/sysname to set the @sys substitution.
+ * Allow the @sys substitution to be configured.
  */
 static ssize_t afs_proc_sysname_write(struct file *file,
 				      const char __user *buf,
@@ -638,6 +607,18 @@ static ssize_t afs_proc_sysname_write(struct file *file,
 	goto out;
 }
 
+void afs_put_sysnames(struct afs_sysnames *sysnames)
+{
+	int i;
+
+	if (sysnames && refcount_dec_and_test(&sysnames->usage)) {
+		for (i = 0; i < sysnames->nr; i++)
+			if (sysnames->subs[i] != afs_init_sysname &&
+			    sysnames->subs[i] != sysnames->blank)
+				kfree(sysnames->subs[i]);
+	}
+}
+
 static int afs_proc_sysname_release(struct inode *inode, struct file *file)
 {
 	struct afs_sysnames *sysnames, *kill = NULL;
@@ -663,47 +644,34 @@ static int afs_proc_sysname_release(struct inode *inode, struct file *file)
 	return seq_release(inode, file);
 }
 
-static int afs_proc_sysname_show(struct seq_file *m, void *v)
-{
-	struct afs_net *net = afs_seq2net(m);
-	struct afs_sysnames *sysnames = net->sysnames;
-	unsigned int i = (unsigned long)v - 1;
-
-	if (i < sysnames->nr)
-		seq_printf(m, "%s\n", sysnames->subs[i]);
-	return 0;
-}
-
-static void *afs_proc_sysname_start(struct seq_file *m, loff_t *pos)
-	__acquires(&net->sysnames_lock)
+/*
+ * Handle opening of /proc/fs/afs/sysname.  If it is opened for writing, we
+ * assume the caller wants to change the substitution list and we allocate a
+ * buffer to hold the list.
+ */
+static int afs_proc_sysname_open(struct inode *inode, struct file *file)
 {
-	struct afs_net *net = afs_seq2net(m);
-	struct afs_sysnames *names = net->sysnames;
-
-	read_lock(&net->sysnames_lock);
-
-	if (*pos >= names->nr)
-		return NULL;
-	return (void *)(unsigned long)(*pos + 1);
-}
+	struct afs_sysnames *sysnames;
+	struct seq_file *m;
+	int ret;
 
-static void *afs_proc_sysname_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct afs_net *net = afs_seq2net(m);
-	struct afs_sysnames *names = net->sysnames;
+	ret = seq_open(file, &afs_proc_sysname_ops);
+	if (ret < 0)
+		return ret;
 
-	*pos += 1;
-	if (*pos >= names->nr)
-		return NULL;
-	return (void *)(unsigned long)(*pos + 1);
-}
+	if (file->f_mode & FMODE_WRITE) {
+		sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
+		if (!sysnames) {
+			seq_release(inode, file);
+			return -ENOMEM;
+		}
 
-static void afs_proc_sysname_stop(struct seq_file *m, void *v)
-	__releases(&net->sysnames_lock)
-{
-	struct afs_net *net = afs_seq2net(m);
+		refcount_set(&sysnames->usage, 1);
+		m = file->private_data;
+		m->private = sysnames;
+	}
 
-	read_unlock(&net->sysnames_lock);
+	return 0;
 }
 
 static const struct file_operations afs_proc_sysname_fops = {
