Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDB3218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZCV4TMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfBLHZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:25:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBLHZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vptPyJpR2E7vj1zh9KXoS+6eLBw7ZWiSved19TJnXsI=; b=jZCV4TMPpjMv7tLVVEB6Y7bBev
        9PaQ3xew1jtGkwO7S4F+9PP0iGDndRir/DIDiLXCJ9bVBGjtMaaiY8aDPkTrZMJaaP0TjeGX/FXTq
        /3rWfny/pso5nRxqozQQXk/QuXqIUJZpxYwQ6pfZ0aWb0tVMg9zB5XTVh1vPJpexIpk26WV1IQAVR
        sXJOJPs8mXK4S6hgw/Tt2MGZFC/Tn5yDN1wcyacLBFqxLACtxEGT3c+WZVCwgpt0Y0/ysh1csB5CO
        BCkkpu2nKWOvg8jgQ0fVi64Chcn/U1t1Lvx4Cm/WwgkXmnoU+DjAreUsyCfcm/OmZADZeeYfljxS1
        2UPHZIWw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRj-0002OR-VH; Tue, 12 Feb 2019 07:25:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] mmc: remove the unused use_blk_mq field from struct mmc_host
Date:   Tue, 12 Feb 2019 08:25:16 +0100
Message-Id: <20190212072528.13167-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mmc/host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4d35ff36ceff..4eadf01b4a93 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -397,7 +397,6 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
-	unsigned int		use_blk_mq:1;	/* use blk-mq */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.20.1

