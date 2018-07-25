Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5960DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749020882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wg8S0Hnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E749020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeGYMtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:49:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbeGYMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FjqzaFaHENN46/lFTxlHfuvJdRnJciZSv3TH49bql9M=; b=Wg8S0HnnwvqKyVxHA1Y1juNIZ
        u+sUr1oQE11pCKMLR5d+CweayjW+Rn4qz0PkbmkANAGd1wVgE7eJZEdj6DA3m1IlYY2b/UHrt9ac4
        BibdpOV/X08pFtclXEbSGnFtfZh5AEWx9h60/z1t1h0X2Sb+bR8cZST9e52RS4VCVZON0ctOH5Fta
        Erb3zTkIT3/JwdfPfKXNagvAPjVwahvdIubIPeRDAP30+pdd8NIt9hw5kLWE4RoERprv5OWAcsgfQ
        mxjCekD0Y4B1lovo15O4ki9umfeFWoQvV8tVihYekPIEUR5tFkr7NXoTMB7VIiDY7GM6XIP3788eP
        V9KjbCs8g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiI7L-0006o6-Ea; Wed, 25 Jul 2018 11:38:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: swiotlb cleanup (resend)
Date:   Wed, 25 Jul 2018 13:37:56 +0200
Message-Id: <20180725113802.18943-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

below are a few swiotlb patches.  Mostly just cleanups, but the removal
of the panic option is an actual change in (rarely used) functionality.

I'd be happy to pick them up through the dma-mapping tree if you are
fine with that.
