Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2D0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F3021873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qHFDx39M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfA2SNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:13:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfA2SNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iGY/6/uIkSQ/SVnkOTP7iJDc4IYtHZf3o7I5f03/Vb0=; b=qHFDx39McKnwRZB2F3+5Lw4q+K
        M9o+8wqN8BM2nbq9dUZIcgvUiOoDUFQg+92sXiE6ycpZBa0/meqYk61AQyCjm5MtAEJe7KUWqMRoF
        i/8pnblYBpMQQAKyJB1ACJiX/N99Czwm4WYNZkQ8ECAvwD8vX1lVQNee3mh7lVAl6uvpwWwFJN/um
        l1U8D6c9j7/4qU4AtJ24PE449XqLRMtDBtgSrarToMoRs451SNkUOw/HUta8ROddleiIOYjgJzR2u
        W2C/tdA274SvweREak03vfWQ9F2THhvUYryQcpb7rWYOwH/3RDW8aG2CW14gJ5ve640ayMQon/ffP
        20OIObOw==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goXt2-000836-IG; Tue, 29 Jan 2019 18:13:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] parisc: properly type the return value of parisc_walk_tree
Date:   Tue, 29 Jan 2019 19:13:07 +0100
Message-Id: <20190129181310.5557-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129181310.5557-1-hch@lst.de>
References: <20190129181310.5557-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parisc/iommu.h b/drivers/parisc/iommu.h
index d6fd3ab899ac..240059cd8185 100644
--- a/drivers/parisc/iommu.h
+++ b/drivers/parisc/iommu.h
@@ -6,7 +6,7 @@
 struct parisc_device;
 struct ioc;
 
-static inline void *parisc_walk_tree(struct device *dev)
+static inline struct pci_hba_data *parisc_walk_tree(struct device *dev)
 {
 	struct device *otherdev;
 
-- 
2.20.1

