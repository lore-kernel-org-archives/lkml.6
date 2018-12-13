Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AEDC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D75A2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rU8q2mDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D75A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeLMVhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:37:15 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47520 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeLMVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:37:15 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 51E92549;
        Thu, 13 Dec 2018 22:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1544737032;
        bh=q/zSdv4xFdeaIo7pL8QOsLZrYbfHMzkWb9lbYbQ/NJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rU8q2mDcA/CCxz4n0bYZaOakBBM+mlmsBDTyhoWJF6wOB+Vy7umghYpEGJQaBGfS+
         8BPmw/V9bzXImvBdE5FxxFG9kuvLncoHxAFNU15ZuwQgSQB3GTjKlyXzYINd8Pzqvl
         fvz2B+x/q5KL3gcNPJloS0S3bLpeEtHHbQYNTf5Y=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] drm: rcar-du: lvds: add R8A774C0 support
Date:   Thu, 13 Dec 2018 23:37:59 +0200
Message-ID: <19818144.G1rqBgM4ba@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1544732616-7322-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1544732616-7322-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Thursday, 13 December 2018 22:23:36 EET Fabrizio Castro wrote:
> The LVDS implementation on the RZ/G2E (a.k.a. R8A774C0) is very similar
> to the one found on R-Car E3 (a.k.a. R8A77990), therefore add RZ/G2E
> LVDS support to the LVDS encoder driver in a similar fashion to what

s/what/what is/

> done for R-Car E3.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree with the above fix.

> ---
>  drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> b/drivers/gpu/drm/rcar-du/rcar_lvds.c index 173d7ad..329dfca 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -785,6 +785,7 @@ static const struct rcar_lvds_device_info
> rcar_lvds_r8a77995_info = {
> 
>  static const struct of_device_id rcar_lvds_of_table[] = {
>  	{ .compatible = "renesas,r8a7743-lvds", .data = &rcar_lvds_gen2_info },
> +	{ .compatible = "renesas,r8a774c0-lvds", .data = &rcar_lvds_r8a77990_info
> }, { .compatible = "renesas,r8a7790-lvds", .data = &rcar_lvds_r8a7790_info
> }, { .compatible = "renesas,r8a7791-lvds", .data = &rcar_lvds_gen2_info },
> { .compatible = "renesas,r8a7793-lvds", .data = &rcar_lvds_gen2_info },


-- 
Regards,

Laurent Pinchart



