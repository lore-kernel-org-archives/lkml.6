Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524671386-2-8405111734377814627
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671385; b=h2zJLsYiLJWk0CICUE+u8MsD2o9+VDvTLMPlFwSBpnZ3xkjuLe
    5/M94I6B9DCPXsC7AQ8f7/AsJeuoWHhrmn4I3wN21jedtQCYvmwO/9JqQ+MpiMxB
    C86jBZtxMMFwR2sDKEGb4h57vWHkMXD4P9mpK6cnTutHi8PVm3Mr5qoBjR55nTTv
    r8VWHjKXO+ADGdEwT6k7kfYGXWjIU/STfMPbhRqQ8mL4B2wti3o/koy00gwxq4Nr
    lZW005pn2RGvFm9juS54+p16d5IymfnlmCO0YQWst1bE93QgJNdNpudADw9aDNlI
    ogCCItnHt8n8bWwyEPjze0EmKVOSRgx7L1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671385; bh=Mteb3
    y5aAfOIcmomHqIGmtfbHlDXxRkoq9qc+pplJ70=; b=vfxKL95Wgw5jmzG3IW1iE
    9T3MtL4TDvjVXNl2oqrT2X3jDjdptOWpcrZlKoPAf/KGd8XPcN8thI6brsWvyeUY
    ds0l36m/swTCht0tqxRMkOMB8sxLGNDePfN5ulBFv9Z9I+imwX+cso89B9iGMe7o
    9M3afd5ePCem5qmIvjKAMG3bPoVp2MHJfrcD+h5yQKKlhJutdvtqBsqIrIbFYasf
    0UAm7kj8BhuuydId4uhUkfCG6/42yeCqR7HsWn5PI6hUABF/tmhrjwyPTdvocSCT
    cWQCIoalnyz9j4r7ZJharTpeu1Nyr7hRSmOFSXoPBr3kjXZOoTZaR16DvtsoWgZM
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FMujBCKe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FMujBCKe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfHl4885RHnwD1H/kDdmJZaYX+cORNqshEL9Pmluauk70od3RSnfpO+0OBchS7WmU/IN13LQO0LXhLrpzKcnyHsN0xnbbvcKutlGhiHeNNA0GU9fnky2p
    VCTT7qwaACZ5xOTaTOyIlWO6rJ+bhtUuNz5214HuHQTlv4or7qByy7/kB/KEZSY3Z9lwhDWKpDBhCE0Yz3W2G+ZY6xJoEjpy59dAJBSLnRCcW5J9GhvLqgnh
    vZDVmTnZrKvBm3OjdadoMQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=S61zV_2lVlzQZ2sxpT4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 07/40] ipv{4,6}/udp{,lite}: simplify proc registration
Date: Wed, 25 Apr 2018 17:47:54 +0200
Message-Id: <20180425154827.32251-8-hch@lst.de>
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

Remove a couple indirections to make the code look like most other
protocols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/udp.h  | 20 ++++------
 net/ipv4/udp.c     | 99 +++++++++++++++++-----------------------------
 net/ipv4/udplite.c | 21 +++-------
 net/ipv6/udp.c     | 30 +++++++++-----
 net/ipv6/udplite.c | 21 +++-------
 5 files changed, 78 insertions(+), 113 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 0676b272f6ac..093cd323f66a 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -408,31 +408,27 @@ do {									\
 #define __UDPX_INC_STATS(sk, field) __UDP_INC_STATS(sock_net(sk), field, 0)
 #endif
 
-/* /proc */
-int udp_seq_open(struct inode *inode, struct file *file);
-
+#ifdef CONFIG_PROC_FS
 struct udp_seq_afinfo {
-	char				*name;
 	sa_family_t			family;
 	struct udp_table		*udp_table;
-	const struct file_operations	*seq_fops;
-	struct seq_operations		seq_ops;
 };
 
 struct udp_iter_state {
 	struct seq_net_private  p;
-	sa_family_t		family;
 	int			bucket;
-	struct udp_table	*udp_table;
 };
 
-#ifdef CONFIG_PROC_FS
-int udp_proc_register(struct net *net, struct udp_seq_afinfo *afinfo);
-void udp_proc_unregister(struct net *net, struct udp_seq_afinfo *afinfo);
+void *udp_seq_start(struct seq_file *seq, loff_t *pos);
+void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos);
+void udp_seq_stop(struct seq_file *seq, void *v);
+
+extern const struct file_operations udp_afinfo_seq_fops;
+extern const struct file_operations udp6_afinfo_seq_fops;
 
 int udp4_proc_init(void);
 void udp4_proc_exit(void);
