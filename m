Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D2C208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D2C208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeGPUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:16:04 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2469 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeGPUQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:16:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4cf60b0000>; Mon, 16 Jul 2018 12:46:19 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 16 Jul 2018 12:47:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 16 Jul 2018 12:47:09 -0700
Received: from [10.26.11.196] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Jul
 2018 19:47:05 +0000
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
To:     Aapo Vienamo <avienamo@nvidia.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
 <6af41450-4770-3b2d-05b8-914f90743a7e@nvidia.com>
 <20180713183925.67d7d5f4@dhcp-10-21-25-168>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <39421023-0354-2af5-0a29-2299321a4259@nvidia.com>
Date:   Mon, 16 Jul 2018 20:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713183925.67d7d5f4@dhcp-10-21-25-168>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/07/18 16:39, Aapo Vienamo wrote:

...

>>> that it returns the current clock rate of the host instead of the
>>> maximum one, which can lead to unnecessarily small clock rates.
>>>
>>> This differs from the previous implementation of
>>> tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.  
>>
>> Why?
> 
> As far as I can tell the original tegra_sdhci_get_max_clock() was
> implemented this way in order to force sdhci_calc_clk() to always set
> the SDHCI clock divider to two on sdhci_set_clock(). The requirement to
> configure the SDHCI divider to two is specific to DDR50/52 modes on
> Tegra.
> 
> The .get_max_clock() callback retuning half of the actual maximum will
> result in HS200 and HS400 modes not being able to run at full speed.
> Another mechanism to enforce the divider requirement has to be figured
> out in order to enable DDR50/52 modes on Tegra SoCs.

OK, thanks. Ah I see Stefan's patch for doubling the clock. OK so that's fine.

Cheers
Jon

-- 
nvpublic
