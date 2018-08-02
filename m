Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBB3208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JIASbRWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBB3208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeHBEYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:24:23 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54839 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeHBEYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:24:22 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180802023528epoutp0165fb08d710aaea4d6ae23b289db63666~G8KhQXr3m3055230552epoutp01G;
        Thu,  2 Aug 2018 02:35:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180802023528epoutp0165fb08d710aaea4d6ae23b289db63666~G8KhQXr3m3055230552epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533177328;
        bh=ru7S46/wS0COAZuVs1OTtLBw4tI77H8BlygT2pmtHXo=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=JIASbRWwpa+qIspTpPsIGQSoCq5fCDX4vQM1Jmwzia9wep5jak9hbF97X7n/X2YdH
         cbkBU3mjd8zf0e7BQxplZl4zz6S6y8QynQRBhxxkXX/GJoMKM0C8EImauQob8TCHMn
         LUxfV1cEQMJZYigzK2LHUor69AW9Q9yyHOMzlGY0=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180802023525epcas1p4af3db5e880f9d24d0399f0452cd080d7~G8KegEiQM1096410964epcas1p4g;
        Thu,  2 Aug 2018 02:35:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.CF.04144.DED626B5; Thu,  2 Aug 2018 11:35:25 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180802023525epcas1p4daaba4bedaba1a25be1d50af8f3c04ac~G8KeCxZw11096410964epcas1p4f;
        Thu,  2 Aug 2018 02:35:25 +0000 (GMT)
X-AuditID: b6c32a39-bb5ff70000001030-97-5b626dede35d
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 29.D8.03704.DED626B5; Thu,  2 Aug
        2018 11:35:25 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCT00CUWB706D70@mmp2.samsung.com>; Thu, 02 Aug 2018 11:35:25 +0900 (KST)
Message-id: <5B626DEC.2030701@samsung.com>
Date:   Thu, 02 Aug 2018 11:35:24 +0900
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
Subject: Re: [PATCH 4/8] devfreq: rk3399_dmc / clk: rockchip: Sync with
 vblank in the kernel for DDRfreq.
