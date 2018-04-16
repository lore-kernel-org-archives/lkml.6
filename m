Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbeDPMfI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:35:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41487 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbeDPMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:35:06 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416123504euoutp01dd0fdd445c175b080684ca6bd423d3fe~l6rNNu7Tn0732907329euoutp01L
X-AuditID: cbfec7f4-713ff700000043e4-ea-5ad49876ef91
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
Date: Mon, 16 Apr 2018 14:35:01 +0200
Message-ID: <6993557.YT37RIp4lG@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <39e461aa-2a60-f3cf-d116-fc7e97f9da2e@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTuvXe7u44m16l5sCxYFBrkRxjd0jSiHyv6oqgfA7OZFxW3Kfeq
        ZT9EMdRW2cpCG36RoGsZW8OGG0PCzCWpS7SloYjTH+UHGZoYfrXtKvnvOec55zzP8/KSuLRV
        GE5mafIYVqNUyQixwNr9t/9wQc2QItbTEk/XL0TQDUNuIf14cganXS6ziB601xL0wqMuRNe4
        OjD6TdeYiJ6aqCROBcht+jGRvMnxE5NbjPcJ+ajbQcgr24xIvmDZe5lQiBPTGVVWAcPGJN0U
        Z/5eGxXkzuy64+zxoGLULtWiABKoeDD0DWFaJCallAFBr2kA54tFBMtL4yK+WEDgKHOKtlZa
        RooFPNGCwL36DPHFPIJyazfmmyKoE/Ck3Ih8OISKhpJfZX4RnGrAoP9Bk8BHBFNXYcK04V8Q
        UAfAs1JC+LCEioLJ3jE/DqXOQVtHuX8mgEqC2aZRIT8TBD0vpvx3cGofVAyWCHl7dhFo7XIe
        n4ElaynB42CYdrZtRtgDG7YGvyGgShEstTtwntB5g5o2nyYBPjgHvEdJr0AUmOwxPgjUSaib
        juBhIAzPBfEOAuGptRrn2xKoKNu8cRDMzWZiS1Rre7WpI4d520tMh2T6bVn027Lo/8s2ItyI
        wph8Tp3BcEc0zO1oTqnm8jUZ0bdy1Bbk/UOf152L7ci+mtaJKBLJdkra+wYVUqGygCtUdyIg
        cVmIpFnpbUnSlYV3GTYnlc1XMVwn2k0KZGGSG5FFCimVocxjshkml2G3WIwMCC9GdXH7zR5X
        Ihv5/d5zzBy3saa5/lW4rmqY2/E6FnSR7/Sz2PzH5BRdc/afY1U5WfVm0/BcyrfqoOD48SjZ
        8JXukQrrMmL3X6w2TDqWz7em6mqPZ2oS0rPfuz99OXqJW2JjCsvJa0U1lrOxVRZu5XTowwt0
        H2PAw9J+UPrG5LcyAZepjDuEs5zyH/6LXaQ/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7plM65EGWw9LmAx77Osxfwr11gt
        +h+/ZrY4f34Du8XlXXPYLD73HmG0mHF+H5PF2iN32S2ePOxjc+D02DnrLrvH4j0vmTw2repk
        87hzbQ+bR9+WVYwenzfJBbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GV8/HuHpeC1WMXxk48YGxh3CHUxcnJICJhILL/ZwNLFyMUhJLCUUeJ+
        03umLkYOoISMxPH1ZRA1whJ/rnWxgdhCAu8YJXYfNAKx2QSsJCa2r2IEsUUE9CQa37cxgdjM
        AjOZJG6u0gSxhQUCJV6vuMcMYrMIqEo8+t0INodXQFPi8Zm7YLaogJfEln3tYL2cAnYSbxbf
        YYXYtZ1RYtuSCoh6QYmTM5+wQMyXl+i43MgKYetILNj9iW0Co+AsJGWzkJTNQlK2gJF5FaNI
        amlxbnpusaFecWJucWleul5yfu4mRmB0bTv2c/MOxksbgw8xCnAwKvHw7jh7OUqINbGsuDL3
        EKMEB7OSCO+yRKAQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wMjP68k3tDU0NzC0tDc2NzY
        zEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUAyPbkqMKU01+BLe4hK+N+7Wh+bpvz5QDOtGp
        R2LffVBc7Hmn+wHH4q853/+dSWngXBCxpGzF0guXLPa+DdjS/l72ab3ntE61sozyOMt9G8/N
        ZIx5cebFlpDjPSduup1a9/lZV8LHyRtiVimqBmbxamjs+bhc+TnzoZaIgIoyjqWbNeMfq6w4
        9VRIiaU4I9FQi7moOBEANRqBqcQCAAA=
X-CMS-MailID: 20180416123502eucas1p1113fb99938a09a6f425e0ed6bfa6be60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416123502eucas1p1113fb99938a09a6f425e0ed6bfa6be60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416123502eucas1p1113fb99938a09a6f425e0ed6bfa6be60
X-RootMTR: 20180416123502eucas1p1113fb99938a09a6f425e0ed6bfa6be60
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-3-git-send-email-b.zolnierkie@samsung.com>
        <39e461aa-2a60-f3cf-d116-fc7e97f9da2e@linaro.org>
        <CGME20180416123502eucas1p1113fb99938a09a6f425e0ed6bfa6be60@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 16, 2018 02:16:56 PM Daniel Lezcano wrote:
> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > tmu_read() in case of Exynos4210 might return error for out of bound
> > values. Current code ignores such value, what leads to reporting critical
> > temperature value. Add proper error code propagation to exynos_get_temp()
> > function.
> 
> For me the comment in the function exynos4210_tmu_read
> 
> /* "temp_code" should range between 75 and 175 */
> 
> ... is strange. I would double check this assertion before dealing with
> the error value.

static int exynos4210_tmu_read(struct exynos_tmu_data *data)
{
	int ret = readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);

	/* "temp_code" should range between 75 and 175 */
	return (ret < 75 || ret > 175) ? -ENODATA : ret;
}

The value returned by Exynos4210 hardware should be > 75 && < 175 and
it is later used as the "temp_code" parameter for code_to_temp():

static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
{
	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;

	return (temp_code - data->temp_error1) *
		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
		(data->temp_error2 - data->temp_error1) +
		EXYNOS_FIRST_POINT_TRIM;
}

so after the current fix the code finally matches the comment.

> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > CC: stable@vger.kernel.org # v4.6+
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 986cbd0..ac83f72 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
> >  static int exynos_get_temp(void *p, int *temp)
> >  {
> >  	struct exynos_tmu_data *data = p;
> > +	int value, ret = 0;
> >  
> >  	if (!data || !data->tmu_read || !data->enabled)
> >  		return -EINVAL;
> > @@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int *temp)
> >  	mutex_lock(&data->lock);
> >  	clk_enable(data->clk);
> >  
> > -	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
> > +	value = data->tmu_read(data);
> > +	if (value < 0)
> > +		ret = value;
> > +	else
> > +		*temp = code_to_temp(data, value) * MCELSIUS;
> >  
> >  	clk_disable(data->clk);
> >  	mutex_unlock(&data->lock);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  #ifdef CONFIG_THERMAL_EMULATION

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
