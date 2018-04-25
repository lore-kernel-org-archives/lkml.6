Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671469-2-16661156555973685861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671468; b=M7KLZvEHB1+c/h0jc62qW68q5J6mwoj7PYZ8fJBc+yaWvNWyGa
    hObPfBDEYj/xmb8WndWyG1tL1lulxhrV9njYRPcGyttu3QdyXyAK0CGMhQxmKTPP
    K9WBFOEz5y5srvzMPYpkzHNGUsevg0ftZ1SCicfCPwQ1REC9Bs4cuSALrvMY8TDH
    WJqif49JGg3HrCqMJbGBNi2HPhYF5aeFo3PY3n+5JbEPXQw45mmzxah8iU9XSzTK
    0qU4ye1y6kWaHlkROcYZApu7rZhMh2mbAI6c28zBR0OSxa/eS5SUgSPUNHYZYgSx
    deKyOrjYAkLKD99tyh7QClklm5qfjBiOFBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671468; bh=NyiCL
    J8CTnATpHBi6Heo9k9QkaWP4WMnZwDHKiKWyFc=; b=X+Msd2bm45Do020LoSNfy
    q9lUX2ek9aTTO0fDvNnizIntUTH+1KIJKezc7IEM4yoo/DxgulzCcxJwW02C+Bx+
    Z+bLebhqeZbGZqmx7DhOLFhoU9LLyHwljxzk43lI9MmdXuPymr0FMLlUWWnOrjmd
    pUrSCB8TwOIUxBaynB5JussbOi5xnEwGeuJJcPJ2l/7dOXEIpwClWIt0XfuTygDq
    Fqdp+686q67TsQfgF7YnsaFp2WdEd0deW5N8L+cCxb+oKjtiu4s0Qp7ZnH5wrPnX
    EIa+O3PqRZqgy3Zb2Ta2dUL9yZS9cLpP8qYi+ssbDAh/HqXz12eqXE8+rpBHGiYq
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=OEbYjW/e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=OEbYjW/e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfCPA81/WZcQirbGYpfQfa+fZGvPBCaT7UQFO+KhtCRvtXsoqB0a50JVx8rKcrzhBzYJDS9WrzXG3seizFxbqgVK6Yj1fIqG+G8DN8mkqTDoSRXre1d9g
    u5KVFfJYp5fYiGc59MEI4ngT9azUmaq8mEfYl/9OAXignHgo8IEtK07LzdSfSFbJaPugdDxLCiXwy6ljRSiXbyoWPcXp+NJW0M5eeYJbPYYpzYbwmVlzY9Yw
    swAzu4KIIS+6vafupXITlA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=t6QSO1cpVmbLQ1TD7QsA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 25/40] resource: switch to proc_create_seq_data
Date: Wed, 25 Apr 2018 17:48:12 +0200
Message-Id: <20180425154827.32251-26-hch@lst.de>
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

And use the root resource directly from the proc private data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/resource.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2af6c03858b9..b589dda910b3 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -87,7 +87,7 @@ enum { MAX_IORES_LEVEL = 5 };
 static void *r_start(struct seq_file *m, loff_t *pos)
 	__acquires(resource_lock)
 {
-	struct resource *p = m->private;
+	struct resource *p = PDE_DATA(file_inode(m->file));
 	loff_t l = 0;
 	read_lock(&resource_lock);
 	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
@@ -103,7 +103,7 @@ static void r_stop(struct seq_file *m, void *v)
 
 static int r_show(struct seq_file *m, void *v)
 {
-	struct resource *root = m->private;
+	struct resource *root = PDE_DATA(file_inode(m->file));
 	struct resource *r = v, *p;
 	unsigned long long start, end;
 	int width = root->end < 0x10000 ? 4 : 8;
@@ -135,44 +135,11 @@ static const struct seq_operations resource_op = {
 	.show	= r_show,
 };
 
-static int ioports_open(struct inode *inode, struct file *file)
-{
-	int res = seq_open(file, &resource_op);
-	if (!res) {
-		struct seq_file *m = file->private_data;
-		m->private = &ioport_resource;
-	}
-	return res;
-}
-
-static int iomem_open(struct inode *inode, struct file *file)
-{
-	int res = seq_open(file, &resource_op);
-	if (!res) {
-		struct seq_file *m = file->private_data;
-		m->private = &iomem_resource;
-	}
-	return res;
-}
-
-static const struct file_operations proc_ioports_operations = {
-	.open		= ioports_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static const struct file_operations proc_iomem_operations = {
-	.open		= iomem_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int __init ioresources_init(void)
 {
-	proc_create("ioports", 0, NULL, &proc_ioports_operations);
-	proc_create("iomem", 0, NULL, &proc_iomem_operations);
+	proc_create_seq_data("ioports", 0, NULL, &resource_op,
+			&ioport_resource);
+	proc_create_seq_data("iomem", 0, NULL, &resource_op, &iomem_resource);
 	return 0;
 }
 __initcall(ioresources_init);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
