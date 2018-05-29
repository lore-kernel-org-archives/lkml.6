Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934854AbeE2OLy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:11:54 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36907 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934158AbeE2OLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:11:51 -0400
X-Google-Smtp-Source: ADUXVKKCHJJQOUJ0TIMpfu5HkoP7XzyIAl4tJiTO6X7xtrW48R0LhkKioF2ArmHypqSg3uPi6FBYOnF7c2ADJ4M7tqw=
MIME-Version: 1.0
In-Reply-To: <20180529155736.275e27b1@jawa>
References: <20180509153428.1440-1-lukma@denx.de> <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
 <20180519140202.3449e3c1@jawa> <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
 <20180529155736.275e27b1@jawa>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 May 2018 11:11:50 -0300
Message-ID: <CAOMZO5AU8PDEErHeU1yb9mwgNLJUvWipTrDsY8csXSHiNro-7w@mail.gmail.com>
Subject: Re: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, May 29, 2018 at 10:58 AM, Lukasz Majewski <lukma@denx.de> wrote:

> Sorry for "small" delay on this.
>
> Ok, so I've investigated the issue:
>
> 1. The code, which you pasted:
> http://code.bulix.org/ik01yu-339697
>
> works correctly as imx53-qsb-common.dtsi directly includes "imx53.dtsi"
> in which iomuxc label is defined.
>
> In my case though,
>
> 2. I do include imx53-tqma53.dtsi [1], in which the iomuxc" label
> is extended:
>
> &iomuxc {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_hog>;
>
>         imx53-tqma53 {
>                 pinctrl_hog: hoggrp {
>
> .......
>
> };
>
> The imx53-tqma53.dtsi then includes imx53.dtsi.
>
> Moreover, my file -> imx53-kp.dtsi as it includes [1], it extends
> further the &iomuxc label:
>
> &iomuxc {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_kp_common>;
>
>         imx53-kp-common {
>                 pinctrl_buzzer: buzzergrp {
> .......
> };
>
> So, when I remove imx53-kp-common I will have mismatch with [1] iomuxc
> structure.
>
> The code works as expected when I do remove imx53-tqma53 in [1].
>
> However, I would prefer to not touch this imx53-tqma53.dtsi file.
> It is also included in: imx53-mba53.dts, which extends iomux in
> following way:
>
> &iomuxc {
>         lvds1 {
>                 pinctrl_lvds1_1: lvds1-grp1 {
>
>
> Here I would need to remove lvds1, disp1 and tve to make it working.
> However, it will not break during build, but at run time.
>
> Considering the above, I would prefer to leave the code in [1] as is
> and use imx53-kp-common as well (as in v2 of this patch).
>
> Fabio, what do you think?

Ok, thanks for the clarification. I just wanted to make sure we did
not have some kind of iomux bug there.

I think your proposed patch is fine then.

Thanks
