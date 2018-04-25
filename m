Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524671543-2-9427440788205073854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671541; b=HMMk+s7m24fLWQvfV3h9QEszC1jxSeQnGJDP8rnv2zjFNFJoYo
    NlQFt2QFHAXuSs2j6Fjx+X2OQa79itC4nwZWFYEME1ZQcc1sJUeRG7InoXEfPNUH
    l1a3kZMGRoxgBMS9JbWoegsb8cpSeW26D8YT7HmiTMzkFWFMRWXoDQsJlCozYq0W
    YcE2t2ZoNaCUy7M0+1UrZ/Q5xmuypwUE8ReROZnsES6GSkha5CGu+J7ea3UAMZ0J
    oxN3hn28ChZ7ZIf+yj/E0MP7/88ydeh3Tvo1Kw95OgY/e97rgad/Iqui17GINR4B
    ZgQqS1xIuanEsnmeHv8ia76jDFa9ZQ5QrG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671541; bh=1nRHd
    rV51Y1SEOG6fglOL+q20P4GEKP/FJBOimhvt14=; b=bXZoXVpKbnpzS8tBkrCgv
    pwR+XmmAOcAIzrIaZDOVc1KE0a/AeJAx1Vrcpvim3uk7uRMjehPwO0BbRO7rSNfu
    r1jnOYdAIwDG2WpCPbWsO0G1o3P1GUGyR+PbTYBTyKBcvxWqoDZvmYWWFQ9Q4XwM
    dBCbCz0yhe9PTQa3Z70EiHDzHMWz2FtHsNmKuyE8HBp85hOnBZZLmEu37NLCSTMC
    xWNCovrn7NuJSvffrAuscK0TmKZYbIRXHr/+fCQAF0qz4hVxZg9GOj7c/PU0gkmE
    qC6hCja9tIqE/SiWJkzuVqXgIfZtAX8CW3URhC6fAMuDbL53DGA8Ra0YX5Q2GfF8
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=U9KW5dIg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=U9KW5dIg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfH1pKegdUrlNQVHcI4mqLNr2b6ibPg5SLH93yqS++dddUbABOWH2IS6hLTZGewGmkxPQ8UMkuBo0tyR9eYTKzvvyOQKEg10ndz/sQ6sCKZK+aRsLO+ad
    tqKVoUzZF7ZwsciR/zNDI/viutW2J0PEexCU3CiI9nPeb9Ahh1GCZ6xdrh2uyug369HiwOHbJpqadvvt3vgI/d1AgKGn+Jh1uFES5//mzyo0gh1UUrwLUv6I
    OhSQRI7ya3CU/vwqzfQO9Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=e0Z0VjiGqk7erTgq0IUA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 39/40] ide: replace ->proc_fops with ->proc_show
Date: Wed, 25 Apr 2018 17:48:26 +0200
Message-Id: <20180425154827.32251-40-hch@lst.de>
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

Just set up the show callback in the tty_operations, and use
proc_create_single_data to create the file without additional
boilerplace code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-cd.c          |  15 +---
 drivers/ide/ide-disk_proc.c   |  62 ++--------------
 drivers/ide/ide-floppy_proc.c |  17 +----
 drivers/ide/ide-proc.c        | 136 +++++-----------------------------
 drivers/ide/ide-tape.c        |  17 +----
 include/linux/ide.h           |   6 +-
 6 files changed, 31 insertions(+), 222 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 5a8e8e3c22cd..b52a7bdace52 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1426,21 +1426,8 @@ static int idecd_capacity_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int idecd_capacity_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, idecd_capacity_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations idecd_capacity_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= idecd_capacity_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static ide_proc_entry_t idecd_proc[] = {
-	{ "capacity", S_IFREG|S_IRUGO, &idecd_capacity_proc_fops },
+	{ "capacity", S_IFREG|S_IRUGO, idecd_capacity_proc_show },
 	{}
 };
 
