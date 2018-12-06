Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91108C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E80C20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lV6N7snu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E80C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeLFOJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:09:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbeLFOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m2xkjuTlSipGSiwsnGp8ljwTaVUUVeTvowEmTVLQrHQ=; b=lV6N7snur2wa7BJ1GuUKJf41b
        neJR4SJ1OlgZsy8mzW7zX4HYTOgvl1K0S4b9YfOlAalGkA1hcDMhXPC7lmNVv9RrpPL2zE9y0HJHn
        SLLFRjWS4VP+cLp+f1TIvQZ8Cpnrf989LwAH0rd1IO8VIkdPjR99LEMVyhyzYO6tt6W60IsQjd1Ki
        iUHV45Bt9qWicOiTF8cvqBH+SEarowQ5w8JrbJLbR2ead2XboshfH8cX4TEuhdWE50TErkH/8JTic
        uzMxQbm/bcW7MtDk3FznNVbjt6+R+lMEKANf++1rlruWkAyIQRwJBU2A1LLko753E+2B90q9Gx/5A
        F/vTK570A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUuLD-00083e-2S; Thu, 06 Dec 2018 14:09:23 +0000
Date:   Thu, 6 Dec 2018 06:09:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/34] powerpc: allow NOT_COHERENT_CACHE for amigaone
Message-ID: <20181206140922.GA29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-3-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc maintainers, can you pick this up as this is a bug fix for the
currently existing powerpc Kconfig code?

On Wed, Nov 14, 2018 at 09:22:42AM +0100, Christoph Hellwig wrote:
> AMIGAONE select NOT_COHERENT_CACHE, so we better allow it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/platforms/Kconfig.cputype | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index f4e2c5729374..6fedbf349fce 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -412,7 +412,8 @@ config NR_CPUS
>  
>  config NOT_COHERENT_CACHE
>  	bool
> -	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
> +	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
> +		GAMECUBE_COMMON || AMIGAONE
>  	default n if PPC_47x
>  	default y
>  
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
