Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405559-2-12716573610818978207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405558; b=qt+XRl2TpBJ9dpGVsDrvg5e2iZ36VB12K8yPx1EFedN6RxTigy
    RHC3z+87LNuPrSbZnJz2QVt0JnPHNcmIRTC/Lkcuj8uexBzwmX9dVoPxnTZs6b7B
    Vtq1Y+50RNQMwfMjJCl+Xc5ZJsX32A5Xps16LozWOokd+40eIr9P28jKYkwHeWpr
    WdB100NtyCrT8ehFRcSvWbFIDpLO4vQXDBwWsrEyaFnhZKuCn7OoiEQPhysvNN9D
    9LkBkCFqBMNTaK/xNlOQTf/9Ec41Z+1zAy3gBrByqJRM1IZv+yHAJnHHZXhx0DWQ
    fZbELXh5BjkCf1ftoD7lrXe+ZBucipLi+bvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405558; bh=Xmay377TEhvHfoFIryt0iBpwOn0jyU
    Vetd9sXnvbeqI=; b=Fw3ZnFtfKWbLHqH1Oabe8n+/YelqD+XIPOG2DvIMdN52nI
    OmhToRqco05tYqHTk5gZzTZahQ2mCGJjd9OgaP0sivXj9M3x8QpAmETY4azOUrD1
    KjybHCCkJylAOOZ00SHSLjAz623B4XQzrfbpkYKciib99z4XmhzEjE0g9/7ahg95
    NUmZSWZmujur63S8cqmSIJWV7a5wraYITF2L6KDklSGpPZYX8wjiYxCBD9BXGqfX
    +MEpQtxLYIgyvQZWBYZm0GX6Dwc+vJCozEsQm+bMWQAOVyEpSiXOYDDbc6n7Ayu7
    0r3RpgDkDzZjJU2iF67o38FGTm11IoNVemZgsr4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPwLXU7bpQdGH4dzbg+u+XefIv8RsgBlaU1oNuKrrDYvjshD7wH4FZo8Gg8nXshH+Ip2kp/Mn13b+6fgbe6duVQCxvyZY48xOBbdKPelXNJoeu9Ci84A
    VPQulzkx+nJEmWQotFNnrQHPhVErE95fgW+zbfN0sbDuClkf1A+1hUd/0RB1MD3hfhaTMqkpofoxa/tNMmPQXUbXy7L/MkBoBsmLHti+2V/WG/NM/qCkS0Ef
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=zAyngx5bAAAA:8 a=VwQbUJbxAAAA:8 a=JDjsHSkAAAAA:8
    a=ag1SF4gXAAAA:8 a=dq7PadFWK6P02X8Xy7sA:9 a=QEXdDO2ut3YA:10
    a=4LA4qAFo6bo561LpWNDU:22 a=AjGcO6oz07-iQ99wixmX:22 a=dseMxAR1CDlncBZeV_se:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754257AbeDVN7O (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:59:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754266AbeDVN7I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:59:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.16 107/196] xprtrdma: Fix corner cases when handling device removal
Date: Sun, 22 Apr 2018 15:52:07 +0200
Message-Id: <20180422135109.778367773@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 25524288631fc5b7d33259fca1e0dc38146be5d6 upstream.

Michal Kalderon has found some corner cases around device unload
with active NFS mounts that I didn't have the imagination to test
when xprtrdma device removal was added last year.

- The ULP device removal handler is responsible for deallocating
  the PD. That wasn't clear to me initially, and my own testing
  suggested it was not necessary, but that is incorrect.

- The transport destruction path can no longer assume that there
  is a valid ID.

- When destroying a transport, ensure that ib_free_cq() is not
  invoked on a CQ that was already released.

Reported-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA from ...")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/verbs.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -250,7 +250,6 @@ rpcrdma_conn_upcall(struct rdma_cm_id *i
 		wait_for_completion(&ia->ri_remove_done);
 
 		ia->ri_id = NULL;
-		ia->ri_pd = NULL;
 		ia->ri_device = NULL;
 		/* Return 1 to ensure the core destroys the id. */
 		return 1;
@@ -445,7 +444,9 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 		ia->ri_id->qp = NULL;
 	}
 	ib_free_cq(ep->rep_attr.recv_cq);
+	ep->rep_attr.recv_cq = NULL;
 	ib_free_cq(ep->rep_attr.send_cq);
+	ep->rep_attr.send_cq = NULL;
 
 	/* The ULP is responsible for ensuring all DMA
 	 * mappings and MRs are gone.
@@ -458,6 +459,8 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 		rpcrdma_dma_unmap_regbuf(req->rl_recvbuf);
 	}
 	rpcrdma_mrs_destroy(buf);
+	ib_dealloc_pd(ia->ri_pd);
+	ia->ri_pd = NULL;
 
 	/* Allow waiters to continue */
 	complete(&ia->ri_remove_done);
@@ -628,14 +631,16 @@ rpcrdma_ep_destroy(struct rpcrdma_ep *ep
 {
 	cancel_delayed_work_sync(&ep->rep_connect_worker);
 
-	if (ia->ri_id->qp) {
+	if (ia->ri_id && ia->ri_id->qp) {
 		rpcrdma_ep_disconnect(ep, ia);
 		rdma_destroy_qp(ia->ri_id);
 		ia->ri_id->qp = NULL;
 	}
 
-	ib_free_cq(ep->rep_attr.recv_cq);
-	ib_free_cq(ep->rep_attr.send_cq);
+	if (ep->rep_attr.recv_cq)
+		ib_free_cq(ep->rep_attr.recv_cq);
+	if (ep->rep_attr.send_cq)
+		ib_free_cq(ep->rep_attr.send_cq);
 }
 
 /* Re-establish a connection after a device removal event.
