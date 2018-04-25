Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671489-2-17618170924934444878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671488; b=DD6fXE0NFzGFOpAjWLASn4uYxeFmEI6uzRq9yf0iVYrgj78AEn
    XpZVjVpitdrHiC638ItATkNADyrvDDkPfISGExj2aMbPGC+xCyCejoCWHtU02K0a
    ar+xl6aKWt1H0OryY3qxZmJbrPNwwzSLKggs2c/+TpQBKsaJMu3URxq9TkZtl4lp
    heXCstyKb7y1CLtOR1dzhUKOnz3Cc+P+uRJncdm/sROwintBOGQGszegGV/sscjh
    BHZvTwxuldbCnBzLpq+AzlS8jVbJ8fBGw86DV/OBYFpR05KoSPQydO/RpH7+c0yV
    Jn5mgy5xwOmnNcXhI6c3GdyfEPnJr39l16LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671488; bh=EyfX8
    bWv2HVLPA2eYnJNC9dk1oKYEvPVQeAxgLePSpo=; b=Ddw7FKY5Q7PayjssoFl4Y
    l/1HenxJK7MZ9ZvvwZy8UeCyM0VviU0GkdGk0MH9shK+PtmIa+H9X0d5xn8mUkT8
    TE95y5lBMmkC6foXe/2OwxIqQLNj2gPM35vElsuCHi7xOrU0WRNiC+3gRzxwmXgq
    D2TZVV5lbliRNB9igZHsvpLYIV5ShxNvnlJqQx9+5fF8hXTtwtrkzSdZqTLFpXq4
    rLPpId1tLbOeOZ4bedTOxRm+8h+zBut8rGAPW4WfKJfMxYcmuh/oJeR2g/rA42+y
    s2jOi/z/gWInunB6r2YkeOhstJAsVTvO+z6ix71MXbnjtvx5irXHo32+EZBpOEWE
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=B+hkCEN3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=B+hkCEN3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfBApv9kMtMQx0odtwDQdiUxFHwobiKqjDJKOzxLJYizxFhtcdufx2bA6Y9FvZh1uCmWzm5IE8Sy9qit+lorsal1XOcggMJl1i1Y9qXX9eNIa9clGSogl
    WSE9dXL9qkRpb5bzgZDC0ehabH9zwHJXYpCm/HgSnBUqmeqQjCaSZA+q7ie1CO6M36NBSLV4+RGdy6xjmqwkIXL/cibwGPyFk+/lX8QDxdUfJ/32g3V5a4fn
    G1gHrtN9hTRxxFtqfcvnVQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=zMiHMkJPCD3nLd7roHIA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 31/40] netfilter/xt_hashlimit: switch to proc_create_{seq,
 single}_data
Date: Wed, 25 Apr 2018 17:48:18 +0200
Message-Id: <20180425154827.32251-32-hch@lst.de>
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
