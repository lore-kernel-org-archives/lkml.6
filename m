Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805410-2-6251358346174703879
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
    t=1521805409; b=Egk2+zS8uP29BoVwqL8jfUWZFPglCxohx2niuYbidGFswa0
    EUN0QCqHwyFiAaFM4xtc0f5dIH4b3nQX0emmYxUt/p7ZPdyuCriSo0Uy45NVSnbC
    kzi/fLTdXNlp1ZSI9IdALw/Nyw21CkB5/4e9jSYzaXwhsDLxNosDsrwK/PL5dvNV
    3J651i3IRrctY43SQdZHSrMoYigiP2NrOn5SOPlmKfG04GyvBYmff6T1tS5ATOio
    EH7VE88Jlupm8iHPcQoNHKbXKozdgdP2R3utJwd4CDTR9bPxoFjtM6iWnyQcnNAS
    f8QoMA0D8rTFd7oJPYBBN/SY/bt6h1Cgvb0Bo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805409; bh=TQjwwO9MY2/t704aY4o3ttYuKM
    BiezvO0N5M835m/Aw=; b=TeK0qmndpi27/zPDDRvVQF+qdT4KTsjHP9FMdPCYpz
    GO5/z/hcnQpRJriVArvv+vCR/fuemKmDpgPn0zEHcYz+/QY9JO1El7bN0dU93h95
    MgC0T183in3JOzQHxnEnpAZQhCc5/KaKKd7itiIwbUWECbHVyt1smgBC6nYv0VjK
    BWppmyXUYcq01RNXOKQFqBi6qnaA4fRxyGgca4ajr0HlZgMK8JNHYYnEBDyucIRP
    5EvrXFhQDKqD2iBJmmOAy6tAWvVYb4AluvMt5Lyop0MVP65/ylwU56M98e9eyAs1
    eOKZxzK2TL7jGmqXtnSUFjzKhkaOn7Npc9PsTCKFJn9A==
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
        id S1754502AbeCWKDl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:03:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754483AbeCWKDj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Bryan Tan <bryantan@vmware.com>,
        Aditya Sarwade <asarwade@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Adit Ranadive <aditr@vmware.com>
Subject: [PATCH 4.14 77/77] RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file
Date: Fri, 23 Mar 2018 10:54:51 +0100
Message-Id: <20180323094147.436849154@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -444,6 +444,7 @@ struct ib_pd *pvrdma_alloc_pd(struct ib_
 	union pvrdma_cmd_resp rsp;
 	struct pvrdma_cmd_create_pd *cmd = &req.create_pd;
 	struct pvrdma_cmd_create_pd_resp *resp = &rsp.create_pd_resp;
+	struct pvrdma_alloc_pd_resp pd_resp = {0};
 	int ret;
 	void *ptr;
 
@@ -472,9 +473,10 @@ struct ib_pd *pvrdma_alloc_pd(struct ib_
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
