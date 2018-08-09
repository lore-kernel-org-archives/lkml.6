Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA03DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EDF21E20
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EDF21E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeHIQbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:31:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19877 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731222AbeHIQbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:31:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6c4a470001>; Thu, 09 Aug 2018 07:05:59 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Aug 2018 07:06:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Aug 2018 07:06:12 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Aug
 2018 14:06:09 +0000
Date:   Thu, 9 Aug 2018 17:06:04 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Message-ID: <20180809170604.4353fe1b@dhcp-10-21-25-168>
In-Reply-To: <20180809134648.GD21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
        <20180809113609.GI21639@ulmo>
        <20180809144515.06089abe@dhcp-10-21-25-168>
        <20180809134648.GD21639@ulmo>
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

On Thu, 9 Aug 2018 15:46:48 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Thu, Aug 09, 2018 at 02:45:15PM +0300, Aapo Vienamo wrote:
> > On Thu, 9 Aug 2018 13:36:09 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >   
> > > On Tue, Aug 07, 2018 at 04:59:57PM +0300, Aapo Vienamo wrote:  
> > > > Document HS400 DQS trim value device tree property.
> > > > 
> > > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > > index 3c7960a..7d294f3 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > > @@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
> > > >    trimmer value for non-tunable modes.
> > > >  - nvidia,default-trim : Specify the default outbound clock trimmer
> > > >    value.
> > > > +- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> > > >  
> > > >    Notes on the pad calibration pull up and pulldown offset values:
> > > >      - The property values are drive codes which are programmed into the
> > > > @@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
> > > >      - The values are programmed to the Vendor Clock Control Register.
> > > >        Please refer to the reference manual of the SoC for correct
> > > >        values.
> > > > +    - The DQS trim values are only used on controllers which support
> > > > +      HS400 timing.    
> > > 
> > > One of these additions says "DQS trim values", the other says "DQS trim
> > > value". It is unclear from the above how many values there are. I think
> > > this should be more explicit. Also, I don't see why the note about which
> > > controllers the DQS trim value(s) applies to is in a separate paragraph.
> > > Couldn't it be moved to the property description?  
> > 
> > It's a single value. The plural form is a mistake.
> >   
> > > Also, I think the bindings should specify which generations of Tegra do
> > > support HS400. Where else are people supposed to find that information?  
> > 
> > This property is under the "Optional properties for Tegra210 and
> > Tegra186" section and it only applies for the said generations.  
> 
> What's the point of specifying that they are only used on controllers
> which support HS400? Are you saying that only a subset of the SDHCI
> controllers on Tegra210 and Tegra186 support HS400?

Yes, on Tegra210 and Tegra186 only SDMMC4 supports HS400.

 -Aapo
