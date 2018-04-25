Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671528-2-12585543865323970563
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
    1524671527; b=w8cnrUAzj5iiFaAxz8kkng/9P3xDXwlL1kGlgw0NU9QB8iB8bP
    zXZU8ix+kUmkkVyGrNRONMkPaMhw7lA1U9hyITlteRTEtNMBnlMUvqmVU82WgJhN
    BqHPPWD/VCheYl+c2pI0ReOIBiD52kGSLeD/Am5WrjNAI9Lb8D7lADu7J1q9QL6r
    hcANTgjbxb73SqzEx4mSI8V8cvFiWcPB0+z51RmLV9Xk81k85nK2EEGFhOBm2jB4
    US61n6/ooGzSfCjkVGfgl2/54+8SzUNThH6qJwARMEEOTDd0i6nc1DORmCQVVL5C
    6A4cdi34WfvsZNQJ4Pf9ir5YRr2ON4qOkLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671527; bh=zd8j9
    m69pC7LJ8aei3oxxUHRBltXEl8nrwH0aU+Kn14=; b=rozOXGFes7CR9ihrsSQ7Z
    btS6B6ufeqKoKyNyUZeEv87DI9W0H5+9McQe3U+oAnTSIs9BPpakSGKNCWxrnrR5
    oIDbOkn1IL0yqpl0bGbUBLgtPiFwWC45QKNzLtKl20xapqjvnvyGbzjLr7qlMKh2
    eYZMIUEnONUKdqMgRYQZjAXBD0UzsxcR935jUr09gJolKLZ41F5yjlxZuzwzE6gM
    NpMZVRyE1+nr3t1ifDRvbla/sCKdA+23qionMd5SM0LUf+YXLZ62j5z0XcPjoc2f
    lScq92YhxMEQ0kqKTU+8JDvBiVcVRwX2D/t5PDscD0IXOZeLDcyz+dDRWBjBF2Nj
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=cRKTzidY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=cRKTzidY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfNNTazgEEcMpc1y3bpm7+vH6PaCCWHcFnYOGmbrCMBnM9q8dHCSC4G5YPhN4/ORrxrZpgzFEtSJrS+g8NsTzUUyf72eHZMmEtGHmfuSYyWQom+2aF5Af
    synXV49odSAPnqHA9NatcqLuRlH7TM6bsPbRA0fCnPYQWG/yOO7xIcSnpNHoBjDhpPLg0bHx4JwhPafMJ4XrMd/mm++HQ8t/Ah+D/FEY7XCAbrlEFBmw//Dq
    0CWriZLHXFatiKDKoiPujw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=oytH-73NTEcFM186UAIA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 36/40] isdn: replace ->proc_fops with ->proc_show
Date: Wed, 25 Apr 2018 17:48:23 +0200
Message-Id: <20180425154827.32251-37-hch@lst.de>
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

And switch to proc_create_single_data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/isdn/capi/kcapi.c              |  3 ++-
 drivers/isdn/gigaset/capi.c            | 16 +---------------
 drivers/isdn/hardware/avm/avmcard.h    |  4 ++--
 drivers/isdn/hardware/avm/b1.c         | 17 ++---------------
 drivers/isdn/hardware/avm/b1dma.c      | 17 ++---------------
 drivers/isdn/hardware/avm/b1isa.c      |  2 +-
 drivers/isdn/hardware/avm/b1pci.c      |  4 ++--
 drivers/isdn/hardware/avm/b1pcmcia.c   |  2 +-
 drivers/isdn/hardware/avm/c4.c         | 15 +--------------
 drivers/isdn/hardware/avm/t1isa.c      |  2 +-
 drivers/isdn/hardware/avm/t1pci.c      |  2 +-
 drivers/isdn/hardware/eicon/capimain.c | 15 +--------------
 drivers/isdn/hysdn/hycapi.c            | 15 +--------------
 include/linux/isdn/capilli.h           |  2 +-
 net/bluetooth/cmtp/capi.c              | 14 +-------------
 15 files changed, 20 insertions(+), 110 deletions(-)

