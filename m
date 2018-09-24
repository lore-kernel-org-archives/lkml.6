Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2968ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF202086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF202086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeIXWR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:17:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33227 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730755AbeIXWR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:17:26 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8OG8m57008559;
        Mon, 24 Sep 2018 18:12:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mnav5c2ux-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Sep 2018 18:12:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16F9631;
        Mon, 24 Sep 2018 16:12:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E377EAA9D;
        Mon, 24 Sep 2018 16:12:45 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.51) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 24 Sep
 2018 18:12:45 +0200
Subject: Re: [PATCH V2 03/27] mmc: mmci: convert dma_setup callback to return
 an int
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
 <1537523181-14578-4-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <15c31e3b-646a-f5db-b45a-3e2f556d9fd5@st.com>
Date:   Mon, 24 Sep 2018 18:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 09/24/2018 04:28 PM, Ulf Hansson wrote:
> On 21 September 2018 at 11:45, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch converts dma_setup callback to return an integer
>> This patch is needed to prepare sdmmc variant with internal dma
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c          | 14 ++++++++++----
>>   drivers/mmc/host/mmci.h          |  2 +-
>>   drivers/mmc/host/mmci_qcom_dml.c |  6 ++++--
>>   3 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index cbd67bc..2f845f3 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -415,7 +415,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>>    * no custom DMA interfaces are supported.
>>    */
>>   #ifdef CONFIG_DMA_ENGINE
>> -static void mmci_dma_setup(struct mmci_host *host)
>> +static int mmci_dma_setup(struct mmci_host *host)
>>   {
>>          const char *rxname, *txname;
>>
>> @@ -466,7 +466,9 @@ static void mmci_dma_setup(struct mmci_host *host)
>>          }
>>
>>          if (host->ops && host->ops->dma_setup)
>> -               host->ops->dma_setup(host);
>> +               return host->ops->dma_setup(host);
>> +
> 
> Looks like you need to implement a error handling, instead of just
> returning the error code.

yes, today if a dma_setup is defined, we can't fallback to pio mode.
A use_dma variable (defined in mmci_host) could be setted follow the 
return code of ops->dma_setup

example:

void mmci_dma_setup(struct mmci_host *host)
{
	int err;

	if (!host->ops || !host->ops->dma_setup)
		return;

	err = host->ops->dma_setup(host);
	if (err)
		return;
	
	host->use_dma = true;
	
	/* initialize pre request cookie */
	host->next_cookie = 1;
}

use_dma variable could be check by mmci_host_ops variant functions.

are you agree with this proposal?

> 
>> +       return 0;
>>   }
>>
>>   /*
>> @@ -741,8 +743,10 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>>   static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>>   {
>>   }
>> -static inline void mmci_dma_setup(struct mmci_host *host)
>> +
>> +static inline int mmci_dma_setup(struct mmci_host *host)
>>   {
>> +       return 0;
>>   }
>>
>>   static inline void mmci_dma_release(struct mmci_host *host)
>> @@ -1796,7 +1800,9 @@ static int mmci_probe(struct amba_device *dev,
>>                   amba_rev(dev), (unsigned long long)dev->res.start,
>>                   dev->irq[0], dev->irq[1]);
>>
>> -       mmci_dma_setup(host);
>> +       ret = mmci_dma_setup(host);
>> +       if (ret)
>> +               goto clk_disable;
>>
>>          pm_runtime_set_autosuspend_delay(&dev->dev, 50);
>>          pm_runtime_use_autosuspend(&dev->dev);
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 21aaf9a..06299ac 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -273,7 +273,7 @@ struct variant_data {
>>
>>   /* mmci variant callbacks */
>>   struct mmci_host_ops {
>> -       void (*dma_setup)(struct mmci_host *host);
>> +       int (*dma_setup)(struct mmci_host *host);
>>   };
>>
>>   struct mmci_host_next {
>> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
>> index be3fab5..1bb59cf 100644
>> --- a/drivers/mmc/host/mmci_qcom_dml.c
>> +++ b/drivers/mmc/host/mmci_qcom_dml.c
>> @@ -119,7 +119,7 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>>   }
>>
>>   /* Initialize the dml hardware connected to SD Card controller */
>> -static void qcom_dma_setup(struct mmci_host *host)
>> +static int qcom_dma_setup(struct mmci_host *host)
>>   {
>>          u32 config;
>>          void __iomem *base;
>> @@ -131,7 +131,7 @@ static void qcom_dma_setup(struct mmci_host *host)
>>
>>          if (producer_id < 0 || consumer_id < 0) {
>>                  host->variant->qcom_dml = false;
> 
> It seems like the existing code is an attempt to fallback to use pio
> mode. However, I doubt it works as is.

oops, I seen that like a variant identification issue, so if it's a
fallback to pio mode it doesn't work.

> 
>> -               return;
>> +               return -EINVAL;
> 
> My point is, if you return an error code here, it means that the error
> code becomes propagated and ->probe() will fail.
> 
> Ideally, we should be able fall back to pio mode when dma doesn't
> work. I have looped in Srinivas who implemented the qcom dml support,
> let's see if he can explains the intent with the code.
> 
> I also volunteer to help out running some tests on the 410c platform,
> however allow me a day or two to do that.

yes, I would be more reassured

> 
>>          }
>>
>>          base = host->base + DML_OFFSET;
>> @@ -175,6 +175,8 @@ static void qcom_dma_setup(struct mmci_host *host)
>>
>>          /* Make sure dml initialization is finished */
>>          mb();
>> +
>> +       return 0;
>>   }
>>
>>   static struct mmci_host_ops qcom_variant_ops = {
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
