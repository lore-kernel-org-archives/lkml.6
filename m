Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31EFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FCA20C07
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="lkSGEP69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FCA20C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeHVOHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:07:02 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50304 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeHVOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:07:02 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6075A25AD64;
        Wed, 22 Aug 2018 20:42:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534934560; bh=lk1RhVsJgsVLIJ3G9tw7NTYawBCbrbvugI37k5TTr+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkSGEP69hey6z3+rbUUiA7rK+4230FeVYWgyUY7yc1yG0w3OSf7il+ArIIwc6y9C+
         2AEmx6rSEb3C/nRMoblyWjOEL7po3oJjXY9vll6FNux2KBwYaa7gafPQ6FsIWHF/pJ
         5CTZmCn2rFHcN2fDO3eGH+MvIlZCdLwU9nYqeO04=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 3E9AB94040B; Wed, 22 Aug 2018 12:42:38 +0200 (CEST)
Date:   Wed, 22 Aug 2018 12:42:38 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: rcar-du: Refactor Feature and Quirk definitions
Message-ID: <20180822104237.crfrf52wkb2zazgt@verge.net.au>
References: <20180820160044.15783-1-kieran.bingham+renesas@ideasonboard.com>
 <20180820160044.15783-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820160044.15783-2-kieran.bingham+renesas@ideasonboard.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 05:00:43PM +0100, Kieran Bingham wrote:
> These flags are represented by bit fields. To make this clear, utilise
> the BIT() macro.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> ---
> This patch fails checkpatch's 80-char limit, due to the line comments
> extending across the 80-char boundary on RCAR_DU_FEATURE_EXT_CTRL_REGS
> 
> To preserve formatting - this warning has been ignored.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> index b3a25e8e07d0..78ea20abfb30 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> @@ -27,11 +27,11 @@ struct drm_device;
>  struct drm_fbdev_cma;
>  struct rcar_du_device;
>  
> -#define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	(1 << 0)	/* Per-CRTC IRQ and clock */
> -#define RCAR_DU_FEATURE_EXT_CTRL_REGS	(1 << 1)	/* Has extended control registers */
> -#define RCAR_DU_FEATURE_VSP1_SOURCE	(1 << 2)	/* Has inputs from VSP1 */
> +#define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	BIT(0)	/* Per-CRTC IRQ and clock */
> +#define RCAR_DU_FEATURE_EXT_CTRL_REGS	BIT(1)	/* Has extended control registers */
> +#define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(2)	/* Has inputs from VSP1 */
>  
> -#define RCAR_DU_QUIRK_ALIGN_128B	(1 << 0)	/* Align pitches to 128 bytes */
> +#define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
>  
>  /*
>   * struct rcar_du_output_routing - Output routing specification
> -- 
> 2.17.1
> 
