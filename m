Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeEBKDu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:03:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39659 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeEBKDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:03:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180502100346euoutp01cae6ba6d31ae48eae59b7bc1c8a17b76~qy7qcWicq2272222722euoutp01O
X-AuditID: cbfec7f5-b5fff700000028a9-c2-5ae98d01d677
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/18] thermal: exynos: cleanup code for enabling
 threshold interrupts
Date: Wed, 02 May 2018 12:03:44 +0200
Message-id: <17338828.V5XOYeIB5l@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501110239.GM27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djP87qMvS+jDDZ/l7OY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvj8IKPbAVHpCtOX+tgb2DsEeti5OCQEDCRmD45tIuRi0NIYAWjxPaDS1ghnM+MEg++
        fWOHKbqw2wAivoxR4s+nTcwQzm9GicbtjWxdjJwcbAJWEhPbVzGC2CICehKN79uYQIqYBVYx
        SvR/escEkhAWiJE4cvUdWBGLgKrEnfkvweK8AloSs9qnsYDYogJeElv2tYPFOQU0JdrXnGeF
        qBGU+DH5HlgNs4C8xL79U1khbB2Js8fWgc2UEFjDJnGrKRjiaheJzt3BEGFhiVfHt7BD2DIS
        lyd3s4DcJiHQzCjxbcceZojEBEaJPeuFIGxricPHL0LN55OYtG06M8RMXomONqgSD4n5X/ZD
        zXSU6F3YwQYPlHuf57FMYJSdheTsWUjOnoXk7AWMzKsYxVNLi3PTU4uN81LL9YoTc4tL89L1
        kvNzNzEC08Hpf8e/7mDc9yfpEKMAB6MSD69B3osoIdbEsuLK3EOMEhzMSiK8KzueRQnxpiRW
        VqUW5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJMnFwSjUw2muaGUzP8FIqYa+W
        fFHRbjnt24MDWsn7DLXf/uCU+nvhrUWxXJeh3/KoI7y9IU2d3GIOukrNRgWbw3bGXOlIi9Ht
        V5xzcq9myQxxjtXXWm3WNjjJX3h4ReGs8dvlxbZn2kPW3WTbN3fRHtl7E7/xpn65sPPKo9n8
        n8uSTN/dd5F/fnOL3NNeJZbijERDLeai4kQAE+pRdgMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xa7qMvS+jDLb0MFvM+yxrMf/KNVaL
        y7vmsFl87j3CaDHj/D4miycP+9gc2Dx2zrrL7rF4z0smjzvX9rB5fN4kF8ASxWWTkpqTWZZa
        pG+XwJVxeMFHtoIj0hWnr3WwNzD2iHUxcnBICJhIXNht0MXIxSEksIRRYt3eu0xdjJxAzl9G
        ie3vLUFsNgEriYntqxhBbBEBPYnG921MIA3MAqsYJVa29jKDJIQFYiSuTp4DVsQioCpxZ/5L
        sEG8AloSs9qnsYDYogJeElv2tYPFOQU0JdrXnGeF2LycUeL2q5uMEA2CEj8m3wNrYBaQl9i3
        fyorhK0lsX7ncaYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFh
        u+3Yzy07GLveBR9iFOBgVOLhNch7ESXEmlhWXJl7iFGCg1lJhHdlx7MoId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYynciK+Bt0xyWSo3vKM08fou+2D
        tsqZ+Z8VTx26HPskYtHytye1TU7xW3w5oxvIVZI+2+LHREsXz60/d4R/t1eL33aF02jC/TXh
        GjMuWtpfiw6reqB4ncHhSZKQn4TFj7n9Txx7ZpXOP3yg+MolVTnHiY/M7vGdSro7Q2+vzs/3
        oo+3G7dcblVVYinOSDTUYi4qTgQAMrRVLlcCAAA=
