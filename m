Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BF12073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BF12073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeI2CCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:02:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39883 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI2CCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:02:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id c20-v6so562508otl.6;
        Fri, 28 Sep 2018 12:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+qCV9SaBAMefNu93MVLFeCsJFl0wtxQ1dZwtJUyGPk=;
        b=gPm4C3tgzGcbELAf7Er03OaV/gfxANt5UwF9Erqk3gzkqohMyRoxiTu42StBL7oTc9
         trOcL3xz5I5IxNtPB1JTgaDLjIaqK53/UgUwJAgB5sEwC5LOR/LYvW0EQvzndSxpSAI6
         Vuxg7nhPGmRNLJMTdutz4O2GyNgF0VPkuj/Cyq/dn2LxH7Z2zvKQxM2cuGV6SEhnWhak
         2lGMmcR04kiZh8/NpiAJMonYRVRu68zarfFWuDT5vw/OSC61TJN5I0BcMIukvUU4Ul8F
         0vYgsS0iKoJv+RWZkVqOaPL0UHWn3ycEhkFgyeH8Q+uJFI0Dmo0/URScmtPmvNwIjaT7
         lBww==
X-Gm-Message-State: ABuFfohf1pCxiR61Vp5rCHnZWlSgWpD3SKFs4spIlu6mO9goXrG+Pj1+
        Qf6t9SIfwC/b26zCvZDt2mZ9epk1lAw=
X-Google-Smtp-Source: ACcGV62F3qKOOOa8mVBjdVGnJkWm9pC8chv1eQECf5iQjKGQg+Syogqg+z/vLE6ku3hJ44+l9XA/eg==
X-Received: by 2002:a9d:4e94:: with SMTP id v20-v6mr47514otk.255.1538163447770;
        Fri, 28 Sep 2018 12:37:27 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id j80-v6sm2161122oib.33.2018.09.28.12.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 12:37:27 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id m23-v6so7159016otf.0;
        Fri, 28 Sep 2018 12:37:26 -0700 (PDT)
X-Received: by 2002:a9d:1b50:: with SMTP id l74-v6mr81460otl.112.1538163446517;
 Fri, 28 Sep 2018 12:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com> <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 28 Sep 2018 14:37:15 -0500
X-Gmail-Original-Message-ID: <CADRPPNS1Zj=47M-yOBAJ=X=sjjxmh0k7tNcj1A8uY=cPM398tQ@mail.gmail.com>
Message-ID: <CADRPPNS1Zj=47M-yOBAJ=X=sjjxmh0k7tNcj1A8uY=cPM398tQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: add LX2160ARDB board support
To:     vabhav.sharma@nxp.com
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
        yamada.masahiro@socionext.com, udit.kumar@nxp.com,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Russell King <linux@armlinux.org.uk>, V.Sethi@nxp.com,
        Sriram Dash <sriram.dash@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 7:51 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.

Please send next version with Shawn Guo and me in the "to" recipient
so that its less likely we will miss it.

>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |  1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 88 +++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
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
> index 0000000..1bbe663
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,88 @@
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
> +       chosen {
> +               stdout-path = "serial0:115200n8";
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
> +&i2c0 {
> +       status = "okay";
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

Need a vcc-supply property according to the binding.

> +                       };
> +
> +                       temperature-sensor@4d {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4d>;

Ditto.

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
> +               };
> +
> +};
> +
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> +
> +&crypto {
> +       status = "okay";
> +};
> --
> 2.7.4
>
