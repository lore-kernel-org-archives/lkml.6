Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EF020673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EF020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932827AbeGII7P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:59:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35802 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeGII7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:59:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so13307425edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3BWLQNmIWRJh6SyXOJavHCp8WXK705OubZNoPpwhAEg=;
        b=qTxRZ3bIJTus7DAk/+Ddo/3ZzYt4V98CmcX2rLuzUcN2gEi4Cu3lxzIsJj5sm6XW+9
         WRxmrzcNIUbJy+yqklNZAspZY/mApP68SlbIb0enz1ZI6JAIdHwI17EeiwlGGuqj3FOG
         AOzGA2ylv8XgG2u58Bf+2SO2G4kbAgBBLyPo9jxb9Cv/VgR0PJRsCBLvGGk9NTNlklu+
         xzysvwd5gekIK7pxx3B7wiTx/NZUFrZRP3u/EPFMDxtkm93FTKiX1mgXnoq6ctGJCwMy
         p5vvLe8o6xXONj9fMa5yFTfCHijeDrIHsUmqcCASUo+HkLaNyElLbn9jrZsrNO57gjyS
         mx9Q==
X-Gm-Message-State: APt69E2bzsXhtH3mN22gpEC6+Wg4Ob2qM6HQC2BvoaA4TULUE4pOJfP5
        XfCzhueiCSvO2kqSIU3ROZda35Co
X-Google-Smtp-Source: AAOMgpd3XYW8aXXG5cbkx7vgKXIDhW9dL25WyG9Ii8guMw7gxnhzH3ZdkXxln7loKsXyIxJswWG5jA==
X-Received: by 2002:a50:8c02:: with SMTP id p2-v6mr20597100edp.282.1531126750813;
        Mon, 09 Jul 2018 01:59:10 -0700 (PDT)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id o24-v6sm2708748edr.64.2018.07.09.01.59.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:59:10 -0700 (PDT)
Received: by mail-wm0-f43.google.com with SMTP id h20-v6so3969508wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:59:09 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr12209078wma.143.1531126749323;
 Mon, 09 Jul 2018 01:59:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 01:58:48 -0700 (PDT)
In-Reply-To: <20180709080724.3ekqb45fsjubvhcm@flea>
References: <20180706124628.3192421-1-arnd@arndb.de> <20180709080724.3ekqb45fsjubvhcm@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 9 Jul 2018 16:58:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HmXRK19-ahv624F8mpNCt21ri3AaVEiB+Gw9GsVeb=Q@mail.gmail.com>
Message-ID: <CAGb2v64HmXRK19-ahv624F8mpNCt21ri3AaVEiB+Gw9GsVeb=Q@mail.gmail.com>
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

On Mon, Jul 9, 2018 at 4:07 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
>> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
>> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
>>
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
>>
>> This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, building
>> the sun8i_tcon_top module the same way as the core sun4i-drm module whenever
>> DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
>>
>> Alternatively, we could always build sun8i_tcon_top.ko along with sun4-drm.ko
>> and detach it from the mixer module, I could not tell which way is more
>> appropriate here.
>
> If that's easily doable, then yeah, that would be the preferred option
> I guess. Jernej? Chen-Yu? Any opinion on this?

Yeah, that definitely works for me. Having TCON TOP being part of the core
sun4i-drm makes more sense. The TCON code will likely call into it later on
when Jernej adds the encoder muxing code.

I wonder if we shouldn't just build the whole display engine code, excluding
downstream encoders (HDMI, DSI, TV) into one module. That would also fix the
issue that DRM_SUN4I_BACKEND has to be built-in if DRM_SUN4I is built-in.
That might be overkill though, given that one day we should be able to get
rid of the frontend check.

Here's a list of the size of various parts of this driver, built for ARMv7:

Common stuff:
   text    data     bss     dec     hex filename
   5021     344       0    5365    14f5 drivers/gpu/drm/sun4i/sun4i_drv.o
   1058       0       0    1058     422 drivers/gpu/drm/sun4i/sun4i_layer.o
    192       4       0     196      c4
drivers/gpu/drm/sun4i/sun4i_framebuffer.o
   1704       0       0    1704     6a8 drivers/gpu/drm/sun4i/sun4i_crtc.o
   1221       0       0    1221     4c5 drivers/gpu/drm/sun4i/sun4i_dotclock.o
   1192      28       0    1220     4c4 drivers/gpu/drm/sun4i/sun4i_lvds.o
   1583      92       0    1675     68b drivers/gpu/drm/sun4i/sun4i_rgb.o
  10088     248       0   10336    2860 drivers/gpu/drm/sun4i/sun4i_tcon.o
   1690     104       0    1794     702 drivers/gpu/drm/sun4i/sun6i_drc.o
  23749     820       0   24569    5ff9 (TOTALS)

DE 1.0:
   text    data     bss     dec     hex filename
   3596     248       0    3844     f04 drivers/gpu/drm/sun4i/sun4i_frontend.o
   8735     248       0    8983    2317 drivers/gpu/drm/sun4i/sun4i_backend.o
  12331     496       0   12827    321b (TOTALS)

DE 2.0:
   text    data     bss     dec     hex filename
   4040     248       0    4288    10c0 drivers/gpu/drm/sun4i/sun8i_mixer.o
   2620      28       0    2648     a58 drivers/gpu/drm/sun4i/sun8i_ui_layer.o
   1500       0       0    1500     5dc drivers/gpu/drm/sun4i/sun8i_ui_scaler.o
   2780      28       0    2808     af8 drivers/gpu/drm/sun4i/sun8i_vi_layer.o
  12612       0       0   12612    3144 drivers/gpu/drm/sun4i/sun8i_vi_scaler.o
    367       0       0     367     16f drivers/gpu/drm/sun4i/sun8i_csc.o
  23919     304       0   24223    5e9f (TOTALS)

TCON TOP:
   text    data     bss     dec     hex filename
   2623     104       0    2727     aa7 drivers/gpu/drm/sun4i/sun8i_tcon_top.o
   2623     104       0    2727     aa7 (TOTALS)

DE 1.0 HDMI:
   text    data     bss     dec     hex filename
    913       0       0     913     391
drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.o
   5543     104       0    5647    160f drivers/gpu/drm/sun4i/sun4i_hdmi_enc.o
   2583       0       0    2583     a17 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.o
   1326       0       0    1326     52e
drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.o
  10365     104       0   10469    28e5 (TOTALS)

MIPI DSI:
   text    data     bss     dec     hex filename
   1990     144       0    2134     856 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.o
   5921     132       0    6053    17a5 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.o
   7911     276       0    8187    1ffb (TOTALS)

DW HDMI:
   text    data     bss     dec     hex filename
   1774     104       0    1878     756 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.o
   1189       0       0    1189     4a5
drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.o
   4877     144       0    5021    139d drivers/gpu/drm/sun4i/sun8i_hdmi_phy.o
   7840     248       0    8088    1f98 (TOTALS)

So it seems better to keep various parts as separate modules.

The "data" column makes me wonder if we've constify-ed all possible data
structures yet.

Regards
ChenYu
