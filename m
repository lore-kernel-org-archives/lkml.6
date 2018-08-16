Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09EC208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09EC208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403952AbeHPRjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:39:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44517 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeHPRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:39:38 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fqJS3-0002nK-O4; Thu, 16 Aug 2018 16:40:39 +0200
Message-ID: <1534430439.4135.6.camel@pengutronix.de>
Subject: Re: [PATCH] drm/panel: p079zca: unconditionally remove the panel on
 removal
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Heiko Stuebner <heiko@sntech.de>, thierry.reding@gmail.com
Cc:     hl@rock-chips.com, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nickey.yang@rock-chips.com, seanpaul@chromium.org
Date:   Thu, 16 Aug 2018 16:40:39 +0200
In-Reply-To: <20180816140920.5009-1-heiko@sntech.de>
References: <20180816140920.5009-1-heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 16:09 +0200, Heiko Stuebner wrote:
> There is no need to check innolux->base.dev when trying to remove
> the panel, as that variable is always set directly before the panel
> gets added and will still be available on panel_remove.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> index 72edb334d997..ca4ae45dd307 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> @@ -506,8 +506,7 @@ static int innolux_panel_add(struct mipi_dsi_device *dsi,
>  
>  static void innolux_panel_del(struct innolux_panel *innolux)
>  {
> -	if (innolux->base.dev)
> -		drm_panel_remove(&innolux->base);
> +	drm_panel_remove(&innolux->base);
>  }
>  
>  static int innolux_panel_probe(struct mipi_dsi_device *dsi)

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
