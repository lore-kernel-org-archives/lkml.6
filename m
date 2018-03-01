Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965064AbeCAIUE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:20:04 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52082 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934985AbeCAIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:20:01 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180301081958euoutp02e062c3a75bcfb7729240364acb4b79f1~XvhV5G8851600716007euoutp02K
X-AuditID: cbfec7f4-713ff700000043e4-4a-5a97b7ad142d
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in
 analogix_dp_bind
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yakir Yang <ykk@rock-chips.com>,
        =?UTF-8?Q?=c3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <b8675afb-a674-e4c9-4030-d527d0e5c456@samsung.com>
Date: Thu, 01 Mar 2018 09:19:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <19741148.ZWsFISTM5I@diego>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO7cdx2anOfOlwmAQSJBlBH1Y2U3i/Onyqx8j09UOWjqVzUtF
        l1XMZJbaDCczpcSkxNJSnBpYOnWlKZpmlqyZVFIyRs0iy0sdzwL/Pe/7Pt/3PO/Dy5KqGXo1
        ezI9SzCm69I0jJxq7pkd2PjAaddunu2OwtcHXhD4cr6Pxv01HQwe+eFncN14J8KLk9M0rrCd
        x78aekl8tWmSwDZvMYWH224x+PvEIolbbj4jcHuji8Kehn6EA5YFBhe9fsXg2bZKCue9WYUH
        zCWy3Wq+rrIO8eXmIYofLrxO8C2easS3Ojwy3vlzgua9BW6Cb6y+yM87nlJ8YVMt4p2jlSQf
        eBx5WKGV79ALaSdzBOOmuCR5ytTbSiLzj/r0G+c8YUbOlVbEssBthd7SMCuSsyruHoKZ6TKZ
        VAQQuKvakRWFLJHye+wyEau4GgTjpUdErORWwq+S95SISS4WPi9YaIkzheC+d6+Iw7hEcE06
        l/pqTguDs2OMKEByThqGH/kZccBwMWD1WRnp0zh42p+/9IDi1kOzZ4wWnYZzR2F6br/YDuGi
        oKZwgJZ010HHyFTQQwRcsbylJM+jMnCNHpBwPFR1lwf7YfDV3SST8FoYLimgRD/AFSFYWPxC
        SEUZgvpvliBrO7jcQ0G1ULA120kpOiXk56kkCg+9k/4gfQ90VQwyUoo+BJ/qLXQxinQsC8yx
        LDDHsiUcy5a4jahaFCFkmwzJgmlLupAbbdIZTNnpydEnMgyP0b9b7Ftwz7SgtrnjnYhjkUah
        HCuya1W0Lsd0xtCJgCU1amWfs1SrUup1Z84KxoxEY3aaYOpEa1hKE6E8FnVBq+KSdVlCqiBk
        Csb/U4INWW1G6lP1esXrhOrwFa2+pISEQ5B3zWimNcfO+nMMGw9+3OuZuuytkV/yehWrvm+L
        Ox06EpvS8bDgne33ztyuwKdvhT9u6AuGUKk8+u7EOZ7Z+j6ypTG++0LvPc3LnQpXpt2yLzEh
        Vx/qn3syfyL17ujHkg93hviAjRtMfL6LbrP7GjSUKUUXs4E0mnR/ATF7mV2HAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xq7prt0+PMpiwk9ui99xJJoumjres
        FmeXHWSzuPL1PZvFmtuHGC3+P3rNajF3Uq3Fjw2nmC3atzxisph0fwKLxeVdc9gsPj34z2yx
        Y8oBJot9mw+zWNzdcJbR4nPrPzaL/quX2Cx+7prHYtF2XcziXMNkdgcRjzXz1jB6zG64yOJx
        ua+XyWPH3SWMHjtn3WX32P7tAavH/e7jTB6bl9R7/J21n8Wjb8sqRo/t1+Yxe3zeJBfAE8Vl
        k5Kak1mWWqRvl8CV8fzmPKaC3yIV17f/ZWpg3C7YxcjJISFgItFxbDp7FyMXh5DAEkaJqevb
        GEESvAKCEj8m32MBsZkFzCS+vDzMClH0nFHizKZuNpCEsEC8xOFH21lBbBGBKInr77eCFTEL
        7GSVWPV3GQtEx1tGid5p58HGsgkYSnS97WKDWGEnsf9sB1g3i4CqxLa7N8BsUYEYiakfN4LZ
        nAIaEsv6zrFCnCEvcfDKc6iTxCWaW2+yTGAUmIXk2llIrp2FpGUWkpYFjCyrGEVSS4tz03OL
        jfSKE3OLS/PS9ZLzczcxAmN427GfW3Ywdr0LPsQowMGoxMPrsH9alBBrYllxZe4hRgkOZiUR
        3tPbgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5zxtURgkJpCeWpGanphakFsFkmTg4pRoYGYUF
        fSROzkq+/EmgtX7vHO0nTqeFF6s5FzKtUbWPkyl+2DPf0e2a27Tzu/7frxZ6Jcg6beWDbvd3
        ZReaf3KXxkdnrZ/9TF6iaUnkN+ZFVt8vc8dkXTneuenPOrHFqX2mF35Mny+2X3CbwOU5AVq1
        ZjOSnNbKfuOdv7pboIBhplCJ+oTWu0UFSizFGYmGWsxFxYkA1oNwFt0CAAA=
