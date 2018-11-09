Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F54C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFB020827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QSxKqr1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFB020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKISjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:39:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKISjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W6XkO00y6sMywbMzupqZThnE4fx9xf/MrzCU6PPJWow=; b=QSxKqr1QkB0N0P7PiZZ6d6Qn6
        Mjbiu3yp8E7dvPEt0akGt7JdbElHIt8EU2bQYROqqfVgAMN1GA+XwOz2tx2dCw3Laxbp2YdG9Bha9
        MomJdWyQ7a7zNGwQIwPAbn4l+WMvGJiEynmwbITyEY1DzdogGNGLNtRO+SZ3N0Z48BVCwbui4DVC4
        SqE8HMCKtenZ7fgQEfqBMjXUDMjSdj/vt67wQuagfnnAIfF5Nk9WShqyg0L7n8KMdtwBsjuBXIJUD
        TcMUkJKn9npPKNDk18uDzECPnlCVDNCkKyNjrlRizh0NSZDbODXngFWhU0b/A3HhQm0n58XBIcvRp
        MlKwZuxRw==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gL2eD-0003tw-VE; Fri, 09 Nov 2018 09:00:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: scatterlist arch cleanups
Date:   Fri,  9 Nov 2018 10:00:06 +0100
Message-Id: <20181109090008.24150-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leftovers, and switch the default on enabling SG chaining.
