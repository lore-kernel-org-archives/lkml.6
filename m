Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD76C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B135C2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z3ZCsZrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfACQEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:04:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54493 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfACQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:04:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so29703268wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=WJAQvMs1Q0JN1b84t4wRcxNWwOJ+O3BW6vUmppGF/AY=;
        b=z3ZCsZrQDcEIzAIG8LechOUoUaDZcaOYNfECx4T0WAavtUc94kAfJJYdPwjczxEh/h
         1DIAb6ErTuFqm5XUtF7IQbWjG3fPD+TLo6ztlCx5059w+5aoKZjgWkh4wFBQvmLXise5
         iXO3k7bXdMFyees72jwJ8nSYG3P2PPiVvbuf/w9Z6Uss9GknXfX48BXmSiia5x+rOgRI
         vh7gWwyFgPUhfmKxocJk9l/YVoQb/QmRxHRZLkbSy3gIhb++S6sgIQrwOmSz+our9lmv
         kkv4tZPr8l/qQ4ffzlGZpj63KW2G1ak6RmTtYD9ojBWwzdLwOj8SgTKJ2O4WGr417MLV
         XVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=WJAQvMs1Q0JN1b84t4wRcxNWwOJ+O3BW6vUmppGF/AY=;
        b=mtX7S8BHE4x0W+E6Hld+Qyk/xYLoXl3M6s7LQCSSnDhrsYywfVpIA5zdh6xlJAY5nq
         0TCEH23S4YKP4tzbapcPe9R+cdu8aKoB09TRQie50cKSZqNHLojCK91zXGR+JzWw9MyF
         wm3tKejIaCI+2cLB/rh8oj5sd4zOYdon0wkh0nVpXnTBcqkHjppcTYPXhaGyzXQAv2C8
         2epS6ua9icLvw8l5EaRUbk1OdtHB/s8bFfpiQTfUVzEwDBu6QQq5cAFtuD94IHYN0HYe
         eoln0ke3nIy8uwjA5doyg/iimIGgSi84CPMdmhrz3Bq9jUbWJ7r42FJF0w1KXKIBT3jN
         NwIA==
X-Gm-Message-State: AA+aEWZ40olHUOS3FsdwB1YnUjKqKnYJE4XzuWOno0poFf6C97eab/7M
        22rKmCMI3JAe8Lrp5FoHTiAiaw==
X-Google-Smtp-Source: ALg8bN504hOREMbUdM3X7NXPDv625PjizpIF3Ff+xFy842xI6GNnXUXL8u+iQx8lGSejUlNsZWzX6w==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr39893190wmn.128.1546531478712;
        Thu, 03 Jan 2019 08:04:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:3f9a])
        by smtp.gmail.com with ESMTPSA id v1sm58979609wrw.90.2019.01.03.08.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:04:37 -0800 (PST)
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] Add driver for globaltop GNSS receivers
In-reply-to: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
Date:   Thu, 03 Jan 2019 17:04:35 +0100
Message-ID: <86bm4x6830.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As suggested by Neil Armstrong - this GNSS device seems to behave 
like
most generic GNSS receivers.
I'll send a v2 with a generic driver that works for both GlobalTop 
and
u-blox.

Please ignore this serie.

Thanks,

Loys

Loys Ollivier writes:

> Hello !
>
> This patch series adds a new GNSS driver for the globaltop GNSS 
> receivers.
> These receivers transmits NMEA output sequence as soon as they 
> have booted.
> Power management can be done via the main supply and optional 
> backup supply
> as defined in the device tree.
>
> The driver has been tested using a GlobalTop pa6h chipset on a 
> Libretech-cc
> board using the expansion header. Changes made in the board 
> device tree can
> be found below for reference and testing.
>
> Loys
>
> Loys Ollivier (4):
>   dt-bindings: Add vendor prefix for "GlobalTop Technology, 
>   Inc."
>   dt-bindings: gnss: add gtop binding
>   gnss: add gtop receiver type support
>   gnss: add driver for globaltop receivers
>
>  Documentation/devicetree/bindings/gnss/gtop.txt    |  33 +++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/gnss/Kconfig                               |  13 ++
>  drivers/gnss/Makefile                              |   3 +
>  drivers/gnss/core.c                                |   1 +
>  drivers/gnss/gtop.c                                | 152 
>  +++++++++++++++++++++
>  include/linux/gnss.h                               |   1 +
>  7 files changed, 204 insertions(+)
>  create mode 100644 
>  Documentation/devicetree/bindings/gnss/gtop.txt
>  create mode 100644 drivers/gnss/gtop.c
>
> ---
> diff --git 
> a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index 90a56af967a7..3b3d4dcc47aa 100644
> --- 
> a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -17,6 +17,7 @@
>  
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;
>                 ethernet0 = &ethmac;
>         };
>  
> @@ -269,7 +270,20 @@
>         pinctrl-names = "default";
>  };
>  
> +/* This is brought out on the UART_A_TX (8) and UART_A_RX (10) 
> pins: */
> +&uart_A {
> +       status = "okay";
> +       pinctrl-0 = <&uart_a_pins>;
> +       pinctrl-names = "default";
> +
> +       gnss {
> +               compatible = "globaltop,pa6h";
> +               v-bckp-supply = <&vcc_3v3>;
> +               vcc-supply = <&vcc_3v3>;
> +               current-speed = <9600>;
> +       };
> +};
> +
>  &usb0 {
>         status = "okay";
>  };


-- 
-L
