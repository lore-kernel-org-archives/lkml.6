Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbeBOJvJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:51:09 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37027 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbeBOJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:51:04 -0500
X-Google-Smtp-Source: AH8x2244t55scHTdR1v2FZK5jgpQzntwEX0jAWPwMgnXGyDQ5sNlKmGuG/bj7g/7YZvr+vpQf6k7hcDMq+C90CjTY9s=
MIME-Version: 1.0
In-Reply-To: <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk> <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 15 Feb 2018 10:50:22 +0100
Message-ID: <CAOFm3uFJC2Xb0PuNECJ-Tvg2gQS==tMSc77p_keQoCexNqOkDg@mail.gmail.com>
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA <alsa-devel@alsa-project.org>, linux-omap@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sebastian,

On Wed, Feb 14, 2018 at 11:07 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Motorola CPCAP is a PMIC with audio functionality, that can be
> found on Motorola Droid 4 and probably a few other phones from
> Motorola's Droid series.
>
> The driver has been written from scratch using Motorola's Android
> driver, register dumps from running Android and datasheet for NXP
> MC13783UG (which is similar to Motorola CPCAP, but not the same).
>
> The chip provides two audio interfaces, that can be muxed to two
> different audio codecs. One provides support for stereo output
> (named StDAC or HiFi), while the other only provides mono output
> (named Voice). Only the Voice codec provides a Capture interface.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

<snip>

> --- /dev/null
> +++ b/sound/soc/codecs/cpcap.c
> @@ -0,0 +1,1588 @@
> +/*
> + * ALSA SoC CPCAP codec driver
> + *
> + * Copyright (C) 2017 - 2018 Sebastian Reichel <sre@kernel.org>
> + *
> + * Very loosely based on original driver from Motorola:
> + * Copyright (C) 2007 - 2009 Motorola, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */

Could you consider using the new SPDX tags instead of this fine but
long legalese? [1]

<snip>

> +MODULE_ALIAS("platform:cpcap-codec");
> +MODULE_DESCRIPTION("ASoC CPCAP codec driver");
> +MODULE_AUTHOR("Sebastian Reichel");
> +MODULE_LICENSE("GPL");

This does not match your license: per module.h, GPL means GPL-2.0 or
later. You notice above is GPL-2.0, not "or later"

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

-- 
Cordially
Philippe Ombredanne
