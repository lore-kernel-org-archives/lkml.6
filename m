Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601D12168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601D12168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeI0TBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:01:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37354 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeI0TBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:01:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id e15-v6so4904401edr.4;
        Thu, 27 Sep 2018 05:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HheI+sulSGsvaB+fzcEph92bcq8ivR8jD6A7s3AfuwE=;
        b=W8ZtZuEfOreelnTVHL4vPUdee7nS+rYwoPiam52vkmUx7AQ80SSHgqFwttjLSlg/U7
         Tww/yHJvTf2CcVTy+Pm2vCGkQh40Ly1FVki/GRNdDC7hqH2sNVcDw16FGrstRnBLlSSk
         K52bGebR+Oy2jfscFkDg1F3H1uATdYpMh8szYnvC5uRMFSzDeLGZTjZuq5J71VG5m6P+
         oYnc5bMGgd20dkD4D3Srb/PChu7UOejxK72xz08jQVIBQrBNnVTTAeyKxjhhqEcE01DT
         9RDWsDEmClBf1slTELCyBHrHmcR8QFtuE8K5bIi96oRPxa4vSoKlMRHIaZmRfQGCf4xW
         E2CQ==
X-Gm-Message-State: ABuFfog2HhK7XT3Gu+yYQEgvJ7MwBhN4AsVrAATZJo+qVkZtTcixNfsa
        AjNS01Vj+H+sOyJaSbY/xy1bTm9JD+g=
X-Google-Smtp-Source: ACcGV62aY4QJKQizMhDeRny3Fbyc67tU6LxVYZVtCPVfQGHwtbh4PN35J4/HChPHwn1upMW/IdJbCw==
X-Received: by 2002:a50:b0c1:: with SMTP id j59-v6mr17029998edd.267.1538052187523;
        Thu, 27 Sep 2018 05:43:07 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id i15-v6sm1807356ede.66.2018.09.27.05.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 05:43:05 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id j15-v6so2434658wrt.8;
        Thu, 27 Sep 2018 05:43:05 -0700 (PDT)
X-Received: by 2002:a5d:6b01:: with SMTP id v1-v6mr8568484wrw.208.1538052185004;
 Thu, 27 Sep 2018 05:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com> <20180927114850.24565-5-jagan@amarulasolutions.com>
In-Reply-To: <20180927114850.24565-5-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 27 Sep 2018 20:42:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
Message-ID: <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] drm/sun4i: sun6i_mipi_dsi: Enable missing DSI bus clock
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 27, 2018 at 7:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> DSI bus_clk is already available in sun6i_dsi but missed to
> get the clk and process for enable/disable.
>
> This patch add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 8e9c76febca2..156b371243c6 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>                 return PTR_ERR(dsi->reset);
>         }
>
> +       dsi->bus_clk = devm_clk_get(dev, "bus");
> +       if (IS_ERR(dsi->bus_clk)) {
> +               dev_err(dev, "Couldn't get the DSI bus clock\n");
> +               return PTR_ERR(dsi->bus_clk);
> +       }
> +

The DSI driver uses devm_regmap_init_mmio_clk, which enables the
clock behind the scenes when regmap access needs it enabled.

Did you have any issues without this patch?

ChenYu

>         if (dsi->variant->has_mod_clk) {
>                 dsi->mod_clk = devm_clk_get(dev, "mod");
>                 if (IS_ERR(dsi->mod_clk)) {
> @@ -1012,6 +1018,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       clk_prepare_enable(dsi->bus_clk);
>         /*
>          * In order to operate properly, that clock seems to be always
>          * set to 297MHz.
> @@ -1065,6 +1072,7 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
>         sun6i_dphy_remove(dsi);
>         if (dsi->variant->has_mod_clk)
>                 clk_rate_exclusive_put(dsi->mod_clk);
> +       clk_disable_unprepare(dsi->bus_clk);
>
>         return 0;
>  }
> --
> 2.18.0.321.gffc6fa0e3
>
