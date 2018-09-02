Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C15C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DC420856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nqVG+d88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DC420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeIBV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:29:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xCNGHzqd4IwDUYNjPpZoJQ9wSSBT9WlpHi778JlDvAQ=; b=nqVG+d88w2PQRTdF81QGh4bt+U
        +18JGvZtwMWzu9DDcgt6HR9YSKva5kQf4SywbAZ3KCawimAstUuaDNPRO7XQeSXNEWhLMVaa7eq9+
        tzPLrAmF0wokptkch00bvyweTidhOp8uckBawvbgGKEsdn9sPpGU85bPFmENH0Gp1mWgJCuPl1dFe
        cU0zaSh2K/nFEvB6BJhC7yJPtz935zddUApzVyz5Dg7tbMf24/cgKXfv6d7k92KeL7owXtYvVd0dY
        e9Z3M2SF8Xy2yux6VmyocW9vNX2oTC2NK2tv/w+JxP7iOw9nL1a2ty7ddS/Qw/OblAkq9UTcp1znj
        KEQmb8SQ==;
Received: from 089144213215.atnat0022.highway.a1.net ([89.144.213.215] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwVwA-0008SZ-Ml; Sun, 02 Sep 2018 17:13:23 +0000
Date:   Sun, 2 Sep 2018 19:13:17 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma mapping fixes for 4.19-rc2
Message-ID: <20180902171317.GA31966@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.19-2

for you to fetch changes up to 8c89ef7b6b64ba093239305f77a485905d03f7bf:

  of/platform: initialise AMBA default DMA masks (2018-09-02 10:04:31 +0200)

----------------------------------------------------------------
dma-mapping fixes for 4.19-rc2

A few fixes for the fallout of being a little more pedantic about
dma masks.

----------------------------------------------------------------
Christoph Hellwig (2):
      kernel/dma/direct: take DMA offset into account in dma_direct_supported
      sparc: set a default 32-bit dma mask for OF devices

Linus Walleij (1):
      of/platform: initialise AMBA default DMA masks

 arch/sparc/kernel/of_device_32.c | 4 ++++
 arch/sparc/kernel/of_device_64.c | 3 +++
 drivers/of/platform.c            | 4 ++++
 kernel/dma/direct.c              | 4 ++--
 4 files changed, 13 insertions(+), 2 deletions(-)