In-reply-to: <20180730081124.30698-5-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmge7b3KRog5k9eha9504yWbzavIfN
        4srX92wWa24fYrT4/+g1q8XcSbUWPzacYrbYfK6H1eJs0xt2i02Pr7FafOy5x2pxedccNovP
        vUcYLT49+M9scfGUq8XtxhVsFq17j7BbHPzwhNXi37WNLBZ3N5xltHj58QSLg6jHmnlrGD3e
        32hl95jdcJHFY8fdJYwem1Z1snls//aA1eN+93Emj81L6j3+ztrP4tG3ZRWjx/Zr85g9Pm+S
        C+CJSrXJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAXpW
        SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrFG1oaKRnaGCuZ2QEpI1jrYxMgUoSUjM2XzzK
        VjChj7Hiw9lnzA2M84q6GDk5JARMJGY232UCsYUEdjBKrF0Q18XIBWR/B7Jnn2CCKXr/bwYb
        RGIDo8ShOdPBErwCghI/Jt9j6WLk4GAWkJc4cikbJMwsoCmxdfd6doj6u4wSx6e9YYOo15I4
        Of8WO4jNIqAqcefEZrA4G1B8/4sbYDa/gKLE1R+PGUFsUYEIiZ3zv4ENEhHoZ5b43NnMBOIw
        C9xnkrgy4TxYh7BAtsSMqU+ZQWxOASeJo+1XWUGKJATesku8WH+UDeIHF4lHc/awQ9jCEq+O
        b2EHOVtCQFri0lFbiPp2RokvL5qhmicwSnw4tRkaAMYSzxZ2MUE8xyfx7msPK0Qzr0RHmxBE
        iYfE/Yd7GCF+PssocXLdTPYJjLKzkIJpFiKYZiEF0wJG5lWMYqkFxbnpqcWGBaZ6xYm5xaV5
        6XrJ+bmbGMGpWstyB+Oxcz6HGAU4GJV4eG8wJEULsSaWFVfmHmKU4GBWEuFt9gAK8aYkVlal
        FuXHF5XmpBYfYjQFhvJEZinR5HxgHskriTc0NTI2NrYwMTQzNTRUEuc18guOFhJITyxJzU5N
        LUgtgulj4uCUamDUX7s9+vkpuQd8aSFX1Q90zeO+vc33wlFz8+JdS5yDPIzV+089qVdf4NMd
        opk0NU1Fy/LSe+UQF8U51k3ycT0us34+v7dcy2e/zw+5nXZbFkUxhtzckPtMgP3P/o9ua2b2
        BD+//bnxd5/qbvOT8+w0/5sU3HSrYDGsbnzqWS/1oPCRS0xlfI8SS3FGoqEWc1FxIgDxHs7P
        6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t9jQd23uUnRBt9PCFn0njvJZPFq8x42
        iytf37NZrLl9iNHi/6PXrBZzJ9Va/Nhwitli87keVouzTW/YLTY9vsZq8bHnHqvF5V1z2Cw+
        9x5htPj04D+zxcVTrha3G1ewWbTuPcJucfDDE1aLf9c2sljc3XCW0eLlxxMsDqIea+atYfR4
        f6OV3WN2w0UWjx13lzB6bFrVyeax/dsDVo/73ceZPDYvqff4O2s/i0ffllWMHtuvzWP2+LxJ
        LoAnissmJTUnsyy1SN8ugStj88WjbAUT+hgrPpx9xtzAOK+oi5GTQ0LAROL9vxlsXYxcHEIC
        6xglzjx9xQyS4BUQlPgx+R5LFyMHB7OAvMSRS9kgYWYBdYlJ8xYxQ9TfZ5TYsXgxC0S9lsTJ
        +bfYQWwWAVWJOyc2s4HYbEDx/S9ugNn8AooSV388ZgSZKSoQIdF9ohJkjohAP7PEtGtnGEEc
        ZoH7TBKX3q1jBGkQFsiWmHr2GtS2s0DXfWsDm8Qp4CRxtP0q6wRGgVlIjp2FcOwsJMcuYGRe
        xSiZWlCcm55bbFRgmJdarlecmFtcmpeul5yfu4kRGL3bDmv17WC8vyT+EKMAB6MSD2/Dv8Ro
        IdbEsuLK3EOMEhzMSiK8zR5J0UK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1O
        TS1ILYLJMnFwSjUwmt9pDFyheHT90nmJ4XxL40vErMvObM36Ntf+QzrrIu608kmc6xoFc9/J
        qHhMUPXRWiuz7ETgm5jymxO/3ZTrVqsrZE9a9W5ThW6mTmLPFSO50tqJJpu0TqycUdLhGd2Y
        UviZk5OLyfCYkPHZvcv38/mc6Ti0n2nbH5Z19m5aM6blXdq+amWBEktxRqKhFnNRcSIA9DF3
        HtoCAAA=
X-CMS-MailID: 20180802023525epcas1p4daaba4bedaba1a25be1d50af8f3c04ac
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180730081231epcas4p3df1bafc11dc546e2b6abdc0f77b43d36
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
        <CGME20180730081231epcas4p3df1bafc11dc546e2b6abdc0f77b43d36@epcas4p3.samsung.com>
        <20180730081124.30698-5-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

I'm not sure this approach is right. Actually, I don't prefer
the definitions of specific functions for only some device drivers.
This approach connect with device drivers without subsystem.
It looks like the direct call function.

Generally, all device driver in linux kernel have to
use the provided API from subsystem as following:
[A subsystem] --------------------- [B subsystem]
       |                                  |
[A device driver]                   [B device driver]


But, this patch looks like following connection.
I think that it might make the complicated codes.
We cannot develop the all device drivers with direct call function
without standard subsystem interface.

[A subsystem] --------------------- [B subsystem]
       |                                  |
[A device driver] ----------------- [B device driver]


Regards,
Chanwoo Choi


