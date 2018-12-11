Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E2FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B526720851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545045;
	bh=RWtfUAkUTRnWDiF0gi0MfuJHadAjjlYFtP8A7nb2Qho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CaSCZmJfj+ZXUJivbz+MgtvKlyAQIakgZJcGsAKsGcmBnymYLUq7kZ9kqGoAOesXe
	 pMj+d06XqhloCT0QVEA+ntZyHZC50UJxdF94kXlkVLPqMTyguLJetYXOIoTPf3IpYV
	 hXBXiTERlqy1Ss7/y0h1ggBPCt7vl8+81IBGJ8nk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B526720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbeLKQRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbeLKPrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5025208E7;
        Tue, 11 Dec 2018 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543235;
        bh=RWtfUAkUTRnWDiF0gi0MfuJHadAjjlYFtP8A7nb2Qho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsDpLOJU5jAUwBzDhOZjG0xVEm6x5u2DKJf+1asZZ9ENOz2GHaZ8tPHvf4m4ILaPC
         sfR3ftaJyyw6alWRRpTaeCs2GmV3OMKY6GDhQJUAYn/IS9kauHHA8i094wXZANxNTt
         y7zBySBUDN+0peIWM7jYEyPSHn03HltxjnaloBE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 65/91] net/mlx4_core: Fix uninitialized variable compilation warning
Date:   Tue, 11 Dec 2018 16:41:24 +0100
Message-Id: <20181211151611.462739330@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3ea7e7ea53c9f6ee41cb69a29c375fe9dd9a56a7 ]

Initialize the uid variable to zero to avoid the compilation warning.

Fixes: 7a89399ffad7 ("net/mlx4: Add mlx4_bitmap zone allocator")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index 0c51c69f802f..a4912b11e54f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -339,7 +339,7 @@ void mlx4_zone_allocator_destroy(struct mlx4_zone_allocator *zone_alloc)
 static u32 __mlx4_alloc_from_zone(struct mlx4_zone_entry *zone, int count,
 				  int align, u32 skip_mask, u32 *puid)
 {
-	u32 uid;
+	u32 uid = 0;
 	u32 res;
 	struct mlx4_zone_allocator *zone_alloc = zone->allocator;
 	struct mlx4_zone_entry *curr_node;
-- 
2.19.1