-#endif
+#endif /* CONFIG_PROC_FS */
 
 int udpv4_offload_init(void);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 24b5c59b1c53..d48790ddb6cf 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2579,12 +2579,13 @@ EXPORT_SYMBOL(udp_prot);
 static struct sock *udp_get_first(struct seq_file *seq, int start)
 {
 	struct sock *sk;
+	struct udp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct udp_iter_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
 
-	for (state->bucket = start; state->bucket <= state->udp_table->mask;
+	for (state->bucket = start; state->bucket <= afinfo->udp_table->mask;
 	     ++state->bucket) {
-		struct udp_hslot *hslot = &state->udp_table->hash[state->bucket];
+		struct udp_hslot *hslot = &afinfo->udp_table->hash[state->bucket];
 
 		if (hlist_empty(&hslot->head))
 			continue;
@@ -2593,7 +2594,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 		sk_for_each(sk, &hslot->head) {
 			if (!net_eq(sock_net(sk), net))
 				continue;
-			if (sk->sk_family == state->family)
+			if (sk->sk_family == afinfo->family)
 				goto found;
 		}
 		spin_unlock_bh(&hslot->lock);
@@ -2605,16 +2606,17 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 
 static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 {
+	struct udp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct udp_iter_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
 
 	do {
 		sk = sk_next(sk);
-	} while (sk && (!net_eq(sock_net(sk), net) || sk->sk_family != state->family));
+	} while (sk && (!net_eq(sock_net(sk), net) || sk->sk_family != afinfo->family));
 
 	if (!sk) {
-		if (state->bucket <= state->udp_table->mask)
-			spin_unlock_bh(&state->udp_table->hash[state->bucket].lock);
+		if (state->bucket <= afinfo->udp_table->mask)
+			spin_unlock_bh(&afinfo->udp_table->hash[state->bucket].lock);
 		return udp_get_first(seq, state->bucket + 1);
 	}
 	return sk;
@@ -2630,15 +2632,16 @@ static struct sock *udp_get_idx(struct seq_file *seq, loff_t pos)
 	return pos ? NULL : sk;
 }
 
-static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
+void *udp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct udp_iter_state *state = seq->private;
 	state->bucket = MAX_UDP_PORTS;
 
 	return *pos ? udp_get_idx(seq, *pos-1) : SEQ_START_TOKEN;
 }
+EXPORT_SYMBOL(udp_seq_start);
 
-static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct sock *sk;
 
@@ -2650,56 +2653,17 @@ static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++*pos;
 	return sk;
 }
+EXPORT_SYMBOL(udp_seq_next);
 
-static void udp_seq_stop(struct seq_file *seq, void *v)
+void udp_seq_stop(struct seq_file *seq, void *v)
 {
+	struct udp_seq_afinfo *afinfo = PDE_DATA(file_inode(seq->file));
 	struct udp_iter_state *state = seq->private;
 
-	if (state->bucket <= state->udp_table->mask)
-		spin_unlock_bh(&state->udp_table->hash[state->bucket].lock);
+	if (state->bucket <= afinfo->udp_table->mask)
+		spin_unlock_bh(&afinfo->udp_table->hash[state->bucket].lock);
 }
