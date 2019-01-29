Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E52C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06192086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762594;
	bh=WKnRnkehAdNPJlvBepKPv6p3q9w3bU4jsPujCSTLQlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7nI3F5cfNQuVpIfS9kG8TcrxVfk5M7HctwihLdnK08pe4b4cHizvWtqHyLlY1a3r
	 /iYL20KA/4hsvuiwZSjDQpuQsRfC2OCT40rc7go2FBmmzn/3Z3gkVocmYwPwuZhuU7
	 Q7rq2Pjbe5Irz8rRHOCnODAdni1xqRmeCqaOu41A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfA2Ltx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbfA2Ltp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2FE2083B;
        Tue, 29 Jan 2019 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762584;
        bh=WKnRnkehAdNPJlvBepKPv6p3q9w3bU4jsPujCSTLQlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NA4WG4VsYafrcJzhSXzvvpjsRxrZdKuIs3WE692/wDX+ssu0VTeuSaNgHUYi9XSU8
         u+2MGezjs9rFhfEl7qYHHQ+fpfVDQYYhyTG730QMQx6af9i48WuwtiQr/lNVZpWQro
         jjEAzL+sP9tbSwj/tsN53K2eS83a11aelUsimm/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Raju Rangoju <rajur@chelsio.com>
Subject: [PATCH 4.14 56/68] nvmet-rdma: Add unlikely for response allocated check
Date:   Tue, 29 Jan 2019 12:36:18 +0100
Message-Id: <20190129113136.858798722@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Israel Rukshin <israelr@mellanox.com>

commit ad1f824948e4ed886529219cf7cd717d078c630d upstream.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Raju  Rangoju <rajur@chelsio.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/target/rdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -189,7 +189,7 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp
 {
 	unsigned long flags;
 
-	if (rsp->allocated) {
+	if (unlikely(rsp->allocated)) {
 		kfree(rsp);
 		return;
 	}


