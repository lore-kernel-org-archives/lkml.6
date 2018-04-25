Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671500-2-390368889782089342
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
    1524671499; b=LVypTB3KumdO1WZASQqstn+WyAqcpS1mHZn70adqB5en1oHSd+
    jNPfEAD4+QUbKBBH5rTvcI75uZCn6eLapm6ikYDltMvQAke6serGR5pLnGuU3VPr
    FC9EAJlcQjN5tvC1j88uCF3K95CxR9iTQ6omk2QWS5L4BS4mF5ZuOW9h743sPRD9
    uebwilAMLLKomFXjlj2srlKFZERfTE3RkpR1BR3FQqSngAYSSNtoJ9opW9Y5aE9V
    Qg7lGfk9RkvAsGgLXgq5ArAxCz9iLgbLbNZb98fF+2fFK4mgDwxryLtS+hm/yVxL
    xGR3gcmPDw9LooaIlWtboftQXO5aXzEh4CIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671499; bh=LIUo7
    U2MrJxv8S1qeDZX0bTP0S20yCgTilfkeaerTUo=; b=vANuoPNu6OJhn5HjeaUps
    LZMVCA5ZGTR+ZreAglD0R0bDs11IpymAk9nVPGbNT/Db/qhy92yTUSN4D8PC2yAC
    GZ0XM5rvB8rdvFFlh/FmVVRkCkZPVVyI03nqMQWL0wcmB1Vk3oUwedY05zppdurP
    NEUevv0tQ4GeSAMwSW/FvamxgF1x7fP8tyrsH9S7jV2dTQ/f4x+Xra2owRiAyTPu
    puobPOS6FHEAQ5qz+fU8zl9a+nHKM8sOoXBuMzKxJbHDJAni+ojK4J8EI9cCCa1i
    I41ALAaRhhxnELp4vdNAVZ+xc9W2qaG7oidRSpimQrv5IzFRipqH6mWOSBX2+T5C
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dF1AbVZm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dF1AbVZm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfN+t3EatLc0A0fRickmnxLvDS3imYZfc9r9DaOeZI7bTxcWB4+auRYkYjM3wF8nhoEA15McripKz+bsF12HvAhaTP1oX7CY14xmi07X/MoGbGkICQWGL
    6DIq4M1s71V66GBTu1Pux+j/LkfsARy7rJRuuzwTAE13UKdFOrCpUYVifhFyKKzMsb4px9IQAXCmaLvNF6etz7AT3bmInCaCPsDKjFpZwa5MXo3JGWGLTER2
    mRceo+e3aceohQQBk7OX/g==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=l8C3SgQkY9CvROynupgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 35/40] atm: switch to proc_create_seq_private
Date: Wed, 25 Apr 2018 17:48:22 +0200
Message-Id: <20180425154827.32251-36-hch@lst.de>
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
