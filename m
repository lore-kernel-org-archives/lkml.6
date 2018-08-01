Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="auuMZD4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeHAKUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:20:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64747 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbeHAKUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:20:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180801083607epoutp030d6de20194e6e247e5cc3bb06ecc3614~GtcHv50_o2749427494epoutp03X;
        Wed,  1 Aug 2018 08:36:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180801083607epoutp030d6de20194e6e247e5cc3bb06ecc3614~GtcHv50_o2749427494epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533112567;
        bh=NDLzxArRetfNSNc+OShDz+kUd7xcm84RVMbeqSjkCao=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=auuMZD4FQwLd8fawIAUkVsTCDQIMvDPI96LJ/uND8aaTt7DFpqQfi5ivY1IR3w7Hr
         tZletFEswZWtatN1Hkl0wP7irn4wHhr5lwpK9Brxqw24id8lAt0HRySLZHsxkzBeFQ
         /NOmPTG9hfswjd3/0H+9FdaqWUvf88gQ0RjGX4pE=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180801083605epcas1p391d6c042deced0df39d8eacc97b484a0~GtcFT60hO3071830718epcas1p3E;
        Wed,  1 Aug 2018 08:36:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.2A.04210.5F0716B5; Wed,  1 Aug 2018 17:36:05 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180801083604epcas1p17fe882ab53e3371a7c0b6a119f4fcb57~GtcFCLaIY0146201462epcas1p1Q;
        Wed,  1 Aug 2018 08:36:04 +0000 (GMT)
X-AuditID: b6c32a36-73bff70000001072-0b-5b6170f56712
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id DD.D2.03704.4F0716B5; Wed,  1 Aug
        2018 17:36:04 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCR001ZHX83TLA0@mmp2.samsung.com>; Wed, 01 Aug 2018 17:36:04 +0900 (KST)
Message-id: <5B6170F4.4070102@samsung.com>
Date:   Wed, 01 Aug 2018 17:36:04 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        kernel@collabora.com, robin.murphy@arm.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] devfreq: rockchip-dfi: Move GRF definitions to a
 common place.
In-reply-to: <20180730081124.30698-2-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmru7XgsRog/XdLBa9504yWbzavIfN
        4srX92wWa24fYrT4/+g1q8XcSbUWPzacYrbYfK6H1eJs0xt2i02Pr7FafOy5x2pxedccNovP
        vUcYLT49+M9scfGUq8XtxhVsFq17j7BbHPzwhNXi37WNLBZ3N5xltHj58QSLg6jHmnlrGD3e
        32hl95jdcJHFY8fdJYwem1Z1snls//aA1eN+93Emj81L6j3+ztrP4tG3ZRWjx/Zr85g9Pm+S
        C+CJSrXJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAXpW
        SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrFG1oaKRnaGCuZ2QEpI1jrYxMgUoSUjNO/PnO
        WLBIpmLC1m2MDYx/xLoYOTkkBEwk5t15wtbFyMUhJLCDUaKjqZkZwvnOKHHpzGQmmKrDx6cx
        QSQ2MEqcnjqJDSTBKyAo8WPyPZYuRg4OZgF5iSOXskHCzAKaElt3r2eHqL/LKPFheQMTRL2W
        xIWueYwgNouAqsTTxefAbDag+P4XN8Bm8gsoSlz98RgsLioQIbFz/jewQSIC/cwSnzubwa5g
        FrjPJHFlwnmwDmGBSIljWz6wg9icAk4Siy9tBPtBQuAtu0Tf2m/MED+4SEw4dZ4RwhaWeHV8
        CzvI2RIC0hKXjtpC1LczSnx50cwK4UwAuvvUZmgAGEs8W9jFBPEcn8S7rz2sEM28Eh1tQhCm
        h8TRV0oQL59llLh/6AnLBEbZWUihNAsRSrOQQmkBI/MqRrHUguLc9NRiwwIjveLE3OLSvHS9
        5PzcTYzgRK1ltoNx0TmfQ4wCHIxKPLwFlQnRQqyJZcWVuYcYJTiYlUR4bWTio4V4UxIrq1KL
        8uOLSnNSiw8xmgIDeSKzlGhyPjCL5JXEG5oaGRsbW5gYmpkaGiqJ8xr5BUcLCaQnlqRmp6YW
        pBbB9DFxcEo1MLZt1XyzdM3if8uqrR1f+jz4d/f8FdXrrTKf9jMcOlHLeSlQyvXgjGnZD63F
        GhiSqtSE3K98ZP01Xbhq3Uz925H6n3awz54gaP16/WzlCuvwFzWaF57m8amF6GuWz2dhv+jW
        MNVg/tqH4u4a/yLKZuQrmmmciXUNWvWp5PtHSc/JTy81BUf05CuxFGckGmoxFxUnAgAqq+Jo
        6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t9jQd0vBYnRBttXalv0njvJZPFq8x42
        iytf37NZrLl9iNHi/6PXrBZzJ9Va/Nhwitli87keVouzTW/YLTY9vsZq8bHnHqvF5V1z2Cw+
        9x5htPj04D+zxcVTrha3G1ewWbTuPcJucfDDE1aLf9c2sljc3XCW0eLlxxMsDqIea+atYfR4
        f6OV3WN2w0UWjx13lzB6bFrVyeax/dsDVo/73ceZPDYvqff4O2s/i0ffllWMHtuvzWP2+LxJ
        LoAnissmJTUnsyy1SN8ugSvjxJ/vjAWLZCombN3G2MD4R6yLkZNDQsBE4vDxaUxdjFwcQgLr
        GCXO9+1iB0nwCghK/Jh8j6WLkYODWUBe4silbJAws4C6xKR5i5gh6u8zSky/+4EZol5L4kLX
        PEYQm0VAVeLp4nNgNhtQfP+LG2wgNr+AosTVH48ZQWaKCkRIdJ+oBJkjItDPLDHt2hlGEIdZ
        4D6TxKV368CahQUiJY5t+cAOse0so8Sm+bNYQBKcAk4Siy9tZJ7AKDALybGzEI6dheTYBYzM
        qxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLzczcxAmN322Gtvh2M95fEH2IU4GBU4uE9UZ0Q
        LcSaWFZcmXuIUYKDWUmE10YmPlqINyWxsiq1KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZ
        qakFqUUwWSYOTqkGRnt+AzfNCRYPXFN0ooPDuKZsrRZ57Vs6ad5dByWWxQ+VQ3U/tmwTrkpz
        Cvv19HWMSeuhe9rzHZLbbnNayCz+0/SsWFtS2aZv8afqRSdqWeYtL1x7LPz35FI5xrmvCrf+
        6ntWOe/dcp/gyX0yfW6zDq1csv3C9CkhyQfZPmpdv7lxbQm335knfkosxRmJhlrMRcWJAHLx
        qtjZAgAA
