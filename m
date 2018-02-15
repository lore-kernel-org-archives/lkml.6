Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbeBOJjr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:39:47 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38657 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbeBOJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:39:42 -0500
X-Google-Smtp-Source: AH8x227nXYt4W1T6aGNJWBNNHNqWg3i5kIryDJma8mTxTtEcoHvo1JQ2DWCup2jPvSKZf6ZkpaYB4OHIfhzziOBb8Ps=
MIME-Version: 1.0
In-Reply-To: <E1elzv3-0005l2-MP@debutante>
References: <1518532988-10990-1-git-send-email-harald@ccbib.org> <E1elzv3-0005l2-MP@debutante>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 10:39:41 +0100
X-Google-Sender-Auth: 5ateWDLJz-FVEnLoZyCcSv_DIIg
Message-ID: <CAMuHMdVLO4Y-NzS6bLp2dUy1oSqmEthC_yD5jCe_R9H4vWBwMA@mail.gmail.com>
Subject: Re: Applied "regulator: dt: regulator-name is required property" to
 the regulator tree
To: Mark Brown <broonie@kernel.org>
Cc: Harald Geyer <harald@ccbib.org>, Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 5:28 PM, Mark Brown <broonie@kernel.org> wrote:
> The patch
>
>    regulator: dt: regulator-name is required property
>
> has been applied to the regulator tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From 4b75291621830acad2c66a1d21d7840a7ca169d3 Mon Sep 17 00:00:00 2001
> From: Harald Geyer <harald@ccbib.org>
> Date: Tue, 13 Feb 2018 14:43:08 +0000
> Subject: [PATCH] regulator: dt: regulator-name is required property
>
> These two drivers fail to probe if no name is provided. For details see:
> https://www.spinics.net/lists/kernel/msg2457515.html
>
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

What about using the DT node name instead, as is done for single-output
clocks?

> ---
>  Documentation/devicetree/bindings/regulator/fixed-regulator.txt | 1 +
>  Documentation/devicetree/bindings/regulator/gpio-regulator.txt  | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> index 4fae41d54798..0c2a6c8a1536 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> @@ -2,6 +2,7 @@ Fixed Voltage regulators
>
>  Required properties:
>  - compatible: Must be "regulator-fixed";
> +- regulator-name: Defined in regulator.txt as optional, but required here.
>
>  Optional properties:
>  - gpio: gpio to use for enable control
> diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> index dd1ed789728e..1f496159e2bb 100644
> --- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> @@ -2,6 +2,8 @@ GPIO controlled regulators
>
>  Required properties:
>  - compatible           : Must be "regulator-gpio".
> +- regulator-name       : Defined in regulator.txt as optional, but required
> +                         here.
>  - states               : Selection of available voltages and GPIO configs.
>                            if there are no states, then use a fixed regulator

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