On 2018년 07월 30일 17:11, Enric Balletbo i Serra wrote:
> From: Derek Basehore <dbasehore@chromium.org>
> 
> This changes the kernel to sync with vblank for the display in the
> kernel. This was done in Trusted Firmware-A (TF-A) before, but that locks
> up one CPU for up to one display frame (1/60 second). That's bad for
> performance and power, so this moves waiting to the kernel where the
> waiting thread can properly wait on a completion.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v1: None
> 
>  drivers/clk/rockchip/clk-ddr.c    | 142 +++++++++++++++++++++++++-----
>  drivers/clk/rockchip/clk.c        |   2 +-
>  drivers/clk/rockchip/clk.h        |   3 +-
>  drivers/devfreq/rk3399_dmc.c      | 125 ++++++++++++++++++++------
>  drivers/devfreq/rk3399_dmc_priv.h |  15 ++++
>  include/soc/rockchip/rk3399_dmc.h |  42 +++++++++
>  6 files changed, 277 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/devfreq/rk3399_dmc_priv.h
>  create mode 100644 include/soc/rockchip/rk3399_dmc.h
> 
> diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
> index e8075359366b..707be1bd8910 100644
> --- a/drivers/clk/rockchip/clk-ddr.c
> +++ b/drivers/clk/rockchip/clk-ddr.c
> @@ -17,7 +17,9 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> +#include <linux/ktime.h>
>  #include <linux/slab.h>
> +#include <soc/rockchip/rk3399_dmc.h>
>  #include <soc/rockchip/rockchip_sip.h>
>  #include "clk.h"
>  
> @@ -30,39 +32,104 @@ struct rockchip_ddrclk {
>  	int		div_shift;
>  	int		div_width;
>  	int		ddr_flag;
> -	spinlock_t	*lock;
> +	unsigned long	cached_rate;
> +	struct work_struct set_rate_work;
> +	struct mutex	lock;
> +	struct raw_notifier_head sync_chain;
>  };
>  
>  #define to_rockchip_ddrclk_hw(hw) container_of(hw, struct rockchip_ddrclk, hw)
> +#define DMC_DEFAULT_TIMEOUT_NS		NSEC_PER_SEC
> +#define DDRCLK_SET_RATE_MAX_RETRIES	3
>  
> -static int rockchip_ddrclk_sip_set_rate(struct clk_hw *hw, unsigned long drate,
> -					unsigned long prate)
> +static void rockchip_ddrclk_set_rate_func(struct work_struct *work)
>  {
> -	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
> -	unsigned long flags;
> +	struct rockchip_ddrclk *ddrclk = container_of(work,
> +			struct rockchip_ddrclk, set_rate_work);
> +	ktime_t timeout = ktime_add_ns(ktime_get(), DMC_DEFAULT_TIMEOUT_NS);
>  	struct arm_smccc_res res;
> +	int ret, i;
> +
> +	mutex_lock(&ddrclk->lock);
> +	for (i = 0; i < DDRCLK_SET_RATE_MAX_RETRIES; i++) {
> +		ret = raw_notifier_call_chain(&ddrclk->sync_chain, 0, &timeout);
> +		if (ret == NOTIFY_BAD)
> +			goto out;
> +
> +		/*
> +		 * Check the timeout with irqs disabled. This is so we don't get
> +		 * preempted after checking the timeout. That could cause things
> +		 * like garbage values for the display if we change the DDR rate
> +		 * at the wrong time.
> +		 */
> +		local_irq_disable();
> +		if (ktime_after(ktime_add_ns(ktime_get(), DMC_MIN_VBLANK_NS),
> +				timeout)) {
> +			local_irq_enable();
> +			continue;
> +		}
> +
> +		arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, ddrclk->cached_rate, 0,
> +			      ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE,
> +			      0, 0, 0, 0, &res);
> +		local_irq_enable();
> +		break;
> +	}
> +out:
> +	mutex_unlock(&ddrclk->lock);
> +}
>  
> -	spin_lock_irqsave(ddrclk->lock, flags);
> -	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, drate, 0,
> -		      ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE,
> -		      0, 0, 0, 0, &res);
> -	spin_unlock_irqrestore(ddrclk->lock, flags);
> +int rockchip_ddrclk_register_sync_nb(struct clk *clk, struct notifier_block *nb)
> +{
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +	struct rockchip_ddrclk *ddrclk;
> +	int ret;
>  
> -	return res.a0;
> +	if (!hw || !nb)
> +		return -EINVAL;
> +
> +	ddrclk = to_rockchip_ddrclk_hw(hw);
> +	if (!ddrclk)
> +		return -EINVAL;
> +
> +	mutex_lock(&ddrclk->lock);
> +	ret = raw_notifier_chain_register(&ddrclk->sync_chain, nb);
> +	mutex_unlock(&ddrclk->lock);
> +
> +	return ret;
>  }
> +EXPORT_SYMBOL_GPL(rockchip_ddrclk_register_sync_nb);
>  
> -static unsigned long
> -rockchip_ddrclk_sip_recalc_rate(struct clk_hw *hw,
> -				unsigned long parent_rate)
> +int rockchip_ddrclk_unregister_sync_nb(struct clk *clk,
> +				       struct notifier_block *nb)
>  {
> -	struct arm_smccc_res res;
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +	struct rockchip_ddrclk *ddrclk;
> +	int ret;
>  
> -	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
> -		      ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE,
> -		      0, 0, 0, 0, &res);
> +	if (!hw || !nb)
> +		return -EINVAL;
>  
> -	return res.a0;
> +	ddrclk = to_rockchip_ddrclk_hw(hw);
> +	if (!ddrclk)
> +		return -EINVAL;
> +
> +	mutex_lock(&ddrclk->lock);
> +	ret = raw_notifier_chain_unregister(&ddrclk->sync_chain, nb);
> +	mutex_unlock(&ddrclk->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_ddrclk_unregister_sync_nb);
> +
> +void rockchip_ddrclk_wait_set_rate(struct clk *clk)
> +{
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
> +
> +	flush_work(&ddrclk->set_rate_work);
>  }
> +EXPORT_SYMBOL_GPL(rockchip_ddrclk_wait_set_rate);
>  
>  static long rockchip_ddrclk_sip_round_rate(struct clk_hw *hw,
>  					   unsigned long rate,
> @@ -77,6 +144,30 @@ static long rockchip_ddrclk_sip_round_rate(struct clk_hw *hw,
>  	return res.a0;
>  }
>  
> +static int rockchip_ddrclk_sip_set_rate(struct clk_hw *hw, unsigned long drate,
> +					unsigned long prate)
> +{
> +	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
> +	long rate;
> +
> +	rate = rockchip_ddrclk_sip_round_rate(hw, drate, &prate);
> +	if (rate < 0)
> +		return rate;
> +
> +	ddrclk->cached_rate = rate;
> +	queue_work(system_highpri_wq, &ddrclk->set_rate_work);
> +	return 0;
> +}
> +
> +static unsigned long
> +rockchip_ddrclk_sip_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
> +
> +	return ddrclk->cached_rate;
> +}
> +
>  static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
>  {
>  	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
> @@ -105,12 +196,12 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
>  					 u8 num_parents, int mux_offset,
>  					 int mux_shift, int mux_width,
>  					 int div_shift, int div_width,
> -					 int ddr_flag, void __iomem *reg_base,
> -					 spinlock_t *lock)
> +					 int ddr_flag, void __iomem *reg_base)
>  {
>  	struct rockchip_ddrclk *ddrclk;
>  	struct clk_init_data init;
>  	struct clk *clk;
> +	struct arm_smccc_res res;
>  
>  	ddrclk = kzalloc(sizeof(*ddrclk), GFP_KERNEL);
>  	if (!ddrclk)
> @@ -134,7 +225,6 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
>  	}
>  
>  	ddrclk->reg_base = reg_base;
> -	ddrclk->lock = lock;
>  	ddrclk->hw.init = &init;
>  	ddrclk->mux_offset = mux_offset;
>  	ddrclk->mux_shift = mux_shift;
> @@ -142,6 +232,14 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
>  	ddrclk->div_shift = div_shift;
>  	ddrclk->div_width = div_width;
>  	ddrclk->ddr_flag = ddr_flag;
> +	mutex_init(&ddrclk->lock);
> +	INIT_WORK(&ddrclk->set_rate_work, rockchip_ddrclk_set_rate_func);
> +	RAW_INIT_NOTIFIER_HEAD(&ddrclk->sync_chain);
> +
> +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
> +		      ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE,
> +		      0, 0, 0, 0, &res);
> +	ddrclk->cached_rate = res.a0;
>  
>  	clk = clk_register(NULL, &ddrclk->hw);
>  	if (IS_ERR(clk))
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 326b3fa44f5d..1b7775aff191 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -541,7 +541,7 @@ void __init rockchip_clk_register_branches(
>  				list->muxdiv_offset, list->mux_shift,
>  				list->mux_width, list->div_shift,
>  				list->div_width, list->div_flags,
> -				ctx->reg_base, &ctx->lock);
> +				ctx->reg_base);
>  			break;
>  		}
>  
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index ef601dded32c..5e4ce49ef337 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -326,8 +326,7 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
>  					 u8 num_parents, int mux_offset,
>  					 int mux_shift, int mux_width,
>  					 int div_shift, int div_width,
> -					 int ddr_flags, void __iomem *reg_base,
> -					 spinlock_t *lock);
> +					 int ddr_flags, void __iomem *reg_base);
>  
>  #define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
>  
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index c619dc4ac620..b4ac9ee605be 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -28,9 +28,12 @@
>  #include <linux/rwsem.h>
>  #include <linux/suspend.h>
>  
> +#include <soc/rockchip/rk3399_dmc.h>
>  #include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rockchip_sip.h>
>  
> +#include "rk3399_dmc_priv.h"
> +
>  struct dram_timing {
>  	unsigned int ddr3_speed_bin;
>  	unsigned int pd_idle;
> @@ -70,6 +73,7 @@ struct rk3399_dmcfreq {
>  	struct clk *dmc_clk;
>  	struct devfreq_event_dev *edev;
>  	struct mutex lock;
> +	struct mutex en_lock;
>  	struct dram_timing timing;
>  	struct regulator *vdd_center;
>  	struct regmap *regmap_pmu;
> @@ -77,6 +81,8 @@ struct rk3399_dmcfreq {
>  	unsigned long volt, target_volt;
>  	unsigned int odt_dis_freq;
>  	int odt_pd_arg0, odt_pd_arg1;
> +	int num_sync_nb;
> +	int disable_count;
>  };
>  
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -139,6 +145,13 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Setting the dpll is asynchronous since clk_set_rate grabs a global
> +	 * common clk lock and set_rate for the dpll takes up to one display
> +	 * frame to complete. We still need to wait for the set_rate to complete
> +	 * here, though, before we change voltage.
> +	 */
> +	rockchip_ddrclk_wait_set_rate(dmcfreq->dmc_clk);
>  	/*
>  	 * Check the dpll rate,
>  	 * There only two result we will get,
> @@ -205,40 +218,15 @@ static struct devfreq_dev_profile rk3399_devfreq_dmc_profile = {
>  static __maybe_unused int rk3399_dmcfreq_suspend(struct device *dev)
>  {
>  	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
> -	int ret = 0;
> -
> -	ret = devfreq_event_disable_edev(dmcfreq->edev);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to disable the devfreq-event devices\n");
> -		return ret;
> -	}
>  
> -	ret = devfreq_suspend_device(dmcfreq->devfreq);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to suspend the devfreq devices\n");
> -		return ret;
> -	}
> -
> -	return 0;
> +	return rockchip_dmcfreq_block(dmcfreq->devfreq);
>  }
>  
>  static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
>  {
>  	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
> -	int ret = 0;
>  
> -	ret = devfreq_event_enable_edev(dmcfreq->edev);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to enable the devfreq-event devices\n");
> -		return ret;
> -	}
> -
> -	ret = devfreq_resume_device(dmcfreq->devfreq);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to resume the devfreq devices\n");
> -		return ret;
> -	}
> -	return ret;
> +	return rockchip_dmcfreq_unblock(dmcfreq->devfreq);
>  }
>  
>  static SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
> @@ -311,6 +299,88 @@ static int of_get_ddr_timings(struct dram_timing *timing,
>  	return ret;
>  }
>  
> +int rockchip_dmcfreq_register_clk_sync_nb(struct devfreq *devfreq,
> +					struct notifier_block *nb)
> +{
> +	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
> +	int ret;
> +
> +	mutex_lock(&dmcfreq->en_lock);
> +	/*
> +	 * We have a short amount of time (~1ms or less typically) to run
> +	 * dmcfreq after we sync with the notifier, so syncing with more than
> +	 * one notifier is not generally possible. Thus, if more than one sync
> +	 * notifier is registered, disable dmcfreq.
> +	 */
> +	if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
> +		devfreq_suspend_device(devfreq);
> +
> +	ret = rockchip_ddrclk_register_sync_nb(dmcfreq->dmc_clk, nb);
> +	if (ret == 0)
> +		dmcfreq->num_sync_nb++;
> +	else if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
> +		devfreq_resume_device(devfreq);
> +
> +	mutex_unlock(&dmcfreq->en_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_dmcfreq_register_clk_sync_nb);
> +
> +int rockchip_dmcfreq_unregister_clk_sync_nb(struct devfreq *devfreq,
> +					  struct notifier_block *nb)
> +{
> +	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
> +	int ret;
> +
> +	mutex_lock(&dmcfreq->en_lock);
> +	ret = rockchip_ddrclk_unregister_sync_nb(dmcfreq->dmc_clk, nb);
> +	if (ret == 0) {
> +		dmcfreq->num_sync_nb--;
> +		if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
> +			devfreq_resume_device(devfreq);
> +	}
> +
> +	mutex_unlock(&dmcfreq->en_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_dmcfreq_unregister_clk_sync_nb);
> +
> +int rockchip_dmcfreq_block(struct devfreq *devfreq)
> +{
> +	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
> +	int ret = 0;
> +
> +	mutex_lock(&dmcfreq->en_lock);
> +	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count <= 0)
> +		ret = devfreq_suspend_device(devfreq);
> +
> +	if (!ret)
> +		dmcfreq->disable_count++;
> +	mutex_unlock(&dmcfreq->en_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_dmcfreq_block);
> +
> +int rockchip_dmcfreq_unblock(struct devfreq *devfreq)
> +{
> +	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
> +	int ret = 0;
> +
> +	mutex_lock(&dmcfreq->en_lock);
> +	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count == 1)
> +		ret = devfreq_resume_device(devfreq);
> +
> +	if (!ret)
> +		dmcfreq->disable_count--;
> +	WARN_ON(dmcfreq->disable_count < 0);
> +	mutex_unlock(&dmcfreq->en_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_dmcfreq_unblock);
> +
>  static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  {
>  	struct arm_smccc_res res;
> @@ -328,6 +398,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mutex_init(&data->lock);
> +	mutex_init(&data->en_lock);
>  
>  	data->vdd_center = devm_regulator_get(dev, "center");
>  	if (IS_ERR(data->vdd_center)) {
> diff --git a/drivers/devfreq/rk3399_dmc_priv.h b/drivers/devfreq/rk3399_dmc_priv.h
> new file mode 100644
> index 000000000000..8ac0340a4990
> --- /dev/null
> +++ b/drivers/devfreq/rk3399_dmc_priv.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2017-2018 Google, Inc.
> + * Author: Derek Basehore <dbasehore@chromium.org>
> + */
> +
> +#ifndef __RK3399_DMC_PRIV_H
> +#define __RK3399_DMC_PRIV_H
> +
> +void rockchip_ddrclk_wait_set_rate(struct clk *clk);
> +int rockchip_ddrclk_register_sync_nb(struct clk *clk,
> +				     struct notifier_block *nb);
> +int rockchip_ddrclk_unregister_sync_nb(struct clk *clk,
> +				       struct notifier_block *nb);
> +#endif
> diff --git a/include/soc/rockchip/rk3399_dmc.h b/include/soc/rockchip/rk3399_dmc.h
> new file mode 100644
> index 000000000000..8b28563710d1
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_dmc.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
> + * Author: Lin Huang <hl@rock-chips.com>
> + */
> +
> +#ifndef __SOC_RK3399_DMC_H
> +#define __SOC_RK3399_DMC_H
> +
> +#include <linux/devfreq.h>
> +#include <linux/notifier.h>
> +
> +#define DMC_MIN_SET_RATE_NS	(250 * NSEC_PER_USEC)
> +#define DMC_MIN_VBLANK_NS	(DMC_MIN_SET_RATE_NS + 50 * NSEC_PER_USEC)
> +
> +#if IS_ENABLED(CONFIG_ARM_RK3399_DMC_DEVFREQ)
> +int rockchip_dmcfreq_register_clk_sync_nb(struct devfreq *devfreq,
> +					  struct notifier_block *nb);
> +
> +int rockchip_dmcfreq_unregister_clk_sync_nb(struct devfreq *devfreq,
> +					    struct notifier_block *nb);
> +
> +int rockchip_dmcfreq_block(struct devfreq *devfreq);
> +
> +int rockchip_dmcfreq_unblock(struct devfreq *devfreq);
> +#else
> +static inline int
> +rockchip_dmcfreq_register_clk_sync_nb(struct devfreq *devfreq,
> +				      struct notifier_block *nb)
> +{ return 0; }
> +
> +static inline int
> +rockchip_dmcfreq_unregister_clk_sync_nb(struct devfreq *devfreq,
> +					struct notifier_block *nb)
> +{ return 0; }
> +
> +static inline int rockchip_dmcfreq_block(struct devfreq *devfreq) { return 0; }
> +
> +static inline int rockchip_dmcfreq_unblock(struct devfreq *devfreq)
> +{ return 0; }
> +#endif
> +#endif
> 
