Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbeDPMuE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:50:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46149 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeDPMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:50:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416124959euoutp018ec49095e35764d659aefe0f1577e198~l64OF5zLp1488914889euoutp01T
X-AuditID: cbfec7f5-b45ff700000028a9-41-5ad49bf5ea79
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
Date: Mon, 16 Apr 2018 14:49:55 +0200
Message-ID: <21168314.MLeXVVoknU@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <22d7f063-9a69-78cf-e0fd-2043e187244e@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7pfZ1+JMtj3XNpi3mdZi/lXrrFa
        9D9+zWxx/vwGdovLu+awWXzuPcJoMeP8PiaLtUfusls8edjH5sDpsXPWXXaPxXteMnlsWtXJ
        5nHn2h42j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4MpYsncjc8EUmYqeC38YGxhPiXUxcnJI
        CJhInHmxhK2LkYtDSGAFo8TrX6uZIJwvjBJ7Vl9nhXA+M0os3P+QFabl6N7VUC3LGSVmrvsE
        5XxglJj/4ygzSBWbgJXExPZVjCC2iICeROP7NrC5zALzmSTOdS9mAUkICwRLPFz/nwnEZhFQ
        lVg8CaSBg4NXQEti6ldvkLCogJfEln3tYCWcAnYSl1uPsoHYvAKCEidnPgEbwywgL9FxuRHs
        VAmBXewSf+/9ZoI41UXiZvN+NghbWOLV8S3sELaMxOnJPSwQDc2MEt927GGGSEwA+nq9EIRt
        LXH4+EVWkIOYBTQl1u/ShwjbSjSsPckOEpYQ4JO48VYQ4gY+iUnbpjNDhHklOtqghqhJbFi2
        gQ1ma9fOlVCLPCTWXvvDNIFRaRaSb2Yh+WYWwt4FjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS
        9ZLzczcxAhPR6X/Hv+5g3Pcn6RCjAAejEg/vjrOXo4RYE8uKK3MPMUpwMCuJ8C5LBArxpiRW
        VqUW5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJMnFwSjUwruX5te2h+QeFjKg6
        x1NztN723ryo8CN4pb3Rk9vvv6WqtRdt+ux5fO1kgUPx33Mdyk7tFGR483lLWv8e24WrNu+/
        4ndtZfi2E+ebDfpvip11r17zQfDkA9cNDdcFgyZmmAu5O3dovcoKMxAqOMqxXYavoZV704ey
        JJNdJ+c0OgTuPLHZbkemnhJLcUaioRZzUXEiAJXkp1ZAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7pfZl+JMji2Uc1i3mdZi/lXrrFa
        9D9+zWxx/vwGdovLu+awWXzuPcJoMeP8PiaLtUfusls8edjH5sDpsXPWXXaPxXteMnlsWtXJ
        5nHn2h42j74tqxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0MtYsncjc8EUmYqeC38YGxhPiXUxcnJICJhIHN27mg3EFhJYyijxsbmg
        i5EDKC4jcXx9GUSJsMSfa11AJVxAJe8YJU6vaWEHSbAJWElMbF/FCGKLCOhJNL5vYwKxmQVm
        MkncXKUJYgsLBEq8XnGPGcRmEVCVWDwJpJ6Dg1dAS2LqV2+QsKiAl8SWfe1grZwCdhKXW49C
        7ZrBKDHvwjNWkASvgKDEyZlPWCDmy0t0XG5khbB1JBbs/sQ2gVFwFpKyWUjKZiEpW8DIvIpR
        JLW0ODc9t9hQrzgxt7g0L10vOT93EyMwurYd+7l5B+OljcGHGAU4GJV4eHecvRwlxJpYVlyZ
        e4hRgoNZSYR3WSJQiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBkZ9XEm9oamhuYWlobmxu
        bGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGx7NJTSa6NSzvrnBmrPsZdmD/vmu62XOZ0
        6fwD3667MvRKvo2o8HKJ+9u8Ssluv8GKqTOumSeGsUeqXQ/UqWjYXrNhoUBcj6fG8uP3BNUP
        xL4IyZoxy23yYs3yNZvNX8QVttxKZVjzJnXHauFD59xKhK9M8eP2tfj8pT2+Illj45/ua58v
        zPdRYinOSDTUYi4qTgQAA2/BwMQCAAA=
