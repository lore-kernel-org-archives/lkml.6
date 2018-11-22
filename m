Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7381CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E7B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E7B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394043AbeKVUyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:54:11 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40622 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390595AbeKVUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:54:11 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAMAEWBY000717;
        Thu, 22 Nov 2018 11:15:01 +0100
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nw2uaeytk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 22 Nov 2018 11:15:01 +0100
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 48BD351;
        Thu, 22 Nov 2018 10:14:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5FC4088B;
        Thu, 22 Nov 2018 10:14:55 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 22 Nov
 2018 11:14:53 +0100
Subject: Re: [PATCH V2 2/2] mmc: mmci: add variant property to send stop cmd
 if a command fail
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
 <1541583041-17461-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpZyYJbDDjYaFPfGEfKme6QedxcD715M2v7kAf7tpUf5A@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <76b63f11-10ef-d49a-0038-13377ef8b772@st.com>
Date:   Thu, 22 Nov 2018 11:14:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpZyYJbDDjYaFPfGEfKme6QedxcD715M2v7kAf7tpUf5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-22_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

due to some ST internal works, I will busy the next days.
But I will sent the change as soon as possible.


On 11/21/18 6:56 PM, Ulf Hansson wrote:
> On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> The mmc framework follows the requirement of SD_Specification:
>> the STOP_TRANSMISSION is sent on multiple write/read commands
>> and the stop command (alone), not needed on other ADTC commands.
>>
>> But, if an error happens on command or data transmission, some
>> variants require a stop command "STOP_TRANSMISION" to clear the DPSM
>> "Data Path State Machine". If it's not done the next data
>> command freezes hardware block.
>> Needed to support the STM32 sdmmc variant.
> 
> May I suggest some re-wording of this changelog, as to make it more
> clear of why this is needed. Something along the lines of:
> 
> "The current approach with sending a CMD12 (STOP_TRANSMISSION) to
> complete a data transfer request, either because of using the open
> ended transmission type or because of receiving an error during a data
> transfer, isn't sufficient for the STM32 sdmmc variant.
> 
> More precisely, for STM32 sdmmc the DPSM ("Data Path State Machine" )
> needs to be cleared by sending a CMD12, also for the so called ADTC
> commands. For this reason, add a new mmci variant property and let the
> driver send a CMD12 to complete ADTC commands, in case it's set."

I will change, it's more accurate and concise, thanks for re-wording

> 
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 33 +++++++++++++++++++++++++++++++++
>>   drivers/mmc/host/mmci.h |  4 ++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 13fa640..47b865d 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/err.h>
>>   #include <linux/highmem.h>
>>   #include <linux/log2.h>
>> +#include <linux/mmc/mmc.h>
>>   #include <linux/mmc/pm.h>
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/card.h>
>> @@ -57,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
>>   #else
>>   static inline void sdmmc_variant_init(struct mmci_host *host) {}
>>   #endif
>> +static void
>> +mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
>>
>>   static unsigned int fmax = 515633;
>>
>> @@ -274,6 +277,7 @@ static struct variant_data variant_stm32_sdmmc = {
>>          .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>>          .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>>          .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
>> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>>          .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>>          .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>>          .datactrl_first         = true,
>> @@ -573,6 +577,24 @@ void mmci_dma_error(struct mmci_host *host)
>>   static void
>>   mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>>   {
>> +       /*
>> +        * If an error happens on command or data transmission, some variants
>> +        * require a stop command to reinit the DPSM.
>> +        * If it's not done the next data command freeze hardware block.
>> +        */
>> +       if (host->variant->cmdreg_stop) {
>> +               u32 dpsm;
>> +
>> +               dpsm = readl_relaxed(host->base + MMCISTATUS);
>> +               dpsm &= MCI_STM32_DPSMACTIVE;
>> +
>> +               if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
>> +                            (mrq->data && mrq->data->error))) {
>> +                       mmci_start_command(host, &host->stop_abort, 0);
>> +                       return;
>> +               }
> 
> I would rather move this code to a separate function.

OK

  Also, I think
> you need something else (or additional) than polling the MMCISTATUS
> register, as in principle you could end up sending CMD12 several times
> for the same request, which isn't correct.

In mmci_request_end, if the DPSM is still enabled, there was no previous 
"cmd12" sent. So Normally, the regular and special cmd12 can't be sent 
for the same request.

> 
> To me the best solution would probably be to make use of the
> host->data pointer, as it becomes set when DPSM has been enabled.
> However, host->data is also cleared in mmci_stop_data() which is being
> called prior mmci_request_end(). In other words, we need to figure
> under what conditions the new code above should be triggered/called
> and then also change the conditions for when mmci_request_end() shall
> be called.
> 
> In principle look at callers of mmci_request_end() and
> mmci_stop_data() and update those paths.
> 
>> +       }
>> +
>>          writel(0, host->base + MMCICOMMAND);
>>
>>          BUG_ON(host->data);
>> @@ -1100,6 +1122,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>                  mmci_reg_delay(host);
>>          }
>>
>> +       if (host->variant->cmdreg_stop &&
>> +           cmd->opcode == MMC_STOP_TRANSMISSION)
>> +               c |= host->variant->cmdreg_stop;
>> +
> 
> Hmm.
> 
> It looks like the above changes, together with the introduction of the
> variant property, belongs in a separate patch, preceding $subject
> patch in the series.
> 
> The reason is, that to me, it makes sense to add the special treatment
> of the ADTC commands in a separate patch. Can you please split it up
> and then of course update the change log accordingly!?

