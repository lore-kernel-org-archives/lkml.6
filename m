Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526463954-2-2292354089155180010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526463953; b=EMpPBE1K6EWmMmMPnF+d/vGgFVF0aoI5SXbm+vaYsDM0nQvOFU
    DSRQ8WGusRUpIyA9CRrZxokg7jZXO8MMcaPUzfa9IVwUuWmdXmKUIkc2dwRXn77H
    Y4NNOsvXsT2hpNB67GNzxo2M+QYtz1+tKaSfaxNTjP34RXAVkatEQvbtz+bTmlLe
    r20FSJoaxJD4TVWcsE9e2z+DnCstVnFnzYTrPRD+c2YV/kUPepRIviyKdD7aEqG3
    gL9I/Omqxhf8sfIygN/jdPshyMKMI8hX9FAXkXZI+SNpQKnMSvOhExaTVM7Bki6B
    ATSybyqio/WGNShysypJ3XY2J+yV/bGS0YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526463953; bh=+wf2J
    Cl3mtjODNbQ/iFyvPetDwwMewPpQhr3SgIuROw=; b=BkXFg5KaZCOpFlq9+9+P1
    zCVCDdENLOLpf8htzDivNfOwtx+vMnBXewHiOimoo9xJTZTBD3+tDXDkFCYX7wOx
    zWiZyFvu/NmKQKbtI5JOjDNjYBpVJaXZ1uRRGITEeCpAsPN89lLUQMBJWYP8XLCG
    rsFNmwDEiJd9kGDrN9voNPARh1w39zvuEeS9iwOkwuVlI2C6BpWpUxn0+hBn/L2y
    3E7gafbwqwKGfkjECBsK6+a6gGTe9yEMox2knyjKUQBNC2pJ8XgvWXUklH0joIf0
    WmCIa6k+YraAdB8eaUm29Rd8HcYSkr9ZzyO8qtP7sqDAvzKq2I33+YPLmko/mu3A
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=q+ABM8bF
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=q+ABM8bF
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEcHOW79jctvZA3vB3HFZrWv2m/GL69p+PBNWUSFvd6+Gm6FgZSRx4JoqSridrNay7V/vnianP+/7LaeGadNR9blY5pE5ayXmYDLKB0y+9otKM/6FU8j
    u8Y84MpPO63a2YdtgFOArZfBXTGKRcE+F+sJcjyBxfzrj2Dpk6zGBdQHCiqze+RHFrfxsRYZDALltFn2YnKDaZ5iomd5XuF1C/NaL5oUA1pWFKXRnHd4RXOH
    sAnyE6HDdTVT/B9xcO4xGw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=n95adBl39jsrF2XtAlkA:9
    a=GtgUaDJn9VDXrE9T:21 a=WTs7naXo3dHkUyGW:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 22/42] sg: simplify procfs code
Date: Wed, 16 May 2018 11:43:26 +0200
Message-Id: <20180516094346.20506-23-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
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

Also don't bother handling proc_create* failures - the driver works
perfectly fine without the proc files, and the cleanup will handle
missing files gracefully.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sg.c | 124 +++++-----------------------------------------
 1 file changed, 12 insertions(+), 112 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c198b96368dd..8ff687158704 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -66,7 +66,6 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
 static char *sg_version_date = "20140603";
 
 static int sg_proc_init(void);
-static void sg_proc_cleanup(void);
 #endif
 
 #define SG_ALLOW_DIO_DEF 0
@@ -1661,7 +1660,7 @@ static void __exit
 exit_sg(void)
 {
 #ifdef CONFIG_SCSI_PROC_FS
-	sg_proc_cleanup();
+	remove_proc_subtree("scsi/sg", NULL);
 #endif				/* CONFIG_SCSI_PROC_FS */
 	scsi_unregister_interface(&sg_interface);
 	class_destroy(sg_sysfs_class);
@@ -2274,11 +2273,6 @@ sg_get_dev(int dev)
 }
 
 #ifdef CONFIG_SCSI_PROC_FS
-
-static struct proc_dir_entry *sg_proc_sgp = NULL;
-
-static char sg_proc_sg_dirname[] = "scsi/sg";
-
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
 static int sg_proc_single_open_adio(struct inode *inode, struct file *file);
@@ -2306,37 +2300,11 @@ static const struct file_operations dressz_fops = {
 };
 
 static int sg_proc_seq_show_version(struct seq_file *s, void *v);
-static int sg_proc_single_open_version(struct inode *inode, struct file *file);
-static const struct file_operations version_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_single_open_version,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static int sg_proc_seq_show_devhdr(struct seq_file *s, void *v);
-static int sg_proc_single_open_devhdr(struct inode *inode, struct file *file);
-static const struct file_operations devhdr_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_single_open_devhdr,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static int sg_proc_seq_show_dev(struct seq_file *s, void *v);
-static int sg_proc_open_dev(struct inode *inode, struct file *file);
 static void * dev_seq_start(struct seq_file *s, loff_t *pos);
 static void * dev_seq_next(struct seq_file *s, void *v, loff_t *pos);
 static void dev_seq_stop(struct seq_file *s, void *v);
-static const struct file_operations dev_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_open_dev,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
 static const struct seq_operations dev_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
