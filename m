Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeBILR6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:17:58 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55860 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBILRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:17:55 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180209111752euoutp0183737d6d6280875784e2fc51b57a96aa~RpC9Qi76-3164131641euoutp01L
X-AuditID: cbfec7f4-f790c6d0000075d3-45-5a7d835f6596
Subject: Re: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg
 warning for syscon restart nodes
To: Adam Borowski <kilobyte@angband.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <06515e72-d7b3-9799-698e-d8b2dd39e22a@samsung.com>
Date: Fri, 09 Feb 2018 12:17:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180209104806.vcrrtpq6izcnwvy2@angband.pl>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3u3l1Hk1/T8mCRMnoZ5AMMfpnZA6vbH0EPMlqJjryo+ci2
        JvYQV2bZshTTtGlLLI1EseaDFJJSc0MjFU0x0kTLR2a1lNB81bwT/O9zzvme3znfw4+l5CO0
        KxsZe4FXx6qiFYxUXN003bo1JDlR6W3JdiX9xmqGzGU2SciL3HKa/CxOQ6R7cpgmjxrf0yR9
        cIwizx7OMaS19bmEmAa7aNJRm8+Q3NY6EanPfoVIUXe7iDR3TzCksGpSQlJeNUrIqNUi3i3n
        iqzVFFdqLEVcR1c7xc38zUScqeQWw1U8SeI6Lddo7m5lCeImTOsOOyil/mF8dGQ8r/YKCJVG
        PG8uZuK6pAmNpT20DrWzeuTAAvYFY9qcWODV0NZXzuiRlJXjIgT9vW8pIZhA8LqqgFnqMP+u
        tBeKEUzpG2ghGEYwU3Bbokcs64Qjobic2Bqc8Sb4MdS7qKHwdRparg5TtgKDfUA/rmdsehkO
        gD7jHltajDeAqefO4jOr8GkYm91vS8vwSpi617e4qQPeDrfyMpGNKewHQ/MptMBuUFE6Tgns
        AskpPWLbWMB1Eki3ZNhtBsLC/EdaYCf4Zq6UCLwWOu7dtjekI5hfGBUJQS6CcmuKXbUDGszt
        9nGOkFmdQ9k2BSyD1BtyQcLBwDudSOA9YJgcsR/oO4KsgVQqA7kZljkyLHNhWObCsMxFARKX
        IGdeq4kJ5zW+nhpVjEYbG+555lyMCf3/fy3z5smX6HGTXz3CLFKskGWcvqKU06p4zcWYegQs
        pXCWxQcnKuWyMNXFS7z6XIhaG81r6tEaVqxwke1U3jgpx+GqC3wUz8fx6qWqiHVw1aEzQeOh
        cdaShK95hem4bONBj+Aj2yonDn3gAoJOhOo4DsynsvRtM16FTS7rZ/fuU3mQY1o/XY5H/omj
        N2uOH6g4e7nT3T9wZY3jL87yJ8Hy4AtnfNqWuPlj/JT2YNQp4j5ksD5u+ZQ0HTvKfx5yL5PP
        jPSer90V+ibN+77/oOVZhEKsiVD5bKHUGtU/WYcm0HsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RXUhTYRiA+3Z+djYcnZbhh0HpIAaWpiX2GSGGN+cqA2/sYOVBD2pzapuu
        jCxLhRz9iD8wZs5IJyrT9DhFSiPm8C9omTEbmGRCKjZ1bZllWs0R7O553/d5rl4Kkwt4OJVX
        UMxrCrh8BSnFX++MOaMvVZSxsS1tSvTJNECi7dpRMeo1PCPQWtt9gGZ8iwRqtr8h0KOFFQx1
        NG2TyOHoESNhwUmg6eePSWRwvBQhW8MwQOaZKRGanPGS6Gm/T4yqhu1itOwZx5PljNkzgDEW
        kwUw084pjNn6VQsYobOaZPpabzPvx+8SzENrJ2C8wqHzElZ6JpvPz9PxmuNJmdLcnsk2ssgp
        vW63uIhyMEXpgYSCdDwc+2bF9EBKyelWAPvtg+LAsAjg/IZJ7Lf203nwz2yvyM+htBKufvlI
        +CWMriRg0/x3UaBYBbCy0bNbkHQc1Lv1pB5QlIxOgnOms/41Th+BguvBrnKAzoANnl7CzzJ6
        H9ysm8P9LKETYXVjLfAzRidA3/IIEeDDsM/ixgIcBiuqXHgNoI1BuTEoMQYlxqDkCcA7QShf
        olXnqLUnYrScWltSkBOTVagWwL9PDoz+tA4C/WqaDdAUUITI2odusnKC02lL1TYAKUwRKtNd
        LGPlsmyu9AavKbysKcnntTZwkMIVYTJHbCkrp3O4Yl7F80W85v9VREnCywHnHY6MTlXO1R+N
        an2XYq7piEiP2psR0f12TZNy70K9eyQ5sktnELUru1S+9ZNs91Jd1sqer7c+GLcFc+xszLmN
        hvXU04nJwK6Md038hukt2IssNi16i1i6suM+ZTaEWO+QrMq7kNC8s3nMNpG5NHTVVS1U/Ji+
        tl6n+lz8SoFrc7m4KEyj5f4CmTIE6cUCAAA=
X-CMS-MailID: 20180209111750eucas1p1d44a825deb0d40cf5d5b25bdb7de91dd
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9
X-RootMTR: 20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9
References: <CGME20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9@epcas1p2.samsung.com>
        <20180130211819.17139-1-krzk@kernel.org>
        <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
        <20180209104806.vcrrtpq6izcnwvy2@angband.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 2018-02-09 11:48, Adam Borowski wrote:
> On Thu, Feb 08, 2018 at 02:46:32PM +0100, Marek Szyprowski wrote:
>> On 2018-01-30 22:18, Krzysztof Kozlowski wrote:
>>> Changes since v1:
>>> 1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
>>>      following Rob's advice.
>>> 2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
>>>      on this.
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> Tested following boards and reboot works fine:
>> Exynos3250 (artik5-eval)
>> Exynos4412 (trats2)
>> Exynos5410 (odroid xu)
>> Exynos5422 (odroid xu3/xu4)
>> Exynos5433 (tm2)
> Doesn't seem to work on mine:
> Exynos4412 (odroid u2)
>
> Rebooting worked correctly with 3.8 + gazillion non-mainlined patches (as
> shipped with providen images), never did with mainline.
>
> Tested on current mid-of-the-merge-window, plus these four patches.
>
>
> It's possible that I'm doing something wrong; might need an updated u-boot,
> etc.  Log of a boot-till-reboot+hang session attached.

Reboot on Odroid X2/U2/U3 doesn't work now. It is broken by devfreq since
a few kernel releases. Please disable devfreq in your .config and reboot
should also work. That's why I didn't put Odroid U3 on the above list.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
