Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41576C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3102073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRAxEvNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3102073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeI2HVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:21:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2HVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=weWlQfXWPB8WxZObWBmotoOgkOGm7aGYyZOmz0b/CIs=; b=pRAxEvNi9JocQHWV2FbCsDu/+d
        dpiJ6lXUZJimwnbtRr7yHaYIKrHbuGYT+GIkdVPzwWM7avvrQqFt1G0E2QU12GBAFZGzgpIRENSU0
        RsE7aKkS9idL0/UTyvnkA1PAAwoOWucZNo3Gj5BQqvobMUGNnzyas+BTsyhL1vzo9Nel+gk/+sT+w
        2NGsUPMKleWFqnG180qK4ypR2NCUuUYeTeeV9rExGgV69SbNGzucX8p2X+KUAKB8KCWptluHMyL/x
        bQbMA+5SMMwKkafNsBhu8UuKCNhfZQkO9hmVvrHO27B9iQX227pQPhvj2GKLXFOxd28xAMw5h6ULl
        8aaqZ0bQ==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g63Wz-0003BF-F3; Sat, 29 Sep 2018 00:54:50 +0000
Date:   Fri, 28 Sep 2018 17:54:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma mapping fix for 4.19-rc6
Message-ID: <20180929005447.GA3397@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfb0e9b490bc15f243009359745a9d8a94089dc4:

  Merge tag 'usb-4.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2018-09-25 17:54:55 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.19-3

for you to fetch changes up to 974c24c5bed75b53e229a6f68a0533b6d5f48feb:

  dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration (2018-09-25 15:11:58 -0700)

----------------------------------------------------------------
fix a missing Kconfig symbol for commits introduced in 4.19-rc

----------------------------------------------------------------
Christoph Hellwig (1):
      dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration

 kernel/dma/Kconfig | 3 +++
 1 file changed, 3 insertions(+)
