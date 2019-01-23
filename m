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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40897C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF9221872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnQe+aME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfAWWVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:21:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34384 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAWWVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:21:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so1904034pfg.1;
        Wed, 23 Jan 2019 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dPlMYpqHflzvPMfzKJnzpuKQBxmVyuZJAT4mYueAi9A=;
        b=gnQe+aMELWvkbNx+/TMHMurIG+BVxPCTIXyf4BxC8L9XlRWByaRY3yLpFsSx+9aYbx
         wDw/fQsgPF/FyYpFEdLsaAuvmn12t/HxeRvYI9zY1jgQ02KnE/4s+E7Io84hnNLgGJve
         mcBSjBuNRXgJanikF3CwZLLxXwknRS3m24kh6TXsMzLSlJaiLKbu3FMNy5WmVhw3zKiv
         AoXHNSbxHxWL3EPfhcKNGs+I2ENaj3fPw9AakXYtEVCXWkB5I9pYvfMtKelxZ95ZIEB+
         uaqzyH4JOywIny6sHZafK60yyW0WXS0OPbn/DjmEb76EFFxSz+qiOZELtG1U5c2IHL+R
         XA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dPlMYpqHflzvPMfzKJnzpuKQBxmVyuZJAT4mYueAi9A=;
        b=WATyebF6218P0vJ7L2ct5LSRerZOSzJQRq+hE3Oh8eiRsfA3izSEv2yIfucjNvJBKO
         X6WZGRyDr2MepiCW5/Z13SuIXsEoT9ULkXzJZ1blIs/BY1CmxVvNYq5HpR86F378mJg8
         LNCViPLOuqjvkRuIjHjNee3+DtZC9gXrz4M/Z+JIzBYvyhySBz7VKz97xBESg9nFXnH+
         mLWUGws5QQRXS6CeXaBGRd4zwK2iYykXPmHYD6wHJ42H4ew/ZsL0BCbIZOOVvRmDY5yj
         JXQ2yr1z/m9S+8n/OtH2+AmaMUbAgR9C81z55Nlaf2bqgPXS3foqGp0QQWUsD2e1ddNv
         GN/A==
X-Gm-Message-State: AJcUukcjr7D8rQca8qOjQ++B0AlrIIGuiNvTVrexOgOg5wpbVQZgVbGP
        R4Sx8KZwBVhl6jlN/2HszXU=
X-Google-Smtp-Source: ALg8bN4ifWOvStZ14ywZPOrNvLvx9FrH1AqGQ/s387FXgv5gRPr5NJtc1zKYzO1XjmW2H8EBkhX9qQ==
X-Received: by 2002:a63:20e:: with SMTP id 14mr3651424pgc.161.1548282067430;
        Wed, 23 Jan 2019 14:21:07 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t90sm28028249pfj.23.2019.01.23.14.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 14:21:06 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:21:05 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Message-ID: <20190123222105.GF179701@dtor-ws>
References: <20190122141311.10445-1-ronald@innovation.ch>
 <20190123084556.gsospl6joh53qnzs@wunner.de>
 <20190123220342.GC179701@dtor-ws>
 <20190123221735.GE4675@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123221735.GE4675@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Jan 24, 2019 at 12:17:35AM +0200, Laurent Pinchart wrote:
> Hello Dmity,
> 
> On Wed, Jan 23, 2019 at 02:03:42PM -0800, Dmitry Torokhov wrote:
> > On Wed, Jan 23, 2019 at 09:45:56AM +0100, Lukas Wunner wrote:
> > > On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> > >> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> > >> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> > >> INPUT. However, this causes problems with other drivers, in particular
> > >> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> > >> future commit):
> > >> 
> > >>   drivers/clk/Kconfig:9:error: recursive dependency detected!
> > >>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
> > >>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
> > >>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
> > >>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
> > >>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
> > >>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
> > >>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
> > >>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> > >> 
> > >> According to the docs, select should only be used for non-visible
> > >> symbols. Furthermore almost all other references to INPUT throughout the
> > >> kernel config are depends, not selects. Hence this change.
> > 
> > I think this is not as cut and dry. We should be able to select needed
> > subsystems (such as INPUT, USB, etc) even if they are user visible.
> 
> Semantically, maybe, but given the current state of Kconfig this results
> in a recursive dependencies nightmare. It's a no-go.
> 
> > User, when enabling a piece of hardware, does not need to know ultimate
> > details of all subsystems the driver might need ti function.
> > 
> > It looks like one of the drivers implies MFD_INTEL_LPSS_PCI, maybe
> > treating imply the same as select when detecting circular dependency is
> > wrong as we are allowed to deselect implied dependencies?
> > 
> > >> 
> > >> CC: Inki Dae <inki.dae@samsung.com>
> > >> CC: Andrzej Hajda <a.hajda@samsung.com>
> > >> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > > 
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > 
> > > I think this needs to be merged through the input tree as a prerequisite
> > > for the applespi.c driver (keyboard + touchpad driver for 2015+ MacBook,
> > > MacBook Air and MacBook Pro which uses SPI instead of USB) to avoid
> > > breaking the build.  Adding Dmitry.
> > 
> > I have no idea what applespi.c is (it is definitely not in my tree), so
> > I think it should be merged through the same tree that the original
> > commit was introduced through.
> > 
> > >> ---
> > >>  drivers/gpu/drm/bridge/Kconfig | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> 
> > >> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > >> index 2fee47b0d50b..eabedc83f25c 100644
> > >> --- a/drivers/gpu/drm/bridge/Kconfig
> > >> +++ b/drivers/gpu/drm/bridge/Kconfig
> > >> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
> > >>  config DRM_SIL_SII8620
> > >>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
> > >>  	depends on OF
> > >> +	depends on INPUT
> > >>  	select DRM_KMS_HELPER
> > >>  	imply EXTCON
> > >> -	select INPUT
> > >>  	select RC_CORE
> > 
> > Keeping "select RC_CORE" is wrong though, as the driver appears to be
> > working find without RC. Maybe it should be stubbed out?
> 
> It should definitely not be select'ed as it's a user-visible symbol. My
> preference would be to simply revert d6abe6df706c. If we want (and can)
> work without RC core then it should be stubbed out.
> 
> Commit d6abe6df706c states
> 
>     And some boards not using remote controller device don't really
>     need to know that RC_CORE config should be enabled to use sil_sii8620
>     driver only for HDMI.
> 
> The same reasoning applies to INPUT, if we agree that depending on
> RC_CORE is confusing for users, then depending on INPUT is confusing as
> well. There's not reason to apply different standards to INPUT and
> RC_CORE, depending on one and selecting the other doesn't make much
> sense.

OK, so revert + patch to stub out RC calls? That works for me (and I
still say it should go through the same tree that introduced
d6abe6df706c).

Thanks.

-- 
Dmitry
