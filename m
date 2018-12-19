Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B33C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F6021850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9kesu9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeLSJjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:39:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36802 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbeLSJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:39:36 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so11269318qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alqENIH4zrVWxQU5khICTpLHqUBK3x9KlcUHJQs2nLA=;
        b=L9kesu9fyShDoukHXOZd5lkFVjVrI33/14q05zlrZybDCq1FD3HIjJqoMZuIyGUFxK
         /k7zPuBgEH1CYUjCuRU9Aqe1TU1oW2uULIC8w0hII/lRyx4dNTllo67914Lx9JGaCVEH
         Ebu5rDnANaxcipdsY8y5x1fKTpzXsuyyemNFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alqENIH4zrVWxQU5khICTpLHqUBK3x9KlcUHJQs2nLA=;
        b=o96jlozIg1ppgh04gNwalcIlew/9Y+siLKd03nN7haZ5qqirYiI+yahqxG0JiQftxA
         VHaX3WXIZM/KNRfwxTwEE4mtJ2x2leIpKkKOgUoxCaPNDG+wIJj/YVyefQvy+YxIbMnh
         lruZz/e77IzL3i2n4WG7Lxcm3vWre0CUBVsrqx5uk8/AiZGy9nqokVoCDDwo+qf60ojt
         S7G7FwQ7VM0nhu2fZcnbrSrK86LwU4KEjiqPXybHbCK5CFJGQvSsKdccauS7+IOGrGpH
         Ye6DxB5Y24Rjft6p+pDw/o8/89X5i/nao9Apy6rYzJf9CjobTRFh1dLXy0aDsaiwjuxI
         o/aA==
X-Gm-Message-State: AA+aEWa8fAT0/BXpFB58T0lQ6i4CbY3eAJGnVPVXAKvi9C9dxPdv8CnG
        UVRjeicRh2GUSoH44G/Xr5s9ZtW9Oaj4NBQAYefmRw==
X-Google-Smtp-Source: AFSGD/UE7lyw07Y2CgiT8R+PaWW1eSHvcVdEBFQe/UDaXYLnPssnAoV1MMzYf90yEhoLyLqp5ZnhHn4AVwmBwGfrsXg=
X-Received: by 2002:a37:d947:: with SMTP id u68mr19260287qki.296.1545212374169;
 Wed, 19 Dec 2018 01:39:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545126964.git.amit.kucheria@linaro.org>
 <d153a86748f99526e7790bfc4ef8781a2016fd51.1545126964.git.amit.kucheria@linaro.org>
 <8f03c13235ff5ad6f0ad6af59d4d7db501fb8c96.camel@perches.com>
In-Reply-To: <8f03c13235ff5ad6f0ad6af59d4d7db501fb8c96.camel@perches.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 19 Dec 2018 15:09:22 +0530
Message-ID: <CAP245DX_NX-78OvGft2NJnmhhzfN_3jSjCi2vMeo0t6MMcS4vA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: update list of qcom drivers
To:     joe@perches.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>, marc.w.gonzalez@free.fr,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kalle Valo <kvalo@adurom.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 6:02 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-12-18 at 15:29 +0530, Amit Kucheria wrote:
> > Several drivers didn't have a specific maintainer (other than the
> > subsystem maintainer). Add all drivers referring to qcom or msm to the
> > list of supported drivers.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -1929,20 +1929,61 @@ M:    Andy Gross <andy.gross@linaro.org>
> >  M:   David Brown <david.brown@linaro.org>
> >  L:   linux-arm-msm@vger.kernel.org
> >  S:   Maintained
> > +F:   include/dt-bindings/*/qcom*
> > +F:   include/linux/*/qcom*
> >  F:   Documentation/devicetree/bindings/soc/qcom/
> > +F:   Documentation/devicetree/bindings/*/qcom*
> >  F:   arch/arm/boot/dts/qcom-*.dts
> >  F:   arch/arm/boot/dts/qcom-*.dtsi
> >  F:   arch/arm/mach-qcom/
> > -F:   arch/arm64/boot/dts/qcom/*
> > -F:   drivers/i2c/busses/i2c-qup.c
> > +F:   arch/arm64/boot/dts/qcom/
> > +F:   drivers/bluetooth/btqcomsmd.c
> > +F:   drivers/bus/qcom*
> > +F:   drivers/cpufreq/qcom*
> >  F:   drivers/clk/qcom/
> > +F:   drivers/clocksource/timer-qcom.c
> > +F:   drivers/crypto/qcom-*
> >  F:   drivers/dma/qcom/
> > +F:   drivers/edac/qcom*
> > +F:   drivers/extcon/extcon-qcom*
> > +F:   drivers/firmware/qcom*
> > +F:   drivers/hwspinlock/qcom_*
> > +F:   drivers/iio/adc/qcom*
> > +F:   drivers/iommu/qcom*
> > +F:   drivers/iommu/msm*
> > +F:   drivers/i2c/busses/i2c-qup.c
> > +F:   drivers/i2c/busses/i2c-qcom-geni.c
> > +F:   drivers/irqchip/qcom*
> > +F:   drivers/mailbox/qcom-*
> > +F:   drivers/media/platform/qcom/
> > +F:   drivers/mfd/qcom*
> > +F:   drivers/mfd/ssbi.c
> > +F:   drivers/misc/qcom-*
> > +F:   drivers/mmc/host/mmci_qcom*
> > +F:   drivers/mmc/host/sdhci_msm.c
> > +F:   drivers/mtd/*/qcom*
> > +F:   drivers/pci/controller/dwc/pcie-qcom.c
> > +F:   drivers/perf/qcom*
> > +F:   drivers/pinctrl/qcom/
> > +F:   drivers/phy/qualcomm/
> > +F:   drivers/power/*/qcom*
> > +F:   drivers/power/*/msm*
> > +F:   drivers/regulator/qcom*
> > +F:   drivers/reset/reset-qcom-*
> > +F:   drivers/remoteproc/qcom*
> > +F:   drivers/rpmsg/qcom*
> > +F:   drivers/scsi/ufs/ufs-qcom.*
> > +F:   drivers/slimbus/qcom*
> >  F:   drivers/soc/qcom/
> >  F:   drivers/spi/spi-qup.c
> > +F:   drivers/spi/spi-geni-qcom.c
> > +F:   drivers/spi/spi-qcom-qspi.c
> > +F:   drivers/thermal/qcom/
> >  F:   drivers/tty/serial/msm_serial.c
> > +F:   drivers/tty/serial/qcom*
> > +F:   drivers/usb/dwc3/dwc3-qcom.c
> > +F:   drivers/watchdog/qcom*
> >  F:   drivers/*/pm8???-*
> > -F:   drivers/mfd/ssbi.c
> > -F:   drivers/firmware/qcom_scm*
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
>
> Perhaps many of these could be consolidated like
>
> F:      drivers/*/qcom/
> F:      drivers/*/qcom*
> F:      drivers/*/*/qcom/
> F:      drivers/*/*/qcom*

Good suggestion! I might be able to get rid of a few more lines with

F:      drivers/*/*qcom*
