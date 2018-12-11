Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51BAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6720855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543838;
	bh=qrB7sH/8wa2jNcNkp89hYzNzq83PCFqptyuKUo35vi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=upbEsekHO/QJeKq+JZ3pkAZeV3HojIhyD1uJXk9Wz5ZYFb0Htqtz4ikNCv+l03t0O
	 1+G8gj1xvNY52W8dK30RgQTySCiya/0gFB7rK4pVJkwhrvhsBRM7XtFfMWJn9fW+pm
	 GVORUce1o8jgBWmEMtfzSXsxHc3bxNfxI3nMoLhQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB6720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbeLKP5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbeLKP5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF522086D;
        Tue, 11 Dec 2018 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543834;
        bh=qrB7sH/8wa2jNcNkp89hYzNzq83PCFqptyuKUo35vi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddfV2Xz1xbGMfXrpdTJ0ByUs5L60OkiONRbc0CmakMRb903HwL9plRboy9eFwSZXm
         Au2rZhqOnDnERCc5MWx7Q2IiEKv7mr0Vuz1YvxrKtd8N1II77JTh/DNB/tjrwbIVfq
         BV7/s2eQW7YCQeGd19cWJwcbpOqtkldn+JPrd/WY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 083/118] Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations"
Date:   Tue, 11 Dec 2018 16:41:42 +0100
Message-Id: <20181211151647.621862795@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Lucas Stach <l.stach@pengutronix.de>

commit c06abca69218ac42fa58d1ba7a7b0d9bab5f1b18 upstream.

This reverts commit c1199875d327, as this depends on another commit
that is going to be reverted.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1194,8 +1194,8 @@ static int sdma_alloc_bd(struct sdma_des
 {
 	int ret = 0;
 
-	desc->bd = dma_pool_alloc(desc->sdmac->bd_pool, GFP_NOWAIT,
-				  &desc->bd_phys);
+	desc->bd = dma_pool_alloc(desc->sdmac->bd_pool, GFP_ATOMIC,
+					&desc->bd_phys);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;


