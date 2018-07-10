Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E06BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33673208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33673208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934218AbeGJP1F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:27:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35018 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGJP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:27:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so16868210edi.2;
        Tue, 10 Jul 2018 08:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B0uhORn1bgf/unxhpeurmbejlvWz3hCxfYGcrnxfQkE=;
        b=RbCUnNRU5HKyiCSvj54M4gYXYyA6zgnmVYYC7VGwkdJeQfHr6poYieO3fE3MCAQgMk
         AEu7hOggrwcpLI9wAJD2QpFMr9eTMNPdbowyn4j+6s1X6jCZuPCJk+K/eTjCf1/qjscx
         SpZ2Maf+R/OBkZjkGorwlLmp1vRKxj1Mt5k3+kCbRnOf4ssu5NxiT/tDerhRP4tV9htM
         5q7yRY4ghzDIwH7MrvP7CXKICKkFBj5UsorYE98d/4m47b1MxytHvK1AwINJzXR3NuiR
         Hj2bZDx1YvDBsX9ABAmUKGYLoLqEtyGDqlTzQxBip9B2s6AZ/HcLcc1WOcqPS71K2YRZ
         x94w==
X-Gm-Message-State: APt69E1aaHFAKzCCOVK/h4udnxkHWea5WPDFgw9v9NHyRfPbSM8ot51m
        /p/Pam/onQvQlHnIA7Db3XKA7iqL
X-Google-Smtp-Source: AAOMgpcWvT45EWXM4YusngCsMhf4bQLP3nRm+1vH3MD+IvhAdfAQkTGsl0frXd9KLWPHJzDtbTMEEw==
X-Received: by 2002:a50:99db:: with SMTP id n27-v6mr7180192edb.111.1531236422076;
        Tue, 10 Jul 2018 08:27:02 -0700 (PDT)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id d11-v6sm7448743edr.24.2018.07.10.08.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:27:00 -0700 (PDT)
Received: by mail-wm0-f48.google.com with SMTP id h20-v6so8881435wmb.4;
        Tue, 10 Jul 2018 08:27:00 -0700 (PDT)
X-Received: by 2002:a1c:ee9a:: with SMTP id j26-v6mr14033757wmi.116.1531236420457;
 Tue, 10 Jul 2018 08:27:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:26:39
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-7-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-7-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:26:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64AOe6p6m5=FhmDtYi5ebGHAv+3cPR9G=wZudQMohz2Zw@mail.gmail.com>
Message-ID: <CAGb2v64AOe6p6m5=FhmDtYi5ebGHAv+3cPR9G=wZudQMohz2Zw@mail.gmail.com>
Subject: Re: [PATCH 06/17] dt-bindings: display: sun4i-drm: Add R40 TV TCON description
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> TCON description is expanded with R40 TV TCON compatible. It is a bit
> special, because it is connected to TCON TOP instead directly to mixer
> and it needs special handling.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 288b4cbc255e..7e2451396a28 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -147,6 +147,7 @@ Required properties:
>     * allwinner,sun8i-a33-tcon
>     * allwinner,sun8i-a83t-tcon-lcd
>     * allwinner,sun8i-a83t-tcon-tv
> +   * allwinner,sun8i-r40-tcon-tv
>     * allwinner,sun8i-v3s-tcon
>     * allwinner,sun9i-a80-tcon-lcd
>     * allwinner,sun9i-a80-tcon-tv
> @@ -181,7 +182,7 @@ For TCONs with channel 0, there is one more clock required:
>  For TCONs with channel 1, there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1
>
> -When TCON support LVDS (all TCONs except TV TCON on A83T and those found
> +When TCON support LVDS (all TCONs except TV TCONs on A83T, R40 and those found
>  in A13, H3, H5 and V3s SoCs), you need one more reset line:

I think this line is getting more convoluted as we add more exceptions.
We may want to reword it somehow.

>     - 'lvds': The reset line driving the LVDS logic
>
> --
> 2.18.0
>
