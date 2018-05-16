Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526463953-2-6456222408925083591
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526463953; b=DAVR3VIGbanUNt/epScAT7zFiwv+R55VzNy9yoRNP0nBy8k0YG
    vVWUGxXAy61WntiCOz1/HXkZ57dLooEedWwLn+1S5yetgQGCirkV0cjWqVp0Se8D
    hkb77kQeFBAjc71VwY29U3zVFOcH40ekMbn/mto4kgCl7mST4kf+KNdn1xZ6Jdzr
    omE3iDK3hXAvYuz0uKPKXQKrbcL9J0a8DigXWw8TWjcUQMjL4XNglwJMnsGzIZPu
    R4P0YLJqSyojb0/3D8yluJ60yhmsCccPFrqQgZ06gjL/vc+3KlC/+4ImaeFhOANk
    rpq0N1ZiKY/n9TslM2pMxpULw5mHfnr8o+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526463953; bh=TkQ2X
    UpuDgKoRc41XvYqKgLYIemR2cZSe3F6+4q7EE4=; b=jHgOcBH9W6//wAbcX9JnT
    qx5Y22S4R7jOTdCoAOw+eNV2Iz3zXdDO6aFyBHw/CZ0xlOQS/8KTxTOErAuPz8fQ
    c+ZclSoY9rHUsZ0eAY/sBdUdBZ4l1NH+ZX2ZBUqtldVmH4EvaVGDqHMqTrZcKNsa
    KgD6o/eFE678x5PrGQ8lBAotnxIS28C4F6uZMllgGQjRw66EH/iwHSZgD8M28gm6
    yh/j7FgSiQOa1mJSywEkUUbsO1/5OQ+LvHmTgvgezHCbqLzIhQd5DmUMS0B1EFfL
    Uekybpr1aRmXA2jmLUVerK/4Yh51GkC1PO7JUnkTE9ZbuL5SyaiKIKBEmT4OUczd
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=B5NLp8bT
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=B5NLp8bT
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFB0ya7DIrX/fwJLnGgSTO4ogzQiRawAABOC8mtjO6qblie49L7MRMFdcPGuRqHw7kH1jOQwUR3OIs1N/zSCVHpXrHruhy7TgjI+7NMzN34XDGEaaHzr
    NNgGVOyJtWteYzSr9fK1D21w7oB7N0COCL9VskPxs9PSjpS+p4MhYNli0OY4S8lvAy4VwVXVED4zxm9jf/HUxpcJ6kLaBYHCvqc2iWWI5L50HabzmoYobgGi
    sCiBRtdehRM7mjxghcRFww==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=c5d4c0_zl500DmvltOAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 21/42] megaraid: simplify procfs code
Date: Wed, 16 May 2018 11:43:25 +0200
Message-Id: <20180516094346.20506-22-hch@lst.de>
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
proc_create_single.

Also don't bother handling proc_create* failures - the driver works
perfectly fine without the proc files, and the cleanup will handle
missing files gracefully.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/megaraid.c | 140 +++++++++++-----------------------------
 drivers/scsi/megaraid.h |  12 ----
 2 files changed, 36 insertions(+), 116 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 7195cff51d4c..91f5e2c68dbc 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -2731,53 +2731,6 @@ proc_show_rdrv_40(struct seq_file *m, void *v)
 	return proc_show_rdrv(m, m->private, 30, 39);
 }
 
