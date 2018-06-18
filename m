Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5778EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E9620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEiG4jvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E9620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755105AbeFRHHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754895AbeFRHG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:06:56 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A90208E6;
        Mon, 18 Jun 2018 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529305615;
        bh=4ZYFG1TnLxxT8on8ktrEz7UhOVRcpYgKuwmuDa4az9o=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iEiG4jvytPZtwpU15iRI0ZiQuU0Y5K8gd+P4dlBceh4QiCxU58waprp+/YAcat4Yv
         9cSBKct8XHpp/9GR4o4zfqg35mxqIWPMOlmOkTn7TsPtzJo3BhDzoUhrzdbQgoP06g
         tZUDq3wV1bXDAdv5si0AfHh9S0/ydPBgo4lRFVQc=
Received: by mail-wm0-f46.google.com with SMTP id x6-v6so12163232wmc.3;
        Mon, 18 Jun 2018 00:06:55 -0700 (PDT)
X-Gm-Message-State: APt69E2yqDP3L82Elb3xocg24aYhcGhKfGQWgeqnz3POt3WvWqfJQmIy
        eQk1z8j4kwrLOwT7uDLvWMCDpPgpS6ZPTRsALzo=
X-Google-Smtp-Source: ADUXVKJU9gWVlcj+yRVl3049YozY9P9RtZj4/L2gJu6Ei7m38f4Jyz5oPgD0+ND9eHX0xp+s6GC08IaYRSBZbpN9Oq4=
X-Received: by 2002:a1c:c05:: with SMTP id 5-v6mr8153967wmm.117.1529305613911;
 Mon, 18 Jun 2018 00:06:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 00:06:53
 -0700 (PDT)
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Jun 2018 09:06:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcAVovxU2mHSbkAG0axutFbd=_92bNdd2P_CnQGmhAfCg@mail.gmail.com>
Message-ID: <CAJKOXPcAVovxU2mHSbkAG0axutFbd=_92bNdd2P_CnQGmhAfCg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anthony Kim <anthony.kim@hideep.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 4:31 PM, Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> Should I split this patch so that different parts can go through differen=
t trees?
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.txt          | 2 +-
>  .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt        | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/hideep.txt  | 2 +-
>  .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt      | 2 +-
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt  | 2 +-
>  Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-
>  Documentation/devicetree/bindings/net/fsl-fman.txt              | 2 +-
>  Documentation/devicetree/bindings/power/power_domain.txt        | 2 +-
>  Documentation/devicetree/bindings/regulator/tps65090.txt        | 2 +-
>  Documentation/devicetree/bindings/reset/st,sti-softreset.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt        | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards=
.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index bdadc3da9556..6970f30a3770 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -66,7 +66,7 @@ Required root node properties:
>         - "insignal,arndale-octa" - for Exynos5420-based Insignal Arndale
>                                     Octa board.
>         - "insignal,origen"       - for Exynos4210-based Insignal Origen =
board.
> -       - "insignal,origen4412    - for Exynos4412-based Insignal Origen =
board.
> +       - "insignal,origen4412"   - for Exynos4412-based Insignal Origen =
board.
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
