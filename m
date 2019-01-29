Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44486C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169C220857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bv3TAi+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfA2SN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:13:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfA2SN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yBOfS/1RGs0Iv7Q/HqrXI7lqeT5eZT0y7JFIpYqjL+g=; b=Bv3TAi+7OVUu9LN8s3D/LcQByB
        KIuCi9YOG4N0UIotJ/gr7TttW5w4YKED3IuYnAR5XSGiN0AoCn5qpK8vGjT3El4JOQhs1e7MU+x2M
        dNYcUutQoaU7DZdcglUz42ElUxGukSLtSCRzZ7aG0KVqGFjT2sIwr7zZc32TbjFPdrIc4Fz3wOfri
        ERgk0JVf/FTz5HlVwEhljRo9MhDKkLBFN/fQfDbGNbV/i3GiBKtJnpstKsAJrPnN+QtE6kDhDaYfl
        AoJFPLHiycBkrZahDFhSKg1QuQ6/anq41MOZkO8V8Fmw+iGduCZt+8frEkCS4TJVPHPeefrwCTxmH
        LzzoAUhA==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goXsz-00082u-MN; Tue, 29 Jan 2019 18:13:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] parisc: properly type the iommu field in struct pci_hba_data
Date:   Tue, 29 Jan 2019 19:13:06 +0100
Message-Id: <20190129181310.5557-5-hch@lst.de>
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
 arch/parisc/include/asm/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 3328fd17c19d..00f763688401 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -56,7 +56,7 @@ struct pci_hba_data {
 	#define DINO_MAX_LMMIO_RESOURCES	3
 
 	unsigned long   lmmio_space_offset;  /* CPU view - PCI view */
-	void *          iommu;          /* IOMMU this device is under */
+	struct ioc	*iommu;		/* IOMMU this device is under */
 	/* REVISIT - spinlock to protect resources? */
 
 	#define HBA_NAME_SIZE 16
-- 
2.20.1

