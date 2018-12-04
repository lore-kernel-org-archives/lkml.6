Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B4C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE202082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE202082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeLDI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:26:23 -0500
Received: from mx.socionext.com ([202.248.49.38]:5447 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbeLDI0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:26:22 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Dec 2018 17:26:18 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id BE13F180B67;
        Tue,  4 Dec 2018 17:26:18 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 4 Dec 2018 17:26:18 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 42A0640394;
        Tue,  4 Dec 2018 17:26:18 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 19EBB120455;
        Tue,  4 Dec 2018 17:26:18 +0900 (JST)
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
Message-ID: <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
Date:   Tue, 4 Dec 2018 17:26:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2018/11/30 17:31, Stephen Boyd wrote:
> Quoting Sugaya Taichi (2018-11-18 17:01:12)
>> Add Milbeaut M10V clock ( including PLL ) control.
> 
> Please give some more details here.

OK, add more description.

> 
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   drivers/clk/Makefile   |   1 +
>>   drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
> 
> And this is different from Uniphier? Maybe we need a socionext
> directory under drivers/clk/.

Yes, M10V is a one of the Milbeaut series ( not Uniphier ).
Anyway, I will talk to Uniphier team about creating a socionext directory.

> 
>>   2 files changed, 672 insertions(+)
>>   create mode 100644 drivers/clk/clk-m10v.c
>>
>> diff --git a/drivers/clk/clk-m10v.c b/drivers/clk/clk-m10v.c
>> new file mode 100644
>> index 0000000..aa92a69
>> --- /dev/null
>> +++ b/drivers/clk/clk-m10v.c
>> @@ -0,0 +1,671 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Socionext Inc.
>> + * Copyright (C) 2016 Linaro Ltd.
>> + *
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
> 
> Is this include used?

I will check and drop if they are not used.

> 
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of.h>
>> +#include <linux/spinlock.h>
>> +
>> +#define CLKSEL1                0x0
>> +#define CLKSEL(n)      (((n) - 1) * 4 + CLKSEL1)
>> +
>> +#define PLLCNT1                0x30
>> +#define PLLCNT(n)      (((n) - 1) * 4 + PLLCNT1)
>> +
>> +#define CLKSTOP1       0x54
>> +#define CLKSTOP(n)     (((n) - 1) * 4 + CLKSTOP1)
>> +
>> +#define CRSWR          0x8c
>> +#define CRRRS          0x90
>> +#define CRRSM          0x94
>> +
>> +#define to_m10v_mux(_hw)       container_of(_hw, struct m10v_mux, hw)
>> +#define to_m10v_gate(_hw)      container_of(_hw, struct m10v_gate, hw)
>> +#define to_m10v_div(_hw)       container_of(_hw, struct m10v_div, hw)
>> +#define to_m10v_pll(_hw)       container_of(_hw, struct m10v_pll, hw)
>> +
>> +static void __iomem *clk_base;
>> +static struct device_node *np_top;
>> +static DEFINE_SPINLOCK(crglock);
> 
> Please make more specific names for these global variables by prefixing
> with m10v_. Also consider getting rid of the iomem and np_top globals
> entirely and associate those with clks differently.

I got it.

> 
>> +
>> +static __init void __iomem *m10v_clk_iomap(void)
>> +{
>> +       if (clk_base)
>> +               return clk_base;
>> +
>> +       np_top = of_find_compatible_node(NULL, NULL,
>> +                       "socionext,milbeaut-m10v-clk-regs");
>> +       if (!np_top) {
>> +               pr_err("%s: CLK iomap failed!\n", __func__);
> 
> We haven't iomapped yet though.

Yes.

> 
>> +               return NULL;
>> +       }
>> +
>> +       clk_base = of_iomap(np_top, 0);
>> +       of_node_put(np_top);
> 
> Would be nicer to use platform_device APIs instead of OF ones.

OK, use platform_device APIs.

> 
>> +
>> +       return clk_base;
>> +}
>> +
>> +struct m10v_mux {
>> +       struct clk_hw hw;
>> +       const char *cname;
>> +       u32 parent;
>> +};
>> +
>> +static u8 m10v_mux_get_parent(struct clk_hw *hw)
>> +{
>> +       struct m10v_mux *mcm = to_m10v_mux(hw);
>> +       struct clk_hw *parent;
>> +       int i;
>> +
>> +       i = clk_hw_get_num_parents(hw);
>> +       while (i--) {
>> +               parent = clk_hw_get_parent_by_index(hw, i);
>> +               if (clk_hw_get_rate(parent))
>> +                       break;
>> +       }
>> +
>> +       if (i < 0) {
>> +               pr_info("%s:%s no parent?!\n",
>> +                       __func__, mcm->cname);
>> +               i = 0;
>> +       }
>> +
>> +       return i;
>> +}
>> +
>> +static int m10v_mux_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +       struct m10v_mux *mcm = to_m10v_mux(hw);
>> +
>> +       mcm->parent = index;
>> +       return 0;
>> +}
>> +
>> +static const struct clk_ops m10v_mux_ops = {
>> +       .get_parent = m10v_mux_get_parent,
>> +       .set_parent = m10v_mux_set_parent,
>> +       .determine_rate = __clk_mux_determine_rate,
>> +};
>> +
>> +void __init m10v_clk_mux_setup(struct device_node *node)
>> +{
>> +       const char *clk_name = node->name;
>> +       struct clk_init_data init;
>> +       const char **parent_names;
>> +       struct m10v_mux *mcm;
>> +       struct clk *clk;
>> +       int i, parents;
>> +
>> +       if (!m10v_clk_iomap())
>> +               return;
>> +
>> +       of_property_read_string(node, "clock-output-names", &clk_name);
>> +
>> +       parents = of_clk_get_parent_count(node);
>> +       if (parents < 2) {
>> +               pr_err("%s: not a mux\n", clk_name);
> 
> How is this possible?

When the node has more than 1 clks...
Or I am misunderstanding your question?

> 
>> +               return;
>> +       }
>> +
>> +       parent_names = kzalloc((sizeof(char *) * parents), GFP_KERNEL);
>> +       if (!parent_names)
>> +               return;
>> +
>> +       for (i = 0; i < parents; i++)
>> +               parent_names[i] = of_clk_get_parent_name(node, i);
> 
> This is of_clk_parent_fill().

OK, use it instead.

> 
>> +
>> +       mcm = kzalloc(sizeof(*mcm), GFP_KERNEL);
>> +       if (!mcm)
>> +               goto err_mcm;
>> +
>> +       init.name = clk_name;
>> +       init.ops = &m10v_mux_ops;
>> +       init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
> 
> Please don't use CLK_IS_BASIC unless you need it.

OK, confirm it.

> 
>> +       init.num_parents = parents;
>> +       init.parent_names = parent_names;
>> +
>> +       mcm->cname = clk_name;
>> +       mcm->parent = 0;
>> +       mcm->hw.init = &init;
>> +
>> +       clk = clk_register(NULL, &mcm->hw);
>> +       if (IS_ERR(clk))
>> +               goto err_clk;
>> +
>> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +       return;
>> +
>> +err_clk:
>> +       kfree(mcm);
>> +err_mcm:
>> +       kfree(parent_names);
>> +}
>> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
>> +                       m10v_clk_mux_setup);
> 
> Any chance you can use a platform driver?

