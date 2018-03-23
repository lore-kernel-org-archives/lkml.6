Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806674-2-11945581890362067007
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
    t=1521806673; b=vCTEbyb5h7IzkjGCBv1WKt1hjwxkjilSgml7EoAhZY+L+aY
    P5ib07jOJWwZt0k4UjHG0UN/l0VjDLNp/phk9DX5P1UjSFKg3C5AdFeVgDt1UZ9P
    DNu45b/M0lfDHERUTRqVF7FdUs8euf6SXxq/Fb2Wx4ubDa/YTlsVV6iYJLiuvji2
    tvNb5XIIHrBE+O9ojMopPyFpwnynr3AaBR9nRSsqizO//iLxLE7wTfuZY95pYLUb
    P9bcZHnQ1UyQcuq+QONVqDDAexCSf7XCmh4TdG8db2wqgl9fSvODSpFxip8PtuG+
    PrzOvG9xC+wZLx3TmF/mnWgxR5aVrkPMs0YdZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806673; bh=1uXYi1fyAwBxTfgYiKv6UTMU+I
    rIAUepIndOEX9QWNc=; b=cqblWm8aTg6q9EWQliui3kKN7bFwOoGzTkDxrJQevP
    ck0mSinXWLvXXT/OMRtFQ7k3+YcT8drWQkQ6cknx/74ZL/mmY9awd1XuuruX4At5
    xG+C3K1iqEHsbr3/5JKs+fpHYzdotR+JNgsOkP9xpohQsj+IlxTxTmVeacS4I0VI
    Qn+vsS6Jkh0W7+rChFCz5V7WXPPTZmvr6DVUbaEBOMrcBeKe3ciGT+fIMelfCrcq
    mQHNzuoFpFzeF0BbmdC/xH8VwTBI8QG3u4VrdTegI5VjXWdHllZH0HQu/ZBXAl8o
    SsMzpK54aBSJBdvpzhRBvrG8xFG+4eIu3He3AUSSY8AA==
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
        id S1753355AbeCWJ7f (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbeCWJ72 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Bryan Tan <bryantan@vmware.com>,
        Aditya Sarwade <asarwade@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Adit Ranadive <aditr@vmware.com>
Subject: [PATCH 4.15 79/84] RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file
Date: Fri, 23 Mar 2018 10:54:33 +0100
Message-Id: <20180323095423.885389341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adit Ranadive <aditr@vmware.com>

commit 1f5a6c47aabc4606f91ad2e6ef71a1ff1924101c upstream.

This ensures that we return the right structures back to userspace.
Otherwise, it looks like the reserved fields in the response structures
in userspace might have uninitialized data in them.

Fixes: 8b10ba783c9d ("RDMA/vmw_pvrdma: Add shared receive queue support")
Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Bryan Tan <bryantan@vmware.com>
Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c    |    4 +++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c   |    4 +++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |    4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -114,6 +114,7 @@ struct ib_cq *pvrdma_create_cq(struct ib
 	union pvrdma_cmd_resp rsp;
 	struct pvrdma_cmd_create_cq *cmd = &req.create_cq;
 	struct pvrdma_cmd_create_cq_resp *resp = &rsp.create_cq_resp;
+	struct pvrdma_create_cq_resp cq_resp = {0};
 	struct pvrdma_create_cq ucmd;
 
 	BUILD_BUG_ON(sizeof(struct pvrdma_cqe) != 64);
@@ -198,6 +199,7 @@ struct ib_cq *pvrdma_create_cq(struct ib
 
 	cq->ibcq.cqe = resp->cqe;
 	cq->cq_handle = resp->cq_handle;
+	cq_resp.cqn = resp->cq_handle;
 	spin_lock_irqsave(&dev->cq_tbl_lock, flags);
 	dev->cq_tbl[cq->cq_handle % dev->dsr->caps.max_cq] = cq;
 	spin_unlock_irqrestore(&dev->cq_tbl_lock, flags);
@@ -206,7 +208,7 @@ struct ib_cq *pvrdma_create_cq(struct ib
 		cq->uar = &(to_vucontext(context)->uar);
 
 		/* Copy udata back. */
-		if (ib_copy_to_udata(udata, &cq->cq_handle, sizeof(__u32))) {
+		if (ib_copy_to_udata(udata, &cq_resp, sizeof(cq_resp))) {
 			dev_warn(&dev->pdev->dev,
 				 "failed to copy back udata\n");
 			pvrdma_destroy_cq(&cq->ibcq);
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -113,6 +113,7 @@ struct ib_srq *pvrdma_create_srq(struct
 	union pvrdma_cmd_resp rsp;
 	struct pvrdma_cmd_create_srq *cmd = &req.create_srq;
 	struct pvrdma_cmd_create_srq_resp *resp = &rsp.create_srq_resp;
+	struct pvrdma_create_srq_resp srq_resp = {0};
 	struct pvrdma_create_srq ucmd;
 	unsigned long flags;
 	int ret;
@@ -204,12 +205,13 @@ struct ib_srq *pvrdma_create_srq(struct
 	}
 
 	srq->srq_handle = resp->srqn;
+	srq_resp.srqn = resp->srqn;
 	spin_lock_irqsave(&dev->srq_tbl_lock, flags);
 	dev->srq_tbl[srq->srq_handle % dev->dsr->caps.max_srq] = srq;
 	spin_unlock_irqrestore(&dev->srq_tbl_lock, flags);
 
 	/* Copy udata back. */
-	if (ib_copy_to_udata(udata, &srq->srq_handle, sizeof(__u32))) {
+	if (ib_copy_to_udata(udata, &srq_resp, sizeof(srq_resp))) {
 		dev_warn(&dev->pdev->dev, "failed to copy back udata\n");
 		pvrdma_destroy_srq(&srq->ibsrq);
 		return ERR_PTR(-EINVAL);
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -447,6 +447,7 @@ struct ib_pd *pvrdma_alloc_pd(struct ib_
 	union pvrdma_cmd_resp rsp;
 	struct pvrdma_cmd_create_pd *cmd = &req.create_pd;
 	struct pvrdma_cmd_create_pd_resp *resp = &rsp.create_pd_resp;
+	struct pvrdma_alloc_pd_resp pd_resp = {0};
 	int ret;
 	void *ptr;
 
@@ -475,9 +476,10 @@ struct ib_pd *pvrdma_alloc_pd(struct ib_
 	pd->privileged = !context;
 	pd->pd_handle = resp->pd_handle;
 	pd->pdn = resp->pd_handle;
+	pd_resp.pdn = resp->pd_handle;
 
 	if (context) {
-		if (ib_copy_to_udata(udata, &pd->pdn, sizeof(__u32))) {
+		if (ib_copy_to_udata(udata, &pd_resp, sizeof(pd_resp))) {
 			dev_warn(&dev->pdev->dev,
 				 "failed to copy back protection domain\n");
 			pvrdma_dealloc_pd(&pd->ibpd);
