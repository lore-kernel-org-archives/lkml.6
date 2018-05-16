Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526464048-2-6796971318919097043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526464047; b=LTeBGq9JT6zXskkHBMTTgGMCHOVQSedq8nqlPMsetW6pk3fjUm
    di6/rnz7PA02PWpg6R51/TORCk8hbdD1OH+MDUKQXu8w0s8nQF1yg4iZ4jy6VZy4
    6/OkhcL7wrB5ijDvIhD6QIbjoRy+ClqanpyneWBs/qxEGkQfPQ8k6Aa9BwDgdpKN
    9gXUOAqUPtPBoA7V7Vn4AnAIhYvt+8GiTak90EIBDT4IXlEiJr0fCI0g1pQ0y14P
    JxDyOhbjw2JhzvZa1FJpPzDH3Fwq+wox7x0QxoQscotFpwzMqQCgb3Yl/iePtDnd
    QOHZzcn83DV1el+t1F6/YFFQQIw437mj1lIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464047; bh=LIUo7
    U2MrJxv8S1qeDZX0bTP0S20yCgTilfkeaerTUo=; b=ftLzxKCZRT5P1gxqpITsi
    GZLD6i9a78HvdKLUQtNiDc8hGvskXk62dm8BarzJ1Zw3t6oq1wEvuWuJlTYibkSo
    wrFF/eKcM/+Q/hvvCKrbyRAg/cGFh5Nbc1RvvoTTC3Gj6fgSYBzRXHDttW9kHLPL
    Dwsru/Zb0PzXGj6/wHKpk9RomqF2AiRdzz1jJ/cwKe0eladLM3VO9Xt9313AaPn6
    9RhUfvdwpqSfeH94RI/jqywmxeo4fs04C+uFOPbEhr5h6HI7I5z1lRB9OLMJBptV
    tARKkoKG3SZNgQ6NCiU3EHCXK8ZSqnCxb/YW4pH31/m2Z2Wrjj3OOjGularHgUU3
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=hQlkFaIu
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=hQlkFaIu
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB7erFwYgwfXsiv5dX0Y4RwhvkD1AZRmdeu9hJKqbx0M9hFWLK5PNJ6UC2ROECBcEKOLm4dP+cxM4YQfFVrTFXB5fVN2G6wNxVYJSwoF2yDqr1c9A/W6
    0/f+XhGpNgJDdqIjEyHpt/b4ctoPawfk8nX0peI8RI82EsstvcZeDcO7xIwfoviMCs7MbDEs7g/B0hFvsoKzq8d3xqRnFG60IlrkZi1YwOpltwPLNob4PmGj
    xSbNjElMLCgofZwVogT6sw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=l8C3SgQkY9CvROynupgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 37/42] atm: switch to proc_create_seq_private
Date: Wed, 16 May 2018 11:43:41 +0200
Message-Id: <20180516094346.20506-38-hch@lst.de>
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

And remove proc boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/atm/proc.c | 72 +++++++++-----------------------------------------
 1 file changed, 13 insertions(+), 59 deletions(-)

diff --git a/net/atm/proc.c b/net/atm/proc.c
index f272b0f59d82..0b0495a41bbe 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -68,7 +68,6 @@ static void atm_dev_info(struct seq_file *seq, const struct atm_dev *dev)
 struct vcc_state {
 	int bucket;
 	struct sock *sk;
-	int family;
 };
 
 static inline int compare_family(struct sock *sk, int family)
@@ -106,23 +105,13 @@ static int __vcc_walk(struct sock **sock, int family, int *bucket, loff_t l)
 	return (l < 0);
 }
 
