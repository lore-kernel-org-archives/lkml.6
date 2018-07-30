Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D0BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CAB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE/aQWBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CAB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG3Ql6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:41:58 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35318 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeG3Ql6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:41:58 -0400
Received: by mail-it0-f68.google.com with SMTP id q20-v6so144134ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t1lvooIay3YWNeavcJ2WXTdP7IniWJ/GFhvbDY8WlAU=;
        b=hE/aQWBSzea5L3jHvv0cjHJMtCwUdGAejXa6+yUxM1nGKmR5S+baFIDBAQ0+8FtwP9
         QzbiGti98hFIFC8+RzdcTWXkdnOpc3pO/NRKHEgrmMHtpFlpcn/cq/hOpN8iOQLMKIJu
         vUbgGBodLQR3Dx8LakXq694wUS/66HvwA2HFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t1lvooIay3YWNeavcJ2WXTdP7IniWJ/GFhvbDY8WlAU=;
        b=Vyjr1qx9MJIRTF9aGC/EWE4CcLZ+Rd76DLuqfgYr/XHET2N7exUZZYrQms5vQ8GVyW
         JKws1zxceb7xCyYiFO+O7SXXqyBqaLpnefgjCyLwY96JsRrXH4nKcHE+ALjDO/VodaPs
         AA2kEARelHPWa3cf5nZUIaOvIO5dnGhfGGwroumyECjwUkEkdnO2nSX7KCM7ZZ2n0NpD
         3GyIdjiFaQVX+9f/FBnNqh/JuLfNbBQSe5sY9NEqxWSANiQHrKl74Iqlzobjd1263IUU
         2sMG361Go/vrkn4A+EASLmd5Od5oMYMDvMB39zBsYk+RN1TMEmV/iXKfoC7BvpuX/OqT
         Ko4A==
X-Gm-Message-State: AOUpUlE0zBZRiqDEfzrHIIRdHR8Ts/wpXLxzJnSu0rGLbhjgWhI2baBl
        HFLBbmC/bCdmPDfvncEBfggUZW3qqfXknxfKzDwMnQ==
X-Google-Smtp-Source: AAOMgpf0aDep6Dm79BmFHZXzX3UI1p6PInMwmhWJ3Zxm4TuQ3z5p18XsTZckS7SF2YtGXyrYlePWHUaXrPtnVjfN6vo=
X-Received: by 2002:a24:4524:: with SMTP id y36-v6mr1542275ita.97.1532963193473;
 Mon, 30 Jul 2018 08:06:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:06:32
 -0700 (PDT)
In-Reply-To: <1532337924-4185-3-git-send-email-cl@rock-chips.com>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com> <1532337924-4185-3-git-send-email-cl@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:06:32 +0200
Message-ID: <CAPDyKFo2GmxKwXDTOxnNY_wb4ydmVjGAZD3=bZYLhfEvjmGyXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: mmc: rockchip-dw-mshc: add
 description for px30
To:     cl@rock-chips.com
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        klaus.goger@theobroma-systems.com, hjc@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Frank Wang <frank.wang@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        zhangqing <zhangqing@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Tao Huang <huangtao@rock-chips.com>, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 at 11:25,  <cl@rock-chips.com> wrote:
> From: Liang Chen <cl@rock-chips.com>
>
> Add "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc" for
> dwmmc on px30 platform.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liang Chen <cl@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> index 8ce49b2..6f629b1 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> @@ -14,6 +14,7 @@ Required Properties:
>                                                         before RK3288
>         - "rockchip,rk3288-dw-mshc": for Rockchip RK3288
>         - "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
> +       - "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip PX30
>         - "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
>         - "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322x
>         - "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
> --
> 1.9.1
>
>
