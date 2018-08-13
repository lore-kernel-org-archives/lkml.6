Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA23EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CF321545
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CF321545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeHMLvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:51:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45629 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728226AbeHMLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:51:10 -0400
X-UUID: 2199422dadca407eaaf5ab327567c021-20180813
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <owen.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1317138789; Mon, 13 Aug 2018 17:09:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 13 Aug 2018 17:09:37 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 13 Aug 2018 17:09:37 +0800
Message-ID: <1534151377.17494.46.camel@mtkswgap22>
Subject: Re: [PATCH v5 09/11] clk: mediatek: add new clkmux register API
From:   Owen Chen <owen.chen@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Date:   Mon, 13 Aug 2018 17:09:37 +0800
In-Reply-To: <1531983463.8953.235.camel@mtkswgap22>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
         <1531817552-17221-10-git-send-email-mars.cheng@mediatek.com>
         <1531983463.8953.235.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 14:57 +0800, Sean Wang wrote:
> On Tue, 2018-07-17 at 16:52 +0800, Mars Cheng wrote:
> > From: Owen Chen <owen.chen@mediatek.com>
> > 
> > MT6765 add "set/clr" register for each clkmux setting, and
> > one update register to trigger value change. It is designed
> > to prevent read-modify-write racing issue. The sw design
> > need to add a new API to handle this hw change with a new
> > mtk_clk_mux/mtk_clk_upd struct in new file "clk-mux"and
> > clk-upd".
> > 
> 
> I don't see any word mtk_clk_upd or clk-upd in the patch
> 
> and the patch needs to be split into more patches
> 

clk-upd is old description, no more clk-upd for handling update bit.

I will remove it next version.

> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > ---
> >  drivers/clk/mediatek/Makefile  |    2 +-
> >  drivers/clk/mediatek/clk-mtk.c |   41 +++++++
> >  drivers/clk/mediatek/clk-mtk.h |   85 ++++++++++++---
> >  drivers/clk/mediatek/clk-mux.c |  236 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/mediatek/clk-mux.h |   38 +++++++
> >  5 files changed, 388 insertions(+), 14 deletions(-)
> >  create mode 100644 drivers/clk/mediatek/clk-mux.c
> >  create mode 100644 drivers/clk/mediatek/clk-mux.h
> > 
> > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> > index 844b55d..b97980d 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o
> > +obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
> >  obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
> >  obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
> >  obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
> > diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> > index 9c0ae42..50becd0 100644
> > --- a/drivers/clk/mediatek/clk-mtk.c
> > +++ b/drivers/clk/mediatek/clk-mtk.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/mfd/syscon.h>
> >  
> >  #include "clk-mtk.h"
> > +#include "clk-mux.h"
> >  #include "clk-gate.h"
> >  
> >  struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
> > @@ -144,6 +145,46 @@ int mtk_clk_register_gates(struct device_node *node,
> >  	return 0;
> >  }
> >  
> > +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> > +			   int num, struct device_node *node,
> > +			   spinlock_t *lock,
> > +			   struct clk_onecell_data *clk_data)
> > +{
> > +	struct regmap *regmap;
> > +	struct clk *clk;
> > +	int i;
> > +
> > +	if (!clk_data)
> > +		return -ENOMEM;
> > +
> 
> general register function is able to handle that there is no clk_data.
> It looks like a optional, not a mandatory
> 

clk_data is reused in topcksys clk registration, because of the
registration include muxes/gates/dividers/fixed_clks, so we need to make
sure clk_data is not NULL pointer so we can use to store the clk
structure we allocated.

> > +	regmap = syscon_node_to_regmap(node);
> > +	if (IS_ERR(regmap)) {
> > +		pr_err("Cannot find regmap for %pOF: %ld\n", node,
> > +		       PTR_ERR(regmap));
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	for (i = 0; i < num; i++) {
> > +		const struct mtk_mux *mux = &muxes[i];
> > +
> > +		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[mux->id]))
> > +			continue;
> > +
> 
> it seems not necessary to check clk data every time
> 
> and always use positive check is good to read
> 

Yes, we will remove clk_data check at this point since not necessary.
the if condition check would alter next version.

> > +		clk = mtk_clk_register_mux(mux, regmap, lock);
> > +
> > +		if (IS_ERR(clk)) {
> > +			pr_err("Failed to register clk %s: %ld\n",
> > +			       mux->name, PTR_ERR(clk));
> > +			continue;
> > +		}
> > +
> > +		if (clk_data)
> > +			clk_data->clks[mux->id] = clk;
> 
> don't alter any data from input, that is a surprise for users
> 

As I mentioned on previous question, clk_data need to be alterd because
of after registration done, we need to offer clk_data as input of
of_clk_add_provider(...,clk_data)

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
> >  		void __iomem *base, spinlock_t *lock)
> >  {
> > diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> > index 1882221..61693f6 100644
> > --- a/drivers/clk/mediatek/clk-mtk.h
> > +++ b/drivers/clk/mediatek/clk-mtk.h
> > @@ -24,7 +24,9 @@
> >  
> >  #define MAX_MUX_GATE_BIT	31
> >  #define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
> > -
> > +#define INVALID_OFS		-1
> > +#define INVALID_SHFT		-1
> > +#define INVALID_WIDTH		-1
> >  #define MHZ (1000 * 1000)
> >  
> >  struct mtk_fixed_clk {
> > @@ -84,10 +86,72 @@ struct mtk_composite {
> >  	signed char num_parents;
> >  };
> >  
> > +struct mtk_mux {
> > +	int id;
> > +	const char *name;
> > +	const char * const *parent_names;
> > +	unsigned int flags;
> > +
> > +	u32 mux_ofs;
> > +	u32 set_ofs;
> > +	u32 clr_ofs;
> > +	u32 upd_ofs;
> > +
> > +	signed char mux_shift;
> > +	signed char mux_width;
> > +	signed char gate_shift;
> > +	signed char upd_shift;
> > +
> > +	const struct clk_ops *ops;
> > +
> > +	signed char num_parents;
> > +};
> > +
> 
> you have created a mtk-mux.h, why is you don't move the newly create
> struct in?
> 

Okay, I would remove mtk_mux structure and only preserve mtk_clk_mux in
clk_mux.h.

> >  /*
> >   * In case the rate change propagation to parent clocks is undesirable,
> >   * this macro allows to specify the clock flags manually.
> >   */
> > +#define CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs, _mux_set_ofs,\
> > +			_mux_clr_ofs, _shift, _width, _gate,		\
> > +			_upd_ofs, _upd, _flags, _ops) {			\
> > +		.id = _id,						\
> > +		.name = _name,						\
> > +		.mux_ofs = _mux_ofs,					\
> > +		.set_ofs = _mux_set_ofs,				\
> > +		.clr_ofs = _mux_clr_ofs,				\
> > +		.upd_ofs = _upd_ofs,					\
> > +		.mux_shift = _shift,					\
> > +		.mux_width = _width,					\
> > +		.gate_shift = _gate,					\
> > +		.upd_shift = _upd,					\
> > +		.parent_names = _parents,				\
> > +		.num_parents = ARRAY_SIZE(_parents),			\
> > +		.flags = _flags,					\
> > +		.ops = &_ops,						\
> > +	}
> > +
> > +#define MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs, _mux_set_ofs,\
> > +			_mux_clr_ofs, _shift, _width, _gate,		\
> > +			_upd_ofs, _upd, _flags)			\
> > +		CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
> > +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> > +			_gate, _upd_ofs, _upd, _flags,			\
> > +			mtk_mux_clr_set_upd_ops)
> > +
> > +#define MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs, _mux_set_ofs,	\
> > +			_mux_clr_ofs, _shift, _width, _gate,		\
> > +			_upd_ofs, _upd)				\
> > +		MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
> > +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> > +			_gate, _upd_ofs, _upd, CLK_SET_RATE_PARENT)
> > +
> > +#define MUX_UPD(_id, _name, _parents, _mux_ofs, _shift, _width, _gate,	\
> > +			_upd_ofs, _upd)				\
> > +		CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
> > +			INVALID_OFS, INVALID_OFS, _shift, _width,	\
> > +			_gate, _upd_ofs, _upd, CLK_SET_RATE_PARENT,	\
> > +			mtk_mux_upd_ops)
> > +
> >  #define MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
> >  			_gate, _flags) {				\
> >  		.id = _id,						\
> > @@ -111,18 +175,8 @@ struct mtk_composite {
> >  	MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
> >  		_gate, CLK_SET_RATE_PARENT)
> >  
> > -#define MUX(_id, _name, _parents, _reg, _shift, _width) {		\
> > -		.id = _id,						\
> > -		.name = _name,						\
> > -		.mux_reg = _reg,					\
> > -		.mux_shift = _shift,					\
> > -		.mux_width = _width,					\
> > -		.gate_shift = -1,					\
> > -		.divider_shift = -1,					\
> > -		.parent_names = _parents,				\
> > -		.num_parents = ARRAY_SIZE(_parents),			\
> > -		.flags = CLK_SET_RATE_PARENT,				\
> > -	}
> 
> As Matthias always said that, you alter the common thing that is already
> used by a lot of SoC.
> 
> You should have a dedicate patch to state why you need it, provide the
> way you propose. and use another patches for migrating old SoC, finally
> then add the patch for your own SoC.
> 
> Don't mix everything in a single patch. The patch can't become reusable
> hard to read it, even hard to backport to the other SoC picking up
> patches they are really wanting.
> 

