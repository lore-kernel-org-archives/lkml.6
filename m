Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEBC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B23A206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyt1IeDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B23A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeLNNW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:22:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45199 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeLNNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:22:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so4854893ljd.12;
        Fri, 14 Dec 2018 05:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sdvan8lmUD1rlPpiah9NeOqv+lAZYCm82gAAtH1UoSA=;
        b=gyt1IeDKZiteZLbY4cDCvHiymE9xVd8otwaZfuSY/MAWievrpiJQZxnfwj7dvBtosO
         HVHbxVd9st3VvdNH2hD1sWvk9q6O8JdKCh/Fc77PdwR5Lqz5ksJWyxYJh767GvBnMsID
         lXFBT0pPUWVsAFuPfpHkZoG8M9rP6Ovr7rkMYjVeUjxqYdyt15pTm7q65+ipUytPu6BB
         FWpTa1O9HyDcLKS5Dcm4XJXONY9TD9hYiiPWt8LFayarxsEkygW+1M18kala5VPg6xyZ
         2ykDlPWPif1cpSfqJd4NJOWf32EjlYTDyscNYXcv7fpAuK+JlcHVbHoafre2dzPqGF27
         F2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sdvan8lmUD1rlPpiah9NeOqv+lAZYCm82gAAtH1UoSA=;
        b=Haz67Co9cXIPDmQWoGCAtaPLW7G08wJ8DyWXCv4b8uCjBr0WnMy21GLMWWX53xiqtf
         SSJ2iGr5W7qmAClTMARN4WtAts5LbKXFX9++Oor20HVraETHA9ISA6fpFTC8FSiEXcqM
         lmHS9H0nHe7/IrV8F0JyEjHUYIhJkpHWGo9ZUf56iTzD+etcCL6tf3JhmfEosu68D3rO
         P/0tb3YJnymgiJEMuvRfcHZUJJu6EjHEdAMMB8Z96fDbyqYcDWuk1NtiW4P0VErvB6DX
         jUKVKLyq8ZhYPm+ckmFp9jSmLb3iW3E6pbQX8UCL1JDnPWmsKS//NThsO5g7XsXs0bvb
         HeLA==
X-Gm-Message-State: AA+aEWb2rsPt7d36d6HJjQqiAcSCVd3smqLp8o+6Ypc2BrpaP8o+3+VV
        eEtrQQS3ECL3h5sa8HOF2CIQW59erdSBaNQI
X-Google-Smtp-Source: AFSGD/Uj4RHtlbDdG8bJw6k08Ub/w6u1doNQH3I2lvhRwdEKp8zeDILxqOAiEtlgzB/pkCFcEkCuRg==
X-Received: by 2002:a2e:2281:: with SMTP id i123-v6mr1643078lji.154.1544793743428;
        Fri, 14 Dec 2018 05:22:23 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id u79-v6sm944101lje.36.2018.12.14.05.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:22:23 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com
Subject: [PATCH 2/6] scsi: hpsa: Support HBA mode on HP Smart Array P410i controllers
Date:   Fri, 14 Dec 2018 18:21:11 +0500
Message-Id: <20181214132115.21440-3-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214132115.21440-1-mironov.ivan@gmail.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on code from the 316b221, most of which was removed by
the b9092b7.

Originally, HBA mode on these controllers was supported only on
Itanium-based HP Integrity servers running HP-UX. Tool for switching
between RAID and HBA modes existed only in form of EFI binary for
ia64 architecture: saupdate.efi[1]. However, I guessed how to overwrite the
corresponding flags field in controller's NVRAM, and was able to
reimplement RAID/HBA mode switching tool for Linux[2].

This change was successfully tested using blktests[3] and xfstests[4] on
my hardware, with embedded P410i controller (PCI ID: 103c:3245, board
ID: 0x3245103c) with firmware version 6.64.

This may work with some other controllers, but it is not tested
(because I do not have the hardware) and it may be very dangerous. That is
why this functionality is disabled by default and may be enabled only
manually using the new module parameter.