diff --git a/drivers/ide/ide-disk_proc.c b/drivers/ide/ide-disk_proc.c
index 82a36ced4e96..95d239b2f646 100644
--- a/drivers/ide/ide-disk_proc.c
+++ b/drivers/ide/ide-disk_proc.c
@@ -52,19 +52,6 @@ static int idedisk_cache_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int idedisk_cache_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, idedisk_cache_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations idedisk_cache_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= idedisk_cache_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int idedisk_capacity_proc_show(struct seq_file *m, void *v)
 {
 	ide_drive_t*drive = (ide_drive_t *)m->private;
@@ -73,19 +60,6 @@ static int idedisk_capacity_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int idedisk_capacity_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, idedisk_capacity_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations idedisk_capacity_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= idedisk_capacity_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int __idedisk_proc_show(struct seq_file *m, ide_drive_t *drive, u8 sub_cmd)
 {
 	u8 *buf;
@@ -114,43 +88,17 @@ static int idedisk_sv_proc_show(struct seq_file *m, void *v)
 	return __idedisk_proc_show(m, m->private, ATA_SMART_READ_VALUES);
 }
 
-static int idedisk_sv_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, idedisk_sv_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations idedisk_sv_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= idedisk_sv_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int idedisk_st_proc_show(struct seq_file *m, void *v)
 {
 	return __idedisk_proc_show(m, m->private, ATA_SMART_READ_THRESHOLDS);
 }
 
-static int idedisk_st_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, idedisk_st_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations idedisk_st_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= idedisk_st_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 ide_proc_entry_t ide_disk_proc[] = {
-	{ "cache",	  S_IFREG|S_IRUGO, &idedisk_cache_proc_fops	},
-	{ "capacity",	  S_IFREG|S_IRUGO, &idedisk_capacity_proc_fops	},
-	{ "geometry",	  S_IFREG|S_IRUGO, &ide_geometry_proc_fops	},
-	{ "smart_values", S_IFREG|S_IRUSR, &idedisk_sv_proc_fops	},
-	{ "smart_thresholds", S_IFREG|S_IRUSR, &idedisk_st_proc_fops	},
+	{ "cache",	  S_IFREG|S_IRUGO, idedisk_cache_proc_show	},
+	{ "capacity",	  S_IFREG|S_IRUGO, idedisk_capacity_proc_show	},
+	{ "geometry",	  S_IFREG|S_IRUGO, ide_geometry_proc_show	},
+	{ "smart_values", S_IFREG|S_IRUSR, idedisk_sv_proc_show		},
+	{ "smart_thresholds", S_IFREG|S_IRUSR, idedisk_st_proc_show	},
 	{}
 };
 
diff --git a/drivers/ide/ide-floppy_proc.c b/drivers/ide/ide-floppy_proc.c
index 471457ebea67..7f697ddb5fe5 100644
--- a/drivers/ide/ide-floppy_proc.c
+++ b/drivers/ide/ide-floppy_proc.c
@@ -14,22 +14,9 @@ static int idefloppy_capacity_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int idefloppy_capacity_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, idefloppy_capacity_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations idefloppy_capacity_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= idefloppy_capacity_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 ide_proc_entry_t ide_floppy_proc[] = {
-	{ "capacity",	S_IFREG|S_IRUGO, &idefloppy_capacity_proc_fops	},
-	{ "geometry",	S_IFREG|S_IRUGO, &ide_geometry_proc_fops	},
+	{ "capacity",	S_IFREG|S_IRUGO, idefloppy_capacity_proc_show	},
+	{ "geometry",	S_IFREG|S_IRUGO, ide_geometry_proc_show		},
 	{}
 };
 
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index b3b8b8822d6a..45c997430332 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -56,19 +56,6 @@ static int ide_imodel_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_imodel_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_imodel_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_imodel_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_imodel_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int ide_mate_proc_show(struct seq_file *m, void *v)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *) m->private;
@@ -80,19 +67,6 @@ static int ide_mate_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_mate_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_mate_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_mate_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_mate_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int ide_channel_proc_show(struct seq_file *m, void *v)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *) m->private;
@@ -101,19 +75,6 @@ static int ide_channel_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_channel_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_channel_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_channel_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_channel_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int ide_identify_proc_show(struct seq_file *m, void *v)
 {
 	ide_drive_t *drive = (ide_drive_t *)m->private;
@@ -141,19 +102,6 @@ static int ide_identify_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_identify_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_identify_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_identify_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_identify_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /**
  *	ide_find_setting	-	find a specific setting
  *	@st: setting table pointer
@@ -441,27 +389,14 @@ static const struct file_operations ide_settings_proc_fops = {
 	.write		= ide_settings_proc_write,
 };
 
-static int ide_capacity_proc_show(struct seq_file *m, void *v)
+int ide_capacity_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "%llu\n", (long long)0x7fffffff);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ide_capacity_proc_show);
 
-static int ide_capacity_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_capacity_proc_show, NULL);
-}
-
-const struct file_operations ide_capacity_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_capacity_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-EXPORT_SYMBOL_GPL(ide_capacity_proc_fops);
-
-static int ide_geometry_proc_show(struct seq_file *m, void *v)
+int ide_geometry_proc_show(struct seq_file *m, void *v)
 {
 	ide_drive_t	*drive = (ide_drive_t *) m->private;
 
@@ -471,20 +406,7 @@ static int ide_geometry_proc_show(struct seq_file *m, void *v)
 			drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	return 0;
 }
-
-static int ide_geometry_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_geometry_proc_show, PDE_DATA(inode));
-}
-
-const struct file_operations ide_geometry_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_geometry_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-EXPORT_SYMBOL(ide_geometry_proc_fops);
+EXPORT_SYMBOL(ide_geometry_proc_show);
 
 static int ide_dmodel_proc_show(struct seq_file *seq, void *v)
 {
@@ -495,19 +417,6 @@ static int ide_dmodel_proc_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int ide_dmodel_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_dmodel_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_dmodel_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_dmodel_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int ide_driver_proc_show(struct seq_file *m, void *v)
 {
 	ide_drive_t		*drive = (ide_drive_t *)m->private;
@@ -523,19 +432,6 @@ static int ide_driver_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_driver_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_driver_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_driver_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_driver_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int ide_media_proc_show(struct seq_file *m, void *v)
 {
 	ide_drive_t	*drive = (ide_drive_t *) m->private;
@@ -567,11 +463,10 @@ static const struct file_operations ide_media_proc_fops = {
 };
 
 static ide_proc_entry_t generic_drive_entries[] = {
-	{ "driver",	S_IFREG|S_IRUGO,	 &ide_driver_proc_fops	},
-	{ "identify",	S_IFREG|S_IRUSR,	 &ide_identify_proc_fops},
-	{ "media",	S_IFREG|S_IRUGO,	 &ide_media_proc_fops	},
-	{ "model",	S_IFREG|S_IRUGO,	 &ide_dmodel_proc_fops	},
-	{ "settings",	S_IFREG|S_IRUSR|S_IWUSR, &ide_settings_proc_fops},
+	{ "driver",	S_IFREG|S_IRUGO,	 ide_driver_proc_show	},
+	{ "identify",	S_IFREG|S_IRUSR,	 ide_identify_proc_show	},
+	{ "media",	S_IFREG|S_IRUGO,	 ide_media_proc_show	},
+	{ "model",	S_IFREG|S_IRUGO,	 ide_dmodel_proc_show	},
 	{}
 };
 
@@ -582,7 +477,7 @@ static void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p
 	if (!dir || !p)
 		return;
 	while (p->name != NULL) {
-		ent = proc_create_data(p->name, p->mode, dir, p->proc_fops, data);
+		ent = proc_create_single_data(p->name, p->mode, dir, p->show, data);
 		if (!ent) return;
 		p++;
 	}
@@ -647,8 +542,12 @@ void ide_proc_port_register_devices(ide_hwif_t *hwif)
 			continue;
 
 		drive->proc = proc_mkdir(drive->name, parent);
-		if (drive->proc)
+		if (drive->proc) {
 			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
+			proc_create_data("setting", S_IFREG|S_IRUSR|S_IWUSR,
+					drive->proc, &ide_settings_proc_fops,
+					drive);
+		}
 		sprintf(name, "ide%d/%s", (drive->name[2]-'a')/2, drive->name);
 		ent = proc_symlink(drive->name, proc_ide_root, name);
 		if (!ent) return;
@@ -658,6 +557,7 @@ void ide_proc_port_register_devices(ide_hwif_t *hwif)
 void ide_proc_unregister_device(ide_drive_t *drive)
 {
 	if (drive->proc) {
+		remove_proc_entry("settings", drive->proc);
 		ide_remove_proc_entries(drive->proc, generic_drive_entries);
 		remove_proc_entry(drive->name, proc_ide_root);
 		remove_proc_entry(drive->name, drive->hwif->proc);
@@ -666,9 +566,9 @@ void ide_proc_unregister_device(ide_drive_t *drive)
 }
 
 static ide_proc_entry_t hwif_entries[] = {
-	{ "channel",	S_IFREG|S_IRUGO,	&ide_channel_proc_fops	},
-	{ "mate",	S_IFREG|S_IRUGO,	&ide_mate_proc_fops	},
-	{ "model",	S_IFREG|S_IRUGO,	&ide_imodel_proc_fops	},
+	{ "channel",	S_IFREG|S_IRUGO,	ide_channel_proc_show	},
+	{ "mate",	S_IFREG|S_IRUGO,	ide_mate_proc_show	},
+	{ "model",	S_IFREG|S_IRUGO,	ide_imodel_proc_show	},
 	{}
 };
 
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index fd57e8ccc47a..ac2c6820c65a 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1847,22 +1847,9 @@ static int idetape_name_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int idetape_name_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, idetape_name_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations idetape_name_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= idetape_name_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static ide_proc_entry_t idetape_proc[] = {
-	{ "capacity",	S_IFREG|S_IRUGO,	&ide_capacity_proc_fops	},
-	{ "name",	S_IFREG|S_IRUGO,	&idetape_name_proc_fops	},
+	{ "capacity",	S_IFREG|S_IRUGO,	ide_capacity_proc_show	},
+	{ "name",	S_IFREG|S_IRUGO,	idetape_name_proc_show	},
 	{}
 };
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index ca9d34feb572..752464f5a772 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -961,7 +961,7 @@ __IDE_PROC_DEVSET(_name, _min, _max, NULL, NULL)
 typedef struct {
 	const char	*name;
 	umode_t		mode;
-	const struct file_operations *proc_fops;
+	int (*show)(struct seq_file *, void *);
 } ide_proc_entry_t;
 
 void proc_ide_create(void);
@@ -973,8 +973,8 @@ void ide_proc_unregister_port(ide_hwif_t *);
 void ide_proc_register_driver(ide_drive_t *, struct ide_driver *);
 void ide_proc_unregister_driver(ide_drive_t *, struct ide_driver *);
 
-extern const struct file_operations ide_capacity_proc_fops;
-extern const struct file_operations ide_geometry_proc_fops;
+int ide_capacity_proc_show(struct seq_file *m, void *v);
+int ide_geometry_proc_show(struct seq_file *m, void *v);
 #else
 static inline void proc_ide_create(void) { ; }
 static inline void proc_ide_destroy(void) { ; }
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
