Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeDMLIo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:08:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:31408 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeDMLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:08:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180413110839epoutp037dc3c7ab83dbc8ca5e3c21d7702bb4f9~k_j5NyTgM1122411224epoutp03Y
X-AuditID: b6c32a45-6ebff70000000fe4-c1-5ad08fb64b7c
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, philip.li@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER"
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] thermal/drivers/exynos_tmu: Fix warnings in
 temp_to_code / code_to_temp
Date: Fri, 13 Apr 2018 13:08:35 +0200
Message-id: <11044079.DdDvlFD91s@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1523617209-1730-1-git-send-email-daniel.lezcano@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZdljTQndb/4Uog0/T2CzmfZa1mH/lGqtF
        /+PXzBbnz29gt9j0GMi9vGsOm8Xn3iOMFjPO72OyuHToIpPFk4d9bA5cHjtn3WX3WLznJZPH
        plWdbB53ru1h89i8pN7j8ya5ALYoLpuU1JzMstQifbsErozdWw6wFcxRqtjc/ZGtgfGyTBcj
        B4eEgInEgoP5XYxcHEICOxglFt7dxgLhfGeU6PhwhwmmaHq7I0R8N6PEgwU/mSGcr4wSHx6v
        Z+xi5ORgE7CSmNi+CswWEdCTaHzfxgRSxCzwnkli79M1bCAJYYE4iblHOphAbBYBVYmWLz1g
        DbwCWhIXrh5jAbFFBbwktuxrB6vhFPCUOLRvCTtEjaDEj8n3wGqYBbQlnry7wApha0q8+DIJ
        7GwJgdtsEnMXTQBbJiHgIrH0w2YoW1ji1fEt7BC2tMSzVRsZIRqaGSW+7djDDJGYwCixZ70Q
        hG0tcfj4RagNfBIdh/+yQ8KCV6KjDarEQ6Jj+WlWCNtRYvP++4yQYNnLKNFz8gjbBEbZWUgO
        n4Xk8FlIDl/AyLyKUSy1oDg3PbXYqMBQrzgxt7g0L10vOT93EyM4lWi57mCccc7nEKMAB6MS
        D29F9fkoIdbEsuLK3EOMEhzMSiK8NwsuRAnxpiRWVqUW5ccXleakFh9ilOZgURLnbfA9EyUk
        kJ5YkpqdmlqQWgSTZeLglGpgjF+8O3rLetd25rWz3pcekejUCd/0eWEQf4TmyaKN9bYTt/1I
        1tibvc1dMtRkt6zqzNtfPvKlW/l/0X/bybGWs+BOdcHMWtut1ue/ijge2Jjw54ll06fYxyU/
        kp0uTpnwbYXvFx3J2Rk6z35vr1ocwpIWde74Y5f4J11FteusfD/8dJu05q7DAyWW4oxEQy3m
        ouJEAAvp2/0hAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t9jAd2t/ReiDF7t0rGY91nWYv6Va6wW
        /Y9fM1ucP7+B3WLTYyD38q45bBafe48wWsw4v4/J4tKhi0wWTx72sTlweeycdZfdY/Gel0we
        m1Z1snncubaHzWPzknqPz5vkAtiiuGxSUnMyy1KL9O0SuDJ2bznAVjBHqWJz90e2BsbLMl2M
        HBwSAiYS09sduxg5OYQEdjJK/NkY0cXIBWR/ZZT4tGAWE0iCTcBKYmL7KkYQW0RAT6LxfRsT
        SBGzwHsmidtPP4IlhAXiJDqnvGMBsVkEVCVavvSAxXkFtCQuXD0GFhcV8JLYsq8dbCingKfE
        oX1L2CG27WWUWLpoEhNEg6DEj8n3wBqYBbQlnry7wApyKbOAusSUKbkTGPlnIamahaRqFkLV
        AkbmVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsYgWG/7bBW/w7Gx0viDzEKcDAq8fAq
        VJ6PEmJNLCuuzD3EKMHBrCTCe7PgQpQQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJ
        JanZqakFqUUwWSYOTqkGRqG9k3yW6gZZhXyJbY1o5JUOP22aYbglJkE4a20870PFnBgByyPm
        ZVkzHn7L2hjI3Gbw8U9HDo+6jvb9smlrbnccqXBNEfCM/R0YtZknYcnGZR2HV+R0nm9Q0519
        ZrvL7i/cBX/PhM6qzGk04PxtPe/Ya/6M+0vbonUmpzf6bo3i++M378puJZbijERDLeai4kQA
        67jwMncCAAA=
