Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A8820883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvsn7s4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A8820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbeFUGkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:40:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFUGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jH6+vA9bQxL+rRo3P5SSNrSDZvaLe9vlDSAQ755Owy0=; b=kvsn7s4N3Y6jUSonsSz/5o8rk
        tiQPOvzdugerDbagxbZOWp7AcQa3z913CM5ZMxWVHQY6LxT0fSUYoHN39jNkgAi7LAUYc01QL/ls0
        d6BjHiAcyy/OwZhKB8u2liW8IRKPieE3VDXsORoWWrJLdXt1oqrVB/kfApKTZ+joxi9f76J9CGcYr
        MmG7wyORd1OmZIhVjONEqVJQ07oCVFVlFoMS44FVSXr/l4nJMKE1b420x+OTgrrBSPxBgsTpZjEMo
        gAZ6OT+LYM1Bst716rb1aQFlIMuBNhzDRUiMtXW4lPqV8PItMLWcetn+T7h7ZafExAoqQRiTOCbUf
        APZAG/TTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVtGt-0003uu-Ox; Thu, 21 Jun 2018 06:40:43 +0000
Date:   Wed, 20 Jun 2018 23:40:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime@adnestech.com
Subject: Re: [PATCH 1/5] RISC-V: Add conditional macro for zone of DMA32
Message-ID: <20180621064043.GC19319@infradead.org>
References: <cover.1529506497.git.zong@andestech.com>
 <79dba59ab02752b260cb31f557a09df786fd80d7.1529506497.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79dba59ab02752b260cb31f557a09df786fd80d7.1529506497.git.zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:41:41AM +0800, Zong Li wrote:
> The DMA32 is for 64-bit usage.
> 
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/mm/init.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c77df8142be2..91a5852e28fd 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -28,8 +28,11 @@ static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
>  
> +#ifdef CONFIG_ZONE_DMA32
>  	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
> +#else
>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +#endif

This breaks the 64-bit setup.  The second line needs to be kept for
the CONFIG_ZONE_DMA32 case.
