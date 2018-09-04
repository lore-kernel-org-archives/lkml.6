Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0394C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948CD2086E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948CD2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIDNXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:23:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37033 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeIDNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:23:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20-v6so2630703edd.4;
        Tue, 04 Sep 2018 01:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxFTHqKbM+qYBbOfpsqejYWeH7+d56f2up+3k4bccjQ=;
        b=HmWtuYNeBwbCJyUxSyEHiE8OdgH/MSRRR+G1F5kB4nVsUNSL8LSgCfwO9lm8gd5R/5
         E3n14wLGEPEmtCo8IKnoX1yvIbh11mn2ENt9JPa/hNyBO6uJbVCYUAaAlG9xdEJPcL+K
         cLk6A10LGvow1Bohl3WZLdGC2E0XuuVXO07RsxhoszM6sipjQVA553MbyNpgt6rc0Ghe
         MGt82KOGmH+Tp3MgSDlS7fNw0OTePaJEJ5kEeONzxNjTwrB3H1slXgKg7RhNTBSGN63C
         WMOLHHrqCc67fKAJAwKaQLo1anLWpzkjFilS2p3+07kpKQBsK2Ha1ZEAMy55UmWX3CE5
         moKA==
X-Gm-Message-State: APzg51C6BYaxwbsrN1lw0pvHxJEJV7IZylOgbiu7oQFE6SUT1LttQH5i
        n8EXWqzjP6ZCaMaNhYTJjHtVbNMu8Vo=
X-Google-Smtp-Source: ANB0VdZpmAmT480Bqcdd6NC21MkZKuE30uTxhgEehIsDNeswezMlOIqW0pF/af+90ZXHRnISjfwUkw==
X-Received: by 2002:a50:b107:: with SMTP id k7-v6mr34108591edd.310.1536051557616;
        Tue, 04 Sep 2018 01:59:17 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id d12-v6sm10521577ede.78.2018.09.04.01.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 01:59:17 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id m27-v6so3106836wrf.3;
        Tue, 04 Sep 2018 01:59:17 -0700 (PDT)
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr2574199wrc.119.1536051556836;
 Tue, 04 Sep 2018 01:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-8-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-8-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Sep 2018 16:59:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v65AsKzEH3AgmQi+RRvVa6AO-cpAckGnNkvWwONsCCsoxw@mail.gmail.com>
Message-ID: <CAGb2v65AsKzEH3AgmQi+RRvVa6AO-cpAckGnNkvWwONsCCsoxw@mail.gmail.com>
Subject: Re: [PATCH 07/27] dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
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

Hi,

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> This commit adds necessary description and dt includes for H6 DE3 clock.
> It is very similar to others, but memory region has some additional
> registers not found in DE2.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++--
>  include/dt-bindings/clock/sun8i-de2.h                 | 3 +++
>  include/dt-bindings/reset/sun8i-de2.h                 | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> index e94582e8b8a9..41a52c2acffd 100644
> --- a/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> +++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> @@ -1,5 +1,5 @@
> -Allwinner Display Engine 2.0 Clock Control Binding
> ---------------------------------------------------
> +Allwinner Display Engine 2.0/3.0 Clock Control Binding
> +------------------------------------------------------
>
>  Required properties :
>  - compatible: must contain one of the following compatibles:
> @@ -8,6 +8,7 @@ Required properties :
>                 - "allwinner,sun8i-v3s-de2-clk"
>                 - "allwinner,sun50i-a64-de2-clk"
>                 - "allwinner,sun50i-h5-de2-clk"
> +               - "allwinner,sun50i-h6-de3-clk"
>
>  - reg: Must contain the registers base address and length
>  - clocks: phandle to the clocks feeding the display engine subsystem.
> diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
> index 3bed63b524aa..7768f73b051e 100644
> --- a/include/dt-bindings/clock/sun8i-de2.h
> +++ b/include/dt-bindings/clock/sun8i-de2.h
> @@ -15,4 +15,7 @@
>  #define CLK_MIXER1             7
>  #define CLK_WB                 8
>
> +#define CLK_BUS_ROT            9
> +#define CLK_ROT                        10
> +
>  #endif /* _DT_BINDINGS_CLOCK_SUN8I_DE2_H_ */
> diff --git a/include/dt-bindings/reset/sun8i-de2.h b/include/dt-bindings/reset/sun8i-de2.h
> index 9526017432f0..1c36a6ac86d6 100644
> --- a/include/dt-bindings/reset/sun8i-de2.h
> +++ b/include/dt-bindings/reset/sun8i-de2.h
> @@ -10,5 +10,6 @@
>  #define RST_MIXER0     0
>  #define RST_MIXER1     1
>  #define RST_WB         2
> +#define RST_ROT                3

Looking at the DE 2.0 register guide, the "Rotate" related fields are also
found on the A83T. So this is not DE 3.0 specific. And you could also have
the H6 DE3 compatible fall back to the A83T for the common parts.

ChenYu

>
>  #endif /* _DT_BINDINGS_RESET_SUN8I_DE2_H_ */
> --
> 2.18.0
>
