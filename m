Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71920C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE7420815
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cbUvsSjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE7420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbeKNB1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:27:40 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41362 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731422AbeKNB1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:27:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F139B8EE12F;
        Tue, 13 Nov 2018 07:29:03 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fHRz-D1pljmF; Tue, 13 Nov 2018 07:29:03 -0800 (PST)
Received: from [192.168.45.84] (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8E5AA8EE0D4;
        Tue, 13 Nov 2018 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542122943;
        bh=zRNF7rnveY5Vq7zcAlsKK4iXXXVXLLIR//xq7IcJs+s=;
        h=Subject:From:To:Cc:Date:From;
        b=cbUvsSjQSyqPaEDily36M7o6aohcDh1dDRZnD/+SfMlY5NXTOEzmG3NfS0eqruiym
         5fOYUd5DRol/BxL38EEBjXxVfKQXV6A4+g55/Ji4lEMj2iYyeRmi0//XUd7eEblkHR
         fzptT1wceN3BtHC7eoYGtubD0RCVwdua78OubpS4=
Message-ID: <1542122942.3042.3.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 4.20-rc2
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Nov 2018 07:29:02 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly a set of minor and obvious fixes (three in one of the
new drivers).  The only substantial change is to move the ufs to the
blk-mq now that the merge window fixed the suspend/resume issues with
blk-mq.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Arnd Bergmann (4):
      scsi: myrs: only build on little-endian platforms
      scsi: myrs: avoid stack overflow warning
      scsi: lpfc: fix remoteport access
      scsi: myrb: fix sprintf buffer overflow warning

Bart Van Assche (1):
      scsi: target/core: Avoid that a kernel oops is triggered when COMPARE AND WRITE fails

Finn Thain (1):
      scsi: NCR5380: Return false instead of NULL

Martin K. Petersen (1):
      Revert "scsi: ufs: Disable blk-mq for now"

Masanari Iida (1):
      scsi: qla2xxx: Fix a typo in MODULE_PARM_DESC

Quinn Tran (1):
      scsi: qla2xxx: Initialize port speed to avoid setting lower speed

YueHaibing (1):
      scsi: hisi_sas: Remove set but not used variable 'dq_list'

And the diffstat:

 drivers/scsi/Kconfig                   |  1 +
 drivers/scsi/NCR5380.c                 |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 --
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  2 --
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  2 --
 drivers/scsi/lpfc/lpfc_debugfs.c       |  2 ++
 drivers/scsi/myrb.c                    |  3 ++-
 drivers/scsi/myrs.c                    | 13 ++++++++-----
 drivers/scsi/qla2xxx/qla_init.c        |  1 +
 drivers/scsi/qla2xxx/qla_os.c          |  2 +-
 drivers/scsi/ufs/ufshcd.c              |  7 -------
 drivers/target/target_core_transport.c |  4 ++--
 12 files changed, 18 insertions(+), 23 deletions(-)

With full diff below

James

---

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index f07444d30b21..640cd1b31a18 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -578,6 +578,7 @@ config SCSI_MYRB
 config SCSI_MYRS
 	tristate "Mylex DAC960/DAC1100 PCI RAID Controller (SCSI Interface)"
 	depends on PCI
+	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
 	select RAID_ATTRS
 	help
 	  This driver adds support for the Mylex DAC960, AcceleRAID, and
diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 8429c855701f..01c23d27f290 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1198,7 +1198,7 @@ static bool NCR5380_select(struct Scsi_Host *instance, struct scsi_cmnd *cmd)
 
 out:
 	if (!hostdata->selecting)
-		return NULL;
+		return false;
 	hostdata->selecting = NULL;
 	return ret;
 }
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index f0e457e6884e..8df822a4a1bd 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -904,11 +904,9 @@ static void start_delivery_v1_hw(struct hisi_sas_dq *dq)
 {
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
 	struct hisi_sas_slot *s, *s1, *s2 = NULL;
-	struct list_head *dq_list;
 	int dlvry_queue = dq->id;
 	int wp;
 
-	dq_list = &dq->list;
 	list_for_each_entry_safe(s, s1, &dq->list, delivery) {
 		if (!s->ready)
 			break;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index cc36b6473e98..77a85ead483e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1670,11 +1670,9 @@ static void start_delivery_v2_hw(struct hisi_sas_dq *dq)
 {
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
 	struct hisi_sas_slot *s, *s1, *s2 = NULL;
-	struct list_head *dq_list;
 	int dlvry_queue = dq->id;
 	int wp;
 
-	dq_list = &dq->list;
 	list_for_each_entry_safe(s, s1, &dq->list, delivery) {
 		if (!s->ready)
 			break;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index bd4ce38b98d2..a369450a1fa7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -886,11 +886,9 @@ static void start_delivery_v3_hw(struct hisi_sas_dq *dq)
 {
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
 	struct hisi_sas_slot *s, *s1, *s2 = NULL;
-	struct list_head *dq_list;
 	int dlvry_queue = dq->id;
 	int wp;
 
-	dq_list = &dq->list;
 	list_for_each_entry_safe(s, s1, &dq->list, delivery) {
 		if (!s->ready)
 			break;
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 0c8005bb0f53..34d311a7dbef 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -698,6 +698,8 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 		rport = lpfc_ndlp_get_nrport(ndlp);
 		if (rport)
 			nrport = rport->remoteport;
+		else
+			nrport = NULL;
 		spin_unlock(&phba->hbalock);
 		if (!nrport)
 			continue;
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index aeb282f617c5..0642f2d0a3bb 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1049,7 +1049,8 @@ static int myrb_get_hba_config(struct myrb_hba *cb)
 		enquiry2->fw.firmware_type = '0';
 		enquiry2->fw.turn_id = 0;
 	}
-	sprintf(cb->fw_version, "%d.%02d-%c-%02d",
+	snprintf(cb->fw_version, sizeof(cb->fw_version),
+		"%d.%02d-%c-%02d",
 		enquiry2->fw.major_version,
 		enquiry2->fw.minor_version,
 		enquiry2->fw.firmware_type,
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 0264a2e2bc19..b8d54ef8cf6d 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -163,9 +163,12 @@ static unsigned char myrs_get_ctlr_info(struct myrs_hba *cs)
 	dma_addr_t ctlr_info_addr;
 	union myrs_sgl *sgl;
 	unsigned char status;
-	struct myrs_ctlr_info old;
+	unsigned short ldev_present, ldev_critical, ldev_offline;
+
+	ldev_present = cs->ctlr_info->ldev_present;
+	ldev_critical = cs->ctlr_info->ldev_critical;
+	ldev_offline = cs->ctlr_info->ldev_offline;
 
-	memcpy(&old, cs->ctlr_info, sizeof(struct myrs_ctlr_info));
 	ctlr_info_addr = dma_map_single(&cs->pdev->dev, cs->ctlr_info,
 					sizeof(struct myrs_ctlr_info),
 					DMA_FROM_DEVICE);
@@ -198,9 +201,9 @@ static unsigned char myrs_get_ctlr_info(struct myrs_hba *cs)
 		    cs->ctlr_info->rbld_active +
 		    cs->ctlr_info->exp_active != 0)
 			cs->needs_update = true;
-		if (cs->ctlr_info->ldev_present != old.ldev_present ||
-		    cs->ctlr_info->ldev_critical != old.ldev_critical ||
-		    cs->ctlr_info->ldev_offline != old.ldev_offline)
+		if (cs->ctlr_info->ldev_present != ldev_present ||
+		    cs->ctlr_info->ldev_critical != ldev_critical ||
+		    cs->ctlr_info->ldev_offline != ldev_offline)
 			shost_printk(KERN_INFO, cs->host,
 				     "Logical drive count changes (%d/%d/%d)\n",
 				     cs->ctlr_info->ldev_critical,
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 6fe20c27acc1..eb59c796a795 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4763,6 +4763,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	fcport->loop_id = FC_NO_LOOP_ID;
 	qla2x00_set_fcport_state(fcport, FCS_UNCONFIGURED);
 	fcport->supported_classes = FC_COS_UNSPECIFIED;
+	fcport->fp_speed = PORT_SPEED_UNKNOWN;
 
 	fcport->ct_desc.ct_sns = dma_alloc_coherent(&vha->hw->pdev->dev,
 		sizeof(struct ct_sns_pkt), &fcport->ct_desc.ct_sns_dma,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 518f15141170..20c85eed1a75 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -67,7 +67,7 @@ module_param(ql2xplogiabsentdevice, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xplogiabsentdevice,
 		"Option to enable PLOGI to devices that are not present after "
 		"a Fabric scan.  This is needed for several broken switches. "
-		"Default is 0 - no PLOGI. 1 - perfom PLOGI.");
+		"Default is 0 - no PLOGI. 1 - perform PLOGI.");
 
 int ql2xloginretrycount = 0;
 module_param(ql2xloginretrycount, int, S_IRUGO);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 23d7cca36ff0..27db55b0ca7f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8099,13 +8099,6 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 		err = -ENOMEM;
 		goto out_error;
 	}
-
-	/*
-	 * Do not use blk-mq at this time because blk-mq does not support
-	 * runtime pm.
-	 */
-	host->use_blk_mq = false;
-
 	hba = shost_priv(host);
 	hba->host = host;
 	hba->dev = dev;
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index e31e4fc31aa1..2cfd61d62e97 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1778,7 +1778,7 @@ EXPORT_SYMBOL(target_submit_tmr);
 void transport_generic_request_failure(struct se_cmd *cmd,
 		sense_reason_t sense_reason)
 {
-	int ret = 0;
+	int ret = 0, post_ret;
 
 	pr_debug("-----[ Storage Engine Exception; sense_reason %d\n",
 		 sense_reason);
@@ -1790,7 +1790,7 @@ void transport_generic_request_failure(struct se_cmd *cmd,
 	transport_complete_task_attr(cmd);
 
 	if (cmd->transport_complete_callback)
-		cmd->transport_complete_callback(cmd, false, NULL);
+		cmd->transport_complete_callback(cmd, false, &post_ret);
 
 	if (transport_check_aborted_status(cmd, 1))
 		return;
