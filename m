Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39810C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF23208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NgNciXpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF23208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935963AbeFNB4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:56:41 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59156 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935616AbeFNB4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:56:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 72F368EE26F;
        Wed, 13 Jun 2018 18:56:39 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1Si5lPlrfqqJ; Wed, 13 Jun 2018 18:56:39 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 15FD48EE1E9;
        Wed, 13 Jun 2018 18:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1528941399;
        bh=DOjEBhC2r/frXW/RGGTSoOHvMlXDlJLKbJV3f1m4yuI=;
        h=Subject:From:To:Cc:Date:From;
        b=NgNciXpex0CsOPPnK/IKT6X7Hn/x40VxMDct8l75F7zijFLOGYo9Tqj7fhETyz+4B
         I8nHLovMYHR2TF5iYqoR/hdqbZ8gAbaxvsflZkGH8Sjzek78pFcIEpTudkRyfcEOOD
         GdbG3MPiIeo+Ny6WsfKxJNoINMpnphUH3effxygE=
Message-ID: <1528941398.4748.6.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 4.17+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Jun 2018 18:56:38 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of minor (and safe changes) that didn't make the initial
pull request plus some bug fixes.  

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Anil Gurumurthy (1):
      scsi: qla2xxx: Mask off Scope bits in retry delay

Christoph Hellwig (1):
      scsi: aacraid: remove bogus GFP_DMA32 specifies

Colin Ian King (1):
      scsi: aic7xxx: aic79xx: fix potential null pointer dereference on ahd

Damien Le Moal (1):
      scsi: sd_zbc: Fix sd_zbc_check_zone_size() error path

Himanshu Madhani (1):
      scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Rodrigo R. Galvao (1):
      scsi: qla2xxx: Fix crash on qla2x00_mailbox_command

Sinan Kaya (1):
      scsi: hpsa: disable device during shutdown

Tomas Henzl (1):
      scsi: mpt3sas: Add an I/O barrier

And the diffstat:

 drivers/scsi/aacraid/commctrl.c     |  4 ++--
 drivers/scsi/aic7xxx/aic79xx_core.c |  8 ++++----
 drivers/scsi/hpsa.c                 | 10 ++++++++--
 drivers/scsi/mpt3sas/mpt3sas_base.c |  1 +
 drivers/scsi/qla2xxx/qla_init.c     |  3 ++-
 drivers/scsi/qla2xxx/qla_isr.c      |  8 ++++++--
 drivers/scsi/qla2xxx/qla_mbx.c      |  8 ++++++++
 drivers/scsi/sd_zbc.c               |  2 +-
 8 files changed, 32 insertions(+), 12 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index a2b3430072c7..25f6600d6c09 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -845,7 +845,7 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 					rcode = -EINVAL;
 					goto cleanup;
 				}
-				p = kmalloc(sg_count[i], GFP_KERNEL|GFP_DMA32);
+				p = kmalloc(sg_count[i], GFP_KERNEL);
 				if (!p) {
 					dprintk((KERN_DEBUG"aacraid: Could not allocate SG buffer - size = %d buffer number %d of %d\n",
 						sg_count[i], i, usg->count));
@@ -886,7 +886,7 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 					rcode = -EINVAL;
 					goto cleanup;
 				}
-				p = kmalloc(sg_count[i], GFP_KERNEL|GFP_DMA32);
+				p = kmalloc(sg_count[i], GFP_KERNEL);
 				if (!p) {
 					dprintk((KERN_DEBUG"aacraid: Could not allocate SG buffer - size = %d buffer number %d of %d\n",
 					  sg_count[i], i, upsg->count));
diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 034f4eebb160..3efd4cdc40a0 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -6112,10 +6112,6 @@ ahd_alloc(void *platform_arg, char *name)
 	ahd->int_coalescing_stop_threshold =
 	    AHD_INT_COALESCING_STOP_THRESHOLD_DEFAULT;
 
-	if (ahd_platform_alloc(ahd, platform_arg) != 0) {
-		ahd_free(ahd);
-		ahd = NULL;
-	}
 #ifdef AHD_DEBUG
 	if ((ahd_debug & AHD_SHOW_MEMORY) != 0) {
 		printk("%s: scb size = 0x%x, hscb size = 0x%x\n",
@@ -6123,6 +6119,10 @@ ahd_alloc(void *platform_arg, char *name)
 		       (u_int)sizeof(struct hardware_scb));
 	}
 #endif
+	if (ahd_platform_alloc(ahd, platform_arg) != 0) {
+		ahd_free(ahd);
+		ahd = NULL;
+	}
 	return (ahd);
 }
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 3a9eca163db8..b92f86acb8bb 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -8869,7 +8869,7 @@ static void hpsa_disable_rld_caching(struct ctlr_info *h)
 	kfree(options);
 }
 
