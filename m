Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7251D21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762438;
	bh=ZV/rWwuoEeju6CvS8gJIdL1K2J52gV2fkC/Y1yygzrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fTcIqzYOHE3aPVF7xj2TDZJnz4nqYxTuK3ox11eepjYKJ4Mh9AP5AVLjhw09AkfWU
	 fnncJRomavF/JbnKmw6LJ+SGCEfKHUsnc5duiYRV/Jjh5axvwN12LxAqiH8W8yvn/X
	 rjhZPtUveTT1y0j7WQpP7px9KKiKOC4tpNYQmqmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfA2LrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbfA2LrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A69022083B;
        Tue, 29 Jan 2019 11:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762433;
        bh=ZV/rWwuoEeju6CvS8gJIdL1K2J52gV2fkC/Y1yygzrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCd95lgjoF7TwO0gZf/nb8DljeXnNFjOg/1cI+e6UeTMkpaD67VyMzmSX5eUmtV72
         39MjMRA+/kFmeqf/Wp5pKgTmWZ8l91A/tsMWsUtu/7EdbHST1iWSet3iifdpCy4wzI
         15RCGPDDuUPJ4thoQz3/2/fGHkVsD7vLcNITG14k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Raju Rangoju <rajur@chelsio.com>
Subject: [PATCH 4.19 099/103] nvmet-rdma: Add unlikely for response allocated check
Date:   Tue, 29 Jan 2019 12:36:16 +0100
Message-Id: <20190129113207.436282167@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -196,7 +196,7 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp
 {
 	unsigned long flags;
 
-	if (rsp->allocated) {
+	if (unlikely(rsp->allocated)) {
 		kfree(rsp);
 		return;
 	}


