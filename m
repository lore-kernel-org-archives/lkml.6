Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B52C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F179220672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxJiiUY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F179220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeKZTWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:22:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKZTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iQTm/XqMSJMom8BW8zmnQQSJXSiibU+HR1aYyO1LZq8=; b=RxJiiUY4dPojPVTiyI5ZcpTux
        2V3PoDnjJx19BsIqvzf5d0HpbPs2GOevB0Be02LgbB7aKheLo2/5NEtZWGDkEBFqQYSioG0H5NSME
        uS+wIr0NJscxt034OBqloyQuuOVk9OyHyz5qJof2y6hWqZd+U+zZKgflAaIz8M3KnV3FqaS7D2KCJ
        VX+XY3BWH/ExfL5USgJq2I5qlTuVOTfTB+LPWJkOvh9KF6ptZthfrO6vnmZt2Muzp/64MtwOOfWW9
        Ot+L2a4Zx41MAT/DG+KqffSSDMQDgcZquzyHZV3zApoLqT5E9a+xEPF2nmoLX0/ptRF4USBxOFQGU
        efzdimKyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRCGY-0006Yl-2x; Mon, 26 Nov 2018 08:29:14 +0000
Date:   Mon, 26 Nov 2018 00:29:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: remove unneeded HAS_DMA define
Message-ID: <20181126082913.GA24840@infradead.org>
References: <1543218130-5800-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543218130-5800-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:42:10PM +0900, Masahiro Yamada wrote:
> kernel/dma/Kconfig globally defines HAS_DMA as follows:
> 
>   config HAS_DMA
>           bool
>           depends on !NO_DMA
>           default y
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Looks good, thanks!

Reviewed-by: Christoph Hellwig <hch@lst.de>
