Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC8CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D35821473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfA3QqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:46:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40850 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfA3QqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:46:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so200384qtf.7;
        Wed, 30 Jan 2019 08:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODhNe21tGWmLJ5rRP419NkyTlGN+pvxqLtxUx/pdUWg=;
        b=XFwkgSp5f2KHLVgBwqh0CoAM8JKfHlT/f2lSAZczeoHEfy/FQZWcofcyUC7uRWzbxA
         75P3uLBvO/PWB6WGkMN2Y5sBFAE/jImRYfkYPfvODaqc8tYPi1uRHGjKDlT6SvbTkuK/
         JmXT4doM+9C7TcMjrwf3CzpzSknBb6dUyFn4A3Y7gIammatrlaToETUdA2rOjQ+cPd8p
         76S4bpDYmJskDWzfwHUSHLhEJVwjHOWdqO5Xa2SOgvQYwsxG1V++e3lW7hYj/I/baeqw
         iZIRYA04vc1F/RbwjZ249F+5MbX6j9oZ7+1kDu0mJgSZtTIyIiYv3fiufFkH/Ao73Wtd
         I50Q==
X-Gm-Message-State: AJcUukfPqdwbIuNYEBXijKbUVViM8DQnbOTaGDxvuy7rEX/MRVBfx3c4
        TmN0tVE4K8YsU4BuoRzzX158xBfP9yy0aHxPjjo=
X-Google-Smtp-Source: ALg8bN5mRONy4poOzxeECFELS7nFOaQRXi2JXsK1D4Q1LFf56ybMCzArRbHvrdHv9ObnnGHOn7fwlRTw1QuFBeM8VH0=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr30152803qtr.319.1548866760393;
 Wed, 30 Jan 2019 08:46:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org> <1f57f120e915ea9af75a45f48c8ef2f446d10486.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <1f57f120e915ea9af75a45f48c8ef2f446d10486.1548052878.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 17:45:43 +0100
Message-ID: <CAK8P3a2+N9-uLi0GS07JEt3H5hwoku6DWZr+e2DXP-nYHEcOyw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: sprd: Add SC2731 charger device
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 8:39 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Add charger device node and related battery node for SC2731 PMIC.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  arch/arm64/boot/dts/sprd/sc2731.dtsi      |    6 ++++++
>  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 ++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> index a2edc25..b52eaf0 100644
> --- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> @@ -17,6 +17,12 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               charger@0 {
> +                       compatible = "sprd,sc27xx-charger", "sprd,sc2731-charger";
> +                       reg = <0x0>;
> +                       monitored-battery = <&bat>;
> +               };

I see some of these have already slipped through, but we should probably
fix those and not add new ones: "sprd,sc27xx-charger" is not an appropriate
compatible string, because it has a 'xx' wildcard.

What you should have instead is to list compatibility with specific older
models. You also need to have the more generic string as the last one,
not the first.

     Arnd