-
-int udp_seq_open(struct inode *inode, struct file *file)
-{
-	struct udp_seq_afinfo *afinfo = PDE_DATA(inode);
-	struct udp_iter_state *s;
-	int err;
-
-	err = seq_open_net(inode, file, &afinfo->seq_ops,
-			   sizeof(struct udp_iter_state));
-	if (err < 0)
-		return err;
-
-	s = ((struct seq_file *)file->private_data)->private;
-	s->family		= afinfo->family;
-	s->udp_table		= afinfo->udp_table;
-	return err;
-}
-EXPORT_SYMBOL(udp_seq_open);
-
-/* ------------------------------------------------------------------------ */
-int udp_proc_register(struct net *net, struct udp_seq_afinfo *afinfo)
-{
-	struct proc_dir_entry *p;
-	int rc = 0;
-
-	afinfo->seq_ops.start		= udp_seq_start;
-	afinfo->seq_ops.next		= udp_seq_next;
-	afinfo->seq_ops.stop		= udp_seq_stop;
-
-	p = proc_create_data(afinfo->name, 0444, net->proc_net,
-			     afinfo->seq_fops, afinfo);
-	if (!p)
-		rc = -ENOMEM;
-	return rc;
-}
-EXPORT_SYMBOL(udp_proc_register);
-
-void udp_proc_unregister(struct net *net, struct udp_seq_afinfo *afinfo)
-{
-	remove_proc_entry(afinfo->name, net->proc_net);
-}
-EXPORT_SYMBOL(udp_proc_unregister);
+EXPORT_SYMBOL(udp_seq_stop);
 
 /* ------------------------------------------------------------------------ */
 static void udp4_format_sock(struct sock *sp, struct seq_file *f,
@@ -2739,32 +2703,43 @@ int udp4_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static const struct file_operations udp_afinfo_seq_fops = {
+static const struct seq_operations udp_seq_ops = {
+	.start		= udp_seq_start,
+	.next		= udp_seq_next,
+	.stop		= udp_seq_stop,
+	.show		= udp4_seq_show,
+};
+
+static int udp_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &udp_seq_ops,
+			sizeof(struct udp_iter_state));
+}
+
+const struct file_operations udp_afinfo_seq_fops = {
 	.open     = udp_seq_open,
 	.read     = seq_read,
 	.llseek   = seq_lseek,
 	.release  = seq_release_net
 };
+EXPORT_SYMBOL(udp_afinfo_seq_fops);
 