diff --git a/drivers/isdn/capi/kcapi.c b/drivers/isdn/capi/kcapi.c
index 46c189ad8d94..0ff517d3c98f 100644
--- a/drivers/isdn/capi/kcapi.c
+++ b/drivers/isdn/capi/kcapi.c
@@ -534,7 +534,8 @@ int attach_capi_ctr(struct capi_ctr *ctr)
 	init_waitqueue_head(&ctr->state_wait_queue);
 
 	sprintf(ctr->procfn, "capi/controllers/%d", ctr->cnr);
-	ctr->procent = proc_create_data(ctr->procfn, 0, NULL, ctr->proc_fops, ctr);
+	ctr->procent = proc_create_single_data(ctr->procfn, 0, NULL,
+			ctr->proc_show, ctr);
 
 	ncontrollers++;
 
diff --git a/drivers/isdn/gigaset/capi.c b/drivers/isdn/gigaset/capi.c
index ccec7778cad2..dac5cd35e901 100644
--- a/drivers/isdn/gigaset/capi.c
+++ b/drivers/isdn/gigaset/capi.c
@@ -2437,19 +2437,6 @@ static int gigaset_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int gigaset_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, gigaset_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations gigaset_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= gigaset_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /**
  * gigaset_isdn_regdev() - register device to LL
  * @cs:		device descriptor structure.
@@ -2478,8 +2465,7 @@ int gigaset_isdn_regdev(struct cardstate *cs, const char *isdnid)
 	iif->ctr.register_appl = gigaset_register_appl;
 	iif->ctr.release_appl  = gigaset_release_appl;
 	iif->ctr.send_message  = gigaset_send_message;
-	iif->ctr.procinfo      = gigaset_procinfo;
-	iif->ctr.proc_fops = &gigaset_proc_fops;
+	iif->ctr.proc_show     = gigaset_proc_show,
 	INIT_LIST_HEAD(&iif->appls);
 	skb_queue_head_init(&iif->sendqueue);
 	atomic_set(&iif->sendqlen, 0);
diff --git a/drivers/isdn/hardware/avm/avmcard.h b/drivers/isdn/hardware/avm/avmcard.h
index c95712dbfa9f..cdfa89c71997 100644
--- a/drivers/isdn/hardware/avm/avmcard.h
+++ b/drivers/isdn/hardware/avm/avmcard.h
@@ -556,7 +556,7 @@ u16  b1_send_message(struct capi_ctr *ctrl, struct sk_buff *skb);
 void b1_parse_version(avmctrl_info *card);
 irqreturn_t b1_interrupt(int interrupt, void *devptr);
 
-extern const struct file_operations b1ctl_proc_fops;
+int b1_proc_show(struct seq_file *m, void *v);
 
 avmcard_dmainfo *avmcard_dma_alloc(char *name, struct pci_dev *,
 				   long rsize, long ssize);
@@ -576,6 +576,6 @@ void b1dma_register_appl(struct capi_ctr *ctrl,
 			 capi_register_params *rp);
 void b1dma_release_appl(struct capi_ctr *ctrl, u16 appl);
 u16  b1dma_send_message(struct capi_ctr *ctrl, struct sk_buff *skb);
-extern const struct file_operations b1dmactl_proc_fops;
+int b1dma_proc_show(struct seq_file *m, void *v);
 
 #endif /* _AVMCARD_H_ */
diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
index b1833d08a5fe..5ee5489d3f15 100644
--- a/drivers/isdn/hardware/avm/b1.c
+++ b/drivers/isdn/hardware/avm/b1.c
@@ -637,7 +637,7 @@ irqreturn_t b1_interrupt(int interrupt, void *devptr)
 }
 
 /* ------------------------------------------------------------- */
