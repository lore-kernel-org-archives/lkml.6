Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524671470-2-3385454994884250619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671469; b=FX+7e/jAT7rFH6dzTj9z1V/ebkmpnarFT7HsmWADBTYxgCBCbC
    JPLmqFPB2IxEBhO3TZOWV+SNZARsYBpDiH4yHfLWvP0V3phfQa+4NMdU3duh/w/z
    gJPGAOYY301odVvPqnkj9ByVB0Lu6D9iMjRXOTOFPIZZuOpGuKVY2vEQm4gH15iM
    VSciZz11eZcXLGP403+q44yUYwvQbT0LGUhNELvj9JbvYFH0xvagtVnq4/hAB48Q
    p0SOJF1fOFWkfzXx6cKoCRiTnvilt1LFeEqACVjwDGXnHzdgVwAJ7PO0FOoPWcfi
    8HWurnDnPcMMcmXk2b4qmCtzz5kFUAva8biA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671469; bh=CTdAX
    +wQ97hjNqR/Uy3fqkolSov/fdbnlLVAekmHgqs=; b=AM6H0EjFKNsulJkVKR69y
    C/uI7dfFtvoEsVNM+NSNss2+Z/oAmFYRV2TZGgwyJlpCSsrlibcTLayolfN0ANNd
    4TqVOJYnN8NRYgOaIGHHVGnRTyRHmDh1WAYY88rTfWvlEiBXWBsXvjaemTSgA+Zy
    hfi8YSGEEktC/F7D5Hq5e4YFDB54cK6mAetU7TygQir3LZtU13jxV80qdWYRxSMv
    VGiKWeyQ5dk7K3GCQEQ6X4OenwUsfG1TNwzMsucNsPSPI8ZK/vO149OEClM6BioW
    Z4a7B7DRI8QRnyDyKpcEhICiAv4P9KQNxzuUVgRmY1Bcn+U0iPeoN+8HLAKicDWN
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=QPkfQnoY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=QPkfQnoY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfBL40WOtK85vZxJRLF3wNm5y9k6iyPlx03sQI9sM76P3tJ5kwBmNmPh+zQIICeHTvNKHyYT2YLmoM/PtNAMNC8hWWTv/fruFUve7PLJ5G2FFQBSSvSbx
    IW7cG6NrDpv6lPv1lWYSYDlfKSYTsHx3k/4FwB6L6d7mOkKva0Q7oUI3PcMEtKXWyKoNZNjiqbYVAukzlwGMbiGOrW97jnij3L/Jy6oOI/taR71pNh0IcvQS
    HgwyHgyEELvgBJ/Nfzo9uw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=hKdEH_Ywdm7tl--R1_4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 30/40] neigh: switch to proc_create_seq_data
Date: Wed, 25 Apr 2018 17:48:17 +0200
Message-Id: <20180425154827.32251-31-hch@lst.de>
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
 net/core/neighbour.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ce519861be59..1fb43bff417d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -59,7 +59,7 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 				    struct net_device *dev);
 
 #ifdef CONFIG_PROC_FS
-static const struct file_operations neigh_stat_seq_fops;
+static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
 /*
@@ -1558,8 +1558,8 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		panic("cannot create neighbour cache statistics");
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_create_data(tbl->id, 0, init_net.proc_net_stat,
-			      &neigh_stat_seq_fops, tbl))
+	if (!proc_create_seq_data(tbl->id, 0, init_net.proc_net_stat,
+			      &neigh_stat_seq_ops, tbl))
 		panic("cannot create neighbour proc dir entry");
 #endif
 
@@ -2786,7 +2786,7 @@ EXPORT_SYMBOL(neigh_seq_stop);
 
 static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	if (*pos == 0)
@@ -2803,7 +2803,7 @@ static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *neigh_stat_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	for (cpu = *pos; cpu < nr_cpu_ids; ++cpu) {
@@ -2822,7 +2822,7 @@ static void neigh_stat_seq_stop(struct seq_file *seq, void *v)
 
 static int neigh_stat_seq_show(struct seq_file *seq, void *v)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	struct neigh_statistics *st = v;
 
 	if (v == SEQ_START_TOKEN) {
@@ -2861,25 +2861,6 @@ static const struct seq_operations neigh_stat_seq_ops = {
 	.stop	= neigh_stat_seq_stop,
 	.show	= neigh_stat_seq_show,
 };
-
-static int neigh_stat_seq_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &neigh_stat_seq_ops);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-};
-
-static const struct file_operations neigh_stat_seq_fops = {
-	.open 	 = neigh_stat_seq_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release,
-};
-
 #endif /* CONFIG_PROC_FS */
 
 static inline size_t neigh_nlmsg_size(void)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
