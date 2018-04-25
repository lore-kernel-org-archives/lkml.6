Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671471-2-5097993573634471619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671470; b=iEUL8zaxoo9Qz9i0BM15A2191Dfx1tqmNU9NyynZqVrJCKYnQB
    tgsbGbnr/9PI+X84Vz+eSkItUkjALUdCSpb+4FC8V/cCX/5WRaGLqh1k2b1RwVEm
    wy2MGYHbN3jjNDDJ5raroBgH7YHTKgWmT6QRjkS8jPN/Yx6sPo0BuOfB+CUdDHk6
    wOHSdm6CM3zK1h0SEA9xgN/I79kS+y17w3Lg6AOmocXTkhFsx5nSGOCHTqOQEPp5
    EJF8voqPl8ALVhvzQUSchkgYywJX3fi5bTfnc0YVI8vI/sRVhYxOJQENLtp7yzdf
    48CZ/dxPFGLAu/DZkJAd4QkTRU6Pd8jshY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671470; bh=AhG2E
    Lml9eQvI71OUYTm1BkEaJatShjY0LrZ/JZbBM4=; b=Gam+upwId95G12dAWMyjS
    FtE135sawMeRJpN8AJfL/wfIdjgWZrLN18yv19+IQsJmYK8EwYpTqvjfnozZFChn
    XOhdeq4ytsupa6ZZwoLlg52TyiPkjiaCp8RFabDRpD9mz+m9b1vQiFpLNFsHSk49
    sY+0CLF81VcqH5x71zopIZ41fZQkFjs8Q74EZy0or8DCLKuWudYQ7qFcgc1KQizO
    b2U/ygYkeSv+CC4YLrGge+vwBHDxIV0+ktf5xSX3YV+nDhezzKsjEUZ4gGVclW1u
    XWrAj1S15ASMNW/7S4KEcMwJP3aBQIG4jdKr9jzEFOOBnSq75xGiHuCOjyBs01Tv
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Uv6Paiyz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Uv6Paiyz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfJfyAROBaPXDNYMO0efRbAA6V0dwrrQDzKcV12a8smznRrLLz3/hvOgA4dG6gFRUpvonkOpYCQhfM9ae9mDiCehPJIuKgJDDmm+HPKZfmJym5Lg8fIKO
    qAsR9hXpQHHRVD+PQgKYa7R7j33My8GBd9EmT7fBXpGontaCX9DZnud17nxi2V8tanwQlAfVbFNoCmyvRpP5cbndtYMGGGbIyUpXFZrNlFF0n49LricuZIMj
    j12o5auID4oXvBeJ62DXCg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=88F98xHFbi003eYDy_sA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 26/40] drbd: switch to proc_create_single
Date: Wed, 25 Apr 2018 17:48:13 +0200
Message-Id: <20180425154827.32251-27-hch@lst.de>
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

And stop messing with try_module_get on THIS_MODULE, which doesn't make
any sense here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/block/drbd/drbd_main.c |  3 ++-
 drivers/block/drbd/drbd_proc.c | 34 +---------------------------------
 3 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 06ecee1b528e..461ddec04e7c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1643,7 +1643,7 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 
 /* drbd_proc.c */
 extern struct proc_dir_entry *drbd_proc;
-extern const struct file_operations drbd_proc_fops;
+int drbd_seq_show(struct seq_file *seq, void *v);
 
 /* drbd_actlog.c */
 extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 185f1ef00a7c..c2d154faac02 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3010,7 +3010,8 @@ static int __init drbd_init(void)
 		goto fail;
 
 	err = -ENOMEM;
-	drbd_proc = proc_create_data("drbd", S_IFREG | S_IRUGO , NULL, &drbd_proc_fops, NULL);
+	drbd_proc = proc_create_single("drbd", S_IFREG | S_IRUGO , NULL,
+			drbd_seq_show);
 	if (!drbd_proc)	{
 		pr_err("unable to register proc file\n");
 		goto fail;
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 582caeb0de86..74ef29247bb5 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -33,18 +33,7 @@
 #include <linux/drbd.h>
 #include "drbd_int.h"
 
-static int drbd_proc_open(struct inode *inode, struct file *file);
-static int drbd_proc_release(struct inode *inode, struct file *file);
-
-
 struct proc_dir_entry *drbd_proc;
-const struct file_operations drbd_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= drbd_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= drbd_proc_release,
-};
 
 static void seq_printf_with_thousands_grouping(struct seq_file *seq, long v)
 {
@@ -235,7 +224,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 	}
 }
 
-static int drbd_seq_show(struct seq_file *seq, void *v)
+int drbd_seq_show(struct seq_file *seq, void *v)
 {
 	int i, prev_i = -1;
 	const char *sn;
@@ -345,24 +334,3 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int drbd_proc_open(struct inode *inode, struct file *file)
-{
-	int err;
-
-	if (try_module_get(THIS_MODULE)) {
-		err = single_open(file, drbd_seq_show, NULL);
-		if (err)
-			module_put(THIS_MODULE);
-		return err;
-	}
-	return -ENODEV;
-}
-
-static int drbd_proc_release(struct inode *inode, struct file *file)
-{
-	module_put(THIS_MODULE);
-	return single_release(inode, file);
-}
-
-/* PROC FS stuff end */
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