-static inline void *vcc_walk(struct vcc_state *state, loff_t l)
+static inline void *vcc_walk(struct seq_file *seq, loff_t l)
 {
-	return __vcc_walk(&state->sk, state->family, &state->bucket, l) ?
-	       state : NULL;
-}
-
-static int __vcc_seq_open(struct inode *inode, struct file *file,
-	int family, const struct seq_operations *ops)
-{
-	struct vcc_state *state;
-
-	state = __seq_open_private(file, ops, sizeof(*state));
-	if (state == NULL)
-		return -ENOMEM;
+	struct vcc_state *state = seq->private;
+	int family = (uintptr_t)(PDE_DATA(file_inode(seq->file)));
 
-	state->family = family;
-	return 0;
+	return __vcc_walk(&state->sk, family, &state->bucket, l) ?
+	       state : NULL;
 }
 
 static void *vcc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -133,7 +122,7 @@ static void *vcc_seq_start(struct seq_file *seq, loff_t *pos)
 
 	read_lock(&vcc_sklist_lock);
 	state->sk = SEQ_START_TOKEN;
-	return left ? vcc_walk(state, left) : SEQ_START_TOKEN;
+	return left ? vcc_walk(seq, left) : SEQ_START_TOKEN;
 }
 
 static void vcc_seq_stop(struct seq_file *seq, void *v)
@@ -144,9 +133,7 @@ static void vcc_seq_stop(struct seq_file *seq, void *v)
 
 static void *vcc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct vcc_state *state = seq->private;
-
-	v = vcc_walk(state, 1);
+	v = vcc_walk(seq, 1);
 	*pos += !!PTR_ERR(v);
 	return v;
 }
@@ -280,18 +267,6 @@ static const struct seq_operations pvc_seq_ops = {
 	.show	= pvc_seq_show,
 };
 
-static int pvc_seq_open(struct inode *inode, struct file *file)
-{
-	return __vcc_seq_open(inode, file, PF_ATMPVC, &pvc_seq_ops);
-}
-
-static const struct file_operations pvc_seq_fops = {
-	.open		= pvc_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release_private,
-};
-
 static int vcc_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == SEQ_START_TOKEN) {
@@ -314,18 +289,6 @@ static const struct seq_operations vcc_seq_ops = {
 	.show	= vcc_seq_show,
 };
 
-static int vcc_seq_open(struct inode *inode, struct file *file)
-{
-	return __vcc_seq_open(inode, file, 0, &vcc_seq_ops);
-}
-
-static const struct file_operations vcc_seq_fops = {
-	.open		= vcc_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release_private,
-};
-
 static int svc_seq_show(struct seq_file *seq, void *v)
 {
 	static const char atm_svc_banner[] =
@@ -349,18 +312,6 @@ static const struct seq_operations svc_seq_ops = {
 	.show	= svc_seq_show,
 };
 
-static int svc_seq_open(struct inode *inode, struct file *file)
-{
-	return __vcc_seq_open(inode, file, PF_ATMSVC, &svc_seq_ops);
-}
-
-static const struct file_operations svc_seq_fops = {
-	.open		= svc_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release_private,
-};
-
 static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
 				 size_t count, loff_t *pos)
 {
@@ -434,9 +385,12 @@ int __init atm_proc_init(void)
 	if (!atm_proc_root)
 		return -ENOMEM;
 	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
-	proc_create("pvc", 0444, atm_proc_root, &pvc_seq_fops);
-	proc_create("svc", 0444, atm_proc_root, &svc_seq_fops);
-	proc_create("vc", 0444, atm_proc_root, &vcc_seq_fops);
+	proc_create_seq_private("pvc", 0444, atm_proc_root, &pvc_seq_ops,
+			sizeof(struct vcc_state), (void *)(uintptr_t)PF_ATMPVC);
+	proc_create_seq_private("svc", 0444, atm_proc_root, &svc_seq_ops,
+			sizeof(struct vcc_state), (void *)(uintptr_t)PF_ATMSVC);
+	proc_create_seq_private("vc", 0444, atm_proc_root, &vcc_seq_ops,
+			sizeof(struct vcc_state), NULL);
 	return 0;
 }
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