Ok, I will split this part in separate patch.

> 
>>          c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>>          if (cmd->flags & MMC_RSP_PRESENT) {
>>                  if (cmd->flags & MMC_RSP_136)
>> @@ -1950,6 +1976,13 @@ static int mmci_probe(struct amba_device *dev,
>>                  mmc->max_busy_timeout = 0;
>>          }
>>
>> +       /* prepare the stop command, used to abort and reinitialized the DPSM */
>> +       if (variant->cmdreg_stop) {
>> +               host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
>> +               host->stop_abort.arg = 0;
>> +               host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
>> +       }
>> +
>>          mmc->ops = &mmci_ops;
>>
>>          /* We support these PM capabilities. */
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 550dd39..35372cd 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -161,6 +161,7 @@
>>   #define MCI_ST_CEATAEND                (1 << 23)
>>   #define MCI_ST_CARDBUSY                (1 << 24)
>>   /* Extended status bits for the STM32 variants */
>> +#define MCI_STM32_DPSMACTIVE   BIT(12)
>>   #define MCI_STM32_BUSYD0       BIT(20)
>>
>>   #define MMCICLEAR              0x038
>> @@ -264,6 +265,7 @@ struct mmci_host;
>>    * @cmdreg_lrsp_crc: enable value for long response with crc
>>    * @cmdreg_srsp_crc: enable value for short response with crc
>>    * @cmdreg_srsp: enable value for short response without crc
>> + * @cmdreg_stop: enable value for stop and abort transmission
>>    * @datalength_bits: number of bits in the MMCIDATALENGTH register
>>    * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>>    *           is asserted (likewise for RX)
>> @@ -316,6 +318,7 @@ struct variant_data {
>>          unsigned int            cmdreg_lrsp_crc;
>>          unsigned int            cmdreg_srsp_crc;
>>          unsigned int            cmdreg_srsp;
>> +       unsigned int            cmdreg_stop;
>>          unsigned int            datalength_bits;
>>          unsigned int            fifosize;
>>          unsigned int            fifohalfsize;
>> @@ -375,6 +378,7 @@ struct mmci_host {
>>          void __iomem            *base;
>>          struct mmc_request      *mrq;
>>          struct mmc_command      *cmd;
>> +       struct mmc_command      stop_abort;
>>          struct mmc_data         *data;
>>          struct mmc_host         *mmc;
>>          struct clk              *clk;
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
