Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426A6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E959A26497
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E959A26497
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965360AbeFZDc7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:32:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40447 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965262AbeFZDc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:32:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id m15-v6so68097edr.7;
        Mon, 25 Jun 2018 20:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z+h7fjVPD52USQZSp0AXwSx5bSqpHssxRP6RMrXFQfg=;
        b=laOQGsdxbG63iVlQs2JSw0oA4VysVpnFeGW7wqR4cQX+xolYyWImwRVyLjHHxJuoQp
         ih54IeKpc+jk84JjpinZI9dYc7DHZWkufGt44NPxKAyq5On0dDE94De/KcJ3LtCKFKvY
         8pJLoE1dEl1OGMNEnFLaq+g/ezLJK3yRJGA8TWQ3fDEJk90dlppYSttAf8uaMTbuxlSu
         nTuKGRRGNItBrBqBH9pVQqaxMelbna2O7KS298zd+WJPhhnu1GhLjdvYEP0k7OvLzV+d
         AYwbjAmr4XE6mIWNx7vmrYXLrIER7qVSpnQViS4MSJqJH2vXlrM9E+iSrxrcmNj910Q6
         3Bgg==
X-Gm-Message-State: APt69E2kOQ4Fxo6bQfuHHdjZwKvCgQOSqWmXW/RhDevK8FG7OHiQD0Fy
        3rpun2KUJtfKeO2V54kSHMOWaFqB
X-Google-Smtp-Source: AAOMgpfjzRpgy95UfZjYO8Rw18nyP83WzvYXIHIFoPcTRdAzyltuUbxBa4yuvAy5yp0w82QiCRfZUQ==
X-Received: by 2002:a50:b1f7:: with SMTP id n52-v6mr99726edd.197.1529983975729;
        Mon, 25 Jun 2018 20:32:55 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id w39-v6sm402562edd.45.2018.06.25.20.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 20:32:54 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id z6-v6so14098759wma.0;
        Mon, 25 Jun 2018 20:32:54 -0700 (PDT)
X-Received: by 2002:a1c:581:: with SMTP id 123-v6mr97888wmf.58.1529983974465;
 Mon, 25 Jun 2018 20:32:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 20:32:34
 -0700 (PDT)
In-Reply-To: <20180622124540.56203-5-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io> <20180622124540.56203-5-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 26 Jun 2018 11:32:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v65W5zVGygcYx2CJDOm__Txp-Fjf=38axo=0K4A0g8hb_w@mail.gmail.com>
Message-ID: <CAGb2v65W5zVGygcYx2CJDOm__Txp-Fjf=38axo=0K4A0g8hb_w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 6/7] arm64: allwinner: a64: add device
 tree node for HDMI simplefb
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
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

On Fri, Jun 22, 2018 at 8:45 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> As the U-Boot bootloader now is also capable of initialize the HDMI on
> A64 boards, add a simplefb device tree node for accessing the HDMI
> framebuffer initialized by the bootloader.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

The subject should have "dts" in it, like:

    arm64: dts: allwinner: a64: ....

Seems we've been missing them for half the patches this coming cycle.

ChenYu

> ---
> Changes in v2:
> - Dropped LCD SimpleFB as it's already added. LCD SimpleFB needs some
>   fix but the fix is present when adding DE2 CCU.
>
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 318c4ba8ae9f..840753432ea5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -68,6 +68,15 @@
>                                  <&display_clocks CLK_MIXER0>;
>                         status = "disabled";
>                 };
> +
> +               simplefb_hdmi: framebuffer-hdmi {
> +                       compatible = "allwinner,simple-framebuffer",
> +                                    "simple-framebuffer";
> +                       allwinner,pipeline = "mixer1-lcd1-hdmi";
> +                       clocks = <&display_clocks CLK_MIXER1>,
> +                                <&ccu CLK_TCON1>, <&ccu CLK_HDMI>;
> +                       status = "disabled";
> +               };
>         };
>
>         cpus {
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
