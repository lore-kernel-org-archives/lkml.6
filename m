Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3457BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB402082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405032AbfAPPrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:47:22 -0500
Received: from muru.com ([72.249.23.125]:33916 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfAPPrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:47:22 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F2A958030;
        Wed, 16 Jan 2019 15:47:27 +0000 (UTC)
Date:   Wed, 16 Jan 2019 07:47:18 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Message-ID: <20190116154717.GQ5544@atomide.com>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
 <20190116132747.GB11050@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116132747.GB11050@ulmo>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thierry Reding <thierry.reding@gmail.com> [190116 13:28]:
> On Tue, Jan 15, 2019 at 05:28:36PM +0100, Thomas Petazzoni wrote:
> > The SDHCI core is know properly checking for the state of a WP GPIO,
> 
> "know" -> "now"
> 
> > so there is no longer any need for the sdhci-omap code to implement
> > ->get_ro() using mmc_gpio_get_ro().
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > ---
> > Note: this patch has only been compiled tested, as I don't have the
> > hardware to test it.
> > ---
> >  drivers/mmc/host/sdhci-omap.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> I can't runtime test this myself, but it certainly looks like this would
> do the right thing because it calls the core now call the very same
> function as this used to, so:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 
> Adding Tony and linux-omap for a slightly wider audience and hopefully
> find someone to test this on. For reference, the whole series is here:
> 
> 	https://patchwork.kernel.org/project/linux-mmc/list/?series=66905

Thanks Kishon can you please review and test?

Regards,

Tony

> > diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> > index d264391616f9..c2a28930086f 100644
> > --- a/drivers/mmc/host/sdhci-omap.c
> > +++ b/drivers/mmc/host/sdhci-omap.c
> > @@ -987,7 +987,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >  		goto err_put_sync;
> >  	}
> >  
> > -	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
> >  	host->mmc_host_ops.start_signal_voltage_switch =
> >  					sdhci_omap_start_signal_voltage_switch;
> >  	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
> > -- 
> > 2.20.1
> > 


