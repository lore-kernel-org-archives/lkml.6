Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeEBJj2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:39:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60196 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeEBJj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:39:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180502093923euoutp0181f23c5862cd16f9e8be4535a3932a74~qymYVVAe60960509605euoutp019
X-AuditID: cbfec7f5-b45ff700000028a9-22-5ae9874948c7
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] thermal: exynos: move trips setting to
 exynos_tmu_initialize()
Date: Wed, 02 May 2018 11:39:20 +0200
Message-id: <1585317.VnK93dIYnt@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501103126.GK27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djP87pe7S+jDHr3M1nM+yxrMf/KNVaL
        y7vmsFl87j3CaDHj/D4miycP+9gc2Dx2zrrL7rF4z0smjzvX9rB5fN4kF8ASxWWTkpqTWZZa
        pG+XwJVx9tdploInHBXvVqk3MP5k62Lk4JAQMJE405XYxcjFISSwglGiZ3Y7M4TzmVHi0fcF
        QEWcYEXHW94wgthCAssYJZp2VkMU/WaUePLxN1gRm4CVxMT2VWBFIgJ6Eo3v25hAipgFVjFK
        9H96xwSSEBaIllh7bBEziM0ioCpx8Pk/MJtXQFNi5fxp7CC2qICXxJZ97WD1nEDxvpWr2CBq
        BCV+TL7HAmIzC8hL7Ns/lRXC1pE4e2wdI8gyCYEVbBKrHn9ghjjbRWJWWys7hC0s8er4Fihb
        RqKz4yATREMzo8S3HXugGiYwSuxZLwRhW0scPn4RagOfxKRt05khAcYr0dEGVeIh8f/sdKhW
        R4nz07oY4cHS8LOVeQKj7Cwkh89CcvgsJIcvYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpec
        n7uJEZgQTv87/nUH474/SYcYBTgYlXh4DfJeRAmxJpYVV+YeYpTgYFYS4V3Z8SxKiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgZGH7yDrz9Oa7F+uVi3V
        n7KF5cVzG36T+ZxbV7fFCLP2ykYlmHyu/a6es3NfnZJc60dbsblXWo0WaETE893TKVm0qKvA
        nFdOnWdr9desn4bmd1dc39J3WfLZ57NLg9gLbvtasf66/4pDZ2/MWe3vs9e/6dQ88FBLuzAj
        at4FX6s9h4Kbjvfq7VBiKc5INNRiLipOBAAshHX/BAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xq7qe7S+jDKb9k7CY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvj7K/TLAVPOCrerVJvYPzJ1sXIySEhYCJxvOUNYxcjF4eQwBJGiZ9LXzBDOH8ZJaYu
        7GICqWITsJKY2L6KEcQWEdCTaHzfxgRSxCywilFiZWsvM0hCWCBaYu2xRWA2i4CqxMHn/8Bs
        XgFNiZXzp7GD2KICXhJb9rWDDeUEivetXMUGsW05o8TvzbNZIBoEJX5MvgdmMwvIS+zbP5UV
        wtaSWL/zONMERv5ZSMpmISmbhaRsASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDA3Xbs
        5+YdjJc2Bh9iFOBgVOLhNch7ESXEmlhWXJl7iFGCg1lJhHdlx7MoId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYz8SUsj7fre7TgXGpX7ZM6rZLWVO794
        zEuJTVWcyZfZ1jxL6GmcTROjs7xRys1fwZ9lJjsG5EzQ3Vh9dUmRogS3wkchFaZl/odOLn82
        0fWt536xb99P2lfsL65YwPlj++oOx32WEhaT3s+vOJRWtPFa9k6eqe/uO9+d/nLdUubZOV/W
        NrNwTe1QYinOSDTUYi4qTgQAS3uDHVgCAAA=
X-CMS-MailID: 20180502093921eucas1p1c1da14cc87d3e2c7f5550b961004521d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502093921eucas1p1c1da14cc87d3e2c7f5550b961004521d
X-RootMTR: 20180502093921eucas1p1c1da14cc87d3e2c7f5550b961004521d
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-15-git-send-email-b.zolnierkie@samsung.com>
        <20180501103126.GK27619@mai>
        <CGME20180502093921eucas1p1c1da14cc87d3e2c7f5550b961004521d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 12:31:26 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Add dummy exynos4210_tmu_set_trip_hyst() helper.
> > 
> > * Add ->tmu_set_trip_temp and ->tmu_set_trip_hyst methods to struct
> >   exynos_tmu_data and set them in exynos_map_dt_data().
> > 
> > * Move trips setting to exynos_tmu_initialize().
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> 
> [ ... ]
> 
> > +/* failing thresholds are not supported on Exynos4210 */
> > +static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
> > +					 int trip, u8 temp, u8 hyst)
> > +{
> > +}
> > +
> 
> May be you can get rid of this empty function and check against a NULL pointer
> in exynos_tmu_initialize ?

This is more a question of taste and I prefer adding this one dummy function
instead of adding NULL pointer check for all SoCs.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
