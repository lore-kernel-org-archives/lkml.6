Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3A920873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bweiKNkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3A920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeKZVHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:07:41 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14620 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:07:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfbc76b0004>; Mon, 26 Nov 2018 02:14:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 26 Nov 2018 02:14:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 26 Nov 2018 02:14:02 -0800
Received: from [10.26.11.165] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 26 Nov
 2018 10:13:59 +0000
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7d433094-4797-9bff-ba7b-325a706882c6@nvidia.com>
Date:   Mon, 26 Nov 2018 10:13:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123164827.GE53235@atomide.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543227244; bh=4e269GsUd7HKpDB9juxIiM2TtLZaEZ0ZpaBeZtzBYwU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bweiKNkvzlxv6SjYR4JySVMukfuRkk0G2cBADiaaKEkxePGJAIe1T2TomMZlwNsR2
         iOS/nrYgDhYYgmNb0wc4xsW2bCEUIQt8LoVuG2be6PblaTQtDaHViBYXwgLBTfeVzY
         8Yh/QJaeFciKUYyD0TybUu6moJpDUIb0bgBeO30CFv8UByELgwvtnww3fP4XvjqySn
         OIwuKy6THPKeJf+TtBUREuB3XzGSimdLEQmjgl73/J5CzJWkYGb4gS4m0t41NpxWCt
         9UnJ0m2RJhXXzOE1KaRlzQTjm3AIAAdyj+jDsdEmUQ9MP0m+TF1U3xEvtiBnU0mYUe
         WFjBy1prtQ7kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/11/2018 16:48, Tony Lindgren wrote:
> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
>> On 19/11/2018 17:14, Tony Lindgren wrote:
>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>>
>> Yes Tegra can invert the polarity of the PMIC interrupt.
> 
> So is there some IP on Tegra called "Tegra PMC" that is
> inverting the interrupt? Or is the "Tegra PMC" that commit
> 7e9d474954f4 mentions just the palmas configuration for
> inverting the interrupt?
> 
> The problem I'm having is With omap5 where I can only get the
> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
> Tegra.

I see what you are saying and so technically we should not need to
invert with the Tegra PMC as well. This PMIC is used on the Tegra114
Dalmore board which was where I saw the original problem. However, I
have not tested this board for a while (and not part of our current
nightly testing). Do you know if something has changed recently?

Cheers
Jon

-- 
nvpublic
