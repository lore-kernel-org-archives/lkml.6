Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id P5MTIt5dHltZMQAAmS7hNA
	; Mon, 11 Jun 2018 11:35:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7EBE4607BB; Mon, 11 Jun 2018 11:35:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="annNhIG8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8179060541;
	Mon, 11 Jun 2018 11:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8179060541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeFKLfK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:35:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37250 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932765AbeFKLfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:35:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so15803837wmg.2;
        Mon, 11 Jun 2018 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kah1dy0JrKIBUKSUVi7td+PScsnZeTQspfxqBEfBZ0c=;
        b=annNhIG8enFthTKCMtcR8PtNAGvhcY06U8ZZbyXIhwC1O8KEQe3EFBVI34Oq7mFoL/
         LPCM1ShA+7rOz2pu/PVkqVhPe5dbzzKcSp3rrVGlVimvbdcKzOFfq4YWT6mx92y70P1w
         igAbX8t0mo8nOXSjMhLRdZNfzptqVKhwWMs67acThutPt8Cls07VSIJBrz8zlHlK8ySe
         1k6nbQCLKDlatmn4NFeCombSA1Dli4hAQnVJRqFMWZNp3L/j7IRHLoQ1G9XO9F+xup47
         /dwwad3/KXmsSqxHGuDHcUJvQ83Wa/VjabEhx3GRrEakS9TCsBLSGyQp9uGzzREe809e
         eFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kah1dy0JrKIBUKSUVi7td+PScsnZeTQspfxqBEfBZ0c=;
        b=p73iUdDL1x/gbYRA2tDiJp0Ggv1ftJE7BdKXb0h261/Dxs5XpXUYF6ZnTNjhj/FbW/
         SOG2tcMNtIDuDk3ODXEtajoXucjrtoc+kg8pznmpn4MWurvlPsMml0f+sKOxFZDVmpIB
         JqXtLIznSzAou2e5MzmiWrC+DH8ud4gFTVAAiKsIqTbhIOnDDed9KrfAuMwFa6hxsxaE
         VRkf0gkOa6WneYvUb4pqgNsgm8frUWsxON6S4pJQzp7l6hnHuOZglQ5bHxHidegFhmfZ
         19J9ve4emIFiTGg8LYIMLO972PFIosb5cO4ryTdgZ/5R025o2E0YCjHOfbevhjoY0tU6
         OsnQ==
X-Gm-Message-State: APt69E0l3YAUm/OlnDBXtVqE/pI+8xHKWRVmORwoYD/LJxkAfLKXw0SW
        2a+520tmOIiWkpfb4n66GcU=
X-Google-Smtp-Source: ADUXVKKQfjQLL17RsqkI5knKkyswfSC8C3KWMjJQ9+T97sfdnk+QByL930moRFwP9HFbgbn0m4YfMw==
X-Received: by 2002:a1c:dcd4:: with SMTP id t203-v6mr7245562wmg.156.1528716905871;
        Mon, 11 Jun 2018 04:35:05 -0700 (PDT)
Received: from localhost (pD9E510DD.dip0.t-ipconnect.de. [217.229.16.221])
        by smtp.gmail.com with ESMTPSA id y186-v6sm11955845wmd.38.2018.06.11.04.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 04:35:04 -0700 (PDT)
Date: Mon, 11 Jun 2018 13:35:03 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] memory: tegra: Introduce Tegra20 EMC driver
Message-ID: <20180611113503.GC31977@ulmo>
References: <20180603223654.23324-1-digetx@gmail.com>
 <20180603223654.23324-6-digetx@gmail.com>
 <20180606110258.GL11810@ulmo>
 <c17a1edf-f87d-e5f6-b446-34505a2bbc07@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <c17a1edf-f87d-e5f6-b446-34505a2bbc07@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 04:42:01PM +0300, Dmitry Osipenko wrote:
> On 06.06.2018 14:02, Thierry Reding wrote:
> > On Mon, Jun 04, 2018 at 01:36:54AM +0300, Dmitry Osipenko wrote:
[...]
> >> +struct tegra_emc {
> >> +	struct device *dev;
> >> +	struct notifier_block clk_nb;
> >> +	struct clk *backup_clk;
> >> +	struct clk *emc_mux;
> >> +	struct clk *pll_m;
> >> +	struct clk *clk;
> >> +	void __iomem *regs;
> >> +
> >> +	struct completion clk_handshake_complete;
> >> +	int irq;
> >> +
> >> +	struct emc_timing *timings;
> >> +	unsigned int num_timings;
> >> +};
> >> +
> >> +static irqreturn_t tegra_emc_isr(int irq, void *data)
> >> +{
> >> +	struct tegra_emc *emc =3D data;
> >> +	u32 intmask =3D EMC_CLKCHANGE_COMPLETE_INT;
> >> +	u32 status;
> >> +
> >> +	status =3D readl_relaxed(emc->regs + EMC_INTSTATUS) & intmask;
> >> +	if (!status)
> >> +		return IRQ_NONE;
> >> +
> >> +	/* clear interrupts */
> >> +	writel_relaxed(status, emc->regs + EMC_INTSTATUS);
> >=20
> > Do we really want to just clear the handshake complete interrupt or do
> > we want to clear all of them? Perhaps we should also warn if there are
> > other interrupts that we're not handling? Currently we'd only get some
> > warning if another interrupt triggered without the handshake complete
> > one triggering at the same time, but couldn't there be others asserted
> > along with the handshake complete interrupt? In which case we'd just
> > be ignoring them. Or perhaps not clearing it would get the ISR run
> > immediately again and produce the "nobody cared" warning?
> >=20
>=20
> Yes, we really want to just clear the handshake-complete interrupt. No, we
> shouldn't warn about other interrupts because IRQ subsys does it for us. =
Other
> interrupts shouldn't be asserted because we disabled them with the interr=
upts
> masking in emc_setup_hw(). Other interrupts can only be asserted in a cas=
e of a
> bug, there will be a "nobody cared" warning and interrupt will be disable=
d, this
> is exactly what we want in that case.

Okay, that's what I was suspecting might happen. Seems fine, then.

> >> +static int cmp_timings(const void *_a, const void *_b)
> >> +{
> >> +	const struct emc_timing *a =3D _a;
> >> +	const struct emc_timing *b =3D _b;
> >> +
> >> +	if (a->rate < b->rate)
> >> +		return -1;
> >> +	else if (a->rate =3D=3D b->rate)
> >> +		return 0;
> >> +	else
> >> +		return 1;
> >=20
> > Nit, I tend to=20
> >=20
>=20
> Tend to..?

Looks like I got distracted at this point. =3D) What I meant to say is
that I tend to not use if ... else if ... else for things that do
immediately return. The above is equivalent to the below, which I think
is much easier to read:

	if (a->rate < b->rate)
		return -1;

	if (a->rate > b->rate)
		return 1;

	return 0;

> >> +}
> >> +
> >> +static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
> >> +					  struct device_node *node)
> >> +{
> >> +	struct device_node *child;
> >> +	struct emc_timing *timing;
> >> +	int child_count;
> >> +	int err;
> >> +
> >> +	child_count =3D of_get_child_count(node);
> >=20
> > It's unfortunate that of_get_child_count() doesn't return unsigned int,
> > there's no reason why this would have to be signed.
> >=20
>=20
> Patches are welcome ;)

Yeah, just a random drive-by comment. Please ignore. =3D)

>=20
> >> +	if (!child_count) {
> >> +		dev_err(emc->dev, "no memory timings in DT node\n");
> >> +		return -ENOENT;
> >> +	}
> >> +
> >> +	emc->timings =3D devm_kcalloc(emc->dev, child_count, sizeof(*timing),
> >> +				    GFP_KERNEL);
> >> +	if (!emc->timings)
> >> +		return -ENOMEM;
> >> +
> >> +	emc->num_timings =3D child_count;
> >> +	timing =3D emc->timings;
> >> +
> >> +	for_each_child_of_node(node, child) {
> >> +		err =3D load_one_timing_from_dt(emc, timing++, child);
> >> +		if (err) {
> >> +			of_node_put(child);
> >> +			return err;
> >> +		}
> >> +	}
> >> +
> >> +	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
> >> +	     NULL);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static struct device_node *
> >> +tegra_emc_find_node_by_ram_code(struct tegra_emc *emc, u32 ram_code)
> >> +{
> >> +	struct device_node *np;
> >> +	int err;
> >> +
> >> +	for_each_child_of_node(emc->dev->of_node, np) {
> >> +		u32 value;
> >> +
> >> +		err =3D of_property_read_u32(np, "nvidia,ram-code", &value);
> >> +		if (err || value !=3D ram_code)
> >> +			continue;
> >> +
> >> +		return np;
> >> +	}
> >> +
> >> +	dev_info(emc->dev, "no memory timings for RAM code %u found in DT\n",
> >> +		 ram_code);
> >=20
> > This seems like it should be dev_warn() or perhaps even dev_err() given
> > that the result of it is the driver failing to probe. dev_info() may go
> > unnoticed.
> >=20
>=20
> Absence of memory timings is a valid case, hence dev_info() suit well her=
e.
>=20
> I can't see anything wrong with returning a errno if driver has nothing t=
o do
> and prefer to keep it because in that case managed resources would be fre=
e'd by
> the driver core, though returning '0' also would work.

I disagree. A driver failing to probe will show up as a kernel log entry
and is something that people will have to whitelist if they're filtering
for error messages in the boot log.

I think it's more user-friendly to just let the driver succeed the probe
in an expected case, even if that means there's really nothing to do. If
you're really concerned about the managed resources staying around, I
think you could probably get rid of them explicitly. By the looks of it
devres_release_all() isn't an exported symbol, so it can't be called
=66rom driver code, but perhaps that's something that we can change.

>=20
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >> +static int tegra_emc_clk_change_notify(struct notifier_block *nb,
> >> +				       unsigned long msg, void *data)
> >> +{
> >> +	struct tegra_emc *emc =3D container_of(nb, struct tegra_emc, clk_nb);
> >> +	struct clk_notifier_data *cnd =3D data;
> >> +	int err;
> >> +
> >> +	switch (msg) {
> >> +	case PRE_RATE_CHANGE:
> >> +		err =3D emc_prepare_timing_change(emc, cnd->new_rate);
> >> +		break;
> >> +
> >> +	case ABORT_RATE_CHANGE:
> >> +		err =3D emc_prepare_timing_change(emc, cnd->old_rate);
> >> +		if (err)
> >> +			break;
> >> +
> >> +		err =3D emc_complete_timing_change(emc, true);
> >> +		break;
> >> +
> >> +	case POST_RATE_CHANGE:
> >> +		err =3D emc_complete_timing_change(emc, false);
> >> +		break;
> >> +
> >> +	default:
> >> +		return NOTIFY_DONE;
> >> +	}
> >> +
> >> +	return notifier_from_errno(err);
> >> +}
> >> +
> >> +static int emc_setup_hw(struct tegra_emc *emc)
> >> +{
> >> +	u32 emc_cfg;
> >> +
> >> +	emc_cfg =3D readl_relaxed(emc->regs + EMC_CFG_2);
> >> +
> >> +	/*
> >> +	 * Depending on a memory type, DRAM should enter either self-refresh
> >> +	 * or power-down state on EMC clock change.
> >> +	 */
> >> +	if (!(emc_cfg & EMC_CLKCHANGE_PD_ENABLE) &&
> >> +	    !(emc_cfg & EMC_CLKCHANGE_SR_ENABLE))
> >> +	{
> >> +		dev_err(emc->dev,
> >> +			"bootloader didn't specify DRAM auto-suspend mode\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* allow EMC and CAR to handshake on PLL divider/source changes */
> >> +	emc_cfg |=3D EMC_CLKCHANGE_REQ_ENABLE;
> >> +	writel_relaxed(emc_cfg, emc->regs + EMC_CFG_2);
> >> +
> >> +	/* initialize interrupt */
> >> +	writel_relaxed(EMC_CLKCHANGE_COMPLETE_INT, emc->regs + EMC_INTMASK);
> >> +	writel_relaxed(EMC_CLKCHANGE_COMPLETE_INT, emc->regs + EMC_INTSTATUS=
);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int emc_init(struct tegra_emc *emc, unsigned long rate)
> >> +{
> >> +	int err;
> >> +
> >> +	err =3D clk_set_parent(emc->emc_mux, emc->backup_clk);
> >> +	if (err) {
> >> +		dev_err(emc->dev,
> >> +			"failed to reparent to backup source: %d\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	err =3D clk_set_rate(emc->pll_m, rate);
> >> +	if (err)
> >> +		dev_err(emc->dev,
> >> +			"failed to change pll_m rate: %d\n", err);
> >> +
> >> +	err =3D clk_set_parent(emc->emc_mux, emc->pll_m);
> >> +	if (err) {
> >> +		dev_err(emc->dev,
> >> +			"failed to reparent to pll_m: %d\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int tegra_emc_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device_node *np;
> >> +	struct tegra_emc *emc;
> >> +	struct resource *res;
> >> +	u32 ram_code;
> >> +	int err;
> >> +
> >> +	emc =3D devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
> >> +	if (!emc)
> >> +		return -ENOMEM;
> >> +
> >> +	emc->dev =3D &pdev->dev;
> >> +
> >> +	ram_code =3D tegra_read_ram_code();
> >> +
> >> +	np =3D tegra_emc_find_node_by_ram_code(emc, ram_code);
> >> +	if (!np)
> >> +		return -ENOENT;
> >> +
> >> +	err =3D tegra_emc_load_timings_from_dt(emc, np);
> >> +	of_node_put(np);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +	emc->regs =3D devm_ioremap_resource(&pdev->dev, res);
> >> +	if (IS_ERR(emc->regs))
> >> +		return PTR_ERR(emc->regs);
> >> +
> >> +	err =3D emc_setup_hw(emc);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	emc->irq =3D platform_get_irq(pdev, 0);
> >> +	if (emc->irq < 0) {
> >> +		dev_warn(&pdev->dev, "interrupt not specified\n");
> >> +		dev_warn(&pdev->dev, "continuing, but please update your DT\n");
> >=20
> > Do we really need this? I think this is a case where we don't have to
> > keep backwards-compatibility because this driver hasn't "worked" in a
> > very long time (because it was absent). Therefore, if we error out in
> > the absence of an interrupt we don't break anything.
> >=20
> > There's a few places in this driver that are awkward just because the
> > interrupt isn't mandatory. I don't think it's warranted in this case.
> >=20
>=20
> Backwards compatibility is always nice to have, but I don't really mind d=
ropping it.

So the Tegra20 EMC driver was removed in commit a7cbe92cef27 ("ARM:
tegra: remove tegra EMC scaling driver"), which is dated August 20,
2013. So it's been almost 5 years since EMC frequency scaling has
worked on Tegra20 (that is, it hasn't worked since v3.15). I very
much doubt that anyone is still running a kernel or DTB from that
time, given how little used to be supported and how much they'd be
missing out on if they stuck to that DTB.

I don't think backwards compatibility will hold up as an argument
in this case.

>=20
> >> +	} else {
> >> +		init_completion(&emc->clk_handshake_complete);
> >> +
> >> +		err =3D devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr, 0,
> >> +				       dev_name(&pdev->dev), emc);
> >> +		if (err < 0) {
> >> +			dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
> >> +				emc->irq, err);
> >> +			return err;
> >> +		}
> >> +	}
> >> +
> >> +	emc->pll_m =3D clk_get_sys(NULL, "pll_m");
> >> +	if (IS_ERR(emc->pll_m)) {
> >> +		err =3D PTR_ERR(emc->pll_m);
> >> +		dev_err(&pdev->dev, "failed to get pll_m: %d\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	emc->backup_clk =3D clk_get_sys(NULL, "pll_p");
> >> +	if (IS_ERR(emc->backup_clk)) {
> >> +		err =3D PTR_ERR(emc->backup_clk);
> >> +		dev_err(&pdev->dev, "failed to get pll_p: %d\n", err);
> >> +		goto put_pll_m;
> >> +	}
> >> +
> >> +	emc->clk =3D clk_get_sys(NULL, "emc");
> >> +	if (IS_ERR(emc->clk)) {
> >> +		err =3D PTR_ERR(emc->clk);
> >> +		dev_err(&pdev->dev, "failed to get emc: %d\n", err);
> >> +		goto put_backup;
> >> +	}
> >=20
> > Instead of using clk_get_sys(), why not specify these in the DT with
> > proper names for context ("emc", "pll", "backup")? Again, I don't think
> > we have to worry about backwards-compatibility here since there can be
> > no regression.
> >=20
>=20
> I don't think that "pll" and "backup" could be placed in DT because it is=
 a pure
> software-driver description.
>=20
> "emc" could be retrieved from DT if we don't care about backwards compati=
bility.

I think both PLL and backup clocks would be appropriate to describe in
DT. There are other cases, like for display, where we list clocks in the
DT that aren't strictly inputs to a hardware block. But they are related
to the functionality of the block, so I think it makes sense to list
them as well.

In this particular case, the PLL is what drives the memory banks, which
is the think that the EMC controls, right? So that itself is reason
enough, in my opinion, to list it in DT. Much the same goes for the
backup clock, which is really just the PLL for some transient state
where the normal PLL is being reconfigured.

Thierry

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlseXmQACgkQ3SOs138+
s6G8HhAAtKI8dZsAbkX/SO8JQypdJmqW2HBbn+DzLz4JBgsLS9ByBw+e9HkrjTf9
L512P5Ckmu+WJmDDZqGTuDZ+Djj1PjBtSXpW8ey/VKD5DYStpGR5pcoXdZCaT7Aa
MOaFsy1QwP9Swc9iwBX2uw1G89jgDLXFhihkXXjFawCXgW38QVchtHMuZFYr2WnT
jHic6/0r005Od4GdwB7ZdVgYjyr+HPY/FG+Sz5UH5yC04ELg132a06DhYCEaWKd+
UyM3TmPIqgxbNYHI81PUN9tZPjcrRy1beWmTL9l3Qob7f3mvikhVhZdxo0+3hmHf
Ml2Iyv58OQsBZ4IF9RI30wBGhFymwZLk28PLTAn+YgpVFnPvjpKHYUJ5p1dVNM3r
n5H4wS7puspnPu46tR9FCH/fvfjOGinrjCYGF5LhQxBb0Zsn4itjjZ5Dbc+hHLzx
1k1QBXEyybsmWHNQ/RyZt8wOlkbpTOgtz3104RcyN7j5lWwAQf9KOxKiq6hSqgsP
eWw95I5Hr6HX2n/16dHuX77n+RpgkqACl0j/WV40jkcg4/dgITn8mmAQClUPIjyv
GEfkIzq5Rr5BLObBz5XM38IOtKCOwLddpJd2lEFYxrTcKXwfcDEwAnG1Nc3mqLv0
fwMtJfX1UeiPoDlw8bU9dqQEidQi0MrNVrU1cVumzBmkvXKcTk0=
=ZQoW
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
