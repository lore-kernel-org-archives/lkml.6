Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2697FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C467520878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C467520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbeGKMYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:24:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58873 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbeGKMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:24:32 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6BCJN0v029335;
        Wed, 11 Jul 2018 14:19:59 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k5hm282da-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 11 Jul 2018 14:19:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 797E911E;
        Wed, 11 Jul 2018 12:19:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 549332A95;
        Wed, 11 Jul 2018 12:19:41 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 14:19:40 +0200
Subject: Re: [PATCH 05/19] mmc: mmci: allow to overwrite clock/power procedure
 to specific variant
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
 <1528809280-31116-6-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpwVMX9LoC_abHm09UNhLse8MJBUpCCHkR8NnK7fOU5Yg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <973d98c5-b5c7-d1c4-1b20-b6a77500adc3@st.com>
Date:   Wed, 11 Jul 2018 14:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpwVMX9LoC_abHm09UNhLse8MJBUpCCHkR8NnK7fOU5Yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2018 03:48 PM, Ulf Hansson wrote:
> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> A specific variant could have different power or clock procedures.
>> This patch allows to overwrite the default mmci_set_clkreg and
>> mmci_set_pwrreg for a specific variant.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 96 +++++++++++++++++++++++++++++--------------------
>>   drivers/mmc/host/mmci.h |  7 ++++
>>   2 files changed, 64 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index ede95b7..801c86b 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -374,6 +374,52 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
>>          mmci_write_clkreg(host, clk);
>>   }
>>
>> +static void mmci_set_pwrreg(struct mmci_host *host, unsigned char power_mode,
>> +                           unsigned int pwr)
>> +{
>> +       struct variant_data *variant = host->variant;
>> +       struct mmc_host *mmc = host->mmc;
>> +
>> +       switch (power_mode) {
>> +       case MMC_POWER_OFF:
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>> +
>> +               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
>> +                       regulator_disable(mmc->supply.vqmmc);
>> +                       host->vqmmc_enabled = false;
>> +               }
>> +
>> +               break;
>> +       case MMC_POWER_UP:
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
>> +                                             mmc->ios.vdd);
>> +
>> +               /*
>> +                * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
>> +                * and instead uses MCI_PWR_ON so apply whatever value is
>> +                * configured in the variant data.
>> +                */
>> +               pwr |= variant->pwrreg_powerup;
>> +
>> +               break;
>> +       case MMC_POWER_ON:
>> +               if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
>> +                       if (regulator_enable(mmc->supply.vqmmc) < 0)
>> +                               dev_err(mmc_dev(mmc),
>> +                                       "failed to enable vqmmc regulator\n");
>> +                       else
>> +                               host->vqmmc_enabled = true;
>> +               }
>> +
>> +               pwr |= MCI_PWR_ON;
>> +               break;
>> +       }
>> +
>> +       mmci_write_pwrreg(host, pwr);
>> +}
>> +
>>   static void
>>   mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>>   {
>> @@ -1031,7 +1077,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>   {
>>          struct mmci_host *host = mmc_priv(mmc);
>>          struct variant_data *variant = host->variant;
>> -       u32 pwr = 0;
>> +       unsigned int pwr = 0;
> 
> ?

yes not needed
rewritten due to re-factoring

> 
>>          unsigned long flags;
>>          int ret;
>>
>> @@ -1039,42 +1085,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                  host->plat->ios_handler(mmc_dev(mmc), ios))
>>                          dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
>>
>> -       switch (ios->power_mode) {
>> -       case MMC_POWER_OFF:
>> -               if (!IS_ERR(mmc->supply.vmmc))
>> -                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>> -
>> -               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
>> -                       regulator_disable(mmc->supply.vqmmc);
>> -                       host->vqmmc_enabled = false;
>> -               }
>> -
>> -               break;
>> -       case MMC_POWER_UP:
>> -               if (!IS_ERR(mmc->supply.vmmc))
>> -                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>> -
>> -               /*
>> -                * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
>> -                * and instead uses MCI_PWR_ON so apply whatever value is
>> -                * configured in the variant data.
>> -                */
>> -               pwr |= variant->pwrreg_powerup;
>> -
>> -               break;
>> -       case MMC_POWER_ON:
>> -               if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
>> -                       ret = regulator_enable(mmc->supply.vqmmc);
>> -                       if (ret < 0)
>> -                               dev_err(mmc_dev(mmc),
>> -                                       "failed to enable vqmmc regulator\n");
>> -                       else
>> -                               host->vqmmc_enabled = true;
>> -               }
>> -
>> -               pwr |= MCI_PWR_ON;
>> -               break;
>> -       }
> 
> This above looks like pure re-factoring. Please make the above change
> a separate patch.

