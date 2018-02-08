Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBHNql (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:46:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39737 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeBHNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:46:38 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180208134635euoutp0159e9a1abba9d6e5e8981c471a32c3060~RXbhcnw9x2157821578euoutp01d
X-AuditID: cbfec7f4-f790c6d0000075d3-a8-5a7c54ba4044
Subject: Re: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg
 warning for syscon restart nodes
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
Date: Thu, 08 Feb 2018 14:46:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180130211819.17139-1-krzk@kernel.org>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfO2TmuTpyWlyeLhNENq1Vg8KZldznklz7Uh2ZiIw8qOZNN
        Rc1SlMVc0UVZjilWTkXEtKaO7qATjQxNLC9QJhrZNKnhqTRL63QW+O33f5//8zzv/+VlCPUo
        FcqkpGUIxjR9qkapIt2dcz3bHh3P0+3wWsPxaKVbiX+XdNL4vr2Jwl9qryA8KE5Q+FZHD4Wv
        jU8RuLf3Ho1d4wMU7n9UocT23mcK3G57inDNYJ8CvxicUeKqVpHG5qcdNPb6npP7V/INlQ2I
        7x/oI/j5nyWId9UXK/nm6nz+9fNCir/aUo/4Gde6Y4xOtSdRSE3JEozbo0+rkp3fFqj04hXZ
        FpuTLkB3VFYUwAAXAf32eVrmYHg10qS0IhWj5moQTIh3FbKYQTB8+Tb9v2No2EbIhVoE9aLd
        75pAMDjXSlkRw6ziUqC2CUvngdx1AubLS2lJEJyIwFNa92+UktsJ1mmrUmKWiwant5GQmOQ2
        wLvhd7Q0KIg7BVO/YmTLSpgtHSElDuB2wY/GNoXEBBcJHxfMlMxh0NwwTcgcAkXmYVLaC5yb
        htfWElKOcBjE/m5/nFUw2dXi57VQbGlTyA3XECwsev3CjqDJZ/a7osDT1edftwJK3GWEdFPg
        WLBcUssWHsZeFihkPgAO8RMlP5EFQcWQl7qOwhxLEjmWpHAsSeFYkuI2IutRoJBpMiQJpgit
        SW8wZaYlac+cM7jQ33/XvdAlPkDOzsh2xDFIs5z9uvu8Tk3ps0w5hnYEDKEJZJ8E5enUbKI+
        J1cwnkswZqYKpna0hiE1Iexe3aWTai5JnyGcFYR0wfi/qmACQgvQDWtMxWUtF/i5aAftWJ8a
        VRX0+AQ7hM8Ge9JtHt+hRvM+duMTW8jsm9zmRG1p4ost2TcfNvjmfWPvqxfjP9x8tezIUbfq
        0K+kyOo6Q7NjpjzHvIlg70YO4dC4PVs921cfjJ12xId+VxwtzEkeidDGXXRtLot+O3khNr8w
        YVa0FGtIU7J+ZzhhNOn/AIAewsBzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xy7q7QmqiDI4c57R4MG8bm8XfScfY
        LTbOWM9q8X5ZD6PF9S/PWS3mHznHatH/+DWzxfnzG9gtNj2+xmpxedccNosZ5/cxWRyaupfR
        Yun1i0wWp65/ZrNYtPULu0Xr3iPsFi8/nmBxEPRYM28No8flaxeZPX7/msTosWlVJ5vH5iX1
        HldONLF69G1ZxejxeZNcAEcUl01Kak5mWWqRvl0CV8bir/9YCzr5KjqmLmZvYFzI1cXIySEh
        YCJx4+ZUZghbTOLCvfVsXYxcHEICSxglvl+fzQLhPGeUODfjCDtIlbBApsT/OxuZQBIiAhOY
        JR63nQNzmAW+MEqc7zjHCNHSxSjx+ssTsMFsAoYSXW+72EBsXgE7icUv14HFWQRUJe7evAs2
        VlQgRmLqx42sEDWCEj8m32MBsTkFTCW+rzvIBGIzC5hJfHl5mBXClpfYvOYtM4QtLtHcepNl
        AqPgLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBsbnt2M/NOxgv
        bQw+xCjAwajEw/vBsjpKiDWxrLgy9xCjBAezkgjvHtGaKCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2MgVor6zfy75Jw8mgUTqhh32y9IO4Y07I+Kbfb
        m6r416ZsCivg1JD75pP7WNJ+tg7Tzb7sNTbrk1m26DxWO1R21zH517951cXHGzRc7HXd/q/4
        dlzeMttbQetthLqr33frx19lrpy4tcNyfdr7NX2enbZ22+Jedjpv2BsoXrt6z84n6tdd5mgq
        sRRnJBpqMRcVJwIA1maAf8kCAAA=
X-CMS-MailID: 20180208134634eucas1p1c4858334217aa881ac0b834048391a5c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9
X-RootMTR: 20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9
References: <CGME20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9@epcas1p2.samsung.com>
        <20180130211819.17139-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-01-30 22:18, Krzysztof Kozlowski wrote:
> Hi,
>
> Changes since v1:
> 1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
>     following Rob's advice.
> 2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
>     on this.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested following boards and reboot works fine:
Exynos3250 (artik5-eval)
Exynos4412 (trats2)
Exynos5410 (odroid xu)
Exynos5422 (odroid xu3/xu4)
Exynos5433 (tm2)

> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (4):
>    soc: samsung: pmu: Populate children syscon nodes
>    ARM: dts: exynos: Remove duplicated inclusion of syscon restart nodes
>      on Exynos5410
>    ARM: dts: exynos: Fix missing missing reg warning for syscon restart
>      nodes
>    arm64: dts: exynos: Fix missing missing reg warning for syscon restart
>      nodes
>
>   .../devicetree/bindings/arm/samsung/pmu.txt        |  6 +++++
>   arch/arm/boot/dts/exynos-syscon-restart.dtsi       | 28 ++++++++++------------
>   arch/arm/boot/dts/exynos3250.dtsi                  |  2 +-
>   arch/arm/boot/dts/exynos4.dtsi                     |  3 ++-
>   arch/arm/boot/dts/exynos5.dtsi                     |  1 -
>   arch/arm/boot/dts/exynos5250.dtsi                  |  1 +
>   arch/arm/boot/dts/exynos5410.dtsi                  |  2 +-
>   arch/arm/boot/dts/exynos5420.dtsi                  |  1 +
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 14 +++++------
>   arch/arm64/boot/dts/exynos/exynos7.dtsi            | 12 +++++-----
>   drivers/soc/samsung/exynos-pmu.c                   |  3 +++
>   11 files changed, 40 insertions(+), 33 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
