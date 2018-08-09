Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FF6216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FF6216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeHIO1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:27:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14937 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:27:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6c2d4c0000>; Thu, 09 Aug 2018 05:02:20 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Aug 2018 05:02:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Aug 2018 05:02:35 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Aug
 2018 12:02:32 +0000
Date:   Thu, 9 Aug 2018 15:02:26 +0300
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
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
Message-ID: <20180809150226.64657f56@dhcp-10-21-25-168>
In-Reply-To: <20180809114922.GN21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
        <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
        <20180809114922.GN21639@ulmo>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2018 13:49:22 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
> > Add the HS400 DQS trim value for Tegra186 SDMMC4.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > index 6e9ef26..9e07bc6 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > @@ -313,6 +313,7 @@
> >  		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
> >  		nvidia,default-tap = <0x5>;
> >  		nvidia,default-trim = <0x9>;
> > +		nvidia,dqs-trim = <63>;
> >  		status = "disabled";
> >  	};
> >    
> 
> Isn't this technically dependent on the board layout and as such would
> belong in the board DTS file? Or does this value work on all existing
> Tegra186 platforms?

This value is specified as part of the controller initialization
sequence in the TRM. I've understood that this (and other tap and trim)
value(s) are used for compensating the propagation delay differences
that are caused by the internal SoC layout.

 -Aapo
