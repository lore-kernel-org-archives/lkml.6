Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE18CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB28208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbRFXmGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB28208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeH1MLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:11:31 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46921 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeH1MLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:11:31 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so696572qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1GFtWDxGPcH77vTCYpdGncHlyo6QmqcJomO3HobbEJo=;
        b=jbRFXmGbyj9i/IVdNrezyIzXci/R/24RXdsc8+q4iqJ/7d8y9doy7784yanrKSumDP
         j8pxTvnAy2eBUVhzkUCIQypXIQ9FXzKps6EDGQ3R7TEMspJQ9HosmYN97gOD/ZSD6dre
         k+vRnzmxPNVB6GaNbT2nbsqyO11ejzlHc4bApryektSlC6OrvRCPY/G8bVziItd417UK
         MXTI3sCqbXCU6ZH8XXcV/jzqe7gXJP3CpxtI19W6EBNchVbRq6w2XoIiCSuw32o1bo37
         SMOmErfGWkk3OZM2oNh3zS0BqroA760p0+ACEdMAPKDI0293oEIGYpjjfwWTochYH8Dp
         ht2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1GFtWDxGPcH77vTCYpdGncHlyo6QmqcJomO3HobbEJo=;
        b=K7PSBBmExJ1Bh9+P+2hVnmuq9hzdM7A2863WZWxS6/LeLqJbBt5BdIcdm4BlX6u41n
         imEq4N2Y7c61q3jVFLH5Eo05RAz076ZLINVFPQDkhw5gkcmoN+BxbzFr4fCc8Ra5y22/
         oULleXwiNoJHQeLxVczZFSYP3FjiAo96Cl6lzKCe2mUrONGL2k7yG4/WOElTPMI50DGd
         3vQMG009/sJLMNcttOToHrVyqNQG8wPDxuWtJE9aSMihHVLp4mTCY7pyw5/r7zQiwbeh
         cXIPB0KTfMw8Sp30xCuQlGi1k5Dsbmf3KNwVsXOja6EV+3wFqIPN/d/xaRhy2iJrPCsl
         iepQ==
X-Gm-Message-State: APzg51CNlhcepqRnddmXHNaSV45mDY6r+0HJTCl9N8zULhQZxJX2qw5F
        XDg56H3nImZ9uUcKVy8htfDlzSOBvkt3XZkYa8eG8A==
X-Google-Smtp-Source: ANB0VdbTo95kPeQHK5rBkRD8oByJAntilRTMPApop1cdtYrlv21vJ1YEAjR0SNVgH/LPj7i9YRKFukp4fD85O2nNP00=
X-Received: by 2002:a0c:cdd1:: with SMTP id a17-v6mr411415qvn.205.1535444459603;
 Tue, 28 Aug 2018 01:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <1535442295-4007-1-git-send-email-hjc@rock-chips.com>
In-Reply-To: <1535442295-4007-1-git-send-email-hjc@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 28 Aug 2018 10:20:48 +0200
Message-ID: <CAFqH_53aJX=n_kzvf=xjWGTSu2ak8q8wJ3nGM94e_OGLYAKWAQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/rockchip: fix coding style and incorrect description
To:     hjc@rock-chips.com
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Sandy Huang <hjc@rock-chips.com> del dia dt., 28 d=E2=80=99ag.
2018 a les 9:45:
>
> Align with other drivers, tab + 2 space key for description.
> and edp/hdmi/dsi can be used on both rk3288 and rk3399.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/=
Kconfig
> index 0ccc762..0534dc1 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -23,7 +23,7 @@ config ROCKCHIP_ANALOGIX_DP
>         help
>           This selects support for Rockchip SoC specific extensions
>           for the Analogix Core DP driver. If you want to enable DP
> -         on RK3288 based SoC, you should selet this option.
> +         on RK3288 or RK3399 based SoC, you should select this option.
>
>  config ROCKCHIP_CDN_DP
>          bool "Rockchip cdn DP"
> @@ -39,16 +39,16 @@ config ROCKCHIP_DW_HDMI
>          help
>           This selects support for Rockchip SoC specific extensions
>           for the Synopsys DesignWare HDMI driver. If you want to
> -         enable HDMI on RK3288 based SoC, you should selet this
> -         option.
> +         enable HDMI on RK3288 or RK3399 based SoC, you should select
> +         this option.
>
>  config ROCKCHIP_DW_MIPI_DSI
>         bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
>         help
> -        This selects support for Rockchip SoC specific extensions
> -        for the Synopsys DesignWare HDMI driver. If you want to
> -        enable MIPI DSI on RK3288 based SoC, you should selet this
> -        option.
> +         This selects support for Rockchip SoC specific extensions
> +         for the Synopsys DesignWare HDMI driver. If you want to
> +         enable MIPI DSI on RK3288 or RK3399 based SoC, you should
> +         select this option.
>
>  config ROCKCHIP_INNO_HDMI
>         bool "Rockchip specific extensions for Innosilicon HDMI"
> --
> 2.7.4

If it helps...

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>
>