Okay, I will restore it to original version.

> > +#define MUX(_id, _name, _parents, _reg, _shift, _width)		\
> > +	MUX_GATE(_id, _name, _parents, _reg, _shift, _width, INVALID_SHFT)
> >  
> >  #define DIV_GATE(_id, _name, _parent, _gate_reg, _gate_shift, _div_reg,	\
> >  					_div_width, _div_shift) {	\
> > @@ -138,6 +192,11 @@ struct mtk_composite {
> >  		.flags = 0,						\
> >  	}
> >  
> > +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> > +			   int num, struct device_node *node,
> > +			   spinlock_t *lock,
> > +			   struct clk_onecell_data *clk_data);
> > +
> 
> move to mtk-mux.h
> 

Again, we can observe that other(gate/divider/fixed_clk) registration
functions all gather together in clk_mtk.h, if we want to move mtk_mux
to clk_mux.h, I think we may start a new patch to move all other three
registration functions and distribute it to their own driver code such
as clk_gate.h/clk_divider.h...etc.

> >  struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
> >  		void __iomem *base, spinlock_t *lock);
> >  
> > diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> > new file mode 100644
> > index 0000000..219181b
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mux.c
> > @@ -0,0 +1,236 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Owen Chen <owen.chen@mediatek.com>
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
> > +
> > +#include "clk-mtk.h"
> > +#include "clk-mux.h"
> > +
> > +static inline struct mtk_clk_mux
> > +	*to_mtk_clk_mux(struct clk_hw *hw)
> > +{
> > +	return container_of(hw, struct mtk_clk_mux, hw);
> > +}
> > +
> > +static int mtk_mux_enable(struct clk_hw *hw)
> > +{
> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	u32 mask = BIT(mux->gate_shift);
> > +	unsigned long flags = 0;
> > +
> > +	if (mux->lock)
> > +		spin_lock_irqsave(mux->lock, flags);
> > +
> 
> we can see many functions in kernel, similar to your need, they always
> be defined as two versions. for example.
> 
> mtk_mux_enable refer to lock version
> 
> mtk_mux_enable_nolock for lock-free version
> 
> that makes less condition, more readable, and users don't care much
> about what stuff is put inside  
> 

clk.c already provides spin_lock at entrance of clk_enable/clk_disalbe
API, so the lock version seems redundant here, I would remove the lock
version and keep this API lock-free as my next modification.

> > +	regmap_update_bits(mux->regmap, mux->mux_ofs, mask, 0);
> > +
> > +	if (mux->lock)
> > +		spin_unlock_irqrestore(mux->lock, flags);
> > +	return 0;
> > +}
> > +
> > +static void mtk_mux_disable(struct clk_hw *hw)
> > +{
> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	u32 mask = BIT(mux->gate_shift);
> > +	unsigned long flags = 0;
> > +
> > +	if (mux->lock)
> > +		spin_lock_irqsave(mux->lock, flags);
> > +
> 
> ditto
> 

I would remove lock next modification.

> > +	regmap_update_bits(mux->regmap, mux->mux_ofs, mask, mask);
> > +
> > +	if (mux->lock)
> > +		spin_unlock_irqrestore(mux->lock, flags);
> > +}
> > +
> > +static int mtk_mux_enable_setclr(struct clk_hw *hw)
> > +{
> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	u32 val;
> > +	unsigned long flags = 0;
> > +
> > +	if (mux->lock)
> > +		spin_lock_irqsave(mux->lock, flags);
> > +
> 
> ditto
> 

I would remove lock next modification.

> > +	val = BIT(mux->gate_shift);
> > +	regmap_write(mux->regmap, mux->mux_clr_ofs, val);
> > +
> > +	if (mux->lock)
> > +		spin_unlock_irqrestore(mux->lock, flags);
> > +	return 0;
> > +}
> > +
> > +static void mtk_mux_disable_setclr(struct clk_hw *hw)
> > +{
> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	u32 val;
> > +	unsigned long flags = 0;
> > +
> > +	if (mux->lock)
> > +		spin_lock_irqsave(mux->lock, flags);
> > +
> 
> ditto
> 

I would remove lock next modification.

> > +	val = BIT(mux->gate_shift);
> > +	regmap_write(mux->regmap, mux->mux_set_ofs, val);
> > +
> > +	if (mux->lock)
> > +		spin_unlock_irqrestore(mux->lock, flags);
> > +}
> > +
> > +static int mtk_mux_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	u32 val = 0;
> > +
> > +	if (mux->gate_shift < 0)
> > +		return true;
> > +
> 
> return value should be bool
> 

