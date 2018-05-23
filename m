Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeEWIeq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754331AbeEWIem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:34:42 -0400
X-Google-Smtp-Source: AB8JxZqyxl7thf8/hvdM5ZdtccVArUKLQdUZ+eIhO75+bUjbbU5f1NFcS0suEZhINEwPXRZ/qQ6qbylBWL6eLVQClos=
MIME-Version: 1.0
In-Reply-To: <f762464c796fa1976c1ec6fde6869add@agner.ch>
References: <1526543103-21668-1-git-send-email-krzk@kernel.org>
 <cbcc6f929d2bd912c11530391d03cdf3@agner.ch> <CAJKOXPeOg7Xjx0qr2qZ0dLs56HFD=1=gbGh8VPeS+PgQm6QQZg@mail.gmail.com>
 <f762464c796fa1976c1ec6fde6869add@agner.ch>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 23 May 2018 10:34:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdwVNtDCiow-cYFdgeUVO5UuEtgmrdmHi2SvHeoZfPupg@mail.gmail.com>
Message-ID: <CAJKOXPdwVNtDCiow-cYFdgeUVO5UuEtgmrdmHi2SvHeoZfPupg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: dts: tegra: Remove skeleton.dtsi and fix DTC
 warnings for /memory
To: Stefan Agner <stefan@agner.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:22 AM, Stefan Agner <stefan@agner.ch> wrote:
> On 23.05.2018 09:05, Krzysztof Kozlowski wrote:
>> On Thu, May 17, 2018 at 1:39 PM, Stefan Agner <stefan@agner.ch> wrote:
>>> On 17.05.2018 09:45, Krzysztof Kozlowski wrote:
>>> Could we not add
>>>
>>>         memory { device_type = "memory"; };
>>>
>>> in the SoC level device trees?
>>>
>>> This would save device_type in all other instances.
>>>
>>> That is also how it is done in other places, e.g.
>>> arch/arm/boot/dts/imx6qdl.dtsi
>>
>> Not really because the unit address will not match between different
>> boards. The imx6qdl, as I see, has the same issue:
>>  - imx6qdl.dtsi defines "memory" node
>>  - imx6dl-apf6dev.dts includes the previous and defines "memory@10000000"
>>
>> This is wrong - two memory nodes.
>>
>
> Hm I see. We could add
>
> memory@0 { device_type = "memory"; };
>
> Since the reg property is specified in the board level device tree it
> would be still fine?
>
> Or probably better to provide a complete spec with length zero:
>
> memory@0 {
>         device_type = "memory";
>         reg = <0x0 0x0>;
> };
>
> Even some boards do that and assume that boot loader will fill it
> correctly, so that should be fine.

That could be the solution although tegra30-apalis.dtsi is a problem
here. For Tegra 114, 124 and 20 it would work fine - all boards from
given SoC have the same address of memory (0x0 or 0x80000000). However
for Tegra30 the Apalis did not have any memory reg before so I am not
sure what should be used. I added 0x0. The other Tegra30 boards have
memory@80000000.

Best regards,
Krzysztof
