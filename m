Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526464036-2-4209882894518987295
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
    1526464035; b=gFSeXWD9Ml4g68hsTmYiRHbrh9XP+oRwnJKYEKHD7GcJEaFJkV
    RmARbbeQLj6ZHPb2kasumXER5d2gpd0QQoC46TkvfceSbV8V0rnBqz1Rvjp//eM7
    GjjynvBfEIHQLI8KAoRVRmjgeUTLt159pfilW3+1BSLlzIAfnet/xsR4MECnktjE
    lSsjldSZ922/kOsBEGJRqpHSdO+8WypTR2w/ZBT3cCKK4SlpLtijuY6fe3tUnUhA
    ahvBR2fy9LbwV287qY94hb3mnzEGDz+y98O4wCvT7O1R9R5sje8m1sXGykNyI9vf
    3bn+Nvcny7QV4xXYz3uqpnpznSqGiQCyD6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464035; bh=EyfX8
    bWv2HVLPA2eYnJNC9dk1oKYEvPVQeAxgLePSpo=; b=KVA8bC4C3gRnUkcTXoATs
    XJggozMHTNU/+gVQQIPu55s/xEyjjOYFGxY2yB0kUe0qV8KQ8HfRZX2wbVXGSFE5
    UeROrvkuiZDkkn3ebus3fFdcUtOaxhhgVWa9bB5NL8RqNQsZRiajAxaLq1q790hz
    kkgVSL8mGhLZvGfOkt/AONpPe6w6R/UbnBI8pGDN/DPqrKTuVxaw+fCfOp+9/n8o
    4wjVnA4ToGEeua8WdDnbZgpVyV3VWWOFnFChkM5Y6P8gDIQyRK6PRrd1URIaDPiW
    oCT4HnZYM8zrDC5gqG7WdFLxsmEbs+PpAlrngV3PxadeMihaK4QI6kdsg8pkhi/8
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=r7q0M5WJ
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=r7q0M5WJ
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
X-CM-Envelope: MS4wfHH6B4Jp5SoQ1FmZCf4Flauwm1Ismfm1333yout53+nNVnUm9l5qwG651Hy+R1EIVp0s/geCxLQDPx3AKfRFWWMagPthBcRiF9bGa6L4smQ3ahk4dSRB
    oEle23f5/HzaTgT955PdjORRfNJwHNo9RBZy/N5aGKw0GbFwAN9B4EWjmIirzRv7QUFT/UsESNl3WWC0ozcydia8FetWDnOQY4pkt5Rs4smyCRIpSucOrFzK
    lDdSsF8++o1YffIX9fgRAw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=zMiHMkJPCD3nLd7roHIA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 33/42] netfilter/xt_hashlimit: switch to proc_create_{seq,
 single}_data
Date: Wed, 16 May 2018 11:43:37 +0200
Message-Id: <20180516094346.20506-34-hch@lst.de>
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
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/xt_hashlimit.c | 92 +++++++-----------------------------
 1 file changed, 18 insertions(+), 74 deletions(-)

diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 0cd73567e7ff..9b16402f29af 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -57,9 +57,9 @@ static inline struct hashlimit_net *hashlimit_pernet(struct net *net)
 }
 
 /* need to declare this at the top */
-static const struct file_operations dl_file_ops_v2;
-static const struct file_operations dl_file_ops_v1;
-static const struct file_operations dl_file_ops;
+static const struct seq_operations dl_seq_ops_v2;
+static const struct seq_operations dl_seq_ops_v1;
+static const struct seq_operations dl_seq_ops;
 
 /* hash table crap */
 struct dsthash_dst {
@@ -272,7 +272,7 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 {
 	struct hashlimit_net *hashlimit_net = hashlimit_pernet(net);
 	struct xt_hashlimit_htable *hinfo;
-	const struct file_operations *fops;
+	const struct seq_operations *ops;
 	unsigned int size, i;
 	int ret;
 
@@ -321,19 +321,19 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 
 	switch (revision) {
 	case 1:
-		fops = &dl_file_ops_v1;
+		ops = &dl_seq_ops_v1;
 		break;
 	case 2:
-		fops = &dl_file_ops_v2;
+		ops = &dl_seq_ops_v2;
 		break;
 	default:
-		fops = &dl_file_ops;
+		ops = &dl_seq_ops;
 	}
 
-	hinfo->pde = proc_create_data(name, 0,
+	hinfo->pde = proc_create_seq_data(name, 0,
 		(family == NFPROTO_IPV4) ?
 		hashlimit_net->ipt_hashlimit : hashlimit_net->ip6t_hashlimit,
-		fops, hinfo);
+		ops, hinfo);
 	if (hinfo->pde == NULL) {
 		kfree(hinfo->name);
 		vfree(hinfo);
@@ -1057,7 +1057,7 @@ static struct xt_match hashlimit_mt_reg[] __read_mostly = {
 static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 	__acquires(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket;
 
 	spin_lock_bh(&htable->lock);
@@ -1074,7 +1074,7 @@ static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 
 static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 
 	*pos = ++(*bucket);
@@ -1088,7 +1088,7 @@ static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 static void dl_seq_stop(struct seq_file *s, void *v)
 	__releases(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 
 	if (!IS_ERR(bucket))
@@ -1130,7 +1130,7 @@ static void dl_seq_print(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1145,7 +1145,7 @@ static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1160,7 +1160,7 @@ static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 			    struct seq_file *s)
 {
-	const struct xt_hashlimit_htable *ht = s->private;
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1174,7 +1174,7 @@ static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 
 static int dl_seq_show_v2(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = (unsigned int *)v;
 	struct dsthash_ent *ent;
 
@@ -1188,7 +1188,7 @@ static int dl_seq_show_v2(struct seq_file *s, void *v)
 
 static int dl_seq_show_v1(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1202,7 +1202,7 @@ static int dl_seq_show_v1(struct seq_file *s, void *v)
 
 static int dl_seq_show(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = s->private;
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1235,62 +1235,6 @@ static const struct seq_operations dl_seq_ops = {
 	.show  = dl_seq_show
 };
 
-static int dl_proc_open_v2(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops_v2);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static int dl_proc_open_v1(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops_v1);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static int dl_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &dl_seq_ops);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations dl_file_ops_v2 = {
-	.open    = dl_proc_open_v2,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations dl_file_ops_v1 = {
-	.open    = dl_proc_open_v1,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
-static const struct file_operations dl_file_ops = {
-	.open    = dl_proc_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
 static int __net_init hashlimit_proc_net_init(struct net *net)
 {
 	struct hashlimit_net *hashlimit_net = hashlimit_pernet(net);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
