Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4879C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D1F218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8RVsqM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfAWWDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:03:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32860 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAWWDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:03:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so1705938pgu.0;
        Wed, 23 Jan 2019 14:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SyFdcdvCcwUnrmB2s1421m4sGVu4iQQZ/zqmFjo/Mw4=;
        b=U8RVsqM27qX7YizoG73MYwJyjYVycEbN3IvItrTaeXG9GGmw36dxG1AXWswRRVDQX5
         XzMaRdlcsFQRgMYZKYi0gZ9dFhjEJXix9Ruh4lafbDQZ8ozXx79ISQOEK6jHhBREEl07
         u2T5WFiPEL6veY+RCOJ5LFyaIcZYamTaVOPI2dECWiJ4bbU2aO50KkXCw1XTOY+I9byi
         MNBw+3TCFUPsYhOXCni1AYs4R6takxmrw3pEec1EAgw9wKE7B1wE8yulBuQ/WuRA1VK+
         MeaY5EAeUEaf+YYUp/3ILZLLnS5+FEYbXUmOM0CdhHE/P5Vl34VOIiiEk1gUi5LT5ppJ
         3c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SyFdcdvCcwUnrmB2s1421m4sGVu4iQQZ/zqmFjo/Mw4=;
        b=PVbXWHJ01/TQ1xKfNS/YZTcwl4ylmcqRfdVhPStzxlxjcbJFh0DMwSsjSDD/J+159w
         m/G7n8hlTW8iV+ECk3kOYkDB6CjfpHzXZjFDynNGzONebHwolcO1EPKE4w+XEBPiM6B0
         d0Ai0AVLoajzO9yGdJvrW9c0DycdvThZISAmoC5lr4Oh5/GSeJ+NpZVwr16/JMxPCahW
         URdcPsRS+wM3EN1Gss8X46LLwBCDygUxEdaN5mppqH8urczOiuLyLBkWcFv7SWqikyfA
         c/tj2ut6fbBaY5Z1eBSFgY8+ZzQhJiqnXsVAvaDE/GjD0/JmthYDMV+KXMwFdGmWTJlV
         jM1g==
X-Gm-Message-State: AJcUukcD6HaEdlNTdPgQXTfG9xd2Xuz4eE9X4QyD6ECnwwX5WRYIrkQi
        48zNo/kMWN2kf9newRrw154=
X-Google-Smtp-Source: ALg8bN6aQx6WNwFfAKS8aByhbR0mzgO7I97tpUjhp/hScagJl9lL5zuUOYUDaxNNjZC6P3X/f+VNyg==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr3349008pgo.369.1548281025577;
        Wed, 23 Jan 2019 14:03:45 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b5sm36701879pfc.150.2019.01.23.14.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 14:03:44 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:03:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Message-ID: <20190123220342.GC179701@dtor-ws>
References: <20190122141311.10445-1-ronald@innovation.ch>
 <20190123084556.gsospl6joh53qnzs@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123084556.gsospl6joh53qnzs@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:45:56AM +0100, Lukas Wunner wrote:
> On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> > commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> > sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> > INPUT. However, this causes problems with other drivers, in particular
> > an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> > future commit):
> > 
> >   drivers/clk/Kconfig:9:error: recursive dependency detected!
> >   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
> >   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
> >   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
> >   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
> >   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
> >   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
> >   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
> >   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> > 
> > According to the docs, select should only be used for non-visible
> > symbols. Furthermore almost all other references to INPUT throughout the
> > kernel config are depends, not selects. Hence this change.

I think this is not as cut and dry. We should be able to select needed
subsystems (such as INPUT, USB, etc) even if they are user visible.
User, when enabling a piece of hardware, does not need to know ultimate
details of all subsystems the driver might need ti function.

It looks like one of the drivers implies MFD_INTEL_LPSS_PCI, maybe
treating imply the same as select when detecting circular dependency is
wrong as we are allowed to deselect implied dependencies?

> > 
> > CC: Inki Dae <inki.dae@samsung.com>
> > CC: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> I think this needs to be merged through the input tree as a prerequisite
> for the applespi.c driver (keyboard + touchpad driver for 2015+ MacBook,
> MacBook Air and MacBook Pro which uses SPI instead of USB) to avoid
> breaking the build.  Adding Dmitry.

I have no idea what applespi.c is (it is definitely not in my tree), so
I think it should be merged through the same tree that the original
commit was introduced through.

> 
> Thanks,
> 
> Lukas
> 
> 
> > ---
> >  drivers/gpu/drm/bridge/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 2fee47b0d50b..eabedc83f25c 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
> >  config DRM_SIL_SII8620
> >  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >  	depends on OF
> > +	depends on INPUT
> >  	select DRM_KMS_HELPER
> >  	imply EXTCON
> > -	select INPUT
> >  	select RC_CORE

Keeping "select RC_CORE" is wrong though, as the driver appears to be
working find without RC. Maybe it should be stubbed out?

Thanks.

-- 
Dmitry
