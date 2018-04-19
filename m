Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3082590-1524143218-2-3770153086866730250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: subject='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524143217; b=sK+jj00OMNNLbSpXoFVHK6quto0RGdTrc4ABPXMxbcX+MmKMR5
    Bnhro/9T1a5wJeTAcXInahYen3OMcXQ2Kfb7MtdCoRSS3C0pIN74F79Tqkj9WBPa
    vembMHtmS46wlHel7T7OGA6QTCPdNJ8oe5bRK6jZdiFeDqehHLaxbo72G2jwbtYv
    aWr5QvmruUNzUt2NDbAlNTbowqJXsdCcs8mMqEGmhZi0x7EF/KuUAKIfuR7BUXsF
    SGVA6M2Auxft7DbvF9E0+O3Rmc6OrcJ4SkwvrgP1yXGV6G3fOiYrXVbNBH5phAiE
    f8t7YIXm29dCoCEiZCXGYPZG7V+G/Hj496Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524143217; bh=KLS8o
    IoJcDmoq3Ih5K5izXhp5d2btee9SLoDAT/iKC8=; b=HPclMd+Yhp1iAblh/eHNS
    TdYw/HyatLjJs5a5RoGM/HV+3wMu8kOZYwws05uoQqDPSGL7A7E2WxJ9a6papJhw
    U9aiq5JWGgC+99Wyol5/vCBhsU4AJKns7ADXyG7JQctbOhiegKjx5v9KJbtto0kU
    uBcX8mXf2tzY5+XFxEHeZw06PPxjzLHWK5UjUAUkamJl3qOgKhUAsqsyG+zias8L
    wCoT+S2DC1fbrRFvFqR42scqNCP9Qxv6KpHoAtnlwrCXluvOIQFBXR1snkofM/hS
    uG5d9T9poEC5boUZvU+NmGsCAyhcjaAWKWvmmn9zE7L2uGwDCe5vh+h2B/zMF590
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HdUUONcH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HdUUONcH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfN9+JA0Il9NXypfk0FqY0zmhYj4srOTf5M4vVUm+cjRcVM0Pqr7H1nqigz3KQ/tz8zxR3d4+ToiSta9oLnK4Ea3JrJZ9VirUkk1XlpjIUgofdHCEmIYu
    499HprRuEGiwnE1dB1QbDysy28WT2gBOSqVzCAr4LxYkM/Nt7h1vK9I1vowDd3V+EckgoyC2YE88R2v/VpAbcW9RJZ9bwhjCMOf13rYdJiWpHmYC7fF0H7PH
    dbj6hjRGEJoC0UrVjS30Rw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=zCwnPa-Y9NYygOW7hOAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 08/39] =?UTF-8?q?ipv{4,
 6}/raw:=20simplify=20=D1=95eq=5Ffil?= =?UTF-8?q?e=20code?=
Date: Thu, 19 Apr 2018 14:41:09 +0200
Message-Id: <20180419124140.9309-9-hch@lst.de>
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

Pass the hashtable to the proc private data instead of copying
it into the per-file private data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/raw.h |  4 ----
 net/ipv4/raw.c    | 36 ++++++++++++------------------------
 net/ipv6/raw.c    |  6 ++++--
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/include/net/raw.h b/include/net/raw.h
index 99d26d0c4a19..9c9fa98a91a4 100644
--- a/include/net/raw.h
+++ b/include/net/raw.h
@@ -48,7 +48,6 @@ void raw_proc_exit(void);
 struct raw_iter_state {
 	struct seq_net_private p;
 	int bucket;
-	struct raw_hashinfo *h;
 };
 
 static inline struct raw_iter_state *raw_seq_private(struct seq_file *seq)
@@ -58,9 +57,6 @@ static inline struct raw_iter_state *raw_seq_private(struct seq_file *seq)
 void *raw_seq_start(struct seq_file *seq, loff_t *pos);
 void *raw_seq_next(struct seq_file *seq, void *v, loff_t *pos);
 void raw_seq_stop(struct seq_file *seq, void *v);
