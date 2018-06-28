Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CA4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A825663
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69A825663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeF1Cvg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:51:36 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:39851 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeF1Cve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:51:34 -0400
Received: by mail-ed1-f50.google.com with SMTP id w14-v6so4219584eds.6;
        Wed, 27 Jun 2018 19:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9exk7gWEOGD7PgIAGo87g6p65P4t78WKrr3EacH3lFU=;
        b=Rq6/esAeykaVQo1z2Km7QTGgLsFll2TqCQSgAVEa+s3REANS96tCUH4/yAZ9RoP5qT
         wNT53Z/A1ZXvYkhHVZbfpKRb89Bwcte622WfPYvpsw5DlHF5Kt+EumAi0YO05X+/Ht6F
         H6bFzn78BNcvv4Thh96zLxTKiMCvgFlmq9WqckRe1gxq5Yioem726xUEFEJNhbX2VjpO
         p3P5TuGJ8K3BT9fWS2m6TH6N5SH4+0gXD8bNuodZccfDSctvINhbt2J82YNcYo11cSKG
         PK1tn0CMPAKb56+Q4tQpf4mip9mLhtSSo0oCvdgLzYEqM5quVLhV1bzlRpqfk+5ZKOLM
         AwNQ==
X-Gm-Message-State: APt69E14x+rf41llNPTFszEV0v/zmo3mrcVUlnLFZhNFTJ5n7e0nsafE
        N9zn/ljnxAR6CbRNo/PCpfHjlVel
X-Google-Smtp-Source: AAOMgpeiJo2m/Lfa+9cKGV/Ak8dPm5aLCnn/8DvtJG3sSlWws5UbZPNpHGeLYjYF7+UXnfgHnriLvw==
X-Received: by 2002:a50:aa8c:: with SMTP id q12-v6mr7648042edc.64.1530154292432;
        Wed, 27 Jun 2018 19:51:32 -0700 (PDT)
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id l8-v6sm1627715eda.67.2018.06.27.19.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:51:32 -0700 (PDT)
Received: by mail-wr0-f173.google.com with SMTP id f16-v6so3870636wrm.3;
        Wed, 27 Jun 2018 19:51:32 -0700 (PDT)
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr6972453wrc.19.1530154291939;
 Wed, 27 Jun 2018 19:51:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:51:11
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-25-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-25-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:51:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v65AE4N6Jabo5co3nu+eitYoJwmakqU7QQtcYukG6JLY+w@mail.gmail.com>
Message-ID: <CAGb2v65AE4N6Jabo5co3nu+eitYoJwmakqU7QQtcYukG6JLY+w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 24/24] ARM: dts: sun8i: r40: Enable HDMI
 output on BananaPi M2 Ultra
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

On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Since HDMI can be considered as main output, most capable mixer is
> connected to it (mixer0).
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 27d9ccd0ef2f..0ebc2f9a980e 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -58,6 +58,17 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       connector {
> +               compatible = "hdmi-connector";
> +               type = "a";
> +
> +               port {
> +                       hdmi_con_in: endpoint {
> +                               remote-endpoint = <&hdmi_out_con>;
> +                       };
> +               };
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>
> @@ -93,6 +104,10 @@
>         };
>  };
>
> +&de {
> +       status = "okay";
> +};
> +
>  &ehci1 {
>         status = "okay";
>  };
> @@ -101,6 +116,16 @@
>         status = "okay";
>  };
>
> +&hdmi {
> +       status = "okay";
> +};
> +
> +&hdmi_out {
> +       hdmi_out_con: endpoint {
> +               remote-endpoint = <&hdmi_con_in>;
> +       };
> +};
> +
>  &i2c0 {
>         status = "okay";
>
> @@ -195,6 +220,26 @@
>         status = "okay";
>  };
>
> +&tcon_top_hdmi_in_tcon_tv0 {
> +       remote-endpoint = <&tcon_tv0_out_tcon_top>;
> +};
> +
> +&tcon_top_mixer0_out_tcon_tv0 {
> +       remote-endpoint = <&tcon_tv0_in_tcon_top>;
> +};
> +
> +&tcon_tv0_in {
> +       tcon_tv0_in_tcon_top: endpoint {
> +               remote-endpoint = <&tcon_top_mixer0_out_tcon_tv0>;
> +       };
> +};
> +
> +&tcon_tv0_out {
> +       tcon_tv0_out_tcon_top: endpoint {
> +               remote-endpoint = <&tcon_top_hdmi_in_tcon_tv0>;
> +       };
> +};
> +

This is the wrong place for this. Once removed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
