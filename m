Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264742087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264742087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeIYNPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:15:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39099 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbeIYNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:15:06 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8P74UZQ023558;
        Tue, 25 Sep 2018 09:08:15 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mqd478xnw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 09:08:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F4863F;
        Tue, 25 Sep 2018 07:08:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 639D024C3;
        Tue, 25 Sep 2018 07:08:13 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.50) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 25 Sep
 2018 09:08:13 +0200
Subject: Re: [PATCH V2 05/27] mmc: mmci: move mmci next cookie to mci host
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
 <1537523181-14578-6-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqhyVrRGRraGQzx9kwRxLtr56Gwc_NKqNqwLvZuM=jM1A@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <87fd1322-a8bc-15cc-8f91-3cf19043a2ca@st.com>
Date:   Tue, 25 Sep 2018 09:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqhyVrRGRraGQzx9kwRxLtr56Gwc_NKqNqwLvZuM=jM1A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/24/2018 08:46 PM, Ulf Hansson wrote:
> On 21 September 2018 at 11:45, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch moves next cookie to mmci host structure to
>> share same cookie management between all variants.
> 
> I would suggest you to squash this with patch4, as I think it makes
> more sense to keep these changes together.

ok

> 
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 10 ++++------
>>   drivers/mmc/host/mmci.h |  2 ++
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 6de7c8d..43f2a1a 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -418,7 +418,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>>   struct mmci_dmae_next {
>>          struct dma_async_tx_descriptor *desc;
>>          struct dma_chan *chan;
>> -       s32 cookie;
>>   };
>>
>>   struct mmci_dmae_priv {
>> @@ -449,7 +448,7 @@ static int mmci_dma_setup(struct mmci_host *host)
>>                                                       "tx");
>>
>>          /* initialize pre request cookie */
>> -       dmae->next_data.cookie = 1;
>> +       host->next_cookie = 1;
>>
>>          /*
>>           * If only an RX channel is specified, the driver will
>> @@ -716,7 +715,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>>          struct mmci_dmae_priv *dmae = host->dma_priv;
>>          struct mmci_dmae_next *next = &dmae->next_data;
>>
>> -       WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
>> +       WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
>>          WARN_ON(!data->host_cookie && (next->desc || next->chan));
>>
>>          dmae->desc_current = next->desc;
>> @@ -728,9 +727,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>>   static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>   {
>>          struct mmci_host *host = mmc_priv(mmc);
>> -       struct mmci_dmae_priv *dmae = host->dma_priv;
>>          struct mmc_data *data = mrq->data;
>> -       struct mmci_dmae_next *nd = &dmae->next_data;
>>
>>          if (!data)
>>                  return;
>> @@ -741,7 +738,8 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>                  return;
>>
>>          if (!mmci_dma_prep_next(host, data))
>> -               data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
>> +               data->host_cookie = ++host->next_cookie < 0 ?
>> +                       1 : host->next_cookie;
>>   }
>>
>>   static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 1e9a45b..5bb1ce2 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -318,5 +318,7 @@ struct mmci_host {
>>          int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
>>
>>          void                    *dma_priv;
>> +
>> +       s32                     next_cookie;
>>   };
>>
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
