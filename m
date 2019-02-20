Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB839C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7641B21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hseujAq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfBTB0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:26:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfBTB0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hkLd6KyoZC6Tlyk9JOarrMRuYpq2hB4GUfzZHeB5XxI=; b=hseujAq6NJQqGR2zHzn5BKlYf
        Isxf8B4mLcSCDim1kXDk86yYcbgIrRqCRXepB8hBgiBEcvwJe5cxpyU3vVVSrfyl4WlH+Cr0GsMQK
        eTGE0+xf8N4cm2QB/8ZltdK0kDGIPs0FD9rQNSAvcCGWFoubjHy73Rt1CXzMaMl/9iAA3BxbqifJJ
        ZgVnvwEpdLsPir10VbqOmAvWM22Vi263eaO5/XXyd0i2tmjStuhIfBb7xeOLB9ilOvVfoj5G3Itlm
        Hfv0gvXkeHz35CnkqcSBaUk+0clEMipamLojIrlKZgqMJx5yaXNwoESdClPbn5L+Ho96hpzJ57Hcp
        wXcEFQ/xA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwGeH-0002We-Uo; Wed, 20 Feb 2019 01:26:09 +0000
Date:   Tue, 19 Feb 2019 17:26:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: xarray reserve/release?
Message-ID: <20190220012609.GC12668@bombadil.infradead.org>
References: <20190219235349.GA17351@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219235349.GA17351@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 04:53:49PM -0700, Jason Gunthorpe wrote:
> Hey Matt,
> 
> Did you intend that xa_release doesn't work on allocating arrays:

That surprises me.  I'll take a look in the morning.

(giving me the test case is perfect, btw)
