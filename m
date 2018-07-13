Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4DFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B57208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PPtsA/74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B57208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeGMHuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:50:11 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45110 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeGMHuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:50:10 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id C1B7425B808;
        Fri, 13 Jul 2018 17:36:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531467406; bh=EAiiYQA4K8R7myVxAX9fPn/OuzAa5xyPK7rOJtOh39k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPtsA/745UnvsoVyDoD+hkHkr9+8sxrxA00GUBN47jij4+ajJjPHNGdXlYoTLBZah
         4Wms6cG6MFmDVnN8gsFUvBqugDoJ7P+tq8emfYJLbYdaGqGoHhn8M9n3bTpVI9F01G
         Y0bQ1n3R0TKrgK9NRkRXLXqzukR0uh3Gde2Sn8u4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A7D55940486; Fri, 13 Jul 2018 09:36:43 +0200 (CEST)
Date:   Fri, 13 Jul 2018 09:36:43 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v4l: rcar_fdp1: Enable compilation on Gen2 platforms
Message-ID: <20180713073642.zhvduzgdryon4iqc@verge.net.au>
References: <20180711142332.4324-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711142332.4324-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:23:32PM +0200, Geert Uytterhoeven wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Commit 1d3897143815 ("[media] v4l: rcar_fdp1: add FCP dependency") fixed
> a compilation breakage when the optional VIDEO_RENESAS_FCP dependency is
> compiled as a module while the rcar_fdp1 driver is built in. As a side
> effect it disabled compilation on Gen2 by disallowing the valid
> combination ARCH_RENESAS && !VIDEO_RENESAS_FCP. Fix it by handling the
> dependency the same way the vsp1 driver did in commit 199946731fa4
> ("[media] vsp1: clarify FCP dependency").
> 
> Fixes: 1d3897143815 ("[media] v4l: rcar_fdp1: add FCP dependency")
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 210b44a457eb66f0..84cb97eccb2a52bc 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -385,7 +385,7 @@ config VIDEO_RENESAS_FDP1
>  	tristate "Renesas Fine Display Processor"
>  	depends on VIDEO_DEV && VIDEO_V4L2
>  	depends on ARCH_RENESAS || COMPILE_TEST
> -	depends on (!ARCH_RENESAS && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
> +	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV
>  	---help---
> -- 
> 2.17.1
> 
