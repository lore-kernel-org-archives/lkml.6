Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D330BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9676320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PLhR+wSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9676320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeLMW4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:56:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33352 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeLMW4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:56:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so4239470qtp.0;
        Thu, 13 Dec 2018 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYHFtPjv8JQJBGdOBsFRXt5vPUKyqFq0Qftwn/agti4=;
        b=PLhR+wSfzhi2oPcg9PAxCb4AB4yL9BkMmkJCQ/GhC5lCVP8btRUZCBDpH5DP2XaOmF
         NGh3ydXwqxQk+4i9oi2JND/sUXlU6PBLGwZ61uLcVXjXUZPr7yrTsi6qQHNeNtajwuSd
         pB4fA930LJtOe8BZLOiWnmNVpfSgcXDuts/fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYHFtPjv8JQJBGdOBsFRXt5vPUKyqFq0Qftwn/agti4=;
        b=nb21anVOqDnzr0BCDTX+iQw0BvpwU4Eehkz8ItVaVmdTyytZO8MgxpMF+8JBPkGDoM
         p87g4/D5AzOZZPhLQBqahW3MhRWH6y+advaXcl4KEgkkDat83ICMC/SFR2xM6+GdiUse
         Qb+dlPNvW1VKqe0pcGc3/24NyxLspawDySNUWg/mvgbpBwo9d7xnQ+Gwied8zjtESE/E
         68YsS5vYwRsK0m/jCAxJpKTVVcE3w7H12RmkaaKZNJbn0mwMYBGXI33/95nYxChbpSj9
         ZMer6s049+5KycNL3P3n54wwdTtLncMdm8c6lWGg1EKPlubjLgvt5h7gFy5SPUr3s6ca
         yauQ==
X-Gm-Message-State: AA+aEWabwPk39ziGrbtvs82vHKPnc7q1uD/Guzh6Wbf0ZDOgx5qfr3Zd
        Pb4nxeSUxhoFeKZ8E9EpalHK7Mn8vZ8aWqupDbk=
X-Google-Smtp-Source: AFSGD/XWEZGKKSBkptO8BO7oZ2mOY/V1j06P37FgMYeO07l+cUs2I2lrG/mM0lb5S/R9GqJrzL6QcPND2e+pZZMBO7c=
X-Received: by 2002:a0c:89b4:: with SMTP id 49mr652178qvr.85.1544741777010;
 Thu, 13 Dec 2018 14:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
In-Reply-To: <20181213195319.1333402-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 14 Dec 2018 09:26:05 +1030
Message-ID: <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
To:     vijaykhemka@fb.com, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 at 06:23, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added ADC and other sensor devices in Facebook Tiogapass device tree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 33 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index f8e7b71af7e6..58bbe08d3ba7 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -21,6 +21,25 @@
>         memory@80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               oemname0 = "MB_P3V3";
> +               oemname1 = "MB_P5V";
> +               oemname2 = "MB_P12V";
> +               oemname3 = "MB_P1V05";
> +               oemname4 = "MB_PVNN_PCH_STBY";
> +               oemname5 = "MB_P3V3_STBY";
> +               oemname6 = "MB_P5V_STBY";

"oemname" isn't part of the upstream bindings. Is this something you
have patches for?

The other parts of the patch lgtm.

> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +                                       <&adc 4>, <&adc 5>, <&adc 6>;
> +       };
> +
> +       iio-hwmon-battery {
> +               oemname0 = "MB_P3V_BAT";
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 7>;
> +       };
>  };
>
>  &fmc {
> @@ -64,6 +83,10 @@
>         use-ncsi;
>  };
>
> +&adc {
> +       status = "okay";
> +};
> +
>  &i2c0 {
>         status = "okay";
>         //Airmax Conn B, CPU0 PIROM, CPU1 PIROM
> @@ -122,6 +145,10 @@
>
>  &i2c8 {
>         status = "okay";
> +       tmp421@1f {
> +               compatible = "ti,tmp421";
> +               reg = <0x1f>;
> +       };
>         //Mezz Sensor SMBus
>  };
>
> @@ -134,13 +161,15 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +       oemname0 = "System_Fan_Connector_1";
> +       oemname1 = "System_Fan_Connector_3";
>         fan@0 {
>                 reg = <0x00>;
>                 aspeed,fan-tach-ch = /bits/ 8 <0x00>;
>         };
>
>         fan@1 {
> -               reg = <0x00>;
> -               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
>         };
>  };
> --
> 2.17.1
>
