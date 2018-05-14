Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeENWUS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:20:18 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54475 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeENWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:20:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180514222010epoutp045469138df28645258ed97f7afe7d65bf~uouD59hFS2384723847epoutp04D
X-AuditID: b6c32a47-bdfff70000001011-cc-5afa0b95b6fe
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFA0B94.4000100@samsung.com>
Date: Tue, 15 May 2018 07:20:04 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Lin Huang <hl@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 03/10] devfreq: rk3399_dmc: Pass ODT and auto power
 down parameters to TF-A.
In-reply-to: <20180514211610.26618-4-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmme5U7l9RBtMfyFr0njvJZPFq8x42
        iytf37NZrLl9iNHi/6PXrBZzJ9Va/Nhwitli87keVouzTW/YLTY9vsZq8bHnHqvF5V1z2Cw+
        9x5htPj04D+zxcVTrha3G1ewWbTuPcJu8e/aRhaLuxvOMlq8/HiCxUHEY828NYwe72+0snvM
        brjI4rHj7hJGj02rOtk8tn97wOpxv/s4k8fmJfUef2ftZ/Ho27KK0WP7tXnMHp83yQXwRKXa
        ZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gD9qaRQlphT
        ChQKSCwuVtK3synKLy1JVcjILy6xVYo2NDTSMzQw1zMyAtLGsVZGpkAlCakZb7c9YypYZlhx
        5NYKpgbGO+pdjJwcEgImEu+b3rB0MXJxCAnsYJSY0jGHGcL5zijR82EVWxcjB1jV1lX5EPEN
        jBI/v6xnBOnmFRCU+DH5HgtIDbOAvMSRS9kgYWYBTYmtu9ezQ9TfZZRo/32SCaJeS2L+h4ls
        IDaLgKrEno9/weawAcX3v7gBFucXUJS4+uMxWFxUIEJi5/xvYINEBPqZJT53NjOBOMwCJ5kk
        js+bxw6yWVggTaJ/iySIySngJHG4XQGkRELgHrvEwvsvWCHedJGYuOMRM4QtLPHq+BZ2CFta
        4tmqjYwQDe1Al+6dxwzhTGGUOHf9HhNElbHEs4VdTBC/8Ul0HP7LDgkWXomONiGIEg+Jsw/b
        ocodJV533oCG6VlGiY+HVzBNYJSbhRRisxAhNgspxBYwMq9iFEstKM5NTy02KjDWK07MLS7N
        S9dLzs/dxAhO2lruOxi3nfM5xCjAwajEw5sw7WeUEGtiWXFl7iFGCQ5mJRHe3UZAId6UxMqq
        1KL8+KLSnNTiQ4ymwACfyCwlmpwPzCh5JfGGpkbGxsYWpuaWxgaWSuK8a5S+RgkJpCeWpGan
        phakFsH0MXFwSjUwNlz12ns+3lc2pJVXX2KbnHTtlI0Km/Rzlu7kZP6XP8Nb9cOBjuVNO4UL
        mfwnMhm7r1kz4WlLjkh14bSklactipUyfxv/SS4sX/785hOx40l//r7bNHuBZ62nVc2UF/4c
        Z2/xPjFlbphwQOnHqjgWuZqqqTNn9DVwP1htMD/A/Znwx6O3vEKilViKMxINtZiLihMBstmo
        3vADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t9jQd0p3L+iDL5+NLHoPXeSyeLV5j1s
        Fle+vmezWHP7EKPF/0evWS3mTqq1+LHhFLPF5nM9rBZnm96wW2x6fI3V4mPPPVaLy7vmsFl8
        7j3CaPHpwX9mi4unXC1uN65gs2jde4Td4t+1jSwWdzecZbR4+fEEi4OIx5p5axg93t9oZfeY
        3XCRxWPH3SWMHptWdbJ5bP/2gNXjfvdxJo/NS+o9/s7az+LRt2UVo8f2a/OYPT5vkgvgieKy
        SUnNySxLLdK3S+DKeLvtGVPBMsOKI7dWMDUw3lHvYuTgkBAwkdi6Kr+LkYtDSGAdo8TpA8sZ
        uxg5OXgFBCV+TL7HAlLDLCAvceRSNkiYWUBdYtK8RcwQ9fcZJf5uvsMMUa8lMf/DRDYQm0VA
        VWLPx79gc9iA4vtf3ACL8wsoSlz98ZgRZKaoQIRE94lKkDkiAv3MEtOunWEEcZgFTjJJrOg8
        zgpSJCyQJtG/RRJi2VlGiTnXvrCDxDkFnCQOtytMYBSYheTUWQinzkJy6gJG5lWMkqkFxbnp
        ucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIGxuu2wVv8OxsdL4g8xCnAwKvHwJkz7GSXEmlhWXJl7
        iFGCg1lJhHe3EVCINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMH
        p1QDo4nl08hJCWsFbdO+G5i9F9V2jfsmXMTkt0A3uLWiXjc7cDHz8rRL59I5i2dvLpnQevbx
        niYFq43t5XIWLxv/cMS/0FC6X+P95e2r2YoHBW7c/Fp/3fSxovOdY58/yv96esJtZqSkz6kz
        X+bdmd4gWLy6lEH72cL3Cz+0tDc+SdDosHzP8dkpQYmlOCPRUIu5qDgRAGbATOrRAgAA