-int raw_seq_open(struct inode *ino, struct file *file,
-		 struct raw_hashinfo *h, const struct seq_operations *ops);
-
 #endif
 
 int raw_hash_sk(struct sock *sk);
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1b4d3355624a..ae57962b31e3 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -1003,11 +1003,12 @@ struct proto raw_prot = {
 static struct sock *raw_get_first(struct seq_file *seq)
 {
 	struct sock *sk;
+	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
 	struct raw_iter_state *state = raw_seq_private(seq);
 
 	for (state->bucket = 0; state->bucket < RAW_HTABLE_SIZE;
 			++state->bucket) {
-		sk_for_each(sk, &state->h->ht[state->bucket])
+		sk_for_each(sk, &h->ht[state->bucket])
 			if (sock_net(sk) == seq_file_net(seq))
 				goto found;
 	}
@@ -1018,6 +1019,7 @@ static struct sock *raw_get_first(struct seq_file *seq)
 
 static struct sock *raw_get_next(struct seq_file *seq, struct sock *sk)
 {
+	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
 	struct raw_iter_state *state = raw_seq_private(seq);
 
 	do {
@@ -1027,7 +1029,7 @@ static struct sock *raw_get_next(struct seq_file *seq, struct sock *sk)
 	} while (sk && sock_net(sk) != seq_file_net(seq));
 
 	if (!sk && ++state->bucket < RAW_HTABLE_SIZE) {
-		sk = sk_head(&state->h->ht[state->bucket]);
+		sk = sk_head(&h->ht[state->bucket]);
 		goto try_again;
 	}
 	return sk;
@@ -1045,9 +1047,9 @@ static struct sock *raw_get_idx(struct seq_file *seq, loff_t pos)
 
 void *raw_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct raw_iter_state *state = raw_seq_private(seq);
+	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
 
-	read_lock(&state->h->lock);
+	read_lock(&h->lock);
 	return *pos ? raw_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 EXPORT_SYMBOL_GPL(raw_seq_start);
@@ -1067,9 +1069,9 @@ EXPORT_SYMBOL_GPL(raw_seq_next);
 
 void raw_seq_stop(struct seq_file *seq, void *v)
 {
-	struct raw_iter_state *state = raw_seq_private(seq);
+	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
 
-	read_unlock(&state->h->lock);
+	read_unlock(&h->lock);
 }
 EXPORT_SYMBOL_GPL(raw_seq_stop);
 
@@ -1110,25 +1112,10 @@ static const struct seq_operations raw_seq_ops = {
 	.show  = raw_seq_show,
 };
 
-int raw_seq_open(struct inode *ino, struct file *file,
-		 struct raw_hashinfo *h, const struct seq_operations *ops)
-{
-	int err;
-	struct raw_iter_state *i;
-
-	err = seq_open_net(ino, file, ops, sizeof(struct raw_iter_state));
-	if (err < 0)
-		return err;
-
-	i = raw_seq_private((struct seq_file *)file->private_data);
-	i->h = h;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(raw_seq_open);
-
 static int raw_v4_seq_open(struct inode *inode, struct file *file)
 {
-	return raw_seq_open(inode, file, &raw_v4_hashinfo, &raw_seq_ops);
+	return seq_open_net(inode, file, &raw_seq_ops,
+			sizeof(struct raw_iter_state));
 }
 
 static const struct file_operations raw_seq_fops = {
@@ -1140,7 +1127,8 @@ static const struct file_operations raw_seq_fops = {
 
 static __net_init int raw_init_net(struct net *net)
 {
-	if (!proc_create("raw", 0444, net->proc_net, &raw_seq_fops))
+	if (!proc_create_data("raw", 0444, net->proc_net, &raw_seq_fops,
+			&raw_v4_hashinfo))
 		return -ENOMEM;
 
 	return 0;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 5eb9b08947ed..dade69bf61e6 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1306,7 +1306,8 @@ static const struct seq_operations raw6_seq_ops = {
 
 static int raw6_seq_open(struct inode *inode, struct file *file)
 {
-	return raw_seq_open(inode, file, &raw_v6_hashinfo, &raw6_seq_ops);
+	return seq_open_net(inode, file, &raw6_seq_ops,
+			sizeof(struct raw_iter_state));
 }
 
 static const struct file_operations raw6_seq_fops = {
@@ -1318,7 +1319,8 @@ static const struct file_operations raw6_seq_fops = {
 
 static int __net_init raw6_init_net(struct net *net)
 {
-	if (!proc_create("raw6", 0444, net->proc_net, &raw6_seq_fops))
+	if (!proc_create_data("raw6", 0444, net->proc_net, &raw6_seq_fops,
+			&raw_v6_hashinfo))
 		return -ENOMEM;
 
 	return 0;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
