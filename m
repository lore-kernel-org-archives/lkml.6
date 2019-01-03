Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F5920815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfACKfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:35:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55090 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729765AbfACKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:35:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03AVSJ4012790;
        Thu, 3 Jan 2019 11:35:38 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pp0pm2m19-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Jan 2019 11:35:38 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1E54C38;
        Thu,  3 Jan 2019 10:35:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B92F74EB9;
        Thu,  3 Jan 2019 10:35:36 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Jan
 2019 11:35:35 +0100
Subject: Re: [PATCH V3 1/2] mmc: mmci: add variant property to set command
 stop bit
From:   Ludovic BARRE <ludovic.barre@st.com>
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
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
 <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
 <35f22c1a-888d-5abd-7ffe-ecf47a74b69a@st.com>
Message-ID: <9e22fd3d-f029-2a2a-18d1-af1987c94e4e@st.com>
Date:   Thu, 3 Jan 2019 11:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <35f22c1a-888d-5abd-7ffe-ecf47a74b69a@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

happy new years.

Just a gentleman ping about patch2 of this series
"mmc: mmci: send stop command to clear the dpsm."

Regards
Ludo

On 12/11/18 10:53 AM, Ludovic BARRE wrote:
> 
> 
> On 12/11/18 10:47 AM, Ulf Hansson wrote:
>> On Thu, 6 Dec 2018 at 16:13, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> On cmd12 (STOP_TRANSMISSION), STM32 sdmmc variant needs to set
>>> cmdstop bit in command register. The CPSM ("Command Path State Machine")
>>> treats the command as a Stop Transmission command and signals
>>> abort to the DPSM ("Data Path State Machine").
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>
>> Applied for next, thanks!
> 
> thanks
> 
>>
>> Withholding patch2 for a while, as I need some more time to review it.
> 
> No problem,
> 
> Regards
> Ludo
> 
>>
>> Kind regards
>> Uffe
>>
>>> ---
>>>   drivers/mmc/host/mmci.c | 6 ++++++
>>>   drivers/mmc/host/mmci.h | 2 ++
>>>   2 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index 13fa640..e352f5a 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -21,6 +21,7 @@
>>>   #include <linux/err.h>
>>>   #include <linux/highmem.h>
>>>   #include <linux/log2.h>
>>> +#include <linux/mmc/mmc.h>
>>>   #include <linux/mmc/pm.h>
>>>   #include <linux/mmc/host.h>
>>>   #include <linux/mmc/card.h>
>>> @@ -274,6 +275,7 @@ static struct variant_data variant_stm32_sdmmc = {
>>>          .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>>>          .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>>>          .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
>>> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>>>          .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>>>          .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>>>          .datactrl_first         = true,
>>> @@ -1100,6 +1102,10 @@ mmci_start_command(struct mmci_host *host, 
>>> struct mmc_command *cmd, u32 c)
>>>                  mmci_reg_delay(host);
>>>          }
>>>
>>> +       if (host->variant->cmdreg_stop &&
>>> +           cmd->opcode == MMC_STOP_TRANSMISSION)
>>> +               c |= host->variant->cmdreg_stop;
>>> +
>>>          c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>>>          if (cmd->flags & MMC_RSP_PRESENT) {
>>>                  if (cmd->flags & MMC_RSP_136)
>>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>>> index 550dd39..2422909 100644
>>> --- a/drivers/mmc/host/mmci.h
>>> +++ b/drivers/mmc/host/mmci.h
>>> @@ -264,6 +264,7 @@ struct mmci_host;
>>>    * @cmdreg_lrsp_crc: enable value for long response with crc
>>>    * @cmdreg_srsp_crc: enable value for short response with crc
>>>    * @cmdreg_srsp: enable value for short response without crc
>>> + * @cmdreg_stop: enable value for stop and abort transmission
>>>    * @datalength_bits: number of bits in the MMCIDATALENGTH register
>>>    * @fifosize: number of bytes that can be written when 
>>> MMCI_TXFIFOEMPTY
>>>    *           is asserted (likewise for RX)
>>> @@ -316,6 +317,7 @@ struct variant_data {
>>>          unsigned int            cmdreg_lrsp_crc;
>>>          unsigned int            cmdreg_srsp_crc;
>>>          unsigned int            cmdreg_srsp;
>>> +       unsigned int            cmdreg_stop;
>>>          unsigned int            datalength_bits;
>>>          unsigned int            fifosize;
>>>          unsigned int            fifohalfsize;
>>> -- 
>>> 2.7.4
>>>
