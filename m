Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A3720881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A3720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJPBaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:30:07 -0400
Received: from mailoutvs30.siol.net ([185.57.226.221]:49883 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726639AbeJPBaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:30:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 6AEB7521577;
        Mon, 15 Oct 2018 19:43:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id H68FphBlTTer; Mon, 15 Oct 2018 19:43:51 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 048355208C1;
        Mon, 15 Oct 2018 19:43:51 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id B6B72521577;
        Mon, 15 Oct 2018 19:43:44 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, laurent.pinchart@ideasonboard.com
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        sboyd@kernel.org, airlied@linux.ie, architt@codeaurora.org,
        a.hajda@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [linux-sunxi] Re: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi: Enable workaround for v2.12a
Date:   Mon, 15 Oct 2018 19:43:44 +0200
Message-ID: <1599508.L0GctDr0rS@jernej-laptop>
In-Reply-To: <3616158.EzHeIcd69b@avalon>
References: <20181007093905.11253-1-jernej.skrabec@siol.net> <20181007093905.11253-16-jernej.skrabec@siol.net> <3616158.EzHeIcd69b@avalon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne torek, 09. oktober 2018 ob 19:40:44 CEST je Laurent Pinchart napisal(a):
> Hi Jernej,
> 
> Thank you for the patch.
> 
> On Sunday, 7 October 2018 12:38:51 EEST Jernej Skrabec wrote:
> > It turns out that even new DW HDMI controllers exhibits same magenta
> > line issues as older versions.
> > 
> > Enable workaround for v2.12a.
> 
> This doesn't affect the platforms I maintain, so I can't really test this,
> but I'm wondering whether there could be other platforms using a v2.12a DW
> HDMI that wouldn't need the workaround.
> 
> My platforms use a previous version, namely v2.01a. The workaround for that
> version has been enabled by
> 
> commit 9c305eb442f3b371fc722ade827bbf673514123e
> Author: Neil Armstrong <narmstrong@baylibre.com>
> Date:   Fri Feb 23 12:44:37 2018 +0100
> 
>     drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
> 
> I haven't paid too much attention to the patch back then, and have now
> double- checked the HDMI output on R-Car Gen3. Enabling the workaround
> doesn't cause any regression, and reverting the commit doesn't cause any
> issue either. I thus wonder whether we shouldn't enable the workaround with
> count = 1 in the default case instead of adding new IP core versions to the
> list. It would be nice if someone from Synopsys could comment on this.

I was thinking about that too, or even having parameter in dw_hdmi_plat_data 
which would tell how many times to repeat workaround procedure for a specific 
platform. But this might be an overkill.

Best regards,
Jernej

> 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > 5971976284bf..df1c7a2d6961 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -1664,6 +1664,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi
> > 
> > *hdmi) case 0x131a:
> >  	case 0x132a:
> > 
> >  	case 0x201a:
> > +	case 0x212a:
> >  		count = 1;
> >  		break;
> >  	
> >  	default:




