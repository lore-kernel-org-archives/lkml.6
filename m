Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28158C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED23E20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216139;
	bh=NhdPfI/2oqphfDIKq5dPj4OtiCIDRmTueAfx252t5LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xjxai0uaeshX9XBA2mNdEg1Uc1OGOJZdbElOOu5j0EB+XofoxWeTrLbSXxd+dKVQp
	 HWlArOFbUGSQZFDs4SOqvMgYtnwP+S5HWj//MFjzpSMnIZbiRKxRvZc71w9VsXCMSz
	 gU52CPpix/5/kcJg/7YR5WpZjg9UipD31pIsz+wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfAKOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387412AbfAKOPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC13214D8;
        Fri, 11 Jan 2019 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216134;
        bh=NhdPfI/2oqphfDIKq5dPj4OtiCIDRmTueAfx252t5LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMq6ha9d3cZbs1VFjcQvQlpYh49x69LKO2Q7bU2sMjgfYOsFP7x6kbRs9vY6KKeQD
         J6l372tFu53VbnpsIK2PcS0VU9jTBIGskioeyGicYfUjwILnxgOCiP6lnMeuPChVHN
         I7yv76ixLe8wVYQcfdelUmhEd1NVovlMdyuQM74E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3.18 34/47] sunrpc: use SVC_NET() in svcauth_gss_* functions
Date:   Fri, 11 Jan 2019 15:08:19 +0100
Message-Id: <20190111131000.489001194@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit b8be5674fa9a6f3677865ea93f7803c4212f3e10 upstream.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/auth_gss/svcauth_gss.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1102,7 +1102,7 @@ static int svcauth_gss_legacy_init(struc
 	struct kvec *resv = &rqstp->rq_res.head[0];
 	struct rsi *rsip, rsikey;
 	int ret;
-	struct sunrpc_net *sn = net_generic(rqstp->rq_xprt->xpt_net, sunrpc_net_id);
+	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
 	memset(&rsikey, 0, sizeof(rsikey));
 	ret = gss_read_verf(gc, argv, authp,
@@ -1213,7 +1213,7 @@ static int svcauth_gss_proxy_init(struct
 	uint64_t handle;
 	int status;
 	int ret;
-	struct net *net = rqstp->rq_xprt->xpt_net;
+	struct net *net = SVC_NET(rqstp);
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 
 	memset(&ud, 0, sizeof(ud));
@@ -1403,7 +1403,7 @@ svcauth_gss_accept(struct svc_rqst *rqst
 	__be32		*rpcstart;
 	__be32		*reject_stat = resv->iov_base + resv->iov_len;
 	int		ret;
-	struct sunrpc_net *sn = net_generic(rqstp->rq_xprt->xpt_net, sunrpc_net_id);
+	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
 	dprintk("RPC:       svcauth_gss: argv->iov_len = %zd\n",
 			argv->iov_len);
@@ -1691,7 +1691,7 @@ svcauth_gss_release(struct svc_rqst *rqs
 	struct rpc_gss_wire_cred *gc = &gsd->clcred;
 	struct xdr_buf *resbuf = &rqstp->rq_res;
 	int stat = -EINVAL;
-	struct sunrpc_net *sn = net_generic(rqstp->rq_xprt->xpt_net, sunrpc_net_id);
+	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
 	if (gc->gc_proc != RPC_GSS_PROC_DATA)
 		goto out;


