Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeBLKAz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932505AbeBLKAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:00:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46CE21779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x224+w3yj2mdzEomQHDZQ9jbPe8Fuay5rb3i7XnuNbrn0xG+Kfid19ffLJbz3FG76A2Bz3vJhXH29ueJB1a5G/s8=
MIME-Version: 1.0
In-Reply-To: <7f86ec02-2235-7622-9298-f6edd367edb2@samsung.com>
References: <CGME20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4@epcas1p4.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com> <20180205154403.13520-5-s.nawrocki@samsung.com>
 <CAJKOXPf-6wFDSPttdDbc34Y2hiuc=TG2j5bb+2uQeScxGuxjZg@mail.gmail.com> <7f86ec02-2235-7622-9298-f6edd367edb2@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 12 Feb 2018 11:00:50 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeHDHbt8e+aVd6RCv3M+AW7qPVep=Cb7nBJeZn3k+u5Bg@mail.gmail.com>
Message-ID: <CAJKOXPeHDHbt8e+aVd6RCv3M+AW7qPVep=Cb7nBJeZn3k+u5Bg@mail.gmail.com>
Subject: Re: [PATCH 4/8] ASoC: samsung: i2s: Define the parameters list for SAMSUNG_I2S_OPCLK
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

On Wed, Feb 7, 2018 at 5:23 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 02/06/2018 01:26 PM, Krzysztof Kozlowski wrote:
>> On Mon, Feb 5, 2018 at 4:43 PM, Sylwester Nawrocki
>> <s.nawrocki@samsung.com> wrote:
>
>>> diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
>>> index 79781de2f247..a9832a9555cb 100644
>>> --- a/sound/soc/samsung/i2s.h
>>> +++ b/sound/soc/samsung/i2s.h
>>> @@ -16,11 +16,16 @@
>>>  #define SAMSUNG_I2S_DAI        "samsung-i2s"
>>>  #define SAMSUNG_I2S_DAI_SEC    "samsung-i2s-sec"
>>>
>>> -#define SAMSUNG_I2S_DIV_BCLK   1
>>> +#define SAMSUNG_I2S_DIV_BCLK           1
>>>
>>> -#define SAMSUNG_I2S_RCLKSRC_0  0
>>> -#define SAMSUNG_I2S_RCLKSRC_1  1
>>> +#define SAMSUNG_I2S_RCLKSRC_0          0
>>> +#define SAMSUNG_I2S_RCLKSRC_1          1
>>>  #define SAMSUNG_I2S_CDCLK              2
>>> +/* Operation clock for IIS logic */
>>>  #define SAMSUNG_I2S_OPCLK              3
>>> +#define  SAMSUNG_I2S_OPCLK_CDCLK_OUT   0       /* CODEC clock out */
>>> +#define  SAMSUNG_I2S_OPCLK_CDCLK_IN    1       /* CODEC clock in */
>>> +#define  SAMSUNG_I2S_OPCLK_BCLK_OUT    2       /* Bit clock out */
>>> +#define  SAMSUNG_I2S_OPCLK_PCLK                3       /* Audio bus clock */
>>>
>>>  #endif /* __SND_SOC_SAMSUNG_I2S_H */
>>
>> This part of patch seems to be unrelated (and it includes some cleanups).
>
> This is actually the main part of the patch, an API exported to other
> drivers.

You are right, I looked at it without the context of 5/8 and I assumed
you are changing existing user of the defines...

> The whitespace changes are for keeping the alignment uniform,
> I could just drop them.

Let it be then.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
