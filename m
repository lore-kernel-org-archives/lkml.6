Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98230C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D66C2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfBYKtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:49:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29348 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbfBYKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:49:19 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PAkgUo024029;
        Mon, 25 Feb 2019 11:48:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6chp8w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Feb 2019 11:48:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C9FD3F;
        Mon, 25 Feb 2019 10:48:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BE202867;
        Mon, 25 Feb 2019 10:48:58 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Feb
 2019 11:48:57 +0100
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
 <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
 <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com>
 <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
Date:   Mon, 25 Feb 2019 11:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Russell & Ulf

On 2/21/19 3:03 PM, Russell King - ARM Linux admin wrote:
> On Thu, Feb 21, 2019 at 02:38:36PM +0100, Ludovic BARRE wrote:
>> hi Russell & Ulf
>>
>> On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
>>> On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
>>>> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
>>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>>
>>>>> This patch series introduces a bitmap of hardware quirks that require
>>>>> some special action. This should reduce the number of boolean
>>>>> into variant structure.
>>>>> And adds quirk bit to define sdmmc specific transfer modes.
>>>>
>>>> Please find some other way to deal with these differences.  As far as
>>>> I'm concerned, introducing a quirk bitmask such as what was done in
>>>> sdhci is a complete disaster and leads to long-term maintanability
>>>> problems.
>>>>
>>>> We already have a way to deal with variants in mmci.
>>>
>>> ... to finish what I was saying ...
>>>
>>> and I think that:
>>>
>>>           if (variant->blksz_datactrl16)
>>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
>>>           else if (variant->blksz_datactrl4)
>>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
>>>           else
>>>                   datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
>>>
>>> ought to become a variant function call which returns the appropriate
>>> datactrl value.  This would shrink the amount of variant testing in this
>>> path, and also means that going forward we aren't facing an endlessly
>>> increasing number of tests here.
>>
>> For blksz_datactrl case:
>> We could create an inline function for datactrl16 and blksz_datactrl4
>> which returns the appropriate datactrl value (specific for ux500v2 and
>> qcom). This function could be register in mmci_host_ops structure.
> 
> Yes, this is what I'm proposing (except for the "inline" bit which
> seems meaningless if it's called via the mmci_host_ops structure.)
> I'm also proposing that it shouldn't just be the blksz that's
> returned but anything that the variant needs to take account of,
> including the stm transfer mode.

Ulf, are you alright with this callback approach (just to be sure that 
every body is align, before send a patch)?

This mmci_host_ops callback could return datactrl config to
start data (defined by variant).

> 
>> in mmci_start_data function we could call a common function which call a
>> hook if defined.
>>
>> int mmci_dblksz(struct mmci_host *host)
> 
> As this is returning a register value, "u32" would be more appropriate
> than "int".
> 
>> {
>> 	if (host->ops && host->ops->dblksz)
>> 		return host->ops->dblk(host);
>>
>> 	/* default data block size definition */
>> 	blksz_bits = ffs(data->blksz) - 1;
>> 	return blksz_bits << 4;
>> }
>>
>> what do you think about it?
> 
> I don't see any reason not to make the call unconditional and have every
> variant supply an appropriate function pointer.  IMHO that keeps stuff
> cleaner.
> 
>> After, I'm afraid to multiply callback function in mmci_host_ops.
>>
>> For stm32 transfer mode:
>> ditto, a callback function or I keep a boolean?
>>
>> BR
>> Ludo
>>
>>>
>>>>
>>>>>
>>>>> Ludovic Barre (2):
>>>>>     mmc: mmci: introduce a quirks property into variant struct
>>>>>     mmc: mmci: add quirk property to add stm32 transfer mode
>>>>>
>>>>>    drivers/mmc/host/mmci.c | 11 +++++++++++
>>>>>    drivers/mmc/host/mmci.h |  9 +++++++++
>>>>>    2 files changed, 20 insertions(+)
>>>>>
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>>
>>>> -- 
>>>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>>>> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
>>>> According to speedtest.net: 11.9Mbps down 500kbps up
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>
> 
