Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7426C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A4242B9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3A4242B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeFVN3o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:29:44 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33218 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbeFVN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:29:42 -0400
Received: by mail-ua0-f194.google.com with SMTP id m21-v6so4289478uan.0;
        Fri, 22 Jun 2018 06:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brv17cAYi9W+9YCvhKMUCNrcwYATZwZOiwB4c6G+enQ=;
        b=Rvnkbc2E0psrPKnlYJM0CFf93ISP5GlSLkqki2uJvpXomJmmzkgAQzOku8IILAKQqV
         EMEGGyAmStJRJ3yKDb/NnJX1dxt/JACo92pmgbKFbtuLA8ZvktOSSO200gPOghEBt4Yj
         r2sxctLPC/IzslJva+aq2aQnQUFTAlICq+HBFUEN17+RLO0Ady44JMP1ZY8sirHfU+4i
         6b7+bGiIn1ETtxtJz1EHXV5HZxETen/ToV1CfsjI7WYcMkoCAclxiNj3y1dsA5lJ5PZo
         oaIZUbbNrO24zO8/WuYKxLtXqsRNc1G893ghssbhWKJixuvmlXoDWySk2V3RzEsB/568
         bbLA==
X-Gm-Message-State: APt69E3+dA5V4lmkIKH/Yi0p/aMRIpKUJLGg1A2uWh/fPQhgj1brRpLU
        F2Vygd3uVSxN4IHG+adloUTRaWvImP7VDpYnE4k=
X-Google-Smtp-Source: AAOMgpf4y/BXL+Use6aExtiYSaaPeLaSAi2xx3xyLiOxGe6qx9tWNn6qwhidczgMTM866tWul385NcFpDymJwWHkRZI=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1064377uae.12.1529674181408;
 Fri, 22 Jun 2018 06:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com> <1528973829-25493-6-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1528973829-25493-6-git-send-email-michel.pollet@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 15:29:30 +0200
Message-ID: <CAMuHMdUin=CjcWvR=nCm9vN-8VWaNXbFt+3k_MUEOmqpKoe2mA@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] clk: renesas: Renesas R9A06G032 clock driver
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Thu, Jun 14, 2018 at 1:03 PM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This provides a clock driver for the Renesas R09A06G032.
> This uses a structure derived from both the RCAR gen2 driver as well as
> the renesas-cpg-mssr driver.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c

> +static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
> +{

[...]

> +       error = of_clk_add_provider(np, of_clk_src_onecell_get, &clocks->data);
> +       if (error)
> +               return error;
> +
> +       error = devm_add_action_or_reset(
> +                       dev, r9a06g032_clocks_del_clk_provider, np);
> +
> +       return error;

This could just be "return devm_add_action_or_reset(...);".

Queuing in clk-renesas-for-v4.19 with the above small change.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
