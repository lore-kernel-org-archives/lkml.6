Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0086FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C141520645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nl04OON6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeLQFrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:47:02 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44648 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLQFrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:47:02 -0500
Received: by mail-yb1-f196.google.com with SMTP id d2so4628291ybs.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 21:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ctqFADV58yUhr8uQS0dXF/3lM/bQh2NGAGf199ZWQI=;
        b=Nl04OON6EHmrKBIgMWUDlEw4bRHJLcXOi0YCSzgMRDZ+U6R4nMYKGJb5/x4I7+LJ1D
         sPhgyHS0xO+rAxQRGG1AFsr0LF+Z59ZrhCkMTBnOPWEJu3+oKLj6+kB+/nOeei/mjRXV
         L0wkjRpV/MHPlHYOzbjqJwdfMX1ynqVgT19TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ctqFADV58yUhr8uQS0dXF/3lM/bQh2NGAGf199ZWQI=;
        b=fu2p04oXI+WeiDKZEg1I7I39kT7blyWn2gUQW6glNwoyxJ4Z0aWzRmOZ5exmdoWWKN
         rLZcJB/Ym1BXCVxT66Cz+4pNNHN2rsnguTkP7RlMfy3eyAHCw17Vp3fM5sewvPgzSS0e
         iYAZmI/ZtOEeKXX8M2IdooKj/bOVsQi5ktg+oCbOB7rwE35Z9/ctYrpgkw5OLu6Tm9pl
         +bLS0GCZbNtilf0oA0tyjr+ORZG01D95Y9JUz9cW0F+UPPXiPBtb1iF6xO4QZaMz3iIU
         3YqVudmqJcPZBFAdu1JGVMuH9bjeshXQ612ZXrp0HPrD0RSw4LX3e1ySdQiEcldrIIal
         A62g==
X-Gm-Message-State: AA+aEWZ23+AlUcmrGm4HQ69Ilb+ybGsAcW2FlVVz9WXRtxsnfDqBUKxv
        0H07pujysAqVl5bwMI5eZc4AGdd4c4M=
X-Google-Smtp-Source: AFSGD/UEmiFOwZ476fe/plsSBnoEVdntw5+/ufwT/MyxguGfnDy99RQDNXra30KiXsfvifiQs443HA==
X-Received: by 2002:a25:e404:: with SMTP id b4mr12017959ybh.517.1545025620714;
        Sun, 16 Dec 2018 21:47:00 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v9sm6309403ywh.2.2018.12.16.21.46.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 21:46:59 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id e124so4628354ybb.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 21:46:59 -0800 (PST)
X-Received: by 2002:a25:d644:: with SMTP id n65mr11687359ybg.204.1545025618887;
 Sun, 16 Dec 2018 21:46:58 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR04MB45048F404CB1166F7CEB0101BFA20@AM6PR04MB4504.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB45048F404CB1166F7CEB0101BFA20@AM6PR04MB4504.eurprd04.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 17 Dec 2018 14:46:47 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com>
Message-ID: <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com>
Subject: Re: [PATCH] dts: rockchip: rk3066: add qos_hdmi and HCLK_HDMI to pmu node
To:     jbx9999@hotmail.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Sun, Dec 16, 2018 at 12:03 AM Johan Jonker <jbx9999@hotmail.com> wrote:
>
> A MK808 TV stick with rk3066 processor boots normal with logo and console.
> After the boot the monitor remains black.
> This patch fixes a vblank timeout crash by adding qos_hdmi and
> HCLK_HDMI to the pmu node.
> The HCLK_HDMI clock and the RK3066_PD_VIO power domain
> will now turn on and off together.
>
> Signed-off-by: Johan Jonker <jbx9999@hotmail.com>
> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 6 ++++--
>  arch/arm/boot/dts/rk3xxx.dtsi  | 5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>

Thanks for the patch. Unfortunately, it looks like you didn't add the
necessary mailing lists to the recipient list. For reference, the
./scripts/get_maintainer.pl script in the kernel source tree should be
able to give you a reasonable recipient list. For now, I added the
mailing lists on CC and replied without snipping, so people should be
still able to review the patch.

Other than that, It looks reasonable to me, but we need someone with
access to SoC documentation to check it. Heiko, Sandy, is that
something you would be able to help with?

> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 30dc8af0b..6e7cdde84 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -672,13 +672,15 @@
>                                  <&cru ACLK_IPP>,
>                                  <&cru HCLK_IPP>,
>                                  <&cru ACLK_RGA>,
> -                                <&cru HCLK_RGA>;
> +                                <&cru HCLK_RGA>,
> +                                <&cru HCLK_HDMI>;
>                         pm_qos = <&qos_lcdc0>,
>                                  <&qos_lcdc1>,
>                                  <&qos_cif0>,
>                                  <&qos_cif1>,
>                                  <&qos_ipp>,
> -                                <&qos_rga>;
> +                                <&qos_rga>,
> +                                <&qos_hdmi>;
>                 };
>
>                 pd_video@RK3066_PD_VIDEO {
> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
> index 97307a405..1f9496e81 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -187,6 +187,11 @@
>                 reg = <0x1012f280 0x20>;
>         };
>
> +       qos_hdmi: qos@1012f300 {
> +               compatible = "syscon";
> +               reg = <0x1012f300 0x20>;
> +       };
> +

Is this really common for all rk3xxx SoCs?

>         usb_otg: usb@10180000 {
>                 compatible = "rockchip,rk3066-usb", "snps,dwc2";
>                 reg = <0x10180000 0x40000>;
> --
> 2.11.0
>

Best regards,
Tomasz
