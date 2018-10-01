Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE8DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE70A2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FP3MOwxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE70A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeJBCtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:49:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBCtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Om1hn+X4M3M0PajiWGYxyCvkQ/Ay4A5Jo74Py42C4mk=; b=FP3MOwxzRtw3ner3hnlKum3C2
        /O27mO0Dwud7yX9BZ7sBF7Pi2Z8hugJ/FZ7V+LdA0+BKTyypxoBDwYRcb49VR3MqEViGam3xLXNXk
        yyVK2oHq+8r6/GmGzGTeRwz/Gnri+avMGtLxA9pdz/ah526HrAwAwP7H7n0hmfG64JuktZh+rQaNp
        /bb0/sOYKaFctw/K6R+Iw92wzoMSuH6DxobnWEwqRhtWEXw/mlNPLLMmUER3PCuutZkGNvgEhVxT6
        6RkUQDPs8Yi/9UOJIr5nYDO1fuivSyR3exWmtC/r+C1DyEpTWm+MMfZWTKTkTCpGbTC7Is9B/wk31
        sZP3YBBRg==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g74WI-0006Fb-2H; Mon, 01 Oct 2018 20:10:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: document dma-direct zone selection
Date:   Mon,  1 Oct 2018 13:10:15 -0700
Message-Id: <20181001201016.32639-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patch documents the dma-direct zone selection, as it doesn't
seem quite obvuious enough.
