Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405554-2-3974520786842800856
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
    1524405553; b=ab4WpzZc5OOpK682WBta1q549rj2kkMHi8aRci8fCr9ObJrRFJ
    VhNZKYtyAT8Kqf4Nbag2rIbut1+4zx7WCFtTi5nWo3o5FxqkVUpBUeWARZIQpxYW
    xOTVS93IWiCnqVHj1ve9KYRUDfUsinUqBIiXdvaU0QfEbJH7NR+3T1P8GWN7hnzo
    rVwyptk74RuHBz5SoMmlQhi1cTgXlSwFTz/s5Zod9K/jO+pj5v5CREnJCTlOyv9x
    65Yb++gTwruDxbYDo00rCVAzOYKn3c5s0tm62DEL1l5hFs/cEThWA8aGzniaM2bI
    n7JYj4I7wp2fIAl+urzQpuNnuQb0YeZrbHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405553; bh=ug9tgYqi/3tBbBJhWPGitoeKTfWZpN
    KGOLJFVZoUedc=; b=dfx3Q0de2uOYkeSjJ+b0W1L/bfTRfNBfDIKVObq57d5Yc4
    VecWf9mugmgFt1eyN3QBap60ifKTbBQYFrrHxjvJ5zr9b0Silu7Ncfdskdy4Evux
    9QJOIFftmPPn6zv2SCoYZ9i5X1Xvf986MRLPks8e+mC8AIty4yzPabQbdqgG5c5K
    69YbdKH5CcXTPUdy4jbqj8lXawsfBSJAmLxj8OAAbK0aXX7/EW/U/CxgnHhQqJ11
    cngX3De/C7oGCpy2eVyYg3sc7kILo4P4sGhQg4oBj8vlVjO1nd/Yfbz8ncz8wVeX
    k5jUGVjy8VH4eEZTAkRJA8RUaiw3ZMIYoh3BCIlQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfAd0DCbQ58b+mZ62WPoUr1ShIJOxCkc8y5bWngybgcMZAoy4TG25mKsuLDBlqsRziRxOQqN8GuNFNmH9e4HLwzrwY+iGaoR4OgGsKy0dOYn1z6mFdNym
    TpoAAMMIITy5lsYX/tUMcRzi8DuCDp8aYKx5f6KXLYl2nzv5Kc9Ku45Dl7iBHXuHuPH/pprtgrRnc6zudiwyUWCCIZYxYa9OjMEi2Z+SAse9qkPmxTzVYd8o
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=JDjsHSkAAAAA:8 a=ag1SF4gXAAAA:8
    a=gou60wet8BXYU8b9vqAA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=dseMxAR1CDlncBZeV_se:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbeDVN7K (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:59:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754257AbeDVN7G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:59:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.16 106/196] xprtrdma: Fix latency regression on NUMA NFS/RDMA clients
Date: Sun, 22 Apr 2018 15:52:06 +0200
Message-Id: <20180422135109.726959401@linuxfoundation.org>
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

commit 6720a89933739cb8dec748cd253f7c8df2c0ae4d upstream.

With v4.15, on one of my NFS/RDMA clients I measured a nearly
doubling in the latency of small read and write system calls. There
was no change in server round trip time. The extra latency appears
in the whole RPC execution path.

"git bisect" settled on commit ccede7598588 ("xprtrdma: Spread reply
processing over more CPUs") .

After some experimentation, I found that leaving the WQ bound and
allowing the scheduler to pick the dispatch CPU seems to eliminate
the long latencies, and it does not introduce any new regressions.

The fix is implemented by reverting only the part of
commit ccede7598588 ("xprtrdma: Spread reply processing over more
CPUs") that dispatches RPC replies specifically on the CPU where the
matching RPC call was made.

Interestingly, saving the CPU number and later queuing reply
processing there was effective _only_ for a NFS READ and WRITE
request. On my NUMA client, in-kernel RPC reply processing for
asynchronous RPCs was dispatched on the same CPU where the RPC call
was made, as expected. However synchronous RPCs seem to get their
reply dispatched on some other CPU than where the call was placed,
every time.

Fixes: ccede7598588 ("xprtrdma: Spread reply processing over ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    2 +-
 net/sunrpc/xprtrdma/transport.c |    2 --
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1366,7 +1366,7 @@ void rpcrdma_reply_handler(struct rpcrdm
 
 	trace_xprtrdma_reply(rqst->rq_task, rep, req, credits);
 
-	queue_work_on(req->rl_cpu, rpcrdma_receive_wq, &rep->rr_work);
+	queue_work(rpcrdma_receive_wq, &rep->rr_work);
 	return;
 
 out_badstatus:
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -52,7 +52,6 @@
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/sunrpc/addr.h>
-#include <linux/smp.h>
 
 #include "xprt_rdma.h"
 
@@ -651,7 +650,6 @@ xprt_rdma_allocate(struct rpc_task *task
 	if (!rpcrdma_get_recvbuf(r_xprt, req, rqst->rq_rcvsize, flags))
 		goto out_fail;
 
-	req->rl_cpu = smp_processor_id();
 	req->rl_connect_cookie = 0;	/* our reserved value */
 	rpcrdma_set_xprtdata(rqst, req);
 	rqst->rq_buffer = req->rl_sendbuf->rg_base;
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -334,7 +334,6 @@ enum {
 struct rpcrdma_buffer;
 struct rpcrdma_req {
 	struct list_head	rl_list;
-	int			rl_cpu;
 	unsigned int		rl_connect_cookie;
 	struct rpcrdma_buffer	*rl_buffer;
 	struct rpcrdma_rep	*rl_reply;
