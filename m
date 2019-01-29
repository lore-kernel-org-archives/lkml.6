Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CFFC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4475F2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ryT4fe7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfA2Bex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:34:53 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:27790 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA2Bew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:34:52 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190129013449epoutp01cfa4a52d592a9a58a877e77ac7f3abeb~_Lc8qt3ap0578905789epoutp01K
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:34:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190129013449epoutp01cfa4a52d592a9a58a877e77ac7f3abeb~_Lc8qt3ap0578905789epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548725689;
        bh=S0Gji/xq64TFfTZeMREx18ih4CAxo/ol2B9nQXBr3H4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ryT4fe7/jplK/y2prwPGnpvlsrjaVLFn5IEd1vN9CHbfQF/ScVecvgSbif+FlUQ9D
         s5v1htkXbZbHnPGjvXqUXNZoPndSqj+q//SzUNNJCV1yzMTjFtGroOKe6CgahYX6bC
         YKUK4DFgGkygIqon6NHh/Ba1SrR6a3HfduhFSt3w=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129013446epcas1p16aebd7dd95eb6e335f255df5855cde71~_Lc6J76yO2912729127epcas1p1K;
        Tue, 29 Jan 2019 01:34:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.85.04288.0BDAF4C5; Tue, 29 Jan 2019 10:34:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190129013439epcas1p1142a75d3d12590aeba0917d2d77e8a94~_LczBLeLO2617426174epcas1p1O;
        Tue, 29 Jan 2019 01:34:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190129013439epsmtrp1e2d36e7f62d21b992168cb89217cfcfb~_Lcy9mDor0089200892epsmtrp1k;
        Tue, 29 Jan 2019 01:34:39 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-bf-5c4fadb049b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.66.03601.FADAF4C5; Tue, 29 Jan 2019 10:34:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129013439epsmtip19f6ac2f4f01dd9ff6da71d30d7c77437~_Lcyy1q8M2860128601epsmtip1G;
        Tue, 29 Jan 2019 01:34:39 +0000 (GMT)
Subject: Re: [PATCH] MAINTAINERS: Change entry name of samsung exynos bus
 frequency driver
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5a106670-9524-a101-2098-ea3c03e72699@samsung.com>
Date:   Tue, 29 Jan 2019 10:34:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1544578871-5278-1-git-send-email-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmvu6Gtf4xBt+72S3mrF/DZvF30jEg
        63wLi0Xz4vVsFufPb2C3uLxrDpvF+0+dTBbbNy9kduDw+P1rEqPHlpU3mTw2repk8zgx4zeL
        x/65a9g97vxYyujxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi
        0rx0veT8XCtDAwMjU6DChOyMr+8nsBds5q+YsWc/SwPjK54uRk4OCQETia5zXUxdjFwcQgI7
        GCWeHH/BDuF8YpS4fOohlPONUeLvidvMMC2f5jxghEjsZZTYeXc9O0hCSOA9o8TeGa4gtrBA
        jMS0k6vA4iICChKbe5+xgjQwC6xmlNix5TrYJDYBLYn9L26wgdj8AooSV388ZgSxeQXsJA5t
        2AsWZxFQlVi1aj8TiC0qECFxuPcdVI2gxMmZT1hAbE4BV4lfPdfB4swC4hK3nsxngrDlJZq3
        zmYGWSwh0M0usePiA1aIF1wknjy+wARhC0u8Or6FHcKWknjZ3wZlV0usPHmEDaK5g1Fiy/4L
        UM3GEvuXTgZq5gDaoCmxfpc+xDI+iXdfe1hBwhICvBIdbUIQ1coSlx/chVolKbG4vZMNwvaQ
        2H90J/sERsVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAhPk6N7ECE6yWhY7GPec8znE
        KMDBqMTDa8DmHyPEmlhWXJl7iFGCg1lJhHfqdb8YId6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwl
        mpwPzAB5JfGGpkbGxsYWJoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6mDg4pRoYHQuN1l86
        LnewXT8iIWTLh4tr9Pk/fIp3VbvWdzwp7+jzmZW8nbmxvJuClBj0N78+73K6QqJQ49qm7RM+
        nvu306HhhuYKdUGX3zsFd3uELFGZcLw/tCLzAufkBWwfHt8zSPYQ2s13a+G1Y0UbXnL9crew
        26O8S/+t/p7/+efurV71M4qrI88+VYmlOCPRUIu5qDgRADVW4gDIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO76tf4xBjPbuC3mrF/DZvF30jF2
        iznnW1gsmhevZ7M4f34Du8XlXXPYLN5/6mSy2L55IbMDh8fvX5MYPbasvMnksWlVJ5vHiRm/
        WTz2z13D7nHnx1JGj8+b5ALYo7hsUlJzMstSi/TtErgyvr6fwF6wmb9ixp79LA2Mr3i6GDk5
        JARMJD7NecDYxcjFISSwm1Fi+Z4TLBAJSYlpF48ydzFyANnCEocPF0PUvGWUaFh2lB2kRlgg
        RmLayVVgtoiAgsTm3mesIEXMAqsZJW5PP8cE0TGDUaLv+QNWkCo2AS2J/S9usIHY/AKKEld/
        PGYEsXkF7CQObdgLFmcRUJVYtWo/E4gtKhAh8fHpPiaIGkGJkzOfgF3HKeAq8avnOlgvs4C6
        xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAo
        L7Vcrzgxt7g0L10vOT93EyM43rS0djCeOBF/iFGAg1GJh9eAzT9GiDWxrLgy9xCjBAezkgjv
        1Ot+MUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoYex14
        xfJ+rQ/KsP5uE9q9SHOhTL/HVY2sPEP1DPuWN6nTzBuf2G1qan0rONlgx7zLM9Mcn/L5HJi2
        Oiqx91IVu+BxAavoqX3zTmlrChR0rqpPVt8y0awv86vpNdVfK5dmW8wW49h3SFoqxD3uTsGZ
        fIUaxti9jTbTzP+ubPvOVmCSqvWB102JpTgj0VCLuag4EQACAimoswIAAA==