X-CMS-MailID: 20180413110837epcas2p1c79b95afdf5f9139fb4b0307a704cae1
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180413110032epcas4p3e0ef781eecb771b1294b7992d2ee6e6d
X-RootMTR: 20180413110032epcas4p3e0ef781eecb771b1294b7992d2ee6e6d
References: <10298074.ogKH1ypqfx@amdc3058>
        <CGME20180413110032epcas4p3e0ef781eecb771b1294b7992d2ee6e6d@epcas4p3.samsung.com>
        <1523617209-1730-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3DB8nGF026505

On Friday, April 13, 2018 01:00:09 PM Daniel Lezcano wrote:
> The latest driver cleanup introduced a compilation warning
> 
>  drivers/thermal/samsung/exynos_tmu.c: In function ‘exynos_get_temp’:
>  drivers/thermal/samsung/exynos_tmu.c:931:37: warning: ‘temp’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    *temp = code_to_temp(data, value) * MCELSIUS;
>                                         ^
> 
>  drivers/thermal/samsung/exynos_tmu.c: In function ‘temp_to_code’
>  drivers/thermal/samsung/exynos_tmu.c:304:9: warning: ‘temp_code’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> 					  return temp_code;
> 					           ^~~~~~~~~
> 
> The compiler gives a warning because semantically speaking the
> function has no default value. However the code path, were the
> variable is never initialized is a dead branch because the switch
> statement always choose one of the two cases as the data->cal_type is
> initialized in the init function to one of both values.
> 
> This is unclear as it adds a dependency on the initialization function
> and it is prone to error. Make things clearer by converting the
> functions with if ... return statements, thus showing we are expecting
> the values to be correctly filled before calling this function.
> 
> This change fixes the couple of function warnings.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks Daniel, this is much better fix.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 46 ++++++++++--------------------------
>  1 file changed, 12 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 2ec8548..197f267 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -284,24 +284,13 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
>   */
>  static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>  {
> -	int temp_code;
> -
> -	switch (data->cal_type) {
> -	case TYPE_TWO_POINT_TRIMMING:
> -		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
> -			(data->temp_error2 - data->temp_error1) /
> -			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> -			data->temp_error1;
> -		break;
> -	case TYPE_ONE_POINT_TRIMMING:
> -		temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		break;
> -	}
> +	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> +		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
>  
> -	return temp_code;
> +	return (temp - EXYNOS_FIRST_POINT_TRIM) *
> +		(data->temp_error2 - data->temp_error1) /
> +		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> +		data->temp_error1;
>  }
>  
>  /*
> @@ -310,24 +299,13 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>   */
>  static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
>  {
> -	int temp;
> -
> -	switch (data->cal_type) {
> -	case TYPE_TWO_POINT_TRIMMING:
> -		temp = (temp_code - data->temp_error1) *
> -			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> -			(data->temp_error2 - data->temp_error1) +
> -			EXYNOS_FIRST_POINT_TRIM;
> -		break;
> -	case TYPE_ONE_POINT_TRIMMING:
> -		temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		break;
> -	}
> +	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> +		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
>  
> -	return temp;
> +	return (temp_code - data->temp_error1) *
> +		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> +		(data->temp_error2 - data->temp_error1) +
> +		EXYNOS_FIRST_POINT_TRIM;
>  }
>  
>  static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
