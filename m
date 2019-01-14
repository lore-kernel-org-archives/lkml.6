Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uUPTHjvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfANLYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:24:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfANLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZnYaNa35JC9qpQE/YlWcltLKGzLnKT/DBn293o4oqlo=; b=uUPTHjvPaX1FVVpqcI6T+7J1b1
        bJYoB3iW9fKqdGgkIlzpzyx0ZeO6z5Pq2kRSaDEHC3QlV2mi7KjVJCKdbqEnz+YvRRuIgXnnDYNLK
        p+7ATqzCWOkabWnOs9kIdxbcrvdLopxn1tFsiAQxZSWKkiY5xVX/+6SYKN5y57klLdgeQMvWehBc5
        zxyDf0ebE4bb3yvJd87CjxwcknqmlRSYSTxAGLRPIgQOTmnENYVhu6yCO2/0SiQD0G5EV7Xoq5dv/
        9+Z1rMzCNpKVsYn5SvPiPWcb2GNOn5bUzuVczIgzPstME7s3fezt1fcw3Tu4FwdQpVXBxpSZcbfHr
        cwUZ2lPA==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj0Li-0006pU-Af; Mon, 14 Jan 2019 11:24:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] parisc: properly type the return value of parisc_walk_tree
Date:   Mon, 14 Jan 2019 12:23:50 +0100
Message-Id: <20190114112353.30616-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114112353.30616-1-hch@lst.de>
References: <20190114112353.30616-1-hch@lst.de>
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
index 94d5eae98bf6..010539fc4643 100644
--- a/drivers/parisc/iommu.h
+++ b/drivers/parisc/iommu.h
@@ -4,7 +4,7 @@
 struct parisc_device;
 struct ioc;
 
-static inline void *parisc_walk_tree(struct device *dev)
+static inline struct pci_hba_data *parisc_walk_tree(struct device *dev)
 {
 	struct device *otherdev;
 
-- 
2.20.1

