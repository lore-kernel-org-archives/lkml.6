Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F222195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ltPHzl6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbeLVTDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:03:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbeLVTDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=doM986ls6USCfvIfs9T+X7hu+Y3QnnYxv8ddQr0tgSs=; b=ltPHzl6hav5HUduZwxcdDmcdh
        lAnnOMIhh6ENN0VUq2AkOQnaPD6pg7Marngrf0ubhjGuGDl2+coEJLIcslHsjzmwGv+l2FuRVQULl
        SPIb+gtqXGut52E9Dm/ZJI1jUt32SYJm/xqKO9h19j4TZMiq8oy9bh3/d89sesZDc4Xcp/nYpo5hQ
        w4TV4l3ONaBJM83pwK8NN92wUaZg1OrI8seCNuYJqmZ/kU/KoXddXzsdl48WRyktt7sDyHR0g7QlL
        TXbVF0JM9al5wM1DBRiTl+Ta0qXm7FiCqbBxbr3pqEfZAJi2NycZo9laQ0LkcuCaetkbrhnzoO/Wv
        qmfACgrwQ==;
Received: from p4ff2ed53.dip0.t-ipconnect.de ([79.242.237.83] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gacX0-00033G-CI; Sat, 22 Dec 2018 08:21:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: one liner DMA mapping fix for 4.20
Date:   Sat, 22 Dec 2018 09:21:07 +0100
Message-Id: <20181222082108.24496-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm sending this directly to you given how late we are.  This is a trivial
one liner fixing a regression I introduces in this merge merge, and which
has only been noticed by code inspection, but which is pretty obvious when
looking at the original commit.  It would be great if it could make 4.20.