X-CMS-MailID: 20180801083604epcas1p17fe882ab53e3371a7c0b6a119f4fcb57
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180730081245epcas3p2794d7d7c21f4059ab89ec59a0ef9fa22
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
        <CGME20180730081245epcas3p2794d7d7c21f4059ab89ec59a0ef9fa22@epcas3p2.samsung.com>
        <20180730081124.30698-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 07월 30일 17:11, Enric Balletbo i Serra wrote:
> Some rk3399 GRF (Generic Register Files) definitions can be used for
> different drivers. Move these definitions to a common include so we
> don't need to duplicate these definitions.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v1:
> - [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Even if you add the changes log, you are missing my Acked-by tag.

> - [RFC 1/10] s/Generic/General/ (Robin Murphy)
> - [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
> - [RFC 7/10] Removed from the series. I did not found a use case where this matters.
> 
>  drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
>  include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
>  2 files changed, 28 insertions(+), 16 deletions(-)
>  create mode 100644 include/soc/rockchip/rk3399_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 22b113363ffc..2fbbcbeb644f 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,6 +26,8 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  
> +#include <soc/rockchip/rk3399_grf.h>
> +
>  #define RK3399_DMC_NUM_CH	2
>  
>  /* DDRMON_CTRL */
> @@ -43,18 +45,6 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>  
> -/* pmu grf */
> -#define PMUGRF_OS_REG2	0x308
> -#define DDRTYPE_SHIFT	13
> -#define DDRTYPE_MASK	7
> -
> -enum {
> -	DDR3 = 3,
> -	LPDDR3 = 6,
> -	LPDDR4 = 7,
> -	UNUSED = 0xFF
> -};
> -
>  struct dmc_usage {
>  	u32 access;
>  	u32 total;
> @@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  	u32 ddr_type;
>  
>  	/* get ddr type */
> -	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
> +	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
>  
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>  
>  	/* set ddr type to dfi */
> -	if (ddr_type == LPDDR3)
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type == LPDDR4)
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>  
>  	/* enable count, use software mode */
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
> new file mode 100644
> index 000000000000..3eebabcb2812
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip General Register Files definitions
> + *
> + * Copyright (c) 2018, Collabora Ltd.
> + * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> + */
> +
> +#ifndef __SOC_RK3399_GRF_H
> +#define __SOC_RK3399_GRF_H
> +
> +/* PMU GRF Registers */
> +#define RK3399_PMUGRF_OS_REG2		0x308
> +#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> +#define RK3399_PMUGRF_DDRTYPE_MASK	7
> +#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
