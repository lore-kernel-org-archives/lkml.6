Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3E208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF3E208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeGJPCQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:02:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43969 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbeGJPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:02:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id u11-v6so16804552eds.10;
        Tue, 10 Jul 2018 08:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DbEgON8kVKpLMh5AFZq1Ud4Wjo/eM6wJle1h5v83A5E=;
        b=AOVNzM7+hCsyP20wGX1fFTaXdeeQvsJNfYtQr7r7tRAi59W+mAfOMzXG9Tyh+nxvlq
         ckgsdRKiEDu4V/jB1TvYD2vFq5ksP7on9st/ha7eAw0BXQ/HoHFho+tDk9ucezgUVoy/
         7MH+pkP9aA36YkQP+J9jhUtEn3LuvhMII9N4XpVWyxZUyc7WCGjMQKVIzBKuYpwe7ArV
         J4yLKwownDfYAgptommQkKIouYKWZPZv5RbEj1sRjGWwfIplSHMBmVV69j4DyzGgIgcF
         2IN7kByqJKlPS59QOjxNMYbUIbdvBcAHbDdiBG/N8wdZG4ynasjDR/GsSBB3bOQVCm1Z
         tCHQ==
X-Gm-Message-State: APt69E1jrXoKYq34HOGyhYnl09fpIVY/dbsP5yKvomO7IuLxs/F7AoT2
        Ppg5CW8hMofZP/Ja2K03gmnD/kJUhHY=
X-Google-Smtp-Source: AAOMgpfz9x/DSkUXLOQV2UAzU9Mhc3f5mYfRjLhw4+l3G4mmP5hs8fwO62gqaSosGvE8m+XH+2aABg==
X-Received: by 2002:a50:9662:: with SMTP id y89-v6mr27786207eda.32.1531234932960;
        Tue, 10 Jul 2018 08:02:12 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id y89-v6sm8226145edy.80.2018.07.10.08.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:02:12 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id z6-v6so13815912wma.0;
        Tue, 10 Jul 2018 08:02:12 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr15690178wma.143.1531234444936;
 Tue, 10 Jul 2018 07:54:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:53:44
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-10-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-10-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:53:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HbpvJhy5KQOepc61nU7NECaWMPvhZ16dk5hJXiPBHxA@mail.gmail.com>
Message-ID: <CAGb2v64HbpvJhy5KQOepc61nU7NECaWMPvhZ16dk5hJXiPBHxA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/22] ARM: dts: sun5i: Use
 most-qualified system control compatibles
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
> This switches the sun5i dtsi to use the most qualified compatibles for
> the system-control block (previously named SRAM controller) as well as
> the SRAM blocks. The sun4i-a10 compatibles are kept since these hardware
> blocks are backward-compatible.

Not quite sure why they are backward-compatible. The A13 has less SRAM
mapping controls than the A10.

ChenYu

> The phandle for system control is also updated to reflect the fact that
> the controller described is really about system control rather than SRAM
> control.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun5i.dtsi | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 07f2248ed5f8..68711954c293 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -114,8 +114,9 @@
>                 #size-cells = <1>;
>                 ranges;
>
> -               sram-controller@1c00000 {
> -                       compatible = "allwinner,sun4i-a10-sram-controller";
> +               system-control@1c00000 {
> +                       compatible = "allwinner,sun5i-a13-system-control",
> +                                    "allwinner,sun4i-a10-system-control";
>                         reg = <0x01c00000 0x30>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> @@ -130,7 +131,8 @@
>                         };
>
>                         emac_sram: sram-section@8000 {
> -                               compatible = "allwinner,sun4i-a10-sram-a3-a4";
> +                               compatible = "allwinner,sun5i-a13-sram-a3-a4",
> +                                            "allwinner,sun4i-a10-sram-a3-a4";
>                                 reg = <0x8000 0x4000>;
>                                 status = "disabled";
>                         };
> @@ -143,7 +145,8 @@
>                                 ranges = <0 0x00010000 0x1000>;
>
>                                 otg_sram: sram-section@0 {
> -                                       compatible = "allwinner,sun4i-a10-sram-d";
> +                                       compatible = "allwinner,sun5i-a13-sram-d",
> +                                                    "allwinner,sun4i-a10-sram-d";
>                                         reg = <0x0000 0x1000>;
>                                         status = "disabled";
>                                 };
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