X-CMS-MailID: 20180502100345eucas1p27280d10571f3e9d7c5b5a62a364dd439
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502100345eucas1p27280d10571f3e9d7c5b5a62a364dd439
X-RootMTR: 20180502100345eucas1p27280d10571f3e9d7c5b5a62a364dd439
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-17-git-send-email-b.zolnierkie@samsung.com>
        <20180501110239.GM27619@mai>
        <CGME20180502100345eucas1p27280d10571f3e9d7c5b5a62a364dd439@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 01:02:39 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:31PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Cleanup code for enabling threshold interrupts in ->tmu_control
> > method implementations.
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 101 ++++++++++++-----------------------
> >  1 file changed, 34 insertions(+), 67 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index abe0737..9639acf 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -76,9 +76,6 @@
> >  #define EXYNOS_TMU_THERM_TRIP_EN_SHIFT	12
> >  
> >  #define EXYNOS_TMU_INTEN_RISE0_SHIFT	0
> > -#define EXYNOS_TMU_INTEN_RISE1_SHIFT	4
> > -#define EXYNOS_TMU_INTEN_RISE2_SHIFT	8
> > -#define EXYNOS_TMU_INTEN_RISE3_SHIFT	12
> >  #define EXYNOS_TMU_INTEN_FALL0_SHIFT	16
> >  
> >  #define EXYNOS_EMUL_TIME	0x57F0
> > @@ -136,13 +133,6 @@
> >  #define EXYNOS7_TMU_TEMP_MASK			0x1ff
> >  #define EXYNOS7_PD_DET_EN_SHIFT			23
> >  #define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
> > -#define EXYNOS7_TMU_INTEN_RISE1_SHIFT		1
> > -#define EXYNOS7_TMU_INTEN_RISE2_SHIFT		2
> > -#define EXYNOS7_TMU_INTEN_RISE3_SHIFT		3
> > -#define EXYNOS7_TMU_INTEN_RISE4_SHIFT		4
> > -#define EXYNOS7_TMU_INTEN_RISE5_SHIFT		5
> > -#define EXYNOS7_TMU_INTEN_RISE6_SHIFT		6
> > -#define EXYNOS7_TMU_INTEN_RISE7_SHIFT		7
> >  #define EXYNOS7_EMUL_DATA_SHIFT			7
> >  #define EXYNOS7_EMUL_DATA_MASK			0x1ff
> >  
> > @@ -615,29 +605,27 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
> >  {
> >  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> >  	struct thermal_zone_device *tz = data->tzd;
> > -	unsigned int con, interrupt_en;
> > +	unsigned int con, interrupt_en = 0, i;
> >  
> >  	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
> >  
> >  	if (on) {
> > -		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> > -		interrupt_en =
> > -			(of_thermal_is_trip_valid(tz, 3)
> > -			 << EXYNOS_TMU_INTEN_RISE3_SHIFT) |
> > -			(of_thermal_is_trip_valid(tz, 2)
> > -			 << EXYNOS_TMU_INTEN_RISE2_SHIFT) |
> > -			(of_thermal_is_trip_valid(tz, 1)
> > -			 << EXYNOS_TMU_INTEN_RISE1_SHIFT) |
> > -			(of_thermal_is_trip_valid(tz, 0)
> > -			 << EXYNOS_TMU_INTEN_RISE0_SHIFT);
> > +		for (i = 0; i < data->ntrip; i++) {
> > +			if (!of_thermal_is_trip_valid(tz, i))
> > +				continue;
> > +
> > +			interrupt_en |=
> > +				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
> > +		}
> 
> As EXYNOS_TMU_INTEN_RISE0_SHIFT is equal to zero, may be you can replace this
> by BITS(i * 4) ?
> 
> Same comments for exynos5433 and exynos7 below.

Good point, I will replace it by using BIT() macro.

> I don't know which one was intended : 

The one that doesn't change the driver behavior as stated in the patch
description.

>  ((EXYNOS_TMU_INTEN_RISE0_SHIFT + i) * 4) or
>   (EXYNOS_TMU_INTEN_RISE0_SHIFT + (i * 4))
> 
> but if it is the former it is lucky it works because the macro is zero.
> 
> Is it possible to have the registers layout, that would facilitate the review.

I'm sorry but Exynos TMU documentation is not publicly available.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
