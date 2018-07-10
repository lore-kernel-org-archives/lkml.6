Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67413C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284CE208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284CE208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934137AbeGJPgU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:36:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36811 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933475AbeGJPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:36:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so16893417eds.3;
        Tue, 10 Jul 2018 08:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J2SeNWct7GmDmL5hAA/YV+NlfJuYT1WoW5dNj7f9oFs=;
        b=b52lYv0qzfzIe5lOW2DuByR130nUTwXJXo5Ahi3FKrX4JUFVtZmR6IZBpmkioR58sq
         SVKTEKuvhVkJQxb623+kVgxsZ2vCwAr/9qxMZ7rySwiYjo715NmThSrM1aCfogCnyFRM
         cZRzuj5GzaSe3F5m6BQbf2vGIBd0gFSHZATB985Wvo/PBSdzfgR+RdFlTtGr/72z1P0J
         WePtD5ILR1NIifsQhq8KQfrACzL1qJGYGqoPSAv3AtKQ9K1qQrwt2qZZnWRbQZb4BzFO
         ci554hXJBki1KFnBS8ppuXMDGtem0DDpDVprlInccrSBaiSbmBzmiHYMOJzcOgBjsbEM
         +oOw==
X-Gm-Message-State: APt69E0gLYZ9mJzb0mU0HdYSkrHonh4JatTCfW014sacXIMO0z8fJXdD
        NI92hPWB4jv0/bXp2Jff3mepWUoo
X-Google-Smtp-Source: AAOMgpdlHbanB3HPqvM7R9/8ONPh1VA2/EutQorKIIQOVieFxat7PqrU5L1P7tLx37HNQUkl5sBP6Q==
X-Received: by 2002:a50:aec9:: with SMTP id f9-v6mr27276414edd.72.1531236977560;
        Tue, 10 Jul 2018 08:36:17 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id o2-v6sm8100553edd.84.2018.07.10.08.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:36:15 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id p1-v6so15097170wrs.9;
        Tue, 10 Jul 2018 08:36:15 -0700 (PDT)
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr17602642wra.19.1531236975065;
 Tue, 10 Jul 2018 08:36:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:35:54
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-9-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-9-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:35:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v65YsW+SiP6_sV9Hd6eQE6ZF0+Lm6CWfNdmwpgMEHBTDgQ@mail.gmail.com>
Message-ID: <CAGb2v65YsW+SiP6_sV9Hd6eQE6ZF0+Lm6CWfNdmwpgMEHBTDgQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
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
> Mixer has to have a way to read its id, if needed.

You should mention that this is required by the device tree binding sun4i-drm,
in the second paragraph of the first section:

    For all connections between components up to the TCONs in the display
    pipeline, when there are multiple components of the same type at the
    same depth, the local endpoint ID must be the same as the remote
    component's index.

You might also want to update the diagram for TCON TOP in the binding doc.

ChenYu

> Add them in R40 DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 2afb079a3776..1dd088d82773 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -576,9 +576,12 @@
>                                 #size-cells = <0>;
>
>                                 tcon_top_mixer0_in: port@0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                         reg = <0>;
>
> -                                       tcon_top_mixer0_in_mixer0: endpoint {
> +                                       tcon_top_mixer0_in_mixer0: endpoint@0 {
> +                                               reg = <0>;
>                                                 remote-endpoint = <&mixer0_out_tcon_top>;
>                                         };
>                                 };
> @@ -606,9 +609,12 @@
>                                 };
>
>                                 tcon_top_mixer1_in: port@2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                         reg = <2>;
>
> -                                       tcon_top_mixer1_in_mixer1: endpoint {
> +                                       tcon_top_mixer1_in_mixer1: endpoint@1 {
> +                                               reg = <1>;
>                                                 remote-endpoint = <&mixer1_out_tcon_top>;
>                                         };
>                                 };
> --
> 2.18.0
>
