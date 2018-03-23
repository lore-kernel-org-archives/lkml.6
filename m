Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521798958-2-7933929963918934643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521798957; b=lsrMiOMgNHEf1txGH94THURTyoPv+6P1OyipN9ftj1nbVwP
    o0ajq+uQ+BJHFsGTqOKuwczOabcBuTSqdb5SasKehxpg4YlSdxYB7/kHE1v90/BP
    JMKysK0syaI20IW7XAHAYOjXNOp35pviuuTGAhkTbK7u5PMnluDnamjoWj6qML6l
    cifDqlOJAZ+MeTVPptAQJvGzyRh6nPa1zu0YS/Mbtz+vdgWmbihsnTXA1D/nCIfH
    nDeMYAJU72bOv7miaNhywrYx1JZ3fU6kXRBa85qMENMGaot/76M7jg0tUF+MCuvc
    uI+d9Uioz3mIeuEutFntbSePzbqVuOKPVd/9RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521798957; bh=PZahZBVxVtFg2ZPJz/C6a8tfoU
    ZlpRR+B331MhWExvg=; b=o6XQLfSw4yFb2i4mCYt6YErnk9O8Z+aRHvPGTEjeXp
    ZpZVJqFoGEhjeuATcwYSy2kwcfs5ClM5qUZDzT6kpvQBoE/6Tc8avYv3hNVCINpD
    4Lgp5JEtVojo4+iOBhW7IDAet5VcVJSP/TwnL3vlsm+oMD9ip83zAiLBBzxjH9i5
    fHr1YszI3XOnWTqRxxkvNBX6/DdJKaDPCNXoRj5Ggt/nz6L8TRkrBo8qBAzDiQ8s
    zM6zHy5Dm7evb0ZXxl0yO5WRfsRFoCAgSqpe1VgNz8YsjumGycPxhLSNQnH3+eOT
    yfSBOHQ0bF0IQilRDrFS+TZx8jtuoQ1xHy8EzFDUxEAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCWJz4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:55:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCWJzz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:55:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 01/84] scsi: megaraid_sas: Do not use 32-bit atomic request descriptor for Ventura controllers
Date: Fri, 23 Mar 2018 10:53:15 +0100
Message-Id: <20180323095412.129952666@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

commit 9ff97fa8db94caeab59a3c5401e975df468b4d8e upstream.

Problem Statement: Sending I/O through 32 bit descriptors to Ventura series of
controller results in IO timeout on certain conditions.

This error only occurs on systems with high I/O activity on Ventura series
controllers.

Changes in this patch will prevent driver from using 32 bit descriptor and use
64 bit Descriptors.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas_fusion.c |   42 +++++++++-------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -216,36 +216,30 @@ inline void megasas_return_cmd_fusion(st
 /**
  * megasas_fire_cmd_fusion -	Sends command to the FW
  * @instance:			Adapter soft state
- * @req_desc:			32bit or 64bit Request descriptor
+ * @req_desc:			64bit Request descriptor
  *
- * Perform PCI Write. Ventura supports 32 bit Descriptor.
- * Prior to Ventura (12G) MR controller supports 64 bit Descriptor.
+ * Perform PCI Write.
  */
 
 static void
 megasas_fire_cmd_fusion(struct megasas_instance *instance,
 		union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc)
 {
-	if (instance->adapter_type == VENTURA_SERIES)
-		writel(le32_to_cpu(req_desc->u.low),
-			&instance->reg_set->inbound_single_queue_port);
-	else {
 #if defined(writeq) && defined(CONFIG_64BIT)
-		u64 req_data = (((u64)le32_to_cpu(req_desc->u.high) << 32) |
-				le32_to_cpu(req_desc->u.low));
+	u64 req_data = (((u64)le32_to_cpu(req_desc->u.high) << 32) |
+		le32_to_cpu(req_desc->u.low));
 
-		writeq(req_data, &instance->reg_set->inbound_low_queue_port);
+	writeq(req_data, &instance->reg_set->inbound_low_queue_port);
 #else
-		unsigned long flags;
-		spin_lock_irqsave(&instance->hba_lock, flags);
-		writel(le32_to_cpu(req_desc->u.low),
-			&instance->reg_set->inbound_low_queue_port);
-		writel(le32_to_cpu(req_desc->u.high),
-			&instance->reg_set->inbound_high_queue_port);
-		mmiowb();
-		spin_unlock_irqrestore(&instance->hba_lock, flags);
+	unsigned long flags;
+	spin_lock_irqsave(&instance->hba_lock, flags);
+	writel(le32_to_cpu(req_desc->u.low),
+		&instance->reg_set->inbound_low_queue_port);
+	writel(le32_to_cpu(req_desc->u.high),
+		&instance->reg_set->inbound_high_queue_port);
+	mmiowb();
+	spin_unlock_irqrestore(&instance->hba_lock, flags);
 #endif
-	}
 }
 
 /**
@@ -982,7 +976,6 @@ megasas_ioc_init_fusion(struct megasas_i
 	const char *sys_info;
 	MFI_CAPABILITIES *drv_ops;
 	u32 scratch_pad_2;
-	unsigned long flags;
 	struct timeval tv;
 	bool cur_fw_64bit_dma_capable;
 
@@ -1121,14 +1114,7 @@ megasas_ioc_init_fusion(struct megasas_i
 			break;
 	}
 
-	/* For Ventura also IOC INIT required 64 bit Descriptor write. */
-	spin_lock_irqsave(&instance->hba_lock, flags);
-	writel(le32_to_cpu(req_desc.u.low),
-	       &instance->reg_set->inbound_low_queue_port);
-	writel(le32_to_cpu(req_desc.u.high),
-	       &instance->reg_set->inbound_high_queue_port);
-	mmiowb();
-	spin_unlock_irqrestore(&instance->hba_lock, flags);
+	megasas_fire_cmd_fusion(instance, &req_desc);
 
 	wait_and_poll(instance, cmd, MFI_POLL_TIMEOUT_SECS);
 
