Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3170045-1524143227-2-17608553523321619913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: subject='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524143225; b=latoLE6tK47eeRajubflPt+Wif9wnMWJqUrmCqPcZb38jXpvWT
    IAl4YGf4sXOqQ75k95vSjTeXmjemqzUv3Ale+ZTTBHNZkMDvFZY9226PhoTxC4lf
    p2yk6g6YeO4sIAi/ArtToLp1AYDGkT/4c4eulhO/XA13DTAlcYbW3xIq5uj0lhXi
    RHvRzyq1R2DbG5/xnt7O0wXvlzL4XJgy6RB7ytvvbeLQCGh6HcIDEymrj0CqBQfC
    WdDgvoILPTkDSxfuC7MELx1/6gbLx8arVYaDOqGE4Cin9EYM/ADFgS17CCOpAJ9Q
    XOOJUA/+6hN7EBkuptlHjiGqNw56jGlzJ5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524143225; bh=U7kd+
    9lIoFW9y2dhX3fS1mB0vgY5jtio+/mpm6deD/k=; b=kFzpq1a20jaNX1DZDmxrY
    KtdK7iLKUggWVmivJpX74C6rb/4P8x+T6SoEIydLhvAOQzVV5TP+DKfMdmzZPuhK
    5xd85YESThPDU4joy4Nuuna1skkoDbDZU5Eh8iLEev8fZ/2kj/6Vexo//TOB4NOW
    69oLFlhZjP6w8tzKUw32bNak+iBLYUrjhrFDpwefb7odDITfgzWK6/J3Gad3no3E
    zgYo69WvODsUVyDeGr+WXAdLoT5ZzhRw94s4ss7YKtm9f1uLLdug0r9O74845U1X
    sGMA/T40pwm/W6icgTbDBgzCqzwwH1fSi0HFC7W5fJozzc6e5qlTy7Wz93xYx2KS
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Tajj9mib x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Tajj9mib x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfAxhCIZt5C++KdaF+yOVpsjAIKM2F0JQcf4eyqSjNHuTSlO0eqhia/aTBQv+ANPfeoGWJ9uubf1nj0xpeqIn+UpNV+7IrrYds9vleP4Q/E9eAu1uWbnJ
    1O9at2v+wQz1FBs8yZZFwtN2biAqSBm/TGismTUDntYTwI/jhexf2MCAiKgtuk09NVFPaE8zenFdfc215wqh2RfTke98MVFck31mnxhxG2Cw0wwQA+W10Cyv
    H9fnGk2H9Dt+9Ck1BBDKog==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=PoB0_FCGx-x5zM6ZuW0A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 11/39] =?UTF-8?q?netfilter/x=5Ftables:=20simplify=20=D1=95?=
 =?UTF-8?q?eq=5Ffile=20code?=
Date: Thu, 19 Apr 2018 14:41:12 +0200
Message-Id: <20180419124140.9309-12-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
MIME-Version: 1.0
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
 Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Just use the address family from the proc private data instead of copying
it into per-file data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/x_tables.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 71325fef647d..3704101af27f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1489,15 +1489,10 @@ void *xt_unregister_table(struct xt_table *table)
 EXPORT_SYMBOL_GPL(xt_unregister_table);
 
 #ifdef CONFIG_PROC_FS
-struct xt_names_priv {
-	struct seq_net_private p;
-	u_int8_t af;
-};
 static void *xt_table_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct xt_names_priv *priv = seq->private;
 	struct net *net = seq_file_net(seq);
-	u_int8_t af = priv->af;
+	u_int8_t af = (unsigned long)PDE_DATA(file_inode(seq->file));
 
 	mutex_lock(&xt[af].mutex);
 	return seq_list_start(&net->xt.tables[af], *pos);
@@ -1505,17 +1500,15 @@ static void *xt_table_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *xt_table_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct xt_names_priv *priv = seq->private;
 	struct net *net = seq_file_net(seq);