X-CMS-MailID: 20190129013439epcas1p1142a75d3d12590aeba0917d2d77e8a94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181212014113epcas2p3e8f44ef2a016a896110df8fe85d0118f
References: <CGME20181212014113epcas2p3e8f44ef2a016a896110df8fe85d0118f@epcas2p3.samsung.com>
        <1544578871-5278-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Gently Ping.

Best Regards,
Chanwoo Choi

On 18. 12. 12. 오전 10:41, Chanwoo Choi wrote:
> The Samsung Exynos's device drivers have the 'SASMUNG EXYNOS' prefix
> in front of the specific device driver name. In order to keep the
> consistent naming format, change the entry name of bus frequency driver
> for Samsung Exynos and then reorder it alpabetically.
> - old : BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
> - new : SAMSUNG EXYNOS BUS FREQUENCY DRIVER
> 
> Also, remove the unneeded git repository information.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  MAINTAINERS | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8119141a926f..f180b8499036 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3248,15 +3248,6 @@ S:	Odd fixes
>  F:	Documentation/media/v4l-drivers/bttv*
>  F:	drivers/media/pci/bt8xx/bttv*
>  
> -BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
> -M:	Chanwoo Choi <cw00.choi@samsung.com>
> -L:	linux-pm@vger.kernel.org
> -L:	linux-samsung-soc@vger.kernel.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> -S:	Maintained
> -F:	drivers/devfreq/exynos-bus.c
> -F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> -
>  BUSLOGIC SCSI DRIVER
>  M:	Khalid Aziz <khalid@gonehiking.org>
>  L:	linux-scsi@vger.kernel.org
> @@ -13102,6 +13093,14 @@ S:	Supported
>  F:	sound/soc/samsung/
>  F:	Documentation/devicetree/bindings/sound/samsung*
>  
> +SAMSUNG EXYNOS BUS FREQUENCY DRIVER
> +M:	Chanwoo Choi <cw00.choi@samsung.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-samsung-soc@vger.kernel.org
> +S:	Maintained
> +F:	drivers/devfreq/exynos-bus.c
> +F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +
>  SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
>  M:	Krzysztof Kozlowski <krzk@kernel.org>
>  L:	linux-crypto@vger.kernel.org
> 
