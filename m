Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526463948-2-2480208461608221894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526463947; b=AfU7H12MIVzKd3OQs04J0c3GchXNm9/yL8er/5OxlLb68tC5Cz
    fkYQ9iFHL/EPTiIUhbhRMPdtU05toP3XQ+63E0veXND4DqrYZd5gwSXzGRM3zKKw
    GLr2O2pIVODPggVbzL+cYJbAtKTP22BQTrhiGt5GfJxC1fvX7x+ZouRjWl1M1Ygg
    JXPv7Q/albE76baBYSxF3iU+q6U6bOsfsSYDQG/uppj7YnpIZG5WnEhDgCaOiCDg
    n6e8QmxdtFsozSgITZ0Bzrf+AXAO3rJruRUv6x0TwnjrqjfNIgdF5Hi1Mvg9HH9U
    x7lciRc61zuUQSRC2FU0U4Ftxu4BQ2ONeayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526463947; bh=vuSu3
    1hT0aczRooKr2rmuSLqEFB8Q2bn4epEudiHCTQ=; b=WvQFY6MpqdDA3ngkmhhkT
    Jco/TysQwAUnrgE5MVc3v1QxXWFIK25Y8B/S2SNvx8GPCFZkbEe3m7nRdfGPgy6l
    GfX+1tnM8Mcrspo/ecwkjR1mwdqmRwQbz96ZcdRrH8YOdoExMvGQohKxS3nv4oE6
    JtW3uH1ts6Av8Mc/HIqiHPLSLRBkWAOEns2F0K14Z1NKAp08FB3TNBWCKjx3wqJN
    kXlcDK4SWK3RUdus4hibIDnzbzr2Clo/UzZX8HM/mcxqF+lY5kgd5JRVvSyRocDF
    x/ReCx76LaEPhBL+GmjVZbhh/Q0M+gNQ94AvR0msesx8mo/ZifIx5elMZScVVIRX
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=BbvCJU9g
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=BbvCJU9g
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
X-CM-Envelope: MS4wfODD04xuozdLgLM4QJCHmY206agujVopKPlGmQTwe+R/GFzFyAUe81dHvD7RHBpV2OAqwy6vSyI8gutXUefEpCJjiwI8tw/8tK3zAltT0I6SgNCaeqAc
    PZxBuUlEDMDk39mkViE0GVk9lOmJj5XElbhI3VhwoNggesFwnLHpuuP75mqzNSw5hiaSWeHxP8BBYQFQ3evbbeY4bVxDo7G95BMWDIgkLN7fLvvw0wbkEbXC
    8LE/fuzDbEKs9EPAVam2Yg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=1Vj8lGVWC8qYKH4cEXMA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 20/42] sgi-gru: simplify procfs code
Date: Wed, 16 May 2018 11:43:24 +0200
Message-Id: <20180516094346.20506-21-hch@lst.de>
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
