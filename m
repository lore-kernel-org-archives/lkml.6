Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C35C20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JK+Qa3Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C35C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeLDQQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:16:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VuXgj2q6T4O9DRNiIHKF3iFHNwohjTrYKeE3vl3CmiI=; b=JK+Qa3MtdBlJeXA5cgLd47Rbq
        k7OwJZeG6A+fy1TcI5SIc+yhEMSNV+TyhXNlhjEnKmU4my9xDbJnZPqjgU08Kl/ZUyIm6+O1QljOu
        IlmHNPcksf8sJ0Y6RU3GxpDPWoVZ18Y8YGvbpM1EfqDQ/eaAY0yVs7IwptgUvO/p0hEz84qgtgz/5
        8zS0NSCPgahj5MnlHMT8ULxgv3klF6oGHLfoqPjR09owpnFjR4TFclo9VGydpOqYzJdEI2VXBmagB
        9U97DsM25x/NFPRBABhhrGqoPT0MNYZJ+A3fBgMl9IWOyp5SO7w7YclRpMC1SolBFxPPCkQURMwz9
        bke3pfpDw==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUDNN-0002EU-Eo; Tue, 04 Dec 2018 16:16:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: merge swiotlb support into dma_direct_ops
Date:   Tue,  4 Dec 2018 08:16:40 -0800
Message-Id: <20181204161645.8038-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad and others,

can you review this series?  It merges the swiotlb support into the
DMA direct ops so that we don't have to duplicate the dma mapping logic
in multiple places.

Note that this is based on the dma_mapping_error series for which I'd
still like to collect a few more reviews, so pulling the git tree might
be easiest for testing.

The git tree is available here:

    git://git.infradead.org/users/hch/misc.git swiotlb-merge

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-merge
