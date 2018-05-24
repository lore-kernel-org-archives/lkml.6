Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162441-2-3711763128444677448
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162440; b=nFs4WY7dxMixyJekGvj5j8Datm3kCgTBJE2ZtVWcvcfB+Q1xwn
    kOKULc+/GlnUdt5u5IokOg/Ns985MGf/z1GUzPpNgZY6BftUTE0gMMXP/Gh+wqII
    1xrX6Tr+7PovuEQMWUxKue47lg2Hn3UxBNezLxbQoempZlCjU4+d4ucmOdYH9Q6v
    t9lT8K9qZ/T5Ng2NpYibqqlk5DXkXk39pa3i6+yVWYAjrmYiTiW8bbT+Vpz6Kqmz
    9cS0CBY54ROUK5mgYvnGNMpUVayhqPoUrUG15jg4ssV/eHkyFbODpzqLQJvz0+9x
    AEKzaWAnaPlO4RVZ59onp1MiwnLk/igRJobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162440; bh=TLRC/931Aez8SerOOPtbBlwgykvQiQ
    EuC1I55zSNd5o=; b=JaYRP+u3hvx6kMNS3MystIZM/3eSaTtrTBacc/tvnRxVox
    BgPYyLIlOQWyy4msv6i53qYHfwvsyeOYsbkHbgAotdZISthD6UJ2gH5lYya2qm2M
    QeZa2pWPUxMN3Ks/SEtTaXfkWc+rV/ik7q5j3lYlx6+UyzTZq3EiqyDqFBNH+0iK
    69TrG52WTQa2D3RnrfrAfZyCmuN7qBij4NSrFAdOuq1QwrTpL35w8fgTul3RFoCn
    e7J17s07YLb2tmgxy7C4HgH/PJUMnjfVCBabiFkZJWpUTYi+Sr3nmDg/X+zmGaDF
    zJTspQO8GflnylNYNPfcXZ2ezvjc7JuhRBq4zjUQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Glng4R5K x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Glng4R5K x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHpO66Yevf2K+7Alah7r1WZouC0HRdR1diNxrBeLjXNtxFGGZqhxP+KOg06/jdyfC5tSk4NxvChMOp/9NtCykG1ZOrLKq45OShrpvJ3vEjQC//eTZYma
    igvYS6NNB9fWRzehAJ5jovjjY/mcBM5N/o7Jn7MW2eWHUd4vtO9YD991IBDKVyWBmj6dEH00rzLYXncxmSDTWTby5N7/9+2zr6rvqfnfJ3RiIO+Unl+WNbL/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=_jlGtV7tAAAA:8
    a=ag1SF4gXAAAA:8 a=5VKkRt6m1sbennSuhUsA:9 a=QEXdDO2ut3YA:10
    a=nlm17XC03S6CtCLSeiRr:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967069AbeEXJrg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967014AbeEXJrb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Yan <yanaijie@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 18/96] scsi: libsas: defer ata device eh commands to libata
Date: Thu, 24 May 2018 11:38:01 +0200
Message-Id: <20180524093606.632176066@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>

commit 318aaf34f1179b39fa9c30fa0f3288b645beee39 upstream.

When ata device doing EH, some commands still attached with tasks are
not passed to libata when abort failed or recover failed, so libata did
not handle these commands. After these commands done, sas task is freed,
but ata qc is not freed. This will cause ata qc leak and trigger a
warning like below:

