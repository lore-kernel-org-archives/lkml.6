Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159462-2-18151258717782525905
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159461; b=mUVgMrrOiiKp5lpMFguMjfWjOA+nzewl4kXIXFPJpZbn30c/oL
    kCUqB1+7oU3bZhebnh3VDwGi047ruP8bt47nVKR0jxuAyqkSGO0BMhUavWUmdwfg
    ATqp0wZcJtn1VEWam7xnJRApI43lj9X8I+SsF2GTGcZ22fIyLLqTHcBsNsnEUcAv
    2CblTAQngTUEN4xrUVamATWt8/VksNl7PKFnU8G9WOPyg9a9JPy6qUS5WFYwrQhG
    k1XSyEwDWfMJihiqrRtemqV1U2gpcqrKUmnM7cMB19C1v3g2T5WnyJhAtOUu40ft
    pHIhxZXk93eEcDOIbmyBRcpCtFEyaCTvuUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159461; bh=lKANvCog72qIUIXDXFTzcd8ndQnJMa
    m6X4RfaoDTbHA=; b=PY59P8uhIjb76xMt5pGphkoHjD61/xEqrwapWtGDclHPR8
    GCJ2zpwCyM7JyxIjZp6ER+xzNE3fcEmqQzdb+PLsn+qRT30Nh2uos5weQugTUD+7
    cX6g0FNodHVbgKp8Ocl0u8sU3cE4JEl96UydqJ1OpIhkCL95QuVJ2L20KdIYLvTa
    i4uoyCBc+S2I3h/IF10XoXnqoWkdzGVxFR3JYRxEzwVl5WvTzNGeraEO0FIxeiux
    akYe8SZ3rQvu6T/YJC8aRchjb+zkr4pZqb7oDdWHkqZ6/f71SF0gmcWYCZM9AZWs
    /+hhYcERn7enwx2hfC1hj3xAYZv/KWNzdnM1uqJw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=p4ZyZ5mz x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=p4ZyZ5mz x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJIJ7ma9rAqSqEL4U/T6Km3Dx+bO0Z9dE+d0H2HAlKlDul7OswUbC0Un4CdWxKWTzSAZYDevXVw01Wl+na88jVH/dDcUplqjUMko+tO2daX8MWvpbbtr
    +lUcia2t+IEldehxsQH3l1poYm+vPLjnY+efE4QlmXzB71XEHez8/V1m81cNxTcT6DmUJe4yQL5USGLUOdW+Ta8V3l/ZfYapu9eOwzMG/0h6yCV5x/Q5cUq9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=CuLLJFOO9y4rdPHpTEYA:9 a=QEXdDO2ut3YA:10
    a=4LA4qAFo6bo561LpWNDU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030270AbeEXK5i (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030259AbeEXJ4L (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manish Rangankar <manish.rangankar@cavium.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 109/165] scsi: qla4xxx: skip error recovery in case of register disconnect.
Date: Thu, 24 May 2018 11:38:35 +0200
Message-Id: <20180524093626.428842355@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Rangankar <manish.rangankar@cavium.com>

[ Upstream commit 1bc5ad3a6acdcf56f83272f2de1cd2389ea9e9e2 ]

A system crashes when continuously removing/re-adding the storage
controller.

Signed-off-by: Manish Rangankar <manish.rangankar@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla4xxx/ql4_def.h |    2 +
 drivers/scsi/qla4xxx/ql4_os.c  |   46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--- a/drivers/scsi/qla4xxx/ql4_def.h
+++ b/drivers/scsi/qla4xxx/ql4_def.h
@@ -168,6 +168,8 @@
 #define DEV_DB_NON_PERSISTENT	0
 #define DEV_DB_PERSISTENT	1
 
+#define QL4_ISP_REG_DISCONNECT 0xffffffffU
+
 #define COPY_ISID(dst_isid, src_isid) {			\
 	int i, j;					\
 	for (i = 0, j = ISID_SIZE - 1; i < ISID_SIZE;)	\
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -262,6 +262,24 @@ static struct iscsi_transport qla4xxx_is
 
 static struct scsi_transport_template *qla4xxx_scsi_transport;
 
+static int qla4xxx_isp_check_reg(struct scsi_qla_host *ha)
+{
+	u32 reg_val = 0;
+	int rval = QLA_SUCCESS;
+
+	if (is_qla8022(ha))
+		reg_val = readl(&ha->qla4_82xx_reg->host_status);
+	else if (is_qla8032(ha) || is_qla8042(ha))
+		reg_val = qla4_8xxx_rd_direct(ha, QLA8XXX_PEG_ALIVE_COUNTER);
+	else
+		reg_val = readw(&ha->reg->ctrl_status);
+
+	if (reg_val == QL4_ISP_REG_DISCONNECT)
+		rval = QLA_ERROR;
+
+	return rval;
+}
+
 static int qla4xxx_send_ping(struct Scsi_Host *shost, uint32_t iface_num,
 			     uint32_t iface_type, uint32_t payload_size,
 			     uint32_t pid, struct sockaddr *dst_addr)
@@ -9188,10 +9206,17 @@ static int qla4xxx_eh_abort(struct scsi_
 	struct srb *srb = NULL;
 	int ret = SUCCESS;
 	int wait = 0;
+	int rval;
 
 	ql4_printk(KERN_INFO, ha, "scsi%ld:%d:%llu: Abort command issued cmd=%p, cdb=0x%x\n",
 		   ha->host_no, id, lun, cmd, cmd->cmnd[0]);
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	srb = (struct srb *) CMD_SP(cmd);
 	if (!srb) {
@@ -9243,6 +9268,7 @@ static int qla4xxx_eh_device_reset(struc
 	struct scsi_qla_host *ha = to_qla_host(cmd->device->host);
 	struct ddb_entry *ddb_entry = cmd->device->hostdata;
 	int ret = FAILED, stat;
+	int rval;
 
 	if (!ddb_entry)
 		return ret;
@@ -9262,6 +9288,12 @@ static int qla4xxx_eh_device_reset(struc
 		      cmd, jiffies, cmd->request->timeout / HZ,
 		      ha->dpc_flags, cmd->result, cmd->allowed));
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	/* FIXME: wait for hba to go online */
 	stat = qla4xxx_reset_lun(ha, ddb_entry, cmd->device->lun);
 	if (stat != QLA_SUCCESS) {
@@ -9305,6 +9337,7 @@ static int qla4xxx_eh_target_reset(struc
 	struct scsi_qla_host *ha = to_qla_host(cmd->device->host);
 	struct ddb_entry *ddb_entry = cmd->device->hostdata;
 	int stat, ret;
+	int rval;
 
 	if (!ddb_entry)
 		return FAILED;
@@ -9322,6 +9355,12 @@ static int qla4xxx_eh_target_reset(struc
 		      ha->host_no, cmd, jiffies, cmd->request->timeout / HZ,
 		      ha->dpc_flags, cmd->result, cmd->allowed));
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	stat = qla4xxx_reset_target(ha, ddb_entry);
 	if (stat != QLA_SUCCESS) {
 		starget_printk(KERN_INFO, scsi_target(cmd->device),
@@ -9376,9 +9415,16 @@ static int qla4xxx_eh_host_reset(struct
 {
 	int return_status = FAILED;
 	struct scsi_qla_host *ha;
+	int rval;
 
 	ha = to_qla_host(cmd->device->host);
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	if ((is_qla8032(ha) || is_qla8042(ha)) && ql4xdontresethba)
 		qla4_83xx_set_idc_dontreset(ha);
 
