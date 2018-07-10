Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEC5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDE2208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDE2208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeGJOxF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:53:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37227 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:53:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so16791411edq.4;
        Tue, 10 Jul 2018 07:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jk30uSDXIIcEdGbxinovusH04dLyMW7GcRxb7on3fvA=;
        b=sGeifRY73aBB0HW+rTz6RTkeR1N+2ySIKNAuIESwFsAd6AHFtcEbD6YHhuPCeJlJt+
         otfxfwi9X3KDj/J5AOQHZfLqHIZyZRttS8n3gc92Mtzw2PnOsIEe054WT96bL9N580VK
         k160x/NuofSLDOf1cMur7V5M7hJqnFrJ30LhKxzXwCWqvJ4zM7Cv4yee1HCom03sC5Id
         vZ281H9y6XnKlZj8X8kJSVKPAbMbiZJIhBh3gNCyJmDC9O5RWG87UNugYtxWhY7WVU/N
         jDqrjQ5PUlwANEYLwHr+mozqirqCEE6NXMetWGXe4CfKzvMYXQND98aje1QXf2RCDaZ1
         QNhQ==
X-Gm-Message-State: APt69E0RS73Kv4hgmfPeTMoeIB2c1XUydHsOc37pDWEAf4mdylR5rzpv
        u+Rpn9jMQYI6H34+XHba/+qFJCxCbEg=
X-Google-Smtp-Source: AAOMgpfKpEur6J/9f0MHJf4+Yv8YGptsc/hktGv5X37etcBzI5b8qXhGAID1s+rR5bH9Ff3SSLiqgg==
X-Received: by 2002:aa7:d0d8:: with SMTP id u24-v6mr14826014edo.144.1531234380796;
        Tue, 10 Jul 2018 07:53:00 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id 33-v6sm1640083edy.82.2018.07.10.07.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:53:00 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id b15-v6so14956890wrv.10;
        Tue, 10 Jul 2018 07:53:00 -0700 (PDT)
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr17590496wrh.148.1531234379902;
 Tue, 10 Jul 2018 07:52:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:52:39
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-9-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-9-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:52:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v65JP8fBvD6Sbexjg2cv5AXVufWxjMVuOPa7J1A9qQjZ2g@mail.gmail.com>
Message-ID: <CAGb2v65JP8fBvD6Sbexjg2cv5AXVufWxjMVuOPa7J1A9qQjZ2g@mail.gmail.com>
Subject: Re: [PATCH v5 08/22] ARM: dts: sun4i-a10: Use system-control compatible
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

On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

Subject prefix should be "ARM: dts: sun4i:"

We don't need the "a10" part since the A10 owns into this category
all by itself.

Also, it doesn't say what the system control compatible is for.
"Switch to new system control compatible string" would be slightly
better.

> This switches the sun4i-a10 dtsi to use the new compatible for the
> system-control block (previously named SRAM controller) instead of
> the deprecated one.
>
> The phandle is also updated to reflect the fact that the controller

The label actually.

ChenYu

> described is really about system control rather than SRAM control.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 3a1c6b45c9a1..82f81f06f201 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -190,8 +190,8 @@
>                 #size-cells = <1>;
>                 ranges;
>
> -               sram-controller@1c00000 {
> -                       compatible = "allwinner,sun4i-a10-sram-controller";
> +               system-control@1c00000 {
> +                       compatible = "allwinner,sun4i-a10-system-control";
>                         reg = <0x01c00000 0x30>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> --
> 2.17.1
>
