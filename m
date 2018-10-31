Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520DECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47982082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47982082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeJaLUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:20:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38651 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbeJaLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:20:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so12300108ede.5;
        Tue, 30 Oct 2018 19:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qisjhRzqYftCgGXLPIeSirkSfWPEJ3OepZwWig78/Bc=;
        b=jQUFmmT5FOJLhz/aD1EJCJ6Oxp2NZc/2VPLsYha8qeQtft2y9QsXUQnnR7F+NiLWBG
         ZbcQ8gElhR2stgmsCKCUdwRRICzpowpWh1vi2DQkRC4jXqWVcrsrW1eSk+teIPz3dhzt
         zbBNdcCquaVe41b/+VGDh5tSYwQPOsCChs/IUWB5cM7JMm0xMT4WwJ2yCUyNAzhGs2Wa
         BlH84FVzWQTFStjaM9wjnWG22v8UYIA5YijUKLrAZ9kU5/WDNOxNUBZS7pLv96MVi93e
         sk2PMUfJndNTGB2IFnViaL7byg3CbHrt8njsbmIfKMMI/xTW1aKR6B2I5LqEsL5VT+25
         24bw==
X-Gm-Message-State: AGRZ1gLYm4MU0KP2PzSxNtegRkbCap0vF2OofRW3YJQDs0707rj4piTn
        na8/aSnC1dcdB6gYKSt2YUIM43QvTfU=
X-Google-Smtp-Source: AJdET5csxfhohntJ1U/4DiuCQ/zKp+l662vuSsLvSZrQwQQvV2WoszXOiuZRsiiIDQAWN33B8dyjMA==
X-Received: by 2002:a50:a8a2:: with SMTP id k31-v6mr606871edc.192.1540952686432;
        Tue, 30 Oct 2018 19:24:46 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id b2-v6sm6464656edy.52.2018.10.30.19.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 19:24:46 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id w5-v6so14746491wrt.2;
        Tue, 30 Oct 2018 19:24:45 -0700 (PDT)
X-Received: by 2002:adf:e307:: with SMTP id b7-v6mr988673wrj.91.1540952685177;
 Tue, 30 Oct 2018 19:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com> <20181026144344.27778-23-jagan@amarulasolutions.com>
In-Reply-To: <20181026144344.27778-23-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 10:24:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v65a-+-U74QWBvHLJ9e+_dWY3Cy+h9CfAFHqmFnB0GmcBw@mail.gmail.com>
Message-ID: <CAGb2v65a-+-U74QWBvHLJ9e+_dWY3Cy+h9CfAFHqmFnB0GmcBw@mail.gmail.com>
Subject: Re: [PATCH v3 22/25] dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
> on the one on A31.
>
> Add A64 compatible and append A31 compatible as fallback.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> Changes for v2:
> - new patch
>
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> index 9fa6e7a758ad..704fb31962f2 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -36,7 +36,7 @@ D-PHY
>
>  Required properties:
>    - compatible: value must be one of:
> -    * allwinner,sun6i-a31-mipi-dphy
> +    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"

The format for this is one "combination" per line. You need to keep the
original "allwinner,sun6i-a31-mipi-dphy".

ChenYu

>    - reg: base address and size of memory-mapped region
>    - clocks: phandles to the clocks feeding the DSI encoder
>      * bus: the DSI interface clock
> --
> 2.18.0.321.gffc6fa0e3
>
