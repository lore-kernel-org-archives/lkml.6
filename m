Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754441AbeDWJWR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:22:17 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38626 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbeDWJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:22:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180423092214euoutp013afe058a5d032e1ed6b289021a8bcde8~oBj1AKW3i0874208742euoutp01A
X-AuditID: cbfec7f2-1dbff70000011644-27-5adda5c357cf
Subject: Re: [PATCH] drm/bridge/sii8620: fix link error
To: Tobias Regnery <tobias.regnery@gmail.com>, architt@codeaurora.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: m.purski@samsung.com
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b3a6953d-024d-e350-0729-bfbfcbbd8321@samsung.com>
Date: Mon, 23 Apr 2018 11:22:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423084700.27888-1-tobias.regnery@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7qHl96NMji9zcKiqeMtq8WVr+/Z
        LC7vmsNmseDlLRaLqxcvsTqwelzu62Xy2DnrLrvH/e7jTB59W1YxenzeJBfAGsVlk5Kak1mW
        WqRvl8CVcfboeuaCFp6KcxfPsTUwLuDqYuTkkBAwkTix+w1jFyMXh5DACkaJbccOM0E4Xxgl
        rq09zAzhfGaUmHhxAitMy7IPT1khEssZJZ7ufc4GkhASeMso8bbFDcQWFjCXONW2jB2kSESg
        jVHi683FzCAJZgEJia7Fb8Ea2AQ0Jf5uvglm8wrYScxf+4QFxGYRUJWYtOwXWL2oQIRE0/Of
        7BA1ghInZ4LUcHBwAtVv/VUEMVJeYvvbOVDjxSVuPZkP9oKEwCJ2iRMHJ7NAXO0iMfv1bCYI
        W1ji1fEt7BC2jMTpyT1QNdUSN180sUA0dzBK3P/dzgaRsJY4fPwiK8hiZqCj1+/ShwjbSqw8
        uJUNJCwhwCdx460gxA18EpO2TWeGCPNKdLQJQVQrStw/u5UZwhaXWHrhK9sERuVZSB6bheSb
        WUi+mYWwdwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAdHP63/FPOxi/Xko6xCjA
        wajEw7tD926UEGtiWXFl7iFGCQ5mJRHeYj+gEG9KYmVValF+fFFpTmrxIUZpDhYlcd44jboo
        IYH0xJLU7NTUgtQimCwTB6dUA2PBL/OH2xgDmV7GnDy1h/2n/LvKfW03rZpW/+FlWrQrfVHm
        8/ZPOXs2Lz7VGa32kl3mVb90/cabh/Q5fCb0vuNeOnkR9ylO9pwQXqUdOy9bmktd2vhIw/aa
        7T3GOc6ux2c3FVg4azgGrWgsNxQMMot4FX75ySzHT/aKB5TmLlIJaFri9Osbv54SS3FGoqEW
        c1FxIgCSQUZQMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7qHlt6NMjj8VsSiqeMtq8WVr+/Z
        LC7vmsNmseDlLRaLqxcvsTqwelzu62Xy2DnrLrvH/e7jTB59W1YxenzeJBfAGqVnU5RfWpKq
        kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcfboeuaCFp6KcxfP
        sTUwLuDqYuTkkBAwkVj24SlrFyMXh5DAUkaJK+vmMkIkxCV2z3/LDGELS/y51sUGUfSaUWL1
        jfusIAlhAXOJU23L2EESIgJtjBL7zr1iB0kwC0hIdC1+C9UxkVHi6LKFbCAJNgFNib+bb4LZ
        vAJ2EvPXPmEBsVkEVCUmLfsFtk5UIELi3vlPUDWCEidngtRwcHAC1W/9VQQxX13iz7xLzBC2
        vMT2t3OgbHGJW0/mM01gFJqFpHsWkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85
        P3cTIzDGth37uXkH46WNwYcYBTgYlXh4d+jejRJiTSwrrsw9xCjBwawkwlvsBxTiTUmsrEot
        yo8vKs1JLT7EaAr020RmKdHkfGD855XEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0t
        SC2C6WPi4JRqYCw/IVPqr79ZYdn7+WdWPtrzVGbz7adXIlobr78+de3JFVbmNtdVZd/XTY71
        e9HfLmNeskVFaOGUh1fXLE/MKj8aI/uPu/f7jO5H69hf9P3MrPm8YiPLSrsC5s/9guGC99nU
        z02MPPufacbcZe6HbOMuL2lxz7g4R/rmt/9eE++m156PjsqMFdRQYinOSDTUYi4qTgQAzQ2S
        fMcCAAA=
X-CMS-MailID: 20180423092211eucas1p2b1ae1e00224695b5d10eef7a66071ebe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180423092211eucas1p2b1ae1e00224695b5d10eef7a66071ebe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423085639epcas3p13d9c120cba4c41bf3f0f18be25f83590
X-RootMTR: 20180423085639epcas3p13d9c120cba4c41bf3f0f18be25f83590
References: <CGME20180423085639epcas3p13d9c120cba4c41bf3f0f18be25f83590@epcas3p1.samsung.com>
        <20180423084700.27888-1-tobias.regnery@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

On 23.04.2018 10:47, Tobias Regnery wrote:
> With CONFIG_EXTCON=m and CONFIG_DRM_SIL_SII8620=y we see the following link
> error:
>
> drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_remove':
> sil-sii8620.c:(.text+0xd5): undefined reference to `extcon_unregister_notifier'
> drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_probe':
> sil-sii8620.c:(.text+0x2a4b): undefined reference to `extcon_find_edev_by_node'
> sil-sii8620.c:(.text+0x2af4): undefined reference to `extcon_register_notifier'
> drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_extcon_work':
> sil-sii8620.c:(.text+0x2b94): undefined reference to `extcon_get_state'
>
> Fix this by selecting EXTCON.
>
> Fixes: 688838442147 ("drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>

There is already pending patch[1].

[1]: https://patchwork.kernel.org/patch/10330653/

Regards
Andrzej

> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3aa65bdecb0e..ab99e36ee034 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -74,6 +74,7 @@ config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF && RC_CORE
>  	select DRM_KMS_HELPER
> +	select EXTCON
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>  
