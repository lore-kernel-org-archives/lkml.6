Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4172C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8453120989
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uO6JlGc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA0J13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 04:27:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfA0J12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 04:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GqvDb2zbfcXEAxxE8/aqVjnQQzmA/UI99/+TL74bWFQ=; b=uO6JlGc7peTJoEu3at8DPdayM6
        jBaAUMRbrPeA5JAPIxKEtmNoLAMX9jTnjQYpMjiyj0v1qFXPmAqc/xlRfWm6DkAQiKSKxVbg05DCb
        QTqADXsFCZZtpLGaSA289mxVw/qb1xozNt4UB2X/orb/twWXZ5ykMDdg9WH8SNCfAdmQ46vNsqdPt
        TRdImjCLfmFJ1jNeuZfeKFv72pBA8IBBUH9bMbTX2chrU+zuns9Jd43xky35x5otqAkVIMukm6kOF
        s1lN3cEjFgwm4tbupNQFX5wR2LLN7AGuKU+dyPngqbhBQfrhqu4p/QlbnmGOhdQAsg4RZJqjZ8+uu
        rmWcZDPw==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gngiq-0004UN-I0; Sun, 27 Jan 2019 09:27:24 +0000
Date:   Sun, 27 Jan 2019 10:27:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Julien Grall <julien.grall@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fix for 5.0-rc
Message-ID: <20190127092721.GA22044@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the fix below, which fixed the xen swiotlb cache flusing
on arm64.

The following changes since commit 333478a7eb21245880c89aad166ad08478cc577d:

  Merge branch 'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux (2019-01-23 16:23:41 +1300)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.0-2

for you to fetch changes up to 60d8cd572f655aac6107a2330dced004ad1fe3d7:

  arm64/xen: fix xen-swiotlb cache flushing (2019-01-23 22:14:56 +0100)

----------------------------------------------------------------
Fix a xen-swiotlb regression on arm64

----------------------------------------------------------------
Christoph Hellwig (1):
      arm64/xen: fix xen-swiotlb cache flushing

 arch/arm/include/asm/xen/page-coherent.h   | 94 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/device.h            |  3 -
 arch/arm64/include/asm/xen/page-coherent.h | 76 +++++++++++++++++++++++
 arch/arm64/mm/dma-mapping.c                |  4 +-
 drivers/xen/swiotlb-xen.c                  |  4 +-
 include/xen/arm/page-coherent.h            | 97 +-----------------------------
 6 files changed, 176 insertions(+), 102 deletions(-)
