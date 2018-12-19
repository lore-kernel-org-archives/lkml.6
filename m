Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66736C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213FB20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJVmfxAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeLSOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:24:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeLSOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=coGmbTLk422neUd7eMcjNwbLbdlqqt6qKLsKfsfuGCg=; b=UJVmfxAWPEoaG9ojeIx96bJaGA
        mFf9KTktohJWDkwOVl65SfWI+IXJaBCHilcWEyxxP/bcmXEQtKk8FbIBBZmtcCseMsp3ZDDsBVuvh
        Rj0100VvZRmvs2e5q1EF+WgMCb2n5Qef/GhZ85mUv0f8DSAn3Ts+M0Rk6ios5iikqoq/3nb43bRNk
        +B42yuulvCDEfZ2Uuqx7JCOjRhXIUdRA5l+yNw7i8ytxnE2YpFwDTTPP32iXOKZpabu/aj/zHCzsk
        LORjDP8xn4lsxZGaonHAF6/+V85Mq5uNkTw2UjpKD2DPbqFQZxpjMYsms4RqSR3Q1vEIr009Aix+m
        vyG1QDsQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZclo-0006jd-Rl; Wed, 19 Dec 2018 14:24:21 +0000
Date:   Wed, 19 Dec 2018 15:24:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for 4.20
Message-ID: <20181219142419.GA1112@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6531e115b7ab84f563fcd7f0d2d05ccf971aaaf9:

  Merge branch 'akpm' (patches from Andrew) (2018-12-14 15:35:30 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-4

for you to fetch changes up to c92a54cfa0257e8ffd66b2a17d49e9c0bd4b769f:

  dma-direct: do not include SME mask in the DMA supported check (2018-12-17 18:02:11 +0100)

----------------------------------------------------------------
dma-mapping fix for 4.21

Fix a regression in dma-direct that didn't take account the magic AMD
memory encryption mask in the DMA address.

----------------------------------------------------------------
Lendacky, Thomas (1):
      dma-direct: do not include SME mask in the DMA supported check

 kernel/dma/direct.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
