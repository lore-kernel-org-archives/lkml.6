Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbeEBJd0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:33:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58184 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:33:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180502093317euoutp013e366dc0a3d5a9ff7b40862f2b558b0f~qyhDVd__q0668306683euoutp01_
X-AuditID: cbfec7f2-1dbff70000011644-58-5ae985dc9e88
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/18] thermal: exynos: add
 exynos*_tmu_set_[trip,hyst]() helpers
Date: Wed, 02 May 2018 11:33:15 +0200
Message-id: <2658994.PYbssquHNy@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501095540.GH27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7p3Wl9GGbw5Lmsx77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAlfGvTOb2ApOcFcsXK/bwLibs4uRk0NCwESi50UraxcjF4eQwApGiRcPVzOBJIQEPjNK
        /NrtA1N082I7I0R8GaPErs+ZEA2/GSWad/SxgSTYBKwkJravAisSEdCTaHzfxgRSxCywilGi
        /9M7sKnCAuES116+YwGxWQRUJWYvnwnWzCugKTFzzVmwZlEBL4kt+9rB6jmB4nv/bYGqEZT4
        MfkeWC+zgLzEvv1TWSFsHYmzx9YxgiyTEFjDJvFgy11WiLNdJL4saWWDsIUlXh3fwg5hy0hc
        ntzNAtHQzCjxbcceZojEBEaJPeuFIGxricPHL0Jt4JOYtG06UA0HUJxXoqMNqsRDou/kHSaI
        sKPE/SZBeKi8m/OdZQKj7Cwkd89CcvcsJHcvYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpec
        n7uJEZgOTv87/mkH49dLSYcYBTgYlXh4DfJeRAmxJpYVV+YeYpTgYFYS4V3Z8SxKiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgVF4VVdS54VVE5sv9zHY
        vl3p9lJwmdvmnrPKy0tYN2o7pgUZ11/dIDJP2IhVzsh8zj3fx7vvxmT/Kn1fJ7Ri3e8iaaa5
        zu/OP89Vv/r22I3jxwotN77M6Ku899ClSWzx0xTWVx89tptbcQRPmvLhtbHBr0UKQbEv99wI
        s1Iq9gosu+11fubJfh4lluKMREMt5qLiRADX7nTMAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xq7q3W19GGex9Y2Mx77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAlfGvTOb2ApOcFcsXK/bwLibs4uRk0NCwETi5sV2xi5GLg4hgSWMEr8fvmYESQgJ/GWU
        2HQtHcRmE7CSmNi+CiwuIqAn0fi+jQmkgVlgFaPEytZeZpCEsEC4xOUl79lBbBYBVYnZy2ey
        gdi8ApoSM9ecBWsWFfCS2LKvnQnE5gSK7/23hQ1i83JGiQd75zJBNAhK/Jh8jwXEZhaQl9i3
        fyorhK0lsX7ncaYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFh
        u+3Yzy07GLveBR9iFOBgVOLhNch7ESXEmlhWXJl7iFGCg1lJhHdlx7MoId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYyR7p9ne91uk2/cvXZC06OSvZ61
        R6teMBR2+PNHXS+ckPb8ZvYkIYtJO5PkDFevnn7k0RPrrEtxD6recN/Lar9pzr5Vz6D/UTPT
        u/qWjtu7qo5rrDXqn6rsnhnFp8jjLy3Q79Y4nWWVQPhz9/Papqe3M8oGqSc9Xzy/Y+HOibzL
        v4Rfys/1NVNiKc5INNRiLipOBABG1huQVwIAAA==
X-CMS-MailID: 20180502093316eucas1p1e7e7b2f27eae677dde9882a4aedd2ed7
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502093316eucas1p1e7e7b2f27eae677dde9882a4aedd2ed7
X-RootMTR: 20180502093316eucas1p1e7e7b2f27eae677dde9882a4aedd2ed7
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-12-git-send-email-b.zolnierkie@samsung.com>
        <20180501095540.GH27619@mai>
        <CGME20180502093316eucas1p1e7e7b2f27eae677dde9882a4aedd2ed7@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 11:55:40 AM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Add exynos*_tmu_set_[trip,hyst]() helpers and convert
> > all ->tmu_initialize implementations accordingly.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 282 +++++++++++++++++------------------
> >  1 file changed, 140 insertions(+), 142 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 82484c5..80265d2 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -305,30 +305,6 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
> >  			EXYNOS_TMU_TEMP_MASK;
> >  }
> 
> [ ... ]
> 
> > +static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
> > +					 int trip, u8 temp)
> > +{
> > +	const struct thermal_trip * const trips =
> > +		of_thermal_get_trip_points(data->tzd);
> > +	u8 ref, th_code;
> 
> I would not do this kind of change (unsigned long => u8) with this patch.
> Just code reorg and another patch to tweak the variable types if needed.

This is so minor change and it is has been already tested so I prefer to
not split it from this patch now.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