-
-/*
- * seq_file wrappers for procfile show routines.
- */
-static int mega_proc_open(struct inode *inode, struct file *file)
-{
-	adapter_t *adapter = proc_get_parent_data(inode);
-	int (*show)(struct seq_file *, void *) = PDE_DATA(inode);
-
-	return single_open(file, show, adapter);
-}
-
-static const struct file_operations mega_proc_fops = {
-	.open		= mega_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-/*
- * Table of proc files we need to create.
- */
-struct mega_proc_file {
-	const char *name;
-	unsigned short ptr_offset;
-	int (*show) (struct seq_file *m, void *v);
-};
-
-static const struct mega_proc_file mega_proc_files[] = {
-	{ "config",	      offsetof(adapter_t, proc_read), proc_show_config },
-	{ "stat",	      offsetof(adapter_t, proc_stat), proc_show_stat },
-	{ "mailbox",	      offsetof(adapter_t, proc_mbox), proc_show_mbox },
-#if MEGA_HAVE_ENH_PROC
-	{ "rebuild-rate",     offsetof(adapter_t, proc_rr), proc_show_rebuild_rate },
-	{ "battery-status",   offsetof(adapter_t, proc_battery), proc_show_battery },
-	{ "diskdrives-ch0",   offsetof(adapter_t, proc_pdrvstat[0]), proc_show_pdrv_ch0 },
-	{ "diskdrives-ch1",   offsetof(adapter_t, proc_pdrvstat[1]), proc_show_pdrv_ch1 },
-	{ "diskdrives-ch2",   offsetof(adapter_t, proc_pdrvstat[2]), proc_show_pdrv_ch2 },
-	{ "diskdrives-ch3",   offsetof(adapter_t, proc_pdrvstat[3]), proc_show_pdrv_ch3 },
-	{ "raiddrives-0-9",   offsetof(adapter_t, proc_rdrvstat[0]), proc_show_rdrv_10 },
-	{ "raiddrives-10-19", offsetof(adapter_t, proc_rdrvstat[1]), proc_show_rdrv_20 },
-	{ "raiddrives-20-29", offsetof(adapter_t, proc_rdrvstat[2]), proc_show_rdrv_30 },
-	{ "raiddrives-30-39", offsetof(adapter_t, proc_rdrvstat[3]), proc_show_rdrv_40 },
-#endif
-	{ NULL }
-};
-
 /**
  * mega_create_proc_entry()
  * @index - index in soft state array
@@ -2788,31 +2741,45 @@ static const struct mega_proc_file mega_proc_files[] = {
 static void
 mega_create_proc_entry(int index, struct proc_dir_entry *parent)
 {
-	const struct mega_proc_file *f;
-	adapter_t	*adapter = hba_soft_state[index];
-	struct proc_dir_entry	*dir, *de, **ppde;
-	u8		string[16];
+	adapter_t *adapter = hba_soft_state[index];
+	struct proc_dir_entry *dir;
+	u8 string[16];
 
 	sprintf(string, "hba%d", adapter->host->host_no);
-
-	dir = adapter->controller_proc_dir_entry =
-		proc_mkdir_data(string, 0, parent, adapter);
-	if(!dir) {
+	dir = proc_mkdir_data(string, 0, parent, adapter);
+	if (!dir) {
 		dev_warn(&adapter->dev->dev, "proc_mkdir failed\n");
 		return;
 	}
 
-	for (f = mega_proc_files; f->name; f++) {
-		de = proc_create_data(f->name, S_IRUSR, dir, &mega_proc_fops,
-				      f->show);
-		if (!de) {
-			dev_warn(&adapter->dev->dev, "proc_create failed\n");
-			return;
-		}
-
-		ppde = (void *)adapter + f->ptr_offset;
-		*ppde = de;
-	}
+	proc_create_single_data("config", S_IRUSR, dir,
+			proc_show_config, adapter);
+	proc_create_single_data("stat", S_IRUSR, dir,
+			proc_show_stat, adapter);
+	proc_create_single_data("mailbox", S_IRUSR, dir,
+			proc_show_mbox, adapter);
+#if MEGA_HAVE_ENH_PROC
+	proc_create_single_data("rebuild-rate", S_IRUSR, dir,
+			proc_show_rebuild_rate, adapter);
+	proc_create_single_data("battery-status", S_IRUSR, dir,
+			proc_show_battery, adapter);
+	proc_create_single_data("diskdrives-ch0", S_IRUSR, dir,
+			proc_show_pdrv_ch0, adapter);
+	proc_create_single_data("diskdrives-ch1", S_IRUSR, dir,
+			proc_show_pdrv_ch1, adapter);
+	proc_create_single_data("diskdrives-ch2", S_IRUSR, dir,
+			proc_show_pdrv_ch2, adapter);
+	proc_create_single_data("diskdrives-ch3", S_IRUSR, dir,
+			proc_show_pdrv_ch3, adapter);
+	proc_create_single_data("raiddrives-0-9", S_IRUSR, dir,
+			proc_show_rdrv_10, adapter);
+	proc_create_single_data("raiddrives-10-19", S_IRUSR, dir,
+			proc_show_rdrv_20, adapter);
+	proc_create_single_data("raiddrives-20-29", S_IRUSR, dir,
+			proc_show_rdrv_30, adapter);
+	proc_create_single_data("raiddrives-30-39", S_IRUSR, dir,
+			proc_show_rdrv_40, adapter);
+#endif
 }
 
 #else
@@ -4580,6 +4547,7 @@ megaraid_remove_one(struct pci_dev *pdev)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	adapter_t *adapter = (adapter_t *)host->hostdata;
+	char buf[12] = { 0 };
 
 	scsi_remove_host(host);
 
@@ -4594,44 +4562,8 @@ megaraid_remove_one(struct pci_dev *pdev)
 
 	mega_free_sgl(adapter);
 
-#ifdef CONFIG_PROC_FS
-	if (adapter->controller_proc_dir_entry) {
-		remove_proc_entry("stat", adapter->controller_proc_dir_entry);
-		remove_proc_entry("config",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("mailbox",
-				adapter->controller_proc_dir_entry);
-#if MEGA_HAVE_ENH_PROC
-		remove_proc_entry("rebuild-rate",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("battery-status",
-				adapter->controller_proc_dir_entry);
-
-		remove_proc_entry("diskdrives-ch0",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch1",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch2",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch3",
-				adapter->controller_proc_dir_entry);
-
-		remove_proc_entry("raiddrives-0-9",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-10-19",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-20-29",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-30-39",
-				adapter->controller_proc_dir_entry);
-#endif
-		{
-			char	buf[12] = { 0 };
-			sprintf(buf, "hba%d", adapter->host->host_no);
-			remove_proc_entry(buf, mega_proc_dir_entry);
-		}
-	}
-#endif
+	sprintf(buf, "hba%d", adapter->host->host_no);
+	remove_proc_subtree(buf, mega_proc_dir_entry);
 
 	pci_free_consistent(adapter->dev, MEGA_BUFFER_SIZE,
 			adapter->mega_buffer, adapter->buf_dma_handle);
diff --git a/drivers/scsi/megaraid.h b/drivers/scsi/megaraid.h
index 21eba2fd465a..18e85d9267ff 100644
--- a/drivers/scsi/megaraid.h
+++ b/drivers/scsi/megaraid.h
@@ -814,18 +814,6 @@ typedef struct {
 
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry	*controller_proc_dir_entry;
-	struct proc_dir_entry	*proc_read;
-	struct proc_dir_entry	*proc_stat;
-	struct proc_dir_entry	*proc_mbox;
-
-#if MEGA_HAVE_ENH_PROC
-	struct proc_dir_entry	*proc_rr;
-	struct proc_dir_entry	*proc_battery;
-#define MAX_PROC_CHANNELS	4
-	struct proc_dir_entry	*proc_pdrvstat[MAX_PROC_CHANNELS];
-	struct proc_dir_entry	*proc_rdrvstat[MAX_PROC_CHANNELS];
-#endif
-
 #endif
 
 	int	has_64bit_addr;		/* are we using 64-bit addressing */
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
