Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F9C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20D220873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675485;
	bh=JQkWJvSjDhcS980OrOd4JY5ud14P3Z+MVkpLjfU7wNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=meo6uZAygb9uB5uiFfiBcj8RrwNKDoDMIuoiCTR165WNKD8pM0wlj4TyUTAqYpaP1
	 HYvFLaT6m7QmO6Osqs68sm4/bwC6dtQtgC0xraLhFe4aAHlKmlnqoNgY7qbEnwPN9Y
	 uQwZ36EpIIptCqoyR3u6uW0FVz8KL+C5bs5pkqpA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20D220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeLMEbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbeLMEbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2D9A20672;
        Thu, 13 Dec 2018 04:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675479;
        bh=JQkWJvSjDhcS980OrOd4JY5ud14P3Z+MVkpLjfU7wNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdppiRqa/KDKGKwR0mnUNEw12BoKgxaohafqFLON7hxVyLTI3UNT6kzi0V9a5XhA+
         +3IiPFNw+BxoyhwHsESmFtIoEyZhEtH6WLUBL3h5FlYYsAK7ZMAFDVHmE191qGs/Kq
         BGnFwOVjmvppYWGgzTOQkNCxo6dr3rR2vqYG89kM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 16/41] ide: pmac: add of_node_put()
Date:   Wed, 12 Dec 2018 23:30:29 -0500
Message-Id: <20181213043054.75891-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit a51921c0db3fd26c4ed83dc0ec5d32988fa02aa5 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/pmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index c5b902b86b44..203ed4adc04a 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -920,6 +920,7 @@ static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *model = of_get_property(root, "model", NULL);
 
+	of_node_put(root);
 	/* Get cable type from device-tree. */
 	if (cable && !strncmp(cable, "80-", 3)) {
 		/* Some drives fail to detect 80c cable in PowerBook */
-- 
2.19.1

