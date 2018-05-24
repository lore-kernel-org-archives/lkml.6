Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161926-2-15827133161570001426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161925; b=ZKOyiE2n9JfkxiQ57KQkcVIK3mMWsrUw8akUMQxMVVb9jI1xLC
    UoDlkLG3WmRfOBROvjD+Kvu03FMKdumIUeLF8M3wd/FJFhntNi3X5lLmrvXvoLKR
    cecLAbHbPAXofKpVxrxMvC+7B2aUONOMRevYuVmuM3X3T3f/1tfAis1cKuwwBiCd
    m4FrvOodM5ybdQlGA4bCXG1i+OUSUKdU/K8w7+Lgmnu9TaLPYH2wQIOz2N6Dumw6
    eRswmfGcgYYSqz2HcGPH+ff6w/Sn4FPpN1ywytYDlMWEhIQr10gUWYcjTJhJqySV
    uwAo69IQj4qEp14MZNtSlrk8gYGSPzqi4z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161925; bh=YhZiQLIFkGtZklukEdPobZycJzZAXE
    goj5wJ392yTO0=; b=dDkrkdKW4v6BUXXbcGqlb1RHpoKBzNymnMNwSVrtrG8ikq
    P12d3Athj8WUi28Ug4bW+y6+gS/yZtO9HPKhu5jQc+wcWXdu8CTfO9/ux/kV0DgE
    UpE832gUbDtntS072WAp+ZE1cUwPiJvUL2D/F9Qfi7PfDkeogey3B/MvIP/LGxOi
    tz4EMh5HjdPHSJ48EigXnAeuxEaTkZ6/oXwQpYSGKXRgu81yr8VvkpEd1nhSSL/T
    lfCNHLfbKzq1t0wRBsxL/DwFz7MdoLvjf2RggRryw41wTqaJ7G/ChbN/KMVucw4e
    +742mKl+JntCalvWGVjDm9G7/Rr6AqSOmTGNRbwg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tK0rsKPY x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tK0rsKPY x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCyBT9NS0Bqv8OLwkTqD7M6bxwzXuzmPxFDRNi0ZHzZPcYlJPdJyAhmsnci85ya0eV123rphqtFQ2irrkR7zlJU954NcCedqnELn+cLmDYyfc00W1FxW
    Q1qg498vwkx5aPMm9uWJ8Kn003/bGtvZN+X6I7yk7KyePEfhIyzx3qSUt/g1LIk/3oIZ9by5ckRndo/p9fpZbtDQR2OpVb1ATPoyNO/pzWHmiFZ9LYZmhfDM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JF9118EUAAAA:8 a=zAyngx5bAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=UKgGvQLnO4sDRP_H8wUA:9 a=QEXdDO2ut3YA:10
    a=xVlTc564ipvMDusKsbsT:22 a=4LA4qAFo6bo561LpWNDU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967447AbeEXLi0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967308AbeEXJtT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 56/96] scsi: qla2xxx: Avoid triggering undefined behavior in qla2x00_mbx_completion()
Date: Thu, 24 May 2018 11:38:39 +0200
Message-Id: <20180524093608.717835490@linuxfoundation.org>
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

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit c02189e12ce3bf3808cb880569d3b10249f50bd9 ]

A left shift must shift less than the bit width of the left argument.
Avoid triggering undefined behavior if ha->mbx_count == 32.

This patch avoids that UBSAN reports the following complaint:

UBSAN: Undefined behaviour in drivers/scsi/qla2xxx/qla_isr.c:275:14
shift exponent 32 is too large for 32-bit type 'int'
Call Trace:
 dump_stack+0x4e/0x6c
 ubsan_epilogue+0xd/0x3b
 __ubsan_handle_shift_out_of_bounds+0x112/0x14c
 qla2x00_mbx_completion+0x1c5/0x25d [qla2xxx]
 qla2300_intr_handler+0x1ea/0x3bb [qla2xxx]
 qla2x00_mailbox_command+0x77b/0x139a [qla2xxx]
 qla2x00_mbx_reg_test+0x83/0x114 [qla2xxx]
 qla2x00_chip_diag+0x354/0x45f [qla2xxx]
 qla2x00_initialize_adapter+0x2c2/0xa4e [qla2xxx]
 qla2x00_probe_one+0x1681/0x392e [qla2xxx]
 pci_device_probe+0x10b/0x1f1
 driver_probe_device+0x21f/0x3a4
 __driver_attach+0xa9/0xe1
 bus_for_each_dev+0x6e/0xb5
 driver_attach+0x22/0x3c
 bus_add_driver+0x1d1/0x2ae
 driver_register+0x78/0x130
 __pci_register_driver+0x75/0xa8
 qla2x00_module_init+0x21b/0x267 [qla2xxx]
 do_one_initcall+0x5a/0x1e2
 do_init_module+0x9d/0x285
 load_module+0x20db/0x38e3
 SYSC_finit_module+0xa8/0xbc
 SyS_finit_module+0x9/0xb
 do_syscall_64+0x77/0x271
 entry_SYSCALL64_slow_path+0x25/0x25

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_isr.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -272,7 +272,8 @@ qla2x00_mbx_completion(scsi_qla_host_t *
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 
 	/* Read all mbox registers? */
-	mboxes = (1 << ha->mbx_count) - 1;
+	WARN_ON_ONCE(ha->mbx_count > 32);
+	mboxes = (1ULL << ha->mbx_count) - 1;
 	if (!ha->mcp)
 		ql_dbg(ql_dbg_async, vha, 0x5001, "MBX pointer ERROR.\n");
 	else
@@ -2516,7 +2517,8 @@ qla24xx_mbx_completion(scsi_qla_host_t *
 	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
 
 	/* Read all mbox registers? */
-	mboxes = (1 << ha->mbx_count) - 1;
+	WARN_ON_ONCE(ha->mbx_count > 32);
+	mboxes = (1ULL << ha->mbx_count) - 1;
 	if (!ha->mcp)
 		ql_dbg(ql_dbg_async, vha, 0x504e, "MBX pointer ERROR.\n");
 	else
