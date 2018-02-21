Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBUUQK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:16:10 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41375 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBUUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:16:08 -0500
X-Google-Smtp-Source: AH8x225DGEDrNGpT3+VyccEKvSnUby5dIuIfkUmz0mGmP9d59zr4OvRmUuXf/1Z38ieVPWo2cPGwFQ==
Subject: Re: [RESEND PATCH v2 2/2] ASoC: topology: Add missing clock gating
 parameter when parsing hw_configs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20180220174446.7784-1-k.marinushkin@gmail.com>
 <20180220174446.7784-3-k.marinushkin@gmail.com>
 <CAHp75Vc451W4GvvVCv-70EO6Cgn99Y+HV9xb530nJ72aT79rLQ@mail.gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <c30eb9d9-11ff-f5c9-bb4e-ab0f9a8f4c09@gmail.com>
Date: Wed, 21 Feb 2018 21:16:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc451W4GvvVCv-70EO6Cgn99Y+HV9xb530nJ72aT79rLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/18 15:50, Andy Shevchenko wrote:
> On Tue, Feb 20, 2018 at 7:44 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>> Clock gating parameter is a part of `dai_fmt`. It is supported by
>> `alsa-lib` when creating a topology binary file, but ignored by kernel
>> when loading this topology file.
>> +               /* clock gating */
>> +               if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
>> +                       link->dai_fmt |= SND_SOC_DAIFMT_GATED;
>> +               else if (hw_config->clock_gated ==
>> +                        SND_SOC_TPLG_DAI_CLK_GATE_CONT)
> A nit, I would leave it on the same line, even if it ~2-3 characters
> longer than 80.

Hello Andy,

Thank you for the comment.

I think it is important to stay in the length of 80. I understand your point, but from my perspective, the coding style is a higher priority guideline.

Therefore I would prefer to keep this line as it is now.

Beast Regards,
Kirill

>> +                       link->dai_fmt |= SND_SOC_DAIFMT_CONT;
>> +
