Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B4FC6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D5208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBPl6uyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01D5208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbeGHA0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 20:26:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754229AbeGHA0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 20:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7IOwGtI1FhqYySX737mpG6uZ9phM/oS1bk11x7DlmPY=; b=JBPl6uyLhIRpghuO0Cg8JLQ6MN
        tDQV0xtX7Knzqx/uRCqPdWvA4nlPs3PIa0l/DG/+aWJcXx5+F9j8grW3159gzuqeCFFq8NVyaTaZC
        GEzoNgRkytldVnY/jOCCroOWgsJ/6T+li3YgCn8qVGFd7wmIwXaCdIIPJuUP4dmdocYX/8oM84aUV
        QlxP0/YIp5xmQbejFJRbB0DwuAE3edmK18NWPgeF78SS8/RGZwX9pMsFhYbWmSfMhkDaveOwCb/qH
        BY88M205+bccl+LUbjnrI8aijomJRy1Ub6bZ3sm9DMgZfsbr+NrxOjez4sDK3mfvwPtic6WFtIA5X
        QbmjTOmA==;
Received: from [65.158.186.241] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbxXB-0001dK-R7; Sun, 08 Jul 2018 00:26:37 +0000
Date:   Sat, 7 Jul 2018 17:26:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping revert for Linux 4.18
Message-ID: <20180708002626.GA2490@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c85639897cf3ea6a11c5cb6929fb0d9d7efea5:

  Merge tag 'acpi-4.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2018-07-05 09:52:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.18-3

for you to fetch changes up to 7ec916f82c48dcfc115eee2e3e0e6d400e310fc5:

  Revert "iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()" (2018-07-05 13:32:06 -0600)

----------------------------------------------------------------
Revert an incorrect dma-mapping commit for 4.18-rc

----------------------------------------------------------------
Christoph Hellwig (1):
      Revert "iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()"

 drivers/iommu/Kconfig       |  1 -
 drivers/iommu/intel-iommu.c | 62 +++++++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 17 deletions(-)
