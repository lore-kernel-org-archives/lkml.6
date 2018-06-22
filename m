Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC99DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52C223E85
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CscbKXye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52C223E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeFVH6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeFVH6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:58:44 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D050A23E85;
        Fri, 22 Jun 2018 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529654324;
        bh=0LG1vepAGvdkBl55GxRmWpfzTo9AxTB7NSV+VULFoYM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CscbKXyeR9amy6C/j2eRj3pbKfqnywRyzgAeel2qEyBKZWjINpsmwF6a/VU3mQzvu
         nDHbWnK3oX8uKqK2O2n4n3GY1FvdpRYfT1jRFDWhGEuzP717yFXySFlU3YV+Z1rCnH
         5mx28iCJoP8EuZYYD2+skm1TV0NCacbnXRAjXD5Q=
Received: by mail-wm0-f46.google.com with SMTP id p11-v6so1366430wmc.4;
        Fri, 22 Jun 2018 00:58:43 -0700 (PDT)
X-Gm-Message-State: APt69E2H2g3PdLrvo7XTPSZCSjnaIi/s5/xrUc/jQy/H88f+lls/1BNi
        T8tAvr0oDBv3SdoNZkUJxXgOAAi7hVoFFUyPRP0=
X-Google-Smtp-Source: ADUXVKK/v+jw0IDyJ5nhauF8iLWA84DaokeWZYHIWO6JtsW0Jmz8Qdr+u3XUOfv6c7IJrn3XMDNMXU0EVhgTnRpb0LE=
X-Received: by 2002:a1c:6d85:: with SMTP id b5-v6mr765232wmi.135.1529654322393;
 Fri, 22 Jun 2018 00:58:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:58:41
 -0700 (PDT)
In-Reply-To: <1529608199-5583-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1529608199-5583-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 09:58:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeG89+7PjPfr42posJ9CvhUfFvMNe-oFpi4DiS57-E6cg@mail.gmail.com>
Message-ID: <CAJKOXPeG89+7PjPfr42posJ9CvhUfFvMNe-oFpi4DiS57-E6cg@mail.gmail.com>
Subject: Re: [PATCH 6/7] ARM: dts: s5pv210: Add initial DTS config for
 SGH-T959P phone
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
> wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>

Commit msg needed.

> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                |  1 +
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 40 +++++++++++++++++++++++++=
++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 522ebdca1d3d..d00e995875bb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) +=3D \
>         s3c6410-smdk6410.dtb
>  dtb-$(CONFIG_ARCH_S5PV210) +=3D \
>         s5pv210-aquila.dtb \
> +       s5pv210-fascinate4g.dtb \
>         s5pv210-galaxys.dtb \
>         s5pv210-goni.dtb \
>         s5pv210-smdkc110.dtb \
> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dt=
s/s5pv210-fascinate4g.dts
> new file mode 100644
> index 000000000000..37967f57c7b7
> --- /dev/null
> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>

Duplicated header.

> +#include "s5pv210-aries.dtsi"
> +
> +/ {
> +       model =3D "Samsung Galaxy S Fascinate 4G (SGH-T959P) based on S5P=
V210";
> +       compatible =3D "samsung,fascinate4g", "samsung,aries", "samsung,s=
5pv210";
> +
> +       chosen {
> +               bootargs =3D "console=3DttySAC2,115200n8 root=3D/dev/mmcb=
lk1p1 rw rootwait ignore_loglevel earlyprintk";

Same comment as for Galaxy S.

Best regards,
Krzysztof

> +       };
> +
> +       gpio-keys {
> +               compatible =3D "gpio-keys";
> +
> +               power {
> +                       label =3D "power";
> +                       gpios =3D <&gph2 6 GPIO_ACTIVE_LOW>;
> +                       linux,code =3D <KEY_POWER>;
> +                       wakeup-source;
> +               };
> +
> +               vol-down {
> +                       label =3D "volume_down";
> +                       gpios =3D <&gph3 2 GPIO_ACTIVE_LOW>;
> +                       linux,code =3D <KEY_VOLUMEDOWN>;
> +               };
> +
> +               vol-up {
> +                       label =3D "volume_up";
> +                       gpios =3D <&gph3 1 GPIO_ACTIVE_LOW>;
> +                       linux,code =3D <KEY_VOLUMEUP>;
> +               };
> +       };
> +};
> --
> 2.7.4
>
