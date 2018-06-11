Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eQFMOvJzHlu2DwAAmS7hNA
	; Mon, 11 Jun 2018 13:06:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CAF40607A4; Mon, 11 Jun 2018 13:06:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbmfaiF/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BEF9260385;
	Mon, 11 Jun 2018 13:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEF9260385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeFKNGz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:06:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34822 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:06:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so16452064wme.0;
        Mon, 11 Jun 2018 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03DKykj/oEcr1c9RQZ6s7ebk3XvGCmrVJcf+KLq+FbM=;
        b=EbmfaiF/0XfCmNTVVr6MNkBBid42lpgQoCRzchLTKn1S1D5dZ5tOdldwFJ8Vn/kZgM
         E4HSgrOZGPwPsBkn2aak8DMI5VkhbYqjii2A+vr9B1Ii1eIMMIsmzR7dt1p4cQBO1dmr
         4UqhH2mXfe5HeNQjr4zx9YT+DPvMcaZ+Q0FxLoy515105YU02BN+kXjzjKOfMuuMHw/2
         IJ/g8vz+Gq1jfBsctEu0DzzUKP+dBRqzRamYJQfhXI3ycsK5lSjUgWiyLg2aV7eOEv5B
         j9QX118DpU7iDpGXAyaWgAoF1sZkS9fXND+qv9NabC9EngtQENn0fF0xULZEm72Z94V8
         OJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03DKykj/oEcr1c9RQZ6s7ebk3XvGCmrVJcf+KLq+FbM=;
        b=rzDER4sNY8O/uRb5jsAShij//m7UC5f1pelQ533IW2JBe9Xv8XE+4pTSHHq+P9pUyB
         ilRgKMCPrtjwwXaLhzSU6SdUCAZBmDagD3vJAMFppnnus7b2Jul6BMeL42ah1DhG/I5d
         KTOMPsHAx7yfqpirvXigGl92cZ1QtwRFH0Kz0p3QeVm9jNGkYzKTn7kxeMhxLFMbJGy2
         HCprpUXRvVUvOQX+csHCtOIWuy0Wzskqzx90MsjJTl0/etq7RQSl0beRNYxhWB8ApDm4
         VwYAq52bp/QdZ8oaBTle3cLPsxsklieU/IdBkC63gYz2G8ZcDgpzX8PwBAzjkQ2nKH/a
         Esfg==
X-Gm-Message-State: APt69E3gBBWGRIoTNEN7r0pfjuiXfW/wPqoSVhKtLMhRBSHGmAVLo0Q/
        SZENzlONVZem4+Kcx3TMzP/Od3mT
X-Google-Smtp-Source: ADUXVKKL9lnxPkWqfC388PDaDDgeGsEQUxb0Kdm+2ARkIDV6cCaFq+vlZkfjuMBFxOOskTDGet3Zrw==
X-Received: by 2002:a1c:b2d0:: with SMTP id b199-v6mr7921656wmf.108.1528722410575;
        Mon, 11 Jun 2018 06:06:50 -0700 (PDT)
Received: from dimapc.localnet (109-252-55-168.nat.spd-mgts.ru. [109.252.55.168])
        by smtp.gmail.com with ESMTPSA id t10-v6sm22504646wrq.74.2018.06.11.06.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:06:49 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] memory: tegra: Introduce Tegra20 EMC driver
Date: Mon, 11 Jun 2018 16:06:41 +0300
Message-ID: <2510221.F5DvE09a94@dimapc>
In-Reply-To: <20180611113503.GC31977@ulmo>
References: <20180603223654.23324-1-digetx@gmail.com> <c17a1edf-f87d-e5f6-b446-34505a2bbc07@gmail.com> <20180611113503.GC31977@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 June 2018 14:35:03 MSK Thierry Reding wrote:
> On Wed, Jun 06, 2018 at 04:42:01PM +0300, Dmitry Osipenko wrote:
> > On 06.06.2018 14:02, Thierry Reding wrote:
> > > On Mon, Jun 04, 2018 at 01:36:54AM +0300, Dmitry Osipenko wrote:
> [...]
> 
> > >> +struct tegra_emc {
> > >> +	struct device *dev;
> > >> +	struct notifier_block clk_nb;
> > >> +	struct clk *backup_clk;
> > >> +	struct clk *emc_mux;
> > >> +	struct clk *pll_m;
> > >> +	struct clk *clk;
> > >> +	void __iomem *regs;
> > >> +
> > >> +	struct completion clk_handshake_complete;
> > >> +	int irq;
> > >> +
> > >> +	struct emc_timing *timings;
> > >> +	unsigned int num_timings;
> > >> +};
> > >> +
> > >> +static irqreturn_t tegra_emc_isr(int irq, void *data)
> > >> +{
> > >> +	struct tegra_emc *emc = data;
> > >> +	u32 intmask = EMC_CLKCHANGE_COMPLETE_INT;
> > >> +	u32 status;
> > >> +
> > >> +	status = readl_relaxed(emc->regs + EMC_INTSTATUS) & intmask;
> > >> +	if (!status)
> > >> +		return IRQ_NONE;
> > >> +
> > >> +	/* clear interrupts */
> > >> +	writel_relaxed(status, emc->regs + EMC_INTSTATUS);
> > > 
> > > Do we really want to just clear the handshake complete interrupt or do
> > > we want to clear all of them? Perhaps we should also warn if there are
> > > other interrupts that we're not handling? Currently we'd only get some
> > > warning if another interrupt triggered without the handshake complete
> > > one triggering at the same time, but couldn't there be others asserted
> > > along with the handshake complete interrupt? In which case we'd just
> > > be ignoring them. Or perhaps not clearing it would get the ISR run
> > > immediately again and produce the "nobody cared" warning?
> > 
> > Yes, we really want to just clear the handshake-complete interrupt. No, we
> > shouldn't warn about other interrupts because IRQ subsys does it for us.
> > Other interrupts shouldn't be asserted because we disabled them with the
> > interrupts masking in emc_setup_hw(). Other interrupts can only be
> > asserted in a case of a bug, there will be a "nobody cared" warning and
> > interrupt will be disabled, this is exactly what we want in that case.
> 
> Okay, that's what I was suspecting might happen. Seems fine, then.
> 
> > >> +static int cmp_timings(const void *_a, const void *_b)
> > >> +{
> > >> +	const struct emc_timing *a = _a;
> > >> +	const struct emc_timing *b = _b;
> > >> +
> > >> +	if (a->rate < b->rate)
> > >> +		return -1;
> > >> +	else if (a->rate == b->rate)
> > >> +		return 0;
> > >> +	else
> > >> +		return 1;
> > > 
> > > Nit, I tend to
> > 
> > Tend to..?
> 
> Looks like I got distracted at this point. =) What I meant to say is
> that I tend to not use if ... else if ... else for things that do
> immediately return. The above is equivalent to the below, which I think
> is much easier to read:
> 
> 	if (a->rate < b->rate)
> 		return -1;
> 
> 	if (a->rate > b->rate)
> 		return 1;
> 
> 	return 0;
> 

Okay.

> > >> +}
> > >> +
> > >> +static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
> > >> +					  struct device_node *node)
> > >> +{
> > >> +	struct device_node *child;
> > >> +	struct emc_timing *timing;
> > >> +	int child_count;
> > >> +	int err;
> > >> +
> > >> +	child_count = of_get_child_count(node);
> > > 
> > > It's unfortunate that of_get_child_count() doesn't return unsigned int,
> > > there's no reason why this would have to be signed.
> > 
> > Patches are welcome ;)
> 
> Yeah, just a random drive-by comment. Please ignore. =)
> 
> > >> +	if (!child_count) {
> > >> +		dev_err(emc->dev, "no memory timings in DT node\n");
> > >> +		return -ENOENT;
> > >> +	}
> > >> +
> > >> +	emc->timings = devm_kcalloc(emc->dev, child_count, 
sizeof(*timing),
> > >> +				    GFP_KERNEL);
> > >> +	if (!emc->timings)
> > >> +		return -ENOMEM;
> > >> +
> > >> +	emc->num_timings = child_count;
> > >> +	timing = emc->timings;
> > >> +
> > >> +	for_each_child_of_node(node, child) {
> > >> +		err = load_one_timing_from_dt(emc, timing++, child);
> > >> +		if (err) {
> > >> +			of_node_put(child);
> > >> +			return err;
> > >> +		}
> > >> +	}
> > >> +
> > >> +	sort(emc->timings, emc->num_timings, sizeof(*timing), 
cmp_timings,
> > >> +	     NULL);
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static struct device_node *
> > >> +tegra_emc_find_node_by_ram_code(struct tegra_emc *emc, u32 ram_code)
> > >> +{
> > >> +	struct device_node *np;
> > >> +	int err;
> > >> +
> > >> +	for_each_child_of_node(emc->dev->of_node, np) {
> > >> +		u32 value;
> > >> +
> > >> +		err = of_property_read_u32(np, "nvidia,ram-code", &value);
> > >> +		if (err || value != ram_code)
> > >> +			continue;
> > >> +
> > >> +		return np;
> > >> +	}
> > >> +
> > >> +	dev_info(emc->dev, "no memory timings for RAM code %u found in DT
\n",
> > >> +		 ram_code);
> > > 
> > > This seems like it should be dev_warn() or perhaps even dev_err() given
> > > that the result of it is the driver failing to probe. dev_info() may go
> > > unnoticed.
> > 
> > Absence of memory timings is a valid case, hence dev_info() suit well
> > here.
> > 
> > I can't see anything wrong with returning a errno if driver has nothing to
> > do and prefer to keep it because in that case managed resources would be
> > free'd by the driver core, though returning '0' also would work.
> 
> I disagree. A driver failing to probe will show up as a kernel log entry
> and is something that people will have to whitelist if they're filtering
> for error messages in the boot log.
> 
> I think it's more user-friendly to just let the driver succeed the probe
> in an expected case, even if that means there's really nothing to do. If
> you're really concerned about the managed resources staying around, I
> think you could probably get rid of them explicitly. By the looks of it
> devres_release_all() isn't an exported symbol, so it can't be called
> from driver code, but perhaps that's something that we can change.
> 
> > >> +
> > >> +	return NULL;
> > >> +}
> > >> +
> > >> +static int tegra_emc_clk_change_notify(struct notifier_block *nb,
> > >> +				       unsigned long msg, void *data)
> > >> +{
> > >> +	struct tegra_emc *emc = container_of(nb, struct tegra_emc, 
clk_nb);
> > >> +	struct clk_notifier_data *cnd = data;
> > >> +	int err;
> > >> +
> > >> +	switch (msg) {
> > >> +	case PRE_RATE_CHANGE:
> > >> +		err = emc_prepare_timing_change(emc, cnd->new_rate);
> > >> +		break;
> > >> +
> > >> +	case ABORT_RATE_CHANGE:
> > >> +		err = emc_prepare_timing_change(emc, cnd->old_rate);
> > >> +		if (err)
> > >> +			break;
> > >> +
> > >> +		err = emc_complete_timing_change(emc, true);
> > >> +		break;
> > >> +
> > >> +	case POST_RATE_CHANGE:
> > >> +		err = emc_complete_timing_change(emc, false);
> > >> +		break;
> > >> +
> > >> +	default:
> > >> +		return NOTIFY_DONE;
> > >> +	}
> > >> +
> > >> +	return notifier_from_errno(err);
> > >> +}
> > >> +
> > >> +static int emc_setup_hw(struct tegra_emc *emc)
> > >> +{
> > >> +	u32 emc_cfg;
> > >> +
> > >> +	emc_cfg = readl_relaxed(emc->regs + EMC_CFG_2);
> > >> +
> > >> +	/*
> > >> +	 * Depending on a memory type, DRAM should enter either self-
refresh
> > >> +	 * or power-down state on EMC clock change.
> > >> +	 */
> > >> +	if (!(emc_cfg & EMC_CLKCHANGE_PD_ENABLE) &&
> > >> +	    !(emc_cfg & EMC_CLKCHANGE_SR_ENABLE))
> > >> +	{
> > >> +		dev_err(emc->dev,
> > >> +			"bootloader didn't specify DRAM auto-suspend mode\n");
> > >> +		return -EINVAL;
> > >> +	}
> > >> +
> > >> +	/* allow EMC and CAR to handshake on PLL divider/source changes 
*/
> > >> +	emc_cfg |= EMC_CLKCHANGE_REQ_ENABLE;
> > >> +	writel_relaxed(emc_cfg, emc->regs + EMC_CFG_2);
> > >> +
> > >> +	/* initialize interrupt */
> > >> +	writel_relaxed(EMC_CLKCHANGE_COMPLETE_INT, emc->regs + 
EMC_INTMASK);
> > >> +	writel_relaxed(EMC_CLKCHANGE_COMPLETE_INT, emc->regs +
> > >> EMC_INTSTATUS);
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static int emc_init(struct tegra_emc *emc, unsigned long rate)
> > >> +{
> > >> +	int err;
> > >> +
> > >> +	err = clk_set_parent(emc->emc_mux, emc->backup_clk);
> > >> +	if (err) {
> > >> +		dev_err(emc->dev,
> > >> +			"failed to reparent to backup source: %d\n", err);
> > >> +		return err;
> > >> +	}
> > >> +
> > >> +	err = clk_set_rate(emc->pll_m, rate);
> > >> +	if (err)
> > >> +		dev_err(emc->dev,
> > >> +			"failed to change pll_m rate: %d\n", err);
> > >> +
> > >> +	err = clk_set_parent(emc->emc_mux, emc->pll_m);
> > >> +	if (err) {
> > >> +		dev_err(emc->dev,
> > >> +			"failed to reparent to pll_m: %d\n", err);
> > >> +		return err;
> > >> +	}
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static int tegra_emc_probe(struct platform_device *pdev)
> > >> +{
> > >> +	struct device_node *np;
> > >> +	struct tegra_emc *emc;
> > >> +	struct resource *res;
> > >> +	u32 ram_code;
> > >> +	int err;
> > >> +
> > >> +	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
> > >> +	if (!emc)
> > >> +		return -ENOMEM;
> > >> +
> > >> +	emc->dev = &pdev->dev;
> > >> +
> > >> +	ram_code = tegra_read_ram_code();
> > >> +
> > >> +	np = tegra_emc_find_node_by_ram_code(emc, ram_code);
> > >> +	if (!np)
> > >> +		return -ENOENT;
> > >> +
> > >> +	err = tegra_emc_load_timings_from_dt(emc, np);
> > >> +	of_node_put(np);
> > >> +	if (err)
> > >> +		return err;
> > >> +
> > >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >> +	emc->regs = devm_ioremap_resource(&pdev->dev, res);
> > >> +	if (IS_ERR(emc->regs))
> > >> +		return PTR_ERR(emc->regs);
> > >> +
> > >> +	err = emc_setup_hw(emc);
> > >> +	if (err)
> > >> +		return err;
> > >> +
> > >> +	emc->irq = platform_get_irq(pdev, 0);
> > >> +	if (emc->irq < 0) {
> > >> +		dev_warn(&pdev->dev, "interrupt not specified\n");
> > >> +		dev_warn(&pdev->dev, "continuing, but please update your DT
\n");
> > > 
> > > Do we really need this? I think this is a case where we don't have to
> > > keep backwards-compatibility because this driver hasn't "worked" in a
> > > very long time (because it was absent). Therefore, if we error out in
> > > the absence of an interrupt we don't break anything.
> > > 
> > > There's a few places in this driver that are awkward just because the
> > > interrupt isn't mandatory. I don't think it's warranted in this case.
> > 
> > Backwards compatibility is always nice to have, but I don't really mind
> > dropping it.
> So the Tegra20 EMC driver was removed in commit a7cbe92cef27 ("ARM:
> tegra: remove tegra EMC scaling driver"), which is dated August 20,
> 2013. So it's been almost 5 years since EMC frequency scaling has
> worked on Tegra20 (that is, it hasn't worked since v3.15). I very
> much doubt that anyone is still running a kernel or DTB from that
> time, given how little used to be supported and how much they'd be
> missing out on if they stuck to that DTB.
> 
> I don't think backwards compatibility will hold up as an argument
> in this case.
> 

Okay.

> > >> +	} else {
> > >> +		init_completion(&emc->clk_handshake_complete);
> > >> +
> > >> +		err = devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr, 
0,
> > >> +				       dev_name(&pdev->dev), emc);
> > >> +		if (err < 0) {
> > >> +			dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
> > >> +				emc->irq, err);
> > >> +			return err;
> > >> +		}
> > >> +	}
> > >> +
> > >> +	emc->pll_m = clk_get_sys(NULL, "pll_m");
> > >> +	if (IS_ERR(emc->pll_m)) {
> > >> +		err = PTR_ERR(emc->pll_m);
> > >> +		dev_err(&pdev->dev, "failed to get pll_m: %d\n", err);
> > >> +		return err;
> > >> +	}
> > >> +
> > >> +	emc->backup_clk = clk_get_sys(NULL, "pll_p");
> > >> +	if (IS_ERR(emc->backup_clk)) {
> > >> +		err = PTR_ERR(emc->backup_clk);
> > >> +		dev_err(&pdev->dev, "failed to get pll_p: %d\n", err);
> > >> +		goto put_pll_m;
> > >> +	}
> > >> +
> > >> +	emc->clk = clk_get_sys(NULL, "emc");
> > >> +	if (IS_ERR(emc->clk)) {
> > >> +		err = PTR_ERR(emc->clk);
> > >> +		dev_err(&pdev->dev, "failed to get emc: %d\n", err);
> > >> +		goto put_backup;
> > >> +	}
> > > 
> > > Instead of using clk_get_sys(), why not specify these in the DT with
> > > proper names for context ("emc", "pll", "backup")? Again, I don't think
> > > we have to worry about backwards-compatibility here since there can be
> > > no regression.
> > 
> > I don't think that "pll" and "backup" could be placed in DT because it is
> > a pure software-driver descriptio     in
> DT. There are other cases, like for display, where we list clocks in the
> DT that aren't strictly inputs to a hardware block. But they are related
> to the functionality of the block, so I think it makes sense to list
> them as well.
> 
> In this particular case, the PLL is what drives the memory banks, which
> is the think that the EMC controls, right? So that itself is reason
> enough, in my opinion, to list it in DT. Much the same goes for the
> backup clock, which is really just the PLL for some transient state
> where the normal PLL is being reconfigured.

PLL itself shouldn't really matter. EMC doesn't control PLL, but only 
interacts with the Clock-and-Reset controller. This means that we could use 
PLL_C instead of PLL_M if we wanted. Though PLL_M is meant to be a "memory 
PLL".

To me a selection of a parent clock is a pure software description that is 
wrong to be placed in DT.

I'm not sure that specifying parent clock for display in DT is correct. That 
simply doesn't make sense because there are four possible parent clocks for 
the display. Selection of a parent clock in DT is a pure software description 
that is only relevant for the upstream Linux DRM driver, it's a mistake to me.

Moreover PLL isn't a "device" clock, but specifically a "system" clock. So 
describing it in DT as a "device" clock is wrong to me too.

Putting all together, the PLL's should be left as-is they are now in v2, 
please let me know if you disagree.

The "emc" clock could be placed in DT since we won't bother with the DT 
backwards compatibility, I'll change it in the next revision of the patchset.
