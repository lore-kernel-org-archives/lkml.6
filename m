Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671454-2-10697868061181127856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671453; b=n0WczmzoVIinRuUgAARGhhQKZLgeKxjUscstiBJ9LseN5hJqB+
    u/JwMvL4zenCZFbTJGL9fUGDYR6282ZnEdpd+evoJGNUFaI1d7N9N5Pjos/v1MgC
    aR5wI+7lZoWE6eRnTsQBXj6LTjI1Des/0nt1SuaKBHUclCoa0jT0vjmOR9+MlQ5m
    G8jNuYL25MknBG5LVsrhEafZaHQkoiaX66fJQmDFuc9h6f5W9B1VvWGMLQBMGRll
    uRFPZoPb2ZoezgPX5gM6cAWStHe7Il4Em1ddoRtvrK3+M3DevdXTELi4C69NQQS+
    FMwHk3KCk1kWobWOx/7AWQnuZJNTdDJgdl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671453; bh=dCR8u
    AYsEIodS96t7XmZdel2muGd4tGZ82tOcmnHA1c=; b=Wz3sKqd5fW1vhp7Yi0Tws
    jaS9kOF0OlsZFoCibmhGGPXvCKrc1O3R0rwFt8aRb4TCmgM8Rz1oYllyH9JIvJDo
    PTaMzdu0tteN3F0JYJybwVIKJ1gV8c9tpolmh/CytUZyMdnU3Q5D8q5KkZyBi2pB
    Aj+ZNzi4dH9dHHEV4FDQX09svJwuorSb9OVl3dNGaX7dGsNJYHWR5ANBEojjCgOr
    JLRp5bPNEzwWKzmSLBD02HoY6vHPfmLq9h1IXxSQ8UAiahf2SE18+nJ4okND5o/s
    nh+xcvFVHsspLxlavIUEw5Tfhb1kZRQJtrFkkGhwdd+bp5fg7rr9PVsgO2rTmzoZ
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=JUqEBQmB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=JUqEBQmB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPG5xzCErJc75VO8Jo4zyF3Envck6D0CaUPVYXLwxTPGtYotiRYmsECEyuR48lFUaXNqA8XKwQjrK9VhrhSAw66Xdd1b+je5VPnSMznjwKRrCswpKSZ
    etmycDM7av7nZpJgapF7lT+UqirtaatrDfRVHpo5HgFHhoMGnjdvyvEWxAgdhkMDFV01Sr2t5SPi9rR+xlLvUsHEI0t1lFVoZY2LC9JfM7mwbEaJH7/rhq9T
    9FBcw/QiMo3wYRwKq7u9lA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=c5d4c0_zl500DmvltOAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 19/40] megaraid: simplify procfs code
Date: Wed, 25 Apr 2018 17:48:06 +0200
Message-Id: <20180425154827.32251-20-hch@lst.de>
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
proc_create_single.

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
