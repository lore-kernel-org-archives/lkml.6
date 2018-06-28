Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E24C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CFF258DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CFF258DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeF1CUV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:20:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35587 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbeF1CUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:20:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so4201623edt.2;
        Wed, 27 Jun 2018 19:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cuLoFg0eboDcDwbq1T+5vhnRcfKLauFYSogu3TdnxqA=;
        b=gEsVTUNevMKf/3LPziHX1qgqCkpK8AUuO/Od/Ohlf+uMaDqL5ROOJqrMyjA4a2EazA
         SDT33+8YkMFzX6FuEIQeKYKJTGcn/lidZ77hmXu1PhBGnjriGAddrCzdEcAiVduy3IEG
         a9TI2Y1EIwOdizQSEHgkcte0++TL3mc4orcLNWTNElCTGHshl++PmFNe0nSyra6EGHIG
         XodbQZwv1DsZ7/OE7OClqMhJ/nbpZ+hjhW2cemZFH5vpWifma54z47W3heKA9gFk4Nvh
         8pyYEo0MwGx5RFgCFwEWFsCXRfDT5PrIh5QDQznq5eHpraCAlmRiY9LI2B2dXUhzeL/y
         wI4g==
X-Gm-Message-State: APt69E39Gz/BeOTUz9FNkJXT4n6BsKNzz+xkIyubBvPubM1KgxbZrs4G
        zKPVdbAotXnw8zboFA9Sd9pzDt6L
X-Google-Smtp-Source: AAOMgpc4dRq/R54jW9L1W0TJgKzoGF8oEtl5a06AhPqb2G/wemGbyFJKMJaXbSMSwk53WYLe8R/eEA==
X-Received: by 2002:a50:d1c1:: with SMTP id i1-v6mr7717263edg.122.1530152417133;
        Wed, 27 Jun 2018 19:20:17 -0700 (PDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com. [74.125.82.46])
        by smtp.gmail.com with ESMTPSA id b20-v6sm1943218edr.26.2018.06.27.19.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:20:16 -0700 (PDT)
Received: by mail-wm0-f46.google.com with SMTP id l15-v6so19433060wmc.1;
        Wed, 27 Jun 2018 19:20:16 -0700 (PDT)
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr6451762wmd.116.1530152416301;
 Wed, 27 Jun 2018 19:20:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:19:55
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-16-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-16-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:19:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ytOrjMOK067URknens34jvYxJ1XoYmGMi4Ji0LYt9sQ@mail.gmail.com>
Message-ID: <CAGb2v66ytOrjMOK067URknens34jvYxJ1XoYmGMi4Ji0LYt9sQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/24] dt-bindings: display: sun4i-drm: Add description
 of A64 HDMI PHY
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
> clock parents. It is compatible to other HDMI PHYs, like that found in
> R40.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 84fe38dbb900..dc83f21ef188 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -101,6 +101,7 @@ DWC HDMI PHY
>
>  Required properties:
>    - compatible: value must be one of:
> +    * allwinner,sun50i-a64-hdmi-phy
>      * allwinner,sun8i-a83t-hdmi-phy
>      * allwinner,sun8i-h3-hdmi-phy

Nit: the list is sorted by family first, then SoC name, so it should
be the last on the list.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>    - reg: base address and size of memory-mapped region
> @@ -111,8 +112,9 @@ Required properties:
>    - resets: phandle to the reset controller driving the PHY
>    - reset-names: must be "phy"
>
> -H3 HDMI PHY requires additional clock:
> +H3 and A64 HDMI PHY require additional clocks:
>    - pll-0: parent of phy clock
> +  - pll-1: second possible phy clock parent (A64 only)
>
>  TV Encoder
>  ----------
> --
> 2.18.0
>
