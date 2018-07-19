Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9922E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUar4Dfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9922E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeGSNjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:39:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbeGSNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I0gWHMe/CcpRrDZJN18GNjj0gafa/XFni8ideEiKeqQ=; b=PUar4Dfz5ujcgSw6lE3YvttL1
        Cj7xvYBhPE+UBChBKbswXvEHB/4jrikOWlD3QJ/TOvhqopXgMlpnrohdDVBUbK5MD7NdDd7lqQzOe
        iSxiHGWa2TMQ39sIcIouYn9SUJty/REiWppv/3ovMxYiTzEP61c98AVhliRG0BETl+Zt357buxlYj
        wDMoZk6P2rqK2wEB9Qw6df4j+46lvW8VYt5tFusOTIGeJgr2fBIJ1wPqHpnbrf3w6G47O+IhkNSGB
        ivhMBlj743MhKBQ3XBHaodHPvaCgPKdwT6hjAJYNSfyIchp6EEM7Z68eMTbhLDR0eukAOo4vYRt38
        B5OrFkl/A==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8Tz-0006Qr-9e; Thu, 19 Jul 2018 12:56:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: use the generic dma-noncoherent code for hexagon
Date:   Thu, 19 Jul 2018 05:56:32 -0700
Message-Id: <20180719125635.824-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

can you review these patches to switch hexagon to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
