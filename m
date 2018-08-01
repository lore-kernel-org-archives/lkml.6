Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B3220840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e6VDjYH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbeHAKxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:53:17 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10171 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbeHAKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:53:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180801090828epoutp017e39f2801ab6a503d168a5bdbd36e78a~Gt4XVWDXu0494104941epoutp01C;
        Wed,  1 Aug 2018 09:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180801090828epoutp017e39f2801ab6a503d168a5bdbd36e78a~Gt4XVWDXu0494104941epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533114508;
        bh=9+FUZFLQJOWJV1OA4NiZcQ7ixSCpwSwma500Za69Gz0=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=e6VDjYH2dNKwiGyiq/q4c4XeUartj0wXZiESlbnhF1ItNWjNTj7Ihx2Q/ACE0X3B5
         zutugdhXQNLWPxC2pheQKhrUttKzH3Hr8VPRhJSYyb1SWPBYDKPrxBWcW5QwOiVBCj
         iujSq0gcVyZCTffxnRClp1Okwk92NPxnsAbAbiT8=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180801090825epcas1p4e54453588c8097b47b9f3ed0822a1801~Gt4UkYIVz0658406584epcas1p4N;
        Wed,  1 Aug 2018 09:08:25 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.B5.04412.988716B5; Wed,  1 Aug 2018 18:08:25 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180801090825epcas2p13dc666cf68c6fcb9e1ae133e6417f262~Gt4UL3xjC0114601146epcas2p1P;
        Wed,  1 Aug 2018 09:08:25 +0000 (GMT)
X-AuditID: b6c32a47-271ff7000000113c-b2-5b617889a925
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 89.53.03824.888716B5; Wed,  1 Aug
        2018 18:08:25 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCR00BJJYPWY940@mmp2.samsung.com>; Wed, 01 Aug 2018 18:08:24 +0900 (KST)
