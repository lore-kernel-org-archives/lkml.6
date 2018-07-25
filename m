Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8485C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE2E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE2E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeGYLLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:11:20 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2578 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeGYLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:11:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b584a2e0002>; Wed, 25 Jul 2018 03:00:14 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Jul 2018 03:00:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Jul 2018 03:00:23 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 25 Jul
 2018 10:00:19 +0000
Date:   Wed, 25 Jul 2018 13:00:13 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] mmc: tegra: Set calibration pad voltage reference
Message-ID: <20180725130013.7c86bfea@dhcp-10-21-25-168>
In-Reply-To: <d5018027-f333-8432-f8ed-81a2cdfedea8@kapsi.fi>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
        <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
        <d5018027-f333-8432-f8ed-81a2cdfedea8@kapsi.fi>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 10:08:46 +0300
Mikko Perttunen <cyndis@kapsi.fi> wrote:

> On 24.07.2018 17:34, Aapo Vienamo wrote:
> > Configure the voltage reference used by the automatic pad drive strength
> > calibration procedure. The value is a magic number from the TRM.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >   drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index e40ca43..6008e2f 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -49,6 +49,10 @@
> >   #define SDHCI_AUTO_CAL_START			BIT(31)
> >   #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> >   
> > +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
> > +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
> > +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> > +
> >   #define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
> >   #define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)
> >   
> > @@ -152,7 +156,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
> >   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >   	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> >   	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> > -	u32 misc_ctrl, clk_ctrl;
> > +	u32 misc_ctrl, clk_ctrl, pad_ctrl;
> >   
> >   	sdhci_reset(host, mask);
> >   
> > @@ -193,8 +197,14 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
> >   	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> >   	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
> >   
> > -	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> > +	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB) {
> > +		pad_ctrl = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> > +		pad_ctrl &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK;
> > +		pad_ctrl |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL;
> > +		sdhci_writel(host, pad_ctrl, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> > +  
> 
> Will this happen to only eMMC controllers or for all controllers? My 
> docs are saying this should be set to 0x7 for SDMMC2/4 and 0x1 or 0x2 
> for SDMMC1/3 depending on voltage. Not sure how downstream is 
> programming it, though.

The Tegra210 TRM specifies that VREF_SEL should be set 0x7 for all of
the controllers, there's no mention of this depending on the mode. The
same value is also programmed by the downstream kernels for Tegra210
and Tegra186.

 -Aapo
