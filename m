Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58C9208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58C9208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeJAUbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:31:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50371 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728979AbeJAUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:31:40 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w91DnBVN006987;
        Mon, 1 Oct 2018 15:53:25 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mu1bjmf1j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 15:53:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 14B1D31;
        Mon,  1 Oct 2018 13:53:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCC7E4DEF;
        Mon,  1 Oct 2018 13:53:23 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Oct
 2018 15:53:23 +0200
Subject: Re: [PATCH V2 27/27] mmc: mmci: add stm32 sdmmc variant
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-28-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqGY2o7TcUVW9bCZM9-4xtyJJ4PaCtWWQvV3VMd+cK99A@mail.gmail.com>
 <50222b8d-3b53-acea-7935-092fa149d54c@st.com>
 <CAPDyKFr45FF-wbhT7C=+G5ptbCMRiKie304UM9P2vRypKd=PvQ@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <9e64085d-c137-6117-644d-78f796210277@st.com>
Date:   Mon, 1 Oct 2018 15:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr45FF-wbhT7C=+G5ptbCMRiKie304UM9P2vRypKd=PvQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2018 03:39 PM, Ulf Hansson wrote:
> [...]
> 
>>>>    struct variant_data {
>>>>           unsigned int            clkreg;
>>>> @@ -348,6 +350,8 @@ struct variant_data {
>>>>           unsigned int            irq_pio_mask;
>>>>           u32                     start_err;
>>>>           u32                     opendrain;
>>>> +       bool                    dma_lli;
>>>> +       u32                     stm32_idmabsize_mask;
>>>
>>>
>>> What are these?
>>
>>
>> This property is specific for sdmmc variants:
>> sdmmc has a Internal DMA and the number bytes per buffer
>> could be different between sdmmc variants
>> (depend of SDMMC_IDMABSIZER register).
> 
> Okay. Thanks for clarifying.
> 
> Could you please add some information about this in the changelog as well?

OK

> 
> [...]
> 
>>>> +
>>>> +static int _sdmmc_idma_prep_data(struct mmci_host *host,
>>>> +                                struct mmc_data *data)
>>>> +{
>>>> +       int n_elem;
>>>> +
>>>> +       n_elem = dma_map_sg(mmc_dev(host->mmc),
>>>> +                           data->sg,
>>>> +                           data->sg_len,
>>>> +                           mmc_get_dma_dir(data));
>>>> +
>>>> +       if (!n_elem) {
>>>> +               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int sdmmc_idma_prep_data(struct mmci_host *host,
>>>> +                               struct mmc_data *data, bool next)
>>>> +{
>>>> +       /* Check if job is already prepared. */
>>>> +       if (!next && data->host_cookie == host->next_cookie)
>>>> +               return 0;
>>>> +
>>>> +       return _sdmmc_idma_prep_data(host, data);
>>>> +}
>>>> +
>>>> +static void sdmmc_idma_unprep_data(struct mmci_host *host,
>>>> +                                  struct mmc_data *data, int err)
>>>> +{
>>>> +       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>>>> +                    mmc_get_dma_dir(data));
>>>> +}
>>>
>>>
>>> The sdmmc_idma_prep_data() and sdmmc_idma_unprep_data(), seems very
>>> similar to what the mmci core driver needs to do in this regards.
>>>
>>> Can we perhaps avoid adding these callbacks altogether, but rather
>>> rely on common code in the mmci core driver?
>>
>>
>> Actually, these callbacks allow to manage prepare/unprepare of
>> dmaengine interface for mmci variant, (not needed for sdmmc which uses an
>> internal dma).
>>
>> For Sdmmc, today there are no special case, just dma_map/unmap.
>> But in the future, I hope manage the lli list in these callback.
>>
>> Only dma_map/unmap could be common, but the error management may
>> be complicated (in mmci variant).
>>
>> Personally, I prefer keep prep_data/unprep_data mmci_host_ops
>> interfaces.
>> What do you suggest ?
> 
> Okay, let's keep them for now. We can always change things on top, in
> case we see later that those callbacks can be removed.

Okay, that make sense.

> 
> [...]
> 
> Kind regards
> Uffe
> 
