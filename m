Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeEGJdn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:33:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37555 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeEGJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:33:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180507093338euoutp022b4dc42a3da7a9c2aa7f1a79071e23f7~sUvyLssEG3097230972euoutp02F
X-AuditID: cbfec7f4-6f9ff700000043e4-94-5af01d7005bf
Subject: Re: [PATCH v2 03/13] drm/kms/mode/exynos-dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
To: Satendra Singh Thakur <satendra.t@samsung.com>, robin.murphy@arm.com,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>, sst2005@gmail.com,
        madhur.verma@samsung.com
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <000252e2-af94-f0af-d943-0c28aedc91f5@samsung.com>
Date: Mon, 7 May 2018 11:33:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525663938-4172-1-git-send-email-satendra.t@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sd0xTURTGvX2jD6T6LCjHgcZqImAERSM3cYS4UmNUEgcGI1jlBYgUsAUU
        NWowynIgI4VSpX+UlBBELUsa0AiRIaOgKGJkxapYixABB7haHkb++93zfd895ySHIcTvqQVM
        eGQMp4iURUhoR7K87kfrqmi34cDVHSXz8LXWRgHuGBuiscVkJXB6bxqJB3raSXzj7ScCm0z3
        hLglwSrEhrcvKfzcqKFxtumhANdm6Wj8eNhM4TumyyTWN3USODvjI+3HSotuFyFppbpbKDUU
        JtPSiq99lLQ3tV4gLdFdkF4vLUTSEcNifybQcWMIFxEexym8Nx91DFO90dHRDaLTVt0IcREV
        z0xBDgyw6+Cm8RuVghwZMVuA4Nn9pwK7IGZHEeg7fHlhBEFyYgb6lxjq6pxK6BFU9+imHoMI
        mpvfkXaXM5uCILOatAsubD8BE5la2i4QbDBoX1gnmWY94FdJ1ySL2M3QXVU9GSbZ5ZCUP07Y
        eS57CBI+/BDynjnQmGOe9DiwO6D5ft/Un0ugYlBD8OwKr815AntjYC8zkKWpIvm5t4G2cZTi
        2Rks9aVCnhfBn8o8Ac9noWsggeTDSQh6JxJpXtgAtfXttjBj6+ABd43efHkTXP1Zh+xlYGfB
        q8E5/AyzIL1cRfBlESRdEfPupdDbUkbw7Ar5bWN0GlqmnraZeto26mnbqP/31SKyELlysUp5
        KKf0ieROeSllcmVsZKjX8Si5Admur+l3/egDZPx5rAaxDJI4iWaohgLFlCxOGS+vQcAQEhfR
        7Ce2kihEFn+GU0QFK2IjOGUNWsiQEldRkPv5QDEbKovhTnBcNKf4pwoYhwW2swlaaa7uyjRq
        zvmrHu1ltL5Xt93KnQiXf0nJa6jw3X4px23hep8YKmznn5HFDQH9PmTA9zL/3fsK8AQYVzhZ
        WtbusWCt5+fiPD+v7sNtt4pnbDLsT4s56OZUclJm2ZLDXdCM98y/uNR8/kidVS3+7k5lO29N
        HnLTp/rl7jrgflYvIZVhsjWehEIp+wvLmq9MeQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xu7r5sh+iDG6f5LLoPXeSyeLK1/ds
        Fq/Ov2G2mHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLA5PXcJm
        cfDDE1aLtedbWSyWn77ObDFj8ks2BwGPNfPWMHrsnHWX3WPTqk42j+3fHrB63O8+zuSxeUm9
        R9+WVYwenzfJBXBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZk
        lqUW6dsl6GVMv7OEreAEb8WbJZ+ZGxjXcXcxcnJICJhIvL95nbWLkYtDSGApo0TX5UvMEAlx
        id3z30LZwhJ/rnWxQRS9ZpS4tPM4K0hCWKCLUWLKXhaQhIjAQ2aJZRd/soEkmAXiJdbdXcMC
        0XGKUeL2k3ZGkASbgKbE3803wYp4Bewk7u4B6ebkYBFQkehY+gtsnahAhMS985+gagQlTs58
        AlbDKeAmcWbjA6gF6hJ/5kGcyiwgL7H97RwoW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKs
        YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIz3bcd+btnB2PUu+BCjAAejEg8vw/T3UUKsiWXF
        lbmHGCU4mJVEePmPAoV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5iK8kriDU0NzS0sDc2N
        zY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MEq5lr4w1Su9b1YvkHjthy2fl9r8Wsm+
        hqxvu5IuM1qv2KBS+DCgN+z2tY6vE6InrnL8vnGb9fLJHEzfG5896DnoqBF/0Plf6MFwgaye
        8on7s7RC4sQ/mRv84DlT+z3/xP8JnK71+UkMqzccUCzo1PNnFD6fnR39ory5w1BA0KA/SEOJ
        +yuDEktxRqKhFnNRcSIAl8OegA0DAAA=
X-CMS-MailID: 20180507093335eucas1p13fb677f7e21b0fd874a7373196f51227
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180507093335eucas1p13fb677f7e21b0fd874a7373196f51227
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9
X-RootMTR: 20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9
References: <920ac8d1-8d2d-1332-256d-21472f69fca5@arm.com>
        <CGME20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9@epcas5p2.samsung.com>
        <1525663938-4172-1-git-send-email-satendra.t@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satendra Singh Thakur,

On 07.05.2018 05:32, Satendra Singh Thakur wrote:
> To avoid duplicate logic for the same
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Acked-by: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>

Whole exynos_dsi_mode_set callback is redundant, so I have posted patch
removing it [1], so this patch can be dropped.

[1]: https://marc.info/?l=dri-devel&m=152568538400712


Regards
Andrzej

> ---
>
>  v2: Removed Mr Robin from reviewed-by field	
>
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 7904ffa..7fe84fd 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1490,17 +1490,8 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
>  				struct drm_display_mode *adjusted_mode)
>  {
>  	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
> -	struct videomode *vm = &dsi->vm;
> -	struct drm_display_mode *m = adjusted_mode;
> -
> -	vm->hactive = m->hdisplay;
> -	vm->vactive = m->vdisplay;
> -	vm->vfront_porch = m->vsync_start - m->vdisplay;
> -	vm->vback_porch = m->vtotal - m->vsync_end;
> -	vm->vsync_len = m->vsync_end - m->vsync_start;
> -	vm->hfront_porch = m->hsync_start - m->hdisplay;
> -	vm->hback_porch = m->htotal - m->hsync_end;
> -	vm->hsync_len = m->hsync_end - m->hsync_start;
> +
> +	drm_display_mode_to_videomode(adjusted_mode, &dsi->vm);
>  }
>  
>  static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
