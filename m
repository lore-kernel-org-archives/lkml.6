Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6AFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB522086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762812;
	bh=TowMoidWMyZQpwgCS4GU3huPmSKg3jC8uG6uS/KplOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TJSqtNtz/DCvFrgubmCvHVdOH4iNli6PEOHlbU8SCFosNErAJp7D0+rmUjQ5gN69R
	 xFW9JeQjle6kLhh4aEJSkIW6/CcJK8OGGxY6pHQJFU0CNcSRLYKJBJ9gQ8G0Grt9k3
	 bjH08YcURGxLwTpKoYxC0dWsOBSpAXFzK3dPBqjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfA2Lxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731754AbfA2LwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:52:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D97032083B;
        Tue, 29 Jan 2019 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762735;
        bh=TowMoidWMyZQpwgCS4GU3huPmSKg3jC8uG6uS/KplOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7w4dckmOY22iiTgl93hB8PH+Hf/aIilvDykpJHSecpZdm3p+XS+AuS1chQp6oM6e
         mxHvCxtXDND3H4pyps9ggdBZ/H20ZwTjJviwT/5uvlVYOuJdsYUOeocpPXWU0zmjlN
         YO0kRlMviL58AfFIwsojgMINV0FcRPgvO7IDBRbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Raju Rangoju <rajur@chelsio.com>
Subject: [PATCH 4.9 40/44] nvmet-rdma: Add unlikely for response allocated check
Date:   Tue, 29 Jan 2019 12:36:35 +0100
Message-Id: <20190129113143.202688532@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