OK

> 
>>
>>          if (variant->signal_direction && ios->power_mode != MMC_POWER_OFF) {
>>                  /*
>> @@ -1126,8 +1136,16 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>>          spin_lock_irqsave(&host->lock, flags);
>>
>> -       mmci_set_clkreg(host, ios->clock);
>> -       mmci_write_pwrreg(host, pwr);
>> +       if (variant->set_clkreg)
>> +               variant->set_clkreg(host, ios->clock);
>> +       else
>> +               mmci_set_clkreg(host, ios->clock);
> 
> This means a change in behavior, which I don't think is what you want.
> 
> 1) The spin lock will be held while doing the regulator operations.

Yes, you are right, the behavior around spin lock has been modified for
legacy. I will try to find a solution to avoid behavior change for
legacy.

For power, sdmmc variant have specific need to reset the sdmmc variant
and set power register before to disable the vqmmc regulator.
that's why I move the regulator operation in mmci_set_pwrreg.

> 2) The clock register will be written to before the regulator
> operations have been done. Not sure if that works fine!?

you are right, it's probably better if the clock is done after power.
do you agree if I change the order?

> 
> An overall comment, I think we should create a mmci_host_ops structure
> and put the needed callbacks in there (kept to a minimum of course),
> rather than putting them as a part of the variant struct. More
> importantly, also the legacy mmci variants should get a mmci_host_ops
> structure assigned during probe.
> 
> The point is, I think it makes the code above (and future wise) more
> flexible. It should also allow us to better share functions between
> the variants. In principle, I expect that we end up with a bunch of
> "library" mmci functions that can be invoked from variant's
> mmci_host_ops (if not assigned directly).

After "Linaro connect" we have exchanged some emails (subject: "STM32MP1 
SDMMC driver review") and the start point was
"Goal is not to redesign mmci.c like sdhci.c."
This it's why I'm surprise by "library" and "mmci_host_ops"
and comment of patch 01.

So, it's not clear for me on where we wish to go.
Could you clarify the way, if it's with a mmci_ops like sdhci_ops?

> 
>> +
>> +       if (variant->set_pwrreg)
>> +               variant->set_pwrreg(host, ios->power_mode, pwr);
>> +       else
>> +               mmci_set_pwrreg(host, ios->power_mode, pwr);
>> +
>>          mmci_reg_delay(host);
>>
>>          spin_unlock_irqrestore(&host->lock, flags);
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 2ba9640..7265ca6 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -231,6 +231,7 @@
>>
>>   struct clk;
>>   struct dma_chan;
>> +struct mmci_host;
>>
>>   /**
>>    * struct variant_data - MMCI variant-specific quirks
>> @@ -273,6 +274,8 @@ struct dma_chan;
>>    *            register.
>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>>    * @mmci_dma: Pointer to platform-specific DMA callbacks.
>> + * @set_clk_ios: if clock procedure of variant is specific
>> + * @set_pwr_ios: if power procedure of variant is specific
>>    */
>>   struct variant_data {
>>          unsigned int            clkreg;
>> @@ -307,6 +310,9 @@ struct variant_data {
>>          u32                     start_err;
>>          u32                     opendrain;
>>          struct mmci_dma_ops     *mmci_dma;
>> +       void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
>> +       void (*set_pwrreg)(struct mmci_host *host, unsigned char power_mode,
>> +                          unsigned int pwr);
>>   };
>>
>>   struct mmci_host {
>> @@ -328,6 +334,7 @@ struct mmci_host {
>>          u32                     pwr_reg;
>>          u32                     pwr_reg_add;
>>          u32                     clk_reg;
>> +       u32                     clk_reg_add;
> 
> What's this? Some leftover I guess?
> 
>>          u32                     datactrl_reg;
>>          u32                     busy_status;
>>          u32                     mask1_reg;
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