-static int b1ctl_proc_show(struct seq_file *m, void *v)
+int b1_proc_show(struct seq_file *m, void *v)
 {
 	struct capi_ctr *ctrl = m->private;
 	avmctrl_info *cinfo = (avmctrl_info *)(ctrl->driverdata);
@@ -699,20 +699,7 @@ static int b1ctl_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int b1ctl_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, b1ctl_proc_show, PDE_DATA(inode));
-}
-
-const struct file_operations b1ctl_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= b1ctl_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-EXPORT_SYMBOL(b1ctl_proc_fops);
+EXPORT_SYMBOL(b1_proc_show);
 
 /* ------------------------------------------------------------- */
 
diff --git a/drivers/isdn/hardware/avm/b1dma.c b/drivers/isdn/hardware/avm/b1dma.c
index 9538a9e5e1a8..6a3dc9937ce5 100644
--- a/drivers/isdn/hardware/avm/b1dma.c
+++ b/drivers/isdn/hardware/avm/b1dma.c
@@ -858,7 +858,7 @@ u16 b1dma_send_message(struct capi_ctr *ctrl, struct sk_buff *skb)
 
 /* ------------------------------------------------------------- */
 
-static int b1dmactl_proc_show(struct seq_file *m, void *v)
+int b1dma_proc_show(struct seq_file *m, void *v)
 {
 	struct capi_ctr *ctrl = m->private;
 	avmctrl_info *cinfo = (avmctrl_info *)(ctrl->driverdata);
@@ -941,20 +941,7 @@ static int b1dmactl_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int b1dmactl_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, b1dmactl_proc_show, PDE_DATA(inode));
-}
-
-const struct file_operations b1dmactl_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= b1dmactl_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-EXPORT_SYMBOL(b1dmactl_proc_fops);
+EXPORT_SYMBOL(b1dma_proc_show);
 
 /* ------------------------------------------------------------- */
 
diff --git a/drivers/isdn/hardware/avm/b1isa.c b/drivers/isdn/hardware/avm/b1isa.c
index 54e871a47387..cdfea72e0ef6 100644
--- a/drivers/isdn/hardware/avm/b1isa.c
+++ b/drivers/isdn/hardware/avm/b1isa.c
@@ -121,7 +121,7 @@ static int b1isa_probe(struct pci_dev *pdev)
 	cinfo->capi_ctrl.load_firmware = b1_load_firmware;
 	cinfo->capi_ctrl.reset_ctr     = b1_reset_ctr;
 	cinfo->capi_ctrl.procinfo      = b1isa_procinfo;
-	cinfo->capi_ctrl.proc_fops = &b1ctl_proc_fops;
+	cinfo->capi_ctrl.proc_show     = b1_proc_show;
 	strcpy(cinfo->capi_ctrl.name, card->name);
 
 	retval = attach_capi_ctr(&cinfo->capi_ctrl);
diff --git a/drivers/isdn/hardware/avm/b1pci.c b/drivers/isdn/hardware/avm/b1pci.c
index ac4863c2ecbc..b76b57a82c02 100644
--- a/drivers/isdn/hardware/avm/b1pci.c
+++ b/drivers/isdn/hardware/avm/b1pci.c
@@ -112,7 +112,7 @@ static int b1pci_probe(struct capicardparams *p, struct pci_dev *pdev)
 	cinfo->capi_ctrl.load_firmware = b1_load_firmware;
 	cinfo->capi_ctrl.reset_ctr     = b1_reset_ctr;
 	cinfo->capi_ctrl.procinfo      = b1pci_procinfo;
-	cinfo->capi_ctrl.proc_fops = &b1ctl_proc_fops;
+	cinfo->capi_ctrl.proc_show     = b1_proc_show;
 	strcpy(cinfo->capi_ctrl.name, card->name);
 	cinfo->capi_ctrl.owner         = THIS_MODULE;
 
@@ -251,7 +251,7 @@ static int b1pciv4_probe(struct capicardparams *p, struct pci_dev *pdev)
 	cinfo->capi_ctrl.load_firmware = b1dma_load_firmware;
 	cinfo->capi_ctrl.reset_ctr     = b1dma_reset_ctr;
 	cinfo->capi_ctrl.procinfo      = b1pciv4_procinfo;
