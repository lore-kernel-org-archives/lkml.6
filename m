Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD16C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5631A2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5631A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933898AbeGJOrd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:47:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38865 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933256AbeGJOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:47:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id t2-v6so2175122edr.5;
        Tue, 10 Jul 2018 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a4jfhzE4kpQaL1P6cyBArl58uZSwK/Q4anUEWZSANOI=;
        b=fiB2GwZMZsqNDvd8W+zPncV3ojpLXwR2uhk+05JD6zEX/ixIzE9+WWI+Tw7f/7pSuX
         sy6gszA2kdeUVNQbw+St+1uN5OgVLYF57ooEQJ1tK/M0faR6tZYrya+S6kRwqf6BlW/4
         Wa7MN4oymhM2rS4K6ZxUskHNCZWKI2sk9k/ylvg41a87wB9o8UbFdD4sKSIxXcGP+rE1
         QGO2aiigd6+9t5k6AnbD/U17t4XXfC6EEmoT5C5vV4FXv5mIAiBIOu04SrkUjq1UcZ6L
         URekuAADm8/6trAdpViYj1wNcDW5lFfmwmXqNJckyymW6dkhbUjlRgpGzN2OsxQ2Lfaf
         2kjQ==
X-Gm-Message-State: APt69E3OIknp2yt+8MTg1Xl3oNw21VaioloI834XuCQLUUEGE7YHSVY5
        9gpjUeLNYvdhzfm6H41u3j0cFyEV6i8=
X-Google-Smtp-Source: AAOMgpdmCiF4/sEki2J93IkOY+Ix73SsSRY2BiSn2GTgeQzi7CfKa76rjEIsRiU+LuIER/C2EXkukw==
X-Received: by 2002:aa7:d918:: with SMTP id a24-v6mr26411488edr.109.1531234048859;
        Tue, 10 Jul 2018 07:47:28 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g9-v6sm6293084edq.34.2018.07.10.07.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:47:28 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id r16-v6so14931860wrt.11;
        Tue, 10 Jul 2018 07:47:28 -0700 (PDT)
X-Received: by 2002:adf:e90c:: with SMTP id f12-v6mr17703902wrm.126.1531234047930;
 Tue, 10 Jul 2018 07:47:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:47:07
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-6-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-6-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:47:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Na1Mq0=-z5Haq=sgggRPHNHVZ-6fFczxb3EESAzZ=XA@mail.gmail.com>
Message-ID: <CAGb2v64Na1Mq0=-z5Haq=sgggRPHNHVZ-6fFczxb3EESAzZ=XA@mail.gmail.com>
Subject: Re: [PATCH v5 05/22] dt-bindings: sram: sunxi: Populate valid
 sections compatibles
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pawel Osciak <posciak@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 4:00 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> This adds a list of valid SRAM sections compatibles for the A13, A20,
> A23 and H3 platforms. Per-platform compatibles are introduced for the
> SRAM sections of these platforms, with the A10 compatibles also listed
> as valid when applicable.
>
> In particular, compatibles for the C1 SRAM section are introduced.

You should probably mention that this is not an exhaustive list. In
particular, the C2 and C3 (sun5i) mappings are still missing.

>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../devicetree/bindings/sram/sunxi-sram.txt   | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> index 156a02ab6b54..07c53c5214a0 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -32,8 +32,33 @@ once again the representation described in the mmio-sram binding.
>
>  The valid sections compatible for A10 are:
>      - allwinner,sun4i-a10-sram-a3-a4
> +    - allwinner,sun4i-a10-sram-c1
>      - allwinner,sun4i-a10-sram-d
>
> +The valid sections compatible for A13 are:
> +    - allwinner,sun5i-a13-sram-a3-a4
> +    - allwinner,sun4i-a10-sram-a3-a4
> +    - allwinner,sun5i-a13-sram-c1
> +    - allwinner,sun4i-a10-sram-c1
> +    - allwinner,sun5i-a13-sram-d
> +    - allwinner,sun4i-a10-sram-d
> +
> +The valid sections compatible for A20 are:
> +    - allwinner,sun7i-a20-sram-a3-a4
> +    - allwinner,sun4i-a10-sram-a3-a4
> +    - allwinner,sun7i-a20-sram-c1
> +    - allwinner,sun4i-a10-sram-c1
> +    - allwinner,sun7i-a20-sram-d
> +    - allwinner,sun4i-a10-sram-d
> +
> +The valid sections compatible for A23/A33 are:
> +    - allwinner,sun8i-a23-sram-c1
> +    - allwinner,sun4i-a10-sram-c1
> +
> +The valid sections compatible for H3 are:
> +    - allwinner,sun8i-h3-sram-c1
> +    - allwinner,sun4i-a10-sram-c1

I'm not quite sure why we want to list these... I think it makes more sense
to just have the SoC specific compatible. They are tied to the controls
after all. Maybe Rob has a different opinion?

ChenYu

> +
>  The valid sections compatible for A64 are:
>      - allwinner,sun50i-a64-sram-c
>
> --
> 2.17.1
>