Message-id: <5B617884.5070600@samsung.com>
Date:   Wed, 01 Aug 2018 18:08:20 +0900
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
Subject: Re: [PATCH 3/8] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
In-reply-to: <20180730081124.30698-4-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmuW5nRWK0waariha9504yWbzavIfN
        4srX92wWa24fYrT4/+g1q8XcSbUWPzacYrbYfK6H1eJs0xt2i02Pr7FafOy5x2pxedccNovP
        vUcYLT49+M9scfGUq8XtxhVsFq17j7BbHPzwhNXi37WNLBZ3N5xltHj58QSLg6jHmnlrGD3e
        32hl95jdcJHFY8fdJYwem1Z1snls//aA1eN+93Emj81L6j3+ztrP4tG3ZRWjx/Zr85g9Pm+S
        C+CJSrXJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAXpW
        SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrFG1oaKRnaGCuZ2QEpI1jrYxMgUoSUjOmXG5h
        LlhjVPH49FvGBsaX6l2MnBwSAiYSiz4sZu5i5OIQEtjBKLFk42Mo5zujxPcDN5lhqm59esQI
        kdjAKHGkpxsswSsgKPFj8j2WLkYODmYBeYkjl7JBwswCmhJbd69nh6i/yyjx/MxHRoh6LYm5
        M94xgdgsAqoSx96dBZvDBhTf/+IGG4jNL6AocfXHY7B6UYEIiZ3zv4ENEhHoZ5b43NnMBOIw
        C9xnkrgy4TxYh7BAgsSkqz/BOjgFnCQ2T/0M9oOEwFt2iQXtj6F+cJF4tm0KG4QtLPHq+BZ2
        CFta4tmqjYwQDe2MEl9eNLNCOBMYJT6c2swEUWUs8WxhFxPEd3wSHYf/soM8LSHAK9HRJgRR
        4iGxccl/FhBbSOAso8SCFrcJjLKzkIJpFiKYZiEF0wJG5lWMYqkFxbnpqcVGBcZ6xYm5xaV5
        6XrJ+bmbGMGpWst9B+O2cz6HGAU4GJV4eAsqE6KFWBPLiitzDzFKcDArifDayMRHC/GmJFZW
        pRblxxeV5qQWH2I0BYbyRGYp0eR8YB7JK4k3NDUyNja2MDW3NDawVBLnrfILjhYSSE8sSc1O
        TS1ILYLpY+LglGpgbJkQcrX9MTfz78BNR5YsnD1n89m+MyfXZf/+nR/XdjTkjvC9ko7VfpPK
        P5Wt2L/rzWP33tXWHULnfJcq7k6TiZxi90nm+K4ezR0fZyy/VVS4ccJnazk5o+S2e1avEv9Y
        eCx4q5S7V+WNHfMD9pUcFW8qg69vE+Z6OIHtYLW5qHPbvNT780U2rVdiKc5INNRiLipOBAC4
        YZu56wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t9jQd3OisRog+XruCx6z51ksni1eQ+b
        xZWv79ks1tw+xGjx/9FrVou5k2otfmw4xWyx+VwPq8XZpjfsFpseX2O1+Nhzj9Xi8q45bBaf
        e48wWnx68J/Z4uIpV4vbjSvYLFr3HmG3OPjhCavFv2sbWSzubjjLaPHy4wkWB1GPNfPWMHq8
        v9HK7jG74SKLx467Sxg9Nq3qZPPY/u0Bq8f97uNMHpuX1Hv8nbWfxaNvyypGj+3X5jF7fN4k
        F8ATxWWTkpqTWZZapG+XwJUx5XILc8Eao4rHp98yNjC+VO9i5OSQEDCRuPXpEWMXIxeHkMA6
        RolTF+6wgiR4BQQlfky+x9LFyMHBLCAvceRSNkiYWUBdYtK8RcwQ9fcZJZ7OfwdVryUxd8Y7
        JhCbRUBV4ti7s8wgNhtQfP+LG2wgNr+AosTVH48ZQWaKCkRIdJ+oBJkjItDPLDHt2hmwI5gF
        7jNJXHq3jhGkQVggQWLS1Z9Q151llGhb/AJsEqeAk8TmqZ+ZJzAKzEJy7CyEY2chOXYBI/Mq
        RsnUguLc9NxiowKjvNRyveLE3OLSvHS95PzcTYzA2N12WKt/B+PjJfGHGAU4GJV4eE9UJ0QL
        sSaWFVfmHmKU4GBWEuG1kYmPFuJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1
        tSC1CCbLxMEp1cDoJfDSduah5czWDD9dbDTbJ1+cHx87my1mmyOXYqvn5eL8yWbhdwoy9Bo2
        ft5/U3Fxat91w6PqFQYPqo2FPa/8mbrXuak89gbTuuvsk89Nb3Ly/JlnriWhvCP+xZModqZr
        C9NfLexPLUydtJrdL2jjDkGGVI2Qs79qv86NT+v+PvP15+3diu1KLMUZiYZazEXFiQCcATBS
        2QIAAA==
X-CMS-MailID: 20180801090825epcas2p13dc666cf68c6fcb9e1ae133e6417f262
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180730081238epcas5p1ee07f1c70f33018509b34f60736f4832
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
        <CGME20180730081238epcas5p1ee07f1c70f33018509b34f60736f4832@epcas5p1.samsung.com>
        <20180730081124.30698-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 07월 30일 17:11, Enric Balletbo i Serra wrote:
> Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
> on-die termination (ODT) and auto power down parameters from kernel,
> this patch adds the functionality to do this. Also, if DDR clock
> frequency is lower than the on-die termination (ODT) disable frequency
> this driver should disable the DDR ODT.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> ---
> 
> Changes in v1:
> - [RFC 3/10] Add an explanation for platform SIP calls.
> - [RFC 3/10] Change if statement for a switch.
> - [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
> 
>  drivers/devfreq/rk3399_dmc.c        | 74 ++++++++++++++++++++++++++++-
>  include/soc/rockchip/rockchip_sip.h |  1 +
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index e795ad2b3f6b..c619dc4ac620 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -18,14 +18,17 @@
>  #include <linux/devfreq.h>
>  #include <linux/devfreq-event.h>
>  #include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/rwsem.h>
>  #include <linux/suspend.h>
>  
> +#include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rockchip_sip.h>
>  
>  struct dram_timing {
> @@ -69,8 +72,11 @@ struct rk3399_dmcfreq {
>  	struct mutex lock;
>  	struct dram_timing timing;
>  	struct regulator *vdd_center;
> +	struct regmap *regmap_pmu;
>  	unsigned long rate, target_rate;
>  	unsigned long volt, target_volt;
> +	unsigned int odt_dis_freq;
> +	int odt_pd_arg0, odt_pd_arg1;
>  };
>  
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	struct dev_pm_opp *opp;
>  	unsigned long old_clk_rate = dmcfreq->rate;
>  	unsigned long target_volt, target_rate;
> +	struct arm_smccc_res res;
> +	bool odt_enable = false;
>  	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  
>  	mutex_lock(&dmcfreq->lock);
>  
> +	if (target_rate >= dmcfreq->odt_dis_freq)
> +		odt_enable = true;
> +
> +	/*
> +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> +	 * timings and to enable or disable the ODT (on-die termination)
> +	 * resistors.
> +	 */
> +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> +		      dmcfreq->odt_pd_arg1,
> +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> +		      odt_enable, 0, 0, 0, &res);
> +
>  	/*
>  	 * If frequency scaling from low to high, adjust voltage first.
>  	 * If frequency scaling from high to low, adjust frequency first.
> @@ -294,11 +315,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  {
>  	struct arm_smccc_res res;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.of_node, *node;
>  	struct rk3399_dmcfreq *data;
>  	int ret, index, size;
>  	uint32_t *timing;
>  	struct dev_pm_opp *opp;
> +	u32 ddr_type;
> +	u32 val;
>  
>  	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
>  	if (!data)
> @@ -334,6 +357,34 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Try to find the optional reference to the pmu syscon */
> +	node = of_parse_phandle(np, "rockchip,pmu", 0);
> +	if (node) {
> +		data->regmap_pmu = syscon_node_to_regmap(node);
> +		if (IS_ERR(data->regmap_pmu))
> +			return PTR_ERR(data->regmap_pmu);
> +	}
> +
> +	/* Get DDR type */
> +	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
> +
> +	/* Get the odt_dis_freq parameter in function of the DDR type */
> +	switch (ddr_type) {
> +	case RK3399_PMUGRF_DDRTYPE_DDR3:
> +		data->odt_dis_freq = data->timing.ddr3_odt_dis_freq;
> +		break;
> +	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
> +		data->odt_dis_freq = data->timing.lpddr3_odt_dis_freq;
> +		break;
> +	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
> +		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
>  	/*
>  	 * Get dram timing and pass it to arm trust firmware,
>  	 * the dram drvier in arm trust firmware will get these
> @@ -358,6 +409,27 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
>  		      0, 0, 0, 0, &res);
>  
> +	/*
> +	 * In TF-A there is a platform SIP call to set the PD (power-down)
> +	 * timings and to enable or disable the ODT (on-die termination).
> +	 * This call needs three arguments as follows:
> +	 *
> +	 * arg0:
> +	 *     bit[0-7]   : sr_idle
> +	 *     bit[8-15]  : sr_mc_gate_idle
> +	 *     bit[16-31] : standby idle
> +	 * arg1:
> +	 *     bit[0-11]  : pd_idle
> +	 *     bit[16-27] : srpd_lite_idle
> +	 * arg2:
> +	 *     bit[0]     : odt enable
> +	 */
> +	data->odt_pd_arg0 = (data->timing.sr_idle & 0xff) |
> +			    ((data->timing.sr_mc_gate_idle & 0xff) << 8) |
> +			    ((data->timing.standby_idle & 0xffff) << 16);
> +	data->odt_pd_arg1 = (data->timing.pd_idle & 0xfff) |
> +			    ((data->timing.srpd_lite_idle & 0xfff) << 16);
> +
>  	/*
>  	 * We add a devfreq driver to our parent since it has a device tree node
>  	 * with operating points.
> diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
> index 7e28092c4d3d..ad9482c56797 100644
> --- a/include/soc/rockchip/rockchip_sip.h
> +++ b/include/soc/rockchip/rockchip_sip.h
> @@ -23,5 +23,6 @@
>  #define ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE	0x05
>  #define ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ	0x06
>  #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM	0x07
> +#define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD	0x08
>  
>  #endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
