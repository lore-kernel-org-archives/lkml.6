Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B057EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E032175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qb0vlRiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBGHbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:31:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfBGHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lOFIUwWTQbE48b7kY5flfLTWU784I61npq4jivcJyEc=; b=Qb0vlRiWFDdy2qFAOeEbMA3zHI
        62z7gpBD+PqKc1KYGiDzKSfC86esxIS8q3wSS5AeI34LuZfWASFZNVdeFz+jhTHw+8CO5rhHZF8C/
        wvNniT3fsFQoJzc22ld+4dIuSZY1OT6HoNhhXJVNI/4huPD29HlxTYp8i55REh5bMDroJLkBYLHNd
        pexLwd6TEJudFs03tQj80PHCXrk6mYk6KpdItBjG1f82rXD87cR2j3dH92dofmccqTctGhqZwmWpE
        W6B8VlmWXe8ecNPf1OzuLabTkuO0S2QEneLcB5foaYtdERVY23Ooj/zgtPlRysGppqXnDhexN4QM7
        UjTReNMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gre9I-0005mt-VU; Thu, 07 Feb 2019 07:31:04 +0000
Date:   Wed, 6 Feb 2019 23:31:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     =?iso-8859-1?Q?=D8rjan?= Eide <Orjan.Eide@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "tkjos@android.com" <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "arve@android.com" <arve@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>, nd <nd@arm.com>,
        "maco@android.com" <maco@android.com>,
        "christian@brauner.io" <christian@brauner.io>
Subject: Re: [Linaro-mm-sig] [PATCH 2/4] staging: android: ion: Restrict
 cache maintenance to dma mapped memory
Message-ID: <20190207073104.GA16222@infradead.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-3-git-send-email-lmark@codeaurora.org>
 <69b18f39-8ce0-3c4d-3528-dfab8399f24f@ti.com>
 <alpine.DEB.2.10.1901181316380.9328@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1901291544001.19412@lmark-linux.qualcomm.com>
 <20190130113122.fipxgcmgrqggozcm@DESKTOP-E1NTVVP.localdomain>
 <20190206154021.GC3768@e106893-lin.trondheim.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206154021.GC3768@e106893-lin.trondheim.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU may only access DMA mapped memory if ownership has been
transferred back to the CPU using dma_sync_{single,sg}_to_cpu, and then
before the device can access it again ownership needs to be transferred
back to the device using dma_sync_{single,sg}_to_device.

> I've run some testing, and this patch does indeed fix the crash in
> dma_sync_sg_for_cpu when it tried to use the 0 dma_address from the sg
> list.
> 
> Tested-by: Ørjan Eide <orjan.eide@arm.com>
> 
> I tested this on an older kernel, v4.14, since the dma-mapping code
> moved, in v4.19, to ignore the dma_address and instead use sg_phys() to
> get a valid address from the page, which is always valid in the ion sg
> lists. While this wouldn't crash on newer kernels, it's still good to
> avoid the unnecessary work when no CMO is needed.

Can you also test is with CONFIG_DMA_API_DEBUG enabled, as that should
catch all the usual mistakes in DMA API usage, including the one found?
