Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82AAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7246520BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ts5JaOGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7246520BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeGLNz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:55:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46073 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeGLNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:55:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so30282229oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8mbVf1c6d4yEuFsU1MtNwt7cC8ldpzhEd6/Q0MfR6ec=;
        b=ts5JaOGZk6Coa9fQTRXFW63aF1CYb9Lm9sxWpGeKkvZWK5gGs+rzwmPFxWUljQLzmu
         8RPOj3rDZOzo9GmyWanCGn5X1h//WTvToDP4YnhtBO79jH9wgillmvZz5u7sWAJqZYgk
         Lr6RPQt6bOzcG3knAw/iRT7w2AKvrCVlf1KK3eYNyB+A3uiKVKsazAdtfC5KCDityvNO
         jfbc1zZlKiPjZj6+XBCKlr558i4+JjQ88p3h0qKf4Iu1NZwCYajAP9nmVE62Vg2kN2zk
         qr37MasZ4jACXf3w4AgzjHsGP/l/YjvDUB/4GcipV8t5OP1IkAtW8X2i2gsyzwoDQWld
         DT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8mbVf1c6d4yEuFsU1MtNwt7cC8ldpzhEd6/Q0MfR6ec=;
        b=gaimiB1fRnEbU3uaogaaCKgz+TDqi3SgyHup4fTWK9SSVFfBbpAxksC1VHPNwudMUO
         WVGWWQMhwrr3WZwnd4WA04Bi+1YoIoiKWLu/TLWIj5j3odx43aAgsc9emMIr4A/47S9G
         vpS/8v6tLQr5kTgnvFjWzFFAunigDbOTVPj9nVeanQudtaMn/yfwqoFt47tgKXQ0RSbj
         /+7eHiMqA8ZayDsUAPgWfGspt1WZHCSvzgsJjzl5wy5kq77H4imy7J40tsENAuPT6gRZ
         zi4vZFh+LUElRJCs0zVB1k9V5ANyOtC8NTXfgfbvJtvlbcwYSGG50Eb1SxI4ZIk+rj2I
         4U1Q==
X-Gm-Message-State: AOUpUlGEABXeeSPnkbFnvcRkXf7hcm6KRxU0GvBBvB6Jr9TRBAI42mOK
        Z+WQEMHgR+bcA+cW1tRMVJ0dQxIvl0DKvE+jdWE=
X-Google-Smtp-Source: AAOMgpdzDJZrUjoLlzASkwrrklVOs04/E4vHOzASPoUoR2zGE4PrZS2MV/uT7j2z4sGnioMH+omb6xqvQ64uKvt6UsY=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr2565648oia.69.1531403180273;
 Thu, 12 Jul 2018 06:46:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 06:46:19
 -0700 (PDT)
In-Reply-To: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
References: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Jul 2018 10:46:19 -0300
Message-ID: <CAOMZO5Dek84qTDUHApYhk2RofuqbG6YuKzJ4XRHfOcKLe1nS+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sl: Add vivante gpu nodes
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Marius Vlad <marius-cristian.vlad@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Thu, Jul 12, 2018 at 10:37 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index a6bc21433839..49a56b4fd393 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -130,10 +130,30 @@
>                         cache-level = <2>;
>                         arm,tag-latency = <4 2 3>;
>                         arm,data-latency = <4 2 3>;
>                 };
>
> +               gpu_2d: gpu@2200000 {
> +                       compatible = "vivante,gc";
> +                       reg = <0x02200000 0x4000>;
> +                       interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +                                <&clks IMX6SL_CLK_GPU2D_OVG>;
> +                       clock-names = "bus", "core";
> +                       power-domains = <&pd_pu>;
> +               };
> +
> +               gpu_vg: gpu@2204000 {
> +                       compatible = "vivante,gc";
> +                       reg = <0x02204000 0x4000>;
> +                       interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +                                <&clks IMX6SL_CLK_GPU2D_OVG>;
> +                       clock-names = "bus", "core";
> +                       power-domains = <&pd_pu>;
> +               };
> +
>                 aips1: aips-bus@2000000 {

We try to keep the peripherals sorted by address range in dtsi, so
please put the gpu nodes below aips2.