@@ -2345,14 +2313,6 @@ static const struct seq_operations dev_seq_ops = {
 };
 
 static int sg_proc_seq_show_devstrs(struct seq_file *s, void *v);
-static int sg_proc_open_devstrs(struct inode *inode, struct file *file);
-static const struct file_operations devstrs_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_open_devstrs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
 static const struct seq_operations devstrs_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
@@ -2361,14 +2321,6 @@ static const struct seq_operations devstrs_seq_ops = {
 };
 
 static int sg_proc_seq_show_debug(struct seq_file *s, void *v);
-static int sg_proc_open_debug(struct inode *inode, struct file *file);
-static const struct file_operations debug_fops = {
-	.owner = THIS_MODULE,
-	.open = sg_proc_open_debug,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
 static const struct seq_operations debug_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
@@ -2376,50 +2328,23 @@ static const struct seq_operations debug_seq_ops = {
 	.show  = sg_proc_seq_show_debug,
 };
 
-
-struct sg_proc_leaf {
-	const char * name;
-	const struct file_operations * fops;
-};
-
-static const struct sg_proc_leaf sg_proc_leaf_arr[] = {
-	{"allow_dio", &adio_fops},
-	{"debug", &debug_fops},
-	{"def_reserved_size", &dressz_fops},
-	{"device_hdr", &devhdr_fops},
-	{"devices", &dev_fops},
-	{"device_strs", &devstrs_fops},
-	{"version", &version_fops}
-};
-
 static int
 sg_proc_init(void)
 {
-	int num_leaves = ARRAY_SIZE(sg_proc_leaf_arr);
-	int k;
+	struct proc_dir_entry *p;
 
-	sg_proc_sgp = proc_mkdir(sg_proc_sg_dirname, NULL);
-	if (!sg_proc_sgp)
+	p = proc_mkdir("scsi/sg", NULL);
+	if (!p)
 		return 1;
-	for (k = 0; k < num_leaves; ++k) {
-		const struct sg_proc_leaf *leaf = &sg_proc_leaf_arr[k];
-		umode_t mask = leaf->fops->write ? S_IRUGO | S_IWUSR : S_IRUGO;
-		proc_create(leaf->name, mask, sg_proc_sgp, leaf->fops);
-	}
-	return 0;
-}
 
-static void
-sg_proc_cleanup(void)
-{
-	int k;
-	int num_leaves = ARRAY_SIZE(sg_proc_leaf_arr);
-
-	if (!sg_proc_sgp)
-		return;
-	for (k = 0; k < num_leaves; ++k)
-		remove_proc_entry(sg_proc_leaf_arr[k].name, sg_proc_sgp);
-	remove_proc_entry(sg_proc_sg_dirname, NULL);
+	proc_create("allow_dio", S_IRUGO | S_IWUSR, p, &adio_fops);
+	proc_create_seq("debug", S_IRUGO, p, &debug_seq_ops);
+	proc_create("def_reserved_size", S_IRUGO | S_IWUSR, p, &dressz_fops);
+	proc_create_single("device_hdr", S_IRUGO, p, sg_proc_seq_show_devhdr);
+	proc_create_seq("devices", S_IRUGO, p, &dev_seq_ops);
+	proc_create_seq("device_strs", S_IRUGO, p, &devstrs_seq_ops);
+	proc_create_single("version", S_IRUGO, p, sg_proc_seq_show_version);
+	return 0;
 }
 
 
@@ -2482,22 +2407,12 @@ static int sg_proc_seq_show_version(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int sg_proc_single_open_version(struct inode *inode, struct file *file)
-{
-	return single_open(file, sg_proc_seq_show_version, NULL);
-}
-
 static int sg_proc_seq_show_devhdr(struct seq_file *s, void *v)
 {
 	seq_puts(s, "host\tchan\tid\tlun\ttype\topens\tqdepth\tbusy\tonline\n");
 	return 0;
 }
 
-static int sg_proc_single_open_devhdr(struct inode *inode, struct file *file)
-{
-	return single_open(file, sg_proc_seq_show_devhdr, NULL);
-}
-
 struct sg_proc_deviter {
 	loff_t	index;
 	size_t	max;
@@ -2531,11 +2446,6 @@ static void dev_seq_stop(struct seq_file *s, void *v)
 	kfree(s->private);
 }
 
-static int sg_proc_open_dev(struct inode *inode, struct file *file)
-{
-        return seq_open(file, &dev_seq_ops);
-}
-
 static int sg_proc_seq_show_dev(struct seq_file *s, void *v)
 {
 	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
@@ -2562,11 +2472,6 @@ static int sg_proc_seq_show_dev(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int sg_proc_open_devstrs(struct inode *inode, struct file *file)
-{
-        return seq_open(file, &devstrs_seq_ops);
-}
-
 static int sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 {
 	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
@@ -2650,11 +2555,6 @@ static void sg_proc_debug_helper(struct seq_file *s, Sg_device * sdp)
 	}
 }
 
-static int sg_proc_open_debug(struct inode *inode, struct file *file)
-{
-        return seq_open(file, &debug_seq_ops);
-}
-
 static int sg_proc_seq_show_debug(struct seq_file *s, void *v)
 {
 	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