[1] https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_0b76aec489764aea9802a6d27b
[2] https://github.com/im-0/hpsahba
[3] https://github.com/osandov/blktests
[4] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/scsi/hpsa.c | 98 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/hpsa.h |  3 ++
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index fc06b790f16b..ee3d7c722a63 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -88,6 +88,11 @@ module_param(hpsa_simple_mode, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(hpsa_simple_mode,
 	"Use 'simple mode' rather than 'performant mode'");
 
+static bool hpsa_use_nvram_hba_flag;
+module_param(hpsa_use_nvram_hba_flag, bool, 0444);
+MODULE_PARM_DESC(hpsa_use_nvram_hba_flag,
+	"Use flag from NVRAM to enable HBA mode");
+
 /* define the PCI info for the cards we can control */
 static const struct pci_device_id hpsa_pci_device_id[] = {
 	{PCI_VENDOR_ID_HP,     PCI_DEVICE_ID_HP_CISSE,     0x103C, 0x3241},
@@ -3039,6 +3044,37 @@ static int hpsa_scsi_do_inquiry(struct ctlr_info *h, unsigned char *scsi3addr,
 	return rc;
 }
 
+static int hpsa_bmic_ctrl_mode_sense(struct ctlr_info *h,
+	struct bmic_controller_parameters *buf)
+{
+	int rc = IO_OK;
+	struct CommandList *c;
+	struct ErrorInfo *ei;
+
+	c = cmd_alloc(h);
+
+	if (fill_cmd(c, BMIC_SENSE_CONTROLLER_PARAMETERS, h, buf, sizeof(*buf),
+			0, RAID_CTLR_LUNID, TYPE_CMD)) {
+		rc = -1;
+		goto out;
+	}
+
+	rc = hpsa_scsi_do_simple_cmd_with_retry(h, c, PCI_DMA_FROMDEVICE,
+		NO_TIMEOUT);
+	if (rc)
+		goto out;
+
+	ei = c->err_info;
+	if (ei->CommandStatus != 0 && ei->CommandStatus != CMD_DATA_UNDERRUN) {
+		hpsa_scsi_interpret_error(h, c);
+		rc = -1;
+	}
+
+out:
+	cmd_free(h, c);
+	return rc;
+}
+
 static int hpsa_send_reset(struct ctlr_info *h, unsigned char *scsi3addr,
 	u8 reset_type, int reply_queue)
 {
@@ -4296,6 +4332,50 @@ static bool hpsa_skip_device(struct ctlr_info *h, u8 *lunaddrbytes,
 	return false;
 }
 
+static int hpsa_nvram_hba_flag_enabled(struct ctlr_info *h, bool *flag_enabled)
+{
+	int rc;
+	struct bmic_controller_parameters *ctlr_params;
+
+	ctlr_params = kzalloc(sizeof(*ctlr_params), GFP_KERNEL);
+	if (!ctlr_params) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = hpsa_bmic_ctrl_mode_sense(h, ctlr_params);
+	if (rc)
+		goto out;
+
+	*flag_enabled = ctlr_params->nvram_flags & HPSA_NVRAM_FLAG_HBA;
+
+out:
+	kfree(ctlr_params);
+	return rc;
+}
+
+static int hpsa_update_nvram_hba_mode(struct ctlr_info *h)
+{
+	int rc;
+	bool flag_enabled;
+
+	if (!hpsa_use_nvram_hba_flag)
+		return 0;
+
+	rc = hpsa_nvram_hba_flag_enabled(h, &flag_enabled);
+	if (rc == -ENOMEM)
+		dev_warn(&h->pdev->dev, "Out of memory.\n");
+	if (rc)
+		return rc;
+
+	dev_info(&h->pdev->dev, "NVRAM HBA flag: %s\n",
+		flag_enabled ? "enabled" : "disabled");
+
+	h->nvram_hba_mode_enabled = flag_enabled;
+
+	return 0;
+}
+
 static void hpsa_update_scsi_devices(struct ctlr_info *h)
 {
 	/* the idea here is we could get notified
@@ -4352,6 +4432,11 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 			__func__);
 	}
 
+	if (hpsa_update_nvram_hba_mode(h)) {
+		h->drv_req_rescan = 1;
+		goto out;
+	}
+
 	/* We might see up to the maximum number of logical and physical disks
 	 * plus external target devices, and a device for the local RAID
 	 * controller.
@@ -4437,11 +4522,16 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 		 * Expose all devices except for physical devices that
 		 * are masked.
 		 */
-		if (MASKED_DEVICE(lunaddrbytes) && this_device->physical_device)
-			this_device->expose_device = 0;
-		else
+		if (MASKED_DEVICE(lunaddrbytes) &&
+				this_device->physical_device) {
+			if (is_disk_or_zbc(this_device) &&
+					h->nvram_hba_mode_enabled)
+				this_device->expose_device = 1;
+			else
+				this_device->expose_device = 0;
+		} else {
 			this_device->expose_device = 1;
-
+		}
 
 		/*
 		 * Get the SAS address for physical devices that are exposed.
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index 59e023696fff..5b508f270520 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -158,6 +158,8 @@ struct bmic_controller_parameters {
 };
 #pragma pack()
 
+#define HPSA_NVRAM_FLAG_HBA (1 << 3)
+
 struct ctlr_info {
 	unsigned int *reply_map;
 	int	ctlr;
@@ -182,6 +184,7 @@ struct ctlr_info {
 	unsigned int msix_vectors;
 	int intr_mode; /* either PERF_MODE_INT or SIMPLE_MODE_INT */
 	struct access_method access;
+	bool nvram_hba_mode_enabled;
 
 	/* queue and queue Info */
 	unsigned int Qdepth;
-- 
2.19.2

