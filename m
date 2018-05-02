Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEBJlx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:41:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47758 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeEBJlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:41:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502094145euoutp0221bbb647c4881af5419a57087833c390~qyocDJt4j1805618056euoutp02H
X-AuditID: cbfec7f2-5ffe19c000011644-32-5ae987d73601
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] thermal: exynos: check return values of
 ->get_trip_[temp,hyst] methods
Date: Wed, 02 May 2018 11:41:42 +0200
Message-id: <2073119.W2NaKLyeRo@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501104304.GL27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djP87rX219GGRy6am0x77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAlfGjdZ3TAULBCr+Pb/C3MB4l6eLkZNDQsBEYsqDxSxdjFwcQgIrGCU+ffvMDuF8ZpT4
        cf0uYxcjB1jVjZP+EPFljBKbGxoYIZzfjBLz585lBhnFJmAlMbF9FSOILSKgJ9H4vo0JpIhZ
        YBWjRP+nd0wgCWGBZInzB9rAbBYBVYnPd7ezgNi8ApoSF1ofsoLYogJeElv2tYPVcALF/2/6
        yAxRIyjxY/I9sHpmAXmJffunskLYOhJnj60Du0hCYA2bxP2r96DOdpFoa7OA+FNY4tXxLewQ
        toxEZ8dBJoj6ZkaJbzv2MEMkJjBK7FkvBGFbSxw+fhFqAZ/EpG3TmSFm8kp0tAlBmB4S65v8
        IaodJZ6c/YIIlKMzZjNNYJSdheTsWUjOnoXk7AWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1
        kvNzNzECE8Lpf8c/7WD8einpEKMAB6MSD69B3osoIdbEsuLK3EOMEhzMSiK8KzueRQnxpiRW
        VqUW5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJMnFwSjUwMsowPOAVqeezPse5
        bX/Ny9MH3hts2SoyrajRcNmqL02JjNPtijrWnmxzMK12OtUculhivo+f1HKZzwKXln46NvP0
        FY/LTyenng6fmBKzYtv7I03Xv22fXqi/YOEmt5COmZMa/xZK+5S++bbDRX6myXvlfdXuD+eV
        Frw9G/vp+Rwp9poy/t0CPUosxRmJhlrMRcWJAD7Dhl4EAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xy7rX219GGTTtEbeY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvjRus7poIFAhX/nl9hbmC8y9PFyMEhIWAiceOkfxcjF4eQwBJGiSO7e9i7GDmBnL+M
        Ejv/KoLYbAJWEhPbVzGC2CICehKN79uYQBqYBVYxSqxs7WUGSQgLJEucPwCS4ORgEVCV+Hx3
        OwuIzSugKXGh9SEriC0q4CWxZV87WA0nUPz/po/MEJuXM0p83rqLCaJBUOLH5HtgzcwC8hL7
        9k9lhbC1JNbvPM40gZF/FpKyWUjKZiEpW8DIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw
        bLcd+7l5B+OljcGHGAU4GJV4eA3yXkQJsSaWFVfmHmKU4GBWEuFd2fEsSog3JbGyKrUoP76o
        NCe1+BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVAMj0wlXp+S1VSnK00J1lTOPfvMQ
        VLPqqq4VZq07cIWlrHnBRTHHpfUiHQ6/jYxX/Dp+UH3zmZvMx5sqi8s/TGGqlMmo9H7IJemT
        0n7YdU/a15jWr+WxTeE/v08MqJ7ebtX6ObWIMf/fC9sNzx5E2//7sD7MO3L3tx0x+sr32f2m
        vZyw8uoP0ywlluKMREMt5qLiRAB57MNtVwIAAA==
X-CMS-MailID: 20180502094143eucas1p282ea9e6519120d8eff473a7b3e1830ac
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502094143eucas1p282ea9e6519120d8eff473a7b3e1830ac
X-RootMTR: 20180502094143eucas1p282ea9e6519120d8eff473a7b3e1830ac
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-16-git-send-email-b.zolnierkie@samsung.com>
        <20180501104304.GL27619@mai>
        <CGME20180502094143eucas1p282ea9e6519120d8eff473a7b3e1830ac@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 12:43:04 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Check return values of ->get_trip_[temp,hyst] methods in
> > exynos_tmu_initialize().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 244aaf6..abe0737 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -357,19 +357,23 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >  		/* Write temperature code for rising and falling threshold */
> >  		for (i = 0; i < ntrips; i++) {
> >  			/* Write temperature code for rising threshold */
> > -			tzd->ops->get_trip_temp(tzd, i, &temp);
> > +			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
> > +			if (ret)
> > +				goto err;
> >  			temp /= MCELSIUS;
> >  			data->tmu_set_trip_temp(data, i, temp);
> >  
> >  			/* Write temperature code for falling threshold */
> > -			tzd->ops->get_trip_hyst(tzd, i, &hyst);
> > +			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
> > +			if (ret)
> > +				goto err;
> 
> Could this fail for 4210 ?

It can't, please see the method implementation in of-thermal.c:

static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
				    int *hyst)
{
	struct __thermal_zone *data = tz->devdata;

	if (trip >= data->ntrips || trip < 0)
		return -EDOM;

	*hyst = data->trips[trip].hysteresis;

	return 0;
}

> >  			hyst /= MCELSIUS;
> >  			data->tmu_set_trip_hyst(data, i, temp, hyst);
> >  		}
> >  
> >  		data->tmu_clear_irqs(data);
> >  	}
> > -
> > +err:
> >  	clk_disable(data->clk);
> >  	mutex_unlock(&data->lock);
> >  	if (!IS_ERR(data->clk_sec))

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
