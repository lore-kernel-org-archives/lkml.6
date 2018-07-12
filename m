Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C50E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C50E20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGLJSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:18:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43186 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbeGLJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:18:41 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6C99Tee000889;
        Thu, 12 Jul 2018 11:09:35 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k5k3443hv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Jul 2018 11:09:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58F4B31;
        Thu, 12 Jul 2018 09:09:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20FF225FD;
        Thu, 12 Jul 2018 09:09:34 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 11:09:32 +0200
Subject: Re: [PATCH 01/19] mmc: mmci: regroup and define dma operations
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpt5HUeUqaoS9icDodM+r64jB9vQ=zTecO0tuBv=TtOXg@mail.gmail.com>
 <d93e6886-1dee-7915-459f-466a54d0c242@st.com>
 <CAPDyKFo0q5Yps1whPmaUQJAV3tXx91WPmxtMF_ov43qP=djQfg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <f407426c-766c-c46f-85cd-7bf76bcab554@st.com>
Date:   Thu, 12 Jul 2018 11:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo0q5Yps1whPmaUQJAV3tXx91WPmxtMF_ov43qP=djQfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2018 02:16 PM, Ulf Hansson wrote:
> On 11 July 2018 at 11:41, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>>
>> On 07/05/2018 05:17 PM, Ulf Hansson wrote:
>>>
>>> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> Prepare mmci driver to manage dma interface by new property.
>>>> This patch defines and regroups dma operations for mmci drivers.
>>>> mmci_dma_XX prototypes are added to call member of mmci_dma_ops
>>>> if not null. Based on legacy need, a mmci dma interface has been
>>>> defined with:
>>>> -mmci_dma_setup
>>>> -mmci_dma_release
>>>> -mmci_dma_pre_req
>>>> -mmci_dma_start
>>>> -mmci_dma_finalize
>>>> -mmci_dma_post_req
>>>> -mmci_dma_error
>>>> -mmci_dma_get_next_data
>>>
>>>
>>> As I suggested for one of the other patches, I would rather turn core
>>> mmci functions into library functions, which can be either invoked
>>> from variant callbacks or assigned directly to them.
>>>
>>> In other words, I would leave the functions that you move in this
>>> patch to stay in mmci.c. Although some needs to be re-factored and we
>>> also needs to make some of them available to be called from another
>>> file, hence the functions needs to be shared via mmci.h rather than
>>> being declared static.
>>
>>
>> In previous exchange mail "STM32MP1 SDMMC driver review"
>> we are said:
>>
>>>>> -dma variant à should fit in Qualcomm implementation, reuse (rename)
>>>>> mmci_qcom_dml.c file and integrate ST dma in.
> 
> Apologize if I may have lead you in a wrong direction, that was not my intent.
> 
> However, by looking at $subject patch, your seems to be unnecessarily
> shuffling code around. I would like to avoid that.
> 
>>>>
>>>> stm32 sdmmc has an internal dma, no need to use dmaengine API;
>>>> So some modifications in mmci (pre/post request, mmci_dma_xx). perhaps
>>>> should be done with an ops or not.
>>>
>>> Yes.
>>>
>>> The Qualcomm variant is also using an internal DMA, hence I thought
>>> there may be something we could re-use, or at least have some new
>>> common ops for.
>>
>> It's not crystal clear for me.
>> Do you always agree with a dma ops which allow to address different
>> DMA transfer:
>> -with dmaengine API
>> -sdmmc idma, without dmaengine API
>> -...
> 
> If we can use a mmci ops callback to manage the variant differences,
> that would be perfect. That combined with making the existing DMA
> functions in mmci.c converted to "library" functions, which the mmci
> ops callbacks can call, in order to re-use code.
> 
> When that isn't really suitable, we may need to add a "quirk" instead,
> which would be specific for that particular variant. Along the lines
> of what we already do for variant specifics inside mmci.c.
> 
> I think we have to decide on case by case basis, what fits best.
> 
> Hope this makes a better explanation. If not, please tell, and I can
> take an initial stab and post a patch to show you with code how I mean
> to move forward.
> 
>>
>>
>>>
>>> Let me take a concrete example on how I would move forward, hopefully
>>> that explains it a bit better. Please see below.
>>>
>>> [...]
>>>
>>>> -/*
>>>> - * All the DMA operation mode stuff goes inside this ifdef.
>>>> - * This assumes that you have a generic DMA device interface,
>>>> - * no custom DMA interfaces are supported.
>>>> - */
>>>> -#ifdef CONFIG_DMA_ENGINE
>>>> -static void mmci_dma_setup(struct mmci_host *host)
>>>> -{
>>>> -       const char *rxname, *txname;
>>>> -       struct variant_data *variant = host->variant;
>>>> -
>>>> -       host->dma_rx_channel =
>>>> dma_request_slave_channel(mmc_dev(host->mmc), "rx");
>>>> -       host->dma_tx_channel =
>>>> dma_request_slave_channel(mmc_dev(host->mmc), "tx");
>>>> -
>>>> -       /* initialize pre request cookie */
>>>> -       host->next_data.cookie = 1;
>>>> -
>>>> -       /*
>>>> -        * If only an RX channel is specified, the driver will
>>>> -        * attempt to use it bidirectionally, however if it is
>>>> -        * is specified but cannot be located, DMA will be disabled.
>>>> -        */
>>>> -       if (host->dma_rx_channel && !host->dma_tx_channel)
>>>> -               host->dma_tx_channel = host->dma_rx_channel;
>>>> -
>>>> -       if (host->dma_rx_channel)
>>>> -               rxname = dma_chan_name(host->dma_rx_channel);
>>>> -       else
>>>> -               rxname = "none";
>>>> -
>>>> -       if (host->dma_tx_channel)
>>>> -               txname = dma_chan_name(host->dma_tx_channel);
>>>> -       else
>>>> -               txname = "none";
>>>> -
>>>> -       dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
>>>> -                rxname, txname);
>>>> -
>>>> -       /*
>>>> -        * Limit the maximum segment size in any SG entry according to
>>>> -        * the parameters of the DMA engine device.
>>>> -        */
>>>> -       if (host->dma_tx_channel) {
>>>> -               struct device *dev = host->dma_tx_channel->device->dev;
>>>> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
>>>> -
>>>> -               if (max_seg_size < host->mmc->max_seg_size)
>>>> -                       host->mmc->max_seg_size = max_seg_size;
>>>> -       }
>>>> -       if (host->dma_rx_channel) {
>>>> -               struct device *dev = host->dma_rx_channel->device->dev;
>>>> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
>>>> -
>>>> -               if (max_seg_size < host->mmc->max_seg_size)
>>>> -                       host->mmc->max_seg_size = max_seg_size;
>>>> -       }
>>>
>>>
>>> Everything above shall be left as generic library function,
>>> mmci_dma_setup() and I would share it via mmci.h and thus change it
>>> from being static.
>>>
>>
>> each interfaces mmci_dma_XXX have very different needs depending
>> dma_ops (legacy, sdmmc idma)
> 
> Right. This was just one example.
> 
> If I understand, what you are suggesting is to make all of them being
> variant specific callbacks, so I assume that would solve the problems.
> Just to be clear, I have no problem with that.
> 
> Although, that doesn't mean we can't re-use existing dma functions in
> mmci.c, when that makes sense.

Yes, when examine dmaengine_XX ops and sdmmc_idma_XX ops (in patch 01
and 17) there are few common piece of code. So I think we will have same
dma functions pointer in mmci_ops. However, the cookie management may be
shared

> 
> [...]
> 
> Kind regards
> Uffe
> 
