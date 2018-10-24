Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2536CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF70B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF70B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJYGL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:11:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36299 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeJYGL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:11:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so6597045otg.3;
        Wed, 24 Oct 2018 14:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+asLhH7avNXtJSDoIT1sM3YWg5U5bqZZWEGl23fiMm0=;
        b=PhaFamut/zeFlDKknstGWPwSfYBzN5tFKNs85N/lgndImmv2Or2LRB9Lh26ui3zthh
         LftNVeA6ufKRfY2C/QWovNSSKHD+3wDs6DkDUw4XFzrbjT4Uiil48PwL+DZvaM/pn38v
         CmWEqMQjqaAmQUv/ASRbP6XChKGjqypv6wEtSd4gj7ylG6E1CRzsWOoXKGOZadF2T46D
         6kTdytH8fQYb8wf0rUPRI2Y7CYhnXRo0UEqrAAZq1TumUpWAJoQjQEO4xzp//nhY9YtD
         5R9vHKGLyr9rtSM9YYXXCvffXcGDInUTRrFDI8aXxK+pQ0xv/UdXb8M3bBCMC6MqmSTz
         4Iig==
X-Gm-Message-State: AGRZ1gJ4/pm73toIoK3THXQ9FhKpkNO7BTf1xCwTJ3FTLjGRnW29D8n4
        tMxOawokBfEbYNzpN38n2EZIElu3oLs=
X-Google-Smtp-Source: AJdET5e15WUWOenikiN232wh5udxxXjmjQpWPtsHcS9fyDgPLqodgrijUIg22kRU08SkI2OSl1Ikgw==
X-Received: by 2002:a9d:385:: with SMTP id f5mr2878916otf.208.1540417302552;
        Wed, 24 Oct 2018 14:41:42 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id v34sm2072979oti.78.2018.10.24.14.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 14:41:41 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id h4-v6so3290474oih.9;
        Wed, 24 Oct 2018 14:41:40 -0700 (PDT)
X-Received: by 2002:aca:5256:: with SMTP id g83-v6mr2456148oib.351.1540417300541;
 Wed, 24 Oct 2018 14:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com> <1539536883-1928-7-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1539536883-1928-7-git-send-email-vabhav.sharma@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 24 Oct 2018 16:41:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNSQt=d4HDR9YckZnXvFi4jB2RisraT869BvTGbpS3Etdg@mail.gmail.com>
Message-ID: <CADRPPNSQt=d4HDR9YckZnXvFi4jB2RisraT869BvTGbpS3Etdg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] arm64: dts: add LX2160ARDB board support
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Scott Wood <oss@buserror.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        yamada.masahiro@socionext.com, Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, V.Sethi@nxp.com,
        udit.kumar@nxp.com, pankaj.bansal@nxp.com,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Ying Zhang <ying.zhang22455@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:14 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.
>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 119 ++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18ad..445b72b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> new file mode 100644
> index 0000000..6481e5f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160ARDB
> +//
> +// Copyright 2018 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +       model = "NXP Layerscape LX2160ARDB";
> +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> +
> +       aliases {
> +               crypto = &crypto;
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       sb_3v3: regulator-sb3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "MC34717-3.3VSB";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +};
> +
> +&crypto {
> +       status = "okay";
> +};
> +
> +&esdhc0 {
> +       sd-uhs-sdr104;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr12;
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       bus-width = <8>;
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       i2c-mux@77 {
> +               compatible = "nxp,pca9547";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       power-monitor@40 {
> +                               compatible = "ti,ina220";
> +                               reg = <0x40>;
> +                               shunt-resistor = <1000>;
> +                       };
> +               };
> +
> +               i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       temperature-sensor@4c {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;
> +                               vcc-supply = <&sb_3v3>;
> +                       };
> +
> +                       temperature-sensor@4d {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4d>;
> +                               vcc-supply = <&sb_3v3>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +
> +       rtc@51 {
> +               compatible = "nxp,pcf2129";
> +               reg = <0x51>;
> +               // IRQ10_B
> +               interrupts = <0 150 0x4>;
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> --
> 2.7.4
>
