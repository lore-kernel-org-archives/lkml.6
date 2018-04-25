Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671350-2-15345722133305693795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671349; b=VU299ZKmTCLaoIAuwOUIa9Y/IoOF5HeHQt1kKbpBP5pUDBbSgJ
    hYdKYIRxLmYrWExO7iA4d7qIqJ/A4kSGfYhvzRFlhi2t9d1QwSmtZ8GLCmK5L8Xt
    58aKs94P7c+ItycgngaGLqx3Y/VBYt9/0ZbPGftHD1lqyNfwpyHz/lmzLoO8LDZa
    D2yzYQhSphrkhdLKmF9etPKLQ7kZd9bf5OxMhjowK0sZQAzR6/WjS0MQ6jAVmoHJ
    sdglRcFGt2m8ZmJZS7JX0nxc9MeaRAH461JfWTETqwekTmmrax5FrRmy+8FVxOso
    nYklVavWn/wzaviCT1DnxP90aeESwX+aVogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671349; bh=p38vM
    nmumZTcsuL65BOGTVIFWcORC4DGp3lgE6owKNY=; b=GgLNqwPsYAMKrLQ9oGtn9
    OewSUwCPw7fIldBEUUXwDv8rqGgb6yieCz1/Ppmlsp1VWSXj9DdB66iXySkMNhLQ
    wTVyHSvOuaLdnOLjDvuJtJ0Zits415+HROB081AARsWbmUEf1oK8Pvws+dbzBul2
    cEULEyLBSUz0YRM29tad6DG32dnJiOypc1kOvudN7cdb8DmMopLhLhsNIAA7Yaol
    KFNP8WilLaN8Qe376ua1s/SOLHVuUhH/XMbwwChJ2N1R2Rsn5WV7EyZOIboQ+mD9
    NEwpAVZe+hTbAwihYxnIsS5x7p6lZYpWo1ggDLjddroefAtjFgdDORFQ7hjiiDvG
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=iiMBy100 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=iiMBy100 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfEjBhgVpedtIX4C7BAot8Rxp4Vyzb21+nXEJDuKsWedmMPG7jMEF+zp/vv4b7wIe6E5+a29/uc3ia8z6HSt9tM0HixlS1qFTVhIHx7H58IiRtjhP6FdB
    Sx8Y9sPFIUENIoLQyElJ1K7K8rgzwGvA3HB6veMq7OxoGXoNIxvbjI6JlLaf3Ax+ZqY05x3lp5xY37HxubzpR7J5Fln6aemqyU23E9xkTBmr3JjpsZSK3zdY
    1ru3GFAcOm4X8Ab/lo8Sgw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=8DPXs7LdIecfLW14igUA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 03/40] proc: add a proc_create_reg helper
Date: Wed, 25 Apr 2018 17:47:50 +0200
Message-Id: <20180425154827.32251-4-hch@lst.de>
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

Common code for creating a regular file.  Factor out of proc_create_data, to
be reused by other functions soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/generic.c  | 44 +++++++++++++++++++++++++-------------------
 fs/proc/internal.h |  2 ++
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index bd8480ff0d35..ab6a321076b8 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -511,33 +511,39 @@ struct proc_dir_entry *proc_create_mount_point(const char *name)
 }
 EXPORT_SYMBOL(proc_create_mount_point);
 
-struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
-					struct proc_dir_entry *parent,
-					const struct file_operations *proc_fops,
-					void *data)
+struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
+		struct proc_dir_entry **parent, void *data)
 {
-	struct proc_dir_entry *pde;
+	struct proc_dir_entry *p;
+
 	if ((mode & S_IFMT) == 0)
 		mode |= S_IFREG;
-
-	if (!S_ISREG(mode)) {
-		WARN_ON(1);	/* use proc_mkdir() */
+	if ((mode & S_IALLUGO) == 0)
+		mode |= S_IRUGO;
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return NULL;
+
+	p = __proc_create(parent, name, mode, 1);
+	if (p) {
+		p->proc_iops = &proc_file_inode_operations;
+		p->data = data;
 	}
+	return p;
+}
+
+struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
+		struct proc_dir_entry *parent,
+		const struct file_operations *proc_fops, void *data)
+{
+	struct proc_dir_entry *p;
 
 	BUG_ON(proc_fops == NULL);
 
-	if ((mode & S_IALLUGO) == 0)
-		mode |= S_IRUGO;
-	pde = __proc_create(&parent, name, mode, 1);
-	if (!pde)
-		goto out;
-	pde->proc_fops = proc_fops;
-	pde->data = data;
-	pde->proc_iops = &proc_file_inode_operations;
-	return proc_register(parent, pde);
-out:
-	return NULL;
+	p = proc_create_reg(name, mode, &parent, data);
+	if (!p)
+		return NULL;
+	p->proc_fops = proc_fops;
+	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
  
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 488e67490312..dd1e11400b97 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,6 +162,8 @@ extern bool proc_fill_cache(struct file *, struct dir_context *, const char *, i
 /*
  * generic.c
  */
+struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
+		struct proc_dir_entry **parent, void *data);
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp);
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
