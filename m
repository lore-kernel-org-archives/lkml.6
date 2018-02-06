Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbeBFNCW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753040AbeBFNCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:02:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE31A21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x2270lLAW2sWjb7L9Fsh+pyjSv77i0scaHgAPZASl84nqTzoXeD4kbx4AqZBoIMrBun1iVO7Ug4Lspju0gE+fsSw=
MIME-Version: 1.0
In-Reply-To: <20180205154403.13520-8-s.nawrocki@samsung.com>
References: <CGME20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d@epcas2p2.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com> <20180205154403.13520-8-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Feb 2018 14:02:11 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc_NUa2worczHpm4VoTY9Do1-Gq4-711kLz7W0qowTeGQ@mail.gmail.com>
Message-ID: <CAJKOXPc_NUa2worczHpm4VoTY9Do1-Gq4-711kLz7W0qowTeGQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] ASoC: samsung: Add missing #sound-dai-cells property documentation
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:44 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The #sound-dai-cells property might be helpful in selecting primary
> or secondary CPU DAI and it's already present in i2s nodes for some
> exynos SoCs so let's add it to the DT binding documentation.

The description above looks like you are documenting existing optional
property but you added it as a required property.

Best regards,
Krzysztof

>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  Documentation/devicetree/bindings/sound/samsung-i2s.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> index 5d7bb2735824..dd1b6e329941 100644
> --- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> @@ -54,6 +54,9 @@ in the IIS Multi Audio Interface.
>  Note: Old DTs may not have the #clock-cells property and then not use the I2S
>  node as a clock supplier.
>
> + - #sound-dai-cells: should be 1.
> +
> +
>  Optional SoC Specific Properties:
>
>  - samsung,idma-addr: Internal DMA register base address of the audio
> @@ -79,4 +82,5 @@ i2s0: i2s@3830000 {
>         samsung,idma-addr = <0x03000000>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2s0_bus>;
> +       #sound-dai-cells = <1>;
>  };
> --
> 2.14.2
>
