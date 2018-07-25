Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CB320671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CB320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeGYJXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:23:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10285 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeGYJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:23:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5831170000>; Wed, 25 Jul 2018 01:13:11 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Jul 2018 01:13:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Jul 2018 01:13:08 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 25 Jul
 2018 08:13:05 +0000
Date:   Wed, 25 Jul 2018 11:12:59 +0300
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
Subject: Re: [PATCH 7/7] arm64: dts: tegra210-p2597: Remove no-1-8-v from
 sdmmc1
Message-ID: <20180725111259.223970b5@dhcp-10-21-25-168>
In-Reply-To: <8946636e-5da7-baf1-5390-669f7442e6ff@kapsi.fi>
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
        <1532090746-15863-8-git-send-email-avienamo@nvidia.com>
        <8946636e-5da7-baf1-5390-669f7442e6ff@kapsi.fi>
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

On Wed, 25 Jul 2018 09:58:37 +0300
Mikko Perttunen <cyndis@kapsi.fi> wrote:

> Looks like patch 6 will probably cause tegra-sdhci to start advertising 
> faster modes (see " if (!IS_ERR(host->mmc->supply.vqmmc))" in 
> sdhci-tegra.c). With that patch and this, will the SDHCI core start to 
> try putting us into these higher modes? Clearly that won't work yet 
> before the upcoming patches.

The SDHCI core won't do that yet at this point. The host capability bits
for the higher speed modes are currently masked by tegra_sdhci_reset()
in sdhci-tegra. The modes are unmasked in another patch after everything
that's required to support the modes has been implemented.

 -Aapo
