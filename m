Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69592C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6042087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6042087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbeGIJR6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:17:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41430 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeGIJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:17:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id b12-v6so13354980edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bo2uOA8TDUCn1UmhmHC7lzyxX1D4yEXQO4LKlJ1TCCA=;
        b=Kc+vImDHEX/nwTJcz4sLym+lxFpy+hbcR7viJ+Omd0aD6SACrI6kUGG3rqpsgrFb2K
         3vT1MIdnWm0i/lqOJdXpXcihLc7YImdsjIrxsiQbRnmPOofNwf1xjjGs/ls2hMDCAC0B
         miszYTWjsF3xYBdaW5AbrReHOZBn8gOongsxWuKCwkZ/KOErnoS9HehpHq8s3YM3q8l6
         LE8Yert0viKbQpeAMYBq7CkXmRySmyaZ7ue3VdNODuLxq7bbPCl0iRrlwnfLXJ5CP0Ld
         z6jBnORnFVr2va5S2mW1elqFHxmCPXPtUGTAJnKfXeAWM3A+2DoBhrS5ODdZWZWMQoMy
         YJvA==
X-Gm-Message-State: APt69E2+C71QUhze9W4AS5Jhtaz7morEx1aj7cINfSWA+ID+yZFaTpPu
        JXs/sPL3Q/LR0PwTNMCLaTykFUmq
X-Google-Smtp-Source: AAOMgpfeOuFv+W7pqs8F5+oFXsqcTvsIcNdScDzdW4ER/K81viYLTrff7jHC+N6y1Dg1MSAUl8dX6Q==
X-Received: by 2002:a50:a305:: with SMTP id 5-v6mr21955413edn.57.1531127876390;
        Mon, 09 Jul 2018 02:17:56 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id k32-v6sm2113489edc.85.2018.07.09.02.17.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 02:17:55 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id u7-v6so10159767wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:17:55 -0700 (PDT)
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr15839347wrb.155.1531127875551;
 Mon, 09 Jul 2018 02:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 02:17:35 -0700 (PDT)
In-Reply-To: <20180709091524.sfamfdmbmwclmegj@flea>
References: <20180706124628.3192421-1-arnd@arndb.de> <20180709080724.3ekqb45fsjubvhcm@flea>
 <CAGb2v64HmXRK19-ahv624F8mpNCt21ri3AaVEiB+Gw9GsVeb=Q@mail.gmail.com> <20180709091524.sfamfdmbmwclmegj@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 9 Jul 2018 17:17:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v66HX9YBzPsUjyUmf3XBufnipZRmfkZKnGJCh4Mh89WvqQ@mail.gmail.com>
Message-ID: <CAGb2v66HX9YBzPsUjyUmf3XBufnipZRmfkZKnGJCh4Mh89WvqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonathan Liu <net147@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:15 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Mon, Jul 09, 2018 at 04:58:48PM +0800, Chen-Yu Tsai wrote:
>> On Mon, Jul 9, 2018 at 4:07 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> > On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
>> >> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
>> >> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
>> >>
>> >> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
>> >> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
>> >>
>> >> This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, building
>> >> the sun8i_tcon_top module the same way as the core sun4i-drm module whenever
>> >> DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
>> >>
>> >> Alternatively, we could always build sun8i_tcon_top.ko along with sun4-drm.ko
>> >> and detach it from the mixer module, I could not tell which way is more
>> >> appropriate here.
>> >
>> > If that's easily doable, then yeah, that would be the preferred option
>> > I guess. Jernej? Chen-Yu? Any opinion on this?
>>
>> Yeah, that definitely works for me. Having TCON TOP being part of the core
>> sun4i-drm makes more sense. The TCON code will likely call into it later on
>> when Jernej adds the encoder muxing code.
>>
>> I wonder if we shouldn't just build the whole display engine code, excluding
>> downstream encoders (HDMI, DSI, TV) into one module. That would also fix the
>> issue that DRM_SUN4I_BACKEND has to be built-in if DRM_SUN4I is built-in.
>> That might be overkill though, given that one day we should be able to get
>> rid of the frontend check.
>
> We can't really do that (or at least without rewriting a significant
> part of the driver), since we can have only one
> module_init/module_exit function per module, and we have one
> per-hardware block.

Right. That would require some serious plumbing to register all the drivers.

ChenYu
