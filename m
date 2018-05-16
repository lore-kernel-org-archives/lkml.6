Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526464009-2-13007094943184892571
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
    1526464008; b=ONxriXkB2hukWr6gI7ChfLs45GAf/X0WrDQypjwQ/9/MwMpIhc
    Vz6IItUuY5ICcHGUqxpL4PgpQcM56B3AWzbQXWuj67z4SRbgxwDMGCxi24li3Hh8
    f1tE1OYmmWafZgFfNcfcgJ/F8e3UDRS0qHiLFJp/uQp6PxgnBOh7WEypDUZFPmlb
    dl9I4GecBDOdUwZYc5zVoIEJUeaGAXz/bB+MHbNUAG4mNZ84Bilik1y9s0JNB48o
    R73y4dbIB3KgpFNttrYdFAxm7cC76SEGJQ5tXMycQePCB6KFNbTuOubkmvf8estZ
    U72c7GEkxa6uAGDs90J9itancXyBtae9QsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464008; bh=QGjIB
    zZt+9nPRXGHzMPo0tYnjgQtBG9wiqGe7GaDjz0=; b=PuhOLPj6iK+R5LJc5ZgP+
    GXe8OQ7qjOWWQbMzLBpw4yKMw4yw2pAAKZ41pEOFhuKvJ0l6lH5hYG3LxJ73OMIo
    1SQlPuF3uJ3q1spW8zMzGwG0R4VmOlwMOvSJiVLsDCaN8KzSUIzveSFvG83fhIYp
    sjsA8LW+VCLZFwkH8FAiRdHjqrWblu4Ith7oX8R7EuoWwcwNmMdKh2SsvuX8hzx0
    WkMPFFQXfce3YWWeD47UUahkTY1nwL0lpAs1TqoGaITEhRaexPs3d1TpTx9elq/p
    3F6N0+rEWixbXA3Vn8XzSxKMejnCzjrz/n0LoVep4egxueJnzGz6WwI3v9rhn2U0
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=dLWLPTqr
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
      header.d=infradead.org header.i=@infradead.org header.b=dLWLPTqr
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
X-CM-Envelope: MS4wfBRa0izDjoTTFDO97Pkb8QDNANonBmRMC5LsztMM1U702I6EZXxdtn+CO7jVNmT66S+dKk1/QvT7O+9X5dBMsv1sHHPh8it+R0gOQjURhIHvDvpXShci
    PpDpC1s4TA0Lm1sPVbuFed2QcgcFWDhtBlJA4GVH/UyvUcnpq9fanZlmB5yPOP5XrabrNOH/iFt/H05ujY9YqX6xxxx5huy5fjCh/dXmRNp3FN7KAYEHD3Qb
    UxpUPSZSBkkiThPOz+KWLw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=Wpy0-uDpMQgr-WdNMiwA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 36/42] atm: simplify procfs code
Date: Wed, 16 May 2018 11:43:40 +0200
Message-Id: <20180516094346.20506-37-hch@lst.de>
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
 net/atm/proc.c | 65 ++++++--------------------------------------------
 1 file changed, 7 insertions(+), 58 deletions(-)

diff --git a/net/atm/proc.c b/net/atm/proc.c
index 55410c00c7e2..f272b0f59d82 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -257,18 +257,6 @@ static const struct seq_operations atm_dev_seq_ops = {
 	.show	= atm_dev_seq_show,
 };
 
-static int atm_dev_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &atm_dev_seq_ops);
-}
-
-static const struct file_operations devices_seq_fops = {
-	.open		= atm_dev_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int pvc_seq_show(struct seq_file *seq, void *v)
 {
 	static char atm_pvc_banner[] =
@@ -440,58 +428,19 @@ void atm_proc_dev_deregister(struct atm_dev *dev)
 	kfree(dev->proc_name);
 }
 
-static struct atm_proc_entry {
-	char *name;
-	const struct file_operations *proc_fops;
-	struct proc_dir_entry *dirent;
-} atm_proc_ents[] = {
-	{ .name = "devices",	.proc_fops = &devices_seq_fops },
-	{ .name = "pvc",	.proc_fops = &pvc_seq_fops },
-	{ .name = "svc",	.proc_fops = &svc_seq_fops },
-	{ .name = "vc",		.proc_fops = &vcc_seq_fops },
-	{ .name = NULL,		.proc_fops = NULL }
-};
-
-static void atm_proc_dirs_remove(void)
-{
-	static struct atm_proc_entry *e;
-
-	for (e = atm_proc_ents; e->name; e++) {
-		if (e->dirent)
-			remove_proc_entry(e->name, atm_proc_root);
-	}
-	remove_proc_entry("atm", init_net.proc_net);
-}
-
 int __init atm_proc_init(void)
 {
-	static struct atm_proc_entry *e;
-	int ret;
-
 	atm_proc_root = proc_net_mkdir(&init_net, "atm", init_net.proc_net);
 	if (!atm_proc_root)
-		goto err_out;
-	for (e = atm_proc_ents; e->name; e++) {
-		struct proc_dir_entry *dirent;
-
-		dirent = proc_create(e->name, 0444,
-				     atm_proc_root, e->proc_fops);
-		if (!dirent)
-			goto err_out_remove;
-		e->dirent = dirent;
-	}
-	ret = 0;
-out:
-	return ret;
-
-err_out_remove:
-	atm_proc_dirs_remove();
-err_out:
-	ret = -ENOMEM;
-	goto out;
+		return -ENOMEM;
+	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
+	proc_create("pvc", 0444, atm_proc_root, &pvc_seq_fops);
+	proc_create("svc", 0444, atm_proc_root, &svc_seq_fops);
+	proc_create("vc", 0444, atm_proc_root, &vcc_seq_fops);
+	return 0;
 }
 
 void atm_proc_exit(void)
 {
-	atm_proc_dirs_remove();
+	remove_proc_subtree("atm", init_net.proc_net);
 }
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
