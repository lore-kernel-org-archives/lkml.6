Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4434CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E151C21722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OycqJwyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E151C21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH0Krh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:47:37 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44593 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeH0Krg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:47:36 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so2520007qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rOy085fvEkUAPIKm+M2S8VyPaJg0ZfK9BxSmCKewvg0=;
        b=OycqJwyhBeVW5rOses0jKPm1AsM7//sdVeo7WeEXalGSkrt1G9tTzanZYItWVv+I7M
         lFfkQzySh/RvFegemmxF2ffXDqH22us0RU3tPNXJ+2lSPii3vi2mRk+b0DmsBQiz0DCK
         TigYbLywjZ0XP+ER+yvXKyOXvmJCJKAMd8Au7l/oYKA1FQZrsSyetu7Qmw1NER/P+jb5
         i84P/m9AaiWeW7kllb8RsgQMp/gCC6/IU9r04LZ6X/+MTJHbfTNYm230h0l/jHHQiCBu
         2fb//DZWoyCH4hv2m+Cc9dXbrN7+KrFzD1ylUtA/RLbKgKMmlpCV6mh/hyOZNYkWT3vu
         n41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rOy085fvEkUAPIKm+M2S8VyPaJg0ZfK9BxSmCKewvg0=;
        b=UCfcsdBvvQH3d+LzMD6VuiEnYDSnp/CkZaJAm2c7CU2pQiVScwyizU1gVaQuMrZnpE
         MwQv/UW/3zvnADcxaJiNsfd/ltvbPKz456xRcB5m6fJLw6fwBQUwSLXtFRYeFuTSLmyR
         n6tiRVYuGqI37+P+74q1VTjOCS1+v8JgIubXLA0tuBMU7KBlpdQfrIEVi6sbr+vIDNte
         vlUBWZwc9jXGnNXZFLtSvbseM08oRX7dq96Dqhnnjw6lm6Z5O55uVhtacOJq2d2EzftA
         kXtQXHwvBq9u5bEgRRHIWt2ThY2z/c2WLCMf8bu5wRRBKqU5BYZPKQzPzWwsP60+xECC
         0Ecg==
X-Gm-Message-State: APzg51CUn3UXyJ1ecKE40Zl7ee+nGA7UE0sp1vqcFtJI34DpSTQ/ElYb
        WwApDttqt0tWRsrDlQ9ecnpQaENiqgBxkjazDFE=
X-Google-Smtp-Source: ANB0VdZ8NBPxhV6EBshFwG7dKk+YIQW4H0a077pAXcoTLDz1j7uep+iwLmP9rcKNCnfothabVtJZTW37Sg4NnONaxPY=
X-Received: by 2002:ac8:16ec:: with SMTP id y41-v6mr12961620qtk.187.1535353335356;
 Mon, 27 Aug 2018 00:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <1535351378-128643-1-git-send-email-hjc@rock-chips.com>
In-Reply-To: <1535351378-128643-1-git-send-email-hjc@rock-chips.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 27 Aug 2018 09:02:04 +0200
Message-ID: <CAFqH_514pyvKTNHYM=wDab6yAPB+cDCNy8shHPpOP5aeLkyafg@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: fix coding style and incorrect description
To:     hjc@rock-chips.com
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

Just noticed a typo that I think will be good fix also
Missatge de Sandy Huang <hjc@rock-chips.com> del dia dl., 27 d=E2=80=99ag.
2018 a les 8:31:
>
> Align with other drivers, tab + 2 space key for description.
> and this option should be enabled on both rk3288 and rk3399.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/=
Kconfig
> index 0ccc762..601234b 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -45,10 +45,10 @@ config ROCKCHIP_DW_HDMI
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
> +         selet this option.

s/selet/select/

Cheers,
 Enric

>
>  config ROCKCHIP_INNO_HDMI
>         bool "Rockchip specific extensions for Innosilicon HDMI"
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
