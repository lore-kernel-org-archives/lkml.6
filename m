Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40176C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F7020833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KcQN2Qf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F7020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeKCRwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 13:52:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeKCRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 13:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3P5MWp17wLDBbsl2bkw3dqaM4NfCx0eVWxyho1YUC6A=; b=KcQN2Qf1ojQE8bY8YLsi5QBUW6
        tw2zlcycTcmBS7nKTuKqO/qMte7FuUaWeyHtZ5um7SgrdfiXdSVS6+n6R4OST3+d4GIgZSf6UWDd9
        D4lpgVW0RpQ0iYyIAlDxl7s6+7yHFd0UVj9xpRHXbTK38o+oH7lWoHwlcMh96qDv2QeGCgf4Yqv4z
        SBG53uRXNHiZZeBby2NUWfBCtzUQLsufhfHjJi3PsCW08AF+f3Wel69z0OjIosp5qv+87fIkdeqvi
        iTLNaPRo5nT1bNq9aDBZPDaWTzZEj5Z3ZxJ6VOHpcEGfxwNiiCwp+3yDGCNu/wDWM22ehQd8rLd3o
        8jnJFIEQ==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIrVU-0000Kw-78; Sat, 03 Nov 2018 08:42:12 +0000
Date:   Sat, 3 Nov 2018 09:42:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fix for 4.20
Message-ID: <20181103084210.GA1429@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8adcc59974b8a65b7eac7d503364837c297139bc:

  Merge branch 'work.misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2018-11-01 20:19:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-2

for you to fetch changes up to f62717551b2b7d72fc2a3975539117d350bad84d:

  arm64: fix warnings without CONFIG_IOMMU_DMA (2018-11-02 19:27:22 +0100)

----------------------------------------------------------------
Avoid compile warnings on non-default arm64 configs

----------------------------------------------------------------
Christoph Hellwig (1):
      arm64: fix warnings without CONFIG_IOMMU_DMA

 arch/arm64/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)
