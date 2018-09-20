Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04275ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B233821523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uEzhTADh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B233821523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeITNJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeITNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XFBDn+jbXmjvPqCjKotjbG5NI2d3jNBVYSg9CIHwwYU=; b=uEzhTADhyW9swnfZ0DmyNG3wG
        CisT5tqTFtbAYHX1m4lI9kZdEkKnCOtCKzF2FIjhO6JzWt33qebOPpBs8DRt544Ld5gkULAvBf1om
        9DcCEgtezYdYGBAetBRJDG0xc0OBLu6i1g1uLrLBmBTpIXya4FYrEADMIOwGQh6DsajoTSLjNwkpW
        GNBIubemQyiNTWep/PIfu226PAfnT3oH6JuE891tiU/aAah2bh1P6HAqkQfCXhoh5KeCqjEs+29he
        koM8s/JlV3Grfpgv5xHfxWyTYscXJZTZPYi8XPkBT0Svkxc2p6l2h7Dc0f7o1ZYQPclDjx8imVOof
        WXyK+MD1g==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tMe-0002a0-3I; Thu, 20 Sep 2018 07:27:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: misc ia64 cleanups (resend)
Date:   Thu, 20 Sep 2018 09:26:51 +0200
Message-Id: <20180920072700.22396-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple random cleanups I stumbled upon when doing dma related work.