-	cinfo->capi_ctrl.proc_fops = &b1dmactl_proc_fops;
+	cinfo->capi_ctrl.proc_show     = b1dma_proc_show;
 	strcpy(cinfo->capi_ctrl.name, card->name);
 
 	retval = attach_capi_ctr(&cinfo->capi_ctrl);
diff --git a/drivers/isdn/hardware/avm/b1pcmcia.c b/drivers/isdn/hardware/avm/b1pcmcia.c
index 6b0d19d963d5..3aca16e62902 100644
--- a/drivers/isdn/hardware/avm/b1pcmcia.c
+++ b/drivers/isdn/hardware/avm/b1pcmcia.c
@@ -108,7 +108,7 @@ static int b1pcmcia_add_card(unsigned int port, unsigned irq,
 	cinfo->capi_ctrl.load_firmware = b1_load_firmware;
 	cinfo->capi_ctrl.reset_ctr     = b1_reset_ctr;
 	cinfo->capi_ctrl.procinfo      = b1pcmcia_procinfo;
-	cinfo->capi_ctrl.proc_fops = &b1ctl_proc_fops;
+	cinfo->capi_ctrl.proc_show     = b1_proc_show;
 	strcpy(cinfo->capi_ctrl.name, card->name);
 
 	retval = attach_capi_ctr(&cinfo->capi_ctrl);
diff --git a/drivers/isdn/hardware/avm/c4.c b/drivers/isdn/hardware/avm/c4.c
index 034cabac699d..ac72cd204c4d 100644
--- a/drivers/isdn/hardware/avm/c4.c
+++ b/drivers/isdn/hardware/avm/c4.c
@@ -1127,19 +1127,6 @@ static int c4_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int c4_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, c4_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations c4_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= c4_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /* ------------------------------------------------------------- */
 
 static int c4_add_card(struct capicardparams *p, struct pci_dev *dev,
@@ -1211,7 +1198,7 @@ static int c4_add_card(struct capicardparams *p, struct pci_dev *dev,
 		cinfo->capi_ctrl.load_firmware = c4_load_firmware;
 		cinfo->capi_ctrl.reset_ctr     = c4_reset_ctr;
 		cinfo->capi_ctrl.procinfo      = c4_procinfo;
-		cinfo->capi_ctrl.proc_fops = &c4_proc_fops;
+		cinfo->capi_ctrl.proc_show     = c4_proc_show;
 		strcpy(cinfo->capi_ctrl.name, card->name);
 
 		retval = attach_capi_ctr(&cinfo->capi_ctrl);
diff --git a/drivers/isdn/hardware/avm/t1isa.c b/drivers/isdn/hardware/avm/t1isa.c
index 9f80d20ced87..2153619c5b31 100644
--- a/drivers/isdn/hardware/avm/t1isa.c
+++ b/drivers/isdn/hardware/avm/t1isa.c
@@ -430,7 +430,7 @@ static int t1isa_probe(struct pci_dev *pdev, int cardnr)
 	cinfo->capi_ctrl.load_firmware = t1isa_load_firmware;
 	cinfo->capi_ctrl.reset_ctr     = t1isa_reset_ctr;
 	cinfo->capi_ctrl.procinfo      = t1isa_procinfo;
-	cinfo->capi_ctrl.proc_fops = &b1ctl_proc_fops;
+	cinfo->capi_ctrl.proc_show     = b1_proc_show;
 	strcpy(cinfo->capi_ctrl.name, card->name);
 
 	retval = attach_capi_ctr(&cinfo->capi_ctrl);
diff --git a/drivers/isdn/hardware/avm/t1pci.c b/drivers/isdn/hardware/avm/t1pci.c
index 2180b1685691..f5ed1d5004c9 100644
--- a/drivers/isdn/hardware/avm/t1pci.c
+++ b/drivers/isdn/hardware/avm/t1pci.c
@@ -119,7 +119,7 @@ static int t1pci_add_card(struct capicardparams *p, struct pci_dev *pdev)
 	cinfo->capi_ctrl.load_firmware = b1dma_load_firmware;
 	cinfo->capi_ctrl.reset_ctr     = b1dma_reset_ctr;
 	cinfo->capi_ctrl.procinfo      = t1pci_procinfo;
-	cinfo->capi_ctrl.proc_fops = &b1dmactl_proc_fops;
+	cinfo->capi_ctrl.proc_show     = b1dma_proc_show;
 	strcpy(cinfo->capi_ctrl.name, card->name);
 
 	retval = attach_capi_ctr(&cinfo->capi_ctrl);
diff --git a/drivers/isdn/hardware/eicon/capimain.c b/drivers/isdn/hardware/eicon/capimain.c
index be36d82004d6..f9244dc1c3c9 100644
--- a/drivers/isdn/hardware/eicon/capimain.c
+++ b/drivers/isdn/hardware/eicon/capimain.c
@@ -90,19 +90,6 @@ static int diva_ctl_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int diva_ctl_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, diva_ctl_proc_show, NULL);
-}
-
-static const struct file_operations diva_ctl_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= diva_ctl_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /*
  * set additional os settings in capi_ctr struct
  */
@@ -111,7 +98,7 @@ void diva_os_set_controller_struct(struct capi_ctr *ctrl)
 	ctrl->driver_name = DRIVERLNAME;
 	ctrl->load_firmware = NULL;
 	ctrl->reset_ctr = NULL;
-	ctrl->proc_fops = &diva_ctl_proc_fops;
+	ctrl->proc_show = diva_ctl_proc_show;
 	ctrl->owner = THIS_MODULE;
 }
 
