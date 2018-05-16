Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526464041-2-225271588440346128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526464040; b=YXybVHQnpfApOQXpOzHTH6KKm8NU/+h6WyHTWRZRCk1KAC6l2Z
    u5H7rbR0QlevIJ/Zfe9vfIRUm9kasJy1GDl45KOBa7H9zCynoc8h0E3/xw35Lqs6
    PxtnEZkIry7zGmKmX7ou17IvHcNf29Q5hAoQ928g7wewZIVaQMYlPEHo0czynLu8
    hSSx6nD70yvROtRFwaVs+WOKYUaLhzgap/KwgC/og/bi4ckDUCbvkNJ3W95NXaGl
    eDjXKCCyoxynstjYSlg7txyzkX2pJ/9T16u+FUigJehgeQ0h2MFYiug3s3+3BeY7
    9tVbyCCJJ++8D69YosNmGaFXT+XkcY8htDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464040; bh=UICY+
    JWGYSkSKEo0fdTu86zeErcvHZGpMGiarak+1Hk=; b=nRfD88mTbJT5vaL9T9o2L
    mqgKvib1+MidNf4eiETogbFhzzsmewldZcwiJgK+WG5bTSoHDuYK/hUBuOM5Bv2X
    Wy0ZxyDhTePFdoaVwOdJht5iAWyy42BRtDHtpI5d5NAT88P2Grc7tjpl1Ajp9udf
    XI46HEnSaV91rDR8Tgd9I1OomdyVe1v3dzRASuxqLbLwnXwzBqFSLMsFy/VReg7f
    JM9B1U3q7jFh2FrFscz9oL49f1p81QWFORtB1AAzf7zRhtaUtDHLVJXSxl04kR55
    SlKwK1G6MGvcEbkIXHKGqq96wZqh4yAAaDqnGojmRW5akpmcSUUl2A3Tsla+5EUW
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=rPNoTs2T
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
      header.d=infradead.org header.i=@infradead.org header.b=rPNoTs2T
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
X-CM-Envelope: MS4wfBhffOYEJPECrfBOIK7umzAp4SldPz3LbwWmz4aONE60uLHtTIhZdE2pn4DMtlA+/I+ULnE1Br1bnWpLX+7UvNdYxOJ73VbyZEONoCp/7JXJBf118nl7
    zGq/VI6nqoY6XwvE/S7znOLDJF82QZDKoqr4w+HL0iPwD95bI0MMVnoEuxck2FfC4Jp+bSDXI7ZVYqBbA0OjAYV3X0+qZqa5IXvkCxQ1a7Z43SggvmZwt+oD
    VsEoCzvS16Rpq3F2bx9vIQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=HNAarusrsSmAjpa1ALsA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 35/42] bluetooth: switch to proc_create_seq_data
Date: Wed, 16 May 2018 11:43:39 +0200
Message-Id: <20180516094346.20506-36-hch@lst.de>
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

And use proc private data directly instead of doing a detour
through seq->private and private state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/bluetooth/af_bluetooth.c | 40 +++++-------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 84d92a077834..3264e1873219 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -605,15 +605,10 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
 EXPORT_SYMBOL(bt_sock_wait_ready);
 
 #ifdef CONFIG_PROC_FS
-struct bt_seq_state {
-	struct bt_sock_list *l;
-};
-
 static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(seq->private->l->lock)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	read_lock(&l->lock);
 	return seq_hlist_start_head(&l->head, *pos);
@@ -621,8 +616,7 @@ static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	return seq_hlist_next(v, &l->head, pos);
 }
@@ -630,16 +624,14 @@ static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void bt_seq_stop(struct seq_file *seq, void *v)
 	__releases(seq->private->l->lock)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	read_unlock(&l->lock);
 }
 
 static int bt_seq_show(struct seq_file *seq, void *v)
 {
-	struct bt_seq_state *s = seq->private;
-	struct bt_sock_list *l = s->l;
+	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq ,"sk               RefCnt Rmem   Wmem   User   Inode  Parent");
@@ -681,35 +673,13 @@ static const struct seq_operations bt_seq_ops = {
 	.show  = bt_seq_show,
 };
 
-static int bt_seq_open(struct inode *inode, struct file *file)
-{
-	struct bt_sock_list *sk_list;
-	struct bt_seq_state *s;
-
-	sk_list = PDE_DATA(inode);
-	s = __seq_open_private(file, &bt_seq_ops,
-			       sizeof(struct bt_seq_state));
-	if (!s)
-		return -ENOMEM;
-
-	s->l = sk_list;
-	return 0;
-}
-
-static const struct file_operations bt_fops = {
-	.open = bt_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release_private
-};
-
 int bt_procfs_init(struct net *net, const char *name,
 		   struct bt_sock_list *sk_list,
 		   int (* seq_show)(struct seq_file *, void *))
 {
 	sk_list->custom_seq_show = seq_show;
 
-	if (!proc_create_data(name, 0, net->proc_net, &bt_fops, sk_list))
+	if (!proc_create_seq_data(name, 0, net->proc_net, &bt_seq_ops, sk_list))
 		return -ENOMEM;
 	return 0;
 }
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