X-CMS-MailID: 20180514222004epcas2p4504f1427aa35b0a2fbbc7019d62406bd
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180514211840epcas3p41708e430bc22d7e61e8b894b12a083f9
X-RootMTR: 20180514211840epcas3p41708e430bc22d7e61e8b894b12a083f9
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
        <CGME20180514211840epcas3p41708e430bc22d7e61e8b894b12a083f9@epcas3p4.samsung.com>
        <20180514211610.26618-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 15일 06:16, Enric Balletbo i Serra wrote:
> Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
> on-die termination (ODT) and auto power down parameters from kernel,
> this patch adds the functionality to do this. Also, if DDR clock
> frequency is lower than the on-die termination (ODT) disable frequency
> this driver should disable the DDR ODT.

I have a question.
'disable frequency' is the same meaning of 'disable the DDR ODT'?

> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/rk3399_dmc.c        | 50 ++++++++++++++++++++++++++++-
>  include/soc/rockchip/rockchip_sip.h |  1 +
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index d5c03e5abe13..cc1bbca3fb15 100644
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
> +	int dram_flag;
>  	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> @@ -95,6 +103,15 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  
>  	mutex_lock(&dmcfreq->lock);
>  
> +	dram_flag = 0;

Also, if dram_flag is 0, it mean that disable ODT frequency?
If it's right, you better to define the precise variables as following
instead of just integer(0 or 1).
For example,
- ROCKCHIP_SIP_DRAM_FREQ_ENABLE
- ROCKCHIP_SIP_DRAM_FREQ_DISABLE

> +	if (target_rate >= dmcfreq->odt_dis_freq)
> +		dram_flag = 1;
> +
> +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> +		      dmcfreq->odt_pd_arg1,
> +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> +		      dram_flag, 0, 0, 0, &res);
> +

This operation is special for only rk3399_dmc. It is difficult
to understand what to do. I recommend you better to add the detailed comment
with code.

>  	/*
>  	 * If frequency scaling from low to high, adjust voltage first.
>  	 * If frequency scaling from high to low, adjust frequency first.
> @@ -294,11 +311,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
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
> @@ -334,6 +353,29 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
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
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_DDR3)
> +		data->odt_dis_freq = data->timing.ddr3_odt_dis_freq;
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
> +		data->odt_dis_freq = data->timing.lpddr3_odt_dis_freq;
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
> +		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
> +	else
> +		return -EINVAL;
> +

how about using 'switch' statement?

>  	/*
>  	 * Get dram timing and pass it to arm trust firmware,
>  	 * the dram drvier in arm trust firmware will get these
> @@ -358,6 +400,12 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
>  		      0, 0, 0, 0, &res);
>  
> +	data->odt_pd_arg0 = (data->timing.sr_idle & 0xff) |
> +			    ((data->timing.sr_mc_gate_idle & 0xff) << 8) |
> +			    ((data->timing.standby_idle & 0xffff) << 16);
> +	data->odt_pd_arg1 = (data->timing.pd_idle & 0xfff) |
> +			    ((data->timing.srpd_lite_idle & 0xfff) << 16);
> +

odt_pd_arg0 and odt_pd_arg1 might be used for disabling/enabling the ODT frequency.
As I commented, it depend on only rk3399_dmc. You better to add detailed comment.

And I prefer to define the XXX_SHIFT/XXX_MASK definition instead of
using 8/16/0xff/0xffff for the readability.

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