-	u_int8_t af = priv->af;
+	u_int8_t af = (unsigned long)PDE_DATA(file_inode(seq->file));
 
 	return seq_list_next(v, &net->xt.tables[af], pos);
 }
 
 static void xt_table_seq_stop(struct seq_file *seq, void *v)
 {
-	struct xt_names_priv *priv = seq->private;
-	u_int8_t af = priv->af;
+	u_int8_t af = (unsigned long)PDE_DATA(file_inode(seq->file));
 
 	mutex_unlock(&xt[af].mutex);
 }
@@ -1538,16 +1531,8 @@ static const struct seq_operations xt_table_seq_ops = {
 
 static int xt_table_open(struct inode *inode, struct file *file)
 {
-	int ret;
-	struct xt_names_priv *priv;
-
-	ret = seq_open_net(inode, file, &xt_table_seq_ops,
-			   sizeof(struct xt_names_priv));
-	if (!ret) {
-		priv = ((struct seq_file *)file->private_data)->private;
-		priv->af = (unsigned long)PDE_DATA(inode);
-	}
-	return ret;
+	return seq_open_net(inode, file, &xt_table_seq_ops,
+			sizeof(struct seq_net_private));
 }
 
 static const struct file_operations xt_table_ops = {
@@ -1563,7 +1548,7 @@ static const struct file_operations xt_table_ops = {
  */
 struct nf_mttg_trav {
 	struct list_head *head, *curr;
-	uint8_t class, nfproto;
+	uint8_t class;
 };
 
 enum {
@@ -1580,6 +1565,7 @@ static void *xt_mttg_seq_next(struct seq_file *seq, void *v, loff_t *ppos,
 		[MTTG_TRAV_NFP_UNSPEC] = MTTG_TRAV_NFP_SPEC,
 		[MTTG_TRAV_NFP_SPEC]   = MTTG_TRAV_DONE,
 	};
+	uint8_t nfproto = (unsigned long)PDE_DATA(file_inode(seq->file));
 	struct nf_mttg_trav *trav = seq->private;
 
 	switch (trav->class) {
@@ -1594,9 +1580,9 @@ static void *xt_mttg_seq_next(struct seq_file *seq, void *v, loff_t *ppos,
 		if (trav->curr != trav->head)
 			break;
 		mutex_unlock(&xt[NFPROTO_UNSPEC].mutex);
-		mutex_lock(&xt[trav->nfproto].mutex);
+		mutex_lock(&xt[nfproto].mutex);
 		trav->head = trav->curr = is_target ?
-			&xt[trav->nfproto].target : &xt[trav->nfproto].match;
+			&xt[nfproto].target : &xt[nfproto].match;
 		trav->class = next_class[trav->class];
 		break;
 	case MTTG_TRAV_NFP_SPEC:
@@ -1628,6 +1614,7 @@ static void *xt_mttg_seq_start(struct seq_file *seq, loff_t *pos,
 
 static void xt_mttg_seq_stop(struct seq_file *seq, void *v)
 {
+	uint8_t nfproto = (unsigned long)PDE_DATA(file_inode(seq->file));
 	struct nf_mttg_trav *trav = seq->private;
 
 	switch (trav->class) {
@@ -1635,7 +1622,7 @@ static void xt_mttg_seq_stop(struct seq_file *seq, void *v)
 		mutex_unlock(&xt[NFPROTO_UNSPEC].mutex);
 		break;
 	case MTTG_TRAV_NFP_SPEC:
-		mutex_unlock(&xt[trav->nfproto].mutex);
+		mutex_unlock(&xt[nfproto].mutex);
 		break;
 	}
 }
@@ -1680,8 +1667,6 @@ static int xt_match_open(struct inode *inode, struct file *file)
 	trav = __seq_open_private(file, &xt_match_seq_ops, sizeof(*trav));
 	if (!trav)
 		return -ENOMEM;
-
-	trav->nfproto = (unsigned long)PDE_DATA(inode);
 	return 0;
 }
 
@@ -1732,8 +1717,6 @@ static int xt_target_open(struct inode *inode, struct file *file)
 	trav = __seq_open_private(file, &xt_target_seq_ops, sizeof(*trav));
 	if (!trav)
 		return -ENOMEM;
-
-	trav->nfproto = (unsigned long)PDE_DATA(inode);
 	return 0;
 }
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
