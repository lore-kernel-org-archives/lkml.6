Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbeCFHfg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:35:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45858 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:35:34 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180306073531euoutp02ad6e4b50128790a9bc4fd68dce3f793e~ZRI9npd650938309383euoutp02q
X-AuditID: cbfec7f2-1c1ff70000011644-3b-5a9e44c2a349
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [PATCH v4 15/38] drm/bridge: analogix_dp: Ensure edp is
 disabled when shutting down the panel
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <3b9537bb-0471-775e-d43b-1f1ccd46b94c@samsung.com>
Date: Tue, 06 Mar 2018 08:35:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180305222324.5872-16-enric.balletbo@collabora.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxNYRzH95y3e0rXjiP6eYvdpWHqajOesLw1TqzhP7sZLp3F3FvcU5EN
        ecnLTbd05+3gzrDQWrW65W2om1xKKjWvu7lllbRCqVCK29HWf9/n+X5+z+/7++1hSb6Dnszu
        jI0XTbF6g4bxpoqf/qoOcoTbdPP6zQtx2svnBD5ysoPGVVmlDK7v+crgnA8OhIea2ml8JfMA
        /plfQeIT9iYCZ37MoHDd/csM7nIPkdjm6Ef4UWEZhV35VQh3pwwy+Nd9G4WPv5m4jBdybDlI
        uJRcSwl1ljRCuOu6gYR7sksl3Ol108LHVCchFN44JPyRH1OCxZ6NhDuvbaTQXeC/3kfnvSRa
        NOxMFE3asK3eO553nSF35/vuG+ypZpLR4XFm5MUCNx9uVuYhM/Jmee4WgmbXGZXH4LluBP3Z
        Y0egJtlJKVAWgraB96THUHPj4Ke1gfJoklsELYMptAK1IrD//j0MjecM8MP5VeUxfLk2BPnl
        7YTnQHIWAqyWxuFyhgsBc4eZUZ4Ng/M932iPpriZkNtQ9I9h2QncJmgfWOW59uJWgPt2HqF0
        ng6l9a3/U/jB0ZR3w1GBq1DBsd5ORpkhHFKv3yMVPR6+OO0qRU+FOmsqpehDYOl7QijFpxE8
        PHaWUIzFUOaspZUOYyGz+DzpCQScGk4e5xVEgJKmof/4cjiX7lYpq3iBYKDGTmcgf3nUyuRR
        K5NHDSGPGuIqorKRn5ggGWNEKSRW3Bss6Y1SQmxM8PY4YwH69wkrB51dd1HPq20OxLFI46Nm
        117R8bQ+UUoyOhCwpMZXvVFr0/HqaH3SftEUt8WUYBAlB5rCUho/9eZZB3U8F6OPF3eJ4m7R
        NOISrNfkZKSNMqI3SXPXynOfzV5fGBFJrtEEfSpQnwp9O6YoZgnhWp57bSLZ+t2Y23mhefVn
        9+dgqlK7IaPRj3jx7E8oelDzzrigPGKdtl5CF61F808zfEZDVnVgVVBbcdLBa5MC1ZOWztiT
        F5Atm/umbS5b3RJlTdAceVjSlR4QaVg8hw9bqaGkHfqQOaRJ0v8FQwkPnIADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xa7qHXOZFGTz7KmrRe+4kk0VTx1tW
        i7PLDrJZXPn6ns1ize1DjBb/H71mtZg7qdbix4ZTzBbtWx4xWUy6P4HF4vKuOWwWnx78Z7aY
        d+g3o8W+zYdZLO5uOMto8bn1H5vFz13zWCzaros5CHmsmbeG0WN2w0UWj8t9vUweO+4uYfTY
        Oesuu8f2bw9YPe53H2fy2Lyk3uPvrP0sHn1bVjF6bL82j9nj8ya5AJ4oLpuU1JzMstQifbsE
        royTnyYyF2wQqfj39TxbA2OjYBcjJ4eEgInEo1nHWboYuTiEBJYwSrxu62UCSfAKCEr8mHyP
        BcRmFjCT+PLyMCtE0XNGie3PHrKBJIQFciSuv1wJlhAReMkocbL3FTuIwyzQwyRx5vhkqLln
        GCV2rH7ICtLCJmAo0fW2iw1ih53E9K8fwOIsAqoS6+5tBdsnKhAjMfXjRrA4p4CTxIOV65kg
        7pCXOHjlOdRN4hLNrTdZJjAKzEJy7iwk585C0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnp
        esn5uZsYgRG77djPLTsYu94FH2IU4GBU4uHd4DE3Sog1say4MvcQowQHs5IIb4T+vCgh3pTE
        yqrUovz4otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjN4zZJ2+nb8tN//9
        4ttvK8R/KO0KXcZmdjRgLsNCMbl4w25PBaObUsvX7JINdBd9/tpNNObI7behX4J0IqzO2wqq
        ZLgU7zlw4gXj3v0zuKR2Rt899Cnt0sy69Wf41970WpK7aIk09+XbllEy561Ma+4pJi2KbqwW
        kuYMsFx4Ka2pXThQYtkBViWW4oxEQy3mouJEAO0FZATUAgAA
X-CMS-MailID: 20180306073530eucas1p296c42fd68e96b4d01b8eb4c80bf7f5c8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180305222414epcas5p4bdc22ede027606945c97d3429c3bd10c
X-RootMTR: 20180305222414epcas5p4bdc22ede027606945c97d3429c3bd10c
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
        <CGME20180305222414epcas5p4bdc22ede027606945c97d3429c3bd10c@epcas5p4.samsung.com>
        <20180305222324.5872-16-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is the patch, which introduces the issue I've pointed here:

https://lists.freedesktop.org/archives/dri-devel/2018-March/167794.html

On 2018-03-05 23:23, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
>
> When panel is shut down, we should make sure edp can be disabled to avoid
> undefined behavior.
>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 92fb9a072cb6..9b7d530ad24c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1160,6 +1160,12 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>   
>   	pm_runtime_get_sync(dp->dev);
>   
> +	ret = clk_prepare_enable(dp->clock);
> +	if (ret < 0) {
> +		DRM_ERROR("Failed to prepare_enable the clock clk [%d]\n", ret);
> +		goto out_dp_clk_pre;
> +	}
> +
>   	if (dp->plat_data->power_on)
>   		dp->plat_data->power_on(dp->plat_data);
>   
> @@ -1191,6 +1197,8 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>   	phy_power_off(dp->phy);
>   	if (dp->plat_data->power_off)
>   		dp->plat_data->power_off(dp->plat_data);
> +	clk_disable_unprepare(dp->clock);
> +out_dp_clk_pre:
>   	pm_runtime_put_sync(dp->dev);
>   
>   	return ret;
> @@ -1234,10 +1242,13 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>   
>   	disable_irq(dp->irq);
>   	phy_power_off(dp->phy);
> +	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);

In case of Exynos DP, external PHY is used to power the DP block, so no
register access should be performed after phy_power_off(). Please move
analogix_dp_set_analog_power_down() before phy_power_off().

>   
>   	if (dp->plat_data->power_off)
>   		dp->plat_data->power_off(dp->plat_data);
>   
> +	clk_disable_unprepare(dp->clock);
> +
>   	pm_runtime_put_sync(dp->dev);
>   
>   	ret = analogix_dp_prepare_panel(dp, false, true);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