due to the proto type of is_enabled function is defined to return
integer. I will alter the return value to 1 or 0.

> > +	regmap_read(mux->regmap, mux->mux_ofs, &val);
> > +
> > +	return (val & BIT(mux->gate_shift)) == 0;
> > +}
> > +
> > +static u8 mtk_mux_get_parent(struct clk_hw *hw)
> > +{
> 
> 
> return value should be int

Okay, I would alter it next version.

> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	int num_parents = clk_hw_get_num_parents(hw);
> > +	u32 mask = GENMASK(mux->mux_width - 1, 0);
> > +	u32 val;
> > +
> > +	regmap_read(mux->regmap, mux->mux_ofs, &val);
> > +	val = (val >> mux->mux_shift) & mask;
> > +
> > +	if (val >= num_parents)
> > +		return -EINVAL;
> > +
> > +	return val;
> > +}
> > +
> > +static int mtk_mux_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	u32 mask = GENMASK(mux->mux_width - 1, 0);
> > +	u32 val, orig;
> > +	unsigned long flags = 0;
> > +
> > +	if (mux->lock)
> > +		spin_lock_irqsave(mux->lock, flags);
> > +
> 
> use lock-free-or-not funciton
> 

I would remove lock next modification.

> > +	regmap_read(mux->regmap, mux->mux_ofs, &val);
> > +	orig = val;
> > +	val &= ~(mask << mux->mux_shift);
> > +	val |= index << mux->mux_shift;
> > +
> > +	if (val != orig) {
> > +		regmap_write(mux->regmap, mux->mux_ofs, val);
> > +
> > +		if (mux->upd_shift >= 0)
> > +			regmap_write(mux->regmap, mux->upd_ofs,
> > +				     BIT(mux->upd_shift));
> 
> 
> why not use regmap_update_bits like function ?
> 

Okay, I would alter it next version..

> > +	}
> > +
> > +	if (mux->lock)
> > +		spin_unlock_irqrestore(mux->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_mux_set_parent_setclr(struct clk_hw *hw, u8 index)
> > +{
> > +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +	u32 mask = GENMASK(mux->mux_width - 1, 0);
> > +	u32 val, orig;
> > +	unsigned long flags = 0;
> > +
> > +	if (mux->lock)
> > +		spin_lock_irqsave(mux->lock, flags);
> > +
> 
> use lock-free-or-not funciton
> 

I would remove lock next modification.

> > +	regmap_read(mux->regmap, mux->mux_ofs, &val);
> > +	orig = val;
> > +	val &= ~(mask << mux->mux_shift);
> > +	val |= index << mux->mux_shift;
> > +
> > +	if (val != orig) {
> > +		val = (mask << mux->mux_shift);
> > +		regmap_write(mux->regmap, mux->mux_clr_ofs, val);
> > +		val = (index << mux->mux_shift);
> > +		regmap_write(mux->regmap, mux->mux_set_ofs, val);
> > +
> 
> why not use regmap_update_bits like function ?

This function specified that mux use set/clr register to update, so it
would be better to use regmap_write to write the whole register instead
of regmap_update_bit.

> > +		if (mux->upd_shift >= 0)
> > +			regmap_write(mux->regmap, mux->upd_ofs,
> > +				     BIT(mux->upd_shift));
> > +	}
> > +
> > +	if (mux->lock)
> > +		spin_unlock_irqrestore(mux->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +const struct clk_ops mtk_mux_upd_ops = {
> > +	.enable = mtk_mux_enable,
> > +	.disable = mtk_mux_disable,
> > +	.is_enabled = mtk_mux_is_enabled,
> > +	.get_parent = mtk_mux_get_parent,
> > +	.set_parent = mtk_mux_set_parent,
> > +	.determine_rate = NULL,
> 
> explicitly set as NULL can be removed

Okay, I would remove it next version.

> > +};
> > +
> > +const struct clk_ops mtk_mux_clr_set_upd_ops = {
> > +	.enable = mtk_mux_enable_setclr,
> > +	.disable = mtk_mux_disable_setclr,
> > +	.is_enabled = mtk_mux_is_enabled,
> > +	.get_parent = mtk_mux_get_parent,
> > +	.set_parent = mtk_mux_set_parent_setclr,
> > +	.determine_rate = NULL,
> 
> explicitly set as NULL can be removed

Okay, I would remove it next version.

> > +};
> > +
> > +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> > +				 struct regmap *regmap,
> > +				 spinlock_t *lock)
> > +{
> > +	struct clk *clk;
> > +	struct clk_init_data init;
> > +	struct mtk_clk_mux *mtk_mux = NULL;
> > +	int ret;
> > +
> make declaration as reverse xmas tree
> 

Okay, I would alter it next version.

> > +	mtk_mux = kzalloc(sizeof(*mtk_mux), GFP_KERNEL);
> > +	if (!mtk_mux)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	init.name = mux->name;
> > +	init.flags = (mux->flags) | CLK_SET_RATE_PARENT;
> > +	init.parent_names = mux->parent_names;
> > +	init.num_parents = mux->num_parents;
> > +	init.ops = mux->ops;
> > +
> > +	mtk_mux->regmap = regmap;
> > +	mtk_mux->name = mux->name;
> > +	mtk_mux->mux_ofs = mux->mux_ofs;
> > +	mtk_mux->mux_set_ofs = mux->set_ofs;
> > +	mtk_mux->mux_clr_ofs = mux->clr_ofs;
> > +	mtk_mux->upd_ofs = mux->upd_ofs;
> > +	mtk_mux->mux_shift = mux->mux_shift;
> > +	mtk_mux->mux_width = mux->mux_width;
> > +	mtk_mux->gate_shift = mux->gate_shift;
> > +	mtk_mux->upd_shift = mux->upd_shift;
> > +
> > +	mtk_mux->lock = lock;
> > +	mtk_mux->hw.init = &init;
> > +
> > +	clk = clk_register(NULL, &mtk_mux->hw);
> > +	if (IS_ERR(clk)) {
> > +		ret = PTR_ERR(clk);
> 
> 
> ret is superfluous
> 

Okay, I would remove it next version.

> > +		goto err_out;
> > +	}
> > +
> > +	return clk;
> > +err_out:
> > +	kfree(mtk_mux);
> > +
> 
> I felt err path can be optimized
> 

Okay, I would remove it next version.

> > +	return ERR_PTR(ret);
> > +}
> > diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> > new file mode 100644
> > index 0000000..64f8e7c
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mux.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Owen Chen <owen.chen@mediatek.com>
> > + */
> > +
> > +#ifndef __DRV_CLK_MUX_H
> > +#define __DRV_CLK_MUX_H
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +struct mtk_clk_mux {
> > +	struct clk_hw hw;
> > +	struct regmap *regmap;
> > +
> > +	const char *name;
> > +
> > +	int mux_set_ofs;
> > +	int mux_clr_ofs;
> > +	int mux_ofs;
> > +	int upd_ofs;
> > +
> > +	s8 mux_shift;
> > +	s8 mux_width;
> > +	s8 gate_shift;
> > +	s8 upd_shift;
> > +
> > +	spinlock_t *lock;
> > +};
> > +
> > +extern const struct clk_ops mtk_mux_upd_ops;
> > +extern const struct clk_ops mtk_mux_clr_set_upd_ops;
> > +
> 
> 
> extern  is superfluous
> 

Okay, I would remove it next version.

> > +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> > +				 struct regmap *regmap,
> > +				 spinlock_t *lock);
> > +
> > +#endif /* __DRV_CLK_MUX_H */
> 
> 


