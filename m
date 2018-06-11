Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34216C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FE320660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvXdFFXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FE320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934119AbeFKSKc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:10:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43759 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeFKSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:10:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so21350303wrm.10;
        Mon, 11 Jun 2018 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=woggjaDRtZ0uUxAUw9LGH/R9FsgIU2j+vuatNv48OOQ=;
        b=OvXdFFXIjPu18Se9qOoFYM1zrfEkGU2NGSYkbCAiTVh4kDUlLkKL22pY0VY7LjOS9/
         Ixxeq1atFfRbdiT0mIV3/jMAJhBve01Oj+e4LlGR/49zwyUIVVrnapIe+EXxARfyUiFY
         kVIdxtLM/SHV7NIUjlrFoI0LGJkzDqZdvdm6wXCljYca0PkUBTBiFrP9GZ3caKczuVL9
         42HruhxJP2GDhH7Iq+dsF2/XFOeKAns2FLO5av/T38yZYlIfm6wylcryBOUJ8mT96J9J
         6nP5t9mcS0/sPWBwedMDmObxVlQdL3H1NfWNGBrcBj8VVhekleRXP3HPDI631xHRydxT
         Gq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=woggjaDRtZ0uUxAUw9LGH/R9FsgIU2j+vuatNv48OOQ=;
        b=D1jbt0RYIsR3gOYezPoUd3sSubKFruG3cAUUabubP0lZw9IqMlPKF/G7KqFfE9tV8C
         UcbPUpIINOATD0FsCE9NoGNPhWpFk6E4nFmwK+rkvhtcdV8aiBxocoydUVs0mYBDQFaI
         Nce/cAIpbMw2L/i5gCxh2bLfMhg3OkDyXSVchlj3j5FRUzJ8oPeRYqkEgoQtyPODgWQM
         GKtrSLkf9QprUs8jReRI0Wua7tAEc79YiixR1ux6QKUXd3rvKGjEHe1OxbTo96IDNoaL
         mqetb1cW8v/QX0bxMrmXH5OVmMPgRC6e92EvKi+r/3AMAAP9KfVcRFqzF2aKDDdksg+u
         OYOQ==
X-Gm-Message-State: APt69E1/rOuerVpgV6LH7kLWSxPJjaywmfuaabtujvo7TPL+vN//e7o1
        Ws06InXOGPuC+5ItL+Uq9Cx4e/wd
X-Google-Smtp-Source: ADUXVKJ2tqVMH4c1mrJ/lZX0CY7BEZrPImTpWzzpk0w9j3IZ5VtndNGF6JMnQtXAqfO4jFdGYmtoOA==
X-Received: by 2002:adf:8ecb:: with SMTP id q69-v6mr150646wrb.261.1528740628281;
        Mon, 11 Jun 2018 11:10:28 -0700 (PDT)
Received: from dimapc.localnet (109-252-55-139.nat.spd-mgts.ru. [109.252.55.139])
        by smtp.gmail.com with ESMTPSA id h12-v6sm10780820wmb.3.2018.06.11.11.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 11:10:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] memory: tegra: Introduce Tegra20 EMC driver