WARNING: CPU: 0 PID: 28512 at drivers/ata/libata-eh.c:4037
ata_eh_finish+0xb4/0xcc
CPU: 0 PID: 28512 Comm: kworker/u32:2 Tainted: G     W  OE 4.14.0#1
......
Call trace:
[<ffff0000088b7bd0>] ata_eh_finish+0xb4/0xcc
[<ffff0000088b8420>] ata_do_eh+0xc4/0xd8
[<ffff0000088b8478>] ata_std_error_handler+0x44/0x8c
[<ffff0000088b8068>] ata_scsi_port_error_handler+0x480/0x694
[<ffff000008875fc4>] async_sas_ata_eh+0x4c/0x80
[<ffff0000080f6be8>] async_run_entry_fn+0x4c/0x170
[<ffff0000080ebd70>] process_one_work+0x144/0x390
[<ffff0000080ec100>] worker_thread+0x144/0x418
[<ffff0000080f2c98>] kthread+0x10c/0x138
[<ffff0000080855dc>] ret_from_fork+0x10/0x18

If ata qc leaked too many, ata tag allocation will fail and io blocked
for ever.

As suggested by Dan Williams, defer ata device commands to libata and
merge sas_eh_finish_cmd() with sas_eh_defer_cmd(). libata will handle
ata qcs correctly after this.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: Xiaofei Tan <tanxiaofei@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/libsas/sas_scsi_host.c |   33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -222,6 +222,7 @@ out_done:
 static void sas_eh_finish_cmd(struct scsi_cmnd *cmd)
 {
 	struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(cmd->device->host);
+	struct domain_device *dev = cmd_to_domain_dev(cmd);
 	struct sas_task *task = TO_SAS_TASK(cmd);
 
 	/* At this point, we only get called following an actual abort
@@ -230,6 +231,14 @@ static void sas_eh_finish_cmd(struct scs
 	 */
 	sas_end_task(cmd, task);
 
+	if (dev_is_sata(dev)) {
+		/* defer commands to libata so that libata EH can
+		 * handle ata qcs correctly
+		 */
+		list_move_tail(&cmd->eh_entry, &sas_ha->eh_ata_q);
+		return;
+	}
+
 	/* now finish the command and move it on to the error
 	 * handler done list, this also takes it off the
 	 * error handler pending list.
@@ -237,22 +246,6 @@ static void sas_eh_finish_cmd(struct scs
 	scsi_eh_finish_cmd(cmd, &sas_ha->eh_done_q);
 }
 
-static void sas_eh_defer_cmd(struct scsi_cmnd *cmd)
-{
-	struct domain_device *dev = cmd_to_domain_dev(cmd);
-	struct sas_ha_struct *ha = dev->port->ha;
-	struct sas_task *task = TO_SAS_TASK(cmd);
-
-	if (!dev_is_sata(dev)) {
-		sas_eh_finish_cmd(cmd);
-		return;
-	}
-
-	/* report the timeout to libata */
-	sas_end_task(cmd, task);
-	list_move_tail(&cmd->eh_entry, &ha->eh_ata_q);
-}
-
 static void sas_scsi_clear_queue_lu(struct list_head *error_q, struct scsi_cmnd *my_cmd)
 {
 	struct scsi_cmnd *cmd, *n;
@@ -260,7 +253,7 @@ static void sas_scsi_clear_queue_lu(stru
 	list_for_each_entry_safe(cmd, n, error_q, eh_entry) {
 		if (cmd->device->sdev_target == my_cmd->device->sdev_target &&
 		    cmd->device->lun == my_cmd->device->lun)
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 	}
 }
 
@@ -622,12 +615,12 @@ static void sas_eh_handle_sas_errors(str
 		case TASK_IS_DONE:
 			SAS_DPRINTK("%s: task 0x%p is done\n", __func__,
 				    task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_ABORTED:
 			SAS_DPRINTK("%s: task 0x%p is aborted\n",
 				    __func__, task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_AT_LU:
 			SAS_DPRINTK("task 0x%p is at LU: lu recover\n", task);
@@ -638,7 +631,7 @@ static void sas_eh_handle_sas_errors(str
 					    "recovered\n",
 					    SAS_ADDR(task->dev),
 					    cmd->device->lun);
-				sas_eh_defer_cmd(cmd);
+				sas_eh_finish_cmd(cmd);
 				sas_scsi_clear_queue_lu(work_q, cmd);
 				goto Again;
 			}
