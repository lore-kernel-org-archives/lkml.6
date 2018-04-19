Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx48Zr7UNOyLDvqznvHyFyH6coNANBKnJH8MDdT09NDOklxl2hwzC6h3gX3KfXGe7bMnrmWbi
ARC-Seal: i=1; a=rsa-sha256; t=1524141831; cv=none;
        d=google.com; s=arc-20160816;
        b=SiCyQNVDYj+NsjWTxXaHW3u4adjSp2sXvqDzTzQdY+G7gp1oK1SrOR1vqJd7/COCYh
         5IwO6xyjD+CeWvxy4qK6hskYSPmkea+q4PSZxfSJHjtfaXwG4D4zLOXHj36wnESGGas6
         QQggL9Uag2356Sla6MYeySYjTImPbMe5zBihJYHhtCeDKh6V5oDRxfZDDz1YIcdKdSpV
         hWL4twKqHbyz1wBN3E7FMg+ByUxAwHmeyOhbF/FIOvGEHuSXB0gI9esP0ZTvSHwzKjw6
         KAp3DgaUJ/pY3u5VNksTrU3Rl7wIH82FzAHA+c2G13GAytkQlLEhSshEQpLG9JAm9sWO
         lMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=g5j//julXkqv7mB+HmgXOJbmEXNPDbnwunqJg0FenF4=;
        b=rMnIcvGQKfLIdYPEf1ZcpougcJt9vxwGnNfVEpopLny46Sdban9J50V9x3rdvvlBgs
         2FaD0pralQoYewDoyxqdIAKQioPamYHfSOL+PxNephylAUElhemjML0oFJf0/vN1CnIf
         MnXezDFynJIDMmm2C9ls1P96nLrlGAopF+QH+IBPBbtFsad+YBm8wrqzEgHfsXnAPvCf
         JlA1D8RUqqfla1dYIfGRI92dfvvK6NR0KG2ZOr9V7RVDeUgrq7NU1tvRH1nFJjkQfYDO
         YSxIgxqx2RWWot8SWujG/p/YCUiCMfCJfPKjaf5cx1f+kRgcc8HWiNpklozoVeSxdqlB
         711w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=iHL0OdaY;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=iHL0OdaY;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Corey Minyard <minyard@acm.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 35/39] isdn: replace ->proc_fops with ->proc_show
Date: Thu, 19 Apr 2018 14:41:36 +0200
Message-Id: <20180419124140.9309-36-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178545250826967?=
X-GMAIL-MSGID: =?utf-8?q?1598178545250826967?=
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