Date:   Mon, 11 Jun 2018 21:10:25 +0300
Message-ID: <3450885.xV2mL0Rtsq@dimapc>
In-Reply-To: <20180611155343.GE31977@ulmo>
References: <20180603223654.23324-1-digetx@gmail.com> <2510221.F5DvE09a94@dimapc> <20180611155343.GE31977@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 June 2018 18:53:43 MSK Thierry Reding wrote:
> On Mon, Jun 11, 2018 at 04:06:41PM +0300, Dmitry Osipenko wrote:
> > On Monday, 11 June 2018 14:35:03 MSK Thierry Reding wrote:
> > > On Wed, Jun 06, 2018 at 04:42:01PM +0300, Dmitry Osipenko wrote:
> > > > On 06.06.2018 14:02, Thierry Reding wrote:
> > > > > On Mon, Jun 04, 2018 at 01:36:54AM +0300, Dmitry Osipenko wrote:
> [...]
> 
> > > > >> +	} else {
> > > > >> +		init_completion(&emc->clk_handshake_complete);
> > > > >> +
> > > > >> +		err = devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr,
> > 
> > 0,
> > 
> > > > >> +				       dev_name(&pdev->dev), emc);
> > > > >> +		if (err < 0) {
> > > > >> +			dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
> > > > >> +				emc->irq, err);
> > > > >> +			return err;
> > > > >> +		}
> > > > >> +	}
> > > > >> +
> > > > >> +	emc->pll_m = clk_get_sys(NULL, "pll_m");
> > > > >> +	if (IS_ERR(emc->pll_m)) {
> > > > >> +		err = PTR_ERR(emc->pll_m);
> > > > >> +		dev_err(&pdev->dev, "failed to get pll_m: %d\n", err);
> > > > >> +		return err;
> > > > >> +	}
> > > > >> +
> > > > >> +	emc->backup_clk = clk_get_sys(NULL, "pll_p");
> > > > >> +	if (IS_ERR(emc->backup_clk)) {
> > > > >> +		err = PTR_ERR(emc->backup_clk);
> > > > >> +		dev_err(&pdev->dev, "failed to get pll_p: %d\n", err);
> > > > >> +		goto put_pll_m;
> > > > >> +	}
> > > > >> +
> > > > >> +	emc->clk = clk_get_sys(NULL, "emc");
> > > > >> +	if (IS_ERR(emc->clk)) {
> > > > >> +		err = PTR_ERR(emc->clk);
> > > > >> +		dev_err(&pdev->dev, "failed to get emc: %d\n", err);
> > > > >> +		goto put_backup;
> > > > >> +	}
> > > > > 
> > > > > Instead of using clk_get_sys(), why not specify these in the DT with
> > > > > proper names for context ("emc", "pll", "backup")? Again, I don't
> > > > > think
> > > > > we have to worry about backwards-compatibility here since there can
> > > > > be
> > > > > no regression.
> > > > 
> > > > I don't think that "pll" and "backup" could be placed in DT because it
> > > > is
> > > > a pure software-driver descriptio     in
> > > 
> > > DT. There are other cases, like for display, where we list clocks in the
> > > DT that aren't strictly inputs to a hardware block. But they are related
> > > to the functionality of the block, so I think it makes sense to list
> > > them as well.
> > > 
> > > In this particular case, the PLL is what drives the memory banks, which
> > > is the think that the EMC controls, right? So that itself is reason
> > > enough, in my opinion, to list it in DT. Much the same goes for the
> > > backup clock, which is really just the PLL for some transient state
> > > where the normal PLL is being reconfigured.
> > 
> > PLL itself shouldn't really matter. EMC doesn't control PLL, but only
> > interacts with the Clock-and-Reset controller. This means that we could
> > use
> > PLL_C instead of PLL_M if we wanted. Though PLL_M is meant to be a "memory
> > PLL".
> > 
> > To me a selection of a parent clock is a pure software description that is
> > wrong to be placed in DT.
> 
> I think of it as configuration rather than software description. The
> problem that we're trying to solve with DT is primarily one of
> configuration and parameterization. The idea is that we describe the
> interfaces of some hardware module and then specify which resources
> to use as inputs and/or outputs for those interfaces.
> 
> So in this case we can define that in order to perform its function the
> EMC driver needs to somehow control a PLL that drives the memory. Even
> if the EMC hardware itself doesn't control a PLL, not controlling a PLL
> would make the EMC driver rather pointless. Actually, if the hardware
> did control the PLL itself, there'd be no need to describe any aspect of
> that PLL in the DT. We only need to describe it in DT because we've got
> several possibilities and we want to make sure we pick one that is best
> for our specific use-case.
> 
> > I'm not sure that specifying parent clock for display in DT is correct.
> > That simply doesn't make sense because there are four possible parent
> > clocks for the display. Selection of a parent clock in DT is a pure
> > software description that is only relevant for the upstream Linux DRM
> > driver, it's a mistake to me.
> I disagree. While it is certainly true that there are multiple possible
> PLLs for display, which one to use depends on the use-case. In most SoC
> generations we have two display PLLs where pll_d2 is "more capable" than
> pll_d because it can run at higher frequencies. pll_d for example can in
> many cases not be used to drive an HDMI output at 1080p resolutions. For
> DisplayPort output, pll_d can usually also not be used. It therefore
> makes sense to define in DT which PLL to use for a particular use-case.
> 

Okay.

> Now, I'll grant you that this somewhat blurs the lines of hardware
> descriptions vs. software description. But the alternative would be that
> we don't describe the PLLs in DT, which would imply that we have to have
> some logic in the driver that either knows which PLLs exist on the given
> SoC and can query their capabilities in order to determine which one to
> use for any given use-case.
> 
> It also means that the driver becomes much less generic, because we have
> to put a lot of SoC specific knowledge into the driver. This is perhaps
> not a big issue for SoCs like Tegra that are very closely integrated
> anyway, but imagine if you take the same approach with IP that can be
> licensed from a third party and therefore could appear in many more
> different combinations.
> 

Having some device-specific configuration in DT isn't a problem if there is a 
machine-specific compatibility property for a device, so that device driver 
could override a broken DT if needed.

> I think having the parent PLL defined in DT is a good compromise. If you
> say that strictly only hardware interfaces can be represented in DT, you
> take away a lot of the flexibility and in turn put a lot of the data
> back into drivers.
> 

Problem is that this flexibility is "written in stone".

For example DT may specify PLL_C as the main parent clock for which clock 
driver seems allow a dynamic clock rate change. The HW configuration in DT 
doesn't make sense in this case, it's a SW configuration which is specific to 
upstream Linux kernel.

> > Moreover PLL isn't a "device" clock, but specifically a "system" clock. So
> > describing it in DT as a "device" clock is wrong to me too.
> > 
> > Putting all together, the PLL's should be left as-is they are now in v2,
> > please let me know if you disagree.
> 
> I don't care very strongly in this case because the driver is unlikely
> to ever be reused anywhere other than on Tegra20. But looking up the
> system clock by a string is not something that is typically encouraged
> because it limits portability.
> 

No, in this case it only increases portability because we won't have to deal 
with unsupported/broken configurations.

On the other hand we could just place the static clocks configuration into the 
DT, because realistically we won't ever have to deal with an unsupported 
configurations. I'll consider this variant for v3.

> > The "emc" clock could be placed in DT since we won't bother with the DT
> > backwards compatibility, I'll change it in the next revision of the
> > patchset.
> Frankly, if you don't have the other clocks in DT there's little sense
> in having the EMC clock in DT.

In any case having the EMC clock in DT would make the DT description more 
consistent.

Thank you very much for the review!