-static void hpsa_shutdown(struct pci_dev *pdev)
+static void __hpsa_shutdown(struct pci_dev *pdev)
 {
 	struct ctlr_info *h;
 
@@ -8884,6 +8884,12 @@ static void hpsa_shutdown(struct pci_dev *pdev)
 	hpsa_disable_interrupt_mode(h);		/* pci_init 2 */
 }
 
+static void hpsa_shutdown(struct pci_dev *pdev)
+{
+	__hpsa_shutdown(pdev);
+	pci_disable_device(pdev);
+}
+
 static void hpsa_free_device_info(struct ctlr_info *h)
 {
 	int i;
@@ -8927,7 +8933,7 @@ static void hpsa_remove_one(struct pci_dev *pdev)
 		scsi_remove_host(h->scsi_host);		/* init_one 8 */
 	/* includes hpsa_free_irqs - init_one 4 */
 	/* includes hpsa_disable_interrupt_mode - pci_init 2 */
-	hpsa_shutdown(pdev);
+	__hpsa_shutdown(pdev);
 
 	hpsa_free_device_info(h);		/* scan */
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 61f93a134956..293f04119eba 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3344,6 +3344,7 @@ _base_mpi_ep_writeq(__u64 b, volatile void __iomem *addr,
 	spin_lock_irqsave(writeq_lock, flags);
 	writel((u32)(data_out), addr);
 	writel((u32)(data_out >> 32), (addr + 4));
+	mmiowb();
 	spin_unlock_irqrestore(writeq_lock, flags);
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 8f55dd44adae..636960ad029a 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5037,7 +5037,8 @@ qla2x00_iidma_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 		return;
 
 	if (fcport->fp_speed == PORT_SPEED_UNKNOWN ||
-	    fcport->fp_speed > ha->link_data_rate)
+	    fcport->fp_speed > ha->link_data_rate ||
+	    !ha->flags.gpsc_supported)
 		return;
 
 	rval = qla2x00_set_idma_speed(vha, fcport->loop_id, fcport->fp_speed,
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index a3dc83f9444d..68560a097ae1 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2494,8 +2494,12 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 		ox_id = le16_to_cpu(sts24->ox_id);
 		par_sense_len = sizeof(sts24->data);
 		/* Valid values of the retry delay timer are 0x1-0xffef */
-		if (sts24->retry_delay > 0 && sts24->retry_delay < 0xfff1)
-			retry_delay = sts24->retry_delay;
+		if (sts24->retry_delay > 0 && sts24->retry_delay < 0xfff1) {
+			retry_delay = sts24->retry_delay & 0x3fff;
+			ql_dbg(ql_dbg_io, sp->vha, 0x3033,
+			    "%s: scope=%#x retry_delay=%#x\n", __func__,
+			    sts24->retry_delay >> 14, retry_delay);
+		}
 	} else {
 		if (scsi_status & SS_SENSE_LEN_VALID)
 			sense_len = le16_to_cpu(sts->req_sense_length);
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index d8a36c13aeda..7e875f575229 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -292,6 +292,14 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			if (time_after(jiffies, wait_time))
 				break;
 
+			/*
+			 * Check if it's UNLOADING, cause we cannot poll in
+			 * this case, or else a NULL pointer dereference
+			 * is triggered.
+			 */
+			if (unlikely(test_bit(UNLOADING, &base_vha->dpc_flags)))
+				return QLA_FUNCTION_TIMEOUT;
+
 			/* Check for pending interrupts. */
 			qla2x00_poll(ha->rsp_q_map[0]);
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 210407cd2341..ff1ba996d87b 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -452,7 +452,7 @@ static s64 sd_zbc_check_zone_size(struct scsi_disk *sdkp)
 			} else if (this_zone_blocks != zone_blocks &&
 				   (block + this_zone_blocks < sdkp->capacity
 				    || this_zone_blocks > zone_blocks)) {
-				this_zone_blocks = 0;
+				zone_blocks = 0;
 				goto out;
 			}
 			block += this_zone_blocks;
