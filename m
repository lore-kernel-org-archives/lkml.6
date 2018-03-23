Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804525-2-9951954479667831059
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804525; b=Y5UMgrBI43tzxRI8pmiz4g9MsECnW/YaMeXfWBVO871ZT1a
    GuW3tgE1C/e2EW8473rmJAZLrN0H1/eTwqlWK1B5YQFda5qEElrm71liienm/RJU
    AwkRpgR5fsaFDjUC+7UUCjS87KU2RGyYz8iZQXq2F7H4AoetCdBVGyrSWxnPHOqf
    cBBbfZS39xOAHpdHAB3MfcMz1Hz7erZZw/hgIEgdqf/cFP+lR6fFX+FBNoej4Y8l
    ohz2g8dp9sHJsRFwH/IPeDL2suVYtHM9vw9ufhI3mglMCgpEriyJrOJDkFa/lKtV
    UtUXHt2hRXSqtWjE/57au/Q4yOFA0nvYPcxfrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804525; bh=fxclqcxPwyMWUp3IMPxurM2eKV
    5nAI8NV6kQ6egfjuc=; b=OTxB8uwfUYTfOdy+vvaJtXxLM+LiNtMRk3M0Ayi7V2
    8kUs638i9AfqNFLAAq2DerDF1DHFjxXm7oOmDAAGpYcVR6s5cLxcDorVJrm3713q
    0Tqp7HXY29sQxaXeyCbkYPQaIdzr4ubFwPN9RTah3Zl8NZKdoJmpPo5obAH5oF/4
    XTb804uFvZfKTTGYkm66Q+YOLlBvnS2bx/vUHa+K9Q63n9UofTzZA6/IhMfB86Wg
    iYb/+onEnS1j0tht7YZUBeZ831g+D7uBVcmn4LFDdBphZZhgN7GazGQqHzwayJSO
    To/jOY8gN/tdINtjA+aXrD+yaHKAU1izXpMO/Kfg5Eow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1755367AbeCWL2c (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:28:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeCWKGw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 056/177] Fix Express lane queue creation.
Date: Fri, 23 Mar 2018 10:53:04 +0100
Message-Id: <20180323094207.820786672@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 7e04e21afa82ef024416f5413b5bdb66e0505bcd ]

The older sli4 adapters only supported the 64 byte WQE entry size.
The new adapter (fw) support both 64 and 128 byte WQE entry sizies.
The Express lane WQ was not being created with the 128 byte WQE sizes
when it was supported.

Not having the right WQE size created for the express lane work queue
caused the the firmware to overwrite the lun indentifier in the FCP header.

This patch correctly creates the express lane work queue with the
supported size.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_init.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11312,6 +11312,7 @@ int
 lpfc_fof_queue_create(struct lpfc_hba *phba)
 {
 	struct lpfc_queue *qdesc;
+	uint32_t wqesize;
 
 	/* Create FOF EQ */
 	qdesc = lpfc_sli4_queue_alloc(phba, phba->sli4_hba.eq_esize,
@@ -11332,8 +11333,11 @@ lpfc_fof_queue_create(struct lpfc_hba *p
 		phba->sli4_hba.oas_cq = qdesc;
 
 		/* Create OAS WQ */
-		qdesc = lpfc_sli4_queue_alloc(phba, phba->sli4_hba.wq_esize,
+		wqesize = (phba->fcp_embed_io) ?
+				LPFC_WQE128_SIZE : phba->sli4_hba.wq_esize;
+		qdesc = lpfc_sli4_queue_alloc(phba, wqesize,
 					      phba->sli4_hba.wq_ecount);
+
 		if (!qdesc)
 			goto out_error;
 
