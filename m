Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeD3PVt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:21:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56672 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbeD3PVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:21:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180430152144euoutp0295c60ee16b80a66ca366d93f53b5406b~qP_t26tzt0436704367euoutp02Q
X-AuditID: cbfec7f2-1c1ff70000011644-8d-5ae734862cdc
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] thermal: exynos: fix setting rising_threshold for
 Exynos5433
Date: Mon, 30 Apr 2018 17:21:40 +0200
Message-id: <1562606.5jxUSbM0dm@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180430143656.GH11457@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djPc7ptJs+jDDY/YLGY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvj7vqZzAXvxCteXnnG2sDYIdTFyMkhIWAiMe3fC1YQW0hgBaPE55tJEPZnRon+I+Yw
        NZ1/XjN3MXIBxZcxShz/M50NwvnNKPF4SSsLSBWbgJXExPZVjCC2iICeROP7NiaQImaBVUCT
        Pr1jAkkIC0RKLP7TzwZiswioSjR8/M4MYvMKaEr8udoHZosKeEls2dcOVs8JFJ+85w4bRI2g
        xI/J98CWMQvIS+zbP5UVwtaROHtsHSPIMgmBFWwSK16cYYa420Xi6MEWFghbWOLV8S3sELaM
        xOXJ3SwQDc2MEt927IFqmMAosWc9NGCsJQ4fvwi1gU9i0rbpQDUcQHFeiY42qBIPiTX/zkK1
        OkpMP3UcGiy/GCWuLjnGNoFRdhaSw2chOXwWksMXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L
        10vOz93ECEwJp/8d/7SD8eulpEOMAhyMSjy8HPLPo4RYE8uKK3MPMUpwMCuJ8K7seBYlxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnDdOoy5KSCA9sSQ1OzW1ILUIJsvEwSnVwBhoVbXSoEGL7wDf
        7lQ3CXO5qvtTBKR/Nr9y3FG3PiT05aqYXy9i58hN/rja/aHq0sT37zcluj6LCrVfsuZK9OR6
        lilO3GumNnJcPHdl+jvGY/MivnEc9J6r22hybvNi4aLbG1NT9GNY3klEvQ9dzMfT415QsHK/
        5s2Pvh1nlgXP/LPzh/iib8pKLMUZiYZazEXFiQBNf5OaBQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xq7qtJs+jDDb+YLKY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvj7vqZzAXvxCteXnnG2sDYIdTFyMkhIWAi0fnnNTOILSSwhFGi84hbFyMXkP2XUeLx
        u35WkASbgJXExPZVjCC2iICeROP7NiaQImaBVYwSK1t7wbqFBSIlFv/pZwOxWQRUJRo+fgeL
        8wpoSvy52gdmiwp4SWzZ184EYnMCxSfvucMGsW0Zo8TTR68ZIRoEJX5MvscCYjMLyEvs2z+V
        FcLWkli/8zjTBEb+WUjKZiEpm4WkbAEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAwN12
        7OeWHYxd74IPMQpwMCrx8HLIP48SYk0sK67MPcQowcGsJMK7suNZlBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQZGA7nWCztuZRkYpytzWluwihc6Lqwp
        PHE5uNxhp2shI6clr6RsiWz32tbVsfnvjx7MWrZZfuEH6aCEtdP8f97aWL3hZc/lqk/by+5/
        jrKdNsPi5LqgD0v8Xb2lIqI6zkVwLRD03WU+cfoM+zkvI/nMtPMu/GH7ucDdVcjpyPIPuaGX
        tCr5rfWUWIozEg21mIuKEwEwiRBuWAIAAA==
X-CMS-MailID: 20180430152141eucas1p2f39d7e8ee83a1fa66ccd19f74442357f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180430152141eucas1p2f39d7e8ee83a1fa66ccd19f74442357f
X-RootMTR: 20180430152141eucas1p2f39d7e8ee83a1fa66ccd19f74442357f
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-2-git-send-email-b.zolnierkie@samsung.com>
        <20180430143656.GH11457@mai>
        <CGME20180430152141eucas1p2f39d7e8ee83a1fa66ccd19f74442357f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 30, 2018 04:36:56 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:16PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Add missing clearing of the previous value when setting rising
> > temperature threshold.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index cda716c..523d26e 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -577,6 +577,7 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
> >  		threshold_code = temp_to_code(data, temp);
> >  
> >  		rising_threshold = readl(data->base + rising_reg_offset);
> > +		rising_threshold &= ~(0xff << j * 8);
> >  		rising_threshold |= (threshold_code << j * 8);
> 
> Bartlomiej,
> 
> I see this code is duplicated all around the driver, so I can't blame you to
> fix it in the same way it is written today but this is not how to deal with

This patch is a bugfix (which may be backported later) and it shouldn't be
mixed with cleanups.

> fields in a register mapping. Can you fix it by adding correct macros with
> masks?

After my patch series we still have following occurrences of "RMW" code:

        th = readl(data->base + EXYNOS_THD_TEMP_RISE);
        th &= ~(0xff << 8 * trip);
        th |= temp_to_code(data, temp) << 8 * trip;
        writel(th, data->base + EXYNOS_THD_TEMP_RISE);

        th = readl(data->base + EXYNOS_THD_TEMP_FALL);
        th &= ~(0xff << 8 * trip);
        if (hyst)
                th |= temp_to_code(data, temp - hyst) << 8 * trip;
        writel(th, data->base + EXYNOS_THD_TEMP_FALL);

        th = readl(data->base + reg_off);
        th &= ~(0xff << j * 8);
        th |= (temp_to_code(data, temp) << j * 8);
        writel(th, data->base + reg_off);

        th = readl(data->base + reg_off);
        th &= ~(0xff << j * 8);
        th |= (temp_to_code(data, temp - hyst) << j * 8);
        writel(th, data->base + reg_off);

        th = readl(data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
        th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
        th |= temp_to_code(data, temp) << (16 * bit_off);
        writel(th, data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);

        th = readl(data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
        th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
        th |= temp_to_code(data, temp - hyst) << (16 * bit_off);
        writel(th, data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);

My personal opinion is that adding new macro for the code above will
only obfuscate it and make it harder to understand,

Anyway how would you like this new macro to look like (how generic or
specific it should be etc.)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
