Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524671446-2-17733781800403594283
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
    1524671445; b=SVbEW2I0xqPUXE1XT2/TcTQKBdgFdvpoglDsn5dmAOtANxdE2k
    wrX0WkppIv/Zw6FOgVm5/JPledcEupwwCAAi5NahGsTz/TRVll/1cDTKWhXJg+fU
    8D+21vl3DnEPELrToXDZAlE5Q+bqPBtSo44ZoC6wwzfJ5v+Jo+NCdbkzDi+CV5ch
    YXRYi6kitbtHAxmHLIXBxs4anSfXd7zadSNF0Ri3+762OsbpRthW8qzQvN84ruGx
    lR+KPCWEjHR2DpA8tnDQQvgVfK0q6m8uGc+3iJ9t26sAZPkVPQQro3lyttuxgg5h
    TQ1ZwlwlfSpJfTj09PX8/pUN8eVsmixyVpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671445; bh=vuSu3
    1hT0aczRooKr2rmuSLqEFB8Q2bn4epEudiHCTQ=; b=Zp4txQbJkbI8bmXf0eGgO
    iM0AQ3b4gNx0F0+tHpwMXsXvRoDcBhNGU9ds6denFfhZuuUtVyO2/apk11VxhFo3
    7PbSxGjj8jqi8J0uaNCix8olWhfjnSRpX943P8Ln0ZCb5OSgv7KiO1MugpLWGHu3
    SFMU9GSaJdOp7yun7KkA84tnvbqCwTp4Wz1YCsmJfN26R3y+kWfNjmmHR7VArPca
    gv27dGGYGMcz5P0Lkg46vNNF16rN/DaADZl0l/4AmggyINC69DxOSIhJEWqFKpPx
    GTMF3MSZgtv9gIlrqhPDrzFRZQBDV9UJXHDYZVIo3wVYyD/FXvO7MZ88nZYnIm5B
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=TOAjUx5v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=TOAjUx5v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfK+whw6EXFyv+NyjnHVu9qjo+CdZZSgxmmKUdkZ0nwe8hQGmcvdqTTxtb2mun/WSzt6IH9b6tFt6I9Y/wJcJL9rKrwvCRhAjv95Qpop+mlRJYoiqN++p
    QYWBH54UuTeZvl60w75IrxKUuOhPM3MKRbi3ST2+azXZT8jhdCoAY+Oof11TDtkgPLhX6mpjRE7dWKgcvhVwdP/b6yX/0E8cARn5iPStxdk3FJqYl7rk+14r
    5M0tTCpAFKiej611mmqtdQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=1Vj8lGVWC8qYKH4cEXMA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 18/40] sgi-gru: simplify procfs code
Date: Wed, 25 Apr 2018 17:48:05 +0200
Message-Id: <20180425154827.32251-19-hch@lst.de>
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
 drivers/misc/sgi-gru/gruprocfs.c | 81 ++++++--------------------------
 1 file changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/misc/sgi-gru/gruprocfs.c b/drivers/misc/sgi-gru/gruprocfs.c
index 4f7635922394..42ea2eccaee9 100644
--- a/drivers/misc/sgi-gru/gruprocfs.c
+++ b/drivers/misc/sgi-gru/gruprocfs.c
@@ -270,16 +270,6 @@ static int options_open(struct inode *inode, struct file *file)
 	return single_open(file, options_show, NULL);
 }
 
-static int cch_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &cch_seq_ops);
-}
-
-static int gru_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &gru_seq_ops);
-}
-
 /* *INDENT-OFF* */
 static const struct file_operations statistics_fops = {
 	.open 		= statistics_open,
@@ -305,73 +295,30 @@ static const struct file_operations options_fops = {
 	.release 	= single_release,
 };
 
-static const struct file_operations cch_fops = {
-	.open 		= cch_open,
-	.read 		= seq_read,
-	.llseek 	= seq_lseek,
-	.release 	= seq_release,
-};
-static const struct file_operations gru_fops = {
-	.open 		= gru_open,
-	.read 		= seq_read,
-	.llseek 	= seq_lseek,
-	.release 	= seq_release,
-};
-
-static struct proc_entry {
-	char *name;
-	umode_t mode;
-	const struct file_operations *fops;
-	struct proc_dir_entry *entry;
-} proc_files[] = {
-	{"statistics", 0644, &statistics_fops},
-	{"mcs_statistics", 0644, &mcs_statistics_fops},
-	{"debug_options", 0644, &options_fops},
-	{"cch_status", 0444, &cch_fops},
-	{"gru_status", 0444, &gru_fops},
-	{NULL}
-};
-/* *INDENT-ON* */
-
 static struct proc_dir_entry *proc_gru __read_mostly;
 
-static int create_proc_file(struct proc_entry *p)
-{
-	p->entry = proc_create(p->name, p->mode, proc_gru, p->fops);
-	if (!p->entry)
-		return -1;
-	return 0;
-}
-
-static void delete_proc_files(void)
-{
-	struct proc_entry *p;
-
-	if (proc_gru) {
-		for (p = proc_files; p->name; p++)
-			if (p->entry)
-				remove_proc_entry(p->name, proc_gru);
-		proc_remove(proc_gru);
-	}
-}
-
 int gru_proc_init(void)
 {
-	struct proc_entry *p;
-
 	proc_gru = proc_mkdir("sgi_uv/gru", NULL);
-
-	for (p = proc_files; p->name; p++)
-		if (create_proc_file(p))
-			goto err;
+	if (!proc_gru)
+		return -1;
+	if (!proc_create("statistics", 0644, proc_gru, &statistics_fops))
+		goto err;
+	if (!proc_create("mcs_statistics", 0644, proc_gru, &mcs_statistics_fops))
+		goto err;
+	if (!proc_create("debug_options", 0644, proc_gru, &options_fops))
+		goto err;
+	if (!proc_create_seq("cch_status", 0444, proc_gru, &cch_seq_ops))
+		goto err;
+	if (!proc_create_seq("gru_status", 0444, proc_gru, &gru_seq_ops))
+		goto err;
 	return 0;
-
 err:
-	delete_proc_files();
+	remove_proc_subtree("sgi_uv/gru", NULL);
 	return -1;
 }
 
 void gru_proc_exit(void)
 {
-	delete_proc_files();
+	remove_proc_subtree("sgi_uv/gru", NULL);
 }
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
