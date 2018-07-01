Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C78C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D742532F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLI5t7e0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D742532F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeGAGLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 02:11:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeGAGLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 02:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g8edyzh8ue/QMpkqn2FyjaAi8m37ftCnyXbEoVfK6jk=; b=OLI5t7e0SLrqGtTtCuOf/hC39v
        dRedg0MFjh/EOsEfUuXWsUUGDPTIkOMVYnhQ1yl2s9K8XktW6D7Dy2ijNyjHd0STjtvy06DwP336L
        K0mZpKDWCLTSsYvleyEO4f6Pb3gcgrRrC46hhCPUVOUCoOw6PjyxGO0M4HnQRLV9PLxJr02XM8I5z
        +N/Tl3ERj90xjo8C2OThZO7hucJ+RJCxDxnhtovBPxnuHWTTYgIz3qo5k0ZZ88y9DjDb2QFMuvkEV
        SS5x1v37dEJ17oPn5vWI+J0HUHTxzx+plSTojSoxO0C3fTSogygsyT29VIJHGicPF0I7wFh75iylh
        aN/AUC+g==;
Received: from [88.128.82.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZVaQ-0003vU-Fr; Sun, 01 Jul 2018 06:11:50 +0000
Date:   Sun, 1 Jul 2018 08:11:46 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [GIT PULL] dma-mapping fix for Linux 4.18
Message-ID: <20180701061146.GA16461@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f57494321cbf5b1e7769b6135407d2995a369e28:

  Merge tag 'xfs-4.18-fixes-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2018-06-27 12:21:06 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.18-2

for you to fetch changes up to 210d0797c97d0e8f3b1a932a0dc143f4c57008a3:

  swiotlb: export swiotlb_dma_ops (2018-06-28 14:00:40 +0200)

----------------------------------------------------------------
Add a missing export required by riscv and unicore

----------------------------------------------------------------
Christoph Hellwig (1):
      swiotlb: export swiotlb_dma_ops

 kernel/dma/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)
