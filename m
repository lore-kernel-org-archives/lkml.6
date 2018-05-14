Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbeENQtG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:49:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51724 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeENQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:49:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180514164901euoutp01403e50f8aa4ec00ffe9b8b7768083a5b~ukM7aVrli0584105841euoutp01z
X-AuditID: cbfec7f4-713ff700000043e4-ee-5af9bdfb966a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: exynos: Reduce severity of too early
 temperature read
Date: Mon, 14 May 2018 18:48:58 +0200
Message-id: <5680419.dyeeL7KHIb@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180513175402.28887-1-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned0/e39GGSzNt5j3WdZi/pVrrBbn
        z29gt9j0GMi6vGsOm8Xn3iOMFjPO72OyWHvkLrvFk4d9bA6cHjtn3WX3WLznJZPHplWdbB53
        ru1h89i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mhbves9aMJ+/4vTSp0wNjOt5uhg5
        OSQETCTWLV/JCmILCaxglGheqdnFyAVkf2aUuL2gkwWm6N3P0ywQRcsYJU58FoMo+s0oMXnW
        USaQBJuAlcTE9lWMILaIQLDE7mcHmUGKmAWamSTutk9hBkkIC4RKLF39kQ3EZhFQlZj+ay5Y
        M6+ApsTJmYfAzhAV8JLYsq8dLM4pYCpx6uRzRogaQYkfk++BXcEsIC+xb/9UVghbR+LssXWM
        EJdeZpO4/Kayi5EDyHaRmN5RCREWlnh1fAs7hC0j0dlxkAnkNgmBZkaJbzv2MEMkJjBK7Fkv
        BGFbSxw+fhFqPp/EpG3TmSFm8kp0tEGVeEgcfPAWaq2jxLK1/1kggdLBKDHt0gfGCYyys5Cc
        PQvJ2bOQnL2AkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYBo5/e/4lx2Mu/4kHWIU
        4GBU4uHdMeNnlBBrYllxZe4hRgkOZiUR3t1GQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1
        UUIC6YklqdmpqQWpRTBZJg5OqQbGqItnpjw4HXT/rnbDRneN3InVV6f89n/QoFNcl5WwWikg
        +D7rjXN/Tm2PYWqxqynf9U/A/7ZX+/acA2fajvc+PTf5wm+H4y9FlA2uMUZqHsiRyXZ5FKyW
        JHNrcYX9yzv6UpGB9srLL3A2rIkQeKb2K3t3JcveY1//KPw0/m0q2XLq/yT1KA5hJZbijERD
        Leai4kQADeeq2x8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t/xq7q/9/6MMmg+z2wx77Osxfwr11gt
        zp/fwG6x6TGQdXnXHDaLz71HGC1mnN/HZLH2yF12iycP+9gcOD12zrrL7rF4z0smj02rOtk8
        7lzbw+axeUm9R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGUs3vWetWA+f8XppU+ZGhjX83Qx
        cnJICJhIvPt5mqWLkYtDSGAJo8SpNWuZQBJCAn8ZJW51J4PYbAJWEhPbVzGC2CICwRIN3avA
        GpgFWpkk1s18B5YQFgiV6OlZAtbMIqAqMf3XXDCbV0BT4uTMQ6wgtqiAl8SWfe1gcU4BU4lT
        J58zQmzuYpTY+WQ6I0SDoMSPyfdYQGxmAXmJffunskLYWhLrdx5nmsDIPwtJ2SwkZbOQlC1g
        ZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGPLbjv3cvIPx0sbgQ4wCHIxKPLw7ZvyMEmJN
        LCuuzD3EKMHBrCTCu9sIKMSbklhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBAemJJanZqakFq
        EUyWiYNTqoFxVnrdi1ut0+td/9gum50ppr9TKuRwQOy8DWzbprwJ2zbl5bSSO4aPT+tJmV35
        5PuFs/btpX2mXXkijuLFXX9i7sw9mvH59ZzC9zo3IzPP/fJkXyJ84e8S9VP73s2+Ij/3750D
        5dNuX0p6o1+wfpHrpVmmMdqsCiGubA9f2CveaDf7pVHLb+3WqcRSnJFoqMVcVJwIAFYlN3R1
        AgAA
X-CMS-MailID: 20180514164859eucas1p173f8d2baf7cb9111578ec55eee5434f9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180513175436epcas1p1475e12e647ec135d0fedd29e5992c152
X-RootMTR: 20180513175436epcas1p1475e12e647ec135d0fedd29e5992c152
References: <CGME20180513175436epcas1p1475e12e647ec135d0fedd29e5992c152@epcas1p1.samsung.com>
        <20180513175402.28887-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, May 13, 2018 07:54:02 PM Krzysztof Kozlowski wrote:
> Thermal core tries to read temperature during sensor registering in
> thermal_zone_of_sensor_register().  In that time Exynos TMU driver and
> hardware are not yet initialized.  Commit 0eb875d88aaa ("thermal:
> exynos: Reading temperature makes sense only when TMU is turned on")
> added a boolean flag to prevent reading bogus temperature in such
> case but it exposed warning message during boot:
> 	[    3.864913] thermal thermal_zone0: failed to read out thermal zone (-22)
> 
> Return EAGAIN in such case to skip omitting such message because it
> might mislead user.

Hi Krzysztof,

I've fixed this in generic way a month ago:

	https://lkml.org/lkml/2018/4/10/376

(there has been not much feedback on it yet)

However since my patchset is not v4.17 material:

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Eduardo, please queue it for v4.17 if possible, thanks.

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 3b20309789e3..c24969d740d1 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -666,8 +666,14 @@ static int exynos_get_temp(void *p, int *temp)
>  	struct exynos_tmu_data *data = p;
>  	int value, ret = 0;
>  
> -	if (!data || !data->tmu_read || !data->enabled)
> +	if (!data || !data->tmu_read)
>  		return -EINVAL;
> +	else if (!data->enabled)
> +		/*
> +		 * Called too early, probably
> +		 * from thermal_zone_of_sensor_register().
> +		 */
> +		return -EAGAIN;
>  
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