OK. try to use platform driver.

> 
>> +
>> +struct m10v_pll {
>> +       struct clk_hw hw;
>> +       const char *cname;
>> +       const struct clk_ops ops;
>> +       u32 offset;
>> +       u32 div, mult;
>> +       bool ro;
>> +};
>> +
>> +#define ST     1
>> +#define SEL    2
>> +
>> +static void _mpg_enable(struct clk_hw *hw, unsigned int enable)
>> +{
>> +       struct m10v_pll *mpg = to_m10v_pll(hw);
>> +       unsigned long flags;
>> +       u32 val;
>> +
>> +       if (mpg->ro) {
>> +               pr_debug("%s:%d %s: read-only\n",
>> +                        __func__, __LINE__, mpg->cname);
>> +               return;
>> +       }
>> +
>> +       spin_lock_irqsave(&crglock, flags);
>> +
>> +       val = readl(clk_base + PLLCNT(SEL));
>> +       if (enable)
>> +               val |= BIT(mpg->offset);
>> +       else
>> +               val &= ~BIT(mpg->offset);
>> +       writel(val, clk_base + PLLCNT(SEL));
>> +
>> +       spin_unlock_irqrestore(&crglock, flags);
>> +}
>> +
>> +static int mpg_enable(struct clk_hw *hw)
>> +{
>> +       _mpg_enable(hw, 1);
>> +       return 0;
>> +}
>> +
>> +static void mpg_disable(struct clk_hw *hw)
>> +{
>> +       _mpg_enable(hw, 0);
>> +}
>> +
>> +static int mpg_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct m10v_pll *mpg = to_m10v_pll(hw);
>> +
>> +       return readl(clk_base + PLLCNT(SEL)) & (1 << mpg->offset);
>> +}
>> +
>> +static void _mpg_prepare(struct clk_hw *hw, unsigned int on)
>> +{
>> +       struct m10v_pll *mpg = to_m10v_pll(hw);
>> +       unsigned long flags;
>> +       u32 val;
>> +
>> +       if (mpg->ro) {
> 
> Should have different RO ops for read-only clks.

I got it.

> 
>> +               pr_debug("%s:%d %s: read-only\n",
>> +                        __func__, __LINE__, mpg->cname);
>> +               return;
>> +       }
>> +
>> +       val = readl(clk_base + PLLCNT(ST));
>> +       if (!on == !(val & BIT(mpg->offset)))
>> +               return;
>> +
>> +       /* disable */
> 
> Please remove obvious comments.

Oops, OK remove.

> 
>> +       mpg_disable(hw);
>> +
>> +       spin_lock_irqsave(&crglock, flags);
>> +
>> +       val = readl(clk_base + PLLCNT(ST));
>> +       if (on)
>> +               val |= BIT(mpg->offset);
>> +       else
>> +               val &= ~BIT(mpg->offset);
>> +       writel(val, clk_base + PLLCNT(ST));
>> +
>> +       spin_unlock_irqrestore(&crglock, flags);
>> +
>> +       udelay(on ? 200 : 10);
>> +}
>> +
>> +static int mpg_prepare(struct clk_hw *hw)
>> +{
>> +       _mpg_prepare(hw, 1);
>> +       return 0;
>> +}
>> +
>> +static void mpg_unprepare(struct clk_hw *hw)
>> +{
>> +       _mpg_prepare(hw, 0);
>> +}
>> +
>> +static int mpg_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                               unsigned long prate)
>> +{
> 
> Why is this implemented then?

This is not necessary maybe. so consider whether getting rid of it.

> 
>> +       return 0;
>> +}
>> +
>> +static unsigned long mpg_recalc_rate(struct clk_hw *hw,
>> +               unsigned long prate)
>> +{
>> +       struct m10v_pll *mpg = to_m10v_pll(hw);
>> +       unsigned long long rate = prate;
>> +
>> +       if (mpg_is_enabled(hw)) {
>> +               rate = (unsigned long long)prate * mpg->mult;
>> +               do_div(rate, mpg->div);
>> +       }
>> +
>> +       return (unsigned long)rate;
>> +}
>> +
>> +static long mpg_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                               unsigned long *prate)
>> +{
>> +       struct m10v_pll *mpg = to_m10v_pll(hw);
>> +       unsigned long long temp_rate = (unsigned long long)*prate * mpg->mult;
>> +
>> +       if (mpg->ro)
>> +               return mpg_recalc_rate(hw, *prate);
>> +
>> +       return do_div(temp_rate, mpg->div);
> 
> There shouldn't be round_rate implemented at all if the device is
> 'read-only' or can't change frequency because set_rate op is empty.

I understand. I will describe correctly.

> 
>> +}
>> +
> [..]
>> +
>> +static void mdc_set_div(struct m10v_div *mdc, u32 div)
>> +{
>> +       u32 off, shift, val;
>> +
>> +       off = mdc->offset / 32 * 4;
>> +       shift = mdc->offset % 32;
>> +
>> +       val = readl(clk_base + CLKSEL1 + off);
>> +       val &= ~(mdc->mask << shift);
>> +       val |= (div << shift);
>> +       writel(val, clk_base + CLKSEL1 + off);
>> +
>> +       if (mdc->waitdchreq) {
>> +               unsigned int count = 250;
>> +
>> +               writel(1, clk_base + CLKSEL(11));
>> +
>> +               do {
>> +                       udelay(1);
>> +               } while (--count && readl(clk_base + CLKSEL(11)) & 1);
> 
> Use readl_poll_timeout()?

OK. use it instead.

> 
>> +
>> +               if (!count)
>> +                       pr_err("%s:%s CLK(%d) couldn't stabilize\n",
>> +                               __func__, mdc->cname, mdc->offset);
>> +       }
>> +}
>> +
> [...]
>> +
>> +void __init m10v_clk_gate_setup(struct device_node *node)
>> +{
>> +       const char *clk_name = node->name;
>> +       struct clk_init_data init;
>> +       const char *parent_name;
>> +       struct m10v_gate *mgc;
>> +       struct clk *clk;
>> +       u32 offset;
>> +       int ret;
>> +
>> +       if (!m10v_clk_iomap())
>> +               return;
>> +
>> +       of_property_read_string(node, "clock-output-names", &clk_name);
>> +
>> +       ret = of_property_read_u32(node, "offset", &offset);
>> +       if (ret) {
>> +               pr_err("%s: missing 'offset' property\n", clk_name);
>> +               return;
>> +       }
>> +
>> +       parent_name = of_clk_get_parent_name(node, 0);
>> +
>> +       mgc = kzalloc(sizeof(*mgc), GFP_KERNEL);
>> +       if (!mgc)
>> +               return;
>> +
>> +       init.name = clk_name;
>> +       init.ops = &m10v_gate_ops;
>> +       init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
>> +       init.parent_names = &parent_name;
>> +       init.num_parents = 1;
>> +
>> +       mgc->cname = clk_name;
>> +       mgc->offset = offset;
>> +       mgc->hw.init = &init;
>> +       if (of_get_property(node, "read-only", NULL))
>> +               mgc->ro = true;
>> +
>> +       clk = clk_register(NULL, &mgc->hw);
> 
> Please use clk_hw based registration and provider APIs.

I got it. I try to describe with referring other drivers.

> 
>> +       if (IS_ERR(clk))
>> +               kfree(mgc);
>> +       else
>> +               of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +}
>> +CLK_OF_DECLARE(m10v_clk_gate, "socionext,milbeaut-m10v-clk-gate",
>> +               m10v_clk_gate_setup);
>> -- 
> 
> I suspect this driver will significantly change so I'm not reviewing
> any further until it's sent again.

I understand. I study and try to renew the driver.


> 

