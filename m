Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA9AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE81420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CWgZSlDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE81420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbeKTCGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:06:42 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19588 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeKTCGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:06:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf2d9fc0000>; Mon, 19 Nov 2018 07:42:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Nov 2018 07:42:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Nov 2018 07:42:43 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 15:42:42 +0000
Subject: Re: [PATCH v1 0/4] EMC fixes for Tegra30+
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830185404.7224-1-digetx@gmail.com>
 <d1f577d8-a944-35b6-89b3-ce4eafdd4808@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f0045dbb-c19a-cd5e-2e78-4b68ccc2342d@nvidia.com>
Date:   Mon, 19 Nov 2018 15:42:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d1f577d8-a944-35b6-89b3-ce4eafdd4808@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542642172; bh=wsJAAgIaFNXQJMj7CeYIQjN/OT36DzlhDGl6T2Dha1I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CWgZSlDBZAx2ofs23UTdFkld+n0GwxDF4I9Q8zwfHAdzOdEzgj5roRE4OzmKcuFmP
         syJ+UN5/OWJQ8U7dfo3RvZd3uDU9z3oNr9su9ku++e7g8E7/YiwIV5ogbLfyTjN0Ct
         QGTaLTheINne5bILJddqgrVhAi7EiV8mcmcTNVcQtXLp9PviItEABf0BLDorq4fVh6
         TUZ4+f0cCql8oPCKJBDh0QrPxHp18Jqrq5sk8VEu1/WFHVMSJWsKZ69cXp1jvrts1Z
         nGWc/Bdr3OkrHwHuNi8CzFi2ygzdUZSLJ4gBxhTj7/4uC93+wLuLWePv4650mmiE7I
         PfjGFogMSrRDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/11/2018 22:06, Dmitry Osipenko wrote:
> On 30.08.2018 21:54, Dmitry Osipenko wrote:
>> Hello,
>>
>> This patch series fixes couple bugs in the memory self-refresh code.
>> The EMC / MC state is properly restored after patches being applied,
>> please review.
>>
>> Dmitry Osipenko (4):
>>   ARM: tegra: Fix missed EMC registers latching on resume from LP1 on
>>     Tegra30+
>>   ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on
>>     Tegra30
>>   ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+
>>   ARM: tegra: Clear EMC interrupts on resume from LP1 on Tegra30+
>>
>>  arch/arm/mach-tegra/iomap.h         |  9 ++++++++
>>  arch/arm/mach-tegra/sleep-tegra30.S | 32 +++++++++++++++++++++++++++--
>>  2 files changed, 39 insertions(+), 2 deletions(-)
>>
> 
> Hello Jon,
> 
> Could you please test these patches using your testing setup? Will be awesome if you could give t-b/r-b to the series, then there should be a better chance that Thierry could apply it eventually ;)

Yes I will give them a test and let you know.

Cheers
Jon

-- 
nvpublic
