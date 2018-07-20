Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6D4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A79206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A79206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeGTItM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:49:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9465 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeGTItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:49:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5197080000>; Fri, 20 Jul 2018 01:02:16 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 20 Jul 2018 01:02:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Jul 2018 01:02:05 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 20 Jul
 2018 08:02:06 +0000
Subject: Re: [PATCH v1] memory: tegra: Don't invoke Tegra30+ specific memory
 timing setup on Tegra20
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180719132453.16860-1-digetx@gmail.com>
 <39607791-3e71-7784-37db-4e05a316d7a8@nvidia.com>
 <31916977.CHrX6e343J@dimapc>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b0403eb2-2494-1924-dbe6-7a6019b6364d@nvidia.com>
Date:   Fri, 20 Jul 2018 09:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <31916977.CHrX6e343J@dimapc>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/07/18 16:38, Dmitry Osipenko wrote:
> On Thursday, 19 July 2018 18:30:48 MSK Jon Hunter wrote:
>> On 19/07/18 14:24, Dmitry Osipenko wrote:
>>> This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
>>> timings for RAM code 0 registered" warning message during of kernels
>>> boot-up on Tegra20.
>>
>> Looking at the tegra20-emc.txt bindings doc [0], the 'nvidia,ram-code'
>> property is also valid for Tegra20. In fact, I see this warning on the
>> Tegra30 Cardhu because this property is not populated. So I think that
>> this warning is valid and harmless.
>>
>> Cheers
>> Jon
>>
>> [0] Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
> 
> That is the irrelevant binding, the relevant one for this driver is [0]. The 
> warning is valid for T30+, but not for T20.
> 
> [0] Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt

Yes indeed, looks like we never supported this for Tegra20. OK, fine with me
I guess this was introduced during the consolidation of the MC drivers. Can
you add the appropriate fixes tag?

Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
