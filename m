Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF504C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A1820848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRFT7NNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A1820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeLCPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:54:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbeLCPyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:54:14 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DBF62146D;
        Mon,  3 Dec 2018 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543852450;
        bh=zPkBlPtwUJ4e/hJsU/+mrYF7VvXkV+coF16HNC2xL1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XRFT7NNcurH8Qm8xmevCDaDQd24ZeFhkid1MY/UBtNk/KLlIJdoYWWFkPE2Xohexs
         +8tbs31kuhHZlVTP5BINk+it+qVZ+7GHf21Uey6l/ofxltGApXkqkyVu3Vgq6KWHzD
         ZiHpfahDwlzwIwSbD7oyXStJN+xNxpJwJIXrsLP0=
Received: by mail-qt1-f177.google.com with SMTP id z16so14278968qtq.4;
        Mon, 03 Dec 2018 07:54:10 -0800 (PST)
X-Gm-Message-State: AA+aEWY0ZKCqgYEM3AqfltvOpfdu8DFR48TsLNvJ43aT+NehlJW8sNqF
        WiT6fvy2oD8r1cEgGuUkVpvuJsChtIUxiMN4HQ==
X-Google-Smtp-Source: AFSGD/VWWsrKpQup9mQybfjJ6mMLlZgPdcX0XpE+Rn0txEtmCCKSO3FBTxaCtjBgTyPwzi0zs/hDyZW0mAqI6CB5uHU=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr16126319qts.144.1543852449415;
 Mon, 03 Dec 2018 07:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org> <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 Dec 2018 09:53:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
Message-ID: <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net,
        overseas.sales@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 9:38 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add initial devicetree support for OrangePi 2G IoT board from Xunlong.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                    |  2 +
>  .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 40 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b0e966d625b9..a0fdad8f10dd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
>         qcom-msm8974-sony-xperia-castor.dtb \
>         qcom-msm8974-sony-xperia-honami.dtb \
>         qcom-mdm9615-wp8548-mangoh-green.dtb
> +dtb-$(CONFIG_ARCH_RDA) +=3D \
> +       rda8810pl-orangepi-2g-iot.dtb
>  dtb-$(CONFIG_ARCH_REALVIEW) +=3D \

Question for Arnd/Olof: can we *please* start putting new SoC families
in sub-dirs?

Rob