X-CMS-MailID: 20180416124956eucas1p17636602f59e7ad83088253ed369e7894
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416124956eucas1p17636602f59e7ad83088253ed369e7894
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416124956eucas1p17636602f59e7ad83088253ed369e7894
X-RootMTR: 20180416124956eucas1p17636602f59e7ad83088253ed369e7894
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <6993557.YT37RIp4lG@amdc3058>
        <22d7f063-9a69-78cf-e0fd-2043e187244e@linaro.org>
        <CGME20180416124956eucas1p17636602f59e7ad83088253ed369e7894@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 16, 2018 02:41:48 PM Daniel Lezcano wrote:
> On 16/04/2018 14:35, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 16, 2018 02:16:56 PM Daniel Lezcano wrote:
> >> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> >>> From: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>
> >>> tmu_read() in case of Exynos4210 might return error for out of bound
> >>> values. Current code ignores such value, what leads to reporting critical
> >>> temperature value. Add proper error code propagation to exynos_get_temp()
> >>> function.
> >>
> >> For me the comment in the function exynos4210_tmu_read
> >>
> >> /* "temp_code" should range between 75 and 175 */
> >>
> >> ... is strange. I would double check this assertion before dealing with
> >> the error value.
> > 
> > static int exynos4210_tmu_read(struct exynos_tmu_data *data)
> > {
> > 	int ret = readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
> > 
> > 	/* "temp_code" should range between 75 and 175 */
> > 	return (ret < 75 || ret > 175) ? -ENODATA : ret;
> > }
> > 
> 
> But I don't get why it *should* ?

Because of hardware design.

> Shouldn't be the same with the 4412, it seems having the same sensor, no?

Probably same limitations apply to all SoCs (Exynos4412 has very similar
sensor) but the driver currently lacks the needed checks for them (it is
on TODO but other things have higher priority).

> > The value returned by Exynos4210 hardware should be > 75 && < 175 and
> > it is later used as the "temp_code" parameter for code_to_temp():
> > 
> > static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
> > {
> > 	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> > 		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
> > 
> > 	return (temp_code - data->temp_error1) *
> > 		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> > 		(data->temp_error2 - data->temp_error1) +
> > 		EXYNOS_FIRST_POINT_TRIM;
> > }
> > 
> > so after the current fix the code finally matches the comment.
> > 
> >>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> CC: stable@vger.kernel.org # v4.6+
> >>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> ---
> >>>  drivers/thermal/samsung/exynos_tmu.c | 9 +++++++--
> >>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> >>> index 986cbd0..ac83f72 100644
> >>> --- a/drivers/thermal/samsung/exynos_tmu.c
> >>> +++ b/drivers/thermal/samsung/exynos_tmu.c
> >>> @@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
> >>>  static int exynos_get_temp(void *p, int *temp)
> >>>  {
> >>>  	struct exynos_tmu_data *data = p;
> >>> +	int value, ret = 0;
> >>>  
> >>>  	if (!data || !data->tmu_read || !data->enabled)
> >>>  		return -EINVAL;
> >>> @@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int *temp)
> >>>  	mutex_lock(&data->lock);
> >>>  	clk_enable(data->clk);
> >>>  
> >>> -	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
> >>> +	value = data->tmu_read(data);
> >>> +	if (value < 0)
> >>> +		ret = value;
> >>> +	else
> >>> +		*temp = code_to_temp(data, value) * MCELSIUS;
> >>>  
> >>>  	clk_disable(data->clk);
> >>>  	mutex_unlock(&data->lock);
> >>>  
> >>> -	return 0;
> >>> +	return ret;
> >>>  }
> >>>  
> >>>  #ifdef CONFIG_THERMAL_EMULATION

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
