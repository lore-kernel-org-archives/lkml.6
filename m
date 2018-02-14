Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031498AbeBNVfr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:35:47 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:47089 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:35:45 -0500
X-Google-Smtp-Source: AH8x224hWp8gINOb2DkhdM5SAsR4kZZbnREpTcoQvOch/Idny6P7WItFb82jYtFyvnOJETq9/cQWViUDM0K4HFRY45w=
MIME-Version: 1.0
In-Reply-To: <1518614467-20613-2-git-send-email-cosmin.samoila@nxp.com>
References: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com> <1518614467-20613-2-git-send-email-cosmin.samoila@nxp.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Wed, 14 Feb 2018 22:35:04 +0100
Message-ID: <CAOFm3uGJU+bVAkL-F9R6Xk05rSkNgt14YT7sXSZhdE2QkrH_Bg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for AK4458 DAC driver
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: Mark <broonie@kernel.org>, ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, mihai.serban@gmail.com,
        linux-imx@nxp.com, shegjiu.wang@nxp.com, daniel.baluta@nxp.com,
        LKML <linux-kernel@vger.kernel.org>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 2:21 PM, Cosmin-Gabriel Samoila
<cosmin.samoila@nxp.com> wrote:
> The AK4458 is a 32-bit 8ch Premium DAC that corresponds
> to a 768kHz PCM input and an 11.2MHz DSD input at maximum.
> It supports I2S, DSD and TDM modes with 24 or 32 bit MSB
> or 16, 24, 32 LSB formats. Its datasheet is available here:
> https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
> ---

> --- /dev/null
> +++ b/sound/soc/codecs/ak4458.c
> @@ -0,0 +1,659 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Audio driver for AK4458 DAC
> + *
> + * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
> + * Copyright 2018 NXP

Thanks for using the proper SPDX tag here.... yet see my comments below.

<snip>

> +MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
> +MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
> +MODULE_DESCRIPTION("ASoC AK4458 DAC driver");
> +MODULE_LICENSE("GPL");

This means GPL-2.0+ per module.h and therefore does not match your
GPL-2.0 SPDX tag above.
Go one way or the other, but not both way please.

> diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
> new file mode 100644
> index 0000000..16d9d22
> --- /dev/null
> +++ b/sound/soc/codecs/ak4458.h
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0

As weird as it sounds the style should be plain /*
SPDX-License-Identifier: GPL-2.0 /* here per [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

-- 
Cordially
Philippe Ombredanne
