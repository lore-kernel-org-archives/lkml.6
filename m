Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671462-2-4799787332936210114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671461; b=N4K5aSfLk0PRjbyN3kkYYyHAcoJrqQp8yt1ShEKX9QQEDKWNYU
    XUdEFfIyIP0qCeVQ0qhN4vdmzpsH1dRMotJb6RGf1c22W7E8m+0P6AXQDBhker2B
    fP1dol+ec2tplBjLlCpTE7d7P1xc8D+Q1NUGIundnJlpM/xCaFi855/dh7CASvD7
    d9YKv9ahcm3287dCMa3XfMb6WComM02b7PmquSc27JXRj4LQFv+OGP40UCTdowaf
    DdSkweqbaSpZTYHJZMVfKQSYEs27eQb2JF62MvNJBAhK3PK4W2ToLMwuxWiQIquU
    aFN0iwlCozi2NmlvgD9+u8r5SVErQt2Kl2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671461; bh=gNUHM
    EhryuWCsRcocQkxqpk+HAE7KPg5opsnx2RwWe0=; b=okilMZ3htgKpJmNC8i3mx
    URKGkAVdJErysQD4rnao2TAHujgs1EIr0ivLl7wjFjckC+HLFGDS+4AZIb8QR0Xn
    7ZPZ22dcsVl7IjaDriTs9SrvcM0c4NUqWahkCTeOFSYBcjsggc1wSOYL/T+Pf6yu
    SpAo6IcTa9lW5SWmQuTtaWkdhaHeQa4XVwmZW2KePse9kyYSn1qoOAuokndjWOWv
    mDQZzhXnc60P9WwVMi2k4ZkzN7cvrl78rzgaxjlSW9uwTQJOhN936woJ5QXLpeh5
    HiWH8gzfV43n+ImpuCvoclBV//v84Gd5v2g98k/6ZGBUrM9lMZa43rW6wjdNUbLN
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=tTXrblxT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=tTXrblxT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfObZddwqJ/37ZL6KsUqaWWoFjwFeyWi8UO9aa/E456bHsaIukp/EVBtWGFi+lg3WZRlJrPFTax5VTG7mr0iMy+fWIQ5/9v6RoSQVVBraHUnnxXuJDq2Y
    unS8PVafMwmPii7e7Js1G5L0oU0BdaekV3VdpZ0wo8dYADeCc8oeBl/fLGf/5UWInyxNFDq/XRTSvAvnh2F9Dog5ulYWf1jF1moTWB3LqMFBkWW4kkiUejo8
    8NPkM4IaJK2tagZHwOIUvQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=qHYdmk5srm4cNRxzpugA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 28/40] bonding: switch to proc_create_seq_data
Date: Wed, 25 Apr 2018 17:48:15 +0200
Message-Id: <20180425154827.32251-29-hch@lst.de>
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
 drivers/net/bonding/bond_procfs.c | 36 ++++++-------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 01059f1a7bca..9f7d83e827c3 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -10,7 +10,7 @@
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	loff_t off = 0;
@@ -29,7 +29,7 @@ static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bond_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	bool found = false;
@@ -56,7 +56,7 @@ static void bond_info_seq_stop(struct seq_file *seq, void *v)
 
 static void bond_info_show_master(struct seq_file *seq)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	const struct bond_opt_value *optval;
 	struct slave *curr, *primary;
 	int i;
@@ -167,7 +167,7 @@ static void bond_info_show_master(struct seq_file *seq)
 static void bond_info_show_slave(struct seq_file *seq,
 				 const struct slave *slave)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 
 	seq_printf(seq, "\nSlave Interface: %s\n", slave->dev->name);
 	seq_printf(seq, "MII Status: %s\n", bond_slave_link_status(slave->link));
@@ -257,38 +257,14 @@ static const struct seq_operations bond_info_seq_ops = {
 	.show  = bond_info_seq_show,
 };
 
-static int bond_info_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int res;
-
-	res = seq_open(file, &bond_info_seq_ops);
-	if (!res) {
-		/* recover the pointer buried in proc_dir_entry data */
-		seq = file->private_data;
-		seq->private = PDE_DATA(inode);
-	}
-
-	return res;
-}
-
-static const struct file_operations bond_info_fops = {
-	.owner   = THIS_MODULE,
-	.open    = bond_info_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
 void bond_create_proc_entry(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct bond_net *bn = net_generic(dev_net(bond_dev), bond_net_id);
 
 	if (bn->proc_dir) {
-		bond->proc_entry = proc_create_data(bond_dev->name,
-						    0444, bn->proc_dir,
-						    &bond_info_fops, bond);
+		bond->proc_entry = proc_create_seq_data(bond_dev->name, 0444,
+				bn->proc_dir, &bond_info_seq_ops, bond);
 		if (bond->proc_entry == NULL)
 			netdev_warn(bond_dev, "Cannot create /proc/net/%s/%s\n",
 				    DRV_NAME, bond_dev->name);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
