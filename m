Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624CAECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1548C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WybRtokV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1548C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJZAaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:30:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33758 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZAaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:30:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id w18so6681570otk.0;
        Thu, 25 Oct 2018 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVC+7RFZP5CbdsC6n66TjwThFve/Ih9fSlCLZjza8GE=;
        b=WybRtokVrXngJtExvnKubXjLdyVNvflxmK+Gfr6f+XA9TvDVpeOs/MVV2TMFg9p5UL
         nLzSwm7x8x1mBHYiLR7kXW+7m+BWUVfQFzTzwNKi8UqOnZGsJUyPlaaoTYCRYvLUvEhB
         SKghLomtMmI5muux/reG1huFG9NqX+X6sNMGn1sv3mtVm6MuAlAtNusb17OKv5XYZWp2
         pftX2LKaMY+4E+p7w7MwyxPNdaytjqnHkSgFH3lSf0Iutm2KMMpRMEhSJa2yXo92bpKB
         kfO9HRSgFjW8v2+AhB097uT73r/7Ce2GM5wK9MiFxuFJc/mCY0jO4IJSHys3bX20PyyY
         DcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVC+7RFZP5CbdsC6n66TjwThFve/Ih9fSlCLZjza8GE=;
        b=eeAQkNiwh/q/HDeNtAztXPZ4k2OAHOLrcvDnKMW2dPRLFs5+Ni0zImlKCK4Z48KcXi
         d6A8r/iPrkzx7LANIMBrSU8fsWh+YBRJk46rdgF/jsLb9KKnxY+0Uw5Xncfbn3Y7wQh2
         7vn98MU9kBLBDw7+Y5/xbwYx9BM6YrUZ4gz1cPm6wn8pjEG2BgGW6hYHvbi8niY403M1
         l/D5G3csozb1bs59c4sk1saf4ZIsd+KR5dLTovQ3Q/knWaC+ysGiAOu8cUSe3+KzcAKD
         ZsRwPQmqrfsT1ytA/Qh/OhMKd1aXz6ws7OzVyeB83gAtBRwd7uiemkiZraz6Tfx8eadh
         72cg==
X-Gm-Message-State: AGRZ1gLs7IdTy5oMUhVW6NnhSeq9YfeHuj5/GSyLN4CUB+TX/nhlW3c5
        mq3djfPQIoiE1nCu1UKT6mqbEklml8jwxZVvdNA=
X-Google-Smtp-Source: AJdET5drPlidRby3vuL5vALdXMPxzQz1BMB2bJoKhjwZUYO0ovyxUJly8BgJFeR1h7KL8ZlWySpaM9rJyBD3eqko134=
X-Received: by 2002:a9d:42a:: with SMTP id 39mr1700662otc.78.1540483014309;
 Thu, 25 Oct 2018 08:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com> <1540480173-12009-3-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1540480173-12009-3-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Oct 2018 12:56:53 -0300
Message-ID: <CAOMZO5B+V5OETLdye7VVB8v6fnZPwPSZjV48_TkzhawQ4zL0oA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010
 lcdif panel
To:     "Gonzalez, Alex" <alex.gonzalez@digi.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:11 PM Alex Gonzalez <alex.gonzalez@digi.com> wrote:
>
> This change adds support for the AUO G101EVN010 lcdif panel for the
> mxsfb DRM driver.
>
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> index 11966d12af76..f6e6b2cf780b 100644
> --- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> +++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> @@ -24,6 +24,18 @@
>                 status = "okay";
>         };
>
> +       panel {
> +               compatible = "auo,g101evn010", "simple-panel";

The "simple-panel" string could be dropped.

Reviewed-by: Fabio Estevam <festevam@gmail.com>


> +               power-supply = <&ldo4_ext>;
> +               backlight = <&lcd_backlight>;
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&display_out>;
> +                       };
> +               };
> +       };
> +
>         reg_usb_otg1_vbus: regulator-usb-otg1 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "usb_otg1_vbus";
> @@ -112,6 +124,12 @@
>                      &pinctrl_lcdif_hvsync>;
>         lcd-supply = <&ldo4_ext>;       /* BU90T82 LVDS bridge power */
>         status = "okay";
> +
> +       port {
> +               display_out: endpoint {
> +                       remote-endpoint = <&panel_in>;
> +               };
> +       };
>  };
>
>  &ldo4_ext {
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
