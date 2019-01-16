Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915B820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cYeiXUBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405387AbfAPQVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:21:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfAPQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XbRpFntAZUmLCET0hDLFncxzq21ZFdGLuQOeJXlO45A=; b=cYeiXUBLSf0smOJsWKEYYP+Xe
        8+zZvnsyTOUsuzkdsDwIvRUoRWKI7jKVotaVEzAcLlZ9QLajNSJwDWuVte1JL0LUS1ANX0UIxqZ2M
        UdiOo4wVLbonAJxh3ghWSb0sLhpj8qNpJNFtId4rklFw8nzf/Pu4HtuC+5iCQ7MTi8VzU7/5IQLZ6
        6Pa7lxrW1bqu1nOaEnqZYQHOMnSPQKGeaKC2JHUOqGDUpv+mTNNB0Bu6qsVocE1rbmEPlIgcQ4484
        zPagYxGkY/+wSo365KR4BaICbOa00q75EW+ZqgqZEmG8Bnb5A+aZlatEHqAfWtHYu6H1Qty7rOZLf
        iuiJRMmlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjnwT-0004TM-IP; Wed, 16 Jan 2019 16:21:25 +0000
Date:   Wed, 16 Jan 2019 08:21:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH] etnaviv: allow to build on ARC
Message-ID: <20190116162125.GA16326@infradead.org>
References: <20190114163157.20114-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114163157.20114-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:31:57PM +0300, Eugeniy Paltsev wrote:
> ARC HSDK SoC has Vivante GPU IP so allow build etnaviv for ARC.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index 342591a1084e..49a9957c3373 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_ETNAVIV
>  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
>  	depends on DRM
> -	depends on ARCH_MXC || ARCH_DOVE || ARM || COMPILE_TEST
> +	depends on ARCH_MXC || ARCH_DOVE || ARM || ARC || COMPILE_TEST

Is there any reason to not just remove the dependencies entirely?
It seems like it could literally build everywhere, and who knows what
other SOCs the IP blocks end up in sooner or later?