diff --git a/drivers/isdn/hysdn/hycapi.c b/drivers/isdn/hysdn/hycapi.c
index eac0f51a0f60..a2c15cd7bf67 100644
--- a/drivers/isdn/hysdn/hycapi.c
+++ b/drivers/isdn/hysdn/hycapi.c
@@ -467,19 +467,6 @@ static int hycapi_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int hycapi_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hycapi_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations hycapi_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= hycapi_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /**************************************************************
 hycapi_load_firmware
 
@@ -774,7 +761,7 @@ hycapi_capi_create(hysdn_card *card)
 		ctrl->load_firmware = hycapi_load_firmware;
 		ctrl->reset_ctr     = hycapi_reset_ctr;
 		ctrl->procinfo      = hycapi_procinfo;
-		ctrl->proc_fops = &hycapi_proc_fops;
+		ctrl->proc_show     = hycapi_proc_show;
 		strcpy(ctrl->name, cinfo->cardname);
 		ctrl->owner = THIS_MODULE;
 
diff --git a/include/linux/isdn/capilli.h b/include/linux/isdn/capilli.h
index 11b57c485854..d75e1ad72964 100644
--- a/include/linux/isdn/capilli.h
+++ b/include/linux/isdn/capilli.h
@@ -50,7 +50,7 @@ struct capi_ctr {
 	u16  (*send_message)(struct capi_ctr *, struct sk_buff *skb);
 	
 	char *(*procinfo)(struct capi_ctr *);
-	const struct file_operations *proc_fops;
+	int (*proc_show)(struct seq_file *, void *);
 
 	/* filled in before calling ready callback */
 	u8 manu[CAPI_MANUFACTURER_LEN];		/* CAPI_GET_MANUFACTURER */
diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 426a92f02db4..eb41556002e3 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -521,18 +521,6 @@ static int cmtp_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int cmtp_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cmtp_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations cmtp_proc_fops = {
-	.open		= cmtp_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 int cmtp_attach_device(struct cmtp_session *session)
 {
 	unsigned char buf[4];
@@ -571,7 +559,7 @@ int cmtp_attach_device(struct cmtp_session *session)
 	session->ctrl.send_message  = cmtp_send_message;
 
 	session->ctrl.procinfo      = cmtp_procinfo;
-	session->ctrl.proc_fops = &cmtp_proc_fops;
+	session->ctrl.proc_show     = cmtp_proc_show;
 
 	if (attach_capi_ctr(&session->ctrl) < 0) {
 		BT_ERR("Can't attach new controller");
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
