Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeDPOZA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:25:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33508 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeDPOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:24:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180416142455euoutp023acd241a6aae99edea770d33b6311375~l8LHZGA7o2110821108euoutp024
X-AuditID: cbfec7f4-b4fc79c0000043e4-eb-5ad4b2343620
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] thermal: exynos: remove separate exynos_tmu.h
 header file
Date: Mon, 16 Apr 2018 16:24:50 +0200
Message-ID: <4780353.WGAykbfPTG@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <fa04dbd9-fdb4-26e4-ac1d-2aa3a5840465@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7qmm65EGbSsZ7GY91nWYv6Va6wW
        /Y9fM1ucP7+B3eLyrjlsFp97jzBazDi/j8niycM+NgcOj52z7rJ7LN7zkslj06pONo871/aw
        eXzeJBfAGsVlk5Kak1mWWqRvl8CVcfjqLLaCfVwVs199Z2pgvMHRxcjJISFgIrFmx0bWLkYu
        DiGBFYwSf9f8ZIRwvjBKTJg5A8r5zChx9cAcFpiW5XOfg9lCAssZJTZeDIco+sAoceXGJVaQ
        BJuAlcTE9lWMILaIgJ5E4/s2JpAiZoFPjBJLmzrZQRLCAmESE54cBWtgEVCVuHbtFZjNK6Ap
        sfTaWTYQW1TAS2LLvnYmEJtTwE7i/cl2NogaQYmTM5+AXcEsIC/RcbkR7AkJgXXsEtN3TmGF
        ONVFYsbrZUwQtrDEq+Nb2CFsGYnTk3tYIBqaGSW+7djDDJGYwCixZ70QhG0tcfj4RaBBHEAb
        NCXW79KHCNtKHLy/kBEkLCHAJ3HjrSDEDXwSk7ZNZ4YI80p0tEENUZPYsGwDG8zWrp0roRZ5
        SBy98Jh5AqPSLCTfzELyzSyEvQsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJp3T
        /45/2cG460/SIUYBDkYlHt4dZy9HCbEmlhVX5h5ilOBgVhLhXZYIFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCUamB044uJ/FLUYGYzn/1jdNCrJFb7nPzl
        dftPzQq42WlodTaLsYdZpLX0nfpqNXnWC0cNH9776buyN9g2/e66rtRg22cuH44w7Jiy5nDu
        yYNHggor32eyPFwj5M+asGlyWxh7zMUEfeWAhSEhAeet/oaueZMZvOXBlpq+ezoKtqE3FrwR
        Yf/xYZkSS3FGoqEWc1FxIgDY7jvRNgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7rGm65EGdx6bGYx77Osxfwr11gt
        +h+/ZrY4f34Du8XlXXPYLD73HmG0mHF+H5PFk4d9bA4cHjtn3WX3WLznJZPHplWdbB53ru1h
        8/i8SS6ANUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
        LkEv4/DVWWwF+7gqZr/6ztTAeIOji5GTQ0LARGL53OcsXYxcHEICSxklmt9tBXI4gBIyEsfX
        l0HUCEv8udbFBlHzjlFiecckRpAEm4CVxMT2VWC2iICeROP7NiaQImaBN4wSR/d8YAVJCAuE
        SDyYcgGsiEVAVeLatVdgcV4BTYml186ygdiiAl4SW/a1M4HYnAJ2Eu9PtkNt28Eocbz/FjtE
        g6DEyZlPWEBsZgF5iY7LjawQto7Egt2f2CYwCs5CUjYLSdksJGULGJlXMYqklhbnpucWG+oV
        J+YWl+al6yXn525iBMbTtmM/N+9gvLQx+BCjAAejEg/vjrOXo4RYE8uKK3MPMUpwMCuJ8C5L
        BArxpiRWVqUW5ccXleakFh9iNAX6biKzlGhyPjDW80riDU0NzS0sDc2NzY3NLJTEec8bVEYJ
        CaQnlqRmp6YWpBbB9DFxcEo1MKp8ja/T4cnL2LVfWcjec9ZpXrPX7covmQx3pXIedmBpuHbY
        ZF8hX7X5nEazOYfZ3i/NPz31vV7lpheGj25dYnUukkyZw61d9E5n9zVTncX2f3lZFE6+kFjj
        wfbpyknTU7uO/XONmPAn9ETHRGGxvgq5Y141HJHa67PfbUhknML77eSKFa9erlZiKc5INNRi
        LipOBAAA2pP1vQIAAA==
X-CMS-MailID: 20180416142452eucas1p2feb091d3ba51e78f42e93e184eb01291
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416142452eucas1p2feb091d3ba51e78f42e93e184eb01291
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416142452eucas1p2feb091d3ba51e78f42e93e184eb01291
X-RootMTR: 20180416142452eucas1p2feb091d3ba51e78f42e93e184eb01291
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-13-git-send-email-b.zolnierkie@samsung.com>
        <fa04dbd9-fdb4-26e4-ac1d-2aa3a5840465@linaro.org>
        <CGME20180416142452eucas1p2feb091d3ba51e78f42e93e184eb01291@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 16, 2018 03:24:57 PM Daniel Lezcano wrote:
> On 16/04/2018 12:12, Bartlomiej Zolnierkiewicz wrote:
> > exynos_tmu.h is used only by exynos_tmu.c so there is no need
> > for a separate include file.
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++++++++-
> >  drivers/thermal/samsung/exynos_tmu.h | 41 ------------------------------------
> >  2 files changed, 17 insertions(+), 42 deletions(-)
> >  delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 7975f33..197f267 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -34,8 +34,10 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/cpu_cooling.h>
> > +
> 
> This one should go away, no ?

Yes, thanks for noticing (I've just sent v2 of this patch).
.
> Apart this.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
