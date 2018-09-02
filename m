Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72E92077C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72E92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeIBNrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:47:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43568 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeIBNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:47:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id z27-v6so11943200edb.10;
        Sun, 02 Sep 2018 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIhQRxJRyD7iv3XZSdxL641fDlGG0nYGOChAx0vzNJU=;
        b=pXpm1+hPVAUYMIZ6oMpkyTbUOmMw5ID0K9rmXK5zPCJLkXtBluH/oGGFqLkc/WmUVx
         qTKU3pW94I9cBKH1iUpprWpDpfN8i24M8AEnUup0Nq8RPdojS1MXtQE0DHbA/mB8ucRU
         VW5RIbNF6z5yYYvkm16z0seG/zqhj7WwO0ZMUAJIwewgznsTUWAjzdPSwpzMmGm7/EKA
         y0xkkIsvRXjaBJCML/BEUBhT5RNcej1AoaAGMarCRiNYCV5QTZxybhsGE9uDu5a0Zy2o
         Lw3zL47otlbHJXFLWbFSMct9hOjOx/UB/HFS4K3TrZprK/i+9AsTgxGMyh3cdeu7kNL+
         Hnfw==
X-Gm-Message-State: APzg51BamUIoDkhT6bbawfZ2PjJsujiKdclKCkeMFHFOtat7PhQsuW4q
        aue59NWJ4Q5ic2Ne3kn1dJsyXszm
X-Google-Smtp-Source: ANB0Vdab6HGlEc8wmIltehpblyCEKAjgGT0DecoEAXl52cbIv4x68AjegyEwDXgZKqSMTKUq4NQm/g==
X-Received: by 2002:a50:b6e3:: with SMTP id f32-v6mr26624642ede.147.1535880723295;
        Sun, 02 Sep 2018 02:32:03 -0700 (PDT)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id s41-v6sm8474444edd.61.2018.09.02.02.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 02:32:02 -0700 (PDT)
Received: by mail-wm0-f43.google.com with SMTP id n11-v6so8924001wmc.2;
        Sun, 02 Sep 2018 02:32:01 -0700 (PDT)
X-Received: by 2002:a1c:e4c3:: with SMTP id b186-v6mr2349892wmh.116.1535880721662;
 Sun, 02 Sep 2018 02:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 2 Sep 2018 17:31:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v66coQW2vNgEkcLeN0VuV4r18baqYVrgqspLA5FvRfgcEg@mail.gmail.com>
Message-ID: <CAGb2v66coQW2vNgEkcLeN0VuV4r18baqYVrgqspLA5FvRfgcEg@mail.gmail.com>
Subject: Re: [PATCH 00/27] Allwinner H6 DE3 and HDMI support
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> can be found on H6 SoC.
>
> Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> displaying and processing 10-bit and AFBC formats, which are not yet
> supported by this series.
>
> This series is based on linux-next at next-20180828, which has working
> R40 display pipeline support. I'll rebase series on later linux-next, if
> needed, once R40 display pipeline support is reintroduced.
>
> I suggest all patches go through allwinner tree, except DRM patches,
> which should go through drm-misc tree.
>
> Last detail, PineH64 model A schematic has DDC_EN signal, which enables
> DDC voltage level shifter. TL Lim, PINE64 founder, said that this
> signal is not actually present on PineH64 model A board. It is, however
> present on PineH64 model B engineering samples, but it will be removed
> in production version. Because of that, I didn't include any code for
> it.
>
> Please take a look.
>
> Best regards,
> Jernej
>
> Icenowy Zheng (7):
>   dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
>   arm64: allwinner: h6: add system controller device tree node

Prefix should be "arm64: dts: allwinner: h6: ".

>   dt-bindings: bus: add H6 DE3 bus binding
>   dt-bindings: display: sunxi: add DT binding for Allwinner H6 DW HDMI
>   drm: sun4i: add quirks for TCON TOP
>   dt-bindings: display: sun4i-drm: document H6 TCON TOP
>   drm: sun4i: add support for H6 TCON TOP
>
> Jernej Skrabec (20):
>   clk: sunxi-ng: Adjust MP clock parent rate when allowed
>   clk: sunxi-ng: Use u64 for calculation of NM rate
>   clk: sunxi-ng: h6: Set video PLLs limits
>   dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
>   clk: sunxi-ng: Add support for H6 DE3 clocks
>   dt-bindings: display: sun4i-drm: Add H6 display engine compatibles
>   drm/sun4i: Add compatible for H6 display engine
>   drm/sun4i: Rework DE2 register defines
>   drm/sun4i: Add basic support for DE3
>   drm/sun4i: Add support for H6 DE3 mixer 0
>   drm/bridge/synopsys: dw-hdmi: Enable workaround for v2.12a
>   drm/sun4i: Not all DW HDMI controllers has scrambled addresses
>   drm/sun4i: dw-hdmi: Make mode_valid function configurable
>   drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
>   drm/sun4i: Add support for H6 DW HDMI controller
>   drm/sun4i: Add support for Synopsys HDMI PHY
>   drm/sun4i: Add support for H6 HDMI PHY
>   drm/sun4i: Initialize registers in tcon-top driver
>   arm64: dts: sun50i: h6: Add HDMI pipeline
>   arm64: dts: sun50i: h6: Enable HDMI output on Pine H64 board

Same here.

ChenYu

>
>  .../bindings/bus/sun50i-de2-bus.txt           |   9 +-
>  .../devicetree/bindings/clock/sun8i-de2.txt   |   5 +-
>  .../bindings/display/sunxi/sun4i-drm.txt      |  30 ++-
>  .../devicetree/bindings/sram/sunxi-sram.txt   |   4 +
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  25 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 224 ++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   4 +
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c          |  65 +++++
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.h          |   1 +
>  drivers/clk/sunxi-ng/ccu_mp.c                 |  64 ++++-
>  drivers/clk/sunxi-ng/ccu_nm.c                 |  18 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |   1 +
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
>  drivers/gpu/drm/sun4i/sun8i_csc.c             |  96 +++++++-
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  45 +++-
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  14 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        | 178 +++++++++++++-
>  drivers/gpu/drm/sun4i/sun8i_mixer.c           |  44 +++-
>  drivers/gpu/drm/sun4i/sun8i_mixer.h           |  61 +++--
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  58 ++++-
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  47 ++--
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.h        |  37 +--
>  drivers/gpu/drm/sun4i/sun8i_ui_scaler.c       |  45 ++--
>  drivers/gpu/drm/sun4i/sun8i_ui_scaler.h       |  28 +--
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  55 +++--
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.h        |  25 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_scaler.c       |  85 +++++--
>  drivers/gpu/drm/sun4i/sun8i_vi_scaler.h       |  68 ++++--
>  include/dt-bindings/clock/sun8i-de2.h         |   3 +
>  include/dt-bindings/reset/sun8i-de2.h         |   1 +
>  30 files changed, 1127 insertions(+), 214 deletions(-)
>
> --
> 2.18.0
>
