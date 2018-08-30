Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3154520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D9xCIRrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3154520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH3WCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:02:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3WCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EBUFnwD8kacWjqjblNy+M7GLSXKKVzmhQiKQKuCF+vY=; b=D9xCIRrFS1M4mbTk1Vqw08S7W
        w3EB/z8ClBs33+ei4yAPQxL0Go0vh1vupHujsVSGjtkzQXKxvjQzZgI5McqJsxCulBX1pQz2macFP
        3TOEDDkHsV8gyvxIgF++W+S9UjYMaaFLzedqkzZ+8oad5lCUOffbCoNlvEEYrmCaFa2uczK/+ZcUj
        exlv9CVl9wXib9myb8hGUHx76gC/i1insSAo6IUG/LbNVzo60r6r36tXt0ImsjX83eyARgTChAnkF
        tah7sRxFp7eUfETjKW/s4pcI0LBSPJhFkVIo4Mqp3fvVXNeZRkieMdwpSRuRGfp2rIaLGgvBlq1nT
        BXvbRn7xA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvRDW-0004iS-Fk; Thu, 30 Aug 2018 17:58:50 +0000
Date:   Thu, 30 Aug 2018 10:58:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "Matwey V . Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>, kernel@collabora.com,
        Keiichi Watanabe <keiichiw@chromium.org>
Subject: Re: [RFC 2/3] USB: core: Add non-coherent buffer allocation helpers
Message-ID: <20180830175850.GA11521@infradead.org>
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-3-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830172030.23344-3-ezequiel@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't introduce new DMA_ATTR_NON_CONSISTENT users, it is
a rather horrible interface, and I plan to kill it off rather sooner
than later.  I plan to post some patches for a better interface
that can reuse the normal dma_sync_single_* interfaces for ownership
transfers.  I can happily include usb in that initial patch set based
on your work here if that helps.