-/* ------------------------------------------------------------------------ */
 static struct udp_seq_afinfo udp4_seq_afinfo = {
-	.name		= "udp",
 	.family		= AF_INET,
 	.udp_table	= &udp_table,
-	.seq_fops	= &udp_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp4_seq_show,
-	},
 };
 
 static int __net_init udp4_proc_init_net(struct net *net)
 {
-	return udp_proc_register(net, &udp4_seq_afinfo);
+	if (!proc_create_data("udp", 0444, net->proc_net, &udp_afinfo_seq_fops,
+			&udp4_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_exit udp4_proc_exit_net(struct net *net)
 {
-	udp_proc_unregister(net, &udp4_seq_afinfo);
+	remove_proc_entry("udp", net->proc_net);
 }
 
 static struct pernet_operations udp4_net_ops = {
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index f96614e9b9a5..4a6e67bfbe0d 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "UDPLite: " fmt
 
 #include <linux/export.h>
+#include <linux/proc_fs.h>
 #include "udp_impl.h"
 
 struct udp_table 	udplite_table __read_mostly;
@@ -73,32 +74,22 @@ static struct inet_protosw udplite4_protosw = {
 };
 
 #ifdef CONFIG_PROC_FS
-
-static const struct file_operations udplite_afinfo_seq_fops = {
-	.open     = udp_seq_open,
-	.read     = seq_read,
-	.llseek   = seq_lseek,
-	.release  = seq_release_net
-};
-
 static struct udp_seq_afinfo udplite4_seq_afinfo = {
-	.name		= "udplite",
 	.family		= AF_INET,
 	.udp_table 	= &udplite_table,
-	.seq_fops	= &udplite_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp4_seq_show,
-	},
 };
 
 static int __net_init udplite4_proc_init_net(struct net *net)
 {
-	return udp_proc_register(net, &udplite4_seq_afinfo);
+	if (!proc_create_data("udplite", 0444, net->proc_net,
+			&udp_afinfo_seq_fops, &udplite4_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_exit udplite4_proc_exit_net(struct net *net)
 {
-	udp_proc_unregister(net, &udplite4_seq_afinfo);
+	remove_proc_entry("udplite", net->proc_net);
 }
 
 static struct pernet_operations udplite4_net_ops = {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 4ec76a87aeb8..68f11d6e3912 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1480,31 +1480,43 @@ int udp6_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static const struct file_operations udp6_afinfo_seq_fops = {
-	.open     = udp_seq_open,
+static const struct seq_operations udp6_seq_ops = {
+	.start		= udp_seq_start,
+	.next		= udp_seq_next,
+	.stop		= udp_seq_stop,
+	.show		= udp6_seq_show,
+};
+
+static int udp6_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open_net(inode, file, &udp6_seq_ops,
+			sizeof(struct udp_iter_state));
+}
+
+const struct file_operations udp6_afinfo_seq_fops = {
+	.open     = udp6_seq_open,
 	.read     = seq_read,
 	.llseek   = seq_lseek,
 	.release  = seq_release_net
 };
+EXPORT_SYMBOL(udp6_afinfo_seq_fops);
 
 static struct udp_seq_afinfo udp6_seq_afinfo = {
-	.name		= "udp6",
 	.family		= AF_INET6,
 	.udp_table	= &udp_table,
-	.seq_fops	= &udp6_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp6_seq_show,
-	},
 };
 
 int __net_init udp6_proc_init(struct net *net)
 {
-	return udp_proc_register(net, &udp6_seq_afinfo);
+	if (!proc_create_data("udp6", 0444, net->proc_net,
+			&udp6_afinfo_seq_fops, &udp6_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 void udp6_proc_exit(struct net *net)
 {
-	udp_proc_unregister(net, &udp6_seq_afinfo);
+	remove_proc_entry("udp6", net->proc_net);
 }
 #endif /* CONFIG_PROC_FS */
 
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index 14ae32bb1f3d..a119e57196b5 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -12,6 +12,7 @@
  *		2 of the License, or (at your option) any later version.
  */
 #include <linux/export.h>
+#include <linux/proc_fs.h>
 #include "udp_impl.h"
 
 static int udplitev6_rcv(struct sk_buff *skb)
@@ -92,32 +93,22 @@ void udplitev6_exit(void)
 }
 
 #ifdef CONFIG_PROC_FS
-
-static const struct file_operations udplite6_afinfo_seq_fops = {
-	.open     = udp_seq_open,
-	.read     = seq_read,
-	.llseek   = seq_lseek,
-	.release  = seq_release_net
-};
-
 static struct udp_seq_afinfo udplite6_seq_afinfo = {
-	.name		= "udplite6",
 	.family		= AF_INET6,
 	.udp_table	= &udplite_table,
-	.seq_fops	= &udplite6_afinfo_seq_fops,
-	.seq_ops	= {
-		.show		= udp6_seq_show,
-	},
 };
 
 static int __net_init udplite6_proc_init_net(struct net *net)
 {
-	return udp_proc_register(net, &udplite6_seq_afinfo);
+	if (!proc_create_data("udplite6", 0444, net->proc_net,
+			&udp6_afinfo_seq_fops, &udplite6_seq_afinfo))
+		return -ENOMEM;
+	return 0;
 }
 
 static void __net_exit udplite6_proc_exit_net(struct net *net)
 {
-	udp_proc_unregister(net, &udplite6_seq_afinfo);
+	remove_proc_entry("udplite6", net->proc_net);
 }
 
 static struct pernet_operations udplite6_net_ops = {
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
