Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D75C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5876E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5876E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeIJJ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:56:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37643 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeIJJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:56:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20-v6so15489427edd.4;
        Sun, 09 Sep 2018 22:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iw984Q6zPALPYIraNxrsxkXmn+eP0J6bEq6Yf+bfbOY=;
        b=g4wxig89uTrMw6u0iN1QsgD5Xrp4kzlGsNsnKrdb/wl7XGRmeVPWPt74sB92tjPpo+
         WSeRqSl0VoKuYYUQKpcQ9OWunnuiOy7EfK9kA/r88G//yy/qtoWYrh0/WpApkpbfRoCX
         Ls9YgLKbkYVKsMX7jOBtHc60FLgwL23s4FUJUnYePCo2DJilBl3RUuz9TcT0KX7L1uxP
         iFhDDg8PLsF8oUNes82pkcK0Lq455mCmIGQe7/Gtbgc10UZINmcHkuXho2QTsnphY17v
         qznxoQ6SQI9AWep5L8GxqvKFNL9HGeHRvMrqSTny5zN9gNjDWuDXKayJcngzE3RmXhU0
         bX6w==
X-Gm-Message-State: APzg51C7OlQX8beFMioEC7uDN6K1uwtgpihTcjKbrnHYYOByU8wNx0Li
        fdYtAyHgeEAtDXT5To392ag86sPIaoA=
X-Google-Smtp-Source: ANB0VdawpTdIurkjnYs+LJOApLEiTS6HE5xNW1sBms0Auhg9fC7uuKTlgJyZsmv49nByjTptRaEpzg==
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr20818254edd.194.1536555830284;
        Sun, 09 Sep 2018 22:03:50 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id p5-v6sm7948240edc.33.2018.09.09.22.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 22:03:49 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id j26-v6so20418055wre.2;
        Sun, 09 Sep 2018 22:03:49 -0700 (PDT)
X-Received: by 2002:adf:8485:: with SMTP id 5-v6mr13656854wrg.34.1536555828970;
 Sun, 09 Sep 2018 22:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180907072234.48282-1-icenowy@aosc.io>
In-Reply-To: <20180907072234.48282-1-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 10 Sep 2018 13:03:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v65G-rVK67C2EfKB+xcKY2OP_K-eXXpyC_BtskXyANe2UA@mail.gmail.com>
Message-ID: <CAGb2v65G-rVK67C2EfKB+xcKY2OP_K-eXXpyC_BtskXyANe2UA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 0/5] Fix A64 HDMI PHY device tree binding
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 3:22 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> When adding support for A64 HDMI PHY in 4.19, we assumed that the two
> PLL-VIDEOs can both feed the HDMI PHY clock. However experiments show
> that the mux bit discovered in R40 blob is not applicable on A64. This
> is not discovered, as normally with a single display pipeline only
> PLL-VIDEO0 will be used.
>
> In this patchset the second PLL is dropped, and a binding specially for
> R40 HDMI PHY is added (which seems to have the mux).
>
> PATCH 1 and 2 are dropping second PLL for A64 HDMI PHY, and PATCH 3 to 5
> are adding R40 HDMI PHY binding.
>
> This patchset targets v4.19 fixes tree, because the binding is
> introduced in v4.19, and if we don't fix it there a wrong binding will
> be left in a stable version released.

Please add fixes tags.

The patches look good, though I'm not sure about patches 3 and 4 going in fixes.

ChenYu


> Icenowy Zheng (5):
>   dt-bindings: sun4i-drm: drop second PLL from A64 HDMI PHY binding
>   drm: sun4i: drop second PLL from A64 HDMI PHY
>   dt-bindings: sun4i-drm: add compatible for R40 HDMI PHY
>   drm/sun4i: add support for R40 HDMI PHY
>   ARM: sun8i: dts: drop A64 HDMI PHY fallback compatible from R40 DT
>
>  .../devicetree/bindings/display/sunxi/sun4i-drm.txt |  5 +++--
>  arch/arm/boot/dts/sun8i-r40.dtsi                    |  3 +--
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c              | 13 ++++++++++++-
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
