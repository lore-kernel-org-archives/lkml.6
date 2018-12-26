Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D1C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DEF21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="SFCw2GqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeLZDYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:24:50 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49084 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLZDYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:24:44 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 678A9BEB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TDY_DxIoibKG for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:24:43 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3DA02A2F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:24:43 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id x82so18641882ita.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2q+H2l6fFp4ZdxuUnlhqNB0h89Pka71vAtMO+QvAYpI=;
        b=SFCw2GqMwOZ97jDLlbSiCN17W5d3V0C9QQ41QLWImYgGk3BNtiyM+S3bnI+G7j+pKO
         V4PPMwwgLXfpr4rpBnZwmzfS2bKaZTY+o3/JalwPPZ3sG9I3y8mpJFo2bFb2rnxYFL7N
         ZZLT5MbX+XJAQoq+PZnfz4a5R5HRydg0PE5E4pPBD1zsmBK7XcStE4aa51eCQwTUxPfD
         fEK7wKd286RnJJaqxdE5NOnAbzomXjZg7B7B6FLo/zvUElh3nPiiFmP6WpYfaXW1dBxE
         tgNaMGYRsxThzrpBQrSQc5aFXJphe0JVoaOoKinvB6qR33RvRvd+0LbFaEslSYbEZdhC
         8lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2q+H2l6fFp4ZdxuUnlhqNB0h89Pka71vAtMO+QvAYpI=;
        b=GG/cWQq0EHCbjFPNZfoff1fCcGhEOw0/xEPV2P1qCZ+L9LX2nqFMfVinjc/bLnd2ec
         c+zbMUEpU/cdjx4Q6lEA1Q4kiWJT/6kbMb0nhmDxqPfMdEr1G98TVa/x0PhBSQfHBA8P
         zSRwMI0HWmsEhf5M/v4Oo7V7n0d2s6S/iB7ocHUyRI+pb+T2hN9cCbCPriYsarmTajsv
         fHvK0OHvIKhyW9qVtHM/Of7p3JynbFaV4uSB/EsmVJRhuMKYEW9B9YZgTMG8m6SjOviK
         pdmsgVtBvGnRpdGfGao6bjVXkWpXzsgf2zq92l+RpcLtni2PIryXhMv8PmL9XCB8YHrQ
         FY6g==
X-Gm-Message-State: AJcUukeBeEKCK6ouc8Fu9dGLqwBcC9bj+7F5kfadRbparu9byoUV1Uqk
        DkmTz/qUlLTmXFAnXNFyO6YfnoYOMM9CCwuceoMgphDg3Oq/snrGQjZBJB7cSr0DWD4YC1JiZ98
        yqesBlbjFsnsS48vHZJs6lkUta/+g
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr2966222itl.146.1545794682539;
        Tue, 25 Dec 2018 19:24:42 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4HE61t8ucQ9IGt4wtCx/hrX9MFbRt8n8xTIFiIr41NC489xbtZjPhM7MPDvqXduhaT+j2Qew==
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr2966208itl.146.1545794682325;
        Tue, 25 Dec 2018 19:24:42 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id c25sm15500481ioa.86.2018.12.25.19.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:24:41 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sunrpc: remove redundant code
Date:   Tue, 25 Dec 2018 21:24:13 -0600
Message-Id: <20181226032415.73064-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no bytes to decode, just use "xdr->p" instead of calling
xdr_inline_decode to get it. The fix cleans up the code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 9f53e0240035..2ef86be49bd8 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1123,7 +1123,6 @@ rpcrdma_decode_msg(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep,
 {
 	struct xdr_stream *xdr = &rep->rr_stream;
 	u32 writelist, replychunk, rpclen;
-	char *base;
 
 	/* Decode the chunk lists */
 	if (decode_read_list(xdr))
@@ -1138,10 +1137,9 @@ rpcrdma_decode_msg(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep,
 		return -EIO;
 
 	/* Build the RPC reply's Payload stream in rqst->rq_rcv_buf */
-	base = (char *)xdr_inline_decode(xdr, 0);
 	rpclen = xdr_stream_remaining(xdr);
 	r_xprt->rx_stats.fixup_copy_count +=
-		rpcrdma_inline_fixup(rqst, base, rpclen, writelist & 3);
+		rpcrdma_inline_fixup(rqst, xdr->p, rpclen, writelist & 3);
 
 	r_xprt->rx_stats.total_rdma_reply += writelist;
 	return rpclen + xdr_align_size(writelist);
-- 
2.17.2 (Apple Git-113)