X-CMS-MailID: 20180301081957eucas1p261ec1dea9c09a020653d32b93527d33a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180228152110epcas2p2f604c46e842dae0cd09cea45af38503c
X-RootMTR: 20180228152110epcas2p2f604c46e842dae0cd09cea45af38503c
References: <20180130202913.28724-1-thierry.escande@collabora.com>
        <20180130202913.28724-6-thierry.escande@collabora.com>
        <CGME20180228152110epcas2p2f604c46e842dae0cd09cea45af38503c@epcas2p2.samsung.com>
        <19741148.ZWsFISTM5I@diego>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Thanks for adding me to this thread.

On 2018-02-28 16:20, Heiko Stübner wrote:
> Am Dienstag, 30. Januar 2018, 21:28:35 CET schrieb Thierry Escande:
>> From: zain wang <wzz@rock-chips.com>
>>
>> The bridge does not need to be powered in analogix_dp_bind(), so
>> remove the calls to pm_runtime_get()/phy_power_on()/analogix_dp_init_dp()
>> as well as their power-off counterparts.
>>
>> Cc: Stéphane Marchesin <marcheu@chromium.org>
>> Signed-off-by: zain wang <wzz@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> [the patch originally just removed the power_on portion, seanpaul removed
>> the power off code as well as improved the commit message]
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>> ---
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 10 ----------
>>   1 file changed, 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c index
>> cb5e18d6ba04..1477ea9ba85d 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1382,11 +1382,6 @@ analogix_dp_bind(struct device *dev, struct
>> drm_device *drm_dev,
>>
>>   	pm_runtime_enable(dev);
>>
>> -	pm_runtime_get_sync(dev);
>> -	phy_power_on(dp->phy);
>> -
>> -	analogix_dp_init_dp(dp);
>> -
>>   	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
>>   					analogix_dp_hardirq,
>>   					analogix_dp_irq_thread,
>> @@ -1414,15 +1409,10 @@ analogix_dp_bind(struct device *dev, struct
>> drm_device *drm_dev, goto err_disable_pm_runtime;
>>   	}
>>
>> -	phy_power_off(dp->phy);
>> -	pm_runtime_put(dev);
>> -
>>   	return dp;
>>
>>   err_disable_pm_runtime:
>>
>> -	phy_power_off(dp->phy);
>> -	pm_runtime_put(dev);
>>   	pm_runtime_disable(dev);
>>
>>   	return ERR_PTR(ret);
> In general, this patch seems to also create the opposite than
> "drm/bridge: analogix_dp: Keep PHY powered between driver bind/unbind" [0]
>
> posted on monday?
>
> [0] https://patchwork.kernel.org/patch/10242493/

Well, my patch was a quick workaround to avoid board freeze.

This patch looks like a proper fix. Besides removing runtime pm and phy
power calls from dp_bind, it also removes dp register access done in
analogix_dp_init_dp, as there is really no need to touch registers in bind
operation.

The patchset however suffers from other issues on Exynos hardware. I 
will post
them in that thread.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
